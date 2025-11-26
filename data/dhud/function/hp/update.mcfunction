function dah.actbar_mixer:remove/this {id:"hp"}
function dah.actbar_mixer:remove/this {id:"hp_container"}
execute unless entity @s[gamemode=!creative,gamemode=!spectator] run return fail

scoreboard players remove %this_hp dhud.HP 1
scoreboard players remove %this_hp dhud.saved_blink 1
scoreboard players operation %this_hp dhud.HP /= #100 dhud.calculator
scoreboard players operation %this_hp dhud.saved_blink /= #100 dhud.calculator
scoreboard players add %this_hp dhud.HP 1
scoreboard players add %this_hp dhud.saved_blink 1

function dhud:hp/cases/mod
function dah.actbar_mixer:append/before

function dhud:hp/draws/container
function dah.actbar_mixer:append/before