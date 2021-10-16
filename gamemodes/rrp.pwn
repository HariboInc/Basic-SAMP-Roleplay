/* This GameMode is made by Spydah
				You may:
				        Edit the script
				        Use the script
				You may not:
				            Delete the credits
				            Claim this script as yours
*/

#include <a_samp>
#include <sii>
#include <zcmd>
#include <sscanf2>
#include <streamer>
#include <foreach>
// defines

#define SERVER_MOTD "Welcome to Basic Roleplay! Have fun."
#define MAX_GANGS              7

// Dialog Defines

#define DIALOG_REGISTER     1
#define DIALOG_LOGIN        2
#define DIALOG_GENDER       3
#define DIALOG_AGE          4
#define DIALOG_HELP         5
#define DIALOG_MSG       8888
#define DIALOG_BUGS         6
#define DIALOG_UPDATES      7

// Color Defines

#define GREY            0xCECECEFF
#define WHITE           0xFFFFFFFF
#define RED             0xAA3333AA
#define GOLD            0xFFD700FF
#define ACTION_COLOR 	0xC2A2DAAA
#define GREEN           0x33AA33AA
#define ORANGE          0xFF9900AA
#define GUARDS_RADIO	0x0000BBAA
#define DOCTORS_RADIO   0xFFC0CBAA
#define COLOR_DMV       0x33CCFFFF

// new's

// Others

forward NewPlayerData(playerid);
forward SavePlayerData(playerid);
forward LoadPlayerData(playerid);
forward ShowStatsForPlayer(playerid,targetid);
forward ServerSettings();
forward SendNearByMessage(playerid, color, str[], Float:radius);
forward LoadObjects();
forward SendFactionMessage(playerid, color, str[]);
forward SendGangMessage(playerid, color, str[]);
forward LoadGangs();

// Player Stats

enum PlayerInfo
{
	 Password[128],
	 Logged,
	 Gender,
	 Age,
	 Money,
	 LastSkin,
	 AdminLevel,
	 Banned,
	 TimesKicked,
	 TimesBanned,
	 LastIP[21],
	 WrongPw,
	 FullyRegistered,
	 Spawned,
	 FactionID,
	 FactionRank,
	 BeingInvitedToFaction,
	 CopDuty,
	 InHospital,
	 Tased,
	 Cuffed,
	 Dead,
	 BeingDragged,
	 GangID,
	 GangRank,
	 BeingInvitedToGang,
	 CarLic,
	 Float: Health,
	 Float: Armour,
	 Float: LastX,
	 Float: LastY,
	 Float: LastZ,
	 Float: LastA,
}
new PlayerStat[MAX_PLAYERS][PlayerInfo];
new PlayerText:MyTD[MAX_PLAYERS];
new Text:AreaMotd;
new GMX1[MAX_PLAYERS];
new LastCar[MAX_PLAYERS];

new SDCar[20];
new EMSCar[20];
new GOVCar[10];
// DMV
new DMVCar[5];
new LicenseTest[MAX_PLAYERS];
new CP[MAX_PLAYERS];

enum GangInfo
{
    GangFile[60],
    GangName[60],
    Leader[60],
    Members,
	Rank1[128],
	Rank2[128],
	Rank3[128],
	Rank4[128],
	Rank5[128],
	Rank6[128],
	MOTD[128],
	Color,
}
new GangStat[MAX_GANGS][GangInfo];


main()
{
	print("----------------------------------");
	print(" Basic Roleplay By Spydah");
	print("----------------------------------");
}

public OnGameModeInit()
{
	SetGameModeText("B:RP v1.0");
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	ShowPlayerMarkers(0);
	AllowInteriorWeapons(1);
	
	//textdraws
	AreaMotd = TextDrawCreate(170.000000, 330.000000, "Basic Roleplay V1.0 By Spydah");
	TextDrawBackgroundColor(AreaMotd, 255);
	TextDrawFont(AreaMotd, 1);
	TextDrawLetterSize(AreaMotd, 0.500000, 2.000000);
	TextDrawColor(AreaMotd, -1);
	TextDrawSetOutline(AreaMotd, 0);
	TextDrawSetProportional(AreaMotd, 1);
	TextDrawSetShadow(AreaMotd, 2);
	
	LoadObjects();
	LoadGangs();
	LoadStaticVehicles();
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerCameraPos(playerid, -1499.7142, 2769.0830, 97.1839);
	SetPlayerCameraLookAt(playerid, -1499.5210, 2768.0774, 96.8166);
	SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, playerid+0);
	TogglePlayerControllable(playerid, false);
	if(PlayerStat[playerid][Logged] == 1 && PlayerStat[playerid][FullyRegistered] == 1) return LoadPlayerData(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	// El Quabrados Additions.
    RemoveBuildingForPlayer(playerid, 3297, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3299, -1518.0313, 2698.5938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3300, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 11600, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3341, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3339, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3342, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 11673, -1461.1563, 2627.6797, 62.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 1522, -1509.6563, 2611.1172, 54.8750, 0.25);
	RemoveBuildingForPlayer(playerid, 11449, -1520.9766, 2620.0938, 57.4453, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1515.2578, 2635.2188, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3169, -1510.3516, 2646.6563, 54.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 956, -1455.1172, 2591.6641, 55.2344, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1479.6953, 2611.3984, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1483.6484, 2611.3984, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 11479, -1460.9141, 2613.7813, 54.9688, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2613.5938, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2617.6250, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2621.6250, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 11543, -1461.1563, 2627.6797, 62.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2625.6094, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2629.4688, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2633.3281, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 672, -1454.2734, 2640.1406, 55.8281, 0.25);
	RemoveBuildingForPlayer(playerid, 11461, -1466.0313, 2637.5938, 54.3906, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2637.1797, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 3278, -1485.7188, 2641.0391, 59.6172, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1457.8672, 2648.9922, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 11544, -1483.2813, 2642.3828, 56.6953, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1446.4531, 2639.3516, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 3283, -1518.0313, 2698.5938, 55.2109, 0.25);
	RemoveBuildingForPlayer(playerid, 3285, -1534.4453, 2689.2734, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 669, -1504.0859, 2704.5859, 55.2422, 0.25);
	RemoveBuildingForPlayer(playerid, 3173, -1447.2344, 2653.3047, 54.8203, 0.25);
	RemoveBuildingForPlayer(playerid, 3242, -1493.8359, 2688.9922, 56.6484, 0.25);
	RemoveBuildingForPlayer(playerid, 3170, -1482.3672, 2704.8047, 54.8047, 0.25);
	RemoveBuildingForPlayer(playerid, 16004, -843.8359, 2746.0078, 47.7109, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -864.7656, 2747.5547, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -878.2344, 2746.2656, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -815.8672, 2751.4141, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -827.1328, 2750.7422, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -865.9219, 2763.5469, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -878.8594, 2762.5156, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -828.8672, 2766.4609, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -817.5625, 2767.2656, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -840.3516, 2763.8359, 45.1406, 0.25);
	RemoveBuildingForPlayer(playerid, 3243, -850.4375, 2763.0313, 45.1406, 0.25);
	//end
	MyTD[playerid] = CreatePlayerTextDraw(playerid, 40.0, 140.0, "_~N~Example text!~N~_");
	PlayerTextDrawUseBox(playerid, MyTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, MyTD[playerid], 0x00000066); // Set the box color to a semi-transparent black
	PlayerTextDrawAlignment(playerid, MyTD[playerid], 2);
	TextDrawShowForPlayer(playerid,AreaMotd);
	if(!IsPlayerNPC(playerid))
    	{

        if(!IsValidName(playerid))
        {
		    SendClientMessage(playerid, GREY, "You have been kicked for having a Non-RP name.");
		    INI_Remove("Accounts/None.ini");
		    Kick(playerid);
	    }
        else if(fexist(Accounts(playerid)))
        {
            GetPlayerIp(playerid, PlayerStat[playerid][LastIP], 21);

      		PlayAudioStreamForPlayer(playerid, "http://dl.dropbox.com/u/26474886/OnPlayerConnection.mp3");
        	SetTimerEx("DisableAudio", 5000, false, "is", 1337, "hello!");

            ClearChatForPlayer(playerid);

            SendClientMessage(playerid, GREEN, "--------------------------------------------------------------------------------");
            SendClientMessage(playerid, WHITE, "                Welcome back to Basic Roleplay                      ");
            SendClientMessage(playerid, WHITE, "            Type the account's password below to login.                  ");
            SendClientMessage(playerid, WHITE, "          Don't forget to visit our website tobechanged.com                 ");
            SendClientMessage(playerid, GREEN, "--------------------------------------------------------------------------------");

            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"Login","Welcome to Basic Roleplay.\nInput your password below to login.","Login","Quit");
        }
        else
        {
            GetPlayerIp(playerid, PlayerStat[playerid][LastIP], 21);

            ClearChatForPlayer(playerid);

            SendClientMessage(playerid, GREEN, "--------------------------------------------------------------------------------");
            SendClientMessage(playerid, WHITE, "                 Welcome back to Basic Roleplay                      ");
            SendClientMessage(playerid, WHITE, "           Type a password below to register a new account.               ");
            SendClientMessage(playerid, WHITE, "          Don't forget to visit our website tobechanged.com                  ");
            SendClientMessage(playerid, GREEN, "--------------------------------------------------------------------------------");

		    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT,"Registering","Welcome to Basic Roleplay.\nInput your password below to register a new account.","Register","Quit");
		}
        SetPlayerColor(playerid, GREY);
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
		SavePlayerData(playerid);
		new str[128];
        switch(reason)
	    {
		    case 0:
			{
			    format(str, sizeof(str), "%s has left the server (Timeout).", GetOOCName(playerid));
			    SendNearByMessage(playerid, WHITE, str, 4);
			}
            case 1:
			{
				format(str, sizeof(str), "%s has left the server (Leaving).", GetOOCName(playerid));
				SendNearByMessage(playerid, WHITE, str, 4);
			}
            case 2:
            {
				format(str, sizeof(str), "%s has left the server (Kicked/Banned).", GetOOCName(playerid));
				SendNearByMessage(playerid, WHITE, str, 4);
			}
		}
		return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerColor(playerid, WHITE);
 	TogglePlayerControllable(playerid, 0);
 	SetTimerEx("FreezeTimer", 1500, false, "i", playerid);
 	TextDrawHideForPlayer(playerid,AreaMotd);
	return 1;
}

