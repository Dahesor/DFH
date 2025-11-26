execute as @a run function dhud:player/read_data
execute store result score $gametime dhud.calculator run time query gametime

scoreboard players add #loop_5 dhud.calculator 1
execute if score #loop_5 dhud.calculator matches 5 run scoreboard players set #loop_5 dhud.calculator 0
execute if score #loop_5 dhud.calculator matches 1 as @a run function dhud:player/update_data