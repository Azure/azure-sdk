import {
  Tier1Languages,
  PackageList,
  TrackSpecificsDefault,
  Plane,
} from "./types";
import { Logger } from './logger';
import _serviceNameMap from "../data-and-rules/serviceNameMap.json";
import _servicesToHide from "../data-and-rules/servicesToHide.json";
import _apiSpecMap from '../data-and-rules/apiSpecMap.json';
import path from "path";
import fs from 'fs';
const log = Logger.getInstance();
//const specsDirPath = path.join(__dirname, '../../../../../azure-rest-api-specs/specification');
const serviceNameMap: any = _serviceNameMap;
const servicesToHide: any = _servicesToHide;
const apiSpecMap: any = _apiSpecMap;


/**
 * Adds empty package entries to the package list based on if the package exists for another language.
 * @param packages A map of packages after being formatted
 * @returns a map of packages with empty entries added
 */
export default async function addEmptyDataPoints(packages: PackageList, apiSpecsDirPath: string): Promise<PackageList> {
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
    // Don't create missing empty packages if package is a RLC JS package. ex: @azure-rest/...
    if (packages[key].Track2.Package.startsWith('@azure-rest/')) continue;
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
  packages = { ...packages, ...(await getServicesFromSpecRepo(packages, apiSpecsDirPath)) };

  return packages;
}

/**
 * Determines if there are azure apis without SDKs of the Tier 1 Languages and creates a Package List of empty packages for said apis.
 * The function scans through a local copy of the Azure/azure-rest-api-specs repo to determine if SDKs are missing.
 * @param packages a Package List of already existing packages, used to stop the function from creating duplicate packages
 * @returns a Package List of empty packages for apis that exist but don't already have a package.
 */
