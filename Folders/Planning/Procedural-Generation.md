# Procedural Dungeon Generation — Design Documentation v1.0



Design finalized

Implementation pending



## 1. Core concept

The dungeon generation system will combine handcrafted room templates with procedurally generated connections and placements.

Rather than generating individual rooms from scratch, the generator selects premade rooms, rotates them, positions them, and connects their doorways using procedurally generated passages.

The result should be a large, irregular dungeon that encourages exploration and combat.

The player should never know which path leads to the boss. Every unexplored doorway should feel like a potential continuation of the dungeon.

### Design principles

- Exploration over linear progression.
- Combat-focused encounters.
- Irregular room placement without recognizable patterns.
- Handcrafted room geometry.
- Procedurally generated passages.
- Randomized room rotation.
- Potentially enormous dungeons.
- No arbitrary dungeon world-size limit.

## 2. Room resources

Rooms will be manually created and stored as individual resources.

Each room defines its own dimensions, tile data, and doorways.

### Proposed resource structure

```
class_name DungeonRoomResource
extends Resource

@export var room_name: String

@export var map_width: int
@export var map_height: int
@export var map: Array[int]

@export var doorways: Array[Vector2i]
```

This is a conceptual starting structure. We can refine it when implementing room storage.

### Room doorways

A doorway represents a possible connection point between a room and a passage.

Important characteristics:

- Rooms can have different numbers of doorways.
- Doorways can be positioned anywhere along the room's boundaries.
- Doorways are not permanently designated as entrances or exits.
- Any doorway can be used for generation or progression.
- Room dimensions are defined individually in their resources.

### Room rotation

Rooms can be rotated in 90-degree increments.

Possible rotations:

- 0°
- 90°
- 180°
- 270°

Rotation must affect both room tile data and doorway positions.

This prevents repetitive room orientations and increases the number of possible dungeon configurations without requiring multiple manually created versions of the same room.

## 3. Main path generation

The first generation stage creates the dungeon's main progression route.

### Generation process

1. Select a random starting room with exactly one doorway.
2. Select a random ending room with exactly one doorway.
3. Generate approximately 15 rooms between them.
4. Randomly position rooms with significant horizontal and vertical variation.
5. Connect consecutive rooms using procedurally generated passages.
6. Ensure every connection is traversable.

