//
//  ServerManager.swift
//  RagnarokOffline
//
//  Created by Leon Li on 2026/5/22.
//

import Foundation
import Observation
import rAthenaChar
import rAthenaCharPre
import rAthenaCommon
import rAthenaLogin
import rAthenaLoginPre
import rAthenaMap
import rAthenaMapPre
import rAthenaResources
import rAthenaWeb
import rAthenaWebPre

let serverWorkingDirectoryURL = URL.libraryDirectory.appending(path: "rathena", directoryHint: .isDirectory)

let serverConfiguration = ServerConfiguration(
    battle_conf: """
        area_size: 26
        max_walk_path: 32
        // [RagOff iPad Mod] Rates, written with reference to rAthena conf/battle/exp.conf and drops.conf.
        // 100 = x1, 1000 = x10. Change the numbers to adjust.
        base_exp_rate: 1000
        job_exp_rate: 1000
        item_rate_common: 500
        item_rate_heal: 500
        item_rate_use: 500
        item_rate_equip: 500
        item_rate_card: 500
        """,
    char_conf: """
        login_ip: 127.0.0.1
        stdout_with_ansisequence: yes
        char_name_option: 0
        char_del_delay: 0
        pincode_enabled: no
        """,
    groups: """
        Header:
          Type: PLAYER_GROUP_DB
          Version: 1

        Body:
          - Id: 0
            Commands:
              mapmove: true
              jobchange: true
              alive: true
              heal: true
              item: true
              baselevelup: true
              joblevelup: true
              monster: true
              zeny: true
              str: true
              agi: true
              vit: true
              int: true
              dex: true
              luk: true
              mount_peco: true
              autoloot: true
              effect: true
            Permissions:
              any_warp: true
              # [RagOff iPad Mod] Unlock every @command (e.g. @refine, @item2, @allskill, @allstats, @go)
              # and allow trading / parties, following rAthena conf/groups.yml (Admin group).
              all_commands: true
              can_trade: true
              can_party: true
        """,
    login_conf: """
        stdout_with_ansisequence: yes
        new_account: yes
        """,
    map_conf: """
        char_ip: 127.0.0.1
        stdout_with_ansisequence: yes
        // [RagOff iPad Mod] 冒險服務員 NPC (written by installModFiles).
        npc: npc/custom/ragoff_adventurer.txt
        """,
    web_conf: """
        stdout_with_ansisequence: yes
        """
)

// [RagOff iPad Mod] Server messages in Chinese, using rAthena's own conf/msg_conf/map_msg_chn.conf.
// map_msg.conf imports conf/msg_conf/import/map_msg_eng_conf.txt, which is written below.
let serverMessageOverride = """
    import: conf/msg_conf/map_msg_chn.conf

    // These lines use different format specifiers in map_msg_chn.conf, so keep the English text.
    85: Invalid time for %s command (time=%d).
    88: Sending request to %s server...
    114: %d item(s) removed from the player.
    115: %d item(s) removed. Player had only %d on %d items.
    116: Character does not have the specified item.
    374: Blue -- Player %s invites you to PVP duel (Use @accept/@reject) --
    423: Your %s has been banished until %s
    504: Used %d kafra points and %d cash points. %d kafra and %d cash points remaining.
    1021: Please enter a player name (usage: %s <char name>).
    1022: Please enter ban time and a player name (usage: %s <time> <char name>).
    1024: MVP Drop Rates: Common %.2fx / Healing %.2fx / Usable %.2fx / Equipment %.2fx / Card %.2fx
    1040: Map: %s | Players: %d | NPCs: %d | Chats: %d | Vendings: %d
    1285: Item: '%s' (ID: %u)
    1295: rAthena Version %s %s
    1494: %d items are dropped (%d skipped)!
    """

