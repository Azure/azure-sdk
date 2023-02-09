import {
  Tier1Languages,
  PackageList,
  TrackSpecificsDefault,
  Plane,
} from "./types";
import { Logger } from './logger';
import _serviceNameMap from "../data-and-rules/serviceNameMap.json";
import _servicesToHide from "../data-and-rules/servicesToHide.json";
import path from "path";
import fs from 'fs';
const log = Logger.getInstance();
const specsDirPath = path.join(__dirname, '../../../../../azure-rest-api-specs/specification');
const serviceNameMap: any = _serviceNameMap;
const servicesToHide: any = _servicesToHide;


/**
 * Adds empty package entries to the package list based on if the package exists for another language. 
 * @param packages A map of packages after being formatted 
 * @returns a map of packages with empty entries added
 */
export default async function addEmptyDataPoints(packages: PackageList): Promise<PackageList> {
  // Add missing sdks when sdks for other languages are found
  const additionalPackages: PackageList = {};
  for (let key in packages) {
    // Skip if packages doesn't have a track 2 version
    if (JSON.stringify(packages[key].Track2) === JSON.stringify(TrackSpecificsDefault)) {
      continue;
    }
    // Skip is package is a core package
    if (packages[key].Service === "Core") continue;
    // Don't create missing empty packages if package is from a non-tier 1 language. 
    if (!Tier1Languages.includes(packages[key].Language) || packages[key].Language === "Go") continue;
    // Don't create missing empty packages if package is still in beta
    if (packages[key].Track2.ColorCode === 3) continue;
    // Don't create missing empty packages if track 2 object is just for a package reference 
    if (packages[key].Track2.ColorCode === 4) continue;
    // Loop through languages adding empty packages
    for (let language of Tier1Languages) {
      const { Service, SDK, Plane, ServiceId } = packages[key];
      const testKey = ((Service || " - ") +
        (SDK || " -- ") +
        (Plane || " --- ") +
        (language || " ---- ")).toLowerCase();
      // Add empty package if ones doesn't already exist for selected language
      //log.atn(`Result of Key: ${testKey} - check on packages: ${JSON.stringify(packages[testKey])}`);
      if (packages[testKey] === undefined && additionalPackages[testKey] === undefined) {
        additionalPackages[testKey] = {
          Service,
          ServiceId,
          SDK,
          Plane,
          Language: language,
          Track1: TrackSpecificsDefault,
          Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from existing package: ${packages[key].Track2.Package}` },
          PercentComplete: undefined,
          LatestRelease: ""
        };
        log.info(`Adding Empty Package from Existing Library.\n\tEmpty Package: ${JSON.stringify(additionalPackages[testKey])}\n\tExisting Package: ${JSON.stringify(packages[key])}`);
      }
    }
  }
  // add new empty packages to package list and return
  packages = { ...packages, ...additionalPackages };
  // add empty packages to package list if service API exists 
  packages = { ...packages, ...(await getServicesFromSpecRepo(packages)) };

  return packages;
}

/**
 * Determines if there are azure apis without SDKs of the Tier 1 Languages and creates a Package List of empty packages for said apis. 
 * The function scans through a local copy of the Azure/azure-rest-api-specs repo to determine if SDKs are missing. 
 * @param packages a Package List of already existing packages, used to stop the function from creating duplicate packages
 * @returns a Package List of empty packages for apis that exist but don't already have a package. 
 */
async function getServicesFromSpecRepo(packages: PackageList): Promise<PackageList> {
  const additionalPackages: PackageList = {}; // empty pkgs collected from specs repo to add
  // get list of service dirs from specs dir
  const serviceSpecDirs = fs.readdirSync(specsDirPath);
  for (let serviceSpecDir of serviceSpecDirs) {
    // determine service name
    const serviceName = serviceNameMap[serviceSpecDir] === undefined ? serviceSpecDir : serviceNameMap[serviceSpecDir];
    // skip service api spec if it's in the list of services to hide
    if (servicesToHide[serviceName]) continue;
    // test if service spec dir is a dir, if not move on. 
    if (!fs.lstatSync(path.join(specsDirPath, serviceSpecDir)).isDirectory()) continue;
    // list of plane dirs in service spec dir, should be either data-plane and/or resource-manager
    let planeSpecDirs: string[] = fs.readdirSync(path.join(specsDirPath, serviceSpecDir));
    // loop through plane dirs in the service spec dir
    for (let planeSpecDir of planeSpecDirs) {
      // determine plane and SDK name
      let plane: Plane = "UNABLE TO BE DETERMINED";
      let sdkName: string = serviceName;
      if (planeSpecDir === 'data-plane') { plane = "data"; sdkName = serviceName; }
      else if (planeSpecDir === 'resource-manager') { plane = 'mgmt'; sdkName = `Resource Management - ${serviceName}`; }
      // check if stable spec exists
      const planeSpecDirContents = fs.readdirSync(path.join(specsDirPath, serviceSpecDir, planeSpecDir));
      const filteredPlaneSpecDirContents = planeSpecDirContents.filter(s => s.startsWith('Microsoft.'));
      if (filteredPlaneSpecDirContents.length <= 0) { log.warn(`${serviceSpecDir}/${planeSpecDir} has no dir that starts with "Microsoft."`); }
      else {
        const microsoftDir = filteredPlaneSpecDirContents[0];
        const microsoftDirContents = fs.readdirSync(path.join(specsDirPath, serviceSpecDir, planeSpecDir, microsoftDir));
        const filteredMicrosoftDirContents = microsoftDirContents.filter(s => s === "stable");
        if (filteredMicrosoftDirContents.length <= 0) { log.info(`No stable API Spec found for ${serviceSpecDir}/${planeSpecDir}`); }
        else {
          // stable spec does exist
          const serviceName = serviceNameMap[serviceSpecDir] === undefined ? serviceSpecDir : serviceNameMap[serviceSpecDir];
          // check if package exists for each language, if not add empty entry 
          for (let language of Tier1Languages) {
            // create pkg key
            const key = (serviceName + sdkName + plane + language).toLowerCase();
            // If package doesn't exist in list already, add it. 
            if (packages[key] === undefined && additionalPackages[key] === undefined) {
              additionalPackages[key] = {
                Service: serviceName,
                ServiceId: 0,
                SDK: sdkName,
                Plane: plane,
                Language: language,
                Track1: TrackSpecificsDefault,
                Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from API in specs repo: ${serviceSpecDir}` },
                PercentComplete: undefined,
                LatestRelease: ''
              };
              log.info(`Adding Empty Package from Specs Repo.\n\tEmpty Package: ${JSON.stringify(additionalPackages[key])}\n\tREST Spec Dir: ${specsDirPath}`);
            }
          }
        }
      }
    }

  }
  return additionalPackages;
}