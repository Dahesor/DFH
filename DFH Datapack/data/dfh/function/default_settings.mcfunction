# Using fake health
execute unless score #init dfh.calculator matches 1 unless score virtual_health dfh.settings matches 0.. run scoreboard players set virtual_health dfh.settings 1
execute if score #init dfh.calculator matches 1 run scoreboard players set virtual_health dfh.settings 1

# If mob effect can affect HP display
scoreboard players set watch_mob_effect dfh.settings 1

# Display Protection Level
scoreboard players set ench_defence dfh.settings 0

# Read Armor and Toughness from player on inventory change
scoreboard players set read_armor dfh.settings 1

# Read Protection Level from armor on inventory change. ** REQUIRES read_armor
scoreboard players set read_ench_defence dfh.settings 0





scoreboard players set #init dfh.settings 1