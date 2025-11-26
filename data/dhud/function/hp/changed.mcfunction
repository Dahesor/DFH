execute if score @s dhud.hp_cache < @s dhud.HP run return run function dhud:hp/healed

execute unless score @s dhud.update matches 10.. run scoreboard players operation @s dhud.saved_blink = @s dhud.hp_cache
execute unless score @s dhud.update matches 18.. run scoreboard players set @s dhud.update 18

function dhud:hp/redraw
function dah.actbar_mixer:redraw