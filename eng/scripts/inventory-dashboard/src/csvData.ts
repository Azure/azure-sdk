import csvToJSON from "csvtojson";
import { Language } from "./types";
import path from "path";
import fs from 'fs';
import { Logger } from './logger';
const log = Logger.getInstance();
const csvDirPath = path.join(__dirname, `../../../../_data/releases/latest`);

/**
 * Reads CSVs files. 
 * Converts CSV File to JSON Array and adds Language Property for each package. 
 * @returns Promise<any[]> all pkg objects from all languages in one array 
 */
export default async function collectCSVData(): Promise<any[]> {
  // Retrieve CSV files from latest release dir
  const csvFiles = fs.readdirSync(csvDirPath);
  // Get CSV contents from all files and convert to JSON
  const packagesJSONArr: any[] = []; // Array to contain all CSV contents
  for (let csv of csvFiles) {
    // Ignore the specs index for now
    if (csv === "specs.csv") { continue; }
    // Convert csv file to json arr
    const jsonContent = await csvToJSON().fromFile(path.join(csvDirPath, csv));
    // Add Language property to each pkg object 
    for (let pkg of jsonContent) {
      packagesJSONArr.push({
        ...pkg,
        Language: csvNameToLanguage(csv)
      });
    }
  }
  return packagesJSONArr;
}

/**
 * Takes the CSV File name from a CSV in the Azure/azure-sdk/_data/releases/latest repo dir and returns the corresponding Language type
 * @param csvName Name of CSV File from Azure/azure-sdk/_data/releases/latest repo dir
 * @returns Language type based on CSV name
 */
function csvNameToLanguage(csvName: string): Language {
  switch (csvName) {
    case "android-packages.csv":
      return "Android";
    case "c-packages.csv":
      return "C";
    case "cpp-packages.csv":
      return "C++";
    case "dotnet-packages.csv":
      return ".NET";
    case "go-packages.csv":
      return "Go";
    case "ios-packages.csv":
      return "iOS";
    case "java-packages.csv":
      return "Java";
    case "js-packages.csv":
      return "JavaScript";
    case "python-packages.csv":
      return "Python";
    case "rust-packages.csv":
      return "Rust";
    default:
      throw Error(`Package CSV matches no Language. Package name: ${csvName}`);
  }
}
