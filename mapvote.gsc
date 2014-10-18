/*--------------------------------

##### #   # #   # #   # ##### ####
#     #   # ##  # ##  # #     #  #
#  ## #   # # # # # # # ##### ####
#   # #   # #  ## #  ## #     # #
##### ##### #   # #   # ##### #  #

----------------------------------*/
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
	//ONLY DEBUG
	//level.players=level.p;
	//setDvar("sv_maprotation","gametype dm map mp_crash gametype tdm map mp_crash gametype dm map mp_backlot gametype tdm map mp_backlot gametype dm map mp_bog gametype tdm map mp_bog gametype dm map mp_strike gametype tdm map mp_strike");

	maps=[];
	type=[];
	rotation=strtok(getDvar("sv_maprotation")," ");
	for(i=0;i<rotation.size;i++)
	{
		gt=getdvar("g_gametype");
		if(rotation[i]=="gametype")
		{
			gt=rotation[i+1];
			i+=2;
		}	
		if(isDefined(rotation[i]) && rotation[i]=="map")
		{
			type[maps.size]=gt;
			if(isDefined(rotation[i+1]))
				maps[maps.size]=rotation[i+1];
			else
				maps[maps.size]=getdvar("mapname");

			i++;
		}
	}
	if(level.players.size>0)
	{
		level.mapvote["1"] = 0;
		level.mapvote["2"] = 0;
		level.mapvote["3"] = 0;
		level.mapvote["4"] = 0;
		level.mapvote["5"] = 0;
		for(i=0;i<level.players.size;i++)
			level.players[i] thread PlayerVote(maps,type);

		for(t=20;t>=0;t--)
		{
			for(i=0;i<level.players.size;i++)
			{
				level.players[i].hud_mapvote[15] setValue(t);
				if(t==5)
					level.players[i].hud_mapvote[15].label=&"Time left: ^1&&1";
				if(t<6)
					level.players[i] playlocalsound("ui_mp_timer_countdown");
			}
			wait 1;
		}
		wait 0.5;
		newmap=0;
		topvote=level.mapvote["1"];
		if(level.mapvote["2"]>topvote)
		{
			newmap=1;
			topvote=level.mapvote["2"];
		}
		if(level.mapvote["3"]>topvote)
		{
			newmap=2;
			topvote=level.mapvote["3"];
		}
		if(level.mapvote["4"]>topvote)
		{
			newmap=3;
			topvote=level.mapvote["4"];
		}
		if(level.mapvote["5"]>topvote)
		{
			newmap=4;
		}
		setdvar("sv_maprotationcurrent", "g_gametype "+type[newmap]+" map "+maps[newmap]);
		iprintlnbold("Nextmap: ^2"+MapRegistry(maps[newmap])+"^3("+type[newmap]+")");

		thread deleteHuds();
		wait 3;
	}
	else
		setdvar("sv_maprotationcurrent", "g_gametype "+type[0]+" map "+maps[0]);
}
deleteHuds()
{
	for(i=0;i<level.players.size;i++)
	{
		level.players[i] notify("vote_end");
		if(isDefined(level.players[i].hud_mapvote))
		{
			for(j=0;j<level.players[i].hud_mapvote.size;j++)
			{
				level.players[i].hud_mapvote[j] fadeOverTime(1);
				level.players[i].hud_mapvote[j].alpha = 0;
			}
		}
	}
	wait 1;
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].hud_mapvote))
		{
			for(j=0;j<level.players[i].hud_mapvote.size;j++)
				level.players[i].hud_mapvote[j] destroy();
		}
	}
}
PlayerVote(maps,type)
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

	self thread addMapvoteText(-125,-55,"left","default",2,(1, 1, 1),"Nextmap");
	self thread addMapvoteText(95,-55,"center","default",1.8,(1, 1, 1),"Votes");

	self thread addMapvoteText(-35,-25,"center","objective",1.4,(1, 1, 1),MapRegistry(maps[0])+"^3("+type[0]+")");
	self thread addMapvoteText(-35,-10,"center","objective",1.4,(1, 1, 1),MapRegistry(maps[1])+"^3("+type[1]+")");
	self thread addMapvoteText(-35,5,"center","objective",1.4,(1, 1, 1),MapRegistry(maps[2])+"^3("+type[2]+")");
	self thread addMapvoteText(-35,20,"center","objective",1.4,(1, 1, 1),MapRegistry(maps[3])+"^3("+type[3]+")");
	self thread addMapvoteText(-35,35,"center","objective",1.4,(1, 1, 1),MapRegistry(maps[4])+"^3("+type[4]+")");

	self thread addMapvoteLabel(-125,60,"left","default",1.4,(1, 1, 1),&"Time left: ^2&&1",20);

	self thread addMapvoteLabel(95,-25,"center","objective",1.4,(1, 1, 1),&"&&1",0);
	self thread addMapvoteLabel(95,-10,"center","objective",1.4,(1, 1, 1),&"&&1",0);
	self thread addMapvoteLabel(95,5,"center","objective",1.4,(1, 1, 1),&"&&1",0);
	self thread addMapvoteLabel(95,20,"center","objective",1.4,(1, 1, 1),&"&&1",0);
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
				choice="4";
				self setVote("4","3");
			}
			else if(choice=="4")
			{
				choice="5";
				self setVote("5","4");
			}
			else if(choice=="5")
			{
				choice="1";
				self setVote("1","5");
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
	case "1":self setVoteHud(1,0,0,0,0);break;
	case "2":self setVoteHud(0,1,0,0,0);break;
	case "3":self setVoteHud(0,0,1,0,0);break;
	case "4":self setVoteHud(0,0,0,1,0);break;
	case "5":self setVoteHud(0,0,0,0,1);break;
	default:break;
	}
	updateVotes();
}
updateVotes()
{
	for(i=0;i<level.players.size;i++)
	{
		if(isDefined(level.players[i].hud_mapvote[16]))
			level.players[i].hud_mapvote[16] setValue(level.mapvote["1"]);
		if(isDefined(level.players[i].hud_mapvote[17]))
			level.players[i].hud_mapvote[17] setValue(level.mapvote["2"]);
		if(isDefined(level.players[i].hud_mapvote[18]))
			level.players[i].hud_mapvote[18] setValue(level.mapvote["3"]);
		if(isDefined(level.players[i].hud_mapvote[19]))
			level.players[i].hud_mapvote[19] setValue(level.mapvote["4"]);
		if(isDefined(level.players[i].hud_mapvote[20]))
			level.players[i].hud_mapvote[20] setValue(level.mapvote["5"]);
	}
}
setVoteHud(x,y,z,a,b)
{
	self.hud_mapvote[10].glowAlpha = x;
	self.hud_mapvote[11].glowAlpha = y;
	self.hud_mapvote[12].glowAlpha = z;
	self.hud_mapvote[13].glowAlpha = a;
	self.hud_mapvote[14].glowAlpha = b;
	self.hud_mapvote[16].glowAlpha = self.hud_mapvote[10].glowAlpha;
	self.hud_mapvote[17].glowAlpha = self.hud_mapvote[11].glowAlpha;
	self.hud_mapvote[18].glowAlpha = self.hud_mapvote[12].glowAlpha;
	self.hud_mapvote[19].glowAlpha = self.hud_mapvote[13].glowAlpha;
	self.hud_mapvote[20].glowAlpha = self.hud_mapvote[14].glowAlpha;

	bg=(1,0.8,0.4);

	if(self.hud_mapvote[10].glowAlpha>0)
		self.hud_mapvote[10].color=(bg);
	else
		self.hud_mapvote[10].color=(1,1,1);
	if(self.hud_mapvote[11].glowAlpha>0)
		self.hud_mapvote[11].color=(bg);
	else
		self.hud_mapvote[11].color=(1,1,1);
	if(self.hud_mapvote[12].glowAlpha>0)
		self.hud_mapvote[12].color=(bg);
	else
		self.hud_mapvote[12].color=(1,1,1);
	if(self.hud_mapvote[13].glowAlpha>0)
		self.hud_mapvote[13].color=(bg);
	else
		self.hud_mapvote[13].color=(1,1,1);
	if(self.hud_mapvote[14].glowAlpha>0)
		self.hud_mapvote[14].color=(bg);
	else
		self.hud_mapvote[14].color=(1,1,1);

	self.hud_mapvote[16].color=self.hud_mapvote[10].color;
	self.hud_mapvote[17].color=self.hud_mapvote[11].color;
	self.hud_mapvote[18].color=self.hud_mapvote[12].color;
	self.hud_mapvote[19].color=self.hud_mapvote[13].color;
	self.hud_mapvote[20].color=self.hud_mapvote[14].color;

}
