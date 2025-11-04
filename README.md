# Assignment 7

## Widget Tree
- A Flutter UI is a tree of widgets. Each widget can have children, which can have their own children, and so on.
- Parents pass configuration down to children via constructor params and inherited data (e.g., theme, MediaQuery).
- Children report their size/layout needs up to parents; parents decide where/how to place them.
- Example: MaterialApp -> HomePage -> Scaffold -> Column -> [AppBar, Padding, ElevatedButton, ...].

## Widgets used in this project (from lib/main.dart)
1. MaterialApp: Top-level Material design app container; sets title, theme, routing, and home.
2. ThemeData: Holds app-wide colors, typography, etc. Provided to descendants via Theme.of(context).
3. HomePage (StatelessWidget): Your custom screen widget.
4. Scaffold: Provides page structure: app bar, body, floating buttons, snackbars, etc.
5. AppBar: The top application bar showing the page title.
6. Padding: Adds space around its child (EdgeInsets.all(16) here).
7. Column: Lays out children vertically.
8. ElevatedButton.icon: A button with an icon and text.
9. Icon: Shows a Material icon (e.g., Icons.list_alt).
10. Text: Renders text labels and content.
11. SizedBox: Adds fixed spacing (e.g., height: 12).
12. SnackBar: Temporary message bar for feedback.
13. ScaffoldMessenger: Shows SnackBar within the current Scaffold context.
14. MyHomePage (StatefulWidget) and its _MyHomePageState: Example counter screen (not used as home).
15. Center: Centers its child.
16. FloatingActionButton: Circular button floating above content.

## What does MaterialApp do, and why as root?
1. MaterialApp sets up Material design defaults (themes, fonts, localization), routing, navigation, and text direction.
2. It inserts inherited widgets that many descendants rely on (Theme, Navigator, MediaQuery).
3. Using it as the root ensures the whole app gets consistent Material behavior and can navigate between pages.

## StatelessWidget vs StatefulWidget
1. StatelessWidget: Immutable; renders purely from inputs. Use when UI doesn’t change over time (e.g., static pages, buttons with callbacks).
2. StatefulWidget: Holds mutable state inside a State object and can call setState to rebuild. Use for counters, form inputs, async data loading, animations.
3. HomePage is StatelessWidget (no internal state). MyHomePage is StatefulWidget (has _counter and setState).

## What is BuildContext and why is it important?
- BuildCOntext is a handle to a widgets location in the widget tree.
- It lets you:
    1. Access inherited data.
    2. Navigate or show UI elements tied to the current page.
    3. Build child widgets with proper theming and localization.
- In build(BuildContext context), i use context to fetch theme (Theme.of(context)) and to show snackbars via ScaffoldMessenger.of(context).

## Hot reload vs Hot restart
a. Hot Reload: Injects updated source code into the running Dart VM, preserves state, and rebuilds widgets. Fast, ideal for UI tweaks. Counter values, current screen, etc., remain.
b. Hot Restart: Fully restarts the app, clears state, re-runs main(). Slower, but ensures a clean state (useful when changes affect global state/initialization).