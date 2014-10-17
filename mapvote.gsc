/*--------------------------------

##### #   # #   # #   # ##### ####
#     #   # ##  # ##  # #     #  #
#  ## #   # # # # # # # ##### ####
#   # #   # #  ## #  ## #     # #
##### ##### #   # #   # ##### #  #

----------------------------------*/
init()
{
	maps = [];
	maps[maps.size] = "mp_crash";
	maps[maps.size] = "mp_crash_snow";
	maps[maps.size] = "mp_bloc";
	maps[maps.size] = "mp_bog";
	maps[maps.size] = "mp_backlot";
	maps[maps.size] = "mp_broadcast";
	maps[maps.size] = "mp_carentan";
	maps[maps.size] = "mp_cargoship";
	maps[maps.size] = "mp_citystreets";
	maps[maps.size] = "mp_convoy";
	maps[maps.size] = "mp_countdown";
	maps[maps.size] = "mp_creek";
	maps[maps.size] = "mp_crossfire";
	maps[maps.size] = "mp_farm";
	maps[maps.size] = "mp_killhouse";
	maps[maps.size] = "mp_overgrown";
	maps[maps.size] = "mp_pipeline";
	maps[maps.size] = "mp_shipment";
	maps[maps.size] = "mp_showdown";
	maps[maps.size] = "mp_strike";
	maps[maps.size] = "mp_vacant";

	if(getdvar("mapnum") == "")
	{
		setdvar("mapnum",0);
		nextmap1=0;
		nextmap2=1;
		nextmap3=2;
	}
	else
	{
		if(isDefined(maps[getdvarInt("mapnum")]))
			nextmap1=getdvarInt("mapnum");
		else
			nextmap1=0;

		if(isDefined(maps[nextmap1+1]))
			nextmap2=nextmap1+1;
		else
			nextmap2=0;

		if(isDefined(maps[nextmap2+1]))
			nextmap3=nextmap2+1;
		else
			nextmap3=0;
	}
	setdvar("mapnum",nextmap3+1);

	level.nextmap1=maps[nextmap1];
	level.nextmap2=maps[nextmap2];
	level.nextmap3=maps[nextmap3];
}
MapRegistry(map)
{
	switch(map)
	{
	case "mp_crash":		return "Crash";
	case "mp_crash_snow":		return "Crash Snow";
	case "mp_bloc":			return "Bloc";
	case "mp_bog":			return "Bog";
	case "mp_backlot":		return "Backlot";
	case "mp_broadcast":		return "Broadcast";
	case "mp_carentan":		return "Chinatown";
	case "mp_cargoship":		return "Wet Work";
	case "mp_citystreets":		return "District";
	case "mp_convoy":		return "Ambush";
	case "mp_countdown":		return "Countdown";
	case "mp_creek":		return "Creek";
	case "mp_crossfire":		return "Crossfire";
	case "mp_farm":			return "Downpour";
	case "mp_killhouse":		return "Killhouse";
	case "mp_overgrown":		return "Overgrown";
	case "mp_pipeline":		return "Pipeline";
	case "mp_shipment":		return "Shipment";
	case "mp_showdown":		return "Showdown";
	case "mp_strike":		return "Strike";
	case "mp_vacant":		return "Vacant";
	default:			return map;
	}
}
addMapvoteShader(s,x,y,w,h,a,c)
{
	if(!isDefined(self.hud_mapvote))
		self.hud_mapvote=[];

	i=self.hud_mapvote.size;
	self.hud_mapvote[i] = newClientHudElem(self);
	self.hud_mapvote[i].horzAlign="center";
	self.hud_mapvote[i].vertAlign="middle";
	self.hud_mapvote[i].x = x-(w/2);
	self.hud_mapvote[i].y = y-(h/2);
	self.hud_mapvote[i].sort = s;
	self.hud_mapvote[i].alpha = 0;
	self.hud_mapvote[i].color = c;
	self.hud_mapvote[i].archived = false;
	self.hud_mapvote[i].hideWhenInMenu = true;
	self.hud_mapvote[i] setShader("white", w, h);
	self.hud_mapvote[i] fadeOverTime(1);
	self.hud_mapvote[i].alpha = a;
}
addMapvoteLabel(x,y,a,ft,f,c,l,v)
{
	if(!isDefined(self.hud_mapvote))
		self.hud_mapvote=[];

	i=self.hud_mapvote.size;
	self.hud_mapvote[i] = newClientHudElem(self);
	self.hud_mapvote[i].alignX=a;
	self.hud_mapvote[i].aligny="middle";
	self.hud_mapvote[i].horzAlign="center";
	self.hud_mapvote[i].vertAlign="middle";
	self.hud_mapvote[i].x = x;
	self.hud_mapvote[i].y = y;
	self.hud_mapvote[i].font = ft;
	self.hud_mapvote[i].fontscale = f;
	self.hud_mapvote[i].sort = 3;
	self.hud_mapvote[i].alpha = 0;
	self.hud_mapvote[i].color = c;
	self.hud_mapvote[i].archived = false;
	self.hud_mapvote[i].hideWhenInMenu = true;
	self.hud_mapvote[i].glowAlpha = 0;
	self.hud_mapvote[i].glowColor = (0,1,0);
	self.hud_mapvote[i].label = l;
	self.hud_mapvote[i] setValue(v);
	self.hud_mapvote[i] fadeOverTime(1);
	self.hud_mapvote[i].alpha = 1;
}
addMapvoteText(x,y,a,ft,f,c,t)
{
	if(!isDefined(self.hud_mapvote))
		self.hud_mapvote=[];

	i=self.hud_mapvote.size;
	self.hud_mapvote[i] = newClientHudElem(self);
	self.hud_mapvote[i].alignX=a;
	self.hud_mapvote[i].aligny="middle";
	self.hud_mapvote[i].horzAlign="center";
	self.hud_mapvote[i].vertAlign="middle";
	self.hud_mapvote[i].x = x;
	self.hud_mapvote[i].y = y;
	self.hud_mapvote[i].font = ft;
	self.hud_mapvote[i].fontscale = f;
	self.hud_mapvote[i].sort = 3;
	self.hud_mapvote[i].alpha = 0;
	self.hud_mapvote[i].color = c;
	self.hud_mapvote[i].archived = false;
	self.hud_mapvote[i].hideWhenInMenu = true;
	self.hud_mapvote[i].glowAlpha = 0;
	self.hud_mapvote[i].glowColor = (0,1,0);
	self.hud_mapvote[i] setText(t);
	self.hud_mapvote[i] fadeOverTime(1);
	self.hud_mapvote[i].alpha = 1;
}
start()
{
	if(level.p.size>0)
	{
		level.mapvote["1"] = 0;
		level.mapvote["2"] = 0;
		level.mapvote["3"] = 0;
		for(i=0;i<level.p.size;i++)
			level.p[i] thread PlayerVote();

		for(t=20;t>=0;t--)
		{
			for(i=0;i<level.p.size;i++)
			{
				level.p[i].hud_mapvote[13] setValue(t);
				if(t==5)
					level.p[i].hud_mapvote[13].label=&"Time left: ^1&&1";
				if(t<6)
					level.p[i] playlocalsound("ui_mp_timer_countdown");
			}
			wait 1;
		}
		wait 0.5;
		newmap=level.nextmap1;
		newstr=MapRegistry(level.nextmap1);
		topvote=level.mapvote["1"];
		if(level.mapvote["2"]>topvote)
		{
			newmap=level.nextmap2;
			newstr=MapRegistry(level.nextmap2);
			topvote=level.mapvote["2"];
		}
		if(level.mapvote["3"]>topvote)
		{
			newmap=level.nextmap3;
			newstr=MapRegistry(level.nextmap3);
		}
		setdvar("sv_maprotationcurrent", "map "+newmap);
		iprintlnbold("^1Nextmap: ^2"+newstr);

		thread deleteHuds();
		wait 1;
	}
	else
		setdvar("sv_maprotationcurrent", "map "+level.nextmap1);
}
deleteHuds()
{
	for(i=0;i<level.p.size;i++)
	{
		level.p[i] notify("vote_end");
		if(isDefined(level.p[i].hud_mapvote))
		{
			for(j=0;j<level.p[i].hud_mapvote.size;j++)
			{
				level.p[i].hud_mapvote[j] fadeOverTime(1);
				level.p[i].hud_mapvote[j].alpha = 0;
			}
		}
	}
	wait 1;
	for(i=0;i<level.p.size;i++)
	{
		if(isDefined(level.p[i].hud_mapvote))
		{
			for(j=0;j<level.p[i].hud_mapvote.size;j++)
				level.p[i].hud_mapvote[j] destroy();
		}
	}
}
PlayerVote()
{
self endon("disconnect");
self endon("vote_end");

	self disableweapons();
	self freezecontrols(true);
	self setClientDvar("g_scriptMainMenu", game["menu_eog_main"]);
	self closeMenu();
	self closeInGameMenu();
	wait 1;
	self thread addMapvoteShader(1,0,0,260,140,0.4,(0.3,0.3,0.3));
	self thread addMapvoteShader(2,0,-70,260,1,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,0,-40,260,1,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,0,50,261,1,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,0,70,261,1,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,-130,0,1,140,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,60,-10,1,120,1,(0.4,0.4,0.4));
	self thread addMapvoteShader(2,130,0,1,140,1,(0.4,0.4,0.4));
	self thread addMapvoteText(-125,-55,"left","default",2,(0.5, 0, 0),"Nextmap");
	self thread addMapvoteText(95,-55,"center","default",1.8,(0.5, 0, 0),"Votes");
	self thread addMapvoteText(-35,-25,"center","objective",1.4,(1, 1, 1),MapRegistry(level.nextmap1));
	self thread addMapvoteText(-35,5,"center","objective",1.4,(1, 1, 1),MapRegistry(level.nextmap2));
	self thread addMapvoteText(-35,35,"center","objective",1.4,(1, 1, 1),MapRegistry(level.nextmap3));
	self thread addMapvoteLabel(-125,60,"left","default",1.4,(1, 1, 1),&"Time left: ^2&&1",20);
	self thread addMapvoteLabel(95,-25,"center","objective",1.4,(1, 1, 1),&"&&1",0);
	self thread addMapvoteLabel(95,5,"center","objective",1.4,(1, 1, 1),&"&&1",0);
	self thread addMapvoteLabel(95,35,"center","objective",1.4,(1, 1, 1),&"&&1",0);

	choice="none";

	while(1)
	{
		wait 0.1;
		if(self attackButtonPressed())
		{
			if(choice=="none")
			{
				choice="1";
				self setVote("1","0");
			}
			else if(choice=="1")
			{
				choice="2";
				self setVote("2","1");
			}
			else if(choice=="2")
			{
				choice="3";
				self setVote("3","2");
			}
			else if(choice=="3")
			{
				choice="1";
				self setVote("1","3");
			}
			self playLocalSound("mouse_click");
			wait 0.1;
		}
	}
}
setVote(s,p)
{
	if(p!=0)
		level.mapvote[p]--;

	level.mapvote[s]++;
	switch(s)
	{
	case "1":self setVoteHud(1,0,0);break;
	case "2":self setVoteHud(0,1,0);break;
	case "3":self setVoteHud(0,0,1);break;
	default:break;
	}
	updateVotes();
}
updateVotes()
{
	for(i=0;i<level.p.size;i++)
	{
		if(isDefined(level.p[i].hud_mapvote[14]))
			level.p[i].hud_mapvote[14] setValue(level.mapvote["1"]);
		if(isDefined(level.p[i].hud_mapvote[15]))
			level.p[i].hud_mapvote[15] setValue(level.mapvote["2"]);
		if(isDefined(level.p[i].hud_mapvote[16]))
			level.p[i].hud_mapvote[16] setValue(level.mapvote["3"]);
	}
}
setVoteHud(x,y,z)
{
	self.hud_mapvote[10].glowAlpha = x;
	self.hud_mapvote[11].glowAlpha = y;
	self.hud_mapvote[12].glowAlpha = z;
	self.hud_mapvote[14].glowAlpha = self.hud_mapvote[10].glowAlpha;
	self.hud_mapvote[15].glowAlpha = self.hud_mapvote[11].glowAlpha;
	self.hud_mapvote[16].glowAlpha = self.hud_mapvote[12].glowAlpha;

	if(self.hud_mapvote[10].glowAlpha>0)
		self.hud_mapvote[10].color=(1,0.5,0);
	else
		self.hud_mapvote[10].color=(1,1,1);
	if(self.hud_mapvote[11].glowAlpha>0)
		self.hud_mapvote[11].color=(1,0.5,0);
	else
		self.hud_mapvote[11].color=(1,1,1);
	if(self.hud_mapvote[12].glowAlpha>0)
		self.hud_mapvote[12].color=(1,0.5,0);
	else
		self.hud_mapvote[12].color=(1,1,1);

	self.hud_mapvote[14].color=self.hud_mapvote[10].color;
	self.hud_mapvote[15].color=self.hud_mapvote[11].color;
	self.hud_mapvote[16].color=self.hud_mapvote[12].color;

}
