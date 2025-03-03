export type Item = {
  type: "dir" | "file" | "submodule" | "symlink";
  size: number;
  name: string;
  path: string;
  content?: string | undefined;
  sha: string;
  url: string;
  git_url: string | null;
  html_url: string | null;
  download_url: string | null;
  _links: any;
};
export type Language =
  ".NET"
  | "Java"
  | "JavaScript"
  | "Python"
  | "Go"
  | "Android"
  | "C"
  | "C++"
  | "iOS"
  | "Rust"
  | "UNABLE TO DETERMINE LANGUAGE";
export function isLanguage(str: string): str is Language {
  return (str === ".NET"
    || str === "Java"
    || str === "JavaScript"
    || str === "Python"
    || str === "Go"
    || str === "Android"
    || str === "C"
    || str === "C++"
    || str === "iOS"
    || str === "UNABLE TO DETERMINE LANGUAGE");
}
export const Tier1Languages: Language[] = [
  ".NET",
  "Java",
  "JavaScript",
  "Python",
  "Go"
];

export type Plane =
  | "mgmt"
  | "data"
  | "compat"
  | "spring"
  | "core"
  | "tool"
  | "UNABLE TO BE DETERMINED";

export function isPlaneType(str: string): str is Plane {
  return ["mgmt", "data", "compat", "spring", "UNABLE TO BE DETERMINED"].some(element => element === str);
}

export type TrackSpecifics = {
  Package: string;
  RepoLink: string;
  ColorCode: number;
  Deprecated: boolean;
};
export const TrackSpecificsDefault: TrackSpecifics = {
  Package: "",
  RepoLink: "",
  ColorCode: 10,
  Deprecated: false,
};
export const StringTrackSpecificsDefault = JSON.stringify(
  TrackSpecificsDefault
);
export type FormattingPackage = {
  Service: string;
  ServiceId: number;
  SDK: string;
  Plane: Plane | undefined;
  Language: Language;
  Track1: TrackSpecifics;
  Track2: TrackSpecifics;
  PercentComplete: number | undefined;
  LatestRelease: string;
  LatestReleaseTrack1: undefined | string;
  LatestReleaseTrack2: undefined | string;
};
export type Package = {
  Service: string;
  ServiceId: number;
  SDK: string;
  Plane: Plane | undefined;
  Language: Language;
  Track1: TrackSpecifics;
  Track2: TrackSpecifics;
  PercentComplete: number | undefined;
  LatestRelease: string;
};
export type FormattingPackageList = {
  [key: string]: FormattingPackage;
};
export type PackageList = {
  [key: string]: Package;
};
export type PomXML = {
  project: {};
};
export type PythonPackageTOML = {
  packageName: string | undefined;
  packagePrintName: string | undefined;
  isArm: boolean | undefined;
};
