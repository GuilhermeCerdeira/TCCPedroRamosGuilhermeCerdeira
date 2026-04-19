extends GutTest

var controller

func before_each():
	controller = MainMenuController.new()
	
	controller.name_input = LineEdit.new()
	controller.warning_name = Label.new()
	controller.warning_name.visible = false
	
	add_child(controller)
	controller.add_child(controller.name_input)
	controller.add_child(controller.warning_name)

func after_each():
	controller.free()

func test_save_name_valid():
	controller.name_input.text = "Pedro"

	var result = controller.save_name_autoload_data()

	assert_true(result)
	assert_eq(AutoloadData.player_name, "Pedro")
	assert_false(controller.warning_name.visible)

func test_save_name_empty():
	controller.name_input.text = ""

	var result = controller.save_name_autoload_data()

	assert_false(result)
	assert_true(controller.warning_name.visible)

func test_ready_loads_player_name():
	AutoloadData.player_name = "Guilherme"

	controller._ready()

	assert_eq(controller.name_input.text, "Guilherme")
