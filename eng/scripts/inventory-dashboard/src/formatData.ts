import {
  Language,
  PackageList,
  Package,
  Plane,
  StringTrackSpecificsDefault,
  TrackSpecifics,
  TrackSpecificsDefault,
  isPlaneType,
  FormattingPackage,
  FormattingPackageList,
} from "./types";
import { Logger } from "./logger";
import _servicesToHide from "../data-and-rules/servicesToHide.json";
const log = Logger.getInstance();
const servicesToHide: any = _servicesToHide;

/**
 * Takes the data from the CSV files and returns it in the format needed for the dashboard. 
 * @param csvData The data from the CSV files
 * @returns The data from the CSV files formatted for the dashboard as an object where the keys are the concatenation of the Service Name, Display Name, Plane and Language. 
 */
export function formatReleaseCSVData(csvData: any[]): PackageList {
  // Create empty object of packages
  const formattedPackageList: FormattingPackageList = {};
  // loop through data from the CSV creating objects in desired format
  for (let pkg of csvData) {
    // Logic for Ignoring certain packages pre-formatting
    // Ignore SDKs who's Hide value in the CSVs is set to true
    if (
      pkg.Hide &&
      typeof pkg.Hide === "string" &&
      pkg.Hide.toLowerCase() === "true"
    ) {
      log.info(`Ignoring package with Hide property. Package: ${JSON.stringify(pkg)}`);
      continue;
    }
    // Ignore beta packages
    if (pkg.Package && typeof pkg.Package === 'string', pkg.Package.toLowerCase().indexOf("hybrid") !== -1 && pkg.Package.toLowerCase().indexOf('profile') !== -1) {
      log.info(`Ignoring Beta package. Package: ${JSON.stringify(pkg)}`);
      continue;
    }

    // create package object in new format
    let formattedPackage: FormattingPackage = {
      Service: getService(pkg),
      ServiceId: 0,   // TODO: use Service ID Column in the CSV for this field. 
      SDK: getSDK(pkg),
      Plane: getPlane(pkg),
      Language: getLanguage(pkg),
      Track1: getTrackInfo(pkg, 1),
      Track2: getTrackInfo(pkg, 2),
      PercentComplete: undefined,
      LatestRelease: getLatestReleaseTrack(pkg, 2),
      LatestReleaseTrack1: getLatestReleaseTrack(pkg, 1),
      LatestReleaseTrack2: getLatestReleaseTrack(pkg, 2)
    };
    log.info(`Package from CSV: ${JSON.stringify(formattedPackage)}`);

    // Logic for Ignoring certain packages post-formatting
    // Ignore Services Plane pairs that are specified in servicesToHide.json
    if (servicesToHide[formattedPackage.Service] !== undefined) {
      if (Array.isArray(servicesToHide[formattedPackage.Service]) && servicesToHide[formattedPackage.Service].includes(formattedPackage.Plane)) {
        continue;
      }
    }
    // Ignore Service|SDK Plane pairs that are specified in servicesToHide.json
    if (servicesToHide[`${formattedPackage.Service}|${formattedPackage.SDK}`] !== undefined) {
      if (Array.isArray(servicesToHide[`${formattedPackage.Service}|${formattedPackage.SDK}`]) && servicesToHide[`${formattedPackage.Service}|${formattedPackage.SDK}`].includes(formattedPackage.Plane)) {
        continue;
      }
    }

    //Ignore Java Spring SDKs
    if (
      formattedPackage.Service?.toLowerCase().indexOf("spring") !== -1 ||
      formattedPackage.SDK?.toLowerCase().indexOf("spring") !== -1 ||
      formattedPackage.Plane?.toLowerCase().indexOf("spring") !== -1
    ) {
      log.info(`Ignoring Spring Package: ${JSON.stringify(formattedPackage)}`);
      continue;
    }

    // Ignore Go Track 1 mgmt plane sdks for now
    if (formattedPackage.Service === "Unable to determine Service Name" && formattedPackage.Language === "Go" && formattedPackage.SDK.startsWith('services/')) {
      log.info(`Ignoring Go Track 1 mgmt plane Package: ${JSON.stringify(formattedPackage)}`);
      continue;
    }

    // Ignore Core, Internal, and Compatibility Packages 
    if (formattedPackage.Plane === "core" || formattedPackage.Plane === 'tool' || formattedPackage.Service.toLowerCase() === "core" || formattedPackage.Service.toLowerCase() === "other" || formattedPackage.Plane === "compat") {
      log.info(`Ignoring Core, Internal, Tool, or Compatibility Package: ${JSON.stringify(formattedPackage)}`);
      continue;
    }

    // create the key used to index the package in the PackageList
    const packageListKey =
      ((formattedPackage.Service || " - ") +
        (formattedPackage.SDK || " -- ") +
        (formattedPackage.Plane || " --- ") +
        (formattedPackage.Language || " ---- ")).toLowerCase();

    // check if package is already in the list or if it's track counterpart is already in the list
    if (!formattedPackageList[packageListKey]) {
      //Package not in the list yet so add it.
      formattedPackageList[packageListKey] = formattedPackage;
    } else if (formattedPackageList[packageListKey]) {
      const pkgInList = formattedPackageList[packageListKey];
      // package in list missing track 1 but new package has track 1 info
      if (
        JSON.stringify(pkgInList.Track1) === StringTrackSpecificsDefault &&
        JSON.stringify(formattedPackage.Track1) !== StringTrackSpecificsDefault
      ) {
        // rewrite package in package list with newly found track 1 info
        formattedPackageList[packageListKey] = {
          ...pkgInList,
          Track1: formattedPackage.Track1,
          LatestRelease: compareDates(formattedPackage.LatestRelease, pkgInList.LatestRelease)
        };
      }
      // package in list missing track 2 or contains a package reference in track 2 prop, but new package has track 2 info
      else if (
        (JSON.stringify(pkgInList.Track2) === StringTrackSpecificsDefault || pkgInList.Track2.ColorCode === 4) &&
        JSON.stringify(formattedPackage.Track2) !== StringTrackSpecificsDefault
      ) {
        // if package reference in track 2 prop check new package matches the reference
        if (pkgInList.Track2.ColorCode === 4 && (pkgInList.Track2.Package.replaceAll("Replaced by:", "") !== formattedPackage.Track2.Package.replaceAll("Replaced by:", ""))) {
          log.atn(`Mismatch in package "Replaced by".\n\tPackage 1: ${JSON.stringify(pkgInList.Track2.Package.replaceAll("Replaced by:", ""))}\n\tPackage 2: ${formattedPackage.Track2.Package.replaceAll("Replaced by:", "")}`);
        }

        // rewrite package in package list with newly found track 2 info 
        formattedPackageList[packageListKey] = {
          ...pkgInList,
          Track2: formattedPackage.Track2,
          LatestRelease: compareDates(formattedPackage.LatestRelease, pkgInList.LatestRelease)
        };
      }
      // package in list has same track info as new package
      else {
        log.warn(
          `Found identical packages.\n\tPackage1: ${JSON.stringify(
            formattedPackageList[packageListKey]
          )}\n\tPackage2: ${JSON.stringify(formattedPackage)}`
        );
        // Determine latest GA'ed package and use that package. 
        // Figure out the track of the new package so we can only replace that Track prop
        if (pkg.hasOwnProperty("New") && typeof pkg.New === "string") {
          if (pkg.New.toLowerCase() === "true") {
            if (pkgInList.LatestReleaseTrack2 === undefined || formattedPackage.LatestReleaseTrack2 === undefined) log.err("Latest GA = Undefined");
            else {
              if (pkgInList.LatestReleaseTrack2 === "" && formattedPackage.LatestReleaseTrack2 !== "") { // if new pkg has latest release date and old pkg doesn't
                log.info(`Package Replaced with more recent package.\n\tNew Package: ${JSON.stringify(formattedPackage)}\n\tOld Package: ${JSON.stringify(pkgInList)}`);
                formattedPackageList[packageListKey] = { ...pkgInList, Track2: formattedPackage.Track2, LatestRelease: formattedPackage.LatestRelease };
              } else if (pkgInList.LatestReleaseTrack2 !== "" && formattedPackage.LatestReleaseTrack2 !== "") { // if both old and new pkg have latest release day
                if (new Date(formattedPackage.LatestReleaseTrack2) > new Date(pkgInList.LatestReleaseTrack2)) {
                  log.info(`Package Replaced with more recent package.\n\tNew Package: ${JSON.stringify(formattedPackage)}\n\tOld Package: ${JSON.stringify(pkgInList)}`);
                  formattedPackageList[packageListKey] = { ...pkgInList, Track2: formattedPackage.Track2, LatestRelease: formattedPackage.LatestRelease };
                }
              }
            }
          } else if (pkg.New.toLowerCase() === "false") {
            if (pkgInList.LatestReleaseTrack1 === undefined || formattedPackage.LatestReleaseTrack1 === undefined) log.err("Latest GA = Undefined");
            else {
              if (pkgInList.LatestReleaseTrack1 === "" && formattedPackage.LatestReleaseTrack1 !== "") { // if new pkg has latest release date and old pkg doesn't
                log.info(`Package Replaced with more recent package.\n\tNew Package: ${JSON.stringify(formattedPackage)}\n\tOld Package: ${JSON.stringify(pkgInList)}`);
                formattedPackageList[packageListKey] = { ...pkgInList, Track1: formattedPackage.Track1 };
              } else if (pkgInList.LatestReleaseTrack1 !== "" && formattedPackage.LatestReleaseTrack1 !== "") { // if both old and new pkg have latest release day
                if (new Date(formattedPackage.LatestReleaseTrack1) > new Date(pkgInList.LatestReleaseTrack1)) {
                  log.info(`Package Replaced with more recent package.\n\tNew Package: ${JSON.stringify(formattedPackage)}\n\tOld Package: ${JSON.stringify(pkgInList)}`);
                  formattedPackageList[packageListKey] = { ...pkgInList, Track1: formattedPackage.Track1 };
                }
              }
            }
          }
        }

      }
    }
  }
  const packageList: PackageList = {};
  //remove unnecessary package props
  for (let key of Object.keys(formattedPackageList)) {
    packageList[key] = {
      "Service": formattedPackageList[key].Service,
      "ServiceId": formattedPackageList[key].ServiceId,
      "SDK": formattedPackageList[key].SDK,
      "Plane": formattedPackageList[key].Plane,
      "Language": formattedPackageList[key].Language,
      "Track1": formattedPackageList[key].Track1,
      "Track2": formattedPackageList[key].Track2,
      "PercentComplete": formattedPackageList[key].PercentComplete,
      "LatestRelease": formattedPackageList[key].LatestRelease,
    };
  }
  return packageList;
}

