class_name All_Enums
extends RefCounted

enum ONLINE_BACKUP_SETTINGS {
	CodebergToken,
	User_Name,
	Repository,
	File_Name
}

enum ITEM_TYPES {
	Helmet,
	Chestplate,
	Leggings,
	Boots,
	Weapon,
	Item

}

# Don't forget to update the Global script dude
enum GAME_STATES {
	MainMenu,
	DungeonSelectionMenu,
	DungeonPlaying,
	TaskManager,
	DeathMenu,
	PauseMenu,
	BackingUpOnlineData,

}

enum WEAPON_TYPES {
	Sword,
	None,
	
}

enum TASK_STATUS {
	ToDo,
	Completed,

}