scoreboard players operation %this_hp dhud.saved_blink = @s dhud.saved_blink
scoreboard players operation %this_hp dhud.HP = @s dhud.HP
scoreboard players set %overflow dhud.saved_blink 0
scoreboard players set %layer dhud.saved_blink 1
function dhud:hp/update