import * as fs from "node:fs";
import * as yaml from "yaml";
import lockfile from "@yarnpkg/lockfile";

const [configPath, lockfilePath, platform, arch, cache] = process.argv.slice(2);

const config = fs.readFileSync(configPath, 'utf8');
const parsedConfig = yaml.parse(config);
const lockFile = fs.readFileSync(lockfilePath, 'utf8');
const parsedLockfile = lockfile.parse(lockFile);

const electronPackageName = Object.keys(parsedLockfile.object).find(pkg => pkg.startsWith("electron@"));
const electronPackage = parsedLockfile.object[electronPackageName];

parsedConfig.mac.target = [{
  target: "dir",
  arch
}];

parsedConfig.linux.target = [{
  target: "dir",
  arch
}];

parsedConfig.electronDownload = {
  version:electronPackage.version,
  cache,
  arch,
  platform
};

fs.writeFileSync(configPath, yaml.stringify(parsedConfig));