forward FreezeTimer(playerid);
public FreezeTimer(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public SendNearByMessage(playerid, color, str[], Float:radius)
{
	new Float: PosX, Float: PosY, Float: PosZ;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(playerid) && PlayerStat[playerid][Spawned] == 1)
	   	{
	   		GetPlayerPos(playerid, PosX, PosY, PosZ);
	   		if(IsPlayerInRangeOfPoint(i, radius, PosX, PosY, PosZ))
	   		{
			    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i) && GetPlayerInterior(playerid) == GetPlayerInterior(i))
	    	    {
	    			SendClientMessage(i, color, str);
	    		}
	    	}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(PlayerStat[playerid][Logged] == 0)
	{
		SendClientMessage(playerid, GREY, "You must be logged in.");
		return 0;
	}
	if(PlayerStat[playerid][FullyRegistered] == 0)
	{
		SendClientMessage(playerid, GREY, "You must enter your character information before using commands.");
		return 0;
	}
	if(PlayerStat[playerid][Spawned] == 0)
	{
		SendClientMessage(playerid, GREY, "You must be spawned.");
		return 0;
 	}
    else return 1;
}

COMMAND:stats(playerid, params[])
{
	ShowStatsForPlayer(playerid, playerid);
	return 1;
}

COMMAND:me(playerid, params[])
{
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /me [action]");
	format(str, sizeof(str), "* %s %s", GetICName(playerid), message);
    SendNearByMessage(playerid, ACTION_COLOR, str, 10);
    ICLog(str);
    return 1;
}

COMMAND:do(playerid, params[])
{
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /do [action]");
	format(str, sizeof(str), "* %s ((%s))",message, GetICName(playerid));
    SendNearByMessage(playerid, ACTION_COLOR, str, 5);
    ICLog(str);
    return 1;
}

COMMAND:b(playerid, params[])
{
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /b [message]");
	format(str, sizeof(str), "(( %s: %s ))", GetOOCName(playerid), message);
    SendNearByMessage(playerid, GREY, str, 4);
    OOCLog(str);
    return 1;
}

COMMAND:low(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /l{ow} [message]");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "[LOW]%s says: %s", GetICName(playerid),  message);
    SendNearByMessage(playerid, GREY, str, 3);
    ICLog(str);
    return 1;
}

COMMAND:l(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /l{ow} [message]");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "[LOW]%s says: %s", GetICName(playerid),  message);
    SendNearByMessage(playerid, GREY, str, 3);
    ICLog(str);
    return 1;
}

COMMAND:s(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /s{hout} [message]");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "%s shouts: %s!", GetICName(playerid), message);
    SendNearByMessage(playerid, WHITE, str, 7);
    ICLog(str);
    return 1;
}

COMMAND:shout(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new message[128], str[128];
    if(sscanf(params,"s[128]", message))return SendClientMessage(playerid, GREY, "USAGE: /s{hout} [message]");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "%s shouts: %s!", GetICName(playerid), message);
    SendNearByMessage(playerid, WHITE, str, 7);
    ICLog(str);
    return 1;
}

COMMAND:w(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new targetid, message[128], str[128];
    if(sscanf(params,"us[128]", targetid, message))return SendClientMessage(playerid, GREY, "USAGE: /w{hisper} [playerid] [message]");
    if(targetid == playerid) return SendClientMessage(playerid, GREY, "You can't send a whisper to yourself.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    if(!IsPlayerInRangeOfPlayer(3, playerid, targetid)) return SendClientMessage(playerid, GREY, "Target ID is too far away.");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "%s whispers to you: %s", GetICName(playerid), message);
    SendClientMessage(targetid, WHITE, str);
    format(str, sizeof(str), "You whispered to %s: %s", GetICName(targetid), message);
    SendClientMessage(playerid, WHITE, str);
    format(str, sizeof(str), "* %s whispers something to %s.",GetICName(playerid), GetICName(targetid));
    SendNearByMessage(playerid, ACTION_COLOR, str, 5);
    return 1;
}

COMMAND:whisper(playerid, params[])
{
    if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
	new targetid, message[128], str[128];
    if(sscanf(params,"us[128]", targetid, message))return SendClientMessage(playerid, GREY, "USAGE: /w{hisper} [playerid] [message]");
    if(targetid == playerid) return SendClientMessage(playerid, GREY, "You can't send a whisper to yourself.");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    if(!IsPlayerInRangeOfPlayer(3, playerid, targetid)) return SendClientMessage(playerid, GREY, "Target ID is too far away.");
    if(strlen(message) < 1) return SendClientMessage(playerid, GREY, "Message is too short.");
    if(strlen(message) > 100) return SendClientMessage(playerid, GREY, "Message is too long.");
	format(str, sizeof(str), "%s whispers to you: %s", GetICName(playerid), message);
    SendClientMessage(targetid, WHITE, str);
    format(str, sizeof(str), "you whispered to %s: %s", GetICName(targetid), message);
    SendClientMessage(playerid, WHITE, str);
    format(str, sizeof(str), "* %s whispers something to %s.",GetICName(playerid), GetICName(targetid));
    SendNearByMessage(playerid, ACTION_COLOR, str, 5);
    return 1;
}

COMMAND:ahelp(playerid, params[])
{
	{
	if(PlayerStat[playerid][AdminLevel] < 5) return SendClientMessage(playerid, GREY, "You can't use this command.");
	}
	if(PlayerStat[playerid][AdminLevel] == 1)
	SendClientMessage(playerid, RED, "==== Administrator Commands ====");
	SendClientMessage(playerid, GREEN, "Level 1.");
	SendClientMessage(playerid, WHITE, "/kick, /ban, /goto, /setvirtualworld.");
		
	if(PlayerStat[playerid][AdminLevel] == 2)
	SendClientMessage(playerid, RED, "==== Administrator Commands ====");
	SendClientMessage(playerid, GREEN, "Level 1.");
	SendClientMessage(playerid, WHITE, "/kick, /ban, /goto, /setvirtualworld.");
	SendClientMessage(playerid, GREEN, "Level 2.");
	SendClientMessage(playerid, WHITE, "/get.");
	
	if(PlayerStat[playerid][AdminLevel] == 3)
	SendClientMessage(playerid, RED, "==== Administrator Commands ====");
	SendClientMessage(playerid, GREEN, "Level 1.");
	SendClientMessage(playerid, WHITE, "/kick, /ban, /goto, /setvirtualworld.");
	SendClientMessage(playerid, GREEN, "Level 2.");
	SendClientMessage(playerid, WHITE, "/get.");
	SendClientMessage(playerid, GREEN, "Level 3.");
	SendClientMessage(playerid, WHITE, "/gotopos.");

	if(PlayerStat[playerid][AdminLevel] == 4)
	SendClientMessage(playerid, RED, "==== Administrator Commands ====");
	SendClientMessage(playerid, GREEN, "Level 1.");
	SendClientMessage(playerid, WHITE, "/kick, /ban, /goto, /setvirtualworld.");
	SendClientMessage(playerid, GREEN, "Level 2.");
	SendClientMessage(playerid, WHITE, "/get.");
	SendClientMessage(playerid, GREEN, "Level 3.");
	SendClientMessage(playerid, WHITE, "/gotopos.");
	SendClientMessage(playerid, GREEN, "Level 4.");
	SendClientMessage(playerid, WHITE, "/makegangleader, /makeleader, /resetgang.");

	if(PlayerStat[playerid][AdminLevel] == 5)
	SendClientMessage(playerid, RED, "==== Administrator Commands ====");
	SendClientMessage(playerid, GREEN, "Level 1.");
	SendClientMessage(playerid, WHITE, "/kick, /ban, /goto, /setvirtualworld.");
	SendClientMessage(playerid, GREEN, "Level 2.");
	SendClientMessage(playerid, WHITE, "/get.");
	SendClientMessage(playerid, GREEN, "Level 3.");
	SendClientMessage(playerid, WHITE, "/gotopos.");
	SendClientMessage(playerid, GREEN, "Level 4.");
	SendClientMessage(playerid, WHITE, "/makegangleader, /makeleader, /resetgang.");
	SendClientMessage(playerid, GREEN, "Level 5.");
	SendClientMessage(playerid, WHITE, "/makeadmin, /gmx, /set.");
	return 1;
}

COMMAND:help(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Help menu", "General Commands\nBugs\nUpdates", "Select", "Quit");
    return 1;
}

COMMAND:admins(playerid, targetid, params[])
{
	new str[128];
	SendClientMessage(playerid, WHITE, "-------------------------");
	SendClientMessage(playerid, RED, "Online Basic Roleplay Staff Team:");
	for(new i = 0; i < MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i) && PlayerStat[i][AdminLevel] >= 1)
		{
            format(str, sizeof(str), "%s %s.", GetAdminRank(i), GetOOCName(i));
            SendClientMessage(playerid, RED, str);
        }
	}
    SendClientMessage(playerid, WHITE, "-------------------------");
    return 1;
}

// DMV Commands

CMD:getlic(playerid, params[])
{
	if(PlayerStat[playerid][Logged] == 0)
    if(!IsPlayerInRangeOfPoint(playerid,2.0,188.8443, 1738.0453, 4.3581)) return SendClientMessage(playerid, GREY, "You are not by the DMV desk.");
    if(PlayerStat[playerid][CarLic]) return SendClientMessage(playerid, GREY, "You already have a drivers license.");
    if(LicenseTest[playerid]) return SendClientMessage(playerid, GREY, "You have already started the drivers license test.");
    if(PlayerStat[playerid][Money] < 100) return SendClientMessage(playerid, GREY, "You don't have enough money on you. ($100)");
	//SetMoney(playerid, -100);
	GiveMoney(playerid, -1000);
	LicenseTest[playerid] =1;
	CP[playerid] = 1;
	SendClientMessage(playerid,COLOR_DMV,"* Drivers Center: Get into a car outside to begin the test.");
	return 1;
}

// Admin Commands.
COMMAND:kickall(playerid, params[])
{
	new str[128];
	if(PlayerStat[playerid][AdminLevel] < 5) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"us[128]")) return SendClientMessage(playerid, GREY, "USAGE: /kickall");
	format(str, sizeof(str), "Admin %s has kicked everyone.", GetOOCName(playerid));
	SendClientMessageToAll(RED, str);
	AdminActionLog(str);
	KickAll();
    return 1;
}

COMMAND:setvirtualworld(playerid, params[])
{
	new targetid, virtualworld, str[128];
	if(PlayerStat[playerid][AdminLevel] < 1) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"ud", targetid , virtualworld))return SendClientMessage(playerid, GREY, "USAGE: /setvirtualworld [playerid] [virtualworld]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
	SetPlayerVirtualWorld(targetid, virtualworld);
	format(str, sizeof(str), "Your virtual world has been set to ~r~ %d ~w~ by an admin", virtualworld);
	GameTextForPlayer(targetid, str, 3000, 4);
	format(str, sizeof(str), "Admin %s has set %s's virtual world to %d", GetOOCName(playerid), GetOOCName(targetid),virtualworld);
	AdminActionLog(str);
    return 1;
}

