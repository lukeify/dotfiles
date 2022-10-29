import { setPref, setGlobalPref } from './utils';

(async () => {
    setPref("safari", "ShowFullURLInSmartSearchField", true);
    setPref("safari", "IncludeDevelopMenu", true);
    setPref("safari", "IncludeInternalDebugMenu", true);
    setGlobalPref("WebKitDeveloperExtras", true);
})();