# Console Port

## [2.9.41](https://github.com/seblindfors/ConsolePort/tree/2.9.41) (2024-12-10)
[Full Changelog](https://github.com/seblindfors/ConsolePort/compare/2.9.40...2.9.41) [Previous Releases](https://github.com/seblindfors/ConsolePort/releases)

- Improve spell menu visuals when using stances and forms  
    - Highlight which bar is active at the time when the spell menu becomes visible  
    - Default the cursor onto empty slots on the current action page rather than a free slot in general, fallback to the general case  
- Improve extra intuitive ring trigger bindings  
    This is hard to explain, but in some cases when the player opens a ring, they will be holding some amalgamation of modifiers, and then they might release one or two of them (or keep holding them) and the mounted trigger bindings do not fire because they are combined with modifiers. This should help with the "intuition" of using the rings.  
