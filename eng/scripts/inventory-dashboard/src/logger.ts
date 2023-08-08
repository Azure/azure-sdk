import chalk from "chalk";
import fs from "fs";

type LogType = "err" | "warn" | "info" | "atn";

export class Logger {
  file: string;
  private static _instance: Logger;
  private constructor(file: string) {
    this.file = file;
    //clear log file
    fs.writeFileSync(this.file, "");
  }
  public static getInstance() {
    return this._instance || (this._instance = new Logger("console.log"));
  }
  log(type: LogType, message: string) {
    let color: (message: string) => void;
    let prefix: string;
    switch (type) {
      case "err":
        color = chalk.red;
        prefix = "ERROR";
        break;
      case "warn":
        color = chalk.yellow;
        prefix = "WARNING";
        break;
      case "info":
        color = chalk.green;
        prefix = "INFO";
        break;
      case "atn":
        color = chalk.blue;
        prefix = "ATTENTION";
        break;
      default:
        color = chalk.green;
        prefix = "INFO";
        break;
    }
    console.log(color(`${prefix} - ${message}`));
    chalk.red;
    fs.appendFileSync(this.file, `${prefix} - ${message}\n`);
  }
  err(message: string) {
    this.log("err", message);
  }
  warn(message: string) {
    this.log("warn", message);
  }
  info(message: string) {
    this.log("info", message);
  }
  atn(message: string) {
    this.log("atn", message);
  }
}
