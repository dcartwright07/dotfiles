"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const path_1 = __importDefault(require("path"));
const fs_1 = __importDefault(require("fs"));
const os_1 = __importDefault(require("os"));
const child_process_1 = require("child_process");
const detect_indent_1 = __importDefault(require("detect-indent"));
const find_up_1 = __importDefault(require("find-up"));
const phpfmt_1 = __importDefault(require("phpfmt"));
const Widget_1 = __importDefault(require("./Widget"));
class PHPFmt {
    constructor() {
        this.config = {};
        this.args = [];
        this.loadSettings();
        this.widget = Widget_1.default.getInstance();
    }
    loadSettings() {
        this.config = vscode_1.workspace.getConfiguration('phpfmt');
        this.args.length = 0;
        if (this.config.custom_arguments !== '') {
            this.args.push(this.config.custom_arguments);
            return;
        }
        if (this.config.psr1) {
            this.args.push('--psr1');
        }
        if (this.config.psr1_naming) {
            this.args.push('--psr1-naming');
        }
        if (this.config.psr2) {
            this.args.push('--psr2');
        }
        if (!this.config.detect_indent) {
            const spaces = this.config.indent_with_space;
            if (spaces === true) {
                this.args.push('--indent_with_space');
            }
            else if (spaces > 0) {
                this.args.push(`--indent_with_space=${spaces}`);
            }
        }
        if (this.config.enable_auto_align) {
            this.args.push('--enable_auto_align');
        }
        if (this.config.visibility_order) {
            this.args.push('--visibility_order');
        }
        const passes = this.config.passes;
        if (passes.length > 0) {
            this.args.push(`--passes=${passes.join(',')}`);
        }
        const exclude = this.config.exclude;
        if (exclude.length > 0) {
            this.args.push(`--exclude=${exclude.join(',')}`);
        }
        if (this.config.smart_linebreak_after_curly) {
            this.args.push('--smart_linebreak_after_curly');
        }
        if (this.config.yoda) {
            this.args.push('--yoda');
        }
        if (this.config.cakephp) {
            this.args.push('--cakephp');
        }
    }
    getWidget() {
        return this.widget;
    }
    getConfig() {
        return this.config;
    }
    getArgs(fileName) {
        const args = this.args.slice(0);
        args.push(`"${fileName}"`);
        return args;
    }
    format(text) {
        return new Promise((resolve, reject) => {
            if (this.config.detect_indent) {
                const indentInfo = (0, detect_indent_1.default)(text);
                if (!indentInfo.type) {
                    this.args.push('--indent_with_space');
                }
                else if (indentInfo.type === 'space') {
                    this.args.push(`--indent_with_space=${indentInfo.amount}`);
                }
            }
            else {
                if (this.config.indent_with_space !== 4 && this.config.psr2) {
                    return reject(new Error('phpfmt: For PSR2, code MUST use 4 spaces for indenting, not tabs.'));
                }
            }
            let iniPath;
            const execOptions = { cwd: '' };
            if (vscode_1.window.activeTextEditor) {
                execOptions.cwd = path_1.default.dirname(vscode_1.window.activeTextEditor.document.fileName);
                const workspaceFolders = vscode_1.workspace.workspaceFolders;
                if (workspaceFolders) {
                    iniPath = find_up_1.default.sync('.phpfmt.ini', {
                        cwd: execOptions.cwd
                    });
                    const origIniPath = iniPath;
                    for (let workspaceFolder of workspaceFolders) {
                        if (origIniPath &&
                            origIniPath.startsWith(workspaceFolder.uri.fsPath)) {
                            break;
                        }
                        else {
                            iniPath = undefined;
                        }
                    }
                }
            }
            try {
                const stdout = (0, child_process_1.execSync)(`${this.config.php_bin} -r "echo PHP_VERSION_ID;"`, execOptions);
                if (Number(stdout.toString()) < 50600 && Number(stdout.toString()) > 80000) {
                    return reject(new Error('phpfmt: PHP version < 5.6 or > 8.0'));
                }
            }
            catch (err) {
                return reject(new Error(`phpfmt: php_bin "${this.config.php_bin}" is invalid`));
            }
            const tmpDir = os_1.default.tmpdir();
            const tmpFileName = path_1.default.normalize(`${tmpDir}/temp-${Math.random()
                .toString(36)
                .replace(/[^a-z]+/g, '')
                .substr(0, 10)}.php`);
            try {
                fs_1.default.writeFileSync(tmpFileName, text);
            }
            catch (err) {
                this.widget.addToOutput(err.message);
                return reject(new Error(`phpfmt: Cannot create tmp file in "${tmpDir}"`));
            }
            try {
                (0, child_process_1.execSync)(`${this.config.php_bin} -l ${tmpFileName}`, execOptions);
            }
            catch (err) {
                this.widget.addToOutput(err.message);
                vscode_1.window.setStatusBarMessage('phpfmt: Format failed - syntax errors found', 4500);
                return reject();
            }
            const args = this.getArgs(tmpFileName);
            args.unshift(`"${phpfmt_1.default.pharPath}"`);
            let formatCmd;
            if (!iniPath) {
                formatCmd = `${this.config.php_bin} ${args.join(' ')}`;
            }
            else {
                formatCmd = `${this.config.php_bin} ${args[0]} --config=${iniPath} ${args.pop()}`;
            }
            this.widget.addToOutput(formatCmd);
            try {
                (0, child_process_1.execSync)(formatCmd, execOptions);
            }
            catch (err) {
                this.widget.addToOutput(err.message).show();
                return reject(new Error('phpfmt: Execute phpfmt failed'));
            }
            const formatted = fs_1.default.readFileSync(tmpFileName, 'utf-8');
            try {
                fs_1.default.unlinkSync(tmpFileName);
            }
            catch (err) { }
            if (formatted.length > 0) {
                resolve(formatted);
            }
            else {
                reject();
            }
        });
    }
}
exports.default = PHPFmt;
//# sourceMappingURL=PHPFmt.js.map