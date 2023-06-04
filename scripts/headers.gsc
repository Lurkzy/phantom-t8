#include scripts\core_common\struct;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\aat_shared.gsc;
#include scripts\mp_common\util.gsc;
#include scripts\core_common\rank_shared.gsc;
#include scripts\core_common\exploder_shared.gsc;
#include scripts\core_common\challenges_shared.gsc;
#include scripts\core_common\contracts_shared.gsc;
#include scripts\core_common\match_record.gsc;
#include scripts\mp_common\gametypes\globallogic_score.gsc;
#include scripts\mp_common\gametypes\globallogic.gsc;
#include scripts\core_common\laststand_shared.gsc;

// phantom includes
#using script_6c8abe14025b47c4; // killstreaks
#using script_2dc48f46bfeac894; // ability player
#using scripts\core_common\values_shared.gsc; // values shared
#using scripts\core_common\oob.gsc; // values shared
#using script_788472602edbe3b9; // loadout
#using script_474309807eb94f34; // active camo ?
#using script_2255a7ad3edc838f; // bots
#using script_383a3b1bb18ba876; // killstreak rules ?
#using script_6b93dd1f0ad89d91; // supply drop
#using scripts\mp_common\gametypes\globallogic.gsc; // globallogic 
#using script_7dd6557e89e9840b.gsc; // remote missile
#using script_1af22ad25a2111f7.gsc; // emp stuff
#using scripts\core_common\lui_shared.gsc; // lui shared
#using script_8988fdbc78d6c53.gsc; // weapon objects

#namespace bb;

autoexec __init__sytem__()
{
	system::register("bb", &__init__, undefined, undefined);
}

__init__()
{
    callback::on_start_gametype(&init);
    callback::on_spawned(&onPlayerSpawned);
}
