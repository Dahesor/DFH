advancement revoke @s only dfh:hurt_by_enemy

execute if entity @s[tag=dfh.__ignore_hurt] run return fail

scoreboard players set $by_entity dfh.var 1
function dfh:logic/check
function dfh:hp/re_record