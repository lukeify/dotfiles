import { setPref } from './utils';

(() => {
    setPref("finder", "_FXShowPosixPathInTitle", true);
    setPref("finder", "ShowStatusBar", true);
    setPref("finder", "ShowPathbar", true);
    setPref("finder", "FXPreferredViewStyle", "Nlsv");
    setPref("finder", "FXDefaultSearchScope", "SCcf");
    // Don't show a warning when changing a file extension.
    setPref("finder", "FXEnableExtensionChangeWarning", false);
    setPref("finder", "NewWindowTargetPath", "file:///Users/luke");
})();