[GitHub - OndrejNepozitek/Edgar-DotNet: Configurable procedural layout generator](https://images.openai.com/static-rsc-4/_d_Bm8baPXA8sLcC5xbmf0TRjiAEYI3DjmTYE32jvcuaZptt3wnWy_1h6fix7UfOcOWuXfXhMnARC3M90GVPVPvE2edFPd-1-WPPfzteWqNClxjqPWzt2Cz10K66X9qfl9-i0SxqlqOqj3kWAfFes2FourVzU4hqbCvzWznRMXw?purpose=inline)

[RogueLike地牢生成算法Unity实现 - SPIDER的陌生人 - 博客园](https://images.openai.com/static-rsc-4/Fc0mbbZdninIxId8kf0l3K53uXNj2YAm0ewcfVWN-nUqr3nBLYZ5kA0ifKx_49c9TooLSvbFRVQKjvf7vQc5xtej3nYnWo_I3HbYG8EMA55gm41mKxh7h74Xsris0txn5bubweeqWBf-YIAi8GFrC8BkyL5PFC9QlFR7RfvmCZk?purpose=inline)

[LoBit old school tileset (core) by Helicity](https://images.openai.com/static-rsc-4/63exx4aaOYGoi1B-yC28SsLPSQjp3ksacAIMx_0B2CabTTu63eXdnpS6PaWCXyKsMVP-9Kj9-Vzndjrpflrx4NQaeGppucP16fBDRrcDCMvx9WNIeaZPQgnuFBdPxCNZLzai1iE6JuOy0ZHdFnQhXmm4l0Hz17CEyMd25aOa9aM?purpose=inline)

10

The main path should not resemble a straight line.

Room positioning should be unpredictable, allowing the route to move up, down, left, and right.

The ending room represents the boss destination.

Important: The generator internally knows which rooms belong to the main path, but the player receives no indication of this.

## 4. Passage generation

Passages connect room doorways.

Unlike traditional rectangular corridors, passages should resemble irregular underground cave systems.

[AI Game Map Generator for RPG, Roguelike & Strategy Games](https://images.openai.com/static-rsc-4/lMZX-LT7W6rR9dl22mIBDQxpqUlngCfXmEtm14LdM1CLSVv1GiocaX-u_o2g6-cj34vN5ZsCOeCSr4Lx1jwRi-SI9cMsITKxGfjfUyvX9DC7Z2HJbe__0VFF-zvQYkGZ46h79FO79I6Q80tTY0KCyWAkjvSW6-nldvxVY6CFSfs?purpose=inline)

[Cave Construction Sample by Madcowchef | Fantasy map, Dungeon maps, Tabletop rpg maps](https://images.openai.com/static-rsc-4/UsifHZFlRMYYn8MoQmjGtdLkS7d-nBFubBIh2BeTBv2Aax0jghwvkgdMFO3DbIWzQWxRjDTNfwkUXLvYGG7XMq6w3m_d3B1cWdCNevCTGZtoEhrhWhX9PjslUfXH1kn6_NJdmB93RHLiR68oRD3Q4xTnAzp6CNA4jJ2pnu48qDc?purpose=inline)

[Andor's Trail Interactive map \[0.7.0\] | blackwater_mountain38](https://images.openai.com/static-rsc-4/eYEsUx9dXwviWi_dtVb83ziW85H1lelLOAA_b-fGSmJPpiKHY9SBABQLe6vmIfV6M77gOWGZscNtFXEdvY3CdC0stnKASa_SUFuehImBA5lgQjP_m49NqaB3gqH72lVNsPjzBFC98pa5J_FeeuOKaNH7nMTPHEvvVGkl3RITZGE?purpose=inline)

9

### Passage characteristics

- Irregular shapes.
- Random horizontal and vertical movement.
- Variable passage widths.
- Occasional narrow sections.
- Potential parkour challenges.
- Vertical variation where possible.
- Traversable connections between rooms.

### Parkour

The generator does not need a dedicated parkour-generation system initially.

Instead, irregular passage generation should naturally produce interesting traversal challenges.

Possible outcomes include:

- Gaps requiring jumps.
- Different platform heights.
- Narrow platforms.
- Descending sections.
- Difficult but reachable terrain.

Critical requirement: Randomness must never produce an impossible connection.

### Passage intersections

Passages will not intentionally intersect or reuse existing passages during the initial implementation.

This avoids the additional complexity of handling overlapping passage geometry.

## 5. Side-path generation

After the main path is complete, the generator processes every unused doorway.

This is where the dungeon becomes a network of exploration paths.

### Generation algorithm

Initialize doorway queue

Collect all unused doorways from main-path rooms.

Select next doorway

Remove one doorway from the queue.

Generate connected room

Select, rotate, position and connect a compatible room.

Collect new doorways

Add every unused doorway from the newly generated room to the queue.

Repeat

Continue until all doorways have been processed.

### Side-path termination probability

As side paths become longer, the probability of generating a room with exactly one doorway increases.

| Side-path depth | Probability bonus |
| --------------- | ----------------- |
| 1               | 0%                |
| 2               | 0%                |
| 3               | 0%                |
| 4               | +25%              |
| 5               | +50%              |
| 6               | +75%              |
| 7               | +100%             |

The intended maximum side-path length is six rooms.

At the maximum depth, the generator must terminate the branch rather than create additional rooms.

The percentages represent an increasing probability bonus. The base probability and exact probability calculation will be established during implementation.

### Branch behavior

- Every unused doorway can produce another side path.
- Side rooms can generate additional side rooms.
- Side paths can have multiple branches.
- Side paths terminate naturally through single-doorway rooms.
- All generated branches must remain traversable.

## 6. Connecting to existing rooms

Configurable feature

The generator should support the possibility of connecting a doorway to an already existing room instead of generating a new room.

This can produce loops and shortcuts.

Introduce a configurable probability:

```
@export_range(0.0, 1.0)
var existing_room_connection_chance: float
```

When the probability check succeeds:

1. Search for a compatible existing room.
2. Check whether it has an available doorway.
3. Verify that the connection is geometrically valid.
4. Connect the two rooms.

Otherwise, generate a new room.

This feature is planned, but its exact implementation can be deferred until the basic generation system works.

## 7. Room placement and failed connections

Room placement must account for:

- Room dimensions.
- Room rotation.
- Doorway position.
- Passage geometry.
- Existing room occupancy.
- Traversability.

### Placement attempts

Each doorway gets up to three placement attempts.

Each attempt can select another room or try another rotation.

Placement failure handling

1. Attempt room placement.
2. If unsuccessful, try another room or rotation.
3. Repeat up to three attempts.
4. If all attempts fail, block the doorway.

Blocking texture

A dedicated blocking texture will be included in the tile system and placed over doorways where room generation fails.

The generator should not silently leave failed connections open.

### Room spacing

Rooms can be extremely close to one another.

There is no requirement for a fixed minimum separation distance.

However, their actual geometry must not overlap in a way that creates invalid room layouts.

## 8. Dungeon boundaries

There will be no predefined maximum dungeon dimensions.

The dungeon should expand according to its generated room and passage positions.

Its final dimensions will be calculated from the generated layout.

The assembler will eventually determine the required `map_width`, `map_height`, and tile array size.

## 9. Final dungeon assembly

Once room placement, passage generation, and connections are complete, everything must be combined into your existing dungeon data structure.

Your current architecture:

```
DungeonResource
│
├── dungeon_name
│
├── dungeon_tilemap: MapData
│   ├── tile_size
│   ├── map_width
│   ├── map_height
│   ├── map
│   └── map_tiles
│
├── checkpoints
│
└── damage_areas
```

The generated dungeon should produce a normal `DungeonResource`.

The generation system must not require changes to your existing dungeon rendering system.

### Assembly responsibilities

1. Calculate the complete dungeon bounding rectangle.
2. Allocate the final tile array.
3. Copy room tile data into the appropriate positions.
4. Copy passage tile data.
5. Place blocking textures where necessary.
6. Produce the final `MapData`.
7. Package the result into `DungeonResource`.

Enemy placement, checkpoint generation, and damage-area generation are deliberately excluded from the initial implementation.

## 10. Proposed implementation roadmap

The implementation will be divided into independent milestones.

Implementation progress

# 0/24

Phase 1 — Room resource system

Define DungeonRoomResource

Store room dimensions and tile data

Define doorway positions

Implement room rotation

Phase 2 — Main path generation

Select starting and ending rooms

Generate approximately 15 intermediate rooms

Calculate irregular room positions

Connect rooms with passages

Phase 3 — Passage generation

Generate winding passages

Support variable passage widths

Generate vertical traversal challenges

Validate passage connectivity

Phase 4 — Side-path generation

Implement doorway queue

Generate side rooms

Implement depth-based termination probability

Implement failed-placement blocking

Phase 5 — Advanced connections

Add existing-room connection probability

Support loops and shortcuts

Validate all connections

Phase 6 — Dungeon assembly

Calculate dungeon bounds

Merge room tile data

Merge passage tile data

Generate final MapData

Produce DungeonResource

## 11. Important architectural principles

These are the rules I'd preserve throughout development:

1. Rooms are handcrafted. The generator assembles them rather than inventing their geometry.
2. Room placement is independent of room rendering.
3. Doorways drive generation. Unused doorways are the source of new branches.
4. The main path is hidden from the player.
5. Randomness must preserve reachability.
6. Dungeon size is unrestricted by an arbitrary configured boundary.
7. Generation metadata should be retained. Room connections, main-path membership, and side-path depth will be useful later.
8. The generator produces the same `DungeonResource` format as manually designed dungeons.

## 12. Scope of the first implementation

Initial target

The first working version should accomplish only this:

- Load premade room resources.
- Rotate rooms.
- Generate the main path.
- Generate irregular connecting passages.
- Generate side paths.
- Handle failed placements.
- Assemble the final `MapData`.
- Render the generated dungeon.

No enemies, bosses, loot, checkpoints, or damage areas yet.

The ultimate goal: Give the generator a collection of handcrafted rooms and a random seed, and have it produce a large, unpredictable, interconnected dungeon that is fully traversable and ready to play.

That's the specification we'll use as our foundation.