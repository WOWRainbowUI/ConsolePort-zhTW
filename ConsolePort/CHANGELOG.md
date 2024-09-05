# Console Port

## [2.9.23](https://github.com/seblindfors/ConsolePort/tree/2.9.23) (2024-09-05)
[Full Changelog](https://github.com/seblindfors/ConsolePort/compare/2.9.22...2.9.23) [Previous Releases](https://github.com/seblindfors/ConsolePort/releases)

- Update ConsolePort.toc  
- Add option to disable cursor algorithm optimization  
    This is added in response to one bag addons where items are sorted based on their item category, which causes the interface cursor to skip items because it's looking for items with the same parent first (i.e. the items it chooses are all in the same equipped bag).  
- Fix API error when zone spell is added to utility ring  
- Fix erroneous spell name on bonus action bars in config  
- Fix slash handler on Retail  
