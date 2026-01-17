scoreboard players operation $dmg dfh.var = @s dfh.monitor.Shield
scoreboard players operation $dmg dfh.var -= $new dfh.monitor.Shield
scoreboard players operation @s dfh.monitor.Shield = $new dfh.monitor.Shield

execute if score #has_type dfh.calculator matches 0 run data modify storage dfh:var type set value "dfh:unknown"
scoreboard players set #has_type dfh.calculator 0

execute if score $dmg dfh.var matches ..0 run return 1

function #dfh:on_dmg

scoreboard players operation @s dfh.Absorb -= $dmg dfh.var
scoreboard players operation $dmg dfh.var = @s dfh.Absorb
scoreboard players operation $dmg dfh.var *= #-1 dfh.calculator
execute if score @s dfh.Absorb matches ..0 run scoreboard players set @s dfh.Absorb 0
execute if score $dmg dfh.var matches ..0 run scoreboard players set $dmg dfh.var 0

scoreboard players operation @s dfh.HP -= $dmg dfh.var
execute if score @s dfh.HP matches ..0 run scoreboard players set @s dfh.HP 0

execute if score @s dfh.monitor.HP matches 30000.. run return run function dfh:logic/monitor/remove_200
function dfh:logic/monitor/reset_shield