COMMAND:get(playerid, params[])
{
	new targetid;
	if(PlayerStat[playerid][AdminLevel] < 1) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"u", targetid))return SendClientMessage(playerid, GREY, "USAGE: /get [playerid]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
	if(playerid == targetid) return SendClientMessage(playerid, GREY, "You can't get yourself.");
	new Float: PosX, Float: PosY, Float: PosZ;
	GetPlayerPos(playerid, PosX, PosY, PosZ);
	SetPlayerPos(targetid, PosX, PosY, PosZ + 0.5);
	SetPlayerInterior(targetid, GetPlayerInterior(playerid));
	SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
    return 1;
}

COMMAND:makeadmin(playerid, params[])
{
	new targetid, alevel, str[128];
	if(PlayerStat[playerid][AdminLevel] < 5) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"ud", targetid, alevel))return SendClientMessage(playerid, GREY, "USAGE: /makeadmin [playerid] [adminlevel]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    if(alevel < 0) return SendClientMessage(playerid, GREY, "Invalid admin level.");
    if(PlayerStat[targetid][AdminLevel] <= alevel)
	{
        format(str, sizeof(str), "Admin %s has promoted %s to level %d admin.", GetOOCName(playerid), GetOOCName(targetid), alevel);
        SendClientMessageToAll(RED, str);
        AdminActionLog(str);
        PlayerStat[targetid][AdminLevel] = alevel;
    }
    if(PlayerStat[targetid][AdminLevel] > alevel)
	{
        format(str, sizeof(str), "Admin %s has demoted %s to level %d admin.", GetOOCName(playerid), GetOOCName(targetid), alevel);
        SendClientMessageToAll(RED, str);
        AdminActionLog(str);
        PlayerStat[targetid][AdminLevel] = alevel;
    }
    return 1;
}

COMMAND:kick(playerid, params[])
{
	new str[128], targetid, reason[128];
	if(PlayerStat[playerid][AdminLevel] < 1) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"us[128]", targetid, reason)) return SendClientMessage(playerid, GREY, "USAGE: /kick [playerid] [reason]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
	if(PlayerStat[targetid][AdminLevel] > PlayerStat[playerid][AdminLevel]) return SendClientMessage(playerid, GREY, "Target ID has a higher admin level.");
	PlayerStat[targetid][TimesKicked]++;
	format(str, sizeof(str), "Admin %s has kicked %s. Reason %s.", GetOOCName(playerid), GetOOCName(targetid), reason);
	SendClientMessageToAll(RED, str);
	AdminActionLog(str);
	Kick(targetid);
    return 1;
}

COMMAND:ban(playerid, params[])
{
	new str[128], targetid, reason[60];
	if(PlayerStat[playerid][AdminLevel] < 1) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"us[60]", targetid, reason))return SendClientMessage(playerid, GREY, "USAGE: /ban [playerid] [reason]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
	if(PlayerStat[targetid][AdminLevel] > PlayerStat[playerid][AdminLevel]) return SendClientMessage(playerid, GREY, "Target ID has a higher admin level.");
	PlayerStat[targetid][Banned] = 1;
	PlayerStat[targetid][TimesBanned]++;
	new Day, Month, Year;
	getdate(Year, Month, Day);
	format(str, sizeof(str), "Admin %s has banned %s, Date: %04d/%02d/%02d, Reason: %s.", GetOOCName(playerid), GetOOCName(targetid), Year, Month, Day, reason);
	SendClientMessageToAll(RED, str);
	AdminActionLog(str);
	format(str, sizeof(str), "%s Banned.", GetOOCName(targetid));
	BanLog(str);
    Kick(targetid);
    return 1;
}

COMMAND:gmx(playerid, targetid, params[])
{
	if(PlayerStat[playerid][AdminLevel] < 5) return SendClientMessage(playerid, GREY, "You are not authorized to use this command.");
	GMX(playerid);
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	format(string, sizeof(string), "%s %s has issued a server restart, it will occur in 30 seconds.", GetAdminRank(playerid), GetOOCName(playerid));
	SendClientMessageToAll(GOLD, string);
	SetTimer("gmxtimer", 30000, false);
	return 1;
}

COMMAND:makegangleader(playerid, params[])
{
	new targetid, Gang, str[128];
	if(PlayerStat[playerid][AdminLevel] < 4) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"ud", targetid, Gang))return SendClientMessage(playerid, GREY, "USAGE: /makegangleader [playerid] [gangid]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    if(Gang <= 0) return SendClientMessage(playerid, GREY, "Invalid Gang ID.");
    if(Gang >= 7) return SendClientMessage(playerid, GREY, "Invalid Gang ID.");
    format(str, sizeof(str), "Admin %s has made %s leader of Gang ID %d.", GetOOCName(playerid), GetOOCName(targetid), Gang);
    SendClientMessageToAll(RED, str);
    AdminActionLog(str);
    PlayerStat[targetid][GangID] = Gang;
    PlayerStat[targetid][GangRank] = 6;
    PlayerStat[targetid][FactionID] = 0;
    PlayerStat[targetid][FactionRank] = 0;
    format(GangStat[PlayerStat[targetid][GangID]][GangFile], 60, "Gangs/Gang %d.ini", PlayerStat[targetid][GangID]);
    format(GangStat[PlayerStat[targetid][GangID]][Leader], 60, "%s", GetOOCName(targetid));
    if(INI_Open(GangStat[PlayerStat[targetid][GangID]][GangFile])) return INI_WriteString("Leader", GangStat[PlayerStat[targetid][GangID]][Leader]);
    return 1;
}

COMMAND:makeleader(playerid, params[])
{
	new targetid, Faction, str[128];
	if(PlayerStat[playerid][AdminLevel] < 4) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"ud", targetid, Faction))return SendClientMessage(playerid, GREY, "USAGE: /makeleader [playerid] [factionid]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    if(Faction <= 0) return SendClientMessage(playerid, GREY, "Invalid Faction ID.");
    if(Faction >= 3) return SendClientMessage(playerid, GREY, "Invalid Faction ID.");
    if(Faction == 1)
    {
        format(str, sizeof(str), "Administrator %s has made %s leader of the El Quebrados Sheriff's Department.", GetOOCName(playerid), GetOOCName(targetid));
        SendClientMessageToAll(RED, str);
        AdminActionLog(str);
        PlayerStat[targetid][GangID] = 0;
        PlayerStat[targetid][GangRank] = 0;
        PlayerStat[targetid][FactionID] = 1;
        PlayerStat[targetid][FactionRank] = 6;
    }
    else if(Faction == 2)
    {
        format(str, sizeof(str), "Administrator %s has made %s leader of the El Quebrados Medical Department.", GetOOCName(playerid), GetOOCName(targetid));
        SendClientMessageToAll(RED, str);
        AdminActionLog(str);
        PlayerStat[targetid][GangID] = 0;
        PlayerStat[targetid][GangRank] = 0;
        PlayerStat[targetid][FactionID] = 2;
        PlayerStat[targetid][FactionRank] = 6;
    }
    return 1;
}

COMMAND:resetgang(playerid, params[])
{
	new Gang, str[128];
	if(PlayerStat[playerid][AdminLevel] < 4) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"d", Gang))return SendClientMessage(playerid, GREY, "USAGE: /resetgang [gangid]");
    if(Gang <= 0) return SendClientMessage(playerid, GREY, "Invalid Gang ID.");
    if(Gang >= 7) return SendClientMessage(playerid, GREY, "Invalid Gang ID.");
    format(GangStat[Gang][GangFile], 60, "Gangs/Gang %d.ini", Gang);
    if(INI_Open(GangStat[Gang][GangFile]))
    {
		format(GangStat[Gang][Leader], 60, "Nobody");
		format(GangStat[Gang][GangName], 60, "Nothing");
		format(GangStat[Gang][Rank1], 60, "None");
		format(GangStat[Gang][Rank2], 60, "None");
		format(GangStat[Gang][Rank3], 60, "None");
		format(GangStat[Gang][Rank4], 60, "None");
		format(GangStat[Gang][Rank5], 60, "None");
		format(GangStat[Gang][Rank6], 60, "None");
		format(GangStat[Gang][MOTD], 128, "None.");
		GangStat[Gang][Members] = 0;

		SaveGang(Gang);

		format(str, sizeof(str), "Admin %s has re-settedn Gang ID %d.", GetOOCName(playerid), Gang);
        SendClientMessageToAll(RED, str);
        AdminActionLog(str);

		for(new i = 0; i < MAX_PLAYERS; i++)
	    {
			if(IsPlayerConnected(i) && PlayerStat[i][GangID] == Gang)
			{
				SendClientMessage(i, RED, "You have been kicked from your gang by an admin");
			    PlayerStat[playerid][GangID] = 0;
                PlayerStat[playerid][GangRank] = 0;
            }
        }
	}
	return 1;
}

COMMAND:goto(playerid, params[])
{
	new str[128], targetid;
	if(PlayerStat[playerid][AdminLevel] < 1) return SendClientMessage(playerid, GREY, "You can't use this command.");
	if(sscanf(params,"u", targetid))return SendClientMessage(playerid, GREY, "USAGE: /goto [playerid]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
	if(playerid == targetid) return SendClientMessage(playerid, GREY, "You can't teleport to yourself.");
	new Float: PosX, Float: PosY, Float: PosZ;
	GetPlayerPos(targetid, PosX, PosY, PosZ);
	SetPlayerPos(playerid, PosX, PosY, PosZ + 0.5);
	SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
	format(str, sizeof(str), "Teleported to %s.", GetOOCName(targetid));
	SendClientMessageToAll(WHITE, str);
    return 1;
}

COMMAND:gotopos(playerid,params[])
{
    new Float: PosX, Float: PosY, Float: PosZ, Interior, str[128];
    if(PlayerStat[playerid][AdminLevel] < 3) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"fffd" ,PosX, PosY, PosZ, Interior))return SendClientMessage(playerid, GREY, "USAGE: /gotopos [PosX] [PosY] [PosZ] [Interior]");
    SetPlayerPos(playerid ,PosX, PosY, PosZ);
	SetPlayerInterior(playerid, Interior);
	format(str, sizeof(str), "Teleported to X: %f, Y: %f, Z: %f and Interior: %d.", PosX, PosY, PosZ, Interior);
	SendClientMessage(playerid, RED, str);
    return 1;
}

