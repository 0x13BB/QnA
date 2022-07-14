extends Node2D



const SQlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_path = "res://QnA_data"
var a_array = [["a",0], ["a",0], ["a",0], ["a",0]]
var a_array1 = [["a",0], ["a",0], ["a",0], ["a",0]]


func _ready():
	db = SQlite.new()
	db.path = db_path

	
	db.open_db()
	
	db.query("SELECT max(id) from questions")
	GlobVar.max_id = int(str(db.query_result).split(":")[1].split("}")[0])
	
	
	

	
	
	
	get_node("Button1").connect("pressed", self, "_button1_pressed")
	get_node("Button2").connect("pressed", self, "_button2_pressed")
	get_node("Button3").connect("pressed", self, "_button3_pressed")
	get_node("Button4").connect("pressed", self, "_button4_pressed")
	text_updater()
	#var butt = local_button.new(get_node("Button1"))
	
func text_updater():
	
	get_node("Label").text = str(readQuestionFromDB(GlobVar.id)).split(":")[1].split("}")[0]
	get_node("Label2").text = str(GlobVar.counter)
	get_node("Label3").text = str(GlobVar.health)
	
	for i in 4:
		a_array[i][0] = str(readAnswerFromDB(GlobVar.id)[i]).split(":")[1].split("}")[0]
		if i == 0:
			a_array[i][1] = 1
	
	var temp_arr = [0,1,2,3]

	var temp2_arr = []
	temp_arr.shuffle()
	
	print(temp_arr)
	print(temp2_arr)
	for x in 4:
		temp2_arr.append(a_array[temp_arr[x]])
		
	a_array1 = temp2_arr
	
	print(a_array1)
	get_node("Button1").text = temp2_arr[0][0]
	get_node("Button2").text = temp2_arr[1][0]
	get_node("Button3").text = temp2_arr[2][0]
	get_node("Button4").text = temp2_arr[3][0]
	#get_node("Button4").text = str(readAnswerFromDB(NumberOfQuestion.id)[3]).split(":")[1].split("}")[0]
	#get_node("Button4").
	
func _button1_pressed():
	if a_array1[0][1] == 1:
		succ_answ()
		print("+")
	else:
		GlobVar.health -=1
		print("-")
		if GlobVar.health == 0:
			game_over()
	next_question()
	
func _button2_pressed():
	if a_array1[1][1] == 1:
		succ_answ()
		print("+")
	else:
		GlobVar.health -=1
		print("-")
		if GlobVar.health == 0:
			game_over()
	next_question()

func _button3_pressed():
	if a_array1[2][1] == 1:
		succ_answ()
		print("+")
	else:
		GlobVar.health -=1
		print("-")
		if GlobVar.health == 0:
			game_over()
	next_question()

func _button4_pressed():
	if a_array1[3][1] == 1:
		succ_answ()
		print("+")
	else:
		GlobVar.health -=1
		print("-")
		if GlobVar.health == 0:
			game_over()
	next_question()
	
func next_question():
	if GlobVar.id < GlobVar.max_id:
		GlobVar.id+=1
		text_updater()
		
	else:
		victory()
	
	
func victory():
	print("you win")
	get_parent().get_node("start").set_visible(true)
	get_parent().get_node("exit").set_visible(true)
	get_parent().get_node("Game").set_visible(false)
	set_to_default()
	

func game_over():
	print("game over")
	get_parent().get_node("start").set_visible(true)
	get_parent().get_node("exit").set_visible(true)
	get_parent().get_node("Game").set_visible(false)
	set_to_default()
	
func succ_answ():
	GlobVar.counter +=1
	get_node("Label").text = str(GlobVar.counter)
	#get_node("Label").text = GlobVar.counter
	
func set_to_default():
	GlobVar.id = 0
	GlobVar.health = 3
	GlobVar.counter = 0
	

func readQuestionFromDB(id):
	var array = [""]
	
	#db.open_db()
	
	db.query("SELECT question FROM questions WHERE id = " + str(id))

	array.append(db.query_result)
	#db.close_db()
	return array

func readAnswerFromDB(id):
	var array = []
	
	#db.open_db()
	
	db.query("SELECT answer FROM answers WHERE id_question =" + str(id))

	array.append_array(db.query_result_by_reference)
	#db.close_db()
	return array
	
	
