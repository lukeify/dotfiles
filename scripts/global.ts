import { setPref, setGlobalPref } from './utils';

(() => {
    // Always show file extensions.
    setGlobalPref("AppleShowAllExtensions", false);
    // Ensure save dialogs start out expanded.
    setGlobalPref("NSNavPanelExpandedStateForSaveMode", true);
    // Prefer saving to disk over iCloud
    setGlobalPref("NSDocumentSaveNewDocumentsToCloud", false);
    // Include the titlebar for windows, always.
    setPref("universalaccess", "showWindowTitlebarIcons", true);
    // Always show scrollbars
    setGlobalPref("AppleShowScrollBars", "Always");
    // Toggle between light and dark more.
    setGlobalPref("AppleInterfaceStyleSwitchesAutomatically", true);
})();