
scoreboard players set #temp dhud.calculator 0
scoreboard players set #temp2 dhud.calculator 0
data modify storage data equipment set from entity @s equipment

execute if data storage data equipment.head.components."minecraft:enchantments"."minecraft:protection" store result score #temp2 dhud.calculator run data get storage data equipment.head.components."minecraft:enchantments"."minecraft:protection"
scoreboard players operation #temp dhud.calculator += #temp2 dhud.calculator

scoreboard players set #temp2 dhud.calculator 0
execute if data storage data equipment.chest.components."minecraft:enchantments"."minecraft:protection" store result score #temp2 dhud.calculator run data get storage data equipment.chest.components."minecraft:enchantments"."minecraft:protection"
scoreboard players operation #temp dhud.calculator += #temp2 dhud.calculator



scoreboard players set #temp2 dhud.calculator 0
execute if data storage data equipment.legs.components."minecraft:enchantments"."minecraft:protection" store result score #temp2 dhud.calculator run data get storage data equipment.legs.components."minecraft:enchantments"."minecraft:protection"
scoreboard players operation #temp dhud.calculator += #temp2 dhud.calculator



scoreboard players set #temp2 dhud.calculator 0
execute if data storage data equipment.feet.components."minecraft:enchantments"."minecraft:protection" store result score #temp2 dhud.calculator run data get storage data equipment.feet.components."minecraft:enchantments"."minecraft:protection"
scoreboard players operation #temp dhud.calculator += #temp2 dhud.calculator



execute if score #temp dhud.calculator matches 1.. run function dhud:stats/calcs/magic_def_parse
execute if score #temp dhud.calculator matches 1.. run function dah.actbar_mixer:append/before

