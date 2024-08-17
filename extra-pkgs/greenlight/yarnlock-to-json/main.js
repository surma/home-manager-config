import * as fs from "node:fs";
import lockfile from "@yarnpkg/lockfile";

const input = fs.readFileSync(0, 'utf8');
const parsedLockfile = lockfile.parse(input);
if(parsedLockfile.type !== "success") throw Error("Failed");
fs.writeFileSync(1, JSON.stringify(parsedLockfile.object, null, 2));
