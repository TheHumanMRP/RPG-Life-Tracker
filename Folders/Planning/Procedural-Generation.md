# Procedural Dungeon Generation

**Status:** Design specification\
**Version:** 1.0

## 1. Overview

The procedural dungeon generation system combines handcrafted room
templates with procedurally generated room placement and passages.

Rooms are authored manually and stored as resources. The generator
selects rooms, rotates and positions them, connects their doorways with
irregular passages, and assembles the result into the existing dungeon
data structure.

The intended dungeon experience focuses on exploration and combat. The
layout should be large, irregular, and difficult to predict. The player
should not be able to identify the main route simply by looking at the
dungeon.

The generator creates the dungeon's structure and tilemap. Enemy
placement, checkpoints, damage areas, loot, and other gameplay
population systems are outside the scope of the initial implementation.

## 2. Design Goals

-   Combine handcrafted rooms with procedural layout generation.
-   Generate one designated main progression path.
-   Generate additional branches from unused room doorways.
-   Make room placement irregular, with horizontal and vertical
    variation.
-   Rotate rooms in 90-degree increments to increase layout variety.
-   Connect rooms using winding, irregular passages rather than only
    straight corridors.
-   Allow passages to create traversal challenges, provided every
    required connection remains reachable.
-   Support configurable connections to existing rooms.
-   Avoid an arbitrary maximum dungeon world size.
-   Produce a `DungeonResource` compatible with the existing dungeon
    rendering system.

## 3. Existing Dungeon Data Structure

The generated dungeon must use the existing resource structure:

``` gdscript
class_name DungeonResource
extends Resource

@export var dungeon_name: String
@export var dungeon_tilemap: MapData
@export var checkpoints: Array[Vector2]
@export var damage_areas: Array[DamageAreaResource]
```

The map data stores the final tile layout and references the tile
definitions used to render it.

``` gdscript
class_name MapData
extends Resource

@export var tile_size: Vector2i
@export var map_width: int
@export var map_height: int
@export var map: Array[int]
@export var map_tiles: Dictionary[int, String]
```

The procedural generator must output a normal `DungeonResource`. The
rendering system should not need to know whether the dungeon was
authored manually or generated procedurally.

## 4. Room Resources

Rooms are created manually and stored as individual resources. The
generator assembles these resources; it does not generate room interiors
from scratch.

Each room defines:

-   Its dimensions.
-   Its tile data.
-   The positions of its doorways.

Room dimensions are not fixed globally. Each room resource defines its
own width and height.

A conceptual initial resource structure is:

``` gdscript
class_name DungeonRoomResource
extends Resource

@export var room_name: String
@export var map_width: int
@export var map_height: int
@export var map: Array[int]
@export var doorways: Array[Vector2i]
```

This structure is a starting point and may be refined during
implementation.

### 4.1 Doorways

A doorway is a possible connection point between a room and a passage.

-   A room can have any supported number of doorways.
-   Doorways are defined by positions on the room boundary.
-   Doorways are not permanently classified as entrances or exits.
-   Any available doorway may be used to connect the room to another
    room.
-   A doorway that is not used by the connection that placed the room
    becomes a candidate for further generation.

Starting and ending rooms are selected from rooms with exactly one
doorway.

### 4.2 Room Rotation

Rooms can be rotated by 0, 90, 180, or 270 degrees.

Rotation must update both:

-   The room's tile data.
-   The positions of all its doorways.

The generator should use rotation to increase layout variety without
requiring separately authored resources for every orientation.

Room rotation must preserve the room's dimensions correctly. For 90- and
270-degree rotations, the resulting width and height are exchanged.

## 5. Main Path Generation

The first generation stage creates the main progression route.

### 5.1 Starting and Ending Rooms

1.  Select a starting room with exactly one doorway.
2.  Select an ending room with exactly one doorway.
3.  Keep the selected ending room as the designated final destination.
4.  Generate approximately 15 rooms between the starting and ending
    rooms.

The starting and ending rooms are connected to the main route through
their single doorways.

### 5.2 Intermediate Room Placement

Intermediate rooms should be placed with irregular horizontal and
vertical variation.

The main route must not form a predictable straight line. Room positions
should vary in both axes, and passages should accommodate the resulting
distances and directions.

Room placement must account for:

-   The selected room's dimensions.
-   Its chosen rotation.
-   The doorway used for the incoming connection.
-   Existing room geometry.
-   The space needed to generate a valid passage.

Rooms may be placed close together. There is no required minimum
separation distance, but room geometry must not overlap in a way that
produces an invalid layout.

### 5.3 Main Path Metadata

The generator must retain which rooms belong to the main path.

This information is generation metadata. It is not exposed to the player
and should not be used to visually identify the main route.

Retaining this information will be useful later for boss placement,
progression logic, debugging, and other gameplay systems.

## 6. Passage Generation

Passages connect compatible room doorways.

Passages should resemble irregular underground cave tunnels in a 2D
environment rather than conventional straight, uniform corridors.

### 6.1 Passage Characteristics

Passages may include:

