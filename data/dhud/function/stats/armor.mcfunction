tag @s remove hud.absorb
execute unless score @s dhud.Absorb matches ..0 run tag @s add hud.absorb

function dah.actbar_mixer:remove/this {id:"ench.DEF"}
function dah.actbar_mixer:remove/this {id:"armor_tough"}
function dah.actbar_mixer:remove/this {id:"armor_20"}
execute unless entity @s[gamemode=!creative,gamemode=!spectator] run return fail

execute if score ench_defence dhud.settings matches 1 run function dhud:stats/calcs/magic_def

scoreboard players operation #temp dhud.calculator = @s dhud.toughness
execute if score #temp dhud.calculator matches 1.. run function dhud:stats/calcs/armor_toughness
execute if score #temp dhud.calculator matches 1.. run function dah.actbar_mixer:append/before

scoreboard players operation #temp dhud.calculator = @s dhud.armor
execute if score #temp dhud.calculator matches 1.. run function dhud:stats/calcs/armor
execute if score #temp dhud.calculator matches 1.. run function dah.actbar_mixer:append/before