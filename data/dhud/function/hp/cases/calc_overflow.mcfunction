scoreboard players operation %overflow dhud.saved_blink = %this_hp dhud.saved_blink
scoreboard players operation %overflow dhud.saved_blink %= #20 dhud.calculator
execute if score %overflow dhud.saved_blink matches 0 run scoreboard players set %overflow dhud.saved_blink 20