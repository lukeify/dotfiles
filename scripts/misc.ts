import { setPref } from './utils';

(async () => {
    // Disable rich text editing in TextEdit.
    setPref("TextEdit", "RichText", false);

    // Prevent warnings when applications are downloaded from the internet.
    setPref("LaunchServices", "LSQuarantine", false);

    // Check for software updates daily.
    setPref("SoftwareUpdate", "ScheduleFrequency", 1);

    // Download available updates in the background.
    setPref("SoftwareUpdate", "AutomaticDownload", 1);

    // Install security updates always.
    setPref("SoftwareUpdate", "CriticalUpdateInstall", 1);

    // Show the battery percentage for mobile devices.
    setPref("menuextra.battery", "ShowPercent", true);

    // Automatically update App Store apps
    setPref("commerce", "AutoUpdate", true);
})();