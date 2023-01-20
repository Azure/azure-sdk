import * as dotenv from "dotenv";
import { Octokit } from "@octokit/rest";
import fetch from "node-fetch";
import csvToJSON from "csvtojson";
import { Language } from "./types";
/**
 * Queries GitHub for the list of CSV files in Azure/azure-sdk/_data/releases/latest.
 * Then retrieves the CSV contents, concatenates them, and converts them to a JSON Object
 */
export default async function collectCSVData(): Promise<any[]> {
  // Make properties in .env environment variables
  dotenv.config();
  // Create Octokit instance
  const octokit = new Octokit({
    auth: process.env.GITHUB_AUTH_TOKEN,
  });
  // Retrieve list of files in latest release dir
  const { data: csvFiles } = await octokit.rest.repos.getContent({
    owner: "Azure",
    repo: "azure-sdk",
    path: "_data/releases/latest",
    ref: "main"
  });
  // Retrieve CSV contents for each CSV File and convert to JSON
  let packagesJSONArr: any[] = []; // Array to contain all CSV Contents
  if (Array.isArray(csvFiles)) {
    for (let csv of csvFiles) {
      if (csv.download_url) {
        // Get CSV Content
        const csvContent = await fetch(csv.download_url).then((response) =>
          response.text()
        );
        // Convert CSV to JSON
        let csvJSONArr = await csvToJSON().fromString(csvContent);
        // Add language and push to main arr
        for (let i = 0; i < csvJSONArr.length; i++) {
          packagesJSONArr.push({
            ...csvJSONArr[i],
            Language: csvNameToLanguage(csv.name),
          });
        }
      } else {
        throw Error(`No download_url on item: ${csv.name}`);
      }
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
    default:
      throw Error(`Package CSV matches no Language. Package name: ${csvName}`);
  }
}
