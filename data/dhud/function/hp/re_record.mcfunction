execute store result score @s dhud.HP run data get entity @s Health 100


scoreboard players operation #hp dhud.calculator = @s dhud.HP
scoreboard players operation #hp dhud.calculator *= #2 dhud.calculator
execute unless score @s dhud.hp_cache = @s dhud.HP run function dhud:hp/changed
scoreboard players operation @s dhud.hp_cache = @s dhud.HP
execute if score @s dhud.update matches 1.. run function dhud:hp/high_tick

scoreboard players operation #hp dhud.calculator = @s dhud.HP
scoreboard players operation #hp dhud.calculator *= #5 dhud.calculator

execute if score #hp dhud.calculator <= @s dhud.max_hp run function dhud:hp/wiggle_only


#Absorb
execute store result score %this dhud.Absorb run data get entity @s AbsorptionAmount 100
execute unless score @s dhud.Absorb = %this dhud.Absorb run function dhud:hp/absorb
scoreboard players operation @s dhud.Absorb = %this dhud.Absorb

execute if score @s[tag=!hud.absorb] dhud.Absorb matches 1.. run return run function dhud:stats/armor
execute if score @s[tag=hud.absorb] dhud.Absorb matches ..0 run return run function dhud:stats/armor