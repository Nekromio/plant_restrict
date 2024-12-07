#include <sdktools_functions>

public Plugin myinfo =
{
    name = "Plant restrict",
    description = "При старте раунда передаёт плент игроку",
    author = "Nek.'a 2x2",
    version = "1.0.1",
    url = "ggwp.site || vk.com/nekromio || t.me/sourcepwn "
};

public void OnPluginStart()
{
    HookEvent("round_start", Event_RoundStart, EventHookMode_Post);
}

void Event_RoundStart(Event hEvent, const char[] sEvName, bool dontBroadcast)
{
    baseLogic();
}

stock void baseLogic()
{
    for (int i = 1; i <= MaxClients; i++) 
    {
        if (!CheckPlayer(i, true) || CheckPlant(i) == -1)
            continue;

        for (int j = 1; j <= MaxClients; j++) 
        {
            if (!CheckPlayer(j, false) || CheckPlant(j) != -1)
                continue;

            if (GivePlayerItem(j, "weapon_c4") != -1)
            {
                RemovePlayerItem(i, CheckPlant(i));
                return;
            }
        }
    }
}

stock int CheckPlant(const int client)
{
    return GetPlayerWeaponSlot(client, 4);
}

stock bool CheckPlayer(const int client, const bool bot)
{
    return IsClientInGame(client) 
        && (bot ? IsFakeClient(client) : !IsFakeClient(client))
        && IsPlayerAlive(client)
        && GetClientTeam(client) == 2;
}