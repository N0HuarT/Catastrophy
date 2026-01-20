# PlayerActions.gd
extends Resource
class_name PlayerActions

enum ActionType {
	IDLE,
	MOVE,
	JUMP,
	ATTACK,
	SPECIAL,
	UTILITY,
	RELOAD,
	SPELL1,
	SPELL2,
	POT,
	INTERACT,
	STUNNED,
}
static var action_priority := {
	ActionType.STUNNED: 80,
	ActionType.UTILITY: 70,
	ActionType.JUMP: 60,
	ActionType.ATTACK: 50,
	ActionType.SPECIAL: 40,
	ActionType.SPELL1: 30,
	ActionType.SPELL2: 30,
	ActionType.RELOAD: 20,
	ActionType.MOVE: 10,
	ActionType.IDLE: 0
}
