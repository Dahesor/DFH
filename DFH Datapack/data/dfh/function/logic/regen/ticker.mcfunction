execute if entity @s[tag=dfh.__food_case] run function dfh:logic/regen/cases

execute unless score @s dfh.food_timer matches ..0 run scoreboard players remove @s dfh.food_timer 10
execute if entity @s[tag=dfh.hunger.saturated] run scoreboard players remove @s dfh.food_timer 70
execute unless score @s dfh.food_timer matches ..0 run return fail

scoreboard players operation @s dfh.food_timer += @s dfh.Regen
function dfh:logic/regen/cases

execute if entity @s[tag=dfh.hunger.hungry] run return fail

scoreboard players set $regen_amount dfh.var 100
scoreboard players set $reduce_hunger dfh.var 1

function #dfh:on_regen_tick

execute unless score @s dfh.HP < @s dfh.MAX_HP run return fail

function #dfh:on_regen_success

scoreboard players operation @s dfh.HP += $regen_amount dfh.var
execute if score @s dfh.HP > @s dfh.MAX_HP run scoreboard players operation @s dfh.HP = @s dfh.MAX_HP

execute if score $reduce_hunger dfh.var matches 1 run function dfh:logic/regen/apply_exhution