/**
 * Determines the relative service for a package from the CSVs
 * @param pkg Package object directly from the CSV 
 * @returns the service name for the package
 */
function getService(pkg: any): string {
  // If the CSV data has a Service Name field, use that to determine the service name
  if (pkg.ServiceName) {
    return pkg.ServiceName;
  } else {
    // if Service Name can't be determined, return default string
    return "Unable to determine Service Name";
  }
}

/**
 * Determines the display name for a package
 * @param pkg Package object directly from the CSV 
 * @returns the display name for the package
 */
function getSDK(pkg: any): string {
  // Handle different naming conventions for management sdks
  if (pkg.DisplayName && pkg.DisplayName.startsWith("Management - ")) {
    pkg.DisplayName = "Resource " + pkg.DisplayName;
  }
  // If package has a DisplayName Property, use as SDK name
  if (pkg.DisplayName) {
    return pkg.DisplayName;
  } else if (pkg.Package) {
    // Use package name if there is no DisplayName
    return pkg.Package;
  } else return " Unable to determine SDK Name";
}

/**
 * Determines the plane of the package 
 * @param pkg Package object directly from the CSV 
 * @returns the plane of the package
 */
function getPlane(pkg: any): Plane {
  // prop and prop type check
  if (pkg.Type && typeof pkg.Type === 'string') {
    // change "client" plane type to "data"
    if (pkg.Type.toLowerCase() === "client") return "data";
    // return other types as is
    else if (
      pkg.Type.toLowerCase() === "mgmt" ||
      pkg.Type.toLowerCase() === "compat" ||
      pkg.Type.toLowerCase() === "spring" ||
      pkg.Type.toLowerCase() === "core" ||
      pkg.Type.toLowerCase() === "tool"
    )
      return pkg.Type.toLowerCase();
    else {
      log.warn(
        `Plane could not be determined. Package: ${JSON.stringify(pkg)}`
      );
    }
  }
  return "UNABLE TO BE DETERMINED";
}

