# Console Port

## [2.7.19](https://github.com/seblindfors/ConsolePort/tree/2.7.19) (2024-01-08)
[Full Changelog](https://github.com/seblindfors/ConsolePort/compare/2.7.18...2.7.19) [Previous Releases](https://github.com/seblindfors/ConsolePort/releases)

- Add interface cursor scrolling to modern scroll containers  
    The switch to scroll containers on Retail instead of using the ScrollFrame widget type has led to broken scrolling in most of the UI (except for edit mode which still uses a ScrollFrame for reasons unknown). This addition should make scrolling work again, but at the risk of spreading taint.  
    - Also added textures to indicate scrolling is available, since this isn't intuitive to all people.  
- Add priority to the tooltip on group loot frames  
    Hopefully this should minimize accidental need/greed/pass on group loot rolls.  
- Switch to use metatable for interface cursor scans  
    This change is to prevent overridden methods on frames found recursively from disturbing the vector calculations necessary for the interface cursor to make decisions.  
- Refactor secure UI controller since it's the only UI controller left in the base addon  
- Add a somewhat working automatic move when a unit expires  
- Clean up raid cursor casting info  
- Fix bug where blocker appears with gamepad cursor in use  
