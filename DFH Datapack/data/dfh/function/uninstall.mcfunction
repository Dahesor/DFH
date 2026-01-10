scoreboard objectives remove dfh.calculator
scoreboard objectives remove dfh.var

scoreboard objectives remove dfh.HP
scoreboard objectives remove dfh.Absorb
scoreboard objectives remove dfh.MAX_HP
scoreboard objectives remove dfh.Regen
scoreboard objectives remove dfh.absorb_cache
scoreboard objectives remove dfh.hp_cache
scoreboard objectives remove dfh.update
scoreboard objectives remove dfh.saved_blink
scoreboard objectives remove dfh.settings
scoreboard objectives remove dfh.armor
scoreboard objectives remove dfh.toughness
scoreboard objectives remove dfh.ench_defence
scoreboard objectives remove dfh.monitor.HP
scoreboard objectives remove dfh.monitor.Shield
scoreboard objectives remove dfh.food_timer
scoreboard objectives remove dfh.item_fix
scoreboard objectives remove dfh.gamemode

function dah.actbar_mixer:remove/for_all {id:"dfh:absorb"}
function dah.actbar_mixer:remove/for_all {id:"dfh:hp"}
function dah.actbar_mixer:remove/for_all {id:"dfh:hp_container"}
function dah.actbar_mixer:remove/for_all {id:"dfh:ench.DEF"}
function dah.actbar_mixer:remove/for_all {id:"dfh:armor_tough"}
function dah.actbar_mixer:remove/for_all {id:"dfh:armor_20"}
advancement revoke @a only dfh:init