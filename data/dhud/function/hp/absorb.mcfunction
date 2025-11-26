function dah.actbar_mixer:remove/this {id:"absorb"}
execute unless entity @s[gamemode=!creative,gamemode=!spectator] run return fail

scoreboard players operation %this_hp dhud.Absorb = %this dhud.Absorb
scoreboard players remove %this_hp dhud.Absorb 1
scoreboard players operation %this_hp dhud.Absorb /= #100 dhud.calculator
scoreboard players add %this_hp dhud.Absorb 1

function dhud:hp/absorb/mod
function dah.actbar_mixer:append/before

function dah.actbar_mixer:redraw