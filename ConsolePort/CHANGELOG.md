# Console Port

## [2.9.43](https://github.com/seblindfors/ConsolePort/tree/2.9.43) (2024-12-22)
[Full Changelog](https://github.com/seblindfors/ConsolePort/compare/2.9.42...2.9.43) [Previous Releases](https://github.com/seblindfors/ConsolePort/releases)

- Update TOC  
- Move locale  
- Remove feature to disable modules when disabled in addon list  
    This is a good idea on paper, to tie the feature of the module into the addon list, but it failed to take an important thing into account; players will often disable all modules belonging to an addon individually when trying to turn the main module off. This lead to many complaints about the interface cursor not working because they wanted to toggle the main addon off to play kb/m, but ticked off every module in the list to do so.  
- Add tools to use custom atlas textures with nine slice support  
- Add preparation for locale support  
    - Move long enUS strings into the the locale file  
    - Fix issue with translation loading order  
    - Add locale debugging  