// [RagOff iPad Mod] 冒險服務員 (Adventure Attendant) NPC script, loaded through map_conf "npc:".
let adventurerScript = """
    //===== RagOff iPad Mod ======================================
    //= 冒險服務員 (Adventure Attendant)
    //= Original script for the RagOff iPad mod.
    //= Warp coordinates follow rAthena npc/custom/warper.txt (@go aligned).
    //============================================================

    function	script	F_RagOffAdventurer	{
    	debugmes "[RagOff] Adventurer clicked by " + strcharinfo(0);
    	mes "[冒險服務員]";
    	mes "冒險者你好！需要什麼服務呢？";
    	next;
    	switch (select("傳送服務:治療與祝福:重置素質/技能:倉庫與存檔點:鑑定/修理裝備:轉職服務:領取冒險補給:道具商店:一鍵升到 200 等:領取 200 等套裝:不用了")) {
    	case 1:
    		switch (select("城鎮:迷宮:上次傳送的地點")) {
    		case 1:
    			setarray .@name$, "普隆德拉","依斯魯德","吉芬","夢羅克","斐揚","艾爾貝塔","艾爾帕蘭","朱諾","克魔島","汶巴拉","尼芙菲姆","天津","崑崙","洛陽","阿約塔雅","艾音布羅克","里希塔樂鎮","雨果","拉赫","維恩斯","聖誕村","莫斯科維亞";
    			setarray .@map$, "prontera","izlude","geffen","morocc","payon","alberta","aldebaran","yuno","comodo","umbala","niflheim","amatsu","gonryun","louyang","ayothaya","einbroch","lighthalzen","hugel","rachel","veins","xmas","moscovia";
    			setarray .@x, 155,128,119,156,179,28,140,157,209,97,202,198,160,217,208,64,158,96,130,216,147,223;
    			setarray .@y, 183,(checkre(3) ? 146 : 114),59,93,100,234,131,51,143,153,174,84,120,100,166,200,92,145,110,123,134,184;
    			.@i = select(implode(.@name$, ":")) - 1;
    			.@wm$ = .@map$[.@i];
    			.@wx = .@x[.@i];
    			.@wy = .@y[.@i];
    			goto L_DoWarp;
    		case 2:
    			setarray .@name$, "普隆德拉地下水道","斐揚洞窟","吉芬地下城","海底洞穴","獸人地下城","金字塔","斯芬克斯","沉船","螞蟻地獄","礦坑","被詛咒的修道院","時計塔","玩具工廠","龜島","克雷斯特漢姆","冰洞","熔岩洞窟","天津地下城","洛陽地下城","基爾地下城","死者之塔","托爾火山","生體工學研究所","深淵湖水","奧丁神殿","拉赫聖殿";
    			setarray .@floor$,
    				"prt_sewb1,131,247|prt_sewb2,19,19|prt_sewb3,180,169|prt_sewb4,100,92",
    				"pay_dun00,21,183|pay_dun01,19,33|pay_dun02,19,63|pay_dun03,155,159|pay_dun04,201,204",
    				"gef_dun00,104,99|gef_dun01,115,236|gef_dun02,106,132|gef_dun03,203,200",
    				"iz_dun00,168,168|iz_dun01,253,252|iz_dun02,236,204|iz_dun03,32,63|iz_dun04,26,27",
    				"orcsdun01,32,170|orcsdun02,21,185",
    				"moc_pryd01,192,9|moc_pryd02,10,192|moc_pryd03,100,92|moc_pryd04,181,11|moc_pryd05,94,96|moc_pryd06,192,8",
    				"in_sphinx1,288,9|in_sphinx2,149,81|in_sphinx3,210,54|in_sphinx4,10,222|in_sphinx5,100,99",
    				"treasure01,69,24|treasure02,102,27",
    				"anthell01,35,262|anthell02,168,170",
    				"mjo_dun01,52,17|mjo_dun02,381,343|mjo_dun03,302,262",
    				"abbey01,51,14|abbey02,150,11|abbey03,120,10",
    				"c_tower1,199,159|c_tower2,148,283|c_tower3,65,147|c_tower4,56,155|alde_dun01,297,25|alde_dun02,127,169|alde_dun03,277,178|alde_dun04,268,74",
    				"xmas_dun01,205,15|xmas_dun02,129,133",
    				"tur_dun01,154,49|tur_dun02,148,261|tur_dun03,132,189|tur_dun04,100,192",
    				"glast_01,370,304|gl_cas01,199,29|gl_cas02,104,25|gl_knt01,150,15|gl_knt02,157,287|gl_chyard,147,15|gl_sew01,258,255|gl_sew02,108,291|gl_sew03,171,283|gl_sew04,68,277|gl_church,156,7|gl_step,12,7|gl_dun01,133,271|gl_dun02,224,274|gl_prison,14,70|gl_prison1,150,14",
    				"ice_dun01,157,14|ice_dun02,151,155|ice_dun03,149,22|ice_dun04,33,158",
    				"mag_dun01,126,68|mag_dun02,47,30",
    				"ama_dun01,228,11|ama_dun02,34,41|ama_dun03,119,14",
    				"lou_dun01,218,196|lou_dun02,282,20|lou_dun03,165,38",
    				"kh_dun01,28,226|kh_dun02,41,198",
    				"tha_t01,150,39|tha_t02,150,136|tha_t03,220,158|tha_t04,59,143|tha_t05,62,11|tha_t06,89,221|tha_t07,35,166|tha_t08,93,148|tha_t09,29,107|tha_t10,159,138|tha_t11,19,20|tha_t12,130,52",
    				"thor_v01,21,228|thor_v02,75,205|thor_v03,34,272",
    				"lhz_dun01,150,288|lhz_dun02,150,18|lhz_dun03,140,134",
    				"abyss_01,261,272|abyss_02,275,270|abyss_03,116,27",
    				"odin_tem01,298,167|odin_tem02,224,149|odin_tem03,266,280",
    				"ra_san01,140,11|ra_san02,32,21|ra_san03,8,149|ra_san04,204,218|ra_san05,150,9";
    			.@d = select(implode(.@name$, ":")) - 1;
    			explode(.@f$, .@floor$[.@d], "|");
    			.@n = getarraysize(.@f$);
    			for (.@k = 0; .@k < .@n; .@k++) {
    				explode(.@p$, .@f$[.@k], ",");
    				.@menu$[.@k] = "第 " + (.@k + 1) + " 區 (" + .@p$[0] + ")";
    			}
    			.@s = select(implode(.@menu$, ":")) - 1;
    			explode(.@p$, .@f$[.@s], ",");
    			.@wm$ = .@p$[0];
    			.@wx = atoi(.@p$[1]);
    			.@wy = atoi(.@p$[2]);
    			goto L_DoWarp;
    		case 3:
    			if (ragoff_lastmap$ == "") {
    				mes "[冒險服務員]";
    				mes "你還沒有用我傳送過喔。";
    				close;
    			}
    			.@wm$ = ragoff_lastmap$;
    			.@wx = ragoff_lastx;
    			.@wy = ragoff_lasty;
    			goto L_DoWarp;
    		}
    		end;

    	case 2:
    		percentheal 100,100;
    		skilleffect "AL_INCAGI",10;
    		sc_start SC_INCREASEAGI,240000,10;
    		skilleffect "AL_BLESSING",10;
    		sc_start SC_BLESSING,240000,10;
    		mes "[冒險服務員]";
    		mes "HP、SP 已經回滿，";
    		mes "也幫你加上了速度增加和天使之賜福（4 分鐘）。";
    		close;

    	case 3:
    		mes "[冒險服務員]";
    		mes "要重置哪一個呢？";
    		next;
    		switch (select("重置素質點:重置技能點:兩個都重置:取消")) {
    		case 1:
    			resetstatus;
    			break;
    		case 2:
    			resetskill;
    			break;
    		case 3:
    			resetstatus;
    			resetskill;
    			break;
    		default:
    			close;
    		}
    		mes "[冒險服務員]";
    		mes "重置完成了，點數已經還給你。";
    		close;

    	case 4:
    		switch (select("開啟倉庫:在這裡記錄存檔點:取消")) {
    		case 1:
    			close2;
    			openstorage;
    			end;
    		case 2:
    			getmapxy(.@m$, .@x, .@y);
    			savepoint .@m$, .@x, .@y;
    			mes "[冒險服務員]";
    			mes "已經把存檔點記錄在這裡了。";
    			close;
    		}
    		close;

    	case 5:
    		switch (select("鑑定所有物品:修理所有裝備:取消")) {
    		case 1:
    			identifyall;
    			mes "[冒險服務員]";
    			mes "背包裡的物品都鑑定好了。";
    			close;
    		case 2:
    			repairall;
    			mes "[冒險服務員]";
    			mes "損壞的裝備都修好了。";
    			close;
    		}
    		close;

    	case 6:
    		mes "[冒險服務員]";
    		mes "想轉成哪一系的職業呢？";
    		mes "轉職後職業等級會變回 1，";
    		mes "多出來的技能點可以在這裡重置。";
    		next;
    		switch (select("一轉:二轉:進階二轉:進階三轉:四轉:擴充職業:取消")) {
    		case 1:
    			setarray .@jname$, "劍士","魔法師","弓箭手","服事","商人","盜賊","跆拳少年","槍手","忍者","超級初學者";
    			setarray .@jid, 1,2,3,4,5,6,4046,24,25,23;
    			break;
    		case 2:
    			setarray .@jname$, "騎士","祭司","巫師","鐵匠","獵人","刺客","十字軍","武僧","賢者","流氓","鍊金術師","詩人","舞孃","拳聖","悟靈士";
    			setarray .@jid, 7,8,9,10,11,12,14,15,16,17,18,19,20,4047,4049;
    			break;
    		case 3:
    			setarray .@jname$, "騎士領主","神官","超魔導士","神工匠","神射手","十字刺客","聖殿十字軍","武術宗師","智者","神行太保","創造者","搞笑藝人","冷豔舞姬";
    			setarray .@jid, 4008,4009,4010,4011,4012,4013,4015,4016,4017,4018,4019,4020,4021;
    			break;
    		case 4:
    			setarray .@jname$, "盧恩騎士 (Rune Knight)","大法師 (Warlock)","遊俠 (Ranger)","大主教 (Arch Bishop)","機匠 (Mechanic)","十字斬首者 (Guillotine Cross)","皇家禁衛隊 (Royal Guard)","魔導師 (Sorcerer)","宮廷樂師 (Minstrel)","浪跡舞者 (Wanderer)","修羅 (Sura)","基因學者 (Genetic)","魅影追蹤者 (Shadow Chaser)";
    			setarray .@jid, 4060,4061,4062,4063,4064,4065,4073,4074,4075,4076,4077,4078,4079;
    			break;
    		case 5:
    			setarray .@jname$, "Dragon Knight","Meister","Shadow Cross","Arch Mage","Cardinal","Windhawk","Imperial Guard","Biolo","Abyss Chaser","Elemental Master","聖裁者 (Inquisitor)","Troubadour","Trouvere";
    			setarray .@jid, 4252,4253,4254,4255,4256,4257,4258,4259,4260,4261,4262,4263,4264;
    			break;
    		case 6:
    			setarray .@jname$, "擴充超級初學者 (Expanded Super Novice)","星帝 (Star Emperor)","Soul Reaper","叛亂者 (Rebellion)","影狼 (Kagerou)","朧 (Oboro)","喵族召喚師 (Summoner)","Sky Emperor","Soul Ascetic","Shinkiro","Shiranui","Night Watch","Hyper Novice","Spirit Handler";
    			setarray .@jid, 4190,4239,4240,4215,4211,4212,4218,4302,4303,4304,4305,4306,4307,4308;
    			break;
    		default:
    			close;
    		}
    		.@j = select(implode(.@jname$, ":")) - 1;
    		if (.@jid[.@j] >= 4054 && !checkre(0)) {
    			mes "[冒險服務員]";
    			mes "這個職業只有在 Renewal 模式才能轉喔。";
    			close;
    		}
    		jobchange .@jid[.@j];
    		mes "[冒險服務員]";
    		mes "轉職完成！加油吧！";
    		close;

    	case 7:
    		getitem 504,50;   // White Potion
    		getitem 505,30;   // Blue Potion
    		getitem 601,100;  // Fly Wing
    		getitem 602,20;   // Butterfly Wing
    		getitem 611,10;   // Magnifier
    		getitem 2301,1;   // Cotton Shirt
    		getitem 2401,1;   // Sandals
    		getitem 2501,1;   // Hood
    		getitem 2101,1;   // Guard
    		mes "[冒險服務員]";
    		mes "這是冒險補給，請收下！";
    		mes "藥水、蒼蠅翅膀、蝴蝶翅膀、放大鏡，";
    		mes "還有一套基本防具。";
    		close;

    	case 8:
    		close2;
    		callshop "RagOffShop",1;
    		end;
    	case 9:
    		mes "[冒險服務員]";
    		mes "要把基本等級直接升到 200 嗎？";
    		mes "職業等級也會一起升到上限。";
    		mes "（上限比 200 低的職業會停在上限。）";
    		next;
    		if (select("升級:取消") == 2)
    			close;
    		if (BaseLevel < 200)
    			atcommand "@blvl " + (200 - BaseLevel);
    		atcommand "@jlvl 100";
    		mes "[冒險服務員]";
    		mes "升級完成！記得去分配素質點和技能點喔。";
    		close;

    	case 10:
    		.@bj = BaseJob;
    		if (.@bj == 7)                                       // Knight family
    			setarray .@w, 21064,600032,630020;
    		else if (.@bj == 14)                                 // Crusader family
    			setarray .@w, 500057,500058,530036;
    		else if (.@bj == 9)                                  // Wizard family
    			setarray .@w, 550096,640038,640039;
    		else if (.@bj == 16)                                 // Sage family
    			setarray .@w, 540061,540062,550097;
    		else if (.@bj == 8)                                  // Priest family
    			setarray .@w, 540063,550098,550099;
    		else if (.@bj == 15)                                 // Monk family
    			setarray .@w, 560039,560040,590052;
    		else if (.@bj == 10)                                 // Blacksmith family
    			setarray .@w, 520022,590050,620021;
    		else if (.@bj == 18)                                 // Alchemist family
    			setarray .@w, 500059,510079,590051;
    		else if (.@bj == 12)                                 // Assassin family
    			setarray .@w, 510080,510081,510082,510083,610043;
    		else if (.@bj == 17)                                 // Rogue family
    			setarray .@w, 510084,510085,700061;
    		else if (.@bj == 11)                                 // Hunter family
    			setarray .@w, 510086,700062,700063;
    		else if (.@bj == 19 || .@bj == 20)                   // Bard / Dancer family
    			setarray .@w, 570034,570035,580035,580036,700064;
    		else if (.@bj == 25 || .@bj == 4211 || .@bj == 4212 || .@bj == 4304 || .@bj == 4305)   // Ninja family
    			setarray .@w, 510087,510088,510089,510090,650030;
    		else if (.@bj == 24 || .@bj == 4215 || .@bj == 4306) // Gunslinger family
    			setarray .@w, 800017,810016,820012,830016,840011;
    		else if (.@bj == 4047 || .@bj == 4239 || .@bj == 4302) // Star Gladiator family
    			setarray .@w, 540064,540065,540066;
    		else if (.@bj == 4049 || .@bj == 4240 || .@bj == 4303) // Soul Linker family
    			setarray .@w, 550100,550101,550102;
    		else if (.@bj == 4218 || .@bj == 4308)               // Summoner family
    			setarray .@w, 550103,550104,550105;
    		else if (.@bj == 0 || .@bj == 23 || .@bj == 4190 || .@bj == 4307) // Novice family
    			setarray .@w, 500060,550106,550107;

    		mes "[冒險服務員]";
    		mes "這是 200 等的 Herosria 套裝：";
    		mes "頭飾、盔甲、盾牌、鞋子、披肩、飾品各種款式都有，";
    		if (getarraysize(.@w))
    			mes "再加上你這個職業能用的 Herosria 武器。";
    		else
    			mes "你目前的職業沒有專屬武器，轉職後可以再來領。";
    		mes "總共大約 40 件，背包要留空位喔。";
    		next;
    		if (select("領取:取消") == 2)
    			close;
    		for (.@i = 0; .@i < getarraysize(.@w); .@i++)
    			getitem .@w[.@i], 1;
    		setarray .@a,
    			400336,400337,400338,400339,400340,401239,401240,401241,401242,401243,  // headgear
    			450229,450230,450231,450232,450233,                                      // armor
    			460034,460035,460036,460037,                                             // shield
    			470153,470154,470155,470156,470157,                                      // shoes
    			480215,480216,480217,480218,480219,                                      // garment
    			490251,490252,490253,490254,490255,490256;                               // accessory
    		for (.@i = 0; .@i < getarraysize(.@a); .@i++)
    			getitem .@a[.@i], 1;
    		mes "[冒險服務員]";
    		mes "裝備都給你了，挑適合自己的穿上吧！";
    		close;

    	}
    	close;

    L_DoWarp:
    	ragoff_lastmap$ = .@wm$;
    	ragoff_lastx = .@wx;
    	ragoff_lasty = .@wy;
    	warp .@wm$, .@wx, .@wy;
    	end;
    }

    -	script	RagOffAdventurerInit	-1,{
    	end;
    OnInit:
    	debugmes "[RagOff] Adventurer script loaded";
    	end;
    }

    -	shop	RagOffShop	-1,501:-1,502:-1,503:-1,504:-1,505:-1,506:-1,601:-1,602:-1,611:-1,645:-1,656:-1,657:-1,715:-1,716:-1,717:-1,1065:-1,1750:-1,1770:-1,7135:-1,7136:-1,7137:-1,7138:-1,7139:-1,12016:-1

    prontera,159,192,4	script	冒險服務員#prt	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    izlude,134,150,4	script	冒險服務員#izl	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    geffen,124,72,4	script	冒險服務員#gef	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    morocc,159,97,4	script	冒險服務員#moc	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    payon,182,108,4	script	冒險服務員#pay	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    alberta,28,240,4	script	冒險服務員#alb	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    aldebaran,145,118,4	script	冒險服務員#alde	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    yuno,162,47,4	script	冒險服務員#yuno	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    comodo,194,158,4	script	冒險服務員#com	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    umbala,106,150,3	script	冒險服務員#umb	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    niflheim,205,179,4	script	冒險服務員#nif	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    amatsu,203,87,4	script	冒險服務員#ama	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    gonryun,162,122,4	script	冒險服務員#gon	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    louyang,208,103,6	script	冒險服務員#lou	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    ayothaya,209,169,6	script	冒險服務員#ayo	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    einbroch,69,202,4	script	冒險服務員#einbr	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    lighthalzen,162,102,4	script	冒險服務員#lhz	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    hugel,101,151,4	script	冒險服務員#hug	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    rachel,135,116,4	script	冒險服務員#rac	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    veins,214,123,4	script	冒險服務員#ve	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    xmas,150,136,6	script	冒險服務員#xmas	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    moscovia,229,191,4	script	冒險服務員#mos	124,{
    	callfunc "F_RagOffAdventurer";
    	end;
    }
    """

