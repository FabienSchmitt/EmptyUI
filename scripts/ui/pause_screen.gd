@tool
extends Control

@export_range(0, 1.0) var menu_opened_amount := 0.0:
	set = set_menu_opened_amount

@onready var _blur_color_rect : ColorRect = %BlurColorRect
@onready var _ui_panel_container: PanelContainer = %UIPanelContainer


func set_menu_opened_amount(amount: float) -> void:
	if _ui_panel_container == null || _blur_color_rect == null: 
		return
		
	menu_opened_amount = amount
	visible = amount > 0.0
	
	# change shader properties
	var blur = lerp(0.0, 1.5, amount)
	_blur_color_rect.material.set_shader_parameter("blur_amount", blur)
	var saturation =  lerp(1.0, 0.3, amount)
	_blur_color_rect.material.set_shader_parameter("saturation", saturation)
	var tint_strength = lerp(0.0, 0.2, amount)
	_blur_color_rect.material.set_shader_parameter("tint_strength", tint_strength)
	
	# handle transparency
	_ui_panel_container.modulate.a = amount