/**
 * Determines the programming Language of a package 
 * @param pkg Package object directly from the CSV 
 * @returns the language of the package
 */
function getLanguage(pkg: any): Language {
  // use the Language property as the language 
  if (pkg.Language) return pkg.Language;
  else {
    log.warn(
      `Language could not be determined for package: ${JSON.stringify(pkg)}`
    );
    return "UNABLE TO DETERMINE LANGUAGE";
  }
}

/**
 * Determines the track specific info for a package. The method is meant to be called twice for both track 1 and 2. 
 * It will determine the proper track of a package on only return the track specifics when called with a matching track parameter. 
 * @param pkg Package object directly from the CSV 
 * @param track 1 or 2, defines the track you are looking for info on. 
 * @returns If the track param matches the found track it will return the track specifics including the Package, RepoLink and a default ColorCode of 10. 
 * If the track param does not match the found track it will return the TrackSpecificsDefault const, which has a empty string for the Package and RepoLink. 
 */
function getTrackInfo(pkg: any, track: 1 | 2): TrackSpecifics {
  // property and property type check 
  if (pkg.hasOwnProperty('New') && typeof pkg.New === "string") {
    // if New prop and track param match, return track specific details
    if (
      (pkg.New.toLowerCase() === "true" && track === 2) ||
      (pkg.New.toLowerCase() === "false" && track === 1)
    ) {
      return {
        Package: getPackage(pkg),
        RepoLink: getRepoLink(pkg),
        ColorCode: isBeta(pkg) ? 3 : 10,
        Deprecated: getDeprecationStatus(pkg)
      };
    } else if (
      pkg.New.toLowerCase() !== "false" &&
      pkg.New.toLowerCase() !== "true"
    ) {
      // Logging for when New Property is set but not to "true" or "false"
      log.warn(
        `Track could not be determined. Package New property not set to true or false. pkg.New.toLowerCase(): ${pkg.New.toLowerCase()} - Package: ${JSON.stringify(
          pkg
        )}`
      );
      if (track === 1) {
        log.warn(`Track could not be determined. Package: ${JSON.stringify(pkg)}`);
        return { ...TrackSpecificsDefault, Package: `UNABLE TO DETERMINE TRACK. PACKAGE: ${getPackage(pkg)}` };
      }
    }
    // If package is a track 1 package and we're determining Track 2 contents look to see if track 1 package has a reference in it's Replace column
    else if (pkg.New.toLowerCase() === "false" && track === 2 && pkg.Replace && typeof pkg.Replace === 'string') {
      return {
        Package: `Replaced by: ${pkg.Replace}`,
        RepoLink: "",
        ColorCode: 4,
        Deprecated: false
      };
    }
  }
  // If a track couldn't be determined assume package is track 1
  // When determined track and param track don't match, return default
  return TrackSpecificsDefault;
}