// async function getServicesFromSpecRepoOLD(packages: PackageList, apiSpecsDirPath: string): Promise<PackageList> {
//   const additionalPackages: PackageList = {}; // empty pkgs collected from specs repo to add
//   // get list of service dirs from specs dir
//   const serviceSpecDirs = fs.readdirSync(apiSpecsDirPath);
//   for (let serviceSpecDir of serviceSpecDirs) {
//     // determine service name and SDK name
//     let serviceName: string = "";
//     let sdkName: string = "";
//     if (typeof serviceNameMap[serviceSpecDir] === 'string' && serviceNameMap[serviceSpecDir].split("|").length > 1) {
//       [serviceName, sdkName] = serviceNameMap[serviceSpecDir].split("|");
//     } else {
//       serviceName = serviceNameMap[serviceSpecDir] === undefined ? serviceSpecDir : serviceNameMap[serviceSpecDir];
//       sdkName = serviceName;
//     }
//     // test if service spec dir is a dir, if not move on.
//     if (!fs.lstatSync(path.join(apiSpecsDirPath, serviceSpecDir)).isDirectory()) continue;
//     // list of plane dirs in service spec dir, should be either data-plane and/or resource-manager
//     let planeSpecDirs: string[] = fs.readdirSync(path.join(apiSpecsDirPath, serviceSpecDir));
//     // loop through plane dirs in the service spec dir
//     for (let planeSpecDir of planeSpecDirs) {
//       // determine plane and SDK name
//       let plane: Plane = "UNABLE TO BE DETERMINED";
//       if (planeSpecDir === 'data-plane') { plane = "data"; }
//       else if (planeSpecDir === 'resource-manager') { plane = 'mgmt'; sdkName = `Resource Management - ${sdkName}`; }
//       // skip service api spec if it's in the list of services to hide
//       // Ignore Services Plane pairs that are specified in servicesToHide.json
//       if (servicesToHide[serviceName] !== undefined) {
//         if (Array.isArray(servicesToHide[serviceName]) && servicesToHide[serviceName].includes(plane)) {
//           continue;
//         }
//       }
//       // Ignore Service|SDK Plane pairs that are specified in servicesToHide.json
//       if (servicesToHide[`${serviceName}|${sdkName}`] !== undefined) {
//         if (Array.isArray(servicesToHide[`${serviceName}|${sdkName}`]) && servicesToHide[`${serviceName}|${sdkName}`].includes(plane)) {
//           continue;
//         }
//       }
//       // check if stable spec exists
//       const planeSpecDirContents = fs.readdirSync(path.join(apiSpecsDirPath, serviceSpecDir, planeSpecDir));
//       const filteredPlaneSpecDirContents = planeSpecDirContents.filter(s => s.startsWith('Microsoft.'));
//       if (filteredPlaneSpecDirContents.length <= 0) { log.warn(`${serviceSpecDir}/${planeSpecDir} has no dir that starts with "Microsoft."`); }
//       else {
//         const microsoftDir = filteredPlaneSpecDirContents[0];
//         const microsoftDirContents = fs.readdirSync(path.join(apiSpecsDirPath, serviceSpecDir, planeSpecDir, microsoftDir));
//         const filteredMicrosoftDirContents = microsoftDirContents.filter(s => s === "stable");
//         if (filteredMicrosoftDirContents.length <= 0) { log.info(`No stable API Spec found for ${serviceSpecDir}/${planeSpecDir}`); }
//         else {
//           // stable spec does exist
//           // check if package exists for each language, if not add empty entry
//           for (let language of Tier1Languages) {
//             // create pkg key
//             const key = (serviceName + sdkName + plane + language).toLowerCase();
//             // If package doesn't exist in list already, add it.
//             if (packages[key] === undefined && additionalPackages[key] === undefined) {
//               additionalPackages[key] = {
//                 Service: serviceName,
//                 ServiceId: 0,
//                 SDK: sdkName,
//                 Plane: plane,
//                 Language: language,
//                 Track1: TrackSpecificsDefault,
//                 Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from API in specs repo: ${serviceSpecDir}/${}` },
//                 PercentComplete: undefined,
//                 LatestRelease: ''
//               };
//               log.info(`Adding Empty Package from Specs Repo.\n\tEmpty Package: ${JSON.stringify(additionalPackages[key])}\n\tREST Spec Dir: ${path.join(apiSpecsDirPath, serviceSpecDir, planeSpecDir)}`);
//             }
//           }
//         }
//       }
//     }

//   }
//   return additionalPackages;
// }

/** Determines if there are azure apis without SDKs of the Tier 1 Languages and creates a Package List of empty packages for said apis.
 * The function scans through a local copy of the Azure/azure-rest-api-specs repo to determine if SDKs are missing.
 * @param packages a Package List of already existing packages, used to stop the function from creating duplicate packages
 * @returns a Package List of empty packages for apis that exist but don't already have a package.
 */