-   Irregular winding paths.
-   Horizontal and vertical movement.
-   Variable widths.
-   Narrow sections.
-   Gaps and jumps.
-   Different platform heights.
-   Descending sections.
-   Other traversal challenges supported by the game's movement system.

The generator may produce parkour-like challenges naturally through
passage geometry. A separate parkour-generation system is not required
for the initial implementation.

### 6.2 Reachability

Randomness must not create an impossible required connection.

Every passage connecting two rooms must be traversable from one doorway
to the other using the game's movement capabilities.

Passage generation must validate the connection before accepting it.

### 6.3 Passage Intersections

During the initial implementation, passages should not intentionally
reuse or intersect existing passages.

Avoiding passage intersections reduces the complexity of geometry
generation, tile merging, and connection validation.

Connecting a doorway to an existing room is a separate feature described
in Section 8. It does not imply that arbitrary passage intersections are
supported.

## 7. Side-Path Generation

After the main path has been generated, the generator processes every
unused doorway.

Side paths are not predetermined optional branches with a fixed
destination. They are generated by repeatedly attaching rooms to unused
doorways. Newly generated rooms may introduce further unused doorways,
which can produce additional branches.

### 7.1 Doorway Processing

Use a queue or another explicit worklist to track doorways that still
need processing.

For each doorway:

1.  Select one unprocessed doorway.
2.  Attempt to connect it to a newly generated room or, when enabled, an
    existing room.
3.  If a new room is placed, identify all of its unused doorways.
4.  Add those doorways to the worklist with their associated side-path
    depth.
5.  Continue until the worklist is empty.

Process doorways sequentially. A room's unused doorways are not
discarded merely because another doorway from that room has already been
processed.

Each doorway must be marked as processed, connected, or blocked so that
it cannot be processed repeatedly.

### 7.2 Side-Path Depth

Track the depth of each side path.

The first room generated from an unused doorway on a main-path room is
side-path depth 1. Each additional room generated farther along that
branch increases the depth by 1.

The intended maximum side-path length is six rooms.

At the maximum depth, the generator must terminate the branch. It must
not enqueue further room-generation work beyond that limit.

### 7.3 Single-Doorway Room Probability

As side-path depth increases, the probability of selecting a room with
exactly one doorway should increase. This encourages branches to
terminate progressively rather than growing indefinitely.

The intended probability bonus is:

    Side-path depth   Probability bonus
  ----------------- -------------------
                  1                  0%
                  2                  0%
                  3                  0%
                  4                +25%
                  5                +50%
                  6                +75%
       7 and beyond               +100%

The bonus is applied to a base probability that will be established
during implementation. The exact probability calculation and clamping
behavior must be defined in code.

The hard maximum depth remains authoritative regardless of the
probability result.

## 8. Connections to Existing Rooms

The generator should support an adjustable probability of connecting a
doorway to an already generated room instead of creating a new room.

This can create loops and shortcuts in the dungeon.

A configurable property is proposed:

``` gdscript
@export_range(0.0, 1.0)
var existing_room_connection_chance: float
```

When the probability check succeeds, the generator should:

1.  Find candidate existing rooms.
2.  Find an available doorway on a candidate room.
3.  Check whether the two doorways can be connected geometrically.
4.  Validate the proposed connection.
5.  Create the connection if valid.

If no valid existing-room connection is found, normal room generation
may be attempted.

This feature is planned, but its implementation can be deferred until
basic room placement, passage generation, and side-path generation are
working.

## 9. Placement Failure and Blocked Doorways

Room placement can fail because of occupied space, incompatible doorway
geometry, or an inability to create a valid passage.

Each doorway receives up to three placement attempts.

An attempt may select another room or try another rotation. The
generator should make a reasonable effort to find a valid placement
before abandoning the doorway.

If all three attempts fail:

-   Mark the doorway as blocked.
-   Place a dedicated blocking tile or texture over the doorway.
-   Do not leave the doorway visually open as though it were a valid
    passage.
-   Do not repeatedly retry the same doorway.

The blocking tile must be represented in the tile data used by the final
assembled dungeon.

A failed side-path placement should not invalidate the rest of the
generated dungeon.

## 10. Dungeon Size and Bounds

There is no predefined maximum world size or fixed dungeon width and
height.

The dungeon expands according to the positions and dimensions of its
generated rooms and passages.

After generation is complete, the assembler calculates the overall
bounds of all generated geometry. These bounds determine the final
`map_width`, `map_height`, and tile array size.

The implementation must still account for practical engine and memory
limits, but the design does not impose an arbitrary gameplay boundary.

## 11. Dungeon Assembly

Once room placement, passage generation, and connection processing are
complete, the generator combines all generated geometry into the final
map.

### 11.1 Assembly Responsibilities

1.  Calculate the complete dungeon bounding rectangle.
2.  Allocate the final tile array.
3.  Copy each room's tile data into its final position.
4.  Copy passage tile data into the same map.
5.  Place blocking tiles at failed connections.
6.  Produce the final `MapData`.
7.  Package the result into a `DungeonResource`.

The assembler must account for the final offsets of all rooms and
passages when copying their tile data into the map.

The final map must use the tile IDs and tile definitions expected by the
existing dungeon rendering system.