/**
 * Determines the package name of the given package
 * @param pkg Package object directly from the CSV 
 * @returns the package name
 */
function getPackage(pkg: any): string {
  // use Package property from CSV
  if (pkg.Package) {
    return pkg.Package;
  } else {
    return "UNABLE TO DETERMINE PACKAGE";
  }
}

/**
 * Determines the repository link of the given package
 * @param pkg Package object directly from the CSV 
 * @returns the link to the packages code repository
 */
function getRepoLink(pkg: any): string {
  // property and property type check
  if (pkg.RepoPath && typeof pkg.RepoPath === "string") {
    // if RepoPath prop starts with github, return it
    if (pkg.RepoPath.startsWith("https://github.com")) {
      return pkg.RepoPath;
    } else if (
      pkg.Language &&
      typeof pkg.Language === "string" &&
      languageToRepoMapping[pkg.Language]
    ) {
      // if RepoPath doesn't start with github link, prefix the RepoPath with github link for language mono repo
      return languageToRepoMapping[pkg.Language] + "/" + pkg.RepoPath;
    } else {
      log.warn(
        `RepoLink could not be determined. Package: ${JSON.stringify(pkg)}`
      );
    }
  }
  // if RepoPath prop is blank of missing and language is Go, use the package name to create the RepoLink
  else if (
    pkg.Language &&
    pkg.Language === "Go" &&
    ((pkg.RepoPath && pkg.RepoPath === "") || pkg.RepoLink === undefined) &&
    pkg.Package &&
    typeof pkg.Package === "string" &&
    pkg.Package !== ""
  ) {
    return "https://github.com/Azure/azure-sdk-for-go/tree/main/" + pkg.Package;
  } else {
    // Logging for when a RepoLink can't be determined
    log.warn(
      `RepoLink could not be determine. Package: ${JSON.stringify(pkg)}`
    );
  }
  return "UNABLE TO DETERMINE REPO LINK";
}

