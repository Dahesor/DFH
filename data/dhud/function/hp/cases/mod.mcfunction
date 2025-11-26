data modify storage dah:actbar new set value {id:"hp",text:[{text:"qW,",font:"terra:hud",shadow_color:0},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"*"},{text:"="},{text:"Qq."}]}
function dhud:hp/cases/cross_layer
execute if score %this_hp dhud.HP matches 21..40 run function dhud:hp/draws/roll_2/base
execute if score %this_hp dhud.HP matches 41..60 run function dhud:hp/draws/roll_3/base
execute if score %this_hp dhud.HP matches 61..80 run function dhud:hp/draws/roll_4/base
execute if score %this_hp dhud.HP matches 81.. run function dhud:hp/draws/roll_5/base

execute if score watch_mob_effect dhud.settings matches 1 if predicate dhud:withered run return run function dhud:hp/cases/withered
execute if score watch_mob_effect dhud.settings matches 1 if predicate dhud:poisoned run return run function dhud:hp/cases/posioned
execute if score %layer dhud.saved_blink matches 2 run return run function dhud:hp/cases/roll_2
execute if score %layer dhud.saved_blink matches 3 run return run function dhud:hp/cases/roll_3
execute if score %layer dhud.saved_blink matches 4 run return run function dhud:hp/cases/roll_4
execute if score %layer dhud.saved_blink matches 5 run return run function dhud:hp/cases/roll_5

#Normal
execute if score %blink dhud.saved_blink matches 1 run function dhud:hp/draws/blinking
function dhud:hp/draws/full_hearts
function dhud:hp/draws/edge
execute if score %blink dhud.saved_blink matches 1 if score %this_hp dhud.saved_blink > %this_hp dhud.HP run function dhud:hp/draws/half_blinking
execute if score %blink dhud.saved_blink matches 1 if score %overflow dhud.saved_blink matches 1.. run function dhud:hp/draws/overflow