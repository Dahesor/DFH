scoreboard players operation #temp dhud.calculator = @s dhud.ench_defence

execute if score #temp dhud.calculator matches 1.. run function dhud:stats/calcs/magic_def_parse
execute if score #temp dhud.calculator matches 1.. run function dah.actbar_mixer:append/before