import { setPref } from 'utils';

(() => {
    // Show icons for attachments always.
    setPref("mail", "DisableInlineAttachmentViewing", true);
    // Show email addresses as "foo@example.com" instead of "Foo <foo@example.com>".
    setPref("mail", "AddressesIncludeNameOnPasteboard", false);
})();