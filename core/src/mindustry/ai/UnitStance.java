package mindustry.ai;

import arc.*;
import arc.scene.style.*;
import arc.util.*;
import mindustry.*;
import mindustry.ctype.*;
import mindustry.gen.*;
import mindustry.input.*;
import mindustry.type.*;

public class UnitStance extends MappableContent{
    public static UnitStance stop, shoot, holdFire, pursueTarget, patrol, ram, mineAuto;

    /** Name of UI icon (from Icon class). */
    public String icon;
    /** Key to press for this stance. */
    public @Nullable Binding keybind;

    public UnitStance(String name, String icon, Binding keybind){
        super(name);
        this.icon = icon;
        this.keybind = keybind;
    }

    public String localized(){
        return Core.bundle.get("stance." + name);
    }

    public TextureRegionDrawable getIcon(){
        return Icon.icons.get(icon, Icon.cancel);
    }

    public char getEmoji() {
        return (char)Iconc.codes.get(icon, Iconc.cancel);
    }

    @Override
    public ContentType getContentType(){
        return ContentType.unitStance;
    }

    @Override
    public String toString(){
        return "UnitStance:" + name;
    }

    public static void loadAll(){
        stop = new UnitStance("stop", "cancel", Binding.cancel_orders);
        shoot = new UnitStance("shoot", "commandAttack", Binding.unit_stance_shoot);
        holdFire = new UnitStance("holdfire", "none", Binding.unit_stance_hold_fire);
        pursueTarget = new UnitStance("pursuetarget", "right", Binding.unit_stance_pursue_target);
        patrol = new UnitStance("patrol", "refresh", Binding.unit_stance_patrol);
        ram = new UnitStance("ram", "rightOpen", Binding.unit_stance_ram);
        mineAuto = new UnitStance("mineauto", "settings", null);

        //Only vanilla items are supported for now
        for(Item item : Vars.content.items()){
            new ItemUnitStance(item);
        }
    }
}