COMMAND:set(playerid, params[])
{
    new targetid, item[30], quantity, str[128];
    if(PlayerStat[playerid][AdminLevel] < 5) return SendClientMessage(playerid, GREY, "You can't use this command.");
    if(sscanf(params,"us[20]d", targetid, item, quantity))
	{
	    SendClientMessage(playerid, GREY, "USAGE: /set [playerid] [item] [quantity]");
	    SendClientMessage(playerid, GREY, "Items: Money, Age, Skin, Health, Armour, Sex.");
	    return 1;
	}
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, GREY, "Target ID not found.");
    else if(!strcmp(item, "money", true))
    {
		SetMoney(targetid, quantity);
		format(str, sizeof(str), "You have changed %s's money to $%d.", GetOOCName(targetid), quantity);
		SendClientMessage(playerid, RED, str);
		format(str, sizeof(str), "An admin has set your money to $%d.", quantity);
		SendClientMessage(targetid, RED, str);
    }
    else if(!strcmp(item, "age", true))
    {
		if(18 <= quantity <= 70)
		{
		    PlayerStat[targetid][Age] = quantity;
		    format(str, sizeof(str), "You have changed %s's age to %d years.", GetOOCName(targetid), quantity);
	    	SendClientMessage(playerid, RED, str);
		    format(str, sizeof(str), "An admin has set your age to %d years old.", quantity);
	    	SendClientMessage(targetid, RED, str);
	    }
	    else return SendClientMessage(playerid, GREY, "Age must be between 18 and 70.");
    }
    else if(!strcmp(item, "skin", true))
    {
		SetSkin(targetid, quantity);
		format(str, sizeof(str), "You have changed %s's skin to %d.", GetOOCName(targetid), quantity);
		SendClientMessage(playerid, RED, str);
		format(str, sizeof(str), "An admin has set your skin to %d.", quantity);
		SendClientMessage(targetid, RED, str);
    }
    else if(!strcmp(item, "health", true))
    {
		SetHealth(targetid, quantity);
		format(str, sizeof(str), "You have changed %s's health to %d.", GetOOCName(targetid), quantity);
		SendClientMessage(playerid, RED, str);
		format(str, sizeof(str), "An admin has set your health to %d.", quantity);
		SendClientMessage(targetid, RED, str);
    }
    else if(!strcmp(item, "armour", true))
    {
		SetArmour(targetid, quantity);
		format(str, sizeof(str), "You have changed %s's armour to %d.", GetOOCName(targetid), quantity);
		SendClientMessage(playerid, RED, str);
		format(str, sizeof(str), "An admin has set your armour to %d.", quantity);
		SendClientMessage(targetid, RED, str);
    }
    else if(!strcmp(item, "sex", true))
    {
		PlayerStat[targetid][Gender] = quantity;
		format(str, sizeof(str), "You have changed %s's Sex to %d.", GetOOCName(targetid), quantity);
		SendClientMessage(playerid, RED, str);
		format(str, sizeof(str), "An admin has set your Sex to %d.", quantity);
		SendClientMessage(targetid, RED, str);
    }
    else return SendClientMessage(playerid, GREY, "Invalid Item.");
    return 1;
}
// End Admin Commands

COMMAND:accept(playerid, params[])
{
    if(PlayerStat[playerid][InHospital] == 1 || PlayerStat[playerid][Tased] == 1 || PlayerStat[playerid][Cuffed] == 1) return SendClientMessage(playerid, GREY, "You can't use this command right now.");
    if(isnull(params)) return SendClientMessage(playerid, GREY, "USAGE: /accept [gang/faction]");
	else if(!strcmp(params, "faction", true))
	{
        if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
		new str[128];
		if(PlayerStat[playerid][BeingInvitedToFaction] == 0) return SendClientMessage(playerid, GREY, "Nobody invited you to join a faction.");
		PlayerStat[playerid][FactionID] = PlayerStat[playerid][BeingInvitedToFaction];
		PlayerStat[playerid][FactionRank] = 1;
        if(PlayerStat[playerid][FactionID] == 1)
	    {
	        format(str, sizeof(str), "%s has accepted to join the Department of Corrections, welcome!", GetOOCName(playerid));
	        SendFactionMessage(playerid, GUARDS_RADIO, str);
	    }
        else if(PlayerStat[playerid][FactionID] == 2)
	    {
	        format(str, sizeof(str), "%s has accepted to join the San Andreas Prison Infirmary, welcome!", GetOOCName(playerid));
	        SendFactionMessage(playerid, DOCTORS_RADIO, str);
        }
	}
	else if(!strcmp(params, "gang", true))
	{
        if(PlayerStat[playerid][Dead] == 1 || PlayerStat[playerid][InHospital] == 1) return SendClientMessage(playerid, GREY, "You are unconscious.");
		new str[128];
		if(PlayerStat[playerid][BeingInvitedToGang] == 0) return SendClientMessage(playerid, GREY, "Nobody invited you to join a gang.");
		PlayerStat[playerid][GangID] = PlayerStat[playerid][BeingInvitedToGang];
		PlayerStat[playerid][GangRank] = 1;
		format(str, sizeof(str), "%s has accepted to join %s, Welcome!", GetOOCName(playerid), GangStat[PlayerStat[playerid][GangID]][GangName]);
        SendGangMessage(playerid, GangStat[PlayerStat[playerid][GangID]][Color], str);
        GangStat[PlayerStat[playerid][GangID]][Members] += 1;
        format(GangStat[PlayerStat[playerid][GangID]][GangFile], 60, "Gangs/Gang %d.ini", PlayerStat[playerid][GangID]);
        if(INI_Open(GangStat[PlayerStat[playerid][GangID]][GangFile]))
        {
            INI_WriteInt("Members", GangStat[PlayerStat[playerid][GangID]][Members]);
            INI_Save();
            INI_Close();
        }
	}
	return 1;
}

