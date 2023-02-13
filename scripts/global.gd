extends Node

onready var AppTitle = ProjectSettings.get_setting("application/config/name")

#Сцены
var BackGroundScene = null #Сцена фона лаунчера
var GameLibraly = null #Сцена оффлайн библеотеки
var MainScene = null #Главная сцена
var ShopScene = null #Сцена со всеми играми
var NewsScene = null #Cцена с новостями

var NetWarning = false

var tik_time = 1 # тик-тайм, нужен для того чтобы у HTTP запроса было время его выполнить и дать данные без ошибки

var GameIdTmp = 0 # Временный id для взятия данных о странце игры
const AllGamesPath = 'Games'

#Данные настроек лаунчера
var SettingsDataInterface = null
var SettingsDataLauncher = null

#Константы названия файлов сохранения
const SaveInterface = 'SettingsInterface.txt'
const SaveLauncher = 'SettingsLauncher.txt'

#Глобальная переменная если игрок играет
var IsPlayerPlay = false

func _ready():
	var data = Fs.load_data(SaveInterface)
	var data2 = Fs.load_data(SaveLauncher)
	if data and data2:
		SettingsDataInterface = data
		SettingsDataLauncher = data2
	else:
		Fs.CreateNewInterfaceSettings()
		SettingsDataInterface = Fs.load_data(SaveInterface)
		Fs.CreateNewLauncherSettings()
		SettingsDataLauncher = Fs.load_data(SaveLauncher)
		
# Функция чтобы перейти на сцену
func scene(s):
	get_tree().change_scene(s)

# Функция чтобы выйти из приложения
func quit():
	get_tree().quit()

# Вызов уведомлений системы
func CallAlert(text,title = AppTitle,CanCall=false):
	if SettingsDataLauncher['UseAlerts'] and !CanCall:
		OS.alert(text,title)

