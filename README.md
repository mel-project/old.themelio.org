## Localization

Localization is done through `l10n.rkt`, which provides a `(current-language)` parameter that defaults to `en-US`. It also imports, through a CSV file, a big mapping of localized strings that's essentially a hashtable from strings to strings. This hashtable can be queried with the `(l10n ..)` function.
