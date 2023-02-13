extends Node

var files = File.new()
var dirs = Directory.new()

# file_name - название файла, data - данные 
# Запись словаря
func save_store_data(file_name: String, data):
	files.open("user://"+file_name, File.WRITE)
	files.store_var(data)
	print('Записано ', to_json(data), ' в ', file_name)

# Запись простой строки
func save_string_data(file_name: String,data):
	files.open("user://"+file_name, File.WRITE)
	files.store_string(data)
	print('Записано ', data, ' в ', file_name)

func save_string_from_data(file_name: String,file_path : String,data):
	files.open("user://"+file_path+'/'+file_name, File.WRITE)
	files.store_string(data)
	print('Записано ', data, ' в ', file_name)

# Чтение
func load_data(file_name: String):
	files.open("user://"+file_name, File.READ)
	var content = files.get_var() #UTF-8
	return content

func load_data_as_text(file_path: String):
	files.open(file_path, File.READ)
	var content = files.get_as_text() #UTF-8
	return content

# Функция создания папки
func save_dir_data(file_name: String):
	dirs.open("user://")
	dirs.make_dir(file_name)
	
# Функция создания папки в папке
func save_dir_from_data(file_name: String,file_path : String):
	dirs.open("user://"+file_path)
	dirs.make_dir(file_name)
	
# Функция проверки существует ли файл в папке
func file_exists(path: String) -> bool:
	return files.file_exists(path)

# Функция проверки существует ли папка
func dir_exists(path: String) -> bool:
	return dirs.dir_exists(path)

func list_files_in_directory(path):
	var files = []
	dirs.open(path)
	dirs.list_dir_begin()
	
	while true:
		var file = dirs.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
		
	return files

func CreateNewInterfaceSettings():
	save_store_data(G.SaveInterface, {
		'ColorGradient' : Color("#27ae60"),
		'ColorBackground' : Color("#363535"),
		'UsePersonalColor': false,
	})

func CreateNewLauncherSettings():
	save_store_data(G.SaveLauncher, {
		'UseAlerts': true
	})
