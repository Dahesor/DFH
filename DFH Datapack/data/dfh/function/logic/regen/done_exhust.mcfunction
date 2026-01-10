tag @s add dfh.__inventory_changed

item modify entity @s saddle {function:"set_enchantments",add:true,enchantments:{"dfh:exhustion":-10}}
execute if items entity @s saddle barrier[custom_data~{dfh:{temp:1b}}] run item replace entity @s saddle with air

tag @s remove dfh.__inventory_changed