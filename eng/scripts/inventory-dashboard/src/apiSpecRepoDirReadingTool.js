// A script that reads the directories in ../azure-rest-api-specs/specification and outputs the directories in a JSON file with the following format:
// {
//  "directory-name": {
//   "service-display-name":"name of directory",
//   "api-display-names": {
//    "subdirectory-names": "api-display-name"
//   },
//  },
// }
// If the directory-name maps to a key in ../data-and-rules/serviceNameMap.json, the service-display-name will be the value of that key. If the value contains a "|", the service-display-name should be the string before the "|". If not, it will be the directory-name.
// If the subdirectory name is data-plane or resource-manager, the api-display-name will be the same as the service-display-name, but if the directory-name maps to a key in ../data-and-rules/serviceNameMap.json, the api-display-name will be the value of that key. If the value contains a "|", the api-display-name should be the string after the "|". 
// If the subdirectory name is neither resource-manager nor data-plane, the api-display-name will be the same as the subdirectory name.


const fs = require("fs");
const path = require("path");
const serviceNameMap = require("../data-and-rules/serviceNameMap.json"); 
const apiSpecRepoDir = path.join(__dirname, "..", "..", "..","..", "..", "azure-rest-api-specs", "specification");
const apiSpecRepoDirReadingToolOutput = path.join(__dirname,"..", "data-and-rules", "apiSpecMap.json");
const jsonOutput = {};

const specDirs = fs.readdirSync(apiSpecRepoDir);
specDirs.forEach(specDir => {
        const specDirPath = path.join(apiSpecRepoDir, specDir);
        const specDirStats = fs.statSync(specDirPath);
        if (specDirStats.isDirectory()) {
            const serviceDisplayName = getServiceDisplayName(specDir);
            const apiDisplayNames = getApiDisplayNames(specDirPath, specDir);
            jsonOutput[specDir] = {
                "service-display-name": serviceDisplayName,
                "api-display-names": apiDisplayNames
            };
        }
});

fs.writeFileSync(apiSpecRepoDirReadingToolOutput, JSON.stringify(jsonOutput, null, 4));

function getServiceDisplayName(specDir) {
    if (serviceNameMap[specDir]) {
        if (serviceNameMap[specDir].includes("|")) {
            return serviceNameMap[specDir].split("|")[0];
        } else {
            return serviceNameMap[specDir];
        }
    } else {
        return specDir;
    }
}

function getApiDisplayNames(specDirPath, specDir) {
    const apiDisplayNames = {};
    const subDirs = fs.readdirSync(specDirPath);
    subDirs.forEach(subDir => {
        if(subDir === "data-plane" || subDir === "resource-manager") {
            if(serviceNameMap[specDir]) {
                if (serviceNameMap[specDir].includes("|")) {
                    apiDisplayNames[subDir] = serviceNameMap[specDir].split("|")[1];
                } else {
                    apiDisplayNames[subDir] = serviceNameMap[specDir];
                }
            } else {
                apiDisplayNames[subDir] = specDir;
            }
        }else {
            apiDisplayNames[subDir] = subDir;
        }
    });
    return apiDisplayNames;
}