/// Writes the mod's extra server files after the working directory is prepared.
func installModFiles(at workingDirectoryURL: URL) throws {
    let fileManager = FileManager.default

    let messageImportURL = workingDirectoryURL.appending(path: "conf/msg_conf/import", directoryHint: .isDirectory)
    try fileManager.createDirectory(at: messageImportURL, withIntermediateDirectories: true)
    try serverMessageOverride.write(to: messageImportURL.appending(path: "map_msg_eng_conf.txt"), atomically: true, encoding: .utf8)
    try "// [RagOff iPad Mod] Intentionally empty.\n".write(to: messageImportURL.appending(path: "map_msg_chn_conf.txt"), atomically: true, encoding: .utf8)

    let customNPCURL = workingDirectoryURL.appending(path: "npc/custom", directoryHint: .isDirectory)
    try fileManager.createDirectory(at: customNPCURL, withIntermediateDirectories: true)
    try adventurerScript.write(to: customNPCURL.appending(path: "ragoff_adventurer.txt"), atomically: true, encoding: .utf8)
}

@MainActor
@Observable
final class ServerManager {
    private(set) var mode: ServerMode

    var loginServer: ServerModel {
        switch mode {
        case .prerenewal: prerenewalLoginServer
        case .renewal: renewalLoginServer
        }
    }