forward gmxtimer(playerid);
public gmxtimer(playerid)
{
    foreach(Player, i)
    {
       	GMX1[i] = 1;
       	SavePlayerData(playerid);
    }
	SendRconCommand("gmx");
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
		if(IsDMVCar(vehicleid))
		{
		    if(!LicenseTest[playerid])
		    {
			    new Float:pos[3];
			    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
			    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		        SendClientMessage(playerid, GREY, "You are not taking a drivers license test.");
		    }
		    else
		    {
		        SendClientMessage(playerid, COLOR_DMV, "* GPS: Finish the test by driving through all of the checkpoints,around fort carson back to the DMV.");
		        SetPlayerCheckpoint(playerid,-1260.7194,2694.6663,49.8266,5);
		        SendClientMessage(playerid, RED, "Do not exit your car otherwise your test will be failed and will have to be re-done");
		    }
		}
		else if(IsSDCar(vehicleid) && PlayerStat[playerid][FactionID] != 1)
	    {
		    new Float:pos[3];
		    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SendClientMessage(playerid, GOLD, " This vehicle is restricted to the EQSD faction.");
	    }
	    else if(IsEMSCar(vehicleid) && PlayerStat[playerid][FactionID] != 2)
	    {
		    new Float:pos[3];
		    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SendClientMessage(playerid, GOLD, " This vehicle is restricted to the EQ-EMS faction.");
	    }
	    else if(IsGOVCar(vehicleid) && PlayerStat[playerid][FactionID] != 3)
	    {
		    new Float:pos[3];
		    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		    SendClientMessage(playerid, GOLD, " This vehicle is restricted to the Governement faction.");
	    }
		return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(LicenseTest[playerid])
	{
		DisablePlayerCheckpoint(playerid);
		LicenseTest[playerid] = 0;
		CP[playerid] = 0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, COLOR_DMV, "* Driving Center: You have left your car, therefore your test has been failed.");
	}
	/*if(LicenseTestP[playerid])
	{
		DisablePlayerCheckpoint(playerid);
		LicenseTestP[playerid] = 0;
		CPFly[playerid] = 0;
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Pilot Center: You have left your maverick, therefore your test has been failed.");
	}*/
	if(PlayerStat[playerid][FactionID] == 0)
	{
	    LastCar[playerid] = vehicleid;
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
if(CP[playerid] == 1) // Drivers License Test
	{
		if(IsPlayerInRangeOfPoint(playerid,5,-1260.7194,2694.6663,49.8266)) // Checkpoint 1
		{
		    SetPlayerCheckpoint(playerid,-1317.6917,2660.4553,49.9034,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1317.6917,2660.4553,49.9034)) // Checkpoint 2
		{
		    SetPlayerCheckpoint(playerid,-1374.3701,2610.0176,53.8429,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1374.3701,2610.0176,53.8429)) // Checkpoint 3
		{
			SetPlayerCheckpoint(playerid,-1413.9224,2603.1677,55.4211,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1413.9224,2603.1677,55.4211)) // Checkpoint 4
		{
			SetPlayerCheckpoint(playerid,-1439.6835,2673.0615,55.4306,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1439.6835,2673.0615,55.4306)) // Checkpoint 5
		{
			SetPlayerCheckpoint(playerid,-1483.0125,2673.7649,55.4350,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1483.0125,2673.7649,55.4350)) // Checkpoint 6
		{
			SetPlayerCheckpoint(playerid,-1532.4152,2673.7100,55.4324,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1532.4152,2673.7100,55.4324)) // Checkpoint 7
		{
			SetPlayerCheckpoint(playerid,-1548.4847,2612.7024,55.4332,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1548.4847,2612.7024,55.4332)) // Checkpoint 8
		{
			SetPlayerCheckpoint(playerid,-1527.3284,2548.5583,55.4337,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1527.3284,2548.5583,55.4337)) // Checkpoint 9
		{
			SetPlayerCheckpoint(playerid,-1493.8063,2586.9353,55.4354,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1493.8063,2586.9353,55.4354)) // Checkpoint 10
		{
			SetPlayerCheckpoint(playerid,-1438.9851,2598.8762,55.4351,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1438.9851,2598.8762,55.4351)) // Checkpoint 11
		{
			SetPlayerCheckpoint(playerid,-1391.0577,2599.1448,55.2371,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1391.0577,2599.1448,55.2371)) // Checkpoint 12
		{
			SetPlayerCheckpoint(playerid,-1422.2595,2510.6897,61.6368,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1422.2595,2510.6897,61.6368)) // Checkpoint 13
		{
			SetPlayerCheckpoint(playerid,-1408.8035,2293.3911,54.7593,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1408.8035,2293.3911,54.7593)) // Checkpoint 14
		{
			SetPlayerCheckpoint(playerid,-1345.4774,2115.6318,48.5341,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1345.4774,2115.6318,48.5341)) // Checkpoint 15
		{
			SetPlayerCheckpoint(playerid,-1326.6051,1981.4150,50.9583,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1326.6051,1981.4150,50.9583)) // Checkpoint 16
		{
			SetPlayerCheckpoint(playerid,-1183.9515,1807.6354,40.4953,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1183.9515,1807.6354,40.4953)) // Checkpoint 17
		{
			SetPlayerCheckpoint(playerid,-1045.7943,1843.8173,55.6865,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1045.7943,1843.8173,55.6865)) // Checkpoint 18
		{
			SetPlayerCheckpoint(playerid,-893.6824,1790.1135,59.8250,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-893.6824,1790.1135,59.8250)) // Checkpoint 19
		{
			SetPlayerCheckpoint(playerid,-870.5801,1929.3770,59.8574,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-870.5801,1929.3770,59.8574)) // Checkpoint 20
		{
			SetPlayerCheckpoint(playerid,-497.8629,1985.6002,59.9409,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-497.8629,1985.6002,59.9409)) // Checkpoint 21
		{
			SetPlayerCheckpoint(playerid,-401.4277,2077.2068,61.4113,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-401.4277,2077.2068,61.4113)) // Checkpoint 22
		{
			SetPlayerCheckpoint(playerid,-459.3476,1979.6223,79.9793,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-459.3476,1979.6223,79.9793)) // Checkpoint 23
		{
			SetPlayerCheckpoint(playerid,-470.2452,1784.1230,74.0922,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-470.2452,1784.1230,74.0922)) // Checkpoint 24
		{
			SetPlayerCheckpoint(playerid,-430.1774,1871.5712,62.1439,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-430.1774,1871.5712,62.1439)) // Checkpoint 25
		{
			SetPlayerCheckpoint(playerid,-404.9424,1744.2050,41.7759,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-404.9424,1744.2050,41.7759)) // Checkpoint 26
		{
			SetPlayerCheckpoint(playerid,-377.3472,1293.5734,24.5122,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-377.3472,1293.5734,24.5122)) // Checkpoint 27
		{
			SetPlayerCheckpoint(playerid,-110.0201,1251.7935,15.9808,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-110.0201,1251.7935,15.9808)) // Checkpoint 28
		{
			SetPlayerCheckpoint(playerid,173.5700,1143.9146,13.9842,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,173.5700,1143.9146,13.9842)) // Checkpoint 29
		{
			SetPlayerCheckpoint(playerid,255.5711,1214.2163,15.3655,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,255.5711,1214.2163,15.3655)) // Checkpoint 30
		{
			SetPlayerCheckpoint(playerid,376.8543,1492.8822,8.9911,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,376.8543,1492.8822,8.9911)) // Checkpoint 31
		{
			SetPlayerCheckpoint(playerid,505.5781,1659.4467,13.1762,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,505.5781,1659.4467,13.1762)) // Checkpoint 32
		{
			SetPlayerCheckpoint(playerid,584.1212,1819.5228,13.6795,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,584.1212,1819.5228,13.6795)) // Checkpoint 33
		{
			SetPlayerCheckpoint(playerid,608.7386,2048.9285,36.2321,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,608.7386,2048.9285,36.2321)) // Checkpoint 34
		{
			SetPlayerCheckpoint(playerid,509.9402,2357.4634,29.8565,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,509.9402,2357.4634,29.8565)) // Checkpoint 35
		{
			SetPlayerCheckpoint(playerid,273.9745,2288.2498,24.7684,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,273.9745,2288.2498,24.7684)) // Checkpoint 36
		{
			SetPlayerCheckpoint(playerid,-13.2794,2302.7749,24.5106,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-13.2794,2302.7749,24.5106)) // Checkpoint 37
		{
			SetPlayerCheckpoint(playerid,-521.4971,2428.2092,58.3551,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-521.4971,2428.2092,58.3551)) // Checkpoint 39
		{
			SetPlayerCheckpoint(playerid,-730.0899,2615.9016,67.4429,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-730.0899,2615.9016,67.4429)) // Checkpoint 40
		{
			SetPlayerCheckpoint(playerid,-696.9487,2684.7356,56.3441,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-696.9487,2684.7356,56.3441)) // Checkpoint 41
		{
			SetPlayerCheckpoint(playerid,-761.1194,2696.5459,47.9677,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-761.1194,2696.5459,47.9677)) // Checkpoint 42
		{
			SetPlayerCheckpoint(playerid,-775.5515,2720.2551,45.0647,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-775.5515,2720.2551,45.0647)) // Checkpoint 43
		{
			SetPlayerCheckpoint(playerid,-1049.2953,2709.6973,45.6144,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1049.2953,2709.6973,45.6144)) // Checkpoint 44
		{
			SetPlayerCheckpoint(playerid,-1270.4656,2671.1289,48.4106,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1270.4656,2671.1289,48.4106)) // Checkpoint 45
		{
			SetPlayerCheckpoint(playerid,-1267.1816,2697.7236,49.8040,5);
		}
		else if(IsPlayerInRangeOfPoint(playerid,5,-1267.1816,2697.7236,49.8040)) // Checkpoint 46 aka end
		{
		    new Float:Health1;
		    GetVehicleHealth(GetPlayerVehicleID(playerid), Health1);
		    if(Health1 > 900)
			{
				DisablePlayerCheckpoint(playerid);
				PlayerStat[playerid][CarLic] = 1;
				LicenseTest[playerid] = 0;
				CP[playerid] = 0;
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SendClientMessage(playerid, COLOR_DMV, "* Driving Center: You have successfully passed the test and received your license.");
			}
			else
			{
				DisablePlayerCheckpoint(playerid);
				LicenseTest[playerid] = 0;
				CP[playerid] = 0;
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				SendClientMessage(playerid, COLOR_DMV, "* Driving Center: You have damaged your vehicle hardly, therefore you failed the test.");
			}
		}
		else DisablePlayerCheckpoint(playerid);
}
return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SetPlayerCameraPos(playerid, -1356.9288, 2561.1094, 110.3804);
	SetPlayerCameraLookAt(playerid, -1357.8594, 2561.5381, 109.9032);
	SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, playerid+0);
	TogglePlayerControllable(playerid, false);
	if(PlayerStat[playerid][Logged] == 1 && PlayerStat[playerid][FullyRegistered] == 1) return LoadPlayerData(playerid);
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_REGISTER)
    {
        if(!response)
        {
            SendClientMessage(playerid, GREY, "You didn't register.");
		    Kick(playerid);
		}
        else if(response)
        {
            if(!strlen(inputtext))
            {
				SendClientMessage(playerid, GREY, "You can't have an empty password.");
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registering","You have entered an invalid password.\nPlease input a password below to register an account.","Register","Quit");
			}
			else if(strlen(inputtext) < 3)
			{
                SendClientMessage(playerid, GREY, "Your password mustn't be under 3 characters.");
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registering","You have entered an invalid password.\nPlease input a password below to register an account.","Register","Quit");
			}
			else if(strlen(inputtext) > 20)
			{
                SendClientMessage(playerid, GREY, "Your password mustn't be more than 20 characters.");
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Registering","You have entered an invalid password.\nPlease input a password below to register an account.","Register","Quit");
			}
            else if(INI_Open(Accounts(playerid)))
			{
				new str[128];
				INI_WriteString("Password", inputtext);
				INI_Save();
				INI_Close();
                SendClientMessage(playerid, GREY, "You have successfully created an account and auto logged in.");
                format(str, sizeof(str), "%s", PlayerStat[playerid][Password]);
                NewPlayerData(playerid);
				PlayerStat[playerid][Logged] = 1;
				TogglePlayerControllable(playerid, false);
				SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, playerid+0);
                SetSpawnInfo(playerid, 0, 0, -1418.7278,2655.7954,55.8359, 0, 0, 0, 0, 0, 0, 0); // Spawn after register.
                SpawnPlayer(playerid);
                SetPlayerCameraPos(playerid, -1414.0009, 2602.2549, 65.1973);
				SetPlayerCameraLookAt(playerid, -1415.0255, 2602.2366, 64.9850);
	            ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Are you a male or a female?","Male\nFemale","Next","Quit");
            }
        }
    }
    if(dialogid == DIALOG_LOGIN)
    {
        if(!response)
        {
            SendClientMessage(playerid, GREY, "You didn't log in.");
		    Kick(playerid);
		}
        if(response)
        {
            if(!strlen(inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Log In","You have entered an invalid password.\nPlease input this account password to log in.","Login","Quit");
            }
            if(INI_Open(Accounts(playerid)))
		    {
                INI_ReadString(PlayerStat[playerid][Password],"Password",20);
		        if(strcmp(inputtext,PlayerStat[playerid][Password],false))
				{
				   if(PlayerStat[playerid][WrongPw] == 1)
				   {
                       SendClientMessage(playerid, GREY, "You have been kicked for not entering the correct password.");
				       Kick(playerid);
				   }
				   else
				   {
					   ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Log In","You have entered an incorrect password.\nPlease input this account password to log in.","Login","Quit");
                       SendClientMessage(playerid, GREY, "You only have one last chance to enter this account password or you'll get kicked.");
                       PlayerStat[playerid][WrongPw] = 1;
                       TogglePlayerControllable(playerid, false);
				       SetPlayerInterior(playerid, 0);
                       SetPlayerVirtualWorld(playerid, playerid+0);
                       SetSpawnInfo(playerid, 0, 0, -1418.7278,2655.7954,55.8359, 0, 0, 0, 0, 0, 0, 0);
                       SpawnPlayer(playerid);
                       SetPlayerCameraPos(playerid, -1495.7522, 2677.9976, 65.7733);
					   SetPlayerCameraLookAt(playerid, -1495.7023, 2676.9744, 65.5859);
				   }
                }
                else
				{

				    new str[128];
				    format(str, sizeof(str), "Welcome Back %s.", GetOOCName(playerid));
				    SendClientMessage(playerid, GREEN, str);
				    format(str, sizeof(str), "~w~Welcome Back ~n~~y~ %s", GetOOCName(playerid));
	                GameTextForPlayer(playerid, str, 3000, 1);
				    SendClientMessage(playerid, GREEN, SERVER_MOTD);

                    if(PlayerStat[playerid][GangID] >= 1)
					{
                        format(str, sizeof(str), "Gang MOTD: %s", GangStat[PlayerStat[playerid][GangID]][MOTD]);
				        SendClientMessage(playerid, GangStat[PlayerStat[playerid][GangID]][Color], str);
				    }
				    
				    PlayerStat[playerid][Logged] = 1;
				    LoadPlayerData(playerid);

				    INI_Save();
                    INI_Close();

				}
            }
        }
	}
    if(dialogid == DIALOG_GENDER)
    {
        if(!response)
        {
            SendClientMessage(playerid, GREY, "Please select 'Male' or 'Female' ");
            ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Are you a male or a female?","Male\nFemale","Next","Quit");
		}
        else if(response)
        {
            switch(listitem)
        	{
        	    case 0:
        	    {
			        SendClientMessage(playerid, GREY, "So, you are a male.");
        	        PlayerStat[playerid][Gender] = 0;
        	        PlayerStat[playerid][LastSkin] = 50;
        	        ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
        	    }
        	    case 1:
        	    {
			        SendClientMessage(playerid, GREY, "So, you are a female.");
        	        PlayerStat[playerid][Gender] = 1;
        	        PlayerStat[playerid][LastSkin] = 191;
        	        ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
        	    }
        	}
        }
    }
    if(dialogid == DIALOG_AGE)
    {
        if(!response)
        {
            SendClientMessage(playerid, GREY, "You need to type your age and press on 'Next'");
            ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
		}
        else if(response)
		{
            if(!strlen(inputtext))
            {
				SendClientMessage(playerid, GREY, "You must enter your age below.");
				ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
			}
			else if(strval(inputtext) < 18)
			{
                SendClientMessage(playerid, GREY, "Your age musn't be under 18.");
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
			}
			else if(strval(inputtext) > 80)
			{
                SendClientMessage(playerid, GREY, "Your age mustn't be over 80.");
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "How old are you?", "Input your age below.", "Next", "Quit");
			}
            else if(INI_Open(Accounts(playerid)))
			{
                INI_WriteString("Age", inputtext);
                INI_WriteInt("FullyRegistered", 1);
				SendClientMessage(playerid, GREY, "Alright, you can spawn now, Have fun roleplaying and don't forget to check our website tobechanged.com.");
				INI_Save();
				INI_Close();
				LoadPlayerData(playerid);
            }
        }
    }
    if(dialogid == DIALOG_HELP)
    {
        if(!response) return 1;
        else if(response)
        {
            switch(listitem)
        	{
				case 0:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "General Commands", "/stats, /admins, /me, /do, (/w)hisper, (/s)hout, (/l)ow, /b.", "Select", "Quit");
				}
				case 1:
				{
                    ShowPlayerDialog(playerid, DIALOG_BUGS, DIALOG_STYLE_LIST, "Bugs", "GMX Spawn.", "Select", "Quit");
				}
				case 2:
				{
                    ShowPlayerDialog(playerid, DIALOG_UPDATES, DIALOG_STYLE_LIST, "Updates", "Login/Register System\nNew Spawn\nHelp Menu\nAdmin Commands added/command to see them.", "Select", "Quit");
				}
        	}
        }
    }
    if(dialogid == DIALOG_UPDATES)
    {
        if(!response) return 1;
        else if(response)
        {
            switch(listitem)
        	{
				case 0:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "Login/Register System", "We've made a working Login/Register System\nAlso with admin levels, but no commands for admins yet.\nThe only current command in this system is /stats", "Select", "Quit");
				}
				case 1:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "New Spawn", "Changed to Angel Pine.\n\n\n\nMappings will be added.", "Select", "Quit");
				}
				case 2:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "Help Menu", "Working Help Menu.", "Select", "Quit");
				}
				case 3:
				    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "Admin Changes", "1.  working on more commands.\n2. Added /ahelp (ONLY FOR ADMINISTRATORS)\n3. Added /admins with ranknames.", "Select", "Quit");
        	}
        }
    }
    if(dialogid == DIALOG_BUGS)
    {
        if(!response) return 1;
        else if(response)
        {
            switch(listitem)
        	{
				case 0:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "GMX Spawn", "Whenever you use /gmx it won't save the playerstat, so neither the quit positions.", "Select", "Quit");
				}
				case 1:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "Bugs", "None yet.", "Select", "Quit");
				}
				case 2:
				{
                    ShowPlayerDialog(playerid, DIALOG_MSG, DIALOG_STYLE_MSGBOX, "Updates", "Login System\nNew Spawn\nTest\nTest", "Select", "Quit");
				}
        	}
        }
    }

	return 1;
}

