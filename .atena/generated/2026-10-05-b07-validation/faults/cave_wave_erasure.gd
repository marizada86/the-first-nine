extends "res://main.gd"
# Faulty test-only subclass: starting a cave night wipes the foothill crawler.
func start_thornwake_night() -> void:
	super.start_thornwake_night()
	scree_crawler = {}