    var charServer: ServerModel {
        switch mode {
        case .prerenewal: prerenewalCharServer
        case .renewal: renewalCharServer
        }
    }

    var mapServer: ServerModel {
        switch mode {
        case .prerenewal: prerenewalMapServer
        case .renewal: renewalMapServer
        }
    }

    var webServer: ServerModel {
        switch mode {
        case .prerenewal: prerenewalWebServer
        case .renewal: renewalWebServer
        }
    }

    private let renewalLoginServer = ServerModel(server: LoginServer.shared)
    private let renewalCharServer = ServerModel(server: CharServer.shared)
    private let renewalMapServer = ServerModel(server: MapServer.shared)
    private let renewalWebServer = ServerModel(server: WebServer.shared)

    private let prerenewalLoginServer = ServerModel(server: LoginServerPre.shared)
    private let prerenewalCharServer = ServerModel(server: CharServerPre.shared)
    private let prerenewalMapServer = ServerModel(server: MapServerPre.shared)
    private let prerenewalWebServer = ServerModel(server: WebServerPre.shared)

    private var allServers: [ServerModel] {
        [loginServer, charServer, mapServer, webServer]
    }

    private let serverResourceManager = ServerResourceManager()

    @ObservationIgnored private var serversToResume: [ServerModel] = []

