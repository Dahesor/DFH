advancement revoke @s through dfh:root

execute if entity @s[tag=dfh.__ignore_hurt] run return run scoreboard players set #has_type dfh.calculator 0

function dfh:logic/check
function dfh:hp/re_record