public LoadObjects()
{
	//El Quebrados Additions
	CreateDynamicObject(16070, -1517.93079, 2617.64282, 60.48250,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(974, -1522.54321, 2611.49878, 57.54810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1430, -1525.17847, 2618.72681, 55.15010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(849, -1520.98853, 2619.04395, 55.10810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1484, -1525.39600, 2614.88110, 55.42210,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1358, -1524.46924, 2625.69971, 56.01210,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1347, -1522.39331, 2615.46167, 55.39000,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1525.19019, 2617.77515, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, -1525.34753, 2617.75220, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1712, -1523.91736, 2612.73633, 54.81010,   0.00000, 0.00000, 127.26000);
	CreateDynamicObject(1712, -1520.06335, 2613.72021, 54.81010,   0.00000, 0.00000, -127.26000);
	CreateDynamicObject(1712, -1519.94092, 2616.64746, 54.81010,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1712, -1525.18884, 2615.17139, 54.81010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1544, -1525.28064, 2617.84155, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, -1525.20862, 2617.66357, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1544, -1525.11865, 2617.87549, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1525.07617, 2617.77319, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1525.05225, 2617.55713, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1543, -1525.32019, 2617.67114, 54.81810,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18266, -1500.55322, 2692.35107, 59.18150,   0.00000, 0.00000, 90.46000);
	CreateDynamicObject(17542, -884.86517, 2758.70581, 48.97850,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12951, -819.41718, 2770.66943, 44.79850,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(12944, -1529.41736, 2637.37744, 54.82450,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(974, -1535.89966, 2570.37622, 56.94610,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(974, -1505.97107, 2578.81982, 56.94610,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(5820, -1510.18005, 2577.58008, 56.26440,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(12949, -1479.47607, 2616.07910, 54.80650,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1687, -1475.15771, 2617.02051, 60.62250,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1439.81360, 2596.11572, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1473.09363, 2596.11572, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1457.06763, 2596.12451, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1448.78125, 2606.19263, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1472.79529, 2606.19263, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1430.97986, 2636.47485, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1430.97986, 2614.46509, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1430.97986, 2652.47998, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1430.97986, 2657.28394, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1428.09705, 2611.02783, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1352, -1430.98206, 2611.36523, 54.81130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(19425, -1434.29443, 2598.89990, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1352, -1417.37537, 2606.54907, 54.81130,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1416.79834, 2603.46533, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1352, -1433.50085, 2596.14136, 54.81130,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(12951, -1466.20984, 2617.33472, 54.82850,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(12944, -1453.18152, 2617.53760, 54.80650,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3170, -1479.30566, 2651.50977, 54.80470,   356.85840, 0.00000, -45.00000);
	CreateDynamicObject(672, -1440.97314, 2613.56348, 55.82813,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(3173, -1454.73389, 2631.03516, 54.82030,   356.85840, 0.00000, -225.00000);
	CreateDynamicObject(3285, -1481.95801, 2635.84180, 56.64840,   3.14160, 0.00000, 180.00000);
	CreateDynamicObject(669, -1453.91321, 2657.21069, 55.24219,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(11461, -1468.09729, 2629.60913, 54.39063,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(3173, -1451.87244, 2651.25830, 54.82030,   356.85840, 0.00000, 225.00000);
	CreateDynamicObject(983, -1445.55750, 2611.18945, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1439.15051, 2611.18945, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1435.95593, 2614.37231, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(982, -1435.95593, 2636.47485, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1435.95593, 2652.47998, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(672, -1440.51343, 2658.22925, 55.82813,   356.85840, 0.00000, 3.14159);
	CreateDynamicObject(983, -1435.95593, 2657.28394, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(982, -1448.78418, 2660.47119, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1473.11621, 2660.47314, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1485.90930, 2647.67773, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(982, -1485.91125, 2625.26563, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1436.02698, 2621.99097, 54.83530,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1436.02698, 2619.25708, 54.83330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1420.89392, 2614.46509, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1420.89392, 2620.86108, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1420.89392, 2627.25708, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1420.89185, 2630.45898, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1420.89185, 2651.72705, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1420.89185, 2658.12305, 55.49640,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(983, -1421.56775, 2664.46704, 55.49640,   0.00000, 0.00000, 11.85600);
	CreateDynamicObject(983, -1424.11572, 2670.08301, 55.54840,   0.00000, 0.00000, 35.98400);
	CreateDynamicObject(983, -1428.79565, 2674.24292, 55.54840,   0.00000, 0.00000, 60.94400);
	CreateDynamicObject(983, -1434.77698, 2676.11499, 55.54840,   0.00000, 0.00000, 83.81200);
	CreateDynamicObject(982, -1457.15125, 2676.25269, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1441.14197, 2676.34692, 55.54840,   0.00000, 0.00000, 91.97600);
	CreateDynamicObject(982, -1491.45044, 2676.25073, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1460.35315, 2676.25073, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1517.04236, 2676.25073, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1542.67444, 2676.25073, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1518.62634, 2606.19458, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1533.03137, 2606.19653, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(982, -1518.62634, 2596.11572, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(983, -1533.03137, 2596.11377, 55.49640,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1505.61035, 2598.89990, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1485.95435, 2603.43579, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1493.76636, 2590.65381, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1493.66101, 2660.67603, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(1352, -1505.92090, 2596.14136, 54.81130,   0.00000, 0.00000, -90.00000);
	CreateDynamicObject(1352, -1485.46741, 2606.18311, 54.81130,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(1352, -1501.15283, 2610.77661, 54.81130,   0.00000, 0.00000, 180.00000);
	CreateDynamicObject(1352, -1490.74524, 2590.93213, 54.81130,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1498.14636, 2611.38379, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1486.15039, 2673.35254, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1556.50562, 2669.00122, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1506.82080, 2668.89575, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1534.94812, 2673.27246, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1543.58032, 2660.55933, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1548.19336, 2611.10620, 54.68330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19425, -1535.44836, 2603.36328, 54.68330,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(19425, -1543.71472, 2591.62500, 54.68330,   0.00000, 0.00000, 0.00000);
	// END
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	//ShowPlayerDialog
	return 1;
}

stock GMX(playerid)
{
	SavePlayerData(playerid);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SavePlayerData(i);
	}
	for(new g = 1; g < MAX_GANGS; g++)
	{
		SaveGang(g);
	}
    return 1;
}

stock IsValidName(playerid)
{
    new CheckName[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, CheckName, sizeof(CheckName));
        for(new i = 0; i < MAX_PLAYER_NAME; i++)
        {
            if (CheckName[i] == '_') return 1;
            if (CheckName[i] == ']' || CheckName[i] == '[') return 0;
        }
    }
    return 0;
}

stock Accounts(playerid)
{
  new PlayerAcc[128];
  format(PlayerAcc,128,"Accounts/%s.ini",GetOOCName(playerid));
  return PlayerAcc;
}

stock ClearChatForPlayer(playerid)
{
    for (new c = 0; c < 150; c++)
    {
        SendClientMessage(playerid, WHITE, " ");
    }
}
stock GetOOCName(playerid)
{
    new OOCName[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, OOCName, sizeof(OOCName));
	}
	else
	{
	    OOCName = "None";
	}

	return OOCName;
}

stock ResetPlayer(playerid)
{
    PlayerStat[playerid][Spawned] = 0;
	PlayerStat[playerid][Logged] = 0;
    PlayerStat[playerid][WrongPw] = 0;
    return 1;
}

stock SetMoney(playerid, money)
{
    PlayerStat[playerid][Money] = money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, money);
    return 1;
}

stock GetICName(playerid)
{
    new ICName[MAX_PLAYER_NAME];
    if(IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, ICName, sizeof(ICName));
        for(new i = 0; i < MAX_PLAYER_NAME; i++)
        {
            if(ICName[i] == '_') ICName[i] = ' ';
        }
	}
	else
	{
	    ICName = "None";
	}

	return ICName;
}

stock GiveMoney(playerid, money)
{
    PlayerStat[playerid][Money] += money;
    GivePlayerMoney(playerid, money);
    return 1;
}

stock GetAdminRank(playerid)
{
	new Rank[60];
    if(PlayerStat[playerid][AdminLevel] >= 1)
    {
    	if(PlayerStat[playerid][AdminLevel] == 1) format(Rank, sizeof(Rank), "Moderator");
     	if(PlayerStat[playerid][AdminLevel] == 2) format(Rank, sizeof(Rank), "Administrator");
      	if(PlayerStat[playerid][AdminLevel] == 3) format(Rank, sizeof(Rank), "Administrator");
       	if(PlayerStat[playerid][AdminLevel] == 4) format(Rank, sizeof(Rank), "Head Administrator");
        if(PlayerStat[playerid][AdminLevel] == 5) format(Rank, sizeof(Rank), "Management");
        if(PlayerStat[playerid][AdminLevel] == 1338) format(Rank, sizeof(Rank), "Management");
	}
	else
	{
	    Rank = "None";
	}
	return Rank;
}

stock GetGender(playerid)
{
	new PlayerGender[60];
    if(PlayerStat[playerid][Gender] == 0)
    {
        PlayerGender = "Male";
	}
	else
	{
	    PlayerGender = "Female";
	}

	return PlayerGender;
}

stock AdminActionLog(str[])
{
    new File:lFile = fopen("Logs/Admin Actions Log.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}

stock BanLog(str[])
{
    new File:lFile = fopen("Logs/Ban Log.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}

stock IsPlayerInRangeOfPlayer(Float:radius,playerid,targetid)
{
	if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		GetPlayerPos(playerid, posx, posy, posz);
		if(IsPlayerInRangeOfPoint(targetid,radius,posx,posy,posz))
		{
		    return 1;
  		}
	}
	return 0;
}

stock ICLog(str[])
{
    new File:lFile = fopen("Logs/ICLog.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}

stock OOCLog(str[])
{
    new File:lFile = fopen("Logs/OOCLog.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}

stock GetGangRank(playerid)
{
	new Rank[60];
    if(PlayerStat[playerid][GangID] >= 1)
    {
       if(PlayerStat[playerid][GangRank] == 1) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank1]);
       if(PlayerStat[playerid][GangRank] == 2) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank2]);
       if(PlayerStat[playerid][GangRank] == 3) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank3]);
       if(PlayerStat[playerid][GangRank] == 4) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank4]);
       if(PlayerStat[playerid][GangRank] == 5) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank5]);
       if(PlayerStat[playerid][GangRank] == 6) format(Rank, sizeof(Rank), "%s", GangStat[PlayerStat[playerid][GangID]][Rank6]);
	}
	else
	{
	    Rank = "None";
	}
	return Rank;
}

stock SetSkin(playerid, skin)
{
    PlayerStat[playerid][LastSkin] = skin;
    SetPlayerSkin(playerid, skin);
    return 1;
}

stock SetHealth(playerid, Float: health)
{
    PlayerStat[playerid][Health] = health;
    SetPlayerHealth(playerid, health);
    return 1;
}

stock SetArmour(playerid, Float: armour)
{
    PlayerStat[playerid][Armour] = armour;
    SetPlayerArmour(playerid, armour);
    return 1;
}

stock GetGangName(playerid)
{
	new Gang[60];
    if(PlayerStat[playerid][GangID] >= 1)
    {
       format(Gang, sizeof(Gang), "%s", GangStat[PlayerStat[playerid][GangID]][GangName]);
	}
	else
	{
	    Gang = "None";
	}
	return Gang;
}

stock GetFactionName(playerid)
{
	new Faction[60];
    if(PlayerStat[playerid][FactionID] >= 1)
    {
       if(PlayerStat[playerid][FactionID] == 1) format(Faction, sizeof(Faction), "El Quebrados Sheriff's Department");
       if(PlayerStat[playerid][FactionID] == 2) format(Faction, sizeof(Faction), "El Quebrados Medical Department");
	}
	else
	{
	    Faction = "None";
	}
	return Faction;
}
// FACTION RANKNAMES
stock GetFactionRank(playerid)
{
	new Rank[60];
    if(PlayerStat[playerid][FactionID] >= 1)
    {
       if(PlayerStat[playerid][FactionID] == 1)
       {
           if(PlayerStat[playerid][FactionRank] == 1) format(Rank, sizeof(Rank), "Cadet");
           if(PlayerStat[playerid][FactionRank] == 2) format(Rank, sizeof(Rank), "Officer");
           if(PlayerStat[playerid][FactionRank] == 3) format(Rank, sizeof(Rank), "Sergeant");
           if(PlayerStat[playerid][FactionRank] == 4) format(Rank, sizeof(Rank), "Lieutenant");
           if(PlayerStat[playerid][FactionRank] == 5) format(Rank, sizeof(Rank), "Deputy Sheriff III");
           if(PlayerStat[playerid][FactionRank] == 6) format(Rank, sizeof(Rank), "Sheriff");
       }
       else if(PlayerStat[playerid][FactionID] == 2)
       {
           if(PlayerStat[playerid][FactionRank] == 1) format(Rank, sizeof(Rank), "Trail Doctor");
           if(PlayerStat[playerid][FactionRank] == 2) format(Rank, sizeof(Rank), "Junior Doctor");
           if(PlayerStat[playerid][FactionRank] == 3) format(Rank, sizeof(Rank), "Doctor");
           if(PlayerStat[playerid][FactionRank] == 4) format(Rank, sizeof(Rank), "Senior Doctor");
           if(PlayerStat[playerid][FactionRank] == 5) format(Rank, sizeof(Rank), "Head Doctor");
           if(PlayerStat[playerid][FactionRank] == 6) format(Rank, sizeof(Rank), "Senior Head Doctor");
       }
       else if(PlayerStat[playerid][FactionID] == 3)
       {
           if(PlayerStat[playerid][FactionRank] == 1) format(Rank, sizeof(Rank), "City Council Employee");
           if(PlayerStat[playerid][FactionRank] == 2) format(Rank, sizeof(Rank), "City Hall Security");
           if(PlayerStat[playerid][FactionRank] == 3) format(Rank, sizeof(Rank), "City Tax Employee");
           if(PlayerStat[playerid][FactionRank] == 4) format(Rank, sizeof(Rank), "Bodyguard");
           if(PlayerStat[playerid][FactionRank] == 5) format(Rank, sizeof(Rank), "Deputy Mayor");
           if(PlayerStat[playerid][FactionRank] == 6) format(Rank, sizeof(Rank), "Mayor");
       }
	}
	else
	{
	    Rank = "None";
	}
	return Rank;
}

stock FactionChatLog(str[])
{
    new File:lFile = fopen("Logs/Faction Chat Log.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return	 1;
}

stock GangChatLog(str[])
{
    new File:lFile = fopen("Logs/Gang Chat Log.txt", io_append);
    new logData[178];
    new Hour, Minute, Second;
    new Day, Month, Year;

    gettime(Hour, Minute, Second);
    getdate(Year, Month, Day);

    format(logData, sizeof(logData),"[%02d/%02d/%02d %02d:%02d:%02d] %s \r\n", Day, Month, Year, Hour, Minute, Second, str);
    fwrite(lFile, logData);

    fclose(lFile);
    return 1;
}

stock LoadStaticVehicles()
{
    // DMV Vehicles
	DMVCar[0] = CreateVehicle(492, -1274.6836, 2705.7974, 49.8084, 0.0000,6,1,300); // Car1
	DMVCar[1] = CreateVehicle(492, -1268.9010, 2708.9495, 49.8161, 0.0000,6,1,300); // Car2
	DMVCar[2] = CreateVehicle(492, -1263.0652, 2712.1360, 49.8067, 0.0000,6,1,300); // Car3
	DMVCar[3] = CreateVehicle(492, -1257.6036, 2715.8245, 49.8068, 0.0000,6,1,300); // Car4
	
	// PD Vehicles
	SDCar[0] = AddStaticVehicle(598,-1399.9590,2629.8613,55.5203,268.3433,141,1); // SDCar1
	SDCar[1] = AddStaticVehicle(598,-1401.1401,2635.8440,55.4478,267.8479,141,1); // SDCar2
	SDCar[2] = AddStaticVehicle(598,-1399.6370,2642.2539,55.4342,269.6583,141,1); // SDCar3
	SDCar[3] = AddStaticVehicle(598,-1400.8645,2647.7300,55.4299,273.5802,141,1); // SDCar4
	SDCar[4] = AddStaticVehicle(598,-1399.7461,2654.5640,55.4310,269.9458,141,1); // SDCar5
	SDCar[5] = AddStaticVehicle(598,-1411.6382,2658.4075,55.4144,180.6694,141,1); // SDCar6
	SDCar[6] = AddStaticVehicle(598,-1411.4790,2626.3538,55.4334,358.9143,141,1); // SDCar7
	
	AddStaticVehicleEx(598, -1356.9288, 2561.1094 ,105.4719, 0.0000, 141, 1, 100000000000000000); // Car1
	print("Static vehicles loaded.");
	return 1;
}

stock IsDMVCar(vehicleid)
{
    for(new i=0; i<5; i++)
    {
        if(vehicleid == DMVCar[i]) return 1;
    }
    return 0;
}

stock IsGOVCar(vehicleid)
{
    for(new i=0; i<5; i++)
    {
        if(vehicleid == GOVCar[i]) return 1;
    }
    return 0;
}

stock IsEMSCar(vehicleid)
{
    for(new i=0; i<5; i++)
    {
        if(vehicleid == EMSCar[i]) return 1;
    }
    return 0;
}

stock IsSDCar(vehicleid)
{
    for(new i=0; i<5; i++)
    {
        if(vehicleid == SDCar[i]) return 1;
    }
    return 0;
}

stock KickAll()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i)) Kick(i);
    }
    return 1;
}

public NewPlayerData(playerid)
{
    if(INI_Open(Accounts(playerid)))
    {
        INI_WriteInt("FullyRegistered",0);

        INI_WriteInt("Age",0);
        INI_WriteInt("Gender",0);
        INI_WriteInt("LastSkin",50);
        INI_WriteInt("Money",5000);
        INI_WriteString("LastIP",PlayerStat[playerid][LastIP]);
        
        INI_WriteFloat("LastX",-1418.7278);
        INI_WriteFloat("LastY",2655.7954);
        INI_WriteFloat("LastZ",55.8359);
        INI_WriteFloat("LastA",90.4835);
        
        INI_WriteInt("GangID",PlayerStat[playerid][GangID]);
		INI_WriteInt("GangRank",PlayerStat[playerid][GangRank]);
		INI_WriteInt("FactionID",PlayerStat[playerid][FactionID]);
		INI_WriteInt("FactionRank",PlayerStat[playerid][FactionRank]);
		INI_WriteInt("CarLicense",PlayerStat[playerid][CarLic]);
		INI_WriteFloat("Health",PlayerStat[playerid][Health]);
		INI_WriteFloat("Armour",PlayerStat[playerid][Armour]);

        INI_WriteInt("AdminLevel",0);
		INI_WriteInt("Banned",0);
		INI_WriteInt("TimesKicked",0);
		INI_WriteInt("TimesBanned",0);


        INI_Save();
        INI_Close();
    }
	return 1;
}

stock SaveGang(gangid)
{
    format(GangStat[gangid][GangFile], 20, "Gangs/Gang %d.ini", gangid);
    if(INI_Open(GangStat[gangid][GangFile]))
    {

        INI_WriteString("Leader", GangStat[gangid][Leader]);
		INI_WriteString("Name", GangStat[gangid][GangName]);
		INI_WriteString("MOTD", GangStat[gangid][MOTD]);

		INI_WriteString("Rank1", GangStat[gangid][Rank1]);
		INI_WriteString("Rank2", GangStat[gangid][Rank2]);
		INI_WriteString("Rank3", GangStat[gangid][Rank3]);
		INI_WriteString("Rank4", GangStat[gangid][Rank4]);
		INI_WriteString("Rank5", GangStat[gangid][Rank5]);
		INI_WriteString("Rank6", GangStat[gangid][Rank6]);

		INI_WriteInt("Members", GangStat[gangid][Members]);

		INI_WriteInt("Color", GangStat[gangid][Color]);

		INI_Save();
		INI_Close();
    }
	return 1;
}

public SavePlayerData(playerid)
{
    if(INI_Open(Accounts(playerid)))
    {
		if(PlayerStat[playerid][FullyRegistered] == 1)
		{
            INI_WriteInt("Age",PlayerStat[playerid][Age]);
            INI_WriteInt("Gender",PlayerStat[playerid][Gender]);
            INI_WriteString("LastIP",PlayerStat[playerid][LastIP]);

            INI_WriteInt("Money",PlayerStat[playerid][Money]);
            INI_WriteInt("LastSkin",PlayerStat[playerid][LastSkin]);

            GetPlayerPos(playerid, PlayerStat[playerid][LastX], PlayerStat[playerid][LastY], PlayerStat[playerid][LastZ]);
		    GetPlayerFacingAngle(playerid, PlayerStat[playerid][LastA]);

            INI_WriteFloat("LastX",PlayerStat[playerid][LastX]);
            INI_WriteFloat("LastY",PlayerStat[playerid][LastY]);
            INI_WriteFloat("LastZ",PlayerStat[playerid][LastZ]);
            INI_WriteFloat("LastA",PlayerStat[playerid][LastA]);
            
            INI_WriteInt("GangID",PlayerStat[playerid][GangID]);
			INI_WriteInt("GangRank",PlayerStat[playerid][GangRank]);
			INI_WriteInt("FactionID",PlayerStat[playerid][FactionID]);
			INI_WriteInt("FactionRank",PlayerStat[playerid][FactionRank]);
			INI_WriteInt("CarLicense",PlayerStat[playerid][CarLic]);
			INI_WriteFloat("Health",PlayerStat[playerid][Health]);
			INI_WriteFloat("Armour",PlayerStat[playerid][Armour]);

            INI_WriteInt("FullyRegistered",PlayerStat[playerid][FullyRegistered]);

            INI_WriteInt("AdminLevel",PlayerStat[playerid][AdminLevel]);
			INI_WriteInt("Banned",PlayerStat[playerid][Banned]);
			INI_WriteInt("TimesKicked",PlayerStat[playerid][TimesKicked]);
		    INI_WriteInt("TimesBanned",PlayerStat[playerid][TimesBanned]);
            INI_Save();
            INI_Close();
        }
        else return 1;
    }
	return 1;
}

public LoadPlayerData(playerid)
{
    if(INI_Open(Accounts(playerid)))
	{
        if(PlayerStat[playerid][Logged] == 0)
        {
		    return 0;
	    }

        PlayerStat[playerid][Banned] = INI_ReadInt("Banned");
        PlayerStat[playerid][FullyRegistered] = INI_ReadInt("FullyRegistered");

        if(PlayerStat[playerid][Banned] == 1)
        {
		    SendClientMessage(playerid, WHITE, "You are banned from this server.");
	        Kick(playerid);
	    }

        else if(PlayerStat[playerid][FullyRegistered] == 0)
	    {
		    TogglePlayerControllable(playerid, false);

			SendClientMessage(playerid, GREY, "You are not fully registered, You must answer your gender and age.");
            ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Are you a male or a female?","Male\nFemale","Next","Quit");
            SetPlayerInterior(playerid, 0);
            SetSpawnInfo(playerid, 0, 0, -1418.7278,2655.7954,55.8359, 0, 0, 0, 0, 0, 0, 0);
            SetPlayerVirtualWorld(playerid, playerid+0);
            SpawnPlayer(playerid);
            SetPlayerCameraPos(playerid, -2247.4417, -2195.0356, 82.7396);
   			SetPlayerCameraLookAt(playerid, -2246.8352, -2195.8284, 82.4949);
	    }
	    else
		{

            PlayerStat[playerid][Age] = INI_ReadInt("Age");
            PlayerStat[playerid][Gender] = INI_ReadInt("Gender");

            PlayerStat[playerid][Money] = INI_ReadInt("Money");
            PlayerStat[playerid][LastSkin] = INI_ReadInt("LastSkin");

            PlayerStat[playerid][AdminLevel] = INI_ReadInt("AdminLevel");
            PlayerStat[playerid][TimesBanned] = INI_ReadInt("TimesBanned");
            PlayerStat[playerid][TimesKicked] = INI_ReadInt("TimesKicked");
            
            PlayerStat[playerid][GangID] = INI_ReadInt("GangID");
            PlayerStat[playerid][GangRank] = INI_ReadInt("GangRank");
            PlayerStat[playerid][FactionID] = INI_ReadInt("FactionID");
            PlayerStat[playerid][FactionRank] = INI_ReadInt("FactionRank");
            PlayerStat[playerid][CarLic] = INI_ReadInt("CarLicense");
            PlayerStat[playerid][Health] = INI_ReadFloat("Health");
            PlayerStat[playerid][Armour] = INI_ReadFloat("Armour");
            
            PlayerStat[playerid][LastX] = INI_ReadFloat("LastX");
            PlayerStat[playerid][LastY] = INI_ReadFloat("LastY");
            PlayerStat[playerid][LastZ] = INI_ReadFloat("LastZ");
            PlayerStat[playerid][LastA] = INI_ReadFloat("LastA");

			SetSpawnInfo(playerid, 0, PlayerStat[playerid][LastSkin], PlayerStat[playerid][LastX], PlayerStat[playerid][LastY], PlayerStat[playerid][LastZ], PlayerStat[playerid][LastA], 0, 0, 0, 0, 0, 0);
            SpawnPlayer(playerid);

            PlayerStat[playerid][Spawned] = 1;
            SetMoney(playerid, PlayerStat[playerid][Money]);
            SetCameraBehindPlayer(playerid);
            TogglePlayerControllable(playerid, 0);
            SetTimerEx("LoadingObjects", 1000, false, "d", playerid);

		}
        INI_Save();
        INI_Close();
    }
	return 1;
}

public ShowStatsForPlayer(playerid, targetid)
{
    new str[128];
	SendClientMessage(targetid, GREEN, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
	format(str, 128, "Name: %s | IP: %s | Gender: %s | Age: %d.", GetICName(playerid), PlayerStat[playerid][LastIP], GetGender(playerid), PlayerStat[playerid][Age]);
	SendClientMessage(targetid, GREY, str);
	format(str, 128, "Admin Level: %d ((%s)) | Times Kicked: %d | Times Banned: %d.", PlayerStat[playerid][AdminLevel], PlayerStat[playerid][TimesKicked], PlayerStat[playerid][TimesBanned]);
	SendClientMessage(targetid, GREY, str);
    format(str, 128, "Money $%d | Bank Account: $%d | Next Paycheck: $%d.", PlayerStat[playerid][Money]);
	SendClientMessage(targetid, GREY, str);
	SendClientMessage(targetid, GREEN, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
}

public SendFactionMessage(playerid, color, str[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && PlayerStat[playerid][FactionID] == PlayerStat[i][FactionID])
		{
            SendClientMessage(i, color, str);
            FactionChatLog(str);
        }
    }
	return 1;
}

public LoadGangs()
{
    printf("Load Basic Roleplay Gangs.");
    for(new i = 1; i < MAX_GANGS; i++)
    {
        format(GangStat[i][GangFile], 60, "Gangs/Gang %d.ini", i);
        if(INI_Open(GangStat[i][GangFile]))
	    {
           INI_ReadString(GangStat[i][Leader],"Leader",60);
           INI_ReadString(GangStat[i][GangName],"Name",60);
           INI_ReadString(GangStat[i][MOTD],"MOTD", 128);

           INI_ReadString(GangStat[i][Rank1],"Rank1",60);
           INI_ReadString(GangStat[i][Rank2],"Rank2",60);
           INI_ReadString(GangStat[i][Rank3],"Rank3",60);
           INI_ReadString(GangStat[i][Rank4],"Rank4",60);
           INI_ReadString(GangStat[i][Rank5],"Rank5",60);
           INI_ReadString(GangStat[i][Rank6],"Rank6",60);

           GangStat[i][Members] = INI_ReadInt("Members");

           GangStat[i][Color] = INI_ReadInt("Color");

           INI_Save();
           INI_Close();
        }
    }
    printf("Gangs Loaded.");
	return 1;
}

public SendGangMessage(playerid, color, str[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && PlayerStat[playerid][GangID] == PlayerStat[i][GangID])
		{
            SendClientMessage(i, color, str);
            GangChatLog(str);
        }
    }
	return 1;
}
