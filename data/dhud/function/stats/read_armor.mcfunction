execute store result score @s dhud.toughness run attribute @s armor_toughness get
execute store result score @s dhud.armor run attribute @s armor get
function dhud:stats/armor
tag @s remove dhud.update_armor