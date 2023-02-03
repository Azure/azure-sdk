import { Tier1Languages, PackageList, TrackSpecificsDefault } from "./types";
import _exceptionsMap from '../data-and-rules/exceptionsMap.json';
import { Logger } from './logger';
const log = Logger.getInstance();
const exceptionMap: any = _exceptionsMap;
export default function exceptionHandler(packages: PackageList): PackageList {
    /*  Handel No Language SDK Needed
        Description: When a library is needed for one programming language but not another this exception will 
        over write the empty/missing SDK entry with an Exception. 
    */
    if (exceptionMap["language-sdk-not-needed"] && Array.isArray(exceptionMap["language-sdk-not-needed"])) {
        for (let exception of exceptionMap["language-sdk-not-needed"]) {
            if (typeof exception === 'object' && exception.Service && exception.SDK && exception.Plane && exception['Languages-Not-Needed'] && Array.isArray(exception['Languages-Not-Needed'])) {
                for (let language of exception['Languages-Not-Needed']) {
                    let key = (exception.Service + exception.SDK + exception.Plane + language).toLowerCase();
                    log.info(`Handling Exception "Language SDK Not Needed" for language: ${language} in exception: ${JSON.stringify(exception)}`);
                    if (packages[key]) {
                        packages[key] = { ...packages[key], Track2: { ...TrackSpecificsDefault, Package: "Exception: Not Needed for Language" } };
                    } else {
                        log.atn(`Needless Exception Rule: "language-sdk-not-needed": Language: ${language} - Exception: ${JSON.stringify(exception)}\nConsider removing the unused rule or modifying it.`);
                    }
                }
            }
        }
    }
    /*  Track 2 Replacement Not Needed
        Description: When a Track 1 library exists with no Track 2 replacement and we do not intend to ever 
        create a replacing library. This exception will over write the empty/missing SDK entry with an Exception. 
     */
    if (exceptionMap["track-2-not-needed"] && Array.isArray(exceptionMap["track-2-not-needed"])) {
        for (let exception of exceptionMap["track-2-not-needed"]) {
            if (typeof exception === 'object' && exception.Service && exception.SDK && exception.Plane && exception.Language) {
                let key = (exception.Service + exception.SDK + exception.Plane + exception.Language).toLowerCase();
                log.info(`Handling Exception "Track 2 Not Needed" for exception: ${JSON.stringify(exception)}`);
                if (packages[key]) {
                    packages[key] = { ...packages[key], Track2: { ...TrackSpecificsDefault, Package: "Exception: Track 2 Replacement Not Needed" } };
                } else {
                    log.atn(`Needless Exception Rule: "track-2-not-needed":${JSON.stringify(exception)}\nConsider removing the unused rule or modifying it.`);
                }
            }
        }
    }
    return packages;
}