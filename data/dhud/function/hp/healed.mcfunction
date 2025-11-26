scoreboard players operation #temp dhud.hp_cache = @s dhud.hp_cache
scoreboard players operation #temp2 dhud.hp_cache = @s dhud.HP

scoreboard players remove #temp dhud.hp_cache 1
scoreboard players remove #temp2 dhud.hp_cache 1
scoreboard players operation #temp dhud.hp_cache /= #100 dhud.calculator
scoreboard players operation #temp2 dhud.hp_cache /= #100 dhud.calculator
scoreboard players add #temp dhud.hp_cache 1
scoreboard players add #temp2 dhud.hp_cache 1

execute unless score #temp2 dhud.hp_cache > #temp dhud.hp_cache run return fail

scoreboard players operation @s dhud.saved_blink = @s dhud.HP
execute unless score @s dhud.update matches 6.. run scoreboard players set @s dhud.update 6

function dhud:hp/redraw