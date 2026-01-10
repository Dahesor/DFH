# DFH - Dahesor's Fake HUD

DFH is a library that **draws player's HUD** (Health bar and Armor bar) **with actionbar**, and has the option to use a scoreboard based **virtual health** system **while still listening to vanilla hp inputs** (mob attacks, fall damage, effect heals, etc.).

Thus, data pack is allowed to modify player health with scoreboard commands and make arbitrty changes to vanilla signals before they take effects.

![](./readme/img/1.png)

## Dependency

> [!IMPORTANT]
> To manage multiple text segments, the [Actionbar Mixer Library](https://github.com/Dahesor/Actionbar-Mixer-for-Minecraft) of version v1.3.2 or higher is required to use this library. 
> Please [install Actionbar Mixer](https://github.com/Dahesor/Actionbar-Mixer-for-Minecraft/releases) first.

Although this library uses actionbar to draw player HUD, powered by Actionbar Mixer you can still display any text with zero width along side DFH. See the documentation of Actionbar Mixer for details.

## Custom HUD Display

The player's health bar and armor bar is no longer drawn by the game, but by the data pack using Actionbar Mixer.

### Health bar and Absoprtion

#### Display

Player's score on `dfh.HP` will be rendered as hp with a scale of 100. So if a player has 2000 score on it, a full health of 20 will be drawn.

If score goes beyond 2000 then a second layer of yellow hearts will be drawn on top of the first one to represent hp higher than 20, followed by purple, green, and blue with a upper limit of 100 HP.

The HP bar flashes on damage or heal, and shakes on low health just like vanilla.

If the player is under poison or wither effect, then the top layer will become the corrsponding texture just like vanilla. By setting score `watch_mob_effect dfh.settings` 0 or 1 you can turn this effect off or on (Defaults to on).

Player's score on `dfh.Absorb` will be rendered as absorption values with a scale of 100. It can also render up to 4 layers for a max score of 8000 (80 points or 40 hearts).

Because different colors of hearts are already used for HP, the texture for absorption values have been changed to shileds.

#### Driver

See the [Virtual Health Section](#virtual-health-system) to learn what could change player's scores on `dfh.HP` and `dfh.Absorb`. If Virtual Health system is off (`virtual_health dfh.settings` -> `0`) then library will only read these scores for hud rendering and will never change it (fully under your control).

### Armor Bar

#### Display

Player's score on `dfh.armor` will be rendered as hp with a scale of 1. If it goes beyond 20 then a second layer of diamond colored armor icon will be rendered on top of the vanilla layer, up to a score of `40`.

Player's score on `dfh.toughness` will be rendered as golden frames (Kind of like the Apple Skin mod) around the vanilla armor bar to represent Armor toughness, up to a score of `20`.

This display **MAY NOT** re-draw automatically when there is a change in number. Run `function dfh:stats/armor` to refresh it when you change its value.

#### Driver

If score `read_armor dfh.settings` is set to `1`, which is **on default**, then the library will automatically change the player's score on `dfh.armor` and `dfh.toughness` based on attributes when there is an equipment change.

When it does so, the armor bar is also refershed and no `function dfh:stats/armor` is needed. However if the player's attribute changed without an equipment change (for example, using the attribute command), then you must run `tag <Player> add dfh.update_armor` for library to update `<Player>`'s scores.

### Enchantment Protection Bar

#### Display

This bar is **off by default**. To turn it on, set score `ench_defence dfh.settings` to `1`.

This display player's score on `dfh.ench_defence` as a third bar on top of armor bar, to represent the total protection enchantment level the player have on armor slots, with a max score of `20`. Follows the same refresh rule as Armor Bar

#### Driver

`dfh.ench_defence` has **no driver on default**, so the library will not change its score. If set score `read_ench_defence dfh.settings` to `1`, then the library will automatically calculate the total protection levels and write to `dfh.ench_defence`, following the same refresh rule as the armor bar driver.

## Virtual Health System

The Virtual Health System is the default driver for `dfh.HP` mentioned above. It is a scoreboard based **virtual health** system **while still listening to vanilla hp inputs**.

This system is **on by default**. To turn it off, set score `virtual_health dfh.settings` -> `0`.

> [!IMPORTANT]
> **If you do not plan on using this system, please create the `dfh.settings` dummy scoreboard and set the settings before installing the datapack so you have less trouble reseting player's attributes.**

You may directly changes a player's scores on the following scoreboards to manage their health related logics:

* `dfh.HP`: Player's Current HP. Scale: 100 Default: 2000
* `dfh.MAX_HP`: Player's Max HP. Sclae: 100 Default: 2000
* `dfh.Absorb`: Player's Current Absoprtion Value Default: 0
* `dfh.Regen`: Player's Natural Regeneration cooldown. Unit: 0.1 ticks Defaults: 800 (vanllina cd).

> [!IMPORTANT]
> Gamerule `natural_health_regeneration` is set to off since this logic is now managed by library.

> [!WARNING]
> To reduce player's hunger, a custom enchantment is used. The library will replace the player's saddle equipment slot with a temporary item with an enchantment to trigger the effect and remove the item, all done within one tick but not within function context. (If there is already an item, then apply enchantment to that item then remove it later). The temporary item has `custom_data` of `{dfh:{temp:1b}}` and the enchantment is `{"dfh:exhustion":1}` in case you need to deal with this logic.
> When the library is operating player's inventory, the player will get tag `dfh.__inventory_changed` so your own `inventory_changed` advancement trigger could tell it is caused by this library.


When this system is enabled, you can directly change the player's Health by changing their score on `dfh.HP`