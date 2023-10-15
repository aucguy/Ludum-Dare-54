extends Node

var debug = true
var loaded = false

var player_speed
var player_invincible
var spray_health_change
var spray_particle_rate
var spray_particle_velocity
var spray_particle_max_distance
var enemy_speed
var enemy_particle_damage
var player_enemy_damage
var big_fire_max_spawn_count
var big_fire_spawn_rate
var big_fire_particle_damage
var small_fire_max_spawn_count
var small_fire_spawn_rate
var small_fire_particle_damage
var pool_refill_speed
var pool_capacity

func reload_params():
	if loaded and not debug:
		return
	load_params()
	
func load_params():
	var file = FileAccess.open('res://parameters.json', FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	if content == null:
		return
		
	player_speed = content.player_speed
	player_invincible = content.player_invincible
	spray_health_change = content.spray_health_change
	spray_particle_rate = content.spray_particle_rate
	spray_particle_velocity = content.spray_particle_velocity
	spray_particle_max_distance = content.spray_particle_max_distance
	enemy_speed = content.enemy_speed
	enemy_particle_damage = content.enemy_particle_damage
	player_enemy_damage = content.player_enemy_damage
	big_fire_max_spawn_count = content.big_fire_max_spawn_count
	big_fire_spawn_rate = content.big_fire_spawn_rate
	big_fire_particle_damage = content.big_fire_particle_damage
	small_fire_max_spawn_count = content.small_fire_max_spawn_count
	small_fire_spawn_rate = content.small_fire_spawn_rate
	small_fire_particle_damage = content.small_fire_particle_damage
	pool_refill_speed = content.pool_refill_speed
	pool_capacity = content.pool_capacity
	
	loaded = true
