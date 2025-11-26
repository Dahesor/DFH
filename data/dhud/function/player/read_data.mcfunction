execute if score read_hp dhud.settings matches 1 store result score @s dhud.HP run data get entity @s Health 100
execute if score read_absoption dhud.settings matches 1 store result score @s dhud.Absorb run data get entity @s AbsorptionAmount 100

function dhud:hp/re_record
execute if entity @s[tag=dhud.update_armor] run function dhud:stats/read_armor
execute if entity @s[tag=dhud.equipment_changed] run tag @s add dhud.update_armor
execute if entity @s[tag=dhud.equipment_changed] run tag @s remove dhud.equipment_changed