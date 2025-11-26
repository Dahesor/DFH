execute store result score @s dhud.toughness run attribute @s armor_toughness get
execute store result score @s dhud.armor run attribute @s armor get
execute if score read_ench_defence data.sidebar.dah matches 1 run function dhud:stats/read_ench
function dhud:stats/armor
tag @s remove dhud.update_armor