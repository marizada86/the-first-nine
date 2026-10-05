# The First Nine

A Godot 4 vertical slice about Nolf and the Thalestriel caravan. The wagon carries family relics; no survivor is left behind. The current prototype includes the cave-camp opening shell, day/night survival, first boss and Mark I, checkpoints, the on-foot Stonehook corridor, Scree Crawler and Cliff Harrier, and approved visual stages at Marks III, V and VII.

## Controls

- Move: A / D, arrows, left stick or directional pad.
- Jump: Space or controller bottom face button.
- Attack: left mouse button, J or controller left face button.
- Collect or interact: E or controller top face button.
- Dash: Shift or right trigger. Right-mouse parry is deferred.
- Nolf inventory: I.
- Wagon management: M near the wagon, or controller Back / Select.
- Camp action: F or left shoulder button.
- First Thread: C or controller right face button, after Mark I.
- Skip opening shell: Escape or controller Start.
- Playtester: F4 in debug builds; change Mark or advance to day/night, then restore the previous session state.

All ally management is accessed through the wagon menu. Saves are currently in memory, not on disk.

## Approved work not yet implemented

The B-09 package contains accepted comic panels, cave environments and resting patient sprites under `.atena/generated/2026-10-05-b09-opening-art-production/`. These are offline assets, not runtime admission. The revised opening comics, separate cave/tutorial map, individual treatment, night invasions and later journey changes still require their bounded gameplay implementation. The complete Mark IX shadow-spider runtime is not implemented.

Open `project.godot` in Godot to play. Local Windows validation uses `D:/Godot/godot.exe`. Current integration evidence is `.atena/evidence/2026-10-05-main-integration.md`.
