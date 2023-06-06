const csvToJSON = require("csvtojson");
const path = require("path");
const inventoryCSVPath = path.join(__dirname,"..", "..", "..", "..", "_data", "releases", "inventory", "inventory.csv");

getInventoryStats();

async function getInventoryStats() {
    const inventoryJSON = await csvToJSON().fromFile(inventoryCSVPath);

    //Print out the number of objects in the inventoryJSON array with distinct values for 'Service'
    console.log(`There are ${inventoryJSON.filter((item, index, self) => self.findIndex(t => t.Service === item.Service) === index).length} distinct services in the inventory.`);
    //Print out and number the distinct values for 'Service'. Exclude any services with Core in the name regardless of case.
    console.log(`The distinct services are: ${inventoryJSON.filter((item, index, self) => self.findIndex(t => t.Service === item.Service) === index).filter((item) => !item.Service.toLowerCase().includes("core")).map((item, index) => `${index + 1}. ${item.Service}`).join(", ")}.`);
    // Print out the number of objects in the inventoryJSON array with a Plane value of 'mgmt` and who's Track2 value has a ColorCode value of '10'
    console.log(`There are ${inventoryJSON.filter((item) => item.Plane === "mgmt" && item.Track2.ColorCode === "10").length} objects in the inventory with a Plane value of 'mgmt' and a Track2 value of '10'.`);
    // Print out the number of objects in the inventoryJSON array with a Plane value of 'mgmt` and who's Track2 value has a ColorCode value of '3'
    console.log(`There are ${inventoryJSON.filter((item) => item.Plane === "mgmt" && item.Track2.ColorCode === "3").length} objects in the inventory with a Plane value of 'mgmt' and a Track2 value of '3'.`);
    // Print out the number of objects in the inventoryJSON array with a Plane value of 'mgmt` and who's Track2 value has a ColorCode value of '1' or '2'
    console.log(`There are ${inventoryJSON.filter((item) => item.Plane === "mgmt" && (item.Track2.ColorCode === "1" || item.Track2.ColorCode === "2")).length} objects in the inventory with a Plane value of 'mgmt' and a Track2 value of '1' or '2'.`);
}
