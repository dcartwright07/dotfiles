"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const os_1 = __importDefault(require("os"));
const child_process_1 = require("child_process");
const phpfmt_1 = __importDefault(require("phpfmt"));
class Transformations {
    constructor(phpBin) {
        this.phpBin = phpBin;
    }
    get baseCmd() {
        return `${this.phpBin} "${phpfmt_1.default.pharPath}"`;
    }
    getTransformations() {
        const output = (0, child_process_1.execSync)(`${this.baseCmd} --list-simple`).toString();
        return output
            .trim()
            .split(os_1.default.EOL)
            .map(v => {
            const splited = v.split(' ');
            return {
                key: splited[0],
                description: splited
                    .filter((value, index) => value && index > 0)
                    .join(' ')
                    .trim()
            };
        });
    }
    getExample(transformationItem) {
        const output = (0, child_process_1.execSync)(`${this.baseCmd} --help-pass ${transformationItem.key}`).toString();
        return output.toString().trim();
    }
}
exports.default = Transformations;
//# sourceMappingURL=Transformations.js.map