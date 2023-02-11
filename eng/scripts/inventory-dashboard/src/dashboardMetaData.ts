import { Package, PackageList, StringTrackSpecificsDefault, TrackSpecifics, TrackSpecificsDefault } from "./types";
import { Logger } from './logger';
const log = Logger.getInstance();

/**
 * Adds needed Dashboard meta data to the package data 
 * Color Codes: 
 *  1: Color = Red, ERROR - Track 2: track 2 replacement for track 1 package missing, Track 1: track 1 package has a track 2 replacement but has not bee deprecated
 *  2: Color = Yellow, WARNING - Track 2: missing track 2 package based on equivalent package in another language or from API spec
 *  3: Color = Orange, BETA - Track 2: package in beta
 * 4: Color = Grey, Nothing - Track 2: Replace Reference 
 *  10: Color = Green, OKAY
 *  11: Color = Grey, Nothing to display
 * @param packages A map of packages after being formatted and after having empty packages added
 * @returns A map of packages with all packages colorCodes being properly set. 
 */
export default function addDashboardMetaData(packages: PackageList): PackageList {
    // go through packages and add color code and completeness percent to each
    for (let key in packages) {
        // If Package is an empty Track 2 Package
        if (JSON.stringify(packages[key].Track2) === JSON.stringify(TrackSpecificsDefault) || isMissingPackage(packages[key].Track2)) {
            // If track 1 package is not empty, this is a missing track 2 replacement 
            if (JSON.stringify(packages[key].Track1) !== JSON.stringify(TrackSpecificsDefault)) {
                // missing track 2 sdk replacement for a track 1, color code 1 = red
                packages[key] = { ...packages[key], Track2: { ...packages[key].Track2, ColorCode: 1 } };
            } else {
                // missing data plane sdk for a language, color code 2 = yellow
                packages[key] = { ...packages[key], Track2: { ...packages[key].Track2, ColorCode: 2 } };
            }
        }
        // If package has a Track 2
        else {
            // If track 1 package also exists and is not deprecated 
            if (JSON.stringify(packages[key].Track1) !== JSON.stringify(TrackSpecificsDefault) && !packages[key].Track1.Deprecated) {
                // track 1 library with a track 2 replacement is not deprecated, color code 1 = red
                packages[key] = { ...packages[key], Track1: { ...packages[key].Track1, ColorCode: 1 } };
            }
        }
        // No Track 1
        if (JSON.stringify(packages[key].Track1) === StringTrackSpecificsDefault) {
            // No track 1 library should be color code 2 for grey
            packages[key] = { ...packages[key], Track1: { ...packages[key].Track1, ColorCode: 11 } };
        }
        // set percent complete, if Both track 1 and 2 have OKAY codes, percent complete should be 1
        let percentComplete = 0;
        if ([3, 4, 10, 11].includes(packages[key].Track2.ColorCode)) {
            percentComplete = 1;
        }
        // if (packages[key].Track1.ColorCode === 11) percentComplete = packages[key].Track2.ColorCode === 10 ? 1 : 0;
        // else if (packages[key].Track2.ColorCode === 10 && packages[key].Track1.ColorCode === 1) percentComplete = 0.5;
        // else if (packages[key].Track2.ColorCode === 10) percentComplete = 1;
        // if (packages[key].Track2.ColorCode === 10) percentComplete += 0.5;
        // if (packages[key].Track1.ColorCode === 10) percentComplete += 0.5;
        packages[key] = { ...packages[key], PercentComplete: percentComplete };
    }
    return packages;
}

function isMissingPackage(pkg: TrackSpecifics): boolean {
    const { Package, RepoLink, ColorCode, Deprecated } = pkg;
    return Package.startsWith("Missing:") && RepoLink === "" && ColorCode === 10 && !Deprecated;
}