// Mapping for language to Track 2 Mono Repos
const languageToRepoMapping: { [key: string]: string; } = {
  ".NET": "https://github.com/Azure/azure-sdk-for-net/tree/main/sdk",
  Java: "https://github.com/Azure/azure-sdk-for-java/tree/main/sdk",
  JavaScript: "https://github.com/Azure/azure-sdk-for-js/tree/main/sdk",
  Python: "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk",
  Go: "https://github.com/Azure/azure-sdk-for-go/tree/main/sdk",
  Android: "https://github.com/Azure/azure-sdk-for-android/tree/main/sdk",
  C: "https://github.com/Azure/azure-sdk-for-c/tree/main/sdk",
  "C++": "https://github.com/Azure/azure-sdk-for-cpp/tree/main/sdk",
  iOS: "https://github.com/Azure/azure-sdk-for-ios/tree/main/sdk",
};

/**
 * Determines whether a package has been deprecated or not
 * @param pkg Package object directly from the CSV
 * @returns true of the package has been deprecated, false if not
 */
function getDeprecationStatus(pkg: any): boolean {
  // below one-liner not working. Makes the func return an empty string? Not sure how that is even possible  // property and property type check, then check deprecation status
  // return pkg.Support && typeof pkg.Support === "string" && pkg.Support === "deprecated";

  // property and property type check
  if (pkg.Support && typeof pkg.Support === 'string') {
    // true if support is deprecated
    return pkg.Support === "deprecated";
  }
  return false;
}

/**
 * Determines the latest package release date
 * @param pkg Package object directly from the CSV
 * @returns the latests release date as a string in MM/DD/YYYY format, or a blank string if now date could be determined
 */
function getLatestRelease(pkg: any): string {
  //prop and prop type check
  if (pkg.LatestGADate && typeof pkg.LatestGADate === 'string') {
    return pkg.LatestGADate;
  }
  return "";
}

/**
 * Determines the latest package release date of package and returns it only if the package matches the track parameter. 
 * @param pkg Package object directly from the CSV
 * @returns the latests release date as a string in MM/DD/YYYY format, or a blank string if now date could be determined
 */
function getLatestReleaseTrack(pkg: any, track: number): string {
  // property and property type check 
  if (pkg.hasOwnProperty('New') && typeof pkg.New === "string") {
    // if New prop and track param match, return track specific details
    if (
      (pkg.New.toLowerCase() === "true" && track === 2) ||
      (pkg.New.toLowerCase() === "false" && track === 1)
    ) {
      return getLatestRelease(pkg);
    }
  }
  return "";
}

/**
 * Given two dates it will determine and return the most recent date
 * @param d1 a date as a string in MM/DD/YYYY format
 * @param d2 a date as a string in MM/DD/YYYY format
 * @returns the more recent date in MM/DD/YYYY format
 */
function compareDates(d1: string, d2: string): string {
  // If d1 or d2 are set to the "UNABLE TO DETERMINE LATEST RELEASE DATE" string, return the other date
  if (d1 === "") {
    return d2;
  }
  else if (d2 === "") {
    return d1;
  }

  let date1 = new Date(d1).getTime();
  let date2 = new Date(d2).getTime();
  // If date 1 comes after date 2 
  if (date1 > date2) {
    return d1;
  } else {
    return d2;
  }
}

/**
 * Determines if a package only has a beta release
 * @param pkg Package object directly from the CSV
 * @returns true if the package only has a beta release, false if it has a stable release. Will return false if function was unable to determine if only a beta version exists. 
 */
function isBeta(pkg: any): boolean {
  if (pkg.VersionGA !== undefined && pkg.VersionPreview !== undefined) {
    return pkg.VersionGA === "" && pkg.VersionPreview !== "";
  }
  log.warn(`Unable to determine if a Stable or Beta version of package exists. Package: ${JSON.stringify(pkg)}`);
  return false;
}

