#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>


public Plugin myinfo = 
{
	name = "Admin Access Message",
	author = "FIVE",
	description = "Показывает сообщение игроку, который не имеет доступа к админ-меню.",
	version = "1.0.2",
	url = "https://hlmod.ru/" // Спасибо всем, кто проверял плагин!
};

public void OnPluginStart()
{
	LoadTranslations("admin_aceessmessage.phrases");
	RegConsoleCmd("sm_admin", CallBackCMD);
}


public Action CallBackCMD(int iClient, int args)
{
	if(iClient > 0)
	{
		if (GetUserFlagBits(iClient) == 0)
		{
	    		Panel hPanel = new Panel();
				char sBuffer[512];
		    	
		    	FormatEx(sBuffer, sizeof(sBuffer), "%t", "Title");
				hPanel.SetTitle(sBuffer);
				hPanel.DrawItem(" ", ITEMDRAW_SPACER|ITEMDRAW_RAWLINE);	
				FormatEx(sBuffer, sizeof(sBuffer), "%t", "Message");
				hPanel.DrawText(sBuffer);
				hPanel.DrawItem(" ", ITEMDRAW_SPACER|ITEMDRAW_RAWLINE);	
				SetPanelCurrentKey(hPanel, 1);
				hPanel.DrawItem("Закрыть");	
				hPanel.Send(iClient, view_as<MenuHandler>(Placehold), 50);
				delete hPanel;
	   	}
	}
}

void Placehold(){}