import { execSync } from 'child_process';

export interface PrefOpts {
    hasCustomDomain: boolean;
    writeOption: string;
}

/**
 * 
 */
export type PreferableType = string | boolean | number;

/**
 * Checks that the command with the given name exists.
 * 
 * @param {string} commandName - The name of the command to check.
 * 
 * @returns boolean - `true` if the command exists, `false` otherwise.
 */
export const commandExists = (commandName: string): boolean => {
    try {
        execSilently(`command -v ${commandName}`);
        return true;
    } catch (e) {
        return false;
    }
}

/**
 * Executes the provided commands silently.
 * 
 * @param {...string} commands - An array of commands to execute silently.
 */
export const execSilently = (...commands: string[]): void => {
    for (const command of commands) {
        execSync(command, { encoding: 'utf-8', stdio: 'pipe' });
    }
}

/**
 * Executes the provided commands. 
 * 
 * @param  {...string} commands - An array of commands to execute.
 */
export const exec = (...commands: string[]): void => {
    for (const command of commands) {
        execSync(command, { encoding: 'utf-8', stdio: 'inherit' });
    }
}

/**
 * Sets a macOS preference against the provided domain.
 * 
 * @param {string} domain - The name of the domain the preference is located within.
 * @param {string} parameter - The parameter name to set.
 * @param {PreferableType} value - The value to be set for the preference.
 * @param {PrefOpts|undefined} options - The options used to customise how the preference is set.
 */
export const setPref = (domain: string, parameter: string, value: PreferableType, options?: PrefOpts): void => {
    let parameterValue, parameterType;

    if (options?.writeOption === 'array-add') {
        parameterType = "array-add";
        
    } else if (typeof value === "boolean") {
        parameterType = "bool";
        parameterValue = value ? "true" : "false";

    } else if (typeof value === "number") {
        parameterType = "int";
        parameterValue = value.toString();

    } else if (typeof value === "string") {
        parameterType = "string";
        parameterValue = value;
    }

    if (!options?.hasCustomDomain) {
        domain = `com.apple.${domain}`;
    }

    const command = [
        `defaults write`,
        domain,
        `"${parameter}"`,
        options?.writeOption ?? '',
        `-${parameterType}`,
        `"${parameterValue}"`
    ].join(" ");

    console.log(`[✔️] ${command}`);
    exec(command);
}

/**
 * Sets a global macOS preference against the `NSGlobalDomain` domain.
 * 
 * @param {string} parameter - The parameter name to set.
 * @param {PreferableType} value - The value to be set for the preference.
 * @param {PrefOpts|undefined} options - The options used to customise how the preference is set.
 */
export const setGlobalPref = (parameter: string, value: PreferableType, options?: PrefOpts): void => {
    setPref("-g", parameter, value, options);
}