### 11.2 Output Compatibility

The generated `DungeonResource` must be usable by the existing dungeon
loading and rendering workflow.

The renderer should not need separate logic for procedural dungeons.

The initial implementation does not generate or populate:

-   Enemies.
-   Boss encounters.
-   Checkpoints.
-   Damage areas.
-   Loot.
-   Other gameplay objects.

These systems will be considered after the main tilemap generation
pipeline is working.

## 12. Generation Metadata

The generator should retain useful structural information while
generating the dungeon.

At minimum, retain enough information to identify:

-   Which rooms belong to the main path.
-   Which rooms belong to side paths.
-   Each side room's depth.
-   Which doorways are available.
-   Which doorways have been connected.
-   Which doorways have been blocked.
-   Which rooms are connected to one another.
-   Which room is the starting room.
-   Which room is the ending room.

This metadata should remain separate from the final tile array where
practical.

It will be useful for debugging, validating connectivity, and
implementing later gameplay systems.

## 13. Proposed System Responsibilities

The implementation may use separate classes or functions for the
following responsibilities. The exact class boundaries should be decided
while coding.

  -----------------------------------------------------------------------
  Responsibility                      Purpose
  ----------------------------------- -----------------------------------
  Room database                       Stores and provides available room
                                      resources.

  Main path generation                Selects and positions the starting
                                      room, intermediate rooms, and
                                      ending room.

  Room placement                      Handles room positioning, rotation,
                                      and overlap checks.

  Passage generation                  Generates and validates irregular
                                      connections between doorways.

  Side-path generation                Processes unused doorways and
                                      generates additional rooms.

  Dungeon assembly                    Combines room and passage data into
                                      the final `MapData`.
  -----------------------------------------------------------------------

These are logical responsibilities, not a requirement to create one
script per responsibility.

## 14. Implementation Order

Implementation should proceed in the following order:

### Phase 1: Room Resource System

-   Define the room resource.
-   Store room dimensions and tile data.
-   Define doorway positions.
-   Implement room rotation.
-   Verify that rotated tile data and doorway positions remain aligned.

### Phase 2: Main Path Generation

-   Select starting and ending rooms.
-   Generate approximately 15 intermediate rooms.
-   Calculate irregular room positions.
-   Connect consecutive rooms.

### Phase 3: Passage Generation

-   Generate winding passages.
-   Support variable passage widths.
-   Generate traversal challenges where supported.
-   Validate passage connectivity and reachability.

### Phase 4: Side-Path Generation

-   Implement the doorway worklist.
-   Generate rooms from unused doorways.
-   Track side-path depth.
-   Implement the depth-based single-doorway-room probability.
-   Implement the three-attempt placement limit.
-   Implement blocked-doorway tiles.

### Phase 5: Advanced Connections

-   Add the existing-room connection probability.
-   Search for compatible existing room doorways.
-   Validate loops and shortcuts.
-   Ensure all accepted connections are traversable.

### Phase 6: Dungeon Assembly

-   Calculate final dungeon bounds.
-   Merge room tile data.
-   Merge passage tile data.
-   Place blocking tiles.
-   Generate the final `MapData`.
-   Produce a compatible `DungeonResource`.
-   Test the generated map in the existing renderer.

## 15. Initial Implementation Scope

The first complete working version should:

-   Load premade room resources.
-   Rotate rooms.
-   Generate the main path.
-   Place rooms irregularly.
-   Generate winding passages.
-   Generate side paths from unused doorways.
-   Enforce side-path depth limits.
-   Handle failed placement attempts.
-   Block doorways when placement fails.
-   Assemble all geometry into the final `MapData`.
-   Produce a playable dungeon using the existing rendering system.

Enemy placement, bosses, loot, checkpoints, and damage areas are
intentionally postponed until the main tilemap generation system is
complete.

## 16. Core Requirements

The following requirements should guide implementation decisions:

1.  Rooms are handcrafted resources; the generator assembles them.
2.  Room dimensions and doorway positions are defined by each room.
3.  Rooms can be rotated in 90-degree increments.
4.  The main route contains a starting room, approximately 15
    intermediate rooms, and an ending room.
5.  Room placement must be irregular in both horizontal and vertical
    directions.
6.  Passages should be winding and cave-like rather than uniformly
    straight.
7.  Every required room connection must be reachable.
8.  Unused doorways generate side paths.
9.  Side paths may branch further through additional unused doorways.
10. Side-path depth increases the probability of selecting a
    single-doorway room.
11. Side paths have a hard maximum length of six rooms.
12. Existing-room connections and loops are supported as a planned
    configurable feature.
13. Each failed doorway placement receives up to three attempts.
14. A doorway that cannot be connected is visibly blocked.
15. There is no arbitrary maximum dungeon world size.
16. The final output is a standard `DungeonResource`.
17. Enemy, boss, checkpoint, damage-area, and loot generation are
    deferred.

The intended result is a large, irregular, exploration-focused dungeon
assembled from handcrafted rooms and procedurally generated passages.
The main progression route is known to the generator but concealed from
the player, making every unexplored doorway a possible route toward the
final encounter.
