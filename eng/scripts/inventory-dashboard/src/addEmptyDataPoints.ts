import {
  Tier1Languages,
  PackageList,
  TrackSpecificsDefault,
  Plane,
  Package,
  Language,
} from "./types";
import { Logger } from './logger';
import { Octokit } from "@octokit/rest";
import * as dotenv from 'dotenv';
import fetch from "node-fetch";
import _serviceNameMap from "../data-and-rules/serviceNameMap.json";
const log = Logger.getInstance();
// create octokit instances 
const octokit = new Octokit({
  auth: process.env.GITHUB_AUTH_TOKEN
});
const serviceNameMap: any = _serviceNameMap;
dotenv.config();

/**
 * Adds empty package entries to the package list based on if the package exists for another language. 
 * @param packages A map of packages after being formatted 
 * @returns a map of packages with empty entries added
 */
export default async function addEmptyDataPoints(packages: PackageList): Promise<PackageList> {
  // REMOVED AS BEHAVIOR WAS NO LONGER DESIRED. LEAVING CODE INCASE WE WANT TO TURN IT BACK ON
  // Add missing data plane sdks when a mgmt plane sdk is found
  // const additionalPackages: PackageList = {};
  // for (let key in packages) {
  //   if (packages[key].Plane === 'mgmt') {
  //     const dataKey = packages[key].Service + packages[key].SDK?.replace('Resource Management - ', '') + 'data' + packages[key].Language;
  //     if (packages[dataKey] === undefined) {
  //       additionalPackages[dataKey] = {
  //         Service: packages[key].Service,
  //         SDK: packages[key].SDK?.replace('Resource Management - ', ''),
  //         Plane: "data",
  //         Language: packages[key].Language,
  //         Track1: TrackSpecificsDefault,
  //         Track2: TrackSpecificsDefault,
  //         PercentComplete: undefined
  //       };
  //     }
  //   }
  // }
  // packages = { ...packages, ...additionalPackages };

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
 * The method queries the Azure/azure-rest-api-specs repo for the list of Azure APIs
 * @param packages a Package List of already existing packages, used to stop the function from creating duplicate packages
 * @returns a Package List of empty packages for apis that exist but don't already have a package. 
 */
async function getServicesFromSpecRepo(packages: PackageList): Promise<PackageList> {
  // black package list to be added to and returned 
  let additionalPackages: PackageList = {};
  // get services from specs repo
  const { data: serviceList } = await octokit.rest.repos.getContent({
    owner: "Azure",
    repo: "azure-rest-api-specs",
    path: "specification"
  });
  // Check service list is array, if not log error and return empty package list
  if (!Array.isArray(serviceList)) {
    log.err(`Specs repo did not return an array of services. Specs repo returned: ${JSON.stringify(serviceList)}`);
    return additionalPackages;
  }

  // Go through list of services and check if they have a data-plane or resource-management dir
  for (let service of serviceList) {
    // check if data or mgmt plane exists and add packages 
    let foundData = (await (await fetch("https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/" + service.path + "/data-plane/readme.md")).text()) !== "404: Not Found";
    let foundMgmt = (await (await fetch("https://raw.githubusercontent.com/Azure/azure-rest-api-specs/main/" + service.path + "/resource-manager/readme.md")).text()) !== "404: Not Found";
    // check if service name has a replacement in serviceNameMap.json, if so, use replacement as service name
    let serviceName = serviceNameMap[service.name] === undefined ? service.name : serviceNameMap[service.name];
    if (foundData) {
      for (let language of Tier1Languages) {
        // create keys for data plane sdks
        let dataKey = (serviceName + serviceName + "data" + language).toLowerCase();
        // add package if it doesn't exist already
        if (packages[dataKey] === undefined && additionalPackages[dataKey] === undefined) {
          additionalPackages[dataKey] = {
            Service: serviceName,
            ServiceId: 0,
            SDK: serviceName,
            Plane: 'data',
            Language: language,
            Track1: TrackSpecificsDefault,
            Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from API in specs repo: ${service.name}` },
            PercentComplete: undefined,
            LatestRelease: ''
          };
          log.info(`Adding Empty Package from Specs Repo.\n\tEmpty Package: ${JSON.stringify(additionalPackages[dataKey])}\n\tREST Spec Dir: ${service.name}`);
        }
      }
    }
    if (foundMgmt) {
      for (let language of Tier1Languages) {
        // create keys for data plane sdks
        let mgmtKey = (serviceName + "Resource Management - " + serviceName + "mgmt" + language).toLowerCase();
        // add package if it doesn't exist already
        if (packages[mgmtKey] === undefined && additionalPackages[mgmtKey] === undefined) {
          additionalPackages[mgmtKey] = {
            Service: serviceName,
            ServiceId: 0,
            SDK: "Resource Management - " + serviceName,
            Plane: 'mgmt',
            Language: language,
            Track1: TrackSpecificsDefault,
            Track2: { ...TrackSpecificsDefault, Package: `Missing: Created from API in specs repo: ${service.name}` },
            PercentComplete: undefined,
            LatestRelease: ''
          };
          log.info(`Adding Empty Package from Specs Repo.\n\tEmpty Package: ${JSON.stringify(additionalPackages[mgmtKey])}\n\tREST Spec Dir: ${service.name}`);
        }
      }
    }
  }
  return additionalPackages;
}
