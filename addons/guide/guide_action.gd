class_name GUIDEAction
extends Resource

enum GUIDEActionValueType {
	BOOL,
	AXIS_1D,
	AXIS_2D,
	AXIS_3D
}

enum GUIDEActionState {
	TRIGGERED,
	ONGOING,
	COMPLETED
}

## The name of this action. Required when this action should be used as
## Godot action. Also displayed in the debugger.
@export var name:StringName

## The action value type.
@export var action_value_type: GUIDEActionValueType = GUIDEActionValueType.BOOL

@export_category("Godot Actions")
## If true, then this action will be emitted into Godot's 
## built-in action system. This can be helpful to interact with
## code using this system, like Godot's UI system. Actions
## will be emitted on trigger and completion (e.g. button down
## and button up).
@export var emit_as_godot_actions:bool = false

@export_category("Action Remapping")

## If true, players can remap this action. To be remappable, make sure
## that a name and the action type are properly set.
@export var is_remappable:bool

## The display name of the action shown to the player.
@export var display_name:String

## The display category of the action shown to the player.
@export var display_category:String

## Emitted every frame while the action is triggered.
signal triggered()

## Emitted when the action started evaluating.
signal started()

## Emitted every frame while the action is still evaluating.
signal ongoing()

## Emitted when the action finished evaluating.
signal completed()

## Emitted when the action was cancelled.
signal cancelled()

var _last_state:GUIDEActionState = GUIDEActionState.COMPLETED
var _value:Vector3 = Vector3.ZERO
var _value_bool:bool = false
var _value_axis2d:Vector2 = Vector2.ZERO

func _triggered(value:Vector3) -> void:
	_update_value(value)
	_last_state = GUIDEActionState.TRIGGERED
	triggered.emit()
	_emit_godot_action_maybe(true)
		
func _started(value:Vector3) -> void:
	_update_value(value)
	_last_state = GUIDEActionState.ONGOING
	started.emit()
	ongoing.emit()

func _ongoing(value:Vector3) -> void:
	_update_value(value)
	var was_triggered:bool = _last_state == GUIDEActionState.TRIGGERED
	_last_state = GUIDEActionState.ONGOING
	ongoing.emit()
	# if the action reverts from triggered to ongoing, this counts as 
	# releasing the action for the godot action system.
	if was_triggered:
		_emit_godot_action_maybe(false)
	

func _cancelled(value:Vector3) -> void:
	_update_value(value)
	_last_state = GUIDEActionState.COMPLETED
	cancelled.emit()
	completed.emit()

func _completed(value:Vector3) -> void:
	_update_value(value)
	_last_state = GUIDEActionState.COMPLETED
	completed.emit()
	_emit_godot_action_maybe(false)
		
func _emit_godot_action_maybe(pressed:bool) -> void:
	if not emit_as_godot_actions:
		return
		
	if name.is_empty():
		push_error("Cannot emit action into Godot's system because name is empty.")
		return
		
	var godot_action = InputEventAction.new()
	godot_action.action = name
	godot_action.strength = _value.x
	godot_action.pressed = pressed
	Input.parse_input_event(godot_action)

func _update_value(value:Vector3):
	_value_bool = abs(value.x) > 0
	_value_axis2d = Vector2(value.x, value.y)
	_value = value

## Returns whether the action is currently triggered. Can be used for a 
## polling style input 
func is_triggered() -> bool:
	return _last_state == GUIDEActionState.TRIGGERED
	
## Returns the value of this action as bool.
func get_value_bool() -> bool:
	return _value_bool 
	
## Returns the value of this action as axis 1d.
func get_value_axis_1d() -> float:
	return _value.x
	
## Returns the value of this action as axis 2d.
func get_value_axis_2d() -> Vector2:
	return _value_axis2d
	
## Returns the value of this action as axis 3d.
func get_value_axis_3d() -> Vector3:
	return _value
	



