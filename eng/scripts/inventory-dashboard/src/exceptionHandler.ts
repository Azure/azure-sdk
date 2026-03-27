import { isLanguage, isPlaneType, Language, Package, PackageList, TrackSpecificsDefault } from "./types";
import _exceptionsList from '../data-and-rules/exceptionsList.json';
import { Logger } from './logger';
const log = Logger.getInstance();
const exceptionList: any = _exceptionsList;
/**
 * Apply exceptions from the exceptionsMap.json file to the list of packages.
 * @param packages Map of found packages.
 * @returns Map of packages with added exceptions
 */
export default function exceptionHandler(packages: PackageList): PackageList {
    if (!Array.isArray(exceptionList)) {
        log.err(`ExceptionList.json does not contain an array at the highest level. `);
        return packages;
    }
    // Loop through all exception and apply them 
    for (let exception of exceptionList) {
        // check exception is an object
        if (typeof exception !== 'object') {
            log.err(`Exception is not an object. Exception: ${JSON.stringify(exception)}`);
        }
        // check exception object has Service, Exception, and SDKs properties and that they are the right type
        else if (!(exception.hasOwnProperty('Service') && typeof exception.Service === "string") || !(exception.hasOwnProperty('Exception') && typeof exception.Exception === 'string') || !(exception.hasOwnProperty('SDKs') && typeof exception.SDKs === 'object')) {
            log.err(`Exception missing Service:string and/or Exception:string and/or SDKs:object property. Exception: ${JSON.stringify(exception)}`);
        }
        // All above checks have passed
        else {
            // extract props to constants
            const { Exception: exceptionStr, Service: service, SDKs: sdks } = exception;
            // loop through SDKs object. 
            for (let sdkName of Object.keys(sdks)) {
                const sdk = sdks[sdkName];
                // prop checks
                if (!(typeof sdk === 'object' && sdk.hasOwnProperty('Plane') && typeof sdk.Plane === 'string' && isPlaneType(sdk.Plane) && sdk.hasOwnProperty('Languages') && Array.isArray(sdk.Languages))) {
                    log.err(`SDK is not an object and/or SDK does not have props Plane:string:PlaneType and/or Languages:array.\n\tException: ${JSON.stringify(exception)}\n\tSDK Name: ${sdkName}\n\tSDK: ${JSON.stringify(sdk)}`);
                }
                // All above checks pass
                else {
                    // extract props to constants
                    const { Plane: plane, Languages: languages } = sdk;
                    // loop through languages
                    for (let language of languages) {
                        // check if language is in list of languages 
                        if (!isLanguage(language)) {
                            log.err(`Language is not a accepted programming language. \n\tException: ${JSON.stringify(exception)}\n\tSDK: ${JSON.stringify(sdk)}\n\tLanguage: ${language}`);
                        }
                        // all above checks pass
                        else {
                            // create package map key
                            const key = (service + sdkName + plane + language).toLowerCase();
                            // check if there is a matching package entry for the key
                            if (packages[key] === undefined) {
                                printExceptionWarn("Found Unused Exception", exception, sdkName, language);
                            }
                            // check if exception would write over a track 2 package
                            else if (packages[key].Track2.ColorCode == 10) {
                                printExceptionWarn("Exception would overwrite valid Track 2 library", exception, sdkName, language, packages[key]);
                            }
                            // all above checks pass
                            else {
                                // write over missing package entry with exception entry
                                packages[key] = {
                                    ...packages[key], Track2: { ...TrackSpecificsDefault, Package: `Exception: ${exceptionStr}` }, PercentComplete: 1
                                };
                            }
                        }
                    }
                }
            }
        }
    }
    return packages;
}

function printExceptionWarn(message: string, exception: object, sdkName: string, language: Language, pkg?: Package): void {
    log.warn(`${message}\n\tException: ${JSON.stringify(exception)}\n\tSDK: ${JSON.stringify(sdkName)}\n\tLanguage: ${language}${pkg !== undefined ? `\n\tPackage: ${JSON.stringify(pkg)}` : ''}`);
}