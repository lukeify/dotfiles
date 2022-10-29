import * as utils from 'utils'; 
const fs = require('fs/promises');

/**
 * `dockutil` cannot be installed via homebrew at the moment. Grab a copy from GitHub.
 */
const installDockutil = (): void => {
    console.log('`dockutil` not found. Installing...');

    const manifestUrl = "https://api.github.com/repos/kcrawford/dockutil/releases/latest";
    const downloadUrl = utils.exec(`curl --silent "${manifestUrl}" | jq -r .assets[].browser_download_url | grep pkg`);

    utils.execSilently(
        `curl -sL ${downloadUrl} -o /tmp/dockutil.pkg`,
        `sudo installer -pkg "/tmp/dockutil.pkg" -target /`,
        `rm /tmp/dockutil.pkg`
    );
}

/**
 * Reorganises the dock by reading from the provided `./dockconfig.json` file, and executing the provided alterations.
 */
const reorganiseDock = async (): Promise<void> => {
    let dockConfiguration = null;
    try {
        dockConfiguration = JSON.parse(await fs.readFile('./dockconfig.json'));
    } catch (e) {
        console.error(e, 'Could not read `dockconfig.json`.');
    }

    dockConfiguration.removals.forEach((item: string) => removeItem(item));
    dockConfiguration.additions.forEach(({ item, position }: { item: string, position: number; }) => addItem(item, position));
    dockConfiguration.spacers.forEach(({ after }: { after: string }) => addSpacer(after));
}

/**
 * Sets dock UI preferences.
 */
const setDockPreferences = (): void => {
    utils.setPref("dock", "tilesize", 56);
    utils.setPref("dock", "show-recents", false);
    utils.setPref("dock", "magnification", 1);
    utils.setPref("dock", "scroll-to-open", true);
}

/**
 * Removes an item from the dock via its application name.
 * 
 * @param {*} appName - The application name to remove from the dock.
 */
const removeItem = async (appName: string): Promise<void> => {
    try {
        utils.execSilently(`dockutil --remove "${appName}" --no-restart`);
    } catch (e) {
        console.error(`Could not remove ${appName}`, e);
    }
}

/**
 * Appends an item to the dock to the provided position, via its application name.
 * 
 * @param {string} appName - The application name to append to the dock. The app should be located in the `/Applications` directory
 * and have an `.app` file extension. 
 * @param {number} position - The zero-indexed position within the dock.
 */
const addItem = (appName: string, position: number): void => {
    try {
        utils.execSilently(`dockutil --add "/Applications/${appName}.app" --position ${position} --no-restart`);
    } catch (e) {
        console.error(`Could not add ${appName}`, e);
    }
}

/**
 * Adds a `small-spacer-tile` element to the dock, after the provided app name.
 * 
 * @param {string} afterAppName - The name of the application to place the spacer after.
 */
const addSpacer = (afterAppName: string): void => {
    try {
        utils.execSilently(`dockutil --add '' --type small-spacer --section apps --after "${afterAppName}" --no-restart`);
    } catch { 
        console.error(`Could not add spacer.`);
    }
}

/**
 * Restarts the dock after modifications to its plist have been made.
 */
const restartDock = () => utils.exec('killall Dock');

/**
 * Handler.
 */
(async () => {
    if (!utils.commandExists('dockutil')) {
        installDockutil();
    }
    await reorganiseDock();
    setDockPreferences();
    restartDock();
})();