extends Node2D

const SQlite = preload("res://addons/godot-sqlite/bin/gdsqlite.gdns")
var db
var db_path = "res://QnA_data"

func _ready():
	db = SQlite.new()
	db.path = db_path
	
	#print("Hello menu!")
	
	pass

