# Console Port

## [3.0.0](https://github.com/seblindfors/ConsolePort/tree/3.0.0) (2025-08-05)
[Full Changelog](https://github.com/seblindfors/ConsolePort/compare/2.9.69...3.0.0) [Previous Releases](https://github.com/seblindfors/ConsolePort/releases)

- Update addon description  
- Merge pull request #141 from LeoQuote/configv2\_translation  
    Add Chinese translation for new text  
- Merge pull request #143 from seblindfors/configv2  
    Config and rings revamp  
- Update TOC version to 11.2  
- Enable keyboard on the Steam Deck template  
    The keyboard is no longer an obnoxious atrocity, so it's probably safe to have it enabled by default on Steam Decks, since the Steam keyboard is quite problematic to use in game.  
- Remove unused code  
- Remove help panel until actually implemented  
- Fix cvars not initialized when using custom settings on first setup  
- Fixes for 11.2, clean up and more UX fixes  
- Complete keyboard module  
- Tune autocorrect algorithm  
- Reimplement auto correct and controls  
- Minor keyboard fixes  
- Rework base keyboard  
- Finalize about panel  
- Add about panel with a touch of silly  
- Fix LAB assisted combat blowing up various buttons  
- Minor UX fixes  
- Fix utility ring data deprecation  
- Remove addon list module load hook  
    This was in retrospect a bad idea. It turns out that some users will toggle modules on/off one by one, when they really mean to toggle the main addon. This hook causes confusion, especially for those who are already less tech savvy proven by them not understanding addon dependencies.  
- Add default handlers for rings and action bar  
- Fix search losing focus after typing in loadout selector  
- Fix search organizing when multiple panels want to push elements  
- Add default handlers to guide panels  
- More minor fixes  
- rollback english text and update translation  
- Add translation for new text  
- Negate UpdateAssistedCombatRotationFrame  
- Minor fixes  
- Add support for action bars 13, 14 and 15 on Classic  
- Add fix for spline attempting to draw without points  
- Remove filigree template  
    I admit it, this was a failed experiment.  
- Remove deprecated config  
- Remove TOC creation from pkgmeta  
- Update TOC version format  
- Update splash layouts, add Nintendo Switch Pro  
- Finalize action bar module integration into config  
- Finalize rings integration into config  
- Embed rings config as panel  
- Move gamepad specific variables into gamepad mixin  
- Update descriptions for action bar types  
- Finalize controls guide  
- Fix cursor stack handler interacting with restricted regions  
- Revamp binding presets to be dynamically assembled  
    By splitting the device into blocks, different presets can be generated on a device basis depending on how the user's current modifiers and mouse emulations are set up.  
- Add new Deck and DS5 graphics, remove blueprints  
- Clean up the output from controls test  
- Remove GamePadAbbreviatedBindingReverse  
    This CVar has been removed from the game and no longer needs to be handled.  
- Add controller test suite to controls panel  
    - Refactor into separate files because I suspect the tester will be used in the Help section.  
    - Use standard solution to render settings so that more custom choices can be added.  
- Add smooth scroll frame template  
    Unlike the old version, this one doesn't suck on low FPS.  
- Remove obsolete templates  
- Add gamepad utility to retrieve connected device info  
- Add initial selections to controls panel  
- Start building controls panel  
- Add utility to wipe OnLoad code that only run once  
    When specializing a frame, either use CPAPI.Specialize (for shared mixins) or CPAPI.SpecializeOnce to consume the OnLoad script, reducing the addon footprint slightly.  
- Cleanup  
- Add garbage collection for on load handlers  
    A construct of executing code after data has loaded is present in many handlers across the addon. Many of these large functions only run once, so a utility has been added to remove these functions for garbage collection, and also force me to think about whether code needs to stick around when new handlers are created.  
- Use splines for graphics panel animations  
- Fix bug with device profiles not showing up due to new format  
- Fix issue with spline effect skipping iteration due to high FPS  
- Refactoring and device selection  
    - Remove metadata from device templates, since this can change without any of the preset things changing for a device. Only save the actual preset.  
    - Prepare all gamepad models for the new splash interface (lines/layout WIP)  
    - Add descriptions for all gamepads.  
    - Add device selection panel as part of intro tutorial.  
    - Fix minor bugs in the config panel.  
    - Fix minor cursor issues.  
- Clean up overview and optimize lines  
    Since lines are somewhat expensive to draw with the timers involved, change so that overview lines only animate when a change is detected.  
- Cleanup  
    - Add utility for using frame metatable index since it's a frequent construct  
- Add support for help plates to the interface cursor  
- Add proper modifier toggles to the overview panel  
- Handle niche cases in overview panel  
- Complete major overview panel functions  
- Merge branch 'master' into configv2  
- Prepare guide overview for loadout manipulation  
- Add lip to loadout selector to keep the target action in view  
- Fix potential bug with unit assignment in unit hotkeys  
- Update ConsolePort\_Rings.toc  
- Update Const.lua  
- Merge branch 'master' into configv2  
- Some cleanup  
- Merge branch 'master' into configv2  
- Add callback namespace  
- Implement drag swap bindings  
- Iterate on guide interface  
- Fix interface cursor executing special commands after moving  
- Add new icon textures to cover binding presets  
- Improve blocked combo removal  
    - Index blocked button combinations for use in clearing invalid bindings and retrieving accurate information of what a button does at any given moment.  
    - Iterate on guide panel to be screenshot friendly with toggled modifiers and indicators.  
- Refactor spline, add effects  
- Refine splines for Playstation 5  
- Add splash to guide panel  
- Merge branch 'master' into configv2  
- Start building guide panel  
- Optimize nudge controller anchoring  
- Refinement of edge cases  
- Add controller to nudge the interface cursor  
- Add LED color handling  
- Add slot editor for action bar  
    ....and a bunch of refactoring and minor improvements.  
- Ignore left list trackbar in config  
- Refactor interface cursor effects  
- Improvements to action bar handling  
- Cursor improvements  
    - Fix cancel click not working if parent panel has a close button  
    - Use V3 algorithm from ConsolePortNode  
    - Add hook to replace right click descriptors on items (WIP)  
- Add initial new action bar loadout manager  
- Add support for creating and using binding presets  
- Refactor settings data provider  
- Further iteration on config  
    - Add support for switching icons for bindings  
- Add binding widget  
- Add character bindings option  
- Merge branch 'master' into configv2  
- Add WIP interface for bindings  
- Hide rings config on escape  
- Update Model.xml  
- Add support for import/export  
    Import/export does need some work to match quality  
- Add support for picking device profile (WIP)  
- Update Search.lua  
- Update Data.lua  
- Add remaining features to cover functionality of old settings config  
- Implement settings search in new config  
- Refresh settings when new variables are added on module load  
- Fix nested utility ring not displaying shared sets  
- Add support for nested option lists and fix bugs  
- Further plumbing for new settings panel  
- Merge branch 'master' into configv2  
- Work on joint settings panel  
- Refactor and start work on main config  
- Refactor config specific templates out of main addon  
    The goal is to remove these templates entirely.  
- Add handling for switching between macrotext and macro ID on rings  
- Remove macrotext removal workaround for game menu  
- Add binding shortcuts to default utility ring set  
- Add support for special bindings on rings  
- Fix secure container not refreshing after removing or clearing a set  
- Add validation for deleted nested rings  
- Remove debug code  
- Finalize rings config with tutorials and options  
- Add animation system for automated frame behavior  
- Fix pet spell provider on Retail  
- Classic fixes  
- Finalize rings config functionally  
- Further iteration on rings  
- Add support for managing rings  
- Refactoring and QoL fixes  
- Add basic support for adding and removing abilities on rings  
- Make loadout collections robust against API failure  
- Further work on rings and refactoring  
- Update Secure.lua  
- Add validation helpers for spells  
- Add helpers to get ring data  
- Revise binding presets  
    The binding presets have largely been the same since CP1, but they have two major issues.  
    - A lot of systems in Retail WoW are designed around using action button 1-2 for things like vehicle quests and other doodads where you need to aim, which should be on the triggers or shoulders. Therefore the order of these bindings have been swapped so shoulders/triggers are mapped to ab 1/2.  
    - Stances are not intuitive to new players. Moving the basic d-pad bindings to the first action bar should help with this, even though they are objectively bad binding compared to XYAB with a modifier.  
    - Finally, this may encourage new players early to use their shoulders/triggers first and foremost, as most players tend to use XYAB first, which is a mistake. Automatic spell placement will place filler and builders on the shoulders/triggers with this change, encouraging better spell placement.  
- Update Events.lua  
- Start building config components, iterate rings manager  
- Refactoring, start implementing rings manager  
- Use interpolators for standard cursor scrolling  
- Add utility to load the config when necessary  
- Add support for automatic scrollbox scrolling (new scroll frames)  
- Refactor to prepare for config reconstruction  
- Refactor to avoid loading dependency  
- Add dev tools, start config replacement, cleanup  
- Refactoring and cleanup  
- Refactor nested ring display properties to mock ring  
    This will be used in the config.  
- Fix ring transitions when going from a low to a higher index on nested ring  
- Nested rings animations and bug fixes  
- Rings v3 base WIP  
    - Add support for nested rings  
    - Persistent sticky selection  
    - Allow both press and hold/toggle to use rings  
    - Improved validation process to eliminate blowouts  
- Refactor utility rings to new module  
- Clean up  
- Add utility to load submodule environment  
- Remove more schema tags in XML  
- Bootstrap new rings module  
- Remove schema tags in XML  
- Remove dependence on utility ring from main addon  
- Refactor constants out of API wrapper  
- Fix TW indentation  
- Refactor utils  
- Merge branch 'master' into configv2  
- Merge pull request #134 from seblindfors/master  
    Merge master to configv2  
- Refactor models and data providers  
- Merge pull request #132 from seblindfors/master  
    Merge master to configv2  
- Merge pull request #131 from seblindfors/master  
    Merge master to configv2  