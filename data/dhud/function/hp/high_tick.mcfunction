scoreboard players remove @s dhud.update 1

scoreboard players operation #temp dhud.calculator = @s dhud.update
scoreboard players operation #temp dhud.calculator %= #6 dhud.calculator
execute if score #temp dhud.calculator matches 3 run scoreboard players set %blink dhud.saved_blink 1

execute if score #temp dhud.calculator matches 3 run function dhud:hp/redraw
execute if score #temp dhud.calculator matches 0 run function dhud:hp/redraw


scoreboard players set %blink dhud.saved_blink 0