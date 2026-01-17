# 大废物 - Dahesor的假HUD与虚拟生命值操作库

大废物是一个使用actionbar绘制玩家HUD的库。它还可以使用记分板形式的虚拟生命值，且保留接受原版生命值信号的功能。

这使得你可以使用记分板命令任意更改玩家的生命值，并在同时拦截原版的生命变动并在它们生效前任意修改它们。

![](./img/1.png)

## 依赖

> [!IMPORTANT]
> 大废物需要版本v1.3.2或更高的[Actionbar Mixer 混合器](https://github.com/Dahesor/Actionbar-Mixer-for-Minecraft)作为前置以管理多个状态栏文本片段。
> 请先[安装Actionbar Mixer](https://github.com/Dahesor/Actionbar-Mixer-for-Minecraft/releases).

虽然大废物使用了状态栏，但只要遵守Actionbar Mixer的规则，你就仍然可以使用actionbar显示任意零宽度的文本片段。查看Actionbar Mixer的说明文档以获取详细信息。

## 自定义HUD

安装大废物时，玩家的生命值与盔甲值将不再由游戏绘制，而是由大废物管理。

### 生命值与伤害吸收

#### 显示

玩家在`dfh.HP`上的分数除以100后会作为他的生命值显示。例：2000分=20点生命值=10颗心。

若分数超过2000则第二层黄色的心会用来表示第二管生命值。在之后还有紫色，绿色，和蓝色，最多能显示5管，或最大100点生命值。

生命值会在受伤或治疗时闪烁，并在濒死时抖动，就如原版一样。

若玩家中毒或凋灵则最上一层的生命值也会如原版一般变换材质。设置分数`watch_mob_effect dfh.settings`为1或0可以控制本效果的开或关，默认为开。

玩家在`dfh.Absorb`上的分数除以100后会作为他的伤害吸收值显示。这最多可以显示4管或80点。

因为不同颜色的心已经用于显示生命值，大废物使用盾牌图标展示伤害吸收。

#### 驱动

查看[虚拟生命值](#虚拟生命值系统)章节以了解玩家的`dfh.HP`和`dfh.Absorb`会在什么情况下变化。若大废物的虚拟生命值模块关闭(`virtual_health dfh.settings` -> `0`)，则大废物不会更改这两个分数，它们将完全由你控制。

### 盔甲与盔甲任性

#### 显示

玩家在`dfh.armor`上的分数会作为其盔甲值显示。若其超过20则会叠加一层钻石色的盔甲图标，最多可显示40点。

玩家在`dfh.toughness`上的分数将会显示为盔甲值外侧得到金色边框以表示盔甲韧性（类似苹果皮模组）,最大显示40点。

当记分板数值变化时，HUD有可能**不会更新**。请手动以玩家身份执行`function dfh:stats/armor`以重新绘制他的盔甲条。

#### 驱动

若`read_armor dfh.settings`设置为1（默认如此）,那么在`equipment_changed`时大废物会自动读取玩家的属性值并填入`dfh.armor`和`dfh.toughness`中。

每当触发时，不需要手动执行`function dfh:stats/armor`就会自动重新绘制。然而，若玩家的属性在装备未更改时发生变化（比如使用attribute命令更改），那么大废物不会更新玩家分数。请给玩家加`tag <Player> add dfh.update_armor`以手动更新。

### 保护魔咒条

#### 显示

这个项目**默认关闭**。若要开启请设置分数`ench_defence dfh.settings`为`1`。

玩家在`dfh.ench_defence`上的分数将会展示在盔甲栏的上方，代表其拥有的总保护魔咒等级，最高20点。它的绘制更新规则和盔甲值一样。

#### 驱动

`dfh.ench_defence`默认不会被驱动,这意味着大废物不会变更它的分数。但若分数`read_ench_defence dfh.settings`设置为`1`，那么大废物会自动计算玩家盔甲栏位中保护魔咒的总等级并写入`dfh.ench_defence`。这个机制触发的条件和盔甲值一致。

## 虚拟生命值系统

虚拟生命值系统是`dfh.HP`和`dfh.Absorb`记分板的默认驱动。它是使用记分板记录的虚拟生命值系统，并同时拥有监听原版生命值变化的功能。

本功能默认开启。要关闭请设置`virtual_health dfh.settings`为`0`。

> [!IMPORTANT]
> **如果你不打算使用本功能，请在安装大废物前就手动创建dummy记分板`dfh.settings`并提前设置分数，否则在安装后再设置你将需要手动重置玩家的`max_health`与`max_absorption`属性。**

> [!CAUTION]
> 由于大废物需要一个没有声音的伤害，大废物的资源包会将`freeze`伤害音效静音。如果你需要这个音效，请考虑另写逻辑复现。

本系统允许你直接更改玩家的分数以控制其生命值的方方面面：

* `dfh.HP`: 玩家的当前生命值。存储倍率：100，默认：2000
* `dfh.MAX_HP`: 玩家的最大生命值。存储倍率：100，默认：2000
* `dfh.Absorb`: 玩家的当前伤害吸收值。存储倍率：100，默认：0
* `dfh.Regen`: 玩家生命值自然回复间隔。单位：0.1刻。默认：800（与原版一致）

> [!IMPORTANT]
> 大废物不会再玩家的`dfh.HP`归零时击杀玩家。请写好自己的逻辑处理这些玩家。大废物可以使用正常的`kill`命令。

> [!IMPORTANT]
> 本系统运行时无法直接使用伤害吸收状态效果。若玩家使用金苹果或命令等方式获得伤害吸收效果，`dfh.Absorb`不会增加。
>
> 你应该定义自己的逻辑以在这些事件发生时增加玩家的`dfh.Absorb`分数。

> [!IMPORTANT]
> 游戏规则`natural_health_regeneration`会被设置为`false`，因为自然回复现在由大废物控制。

> [!CAUTION]
> 为了减少玩家的饥饿值，大废物使用了一个自定义魔咒。为了触发它，大废物会在需要时，向玩家的`saddle`槽位填充一个带有该魔咒的物品并在一刻内（但不是函数上下文内）移除它。（若saddle槽位已有物品则会添加这个魔咒到该物品中并在触发后移除魔咒）。
>
> 如果你需要处理相关逻辑：这个临时物品会有`custom_data`:`{dfh:{temp:1b}}`。魔咒为`{"dfh:exhustion":1}`。
>
> 在大废物对玩家进行任意物品栏操作时会添加临时标签`dfh.__inventory_changed`以确保其他数据包的`inventory_changed`进度触发器可以排除来自大废物的触发。

### 原版信号监视器

虽然大废物使用记分板的虚拟生命值，但是它保留了监听原版生命值变化的能力。若玩家以任何方式受伤或者受到治疗，玩家的`dfh.HP`和`dfh.Absorb`都会正确地变动，并且你可以在变动发生前拦截这些信号并修改它们。

**#dfh:on_dmg**

当玩家受伤时，函数标签`function #dfh:on_dmg`会被执行。

你可以在`#dfh:on_dmg`函数中读写以下分数在`dfh.var`记分板上的数值:
* `$dmg`: **(读写)** 该玩家将要受到的伤害。**倍率: 100**。请勿调整为负数。

同时，本次伤害的伤害类型会被存储于storage `dfh:var`的`type`键名下。这个ID默认包含默认命名空间 (类似 `minecraft:fall`).

> [!IMPORTANT]
> 伤害类型检测默认仅适用于原版已有的伤害类型。
> 如果你想要使大废物能够检测你添加的自定义伤害类型，请见[自定义伤害类型判断](#自定义伤害类型判断)部分。

**#dfh:on_heal**

玩家受到治疗时执行函数标签`function #dfh:on_heal`。

`dfh.var`上的分数:
* `$heal`: **(读写)** 该玩家将要受到的治疗量。**倍率: 100**。

**#dfh:on_regen_tick** 与 **#dfh:on_regen_success**

当玩家尝试进行自然生命值回复时，执行`function #dfh:on_regen_tick`(饥饿值足够且冷却结束)

当玩家尝试进行自然生命值回复时，且其`dfh.HP` < `dfh.MAX_HP`所以将要成功时，执行`function #dfh:on_regen_success`

`dfh.var`上的分数:
* `$regen_amount`: **(读写)** 该玩家将要受到的治疗量。**倍率: 100**。默认为100。
* `$reduce_hunger`: **(读写)** 若为1，则玩家将会失去一点饥饿值或饱和度。默认为1。


#### 自定义伤害类型判断

默认情况下，大废物只会检查一次伤害是否属于任意原版伤害类型。如果你添加了新的伤害类型并用它造成伤害，那么在触发`#dfh:on_dmg`时，大废物提供的伤害类型将会是`dfh:unknown`。

想要大废物检测你的自定义伤害类型，你需要：
1. 将你的伤害类型添加入伤害类型标签`dfh:sys/all`
2. 创建一个进度触发器:
```json
{
    "criteria": {
        "hurt": {
            "trigger": "entity_hurt_player",
            "conditions": {
                "damage": {
                    "type": {
                        "tags": [{"expected": true,"id": "伤害类型标签"}]
                    }
                }
            }
        }
    },
    "rewards": {
        "function": "执行函数"
    },
    "parent": "dfh:root"
}
```
触发器的`parent`应该是`dfh:root`。其他条件不限，但一般来说，应该把`伤害类型标签`换成一个包含伤害类型的标签。触发时执行的函数`执行函数`的内容应该是:
```mcfunction
function dfh:dmg_recieve {type:"ID"}
```
`ID`可以是任意字符串。当你的进度触发时，本次伤害（如果有的话）的`#dfh:on_dmg`提供的伤害类型就会是你填入的`ID`。

这个函数不需要撤回进度。

##### 覆盖原版伤害类型触发器

<details>
<summary>如何做自定义的entity_hurt_player进度触发判断</summary>

如果你需要自定义的`entity_hurt_player`进度触发器以定义自定义的`ID`，那么你可以禁用大废物在特定原版伤害类型上的默认触发器，然后定义你自己的。

想要禁用大废物对于一个原版伤害类型的默认触发器，设置分数`<伤害类型ID>`在计分板`dfh.disabled_trigger`上的分数为`1`。`<伤害类型ID>`应该包含默认命名空间。

比如，执行`scoreboard players set minecraft:fall dfh.disabled_trigger 1`会禁用大废物对`fall`伤害类型的默认触发器。

现在，你可以向上面[自定义伤害类型判断](#自定义伤害类型判断)部分一样，为`fall`伤害类型创建自定义的进度触发器。例如，你可以创建两个进度，根据不同条件将`fall`伤害类型分为两种情况，分别执行`function dfh:dmg_recieve {type:"normal_fall"}`或`function dfh:dmg_recieve {type:"special_fall"}`。那么现在当它们触发时，`#dfh:on_dmg`函数就会提供的伤害类型就会是`normal_fall`或`special_fall`。

如果一次伤害没能触发任何进度，那么提供的伤害类型将为`dfh:unknown`。

</details>

### 大废物监视器

大废物会在以下情况发生时以目标玩家为实体执行对应的函数标签。

**#dfh:player_init**

当玩家第一次被大废物初始化时。

**#dfh:on_revive**

当玩家复活时。

**#dfh:on_hp_init_complete**

> [!CAUTION]
> 当玩家复活或是第一次进入游戏时，生命值系统将在两刻内不可用，因为大废物正在进行初始化工作。

当玩家的生命值系统初始化完毕时。

## 大废物函数

大废物提供一下函数

**dfh:redraw**

立刻全部擦除并重新绘制当前玩家的HUD。

**dfh:stats/armor**

立刻全部擦除并重新绘制当前玩家的盔甲值和保护魔咒值。

**dfh:kill**

击杀当前玩家。死亡信息为`❌ <玩家名>`

**dfh:fake_dmg**

给予玩家没有击退的0.001伤害。若你降低了玩家的生命值分数，可以考虑执行本函数以给予玩家视听效果。

**dfh:return**

返回大废物的数字版本号。

**dfh:uninstall**

卸载大废物。你应该在下次reload前移除数据包以免它再次安装。

> [!CAUTION]
> 大废物的虚拟生命值系统会变更所有玩家的`max_health`和`max_absorption`属性。大废物无法在卸载时还原下线玩家的属性。
>
> 因此，你应该负责在卸载大废物后还原玩家的这两项属性。

## 大废物伤害类型

大废物提供以下3种伤害类型以供使用：
 - **dfh:silent**: 无视冷却和任何伤害免疫，没有声音，没有击退
 - **dfh:sys**: 无视冷却和任何伤害免疫，没有击退
 - **dfh:sys_with_knockback**: 无视冷却和任何伤害免疫

## 数据文件

大废物在下载中提供了一个DFH-dependency.zip文件。将其放置到电脑的任意位置，配合 [Spyglass](https://github.com/SpyglassMC/Spyglass)（Datapack Helper Plus），就可以通过在数据包根目录创建一个`spyglass.json`文件的方式，获取本库所需的所有函数/标签/计分板等的自定义补全。

示例`spyglass.json`: 阅读[Spyglass文档](https://spyglassmc.com/user/config.html)获取详细信息。
```json
{
    "env": {
        "dependencies": [
            "file:///C:/path/to/DFH-dependency.zip",
            "@vanilla-mcdoc",
            "@vanilla-resourcepack",
            "@vanilla-mcdoc"
        ],
        "gameVersion": "1.21.11"
    }
}
```
修改后需要重载Vs Code