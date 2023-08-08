import { json2csv } from "json-2-csv";
import collectCSVData from "./csvData";
import { formatReleaseCSVData } from "./formatData";
import { Logger } from "./logger";
import fs from "fs";
import path from "path";
import addEmptyDataPoints from "./addEmptyDataPoints";
import exceptionHandler from "./exceptionHandler";
import addDashboardMetaData from "./dashboardMetaData";
const log = Logger.getInstance();

//Get two inputs from command line for csvDirPath and apiSpecsDirPath
const apiSpecsDirPath = process.argv[2];


// Main entry point for data collection and data formatting of SDK Package Inventory Data
async function main() {
    // Pull in csv data from release CSVs and convert to array of Objects
    const csvData = await collectCSVData();
    // Format JSON Objects
    let formattedCSVData = formatReleaseCSVData(csvData);
    // Add empty data points, ex: if data plane SDK is missing.
    formattedCSVData = await addEmptyDataPoints(formattedCSVData, apiSpecsDirPath);
    // Add color code and completeness percent
    formattedCSVData = addDashboardMetaData(formattedCSVData);
    // Add exception handling
    formattedCSVData = exceptionHandler(formattedCSVData);
    // Turn package map into a package array
    const formattedPackageArr = [];
    for (let pkgKey in formattedCSVData) {
        formattedPackageArr.push(formattedCSVData[pkgKey]);
    }
    // Write Formatted Object to CSV File
    json2csv(formattedPackageArr, (err, csv) => {
        if (err) {
            log.err(`Error Writing to CSV. Error: ${err}`);
        } else if (csv) {
            fs.writeFileSync(
                path.join(__dirname, "../../../../_data/releases/inventory/inventory.csv"),
                csv
            );
        } else {
            log.err(`CSV is undefined`);
        }
    });
}
main();
