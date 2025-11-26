function dhud:hp/re_record
execute if entity @s[tag=dhud.update_armor] run function dhud:stats/read_armor
execute if entity @s[tag=dhud.equipment_changed] run tag @s add dhud.update_armor
execute if entity @s[tag=dhud.equipment_changed] run tag @s remove dhud.equipment_changed