async function getServicesFromSpecRepo(packages: PackageList, apiSpecsDirPath: string): Promise<PackageList> {
  // empty PackageList to be returned
  const additionalPackages: PackageList = {};
  // get list of service dirs from specs dir
  const serviceDirs = fs.readdirSync(apiSpecsDirPath);
  // loop through service dirs
  for (let serviceDir of serviceDirs) {
    let serviceName: string = "";
    // if the the serviceDir maps to a key in ../data-and-rules/apiSpecMap.json, use the service-display-name property from the value object as the serviceName
    if (typeof apiSpecMap[serviceDir] === 'object' && apiSpecMap[serviceDir].hasOwnProperty('service-display-name')) {
      serviceName = apiSpecMap[serviceDir]['service-display-name'];
    } else {
      serviceName = serviceDir;
    }
    // if specDir is a dir, read it's contents and loop through them
    if (fs.lstatSync(path.join(apiSpecsDirPath, serviceDir)).isDirectory()) {
      const apiSpecDirs = fs.readdirSync(path.join(apiSpecsDirPath, serviceDir));
      for (let apiSpecDir of apiSpecDirs) {
        // determine SDK name
        let sdkName: string = "Unable to determine Service Name";
        // if the serviceDir maps to a key in ../data-and-rules/apiSpecMap.json, and it's value object has an api-display-name property, with a property that matches the apiSpecDir, use the value of that property as the sdkName
        if (typeof apiSpecMap[serviceDir] === 'object' && apiSpecMap[serviceDir].hasOwnProperty('api-display-names') && typeof apiSpecMap[serviceDir]['api-display-names'] === 'object' && apiSpecMap[serviceDir]['api-display-names'].hasOwnProperty(apiSpecDir)) {
          sdkName = apiSpecMap[serviceDir]['api-display-names'][apiSpecDir];
        } else {
          // if apiSpecDir is data-plane or resource-manager, sdkName should be the same as serviceName, else it should be the same as apiSpecDir
          sdkName = apiSpecDir === 'data-plane' || apiSpecDir === 'resource-manager' || apiSpecDir === 'resource-management' ? serviceName : apiSpecDir;
        }
        // Determine the plane 
        let plane: Plane = "UNABLE TO BE DETERMINED";
        if (apiSpecDir === 'data-plane') { plane = "data"; }
        else if (apiSpecDir === 'resource-manager' || apiSpecDir === 'resource-management' || apiSpecDir === 'control-plane') { plane = 'mgmt'; sdkName = `Resource Management - ${sdkName}`; }
        else {
          // if apiSpecDir ends in .management regardless of case, print out attention log 
          if (apiSpecDir.toLowerCase().endsWith('.management')) {
            plane = 'mgmt';
            sdkName = `Resource Management - ${sdkName}`;
          } else {
            plane = 'data';
          }
        }

        // skip service api spec if it's in the list of services to hide
        if ((servicesToHide[serviceName] !== undefined && Array.isArray(servicesToHide[serviceName]) && servicesToHide[serviceName].includes(plane)) || (servicesToHide[`${serviceName}|${sdkName}`] !== undefined && Array.isArray(servicesToHide[`${serviceName}|${sdkName}`]) && servicesToHide[`${serviceName}|${sdkName}`].includes(plane))) {
          if ((Array.isArray(servicesToHide[serviceName]) && servicesToHide[serviceName].includes(plane)) || (Array.isArray(servicesToHide[`${serviceName}|${sdkName}`]) && servicesToHide[`${serviceName}|${sdkName}`].includes(plane))) {
            continue;
          }
        }

        // Check if stable spec exists 
        const apiSpecDirContents = fs.readdirSync(path.join(apiSpecsDirPath, serviceDir, apiSpecDir));
        if (apiSpecDir === 'data-plane' || apiSpecDir === 'resource-manager' || apiSpecDir === 'resource-management') {
          const filteredApiSpecDirContents = apiSpecDirContents.filter(s => s.startsWith('Microsoft.'));
          if (filteredApiSpecDirContents.length <= 0) { log.warn(`${serviceDir}/${apiSpecDir} has no dir that starts with "Microsoft."`); }
          else {
            const microsoftDir = filteredApiSpecDirContents[0];
            const microsoftDirContents = fs.readdirSync(path.join(apiSpecsDirPath, serviceDir, apiSpecDir, microsoftDir));
            const filteredMicrosoftDirContents = microsoftDirContents.filter(s => s === "stable");
            // If no stable api was found skip
            if (filteredMicrosoftDirContents.length <= 0) { log.info(`No stable API Spec found for ${serviceDir}/${apiSpecDir}`); continue; }

          }
        } else {
          //TODO - check if TypeSpec api has stable version, if not skip
        }

        // loop through Tier 1 languages and create empty package if it doesn't exist
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
              Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from API in specs repo: ${serviceDir}/${apiSpecDir}` },
              PercentComplete: undefined,
              LatestRelease: ''
            };
            log.info(`Adding Empty Package from Specs Repo.\n\tEmpty Package: ${JSON.stringify(additionalPackages[key])}\n\tREST Spec Dir: ${serviceDir}/${apiSpecDir}`);
          }
        }

      }
    }
  }
  return additionalPackages;
}