    var allServersAreRunning: Bool {
        allServers.allSatisfy({ $0.status == .running })
    }

    init(mode: ServerMode) {
        self.mode = mode
    }

    func setMode(_ mode: ServerMode) async {
        guard mode != self.mode else {
            return
        }

        await stopAllServers()

        self.mode = mode
    }

    func startServer(_ server: ServerModel) async throws {
        try await serverResourceManager.prepareWorkingDirectory(at: serverWorkingDirectoryURL, mode: mode, configuration: serverConfiguration)
        try installModFiles(at: serverWorkingDirectoryURL)
        _ = await server.start()
    }

    func startAllServers() async throws {
        try await serverResourceManager.prepareWorkingDirectory(at: serverWorkingDirectoryURL, mode: mode, configuration: serverConfiguration)
        try installModFiles(at: serverWorkingDirectoryURL)
        await startServers(allServers)
    }

    func stopServer(_ server: ServerModel) async {
        _ = await server.stop()
    }

    func stopAllServers() async {
        serversToResume.removeAll()
        await stopServers(allServers)
    }

    func pauseServers() async {
        serversToResume = allServers.filter({ $0.status == .running })
        await stopServers(serversToResume)
    }

    func resumeServers() async throws {
        let servers = serversToResume
        serversToResume.removeAll()

        try await serverResourceManager.prepareWorkingDirectory(at: serverWorkingDirectoryURL, mode: mode, configuration: serverConfiguration)
        try installModFiles(at: serverWorkingDirectoryURL)
        await startServers(servers)
    }

    private func startServers(_ servers: [ServerModel]) async {
        await withTaskGroup(of: Void.self) { taskGroup in
            for server in servers {
                taskGroup.addTask {
                    _ = await server.start()
                }
            }
        }
    }

    private func stopServers(_ servers: [ServerModel]) async {
        await withTaskGroup(of: Void.self) { taskGroup in
            for server in servers {
                taskGroup.addTask {
                    _ = await server.stop()
                }
            }
        }
    }
}
