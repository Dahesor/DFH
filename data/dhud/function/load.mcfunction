scoreboard objectives add dhud.calculator dummy


scoreboard objectives add dhud.HP dummy
scoreboard objectives add dhud.Absorb dummy
scoreboard objectives add dhud.hp_cache dummy
scoreboard objectives add dhud.absorb_cache dummy
scoreboard objectives add dhud.update dummy
scoreboard objectives add dhud.saved_blink dummy
scoreboard objectives add dhud.settings dummy
scoreboard objectives add dhud.max_hp dummy
scoreboard objectives add dhud.armor dummy
scoreboard objectives add dhud.toughness dummy
scoreboard objectives add dhud.ench_defence dummy

#NUM
scoreboard players set #-1 dhud.calculator -1
scoreboard players set #2 dhud.calculator 2
scoreboard players set #3 dhud.calculator 3
scoreboard players set #5 dhud.calculator 5
scoreboard players set #6 dhud.calculator 6
scoreboard players set #10 dhud.calculator 10
scoreboard players set #20 dhud.calculator 20
scoreboard players set #30 dhud.calculator 30
scoreboard players set #60 dhud.calculator 60
scoreboard players set #100 dhud.calculator 100
scoreboard players set #1000 dhud.calculator 1000
scoreboard players set #10000 dhud.calculator 10000

execute unless score #init dhud.settings matches 1 run function dhud:default_settings