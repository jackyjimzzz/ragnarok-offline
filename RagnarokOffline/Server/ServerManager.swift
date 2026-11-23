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
        // [RagOff iPad Mod] Arrows and bullets are not used up.
        arrow_decrement: 0
        override_mob_names: 1
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
              # [RagOff iPad Mod] Skills need no items, SP or special weapons.
              skill_unconditional: true
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
    	switch (select("傳送服務:治療與祝福:重置素質/技能:倉庫與存檔點:鑑定/修理裝備:轉職服務:領取冒險補給:道具商店:一鍵升滿等級與素質:領取 200 等套裝:租借坐騎與獵鷹:PK 對手:不用了")) {
    	case 1:
    		switch (select("城鎮:迷宮:副本入口:上次傳送的地點")) {
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
    			switch (select("直接進入副本（不限人數、等級、組隊、冷卻）:傳到副本入口 NPC 旁邊:副本刷新（關閉目前的副本）")) {
    			case 1:
    				setarray .@iname$, "Endless Tower","Sealed Catacomb","Orc's Memory","Nidhoggur's Nest","Old Glast Heim","Old Glast Heim (Beginner)","Old Glast Heim (Challenge Mode)","Fall of Glast Heim (Normal)","Fall of Glast Heim (Advanced)","Sky Fortress Invasion","Devil's Tower","Poring Village","Faceworm's Nest","Ghost Palace","Horror Toy Factory","Mistwood Maze","Culvert","Octopus Cave","Bangungot Hospital 2F","Buwaya Cave","Bakonawa Lake","Wolfchev's Laboratory","Eclage Interior","Sara's Memories","Geffen Magic Tournament","Assault on the Airship","Fenrir and Sarah","Nightmarish Jitterbug","Isle of Bios","Morse's Cave","Temple of the Demon God","Central Laboratory","Last room","Charleston in Distress","Ritual of Blessing","Room of Consciousness","Heart Hunter War Base 1","Heart Hunter War Base 2","Werner Laboratory central room#1","Werner Laboratory central room#2","Infinite Space","Regenschirm","Sealed OS","OS Occupation","2nd OS Search","Cor Memorial","Half Moon In The Daylight","Weekend Dungeon","Friday Dungeon","Twilight Garden","Hey! Sweety","Farm Lost in Time","Water Garden","Water Garden Hard","Hidden Flower Garden","Security Area 1","Security Area 2","Sunken Tower","Constellation Tower","Tomb of Remorse","Geffen Night Arena","Airship Crash","Thanatos Tower","Oz Labyrinth","Thor Military Base","Wolves Gathering Place","Sanctuary Purification","High Priest's Villa","Villa of Deception","Villa of Deception Advanced","Bagot Laboratory","Confused Snake's Nest","Iwin Patrol","Airship Destruction","Simulation Battle","Deep Forest";
    				setarray .@ilabel$, "無限塔","封印神殿","半獸人的記憶","尼德霍格巢穴","舊格拉斯海姆","舊格拉斯海姆（新手）","舊格拉斯海姆（挑戰）","格拉斯海姆的陷落（普通）","格拉斯海姆的陷落（進階）","空中要塞","惡魔之塔","波利村","臉蟲巢穴","鬼魂宮殿","恐怖玩具工廠","迷霧森林","馬朗島地下水道","章魚洞窟","班古葛醫院 2F","布瓦亞洞窟","巴科納瓦湖","沃爾夫切夫研究所","艾克拉傑內部","莎拉的記憶","吉芬魔法大賽","飛空艇襲擊","芬里爾與莎拉","惡夢吉特巴","拜歐斯之島","莫斯洞窟","魔神殿","中央研究所","最後的房間","危機中的查爾斯頓","祝福儀式","意識之間","心靈獵人戰爭基地 1","心靈獵人戰爭基地 2","維納研究所中央室 1","維納研究所中央室 2","無限空間","雷根施爾姆","封印的 OS","OS 佔領","第二次 OS 搜索","柯爾紀念館","白晝的半月","週末迷宮","週五迷宮","黃昏庭園","嘿！甜心","時光中遺失的農場","水之庭園","水之庭園（困難）","隱藏花園","警戒區域 1","警戒區域 2","沉沒之塔","星座之塔","悔恨之墓","吉芬夜間競技場","飛空艇墜毀","死者之塔（副本）","歐茲迷宮","托爾軍事基地","狼群聚集地","聖域淨化","大祭司別墅","欺瞞別墅","欺瞞別墅（進階）","巴哥特研究所","混亂蛇巢","伊溫巡邏","飛空艇毀滅","模擬戰鬥","深邃森林";
    				.@i = select(implode(.@ilabel$, ":")) - 1;
    				.@old = instance_id(IM_CHAR);
    				if (.@old > 0)
    					instance_destroy .@old;
    				.@iid = instance_create(.@iname$[.@i], IM_CHAR);
    				if (.@iid <= 0) {
    					mes "[冒險服務員]";
    					mes "副本建立失敗（代碼 " + .@iid + "）。";
    					close;
    				}
    				.@r = instance_enter(.@iname$[.@i], -1, -1, getcharid(0), .@iid);
    				if (.@r != IE_OK) {
    					mes "[冒險服務員]";
    					mes "進入副本失敗（代碼 " + .@r + "）。";
    					close;
    				}
    				end;
    			case 3:
    				.@n = 0;
    				.@cid = instance_id(IM_CHAR);
    				if (.@cid > 0) {
    					instance_destroy .@cid;
    					.@n++;
    				}
    				.@pid = instance_id(IM_PARTY);
    				if (.@pid > 0) {
    					instance_destroy .@pid;
    					.@n++;
    				}
    				mes "[冒險服務員]";
    				if (.@n > 0)
    					mes "已經關閉你目前的副本，可以重新進入了。";
    				else
    					mes "你目前沒有開啟中的副本。";
    				close;
    			}
    			setarray .@name$, "無限塔","半獸人的記憶","封印神殿","尼德霍格巢穴","舊格拉斯海姆","空中要塞","惡魔之塔","波利村","臉蟲巢穴","鬼魂宮殿","恐怖玩具工廠","莫斯洞窟","魔神殿","拜歐斯之島","章魚洞窟","馬朗島地下水道","週末迷宮","週五迷宮","飛空艇襲擊","中央研究所","心靈獵人戰爭基地","無限空間";
    			setarray .@map$, "alberta","gef_fild10","monk_test","nyd_dun02","glast_01","prt_q","dali02","prt_fild05","payon","dali02","xmas","moro_cav","moro_cav","moro_cav","mal_dun01","mal_in01","pay_arche","gef_tower","dali02","verus01","ein_fild04","cmd_fild07";
    			setarray .@x, 214,242,309,100,204,249,134,174,157,43,237,61,41,50,153,172,44,57,136,153,275,54;
    			setarray .@y, 77,202,146,201,273,82,119,238,54,129,303,69,73,64,237,28,124,170,79,155,342,280;
    			mes "[冒險服務員]";
    			mes "會把你傳到副本入口的 NPC 旁邊。";
    			mes "副本大多要先組隊才能進入，";
    			mes "一個人可以先輸入 @party 隊伍名稱。";
    			next;
    			.@i = select(implode(.@name$, ":")) - 1;
    			.@wm$ = .@map$[.@i];
    			.@wx = .@x[.@i];
    			.@wy = .@y[.@i];
    			goto L_DoWarp;
    		case 4:
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
    		sc_start SC_INCREASEAGI,43200000,10;
    		skilleffect "AL_BLESSING",10;
    		sc_start SC_BLESSING,43200000,10;
    		mes "[冒險服務員]";
    		mes "HP、SP 已經回滿，";
    		mes "也幫你加上了速度增加和天使之賜福（12 小時）。";
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
    			setarray .@jname$, "盧恩龍爵 (Dragon Knight)","機甲神匠 (Meister)","十字影武 (Shadow Cross)","禁咒魔導士 (Arch Mage)","樞機主教 (Cardinal)","風鷹狩獵者 (Windhawk)","帝國聖衛軍 (Imperial Guard)","生命締造者 (Biolo)","深淵追跡者 (Abyss Chaser)","元素支配者 (Elemental Master)","聖裁者 (Inquisitor)","天籟頌者 (Troubadour)","樂之舞靈 (Trouvere)";
    			setarray .@jid, 4252,4253,4254,4255,4256,4257,4258,4259,4260,4261,4262,4263,4264;
    			break;
    		case 6:
    			setarray .@jname$, "擴充超級初學者 (Expanded Super Novice)","拳皇 (Star Emperor)","獵靈士 (Soul Reaper)","叛亂者 (Rebellion)","影狼 (Kagerou)","朧 (Oboro)","召喚師 (Summoner)","天帝 (Sky Emperor)","魂靈苦行者 (Soul Ascetic)","蜃氣樓 (Shinkiro)","幻朧 (Shiranui)","夜行者 (Night Watch)","極限初學者 (Hyper Novice)","魂靈師 (Spirit Handler)";
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
    		mes "要把基本等級和職業等級";
    		mes "直接升到目前職業的最高等級，";
    		mes "並把所有素質（含特性）點滿嗎？";
    		next;
    		if (select("升級並點滿:取消") == 2)
    			close;
    		atcommand "@blvl 999";
    		atcommand "@jlvl 999";
    		atcommand "@allstats";
    		atcommand "@pow 999";
    		atcommand "@sta 999";
    		atcommand "@wis 999";
    		atcommand "@spl 999";
    		atcommand "@con 999";
    		atcommand "@crt 999";
    		mes "[冒險服務員]";
    		mes "完成！等級和素質都已經到上限了。";
    		mes "（沒有特性的職業，特性不會變動）";
    		close;

    	case 11:
    		mes "[冒險服務員]";
    		mes "要租借什麼呢？";
    		mes "（職業不符合或沒學相關技能的話不會有變化）";
    		next;
    		switch (select("職業坐騎（大嘴鳥/龍/獅鷲/魔導機甲/座狼）:獵鷹:狼（遊俠）:手推車:全部歸還:取消")) {
    		case 1:
    			atcommand "@mount";
    			break;
    		case 2:
    			setfalcon;
    			break;
    		case 3:
    			setoption Option_Wug,1;
    			break;
    		case 4:
    			setcart;
    			break;
    		case 5:
    			setriding 0;
    			setdragon 0;
    			setmadogear 0;
    			setfalcon 0;
    			setcart 0;
    			setoption Option_Wug,0;
    			setoption Option_Wugrider,0;
    			break;
    		default:
    			close;
    		}
    		mes "[冒險服務員]";
    		mes "好了！";
    		close;

    	case 12:
    		mes "[冒險服務員]";
    		mes "要傳送到 PK 場地嗎？";
    		mes "到了之後跟「PK 管理員」說話，";
    		mes "選好對手就會開始。";
    		next;
    		if (select("出發:取消") == 2)
    			close;
    		getmapxy(.@pm$, .@px, .@py, BL_PC);
    		if (.@pm$ != "guild_vs1") {
    			ragoff_pkback$ = .@pm$;
    			ragoff_pkbackx = .@px;
    			ragoff_pkbacky = .@py;
    		}
    		warp "guild_vs1", 50, 47;
    		end;

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
    		mes "這是 200 等的 Herosria 套裝，想要哪一種類型？";
    		mes "每套 7 件：頭飾、盔甲、盾牌、鞋子、披肩、兩個飾品，";
    		if (getarraysize(.@w))
    			mes "再加上你這個職業能用的武器。";
    		next;
    		switch (select("近戰物理:暴擊:遠程物理:魔法:輔助/坦克:取消")) {
    		case 1:
    			setarray .@a, 400336,450229,460036,470153,480215,490251,490255;
    			break;
    		case 2:
    			setarray .@a, 401240,450231,460036,470155,480217,490252,490254;
    			break;
    		case 3:
    			setarray .@a, 400337,450230,460036,470157,480216,490251,490255;
    			break;
    		case 4:
    			setarray .@a, 400338,450232,460036,470154,480218,490252,490255;
    			break;
    		case 5:
    			setarray .@a, 401242,450233,460035,470157,480219,490253,490256;
    			break;
    		default:
    			close;
    		}
    		for (.@i = 0; .@i < getarraysize(.@w); .@i++)
    			getitem .@w[.@i], 1;
    		for (.@i = 0; .@i < getarraysize(.@a); .@i++)
    			getitem .@a[.@i], 1;
    		mes "[冒險服務員]";
    		mes "裝備都給你了，穿上試試看吧！";
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

    -	script	RagOffPlayerBonus	-1,{
    	end;
    OnPCLoginEvent:
    	// [RagOff iPad Mod] +100000 max weight, refreshed at every login.
    	bonus_script "{ bonus bAddMaxWeight,1000000; }",2592000,1536;
    	// [RagOff iPad Mod] Make sure the player always has a party (some instances check for one).
    	if (getcharid(1) == 0)
    		party_create("RO" + getcharid(0), getcharid(0));
    	end;
    }

    // [RagOff iPad Mod] PK arena: guild_vs1 without the guild war rules.
    guild_vs1	mapflag	gvg	off
    guild_vs1	mapflag	gvg_noparty	off
    guild_vs1	mapflag	hidemobhpbar	off
    guild_vs1	mapflag	noteleport	off

    guild_vs1,50,52,4	script	PK 管理員#ragoff	105,{
    	mes "[PK 管理員]";
    	mes "歡迎來到 PK 場地！";
    	mes "選好對手後，對手會出現在場地中央。";
    	next;
    	switch (select("選擇對手開始 PK:清除場上的對手:補滿 HP/SP:回到原本的地方:不用了")) {
    	case 1:
    		break;
    	case 2:
    		killmonster "guild_vs1", "RagOffPK::OnDummy";
    		mes "[PK 管理員]";
    		mes "場上的對手都清除了。";
    		close;
    	case 3:
    		percentheal 100,100;
    		mes "[PK 管理員]";
    		mes "HP、SP 已經補滿。";
    		close;
    	case 4:
    		killmonster "guild_vs1", "RagOffPK::OnDummy";
    		if (ragoff_pkback$ == "")
    			warp "SavePoint", 0, 0;
    		else
    			warp ragoff_pkback$, ragoff_pkbackx, ragoff_pkbacky;
    		end;
    	default:
    		close;
    	}
    	switch (select("自己的分身:轉生二轉（普通）:轉生二轉（MVP）:轉生二轉第二批（普通）:轉生二轉第二批（MVP）:三轉職業（最強 MVP）:取消")) {
    	case 1:
    		killmonster "guild_vs1", "RagOffPK::OnDummy";
    		clone "guild_vs1", 50, 40, "RagOffPK::OnDummy", getcharid(0);
    		mes "[PK 管理員]";
    		mes "你的分身出現了，開始吧！";
    		close;
    	case 2:
    		setarray .@pkid, 1634,1635,1636,1637,1638,1639;
    		setarray .@pkname$, "騎士系 賽依連","刺客系 艾勒梅斯","鐵匠系 哈沃德","牧師系 瑪嘉蕾特","獵人系 希西爾","巫師系 卡特琳娜";
    		break;
    	case 3:
    		setarray .@pkid, 1646,1647,1648,1649,1650,1651;
    		setarray .@pkname$, "騎士系 賽依連","刺客系 艾勒梅斯","鐵匠系 哈沃德","牧師系 瑪嘉蕾特","獵人系 希西爾","巫師系 卡特琳娜";
    		break;
    	case 4:
    		setarray .@pkid, 2221,2222,2223,2224,2225,2226,2227;
    		setarray .@pkname$, "十字軍系 蘭德爾","鍊金系 弗拉梅爾","賢者系 西莉亞","武僧系 陳","流氓系 格蒂","詩人系 阿爾佛西奧","舞孃系 崔恩蒂尼";
    		break;
    	case 5:
    		setarray .@pkid, 2235,2236,2237,2238,2239,2240,2241;
    		setarray .@pkname$, "十字軍系 蘭德爾","鍊金系 弗拉梅爾","賢者系 西莉亞","武僧系 陳","流氓系 格蒂","詩人系 阿爾佛西奧","舞孃系 崔恩蒂尼";
    		break;
    	case 6:
    		setarray .@pkid, 3225,3220,3223,3221,3222,3224,3240;
    		setarray .@pkname$, "盧恩騎士 賽依連","十字斬首者 艾勒梅斯","機械工匠 哈沃德","大主教 瑪嘉蕾特","遊俠 希西爾","咒術士 卡特琳娜","皇家禁衛隊 蘭德爾";
    		break;
    	default:
    		close;
    	}
    	.@n = getarraysize(.@pkid);
    	.@pkname$[.@n] = "全部一起上";
    	.@s = select(implode(.@pkname$, ":")) - 1;
    	killmonster "guild_vs1", "RagOffPK::OnDummy";
    	if (.@s == .@n) {
    		for (.@i = 0; .@i < .@n; .@i++)
    			monster "guild_vs1", 46 + (.@i % 4) * 3, 38 + (.@i / 4) * 3, "--ja--", .@pkid[.@i], 1, "RagOffPK::OnDummy";
    	} else {
    		monster "guild_vs1", 50, 40, "--ja--", .@pkid[.@s], 1, "RagOffPK::OnDummy";
    	}
    	mes "[PK 管理員]";
    	mes "對手已經在場地中央了，開始吧！";
    	close;
    }

    -	script	RagOffPK	-1,{
    	end;
    OnDummy:
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

// [RagOff iPad Mod] Fly Wing and Butterfly Wing warp at once, without the Teleport skill cast.
let itemDatabaseOverride = """
    Header:
      Type: ITEM_DB
      Version: 3

    Body:
      - Id: 601
        AegisName: Wing_Of_Fly
        Name: Fly Wing
        Type: Usable
        Script: |
          warp "Random",0,0;
      - Id: 602
        AegisName: Wing_Of_Butterfly
        Name: Butterfly Wing
        Type: Usable
        Script: |
          warp "SavePoint",0,0;
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

    let databaseImportURL = workingDirectoryURL.appending(path: "db/import", directoryHint: .isDirectory)
    try fileManager.createDirectory(at: databaseImportURL, withIntermediateDirectories: true)
    try itemDatabaseOverride.write(to: databaseImportURL.appending(path: "item_db.yml"), atomically: true, encoding: .utf8)
    try mobNameDatabaseOverride.write(to: databaseImportURL.appending(path: "mob_db.yml"), atomically: true, encoding: .utf8)
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

// [RagOff iPad Mod] Traditional Chinese monster names (db/import/mob_db.yml).
let mobNameDatabaseOverride = """
# [RagOff iPad Mod] Traditional Chinese monster names.
# Names from Pandas (https://github.com/PandasWS/Pandas, GPL-3.0), tools/python/db/zh-tw/mobname.txt.
Header:
  Type: MOB_DB
  Version: 5

Body:
  - Id: 1001
    Name: "蠍子"
    JapaneseName: "蠍子"
  - Id: 1002
    Name: "波利"
    JapaneseName: "波利"
  - Id: 1004
    Name: "蜂兵"
    JapaneseName: "蜂兵"
  - Id: 1005
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 1007
    Name: "綠棉蟲"
    JapaneseName: "綠棉蟲"
  - Id: 1008
    Name: "蟲蛹"
    JapaneseName: "蟲蛹"
  - Id: 1009
    Name: "禿鷹"
    JapaneseName: "禿鷹"
  - Id: 1010
    Name: "樹精"
    JapaneseName: "樹精"
  - Id: 1011
    Name: "蒼蠅"
    JapaneseName: "蒼蠅"
  - Id: 1012
    Name: "羅達蛙"
    JapaneseName: "羅達蛙"
  - Id: 1013
    Name: "狼"
    JapaneseName: "狼"
  - Id: 1014
    Name: "魔菇"
    JapaneseName: "魔菇"
  - Id: 1015
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 1016
    Name: "邪骸弓箭手"
    JapaneseName: "邪骸弓箭手"
  - Id: 1018
    Name: "克瑞米"
    JapaneseName: "克瑞米"
  - Id: 1019
    Name: "大嘴鳥"
    JapaneseName: "大嘴鳥"
  - Id: 1020
    Name: "曼陀羅魔花"
    JapaneseName: "曼陀羅魔花"
  - Id: 1023
    Name: "獸人戰士"
    JapaneseName: "獸人戰士"
  - Id: 1024
    Name: "森靈"
    JapaneseName: "森靈"
  - Id: 1025
    Name: "青蛇"
    JapaneseName: "青蛇"
  - Id: 1026
    Name: "殭屍"
    JapaneseName: "殭屍"
  - Id: 1028
    Name: "邪骸士兵"
    JapaneseName: "邪骸士兵"
  - Id: 1029
    Name: "蛇女伊絲"
    JapaneseName: "蛇女伊絲"
  - Id: 1030
    Name: "毒蛇"
    JapaneseName: "毒蛇"
  - Id: 1031
    Name: "波波利"
    JapaneseName: "波波利"
  - Id: 1032
    Name: "木乃伊犬"
    JapaneseName: "木乃伊犬"
  - Id: 1033
    Name: "長老樹精"
    JapaneseName: "長老樹精"
  - Id: 1034
    Name: "達拉蛙"
    JapaneseName: "達拉蛙"
  - Id: 1035
    Name: "赤蒼蠅"
    JapaneseName: "赤蒼蠅"
  - Id: 1036
    Name: "綠腐屍"
    JapaneseName: "綠腐屍"
  - Id: 1037
    Name: "黑蛇"
    JapaneseName: "黑蛇"
  - Id: 1038
    Name: "俄塞里斯"
    JapaneseName: "俄塞里斯"
  - Id: 1039
    Name: "巴風特"
    JapaneseName: "巴風特"
  - Id: 1040
    Name: "巨石怪"
    JapaneseName: "巨石怪"
  - Id: 1041
    Name: "木乃伊"
    JapaneseName: "木乃伊"
  - Id: 1042
    Name: "綠蒼蠅"
    JapaneseName: "綠蒼蠅"
  - Id: 1044
    Name: "人魚"
    JapaneseName: "人魚"
  - Id: 1045
    Name: "馬克"
    JapaneseName: "馬克"
  - Id: 1046
    Name: "死靈"
    JapaneseName: "死靈"
  - Id: 1047
    Name: "大嘴鳥蛋"
    JapaneseName: "大嘴鳥蛋"
  - Id: 1048
    Name: "盜蟲卵"
    JapaneseName: "盜蟲卵"
  - Id: 1049
    Name: "小雞"
    JapaneseName: "小雞"
  - Id: 1050
    Name: "蛋殼小雞"
    JapaneseName: "蛋殼小雞"
  - Id: 1051
    Name: "盜蟲"
    JapaneseName: "盜蟲"
  - Id: 1052
    Name: "搖滾蝗蟲"
    JapaneseName: "搖滾蝗蟲"
  - Id: 1053
    Name: "浮勒盜蟲"
    JapaneseName: "浮勒盜蟲"
  - Id: 1054
    Name: "瑪勒盜蟲"
    JapaneseName: "瑪勒盜蟲"
  - Id: 1055
    Name: "摩卡"
    JapaneseName: "摩卡"
  - Id: 1056
    Name: "狸貓"
    JapaneseName: "狸貓"
  - Id: 1057
    Name: "溜溜猴"
    JapaneseName: "溜溜猴"
  - Id: 1058
    Name: "重金屬蝗蟲"
    JapaneseName: "重金屬蝗蟲"
  - Id: 1059
    Name: "蜂后"
    JapaneseName: "蜂后"
  - Id: 1060
    Name: "大腳熊"
    JapaneseName: "大腳熊"
  - Id: 1061
    Name: "夢魘"
    JapaneseName: "夢魘"
  - Id: 1062
    Name: "聖誕波利"
    JapaneseName: "聖誕波利"
  - Id: 1063
    Name: "瘋兔"
    JapaneseName: "瘋兔"
  - Id: 1064
    Name: "邪骸食人魚"
    JapaneseName: "邪骸食人魚"
  - Id: 1065
    Name: "海神"
    JapaneseName: "海神"
  - Id: 1066
    Name: "螃蟹"
    JapaneseName: "螃蟹"
  - Id: 1067
    Name: "卡那多斯"
    JapaneseName: "卡那多斯"
  - Id: 1068
    Name: "海葵"
    JapaneseName: "海葵"
  - Id: 1069
    Name: "異變魚"
    JapaneseName: "異變魚"
  - Id: 1070
    Name: "庫克雷"
    JapaneseName: "庫克雷"
  - Id: 1071
    Name: "邪骸海盜"
    JapaneseName: "邪骸海盜"
  - Id: 1072
    Name: "卡浩"
    JapaneseName: "卡浩"
  - Id: 1073
    Name: "卡拉蟹"
    JapaneseName: "卡拉蟹"
  - Id: 1074
    Name: "貝殼魔靈"
    JapaneseName: "貝殼魔靈"
  - Id: 1076
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 1077
    Name: "毒魔菇"
    JapaneseName: "毒魔菇"
  - Id: 1078
    Name: "紅草"
    JapaneseName: "紅草"
  - Id: 1079
    Name: "藍草"
    JapaneseName: "藍草"
  - Id: 1080
    Name: "綠草"
    JapaneseName: "綠草"
  - Id: 1081
    Name: "黃草"
    JapaneseName: "黃草"
  - Id: 1082
    Name: "白草"
    JapaneseName: "白草"
  - Id: 1083
    Name: "光芒草"
    JapaneseName: "光芒草"
  - Id: 1084
    Name: "黑菇"
    JapaneseName: "黑菇"
  - Id: 1085
    Name: "紅菇"
    JapaneseName: "紅菇"
  - Id: 1086
    Name: "黃金蟲"
    JapaneseName: "黃金蟲"
  - Id: 1087
    Name: "獸人英雄"
    JapaneseName: "獸人英雄"
  - Id: 1088
    Name: "蝗蟲之王"
    JapaneseName: "蝗蟲之王"
  - Id: 1089
    Name: "蛙王"
    JapaneseName: "蛙王"
  - Id: 1090
    Name: "波利之王"
    JapaneseName: "波利之王"
  - Id: 1091
    Name: "龍蠅"
    JapaneseName: "龍蠅"
  - Id: 1092
    Name: "流浪之狼"
    JapaneseName: "流浪之狼"
  - Id: 1093
    Name: "藍瘋兔"
    JapaneseName: "藍瘋兔"
  - Id: 1094
    Name: "蝸牛"
    JapaneseName: "蝸牛"
  - Id: 1095
    Name: "白蟻"
    JapaneseName: "白蟻"
  - Id: 1096
    Name: "天使波利"
    JapaneseName: "天使波利"
  - Id: 1097
    Name: "白蟻幼蟲"
    JapaneseName: "白蟻幼蟲"
  - Id: 1098
    Name: "胡狼頭神"
    JapaneseName: "胡狼頭神"
  - Id: 1099
    Name: "艾吉歐蜈蚣"
    JapaneseName: "艾吉歐蜈蚣"
  - Id: 1100
    Name: "艾斯蜘蛛"
    JapaneseName: "艾斯蜘蛛"
  - Id: 1101
    Name: "小巴風特"
    JapaneseName: "小巴風特"
  - Id: 1102
    Name: "巫婆"
    JapaneseName: "巫婆"
  - Id: 1103
    Name: "刺蝟蟲"
    JapaneseName: "刺蝟蟲"
  - Id: 1104
    Name: "松鼠"
    JapaneseName: "松鼠"
  - Id: 1105
    Name: "兵蟻"
    JapaneseName: "兵蟻"
  - Id: 1106
    Name: "沙漠之狼"
    JapaneseName: "沙漠之狼"
  - Id: 1107
    Name: "沙漠幼狼"
    JapaneseName: "沙漠幼狼"
  - Id: 1108
    Name: "狄奧斯"
    JapaneseName: "狄奧斯"
  - Id: 1109
    Name: "小惡魔"
    JapaneseName: "小惡魔"
  - Id: 1110
    Name: "土人"
    JapaneseName: "土人"
  - Id: 1111
    Name: "紅蝙蝠"
    JapaneseName: "紅蝙蝠"
  - Id: 1112
    Name: "海盜之王"
    JapaneseName: "海盜之王"
  - Id: 1113
    Name: "土波利"
    JapaneseName: "土波利"
  - Id: 1114
    Name: "獵蠅"
    JapaneseName: "獵蠅"
  - Id: 1115
    Name: "虎王"
    JapaneseName: "虎王"
  - Id: 1116
    Name: "轉轉蛋"
    JapaneseName: "轉轉蛋"
  - Id: 1117
    Name: "闇神官"
    JapaneseName: "闇神官"
  - Id: 1118
    Name: "噬人花"
    JapaneseName: "噬人花"
  - Id: 1119
    Name: "傘蜥"
    JapaneseName: "傘蜥"
  - Id: 1120
    Name: "幽靈波利"
    JapaneseName: "幽靈波利"
  - Id: 1121
    Name: "基爾瑟"
    JapaneseName: "基爾瑟"
  - Id: 1122
    Name: "刺刀哥布靈"
    JapaneseName: "刺刀哥布靈"
  - Id: 1123
    Name: "鏈錘哥布靈"
    JapaneseName: "鏈錘哥布靈"
  - Id: 1124
    Name: "大斧哥布靈"
    JapaneseName: "大斧哥布靈"
  - Id: 1125
    Name: "榔頭哥布靈"
    JapaneseName: "榔頭哥布靈"
  - Id: 1126
    Name: "刺錘哥布靈"
    JapaneseName: "刺錘哥布靈"
  - Id: 1127
    Name: "蚯蚓"
    JapaneseName: "蚯蚓"
  - Id: 1128
    Name: "鍬形蟲"
    JapaneseName: "鍬形蟲"
  - Id: 1129
    Name: "鬼火"
    JapaneseName: "鬼火"
  - Id: 1130
    Name: "南瓜先生"
    JapaneseName: "南瓜先生"
  - Id: 1131
    Name: "裘卡"
    JapaneseName: "裘卡"
  - Id: 1132
    Name: "卡利斯格"
    JapaneseName: "卡利斯格"
  - Id: 1133
    Name: "大斧犬妖"
    JapaneseName: "大斧犬妖"
  - Id: 1134
    Name: "榔頭犬妖"
    JapaneseName: "榔頭犬妖"
  - Id: 1135
    Name: "刺錘犬妖"
    JapaneseName: "刺錘犬妖"
  - Id: 1136
    Name: "犬妖"
    JapaneseName: "犬妖"
  - Id: 1137
    Name: "犬妖"
    JapaneseName: "犬妖"
  - Id: 1138
    Name: "魔鍋蛋"
    JapaneseName: "魔鍋蛋"
  - Id: 1139
    Name: "螳螂"
    JapaneseName: "螳螂"
  - Id: 1140
    Name: "馬爾杜克"
    JapaneseName: "馬爾杜克"
  - Id: 1141
    Name: "水母"
    JapaneseName: "水母"
  - Id: 1142
    Name: "氣泡蟲"
    JapaneseName: "氣泡蟲"
  - Id: 1143
    Name: "傀儡娃娃"
    JapaneseName: "傀儡娃娃"
  - Id: 1144
    Name: "烏賊"
    JapaneseName: "烏賊"
  - Id: 1145
    Name: "土撥鼠"
    JapaneseName: "土撥鼠"
  - Id: 1146
    Name: "黑狐"
    JapaneseName: "黑狐"
  - Id: 1147
    Name: "蟻后"
    JapaneseName: "蟻后"
  - Id: 1148
    Name: "米杜沙"
    JapaneseName: "米杜沙"
  - Id: 1149
    Name: "米洛斯"
    JapaneseName: "米洛斯"
  - Id: 1150
    Name: "月夜貓"
    JapaneseName: "月夜貓"
  - Id: 1151
    Name: "麥斯特"
    JapaneseName: "麥斯特"
  - Id: 1152
    Name: "邪骸獸人"
    JapaneseName: "邪骸獸人"
  - Id: 1153
    Name: "獸人腐屍"
    JapaneseName: "獸人腐屍"
  - Id: 1154
    Name: "帕莎納"
    JapaneseName: "帕莎納"
  - Id: 1155
    Name: "畢帝特地龍"
    JapaneseName: "畢帝特地龍"
  - Id: 1156
    Name: "畢帝特飛龍"
    JapaneseName: "畢帝特飛龍"
  - Id: 1157
    Name: "法老王"
    JapaneseName: "法老王"
  - Id: 1158
    Name: "劍魚"
    JapaneseName: "劍魚"
  - Id: 1159
    Name: "皮里恩"
    JapaneseName: "皮里恩"
  - Id: 1160
    Name: "工蟻"
    JapaneseName: "工蟻"
  - Id: 1161
    Name: "漂浮蟲"
    JapaneseName: "漂浮蟲"
  - Id: 1162
    Name: "草精"
    JapaneseName: "草精"
  - Id: 1163
    Name: "幽靈劍士"
    JapaneseName: "幽靈劍士"
  - Id: 1164
    Name: "諾可伊"
    JapaneseName: "諾可伊"
  - Id: 1165
    Name: "泥人"
    JapaneseName: "泥人"
  - Id: 1166
    Name: "野豬"
    JapaneseName: "野豬"
  - Id: 1167
    Name: "小野豬"
    JapaneseName: "小野豬"
  - Id: 1169
    Name: "邪骸礦工"
    JapaneseName: "邪骸礦工"
  - Id: 1170
    Name: "鬼女"
    JapaneseName: "鬼女"
  - Id: 1174
    Name: "瓢蟲"
    JapaneseName: "瓢蟲"
  - Id: 1175
    Name: "白鼠"
    JapaneseName: "白鼠"
  - Id: 1176
    Name: "黑蟻"
    JapaneseName: "黑蟻"
  - Id: 1177
    Name: "茲諾克"
    JapaneseName: "茲諾克"
  - Id: 1178
    Name: "傑洛米"
    JapaneseName: "傑洛米"
  - Id: 1179
    Name: "白幽靈"
    JapaneseName: "白幽靈"
  - Id: 1180
    Name: "九尾狐"
    JapaneseName: "九尾狐"
  - Id: 1182
    Name: "香菇"
    JapaneseName: "香菇"
  - Id: 1183
    Name: "蒼蠅"
    JapaneseName: "蒼蠅"
  - Id: 1184
    Name: "綠棉蟲"
    JapaneseName: "綠棉蟲"
  - Id: 1185
    Name: "白幽靈"
    JapaneseName: "白幽靈"
  - Id: 1186
    Name: "巨大白幽靈"
    JapaneseName: "巨大白幽靈"
  - Id: 1188
    Name: "妖道"
    JapaneseName: "妖道"
  - Id: 1189
    Name: "獸人弓箭手"
    JapaneseName: "獸人弓箭手"
  - Id: 1190
    Name: "獸人酋長"
    JapaneseName: "獸人酋長"
  - Id: 1191
    Name: "邪惡箱"
    JapaneseName: "邪惡箱"
  - Id: 1192
    Name: "惡靈"
    JapaneseName: "惡靈"
  - Id: 1193
    Name: "鐘怪"
    JapaneseName: "鐘怪"
  - Id: 1194
    Name: "捲甲蟲"
    JapaneseName: "捲甲蟲"
  - Id: 1195
    Name: "飛行魔書"
    JapaneseName: "飛行魔書"
  - Id: 1196
    Name: "邪骸戰俘"
    JapaneseName: "邪骸戰俘"
  - Id: 1197
    Name: "腐屍戰俘"
    JapaneseName: "腐屍戰俘"
  - Id: 1198
    Name: "暗黑祭司"
    JapaneseName: "暗黑祭司"
  - Id: 1199
    Name: "朽魔"
    JapaneseName: "朽魔"
  - Id: 1200
    Name: "艾斯恩魔女"
    JapaneseName: "艾斯恩魔女"
  - Id: 1201
    Name: "瑞比歐"
    JapaneseName: "瑞比歐"
  - Id: 1202
    Name: "阿修羅狂戰士"
    JapaneseName: "阿修羅狂戰士"
  - Id: 1203
    Name: "弒神者"
    JapaneseName: "弒神者"
  - Id: 1204
    Name: "獸牙怪"
    JapaneseName: "獸牙怪"
  - Id: 1205
    Name: "行刑者"
    JapaneseName: "行刑者"
  - Id: 1206
    Name: "虎蜥人"
    JapaneseName: "虎蜥人"
  - Id: 1207
    Name: "史汀"
    JapaneseName: "史汀"
  - Id: 1208
    Name: "邪骸浪人"
    JapaneseName: "邪骸浪人"
  - Id: 1209
    Name: "藍鼠"
    JapaneseName: "藍鼠"
  - Id: 1210
    Name: "曼斯鍬形蟲"
    JapaneseName: "曼斯鍬形蟲"
  - Id: 1211
    Name: "伊特瓢蟲"
    JapaneseName: "伊特瓢蟲"
  - Id: 1212
    Name: "鐵蠍"
    JapaneseName: "鐵蠍"
  - Id: 1213
    Name: "獸人戰士長"
    JapaneseName: "獸人戰士長"
  - Id: 1214
    Name: "巧克猴"
    JapaneseName: "巧克猴"
  - Id: 1215
    Name: "灰森靈"
    JapaneseName: "灰森靈"
  - Id: 1216
    Name: "梅納海葵"
    JapaneseName: "梅納海葵"
  - Id: 1219
    Name: "深淵騎士"
    JapaneseName: "深淵騎士"
  - Id: 1220
    Name: "沙漠之狼"
    JapaneseName: "沙漠之狼"
  - Id: 1221
    Name: "野豬"
    JapaneseName: "野豬"
  - Id: 1229
    Name: "綠棉蟲"
    JapaneseName: "綠棉蟲"
  - Id: 1230
    Name: "蟲蛹"
    JapaneseName: "蟲蛹"
  - Id: 1231
    Name: "克瑞米"
    JapaneseName: "克瑞米"
  - Id: 1232
    Name: "大嘴鳥蛋"
    JapaneseName: "大嘴鳥蛋"
  - Id: 1234
    Name: "溜溜猴"
    JapaneseName: "溜溜猴"
  - Id: 1235
    Name: "吸菸的獸人戰士"
    JapaneseName: "吸菸的獸人戰士"
  - Id: 1236
    Name: "螞蟻卵"
    JapaneseName: "螞蟻卵"
  - Id: 1237
    Name: "白蟻"
    JapaneseName: "白蟻"
  - Id: 1238
    Name: "工蟻"
    JapaneseName: "工蟻"
  - Id: 1239
    Name: "兵蟻"
    JapaneseName: "兵蟻"
  - Id: 1240
    Name: "小雞"
    JapaneseName: "小雞"
  - Id: 1241
    Name: "蛋殼小雞"
    JapaneseName: "蛋殼小雞"
  - Id: 1242
    Name: "冰波利"
    JapaneseName: "冰波利"
  - Id: 1243
    Name: "雪熊"
    JapaneseName: "雪熊"
  - Id: 1244
    Name: "聖誕南瓜先生"
    JapaneseName: "聖誕南瓜先生"
  - Id: 1245
    Name: "聖誕哥布靈"
    JapaneseName: "聖誕哥布靈"
  - Id: 1246
    Name: "甜餅人"
    JapaneseName: "甜餅人"
  - Id: 1247
    Name: "邪惡老公公"
    JapaneseName: "邪惡老公公"
  - Id: 1248
    Name: "玩具士兵"
    JapaneseName: "玩具士兵"
  - Id: 1249
    Name: "邪惡禮盒"
    JapaneseName: "邪惡禮盒"
  - Id: 1250
    Name: "魔靈娃娃"
    JapaneseName: "魔靈娃娃"
  - Id: 1251
    Name: "冰暴騎士"
    JapaneseName: "冰暴騎士"
  - Id: 1252
    Name: "卡崙"
    JapaneseName: "卡崙"
  - Id: 1253
    Name: "蝙蝠弓箭手"
    JapaneseName: "蝙蝠弓箭手"
  - Id: 1254
    Name: "奈吉鳥"
    JapaneseName: "奈吉鳥"
  - Id: 1255
    Name: "奈利蟲"
    JapaneseName: "奈利蟲"
  - Id: 1256
    Name: "單眼蟲"
    JapaneseName: "單眼蟲"
  - Id: 1257
    Name: "邪惡使者"
    JapaneseName: "邪惡使者"
  - Id: 1258
    Name: "弓箭哥布靈"
    JapaneseName: "弓箭哥布靈"
  - Id: 1259
    Name: "獅鷲獸"
    JapaneseName: "獅鷲獸"
  - Id: 1260
    Name: "鏡妖"
    JapaneseName: "鏡妖"
  - Id: 1261
    Name: "狂暴野貓"
    JapaneseName: "狂暴野貓"
  - Id: 1262
    Name: "半龍人"
    JapaneseName: "半龍人"
  - Id: 1263
    Name: "風魔巫師"
    JapaneseName: "風魔巫師"
  - Id: 1264
    Name: "人魚士兵"
    JapaneseName: "人魚士兵"
  - Id: 1265
    Name: "綠餅人"
    JapaneseName: "綠餅人"
  - Id: 1266
    Name: "海星"
    JapaneseName: "海星"
  - Id: 1267
    Name: "卡拉特小丑"
    JapaneseName: "卡拉特小丑"
  - Id: 1268
    Name: "血腥騎士"
    JapaneseName: "血腥騎士"
  - Id: 1269
    Name: "古鐘魔"
    JapaneseName: "古鐘魔"
  - Id: 1270
    Name: "鐘塔守護者"
    JapaneseName: "鐘塔守護者"
  - Id: 1271
    Name: "鱷魚人"
    JapaneseName: "鱷魚人"
  - Id: 1272
    Name: "黑暗之王"
    JapaneseName: "黑暗之王"
  - Id: 1273
    Name: "獸人女戰士"
    JapaneseName: "獸人女戰士"
  - Id: 1274
    Name: "邪惡摩艾"
    JapaneseName: "邪惡摩艾"
  - Id: 1275
    Name: "愛麗絲女僕"
    JapaneseName: "愛麗絲女僕"
  - Id: 1276
    Name: "幽靈弓箭手"
    JapaneseName: "幽靈弓箭手"
  - Id: 1277
    Name: "將軍魔碑"
    JapaneseName: "將軍魔碑"
  - Id: 1278
    Name: "鐘乳巨石怪"
    JapaneseName: "鐘乳巨石怪"
  - Id: 1279
    Name: "三葉蟲"
    JapaneseName: "三葉蟲"
  - Id: 1280
    Name: "噴射哥布靈"
    JapaneseName: "噴射哥布靈"
  - Id: 1281
    Name: "賢者蟲"
    JapaneseName: "賢者蟲"
  - Id: 1282
    Name: "犬妖弓箭手"
    JapaneseName: "犬妖弓箭手"
  - Id: 1283
    Name: "凱美拉"
    JapaneseName: "凱美拉"
  - Id: 1285
    Name: "弓手監護人"
    JapaneseName: "弓手監護人"
  - Id: 1286
    Name: "騎士監護人"
    JapaneseName: "騎士監護人"
  - Id: 1287
    Name: "士兵監護人"
    JapaneseName: "士兵監護人"
  - Id: 1288
    Name: "EMPELIUM"
    JapaneseName: "EMPELIUM"
  - Id: 1289
    Name: "狂暴蟻后"
    JapaneseName: "狂暴蟻后"
  - Id: 1290
    Name: "邪骸戰士長"
    JapaneseName: "邪骸戰士長"
  - Id: 1291
    Name: "狂暴惡靈"
    JapaneseName: "狂暴惡靈"
  - Id: 1292
    Name: "狂暴小惡魔"
    JapaneseName: "狂暴小惡魔"
  - Id: 1293
    Name: "狂暴克瑞米"
    JapaneseName: "狂暴克瑞米"
  - Id: 1294
    Name: "狂暴螳螂"
    JapaneseName: "狂暴螳螂"
  - Id: 1295
    Name: "鴞裊男爵"
    JapaneseName: "鴞裊男爵"
  - Id: 1296
    Name: "犬妖首領"
    JapaneseName: "犬妖首領"
  - Id: 1297
    Name: "狂暴木乃伊"
    JapaneseName: "狂暴木乃伊"
  - Id: 1298
    Name: "腐屍首領"
    JapaneseName: "腐屍首領"
  - Id: 1299
    Name: "哥布靈首領"
    JapaneseName: "哥布靈首領"
  - Id: 1300
    Name: "狂暴綠棉蟲"
    JapaneseName: "狂暴綠棉蟲"
  - Id: 1301
    Name: "狂暴小土人"
    JapaneseName: "狂暴小土人"
  - Id: 1302
    Name: "迷幻之王"
    JapaneseName: "迷幻之王"
  - Id: 1303
    Name: "狂暴蜂兵"
    JapaneseName: "狂暴蜂兵"
  - Id: 1304
    Name: "狂暴蜘蛛"
    JapaneseName: "狂暴蜘蛛"
  - Id: 1305
    Name: "狂暴蜈蚣"
    JapaneseName: "狂暴蜈蚣"
  - Id: 1306
    Name: "狂暴大腳熊"
    JapaneseName: "狂暴大腳熊"
  - Id: 1307
    Name: "狂暴月夜貓"
    JapaneseName: "狂暴月夜貓"
  - Id: 1308
    Name: "狂暴哥布靈"
    JapaneseName: "狂暴哥布靈"
  - Id: 1309
    Name: "狂暴鬼火"
    JapaneseName: "狂暴鬼火"
  - Id: 1310
    Name: "狂暴米洛斯"
    JapaneseName: "狂暴米洛斯"
  - Id: 1311
    Name: "狂暴野豬"
    JapaneseName: "狂暴野豬"
  - Id: 1312
    Name: "烏龜將軍"
    JapaneseName: "烏龜將軍"
  - Id: 1313
    Name: "流氓"
    JapaneseName: "流氓"
  - Id: 1314
    Name: "果樹龜"
    JapaneseName: "果樹龜"
  - Id: 1315
    Name: "風靈龜"
    JapaneseName: "風靈龜"
  - Id: 1316
    Name: "岩石龜"
    JapaneseName: "岩石龜"
  - Id: 1317
    Name: "海豹寶寶"
    JapaneseName: "海豹寶寶"
  - Id: 1318
    Name: "火焰龜"
    JapaneseName: "火焰龜"
  - Id: 1319
    Name: "水靈龜"
    JapaneseName: "水靈龜"
  - Id: 1320
    Name: "鴞裊首領"
    JapaneseName: "鴞裊首領"
  - Id: 1321
    Name: "刺尾蜻蜓"
    JapaneseName: "刺尾蜻蜓"
  - Id: 1322
    Name: "彈簧兔"
    JapaneseName: "彈簧兔"
  - Id: 1323
    Name: "海獺"
    JapaneseName: "海獺"
  - Id: 1324
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1325
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1326
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1327
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1328
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1329
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1330
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1331
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1332
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1333
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1334
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1335
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1336
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1337
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1338
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1339
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1340
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1341
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1342
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1343
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1344
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1345
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1346
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1347
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1348
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1349
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1350
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1351
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1352
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1353
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1354
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1355
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1356
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1357
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1358
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1359
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1360
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1361
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1362
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1363
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1364
    Name: "風靈龜"
    JapaneseName: "風靈龜"
  - Id: 1365
    Name: "阿修羅機械戰士"
    JapaneseName: "阿修羅機械戰士"
  - Id: 1366
    Name: "熔岩巨石"
    JapaneseName: "熔岩巨石"
  - Id: 1367
    Name: "火焰妖"
    JapaneseName: "火焰妖"
  - Id: 1368
    Name: "邪惡向日葵"
    JapaneseName: "邪惡向日葵"
  - Id: 1369
    Name: "七彩大嘴鳥"
    JapaneseName: "七彩大嘴鳥"
  - Id: 1370
    Name: "惡魔女僕"
    JapaneseName: "惡魔女僕"
  - Id: 1371
    Name: "偽天使"
    JapaneseName: "偽天使"
  - Id: 1372
    Name: "魔羌"
    JapaneseName: "魔羌"
  - Id: 1373
    Name: "死靈騎士"
    JapaneseName: "死靈騎士"
  - Id: 1374
    Name: "惡魔侍者"
    JapaneseName: "惡魔侍者"
  - Id: 1375
    Name: "紙妖"
    JapaneseName: "紙妖"
  - Id: 1376
    Name: "鳥人哈比"
    JapaneseName: "鳥人哈比"
  - Id: 1377
    Name: "邪靈魔導士"
    JapaneseName: "邪靈魔導士"
  - Id: 1378
    Name: "天邪鬼"
    JapaneseName: "天邪鬼"
  - Id: 1379
    Name: "七彩夢魘"
    JapaneseName: "七彩夢魘"
  - Id: 1380
    Name: "爆鑽傘蜥"
    JapaneseName: "爆鑽傘蜥"
  - Id: 1381
    Name: "暴燄野熊"
    JapaneseName: "暴燄野熊"
  - Id: 1382
    Name: "赤焰小惡魔"
    JapaneseName: "赤焰小惡魔"
  - Id: 1383
    Name: "爆炎蝙蝠"
    JapaneseName: "爆炎蝙蝠"
  - Id: 1384
    Name: "七彩飛龍"
    JapaneseName: "七彩飛龍"
  - Id: 1385
    Name: "七彩地龍"
    JapaneseName: "七彩地龍"
  - Id: 1386
    Name: "沙妖"
    JapaneseName: "沙妖"
  - Id: 1387
    Name: "沙漠毒蠍"
    JapaneseName: "沙漠毒蠍"
  - Id: 1388
    Name: "聖天使波利"
    JapaneseName: "聖天使波利"
  - Id: 1389
    Name: "德古拉男爵"
    JapaneseName: "德古拉男爵"
  - Id: 1390
    Name: "薇歐莉"
    JapaneseName: "薇歐莉"
  - Id: 1391
    Name: "啤酒企鵝"
    JapaneseName: "啤酒企鵝"
  - Id: 1392
    Name: "直升機哥布靈"
    JapaneseName: "直升機哥布靈"
  - Id: 1393
    Name: "木乃伊"
    JapaneseName: "木乃伊"
  - Id: 1394
    Name: "腐尸"
    JapaneseName: "腐尸"
  - Id: 1395
    Name: "風元素"
    JapaneseName: "風元素"
  - Id: 1396
    Name: "土元素"
    JapaneseName: "土元素"
  - Id: 1397
    Name: "火元素"
    JapaneseName: "火元素"
  - Id: 1398
    Name: "水元素"
    JapaneseName: "水元素"
  - Id: 1399
    Name: "巴風特"
    JapaneseName: "巴風特"
  - Id: 1400
    Name: "傘妖"
    JapaneseName: "傘妖"
  - Id: 1401
    Name: "火忍西怒畢"
    JapaneseName: "火忍西怒畢"
  - Id: 1402
    Name: "牛蛙"
    JapaneseName: "牛蛙"
  - Id: 1403
    Name: "武士火槍兵"
    JapaneseName: "武士火槍兵"
  - Id: 1404
    Name: "米雅畢"
    JapaneseName: "米雅畢"
  - Id: 1405
    Name: "天狗"
    JapaneseName: "天狗"
  - Id: 1406
    Name: "釣魚河童"
    JapaneseName: "釣魚河童"
  - Id: 1408
    Name: "血蝴蝶"
    JapaneseName: "血蝴蝶"
  - Id: 1409
    Name: "元宵童子"
    JapaneseName: "元宵童子"
  - Id: 1410
    Name: "猴桃木"
    JapaneseName: "猴桃木"
  - Id: 1412
    Name: "惡雲仙人"
    JapaneseName: "惡雲仙人"
  - Id: 1413
    Name: "人蔘精"
    JapaneseName: "人蔘精"
  - Id: 1415
    Name: "小花豹"
    JapaneseName: "小花豹"
  - Id: 1416
    Name: "妖仙女"
    JapaneseName: "妖仙女"
  - Id: 1417
    Name: "拉鏈熊"
    JapaneseName: "拉鏈熊"
  - Id: 1418
    Name: "墨蛇君"
    JapaneseName: "墨蛇君"
  - Id: 1419
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 1420
    Name: "邪骸弓箭手"
    JapaneseName: "邪骸弓箭手"
  - Id: 1421
    Name: "蛇女伊斯"
    JapaneseName: "蛇女伊斯"
  - Id: 1422
    Name: "赤蒼蠅"
    JapaneseName: "赤蒼蠅"
  - Id: 1423
    Name: "綠腐尸"
    JapaneseName: "綠腐尸"
  - Id: 1424
    Name: "黑蛇"
    JapaneseName: "黑蛇"
  - Id: 1425
    Name: "人魚"
    JapaneseName: "人魚"
  - Id: 1426
    Name: "馬克"
    JapaneseName: "馬克"
  - Id: 1427
    Name: "夢魘"
    JapaneseName: "夢魘"
  - Id: 1428
    Name: "毒魔菇"
    JapaneseName: "毒魔菇"
  - Id: 1429
    Name: "艾吉歐蜈蚣"
    JapaneseName: "艾吉歐蜈蚣"
  - Id: 1430
    Name: "艾斯蜘蛛"
    JapaneseName: "艾斯蜘蛛"
  - Id: 1431
    Name: "小巴風特"
    JapaneseName: "小巴風特"
  - Id: 1432
    Name: "沙漠之狼"
    JapaneseName: "沙漠之狼"
  - Id: 1433
    Name: "小惡魔"
    JapaneseName: "小惡魔"
  - Id: 1434
    Name: "紅蝙蝠"
    JapaneseName: "紅蝙蝠"
  - Id: 1435
    Name: "暗神官"
    JapaneseName: "暗神官"
  - Id: 1436
    Name: "南瓜先生"
    JapaneseName: "南瓜先生"
  - Id: 1437
    Name: "裘卡"
    JapaneseName: "裘卡"
  - Id: 1438
    Name: "卡利斯格"
    JapaneseName: "卡利斯格"
  - Id: 1439
    Name: "獸人戰士長"
    JapaneseName: "獸人戰士長"
  - Id: 1440
    Name: "灰森靈"
    JapaneseName: "灰森靈"
  - Id: 1441
    Name: "梅納海葵"
    JapaneseName: "梅納海葵"
  - Id: 1442
    Name: "雪熊"
    JapaneseName: "雪熊"
  - Id: 1443
    Name: "玩具士兵"
    JapaneseName: "玩具士兵"
  - Id: 1444
    Name: "魔靈娃娃"
    JapaneseName: "魔靈娃娃"
  - Id: 1445
    Name: "奈吉鳥"
    JapaneseName: "奈吉鳥"
  - Id: 1446
    Name: "邪惡使者"
    JapaneseName: "邪惡使者"
  - Id: 1447
    Name: "獅鷲獸"
    JapaneseName: "獅鷲獸"
  - Id: 1448
    Name: "鏡妖"
    JapaneseName: "鏡妖"
  - Id: 1449
    Name: "半龍人"
    JapaneseName: "半龍人"
  - Id: 1450
    Name: "風魔巫師"
    JapaneseName: "風魔巫師"
  - Id: 1451
    Name: "人魚士兵"
    JapaneseName: "人魚士兵"
  - Id: 1452
    Name: "獸人女戰士"
    JapaneseName: "獸人女戰士"
  - Id: 1453
    Name: "幽靈弓箭手"
    JapaneseName: "幽靈弓箭手"
  - Id: 1454
    Name: "三葉蟲"
    JapaneseName: "三葉蟲"
  - Id: 1455
    Name: "犬妖弓箭手"
    JapaneseName: "犬妖弓箭手"
  - Id: 1456
    Name: "凱美拉"
    JapaneseName: "凱美拉"
  - Id: 1457
    Name: "螳螂"
    JapaneseName: "螳螂"
  - Id: 1458
    Name: "馬爾杜克"
    JapaneseName: "馬爾杜克"
  - Id: 1459
    Name: "傀儡娃娃"
    JapaneseName: "傀儡娃娃"
  - Id: 1460
    Name: "黑狐"
    JapaneseName: "黑狐"
  - Id: 1461
    Name: "米諾斯"
    JapaneseName: "米諾斯"
  - Id: 1462
    Name: "邪骸獸人"
    JapaneseName: "邪骸獸人"
  - Id: 1463
    Name: "獸人腐尸"
    JapaneseName: "獸人腐尸"
  - Id: 1464
    Name: "帕莎納"
    JapaneseName: "帕莎納"
  - Id: 1465
    Name: "畢帝特地龍"
    JapaneseName: "畢帝特地龍"
  - Id: 1466
    Name: "畢帝特飛龍"
    JapaneseName: "畢帝特飛龍"
  - Id: 1467
    Name: "幽靈劍士"
    JapaneseName: "幽靈劍士"
  - Id: 1468
    Name: "諾可伊"
    JapaneseName: "諾可伊"
  - Id: 1469
    Name: "邪骸礦工"
    JapaneseName: "邪骸礦工"
  - Id: 1470
    Name: "杰洛米"
    JapaneseName: "杰洛米"
  - Id: 1471
    Name: "九尾狐"
    JapaneseName: "九尾狐"
  - Id: 1472
    Name: "妖道"
    JapaneseName: "妖道"
  - Id: 1473
    Name: "獸人弓箭手"
    JapaneseName: "獸人弓箭手"
  - Id: 1474
    Name: "邪惡箱"
    JapaneseName: "邪惡箱"
  - Id: 1475
    Name: "惡靈"
    JapaneseName: "惡靈"
  - Id: 1476
    Name: "鐘怪"
    JapaneseName: "鐘怪"
  - Id: 1477
    Name: "卷甲蟲"
    JapaneseName: "卷甲蟲"
  - Id: 1478
    Name: "飛行魔書"
    JapaneseName: "飛行魔書"
  - Id: 1479
    Name: "邪骸戰俘"
    JapaneseName: "邪骸戰俘"
  - Id: 1480
    Name: "腐尸戰俘"
    JapaneseName: "腐尸戰俘"
  - Id: 1481
    Name: "朽魔"
    JapaneseName: "朽魔"
  - Id: 1482
    Name: "艾斯恩魔女"
    JapaneseName: "艾斯恩魔女"
  - Id: 1483
    Name: "瑞比歐"
    JapaneseName: "瑞比歐"
  - Id: 1484
    Name: "阿修羅狂戰士"
    JapaneseName: "阿修羅狂戰士"
  - Id: 1485
    Name: "弒神者"
    JapaneseName: "弒神者"
  - Id: 1486
    Name: "獸牙怪"
    JapaneseName: "獸牙怪"
  - Id: 1487
    Name: "行刑者"
    JapaneseName: "行刑者"
  - Id: 1488
    Name: "虎蜥人"
    JapaneseName: "虎蜥人"
  - Id: 1489
    Name: "史汀"
    JapaneseName: "史汀"
  - Id: 1490
    Name: "邪骸浪人"
    JapaneseName: "邪骸浪人"
  - Id: 1491
    Name: "土人"
    JapaneseName: "土人"
  - Id: 1492
    Name: "元靈武士"
    JapaneseName: "元靈武士"
  - Id: 1493
    Name: "森林妖姬"
    JapaneseName: "森林妖姬"
  - Id: 1494
    Name: "巨象甲蟲"
    JapaneseName: "巨象甲蟲"
  - Id: 1495
    Name: "石炮火樹"
    JapaneseName: "石炮火樹"
  - Id: 1497
    Name: "機木人"
    JapaneseName: "機木人"
  - Id: 1498
    Name: "伍坦彈弓手"
    JapaneseName: "伍坦彈弓手"
  - Id: 1499
    Name: "伍坦戰士"
    JapaneseName: "伍坦戰士"
  - Id: 1500
    Name: "苗娃佩瑞絲"
    JapaneseName: "苗娃佩瑞絲"
  - Id: 1502
    Name: "魔王波利"
    JapaneseName: "魔王波利"
  - Id: 1503
    Name: "鬼娃樹"
    JapaneseName: "鬼娃樹"
  - Id: 1504
    Name: "無顱武士"
    JapaneseName: "無顱武士"
  - Id: 1505
    Name: "銀月魔女"
    JapaneseName: "銀月魔女"
  - Id: 1506
    Name: "假面鬼"
    JapaneseName: "假面鬼"
  - Id: 1507
    Name: "嗜血怪人"
    JapaneseName: "嗜血怪人"
  - Id: 1508
    Name: "萬聖魔"
    JapaneseName: "萬聖魔"
  - Id: 1509
    Name: "南瓜魂"
    JapaneseName: "南瓜魂"
  - Id: 1510
    Name: "兔斯拉"
    JapaneseName: "兔斯拉"
  - Id: 1511
    Name: "古埃及王"
    JapaneseName: "古埃及王"
  - Id: 1512
    Name: "妖君"
    JapaneseName: "妖君"
  - Id: 1513
    Name: "狐仙"
    JapaneseName: "狐仙"
  - Id: 1514
    Name: "舞獅"
    JapaneseName: "舞獅"
  - Id: 1515
    Name: "卡崙寶寶"
    JapaneseName: "卡崙寶寶"
  - Id: 1516
    Name: "米糕"
    JapaneseName: "米糕"
  - Id: 1517
    Name: "豹皮怪"
    JapaneseName: "豹皮怪"
  - Id: 1518
    Name: "白素貞"
    JapaneseName: "白素貞"
  - Id: 1519
    Name: "小青"
    JapaneseName: "小青"
  - Id: 1520
    Name: "肉粽怪"
    JapaneseName: "肉粽怪"
  - Id: 1521
    Name: "愛麗絲女僕"
    JapaneseName: "愛麗絲女僕"
  - Id: 1522
    Name: "狂暴木乃伊"
    JapaneseName: "狂暴木乃伊"
  - Id: 1523
    Name: "武士火槍兵"
    JapaneseName: "武士火槍兵"
  - Id: 1524
    Name: "小花豹"
    JapaneseName: "小花豹"
  - Id: 1525
    Name: "巫婆"
    JapaneseName: "巫婆"
  - Id: 1526
    Name: "血蝴蝶"
    JapaneseName: "血蝴蝶"
  - Id: 1527
    Name: "鐘塔守護者"
    JapaneseName: "鐘塔守護者"
  - Id: 1528
    Name: "古鐘魔"
    JapaneseName: "古鐘魔"
  - Id: 1529
    Name: "墨蛇君"
    JapaneseName: "墨蛇君"
  - Id: 1530
    Name: "德古拉男爵"
    JapaneseName: "德古拉男爵"
  - Id: 1531
    Name: "惡雲仙人"
    JapaneseName: "惡雲仙人"
  - Id: 1532
    Name: "爆炎蝙蝠"
    JapaneseName: "爆炎蝙蝠"
  - Id: 1533
    Name: "海豹寶寶"
    JapaneseName: "海豹寶寶"
  - Id: 1534
    Name: "刺刀哥布靈"
    JapaneseName: "刺刀哥布靈"
  - Id: 1535
    Name: "鏈錘哥布靈"
    JapaneseName: "鏈錘哥布靈"
  - Id: 1536
    Name: "大斧哥布靈"
    JapaneseName: "大斧哥布靈"
  - Id: 1537
    Name: "榔頭哥布靈"
    JapaneseName: "榔頭哥布靈"
  - Id: 1538
    Name: "刺錘哥布靈"
    JapaneseName: "刺錘哥布靈"
  - Id: 1539
    Name: "哥布靈首領"
    JapaneseName: "哥布靈首領"
  - Id: 1540
    Name: "巨石怪"
    JapaneseName: "巨石怪"
  - Id: 1541
    Name: "將軍魔碑"
    JapaneseName: "將軍魔碑"
  - Id: 1542
    Name: "元靈武士"
    JapaneseName: "元靈武士"
  - Id: 1543
    Name: "釣魚河童"
    JapaneseName: "釣魚河童"
  - Id: 1544
    Name: "傘妖"
    JapaneseName: "傘妖"
  - Id: 1545
    Name: "大斧犬妖"
    JapaneseName: "大斧犬妖"
  - Id: 1546
    Name: "榔頭犬妖"
    JapaneseName: "榔頭犬妖"
  - Id: 1547
    Name: "刺錘犬妖"
    JapaneseName: "刺錘犬妖"
  - Id: 1548
    Name: "犬妖首領"
    JapaneseName: "犬妖首領"
  - Id: 1549
    Name: "熔岩巨石"
    JapaneseName: "熔岩巨石"
  - Id: 1550
    Name: "猴桃木"
    JapaneseName: "猴桃木"
  - Id: 1551
    Name: "烏賊"
    JapaneseName: "烏賊"
  - Id: 1552
    Name: "米雅畢"
    JapaneseName: "米雅畢"
  - Id: 1553
    Name: "麥斯特"
    JapaneseName: "麥斯特"
  - Id: 1554
    Name: "七彩夢魘"
    JapaneseName: "七彩夢魘"
  - Id: 1555
    Name: "苗娃佩瑞絲"
    JapaneseName: "苗娃佩瑞絲"
  - Id: 1556
    Name: "牛蛙"
    JapaneseName: "牛蛙"
  - Id: 1557
    Name: "直升機哥布靈"
    JapaneseName: "直升機哥布靈"
  - Id: 1558
    Name: "泥人"
    JapaneseName: "泥人"
  - Id: 1559
    Name: "蝎子"
    JapaneseName: "蝎子"
  - Id: 1560
    Name: "火忍西怒畢"
    JapaneseName: "火忍西怒畢"
  - Id: 1561
    Name: "貍貓"
    JapaneseName: "貍貓"
  - Id: 1562
    Name: "邪骸士兵"
    JapaneseName: "邪骸士兵"
  - Id: 1563
    Name: "天狗"
    JapaneseName: "天狗"
  - Id: 1564
    Name: "妖仙女"
    JapaneseName: "妖仙女"
  - Id: 1565
    Name: "人參精"
    JapaneseName: "人參精"
  - Id: 1566
    Name: "狂暴惡靈"
    JapaneseName: "狂暴惡靈"
  - Id: 1567
    Name: "狂暴蜈蚣"
    JapaneseName: "狂暴蜈蚣"
  - Id: 1568
    Name: "天使波利"
    JapaneseName: "天使波利"
  - Id: 1569
    Name: "血腥騎士"
    JapaneseName: "血腥騎士"
  - Id: 1570
    Name: "藍鼠"
    JapaneseName: "藍鼠"
  - Id: 1571
    Name: "狄奧斯"
    JapaneseName: "狄奧斯"
  - Id: 1572
    Name: "土波利"
    JapaneseName: "土波利"
  - Id: 1573
    Name: "邪靈魔導士"
    JapaneseName: "邪靈魔導士"
  - Id: 1574
    Name: "長老樹精"
    JapaneseName: "長老樹精"
  - Id: 1575
    Name: "噬人花"
    JapaneseName: "噬人花"
  - Id: 1576
    Name: "幽靈波利"
    JapaneseName: "幽靈波利"
  - Id: 1577
    Name: "弓箭哥布靈"
    JapaneseName: "弓箭哥布靈"
  - Id: 1578
    Name: "鬼火"
    JapaneseName: "鬼火"
  - Id: 1579
    Name: "海葵"
    JapaneseName: "海葵"
  - Id: 1580
    Name: "惡魔侍者"
    JapaneseName: "惡魔侍者"
  - Id: 1581
    Name: "搖滾蝗蟲"
    JapaneseName: "搖滾蝗蟲"
  - Id: 1582
    Name: "惡魔波利"
    JapaneseName: "惡魔波利"
  - Id: 1583
    Name: "塔奧群卡"
    JapaneseName: "塔奧群卡"
  - Id: 1584
    Name: "塔嚕安"
    JapaneseName: "塔嚕安"
  - Id: 1585
    Name: "啞劇猴"
    JapaneseName: "啞劇猴"
  - Id: 1586
    Name: "群葉貓"
    JapaneseName: "群葉貓"
  - Id: 1587
    Name: "克萊本"
    JapaneseName: "克萊本"
  - Id: 1588
    Name: "聖誕獸人戰士"
    JapaneseName: "聖誕獸人戰士"
  - Id: 1589
    Name: "曼陀羅魔花"
    JapaneseName: "曼陀羅魔花"
  - Id: 1590
    Name: "邪惡向日葵"
    JapaneseName: "邪惡向日葵"
  - Id: 1591
    Name: "瘋兔"
    JapaneseName: "瘋兔"
  - Id: 1592
    Name: "流氓"
    JapaneseName: "流氓"
  - Id: 1593
    Name: "狂暴木乃伊"
    JapaneseName: "狂暴木乃伊"
  - Id: 1594
    Name: "水靈龜"
    JapaneseName: "水靈龜"
  - Id: 1595
    Name: "冰波利"
    JapaneseName: "冰波利"
  - Id: 1596
    Name: "塔嚕安"
    JapaneseName: "塔嚕安"
  - Id: 1597
    Name: "蝙蝠弓箭手"
    JapaneseName: "蝙蝠弓箭手"
  - Id: 1598
    Name: "火焰妖"
    JapaneseName: "火焰妖"
  - Id: 1599
    Name: "巨大白幽靈"
    JapaneseName: "巨大白幽靈"
  - Id: 1600
    Name: "火焰龜"
    JapaneseName: "火焰龜"
  - Id: 1601
    Name: "果樹龜"
    JapaneseName: "果樹龜"
  - Id: 1602
    Name: "岩石龜"
    JapaneseName: "岩石龜"
  - Id: 1603
    Name: "大腳熊"
    JapaneseName: "大腳熊"
  - Id: 1604
    Name: "狂暴蜂兵"
    JapaneseName: "狂暴蜂兵"
  - Id: 1605
    Name: "迷幻之王"
    JapaneseName: "迷幻之王"
  - Id: 1606
    Name: "卡崙寶寶"
    JapaneseName: "卡崙寶寶"
  - Id: 1607
    Name: "聖誕哥布靈"
    JapaneseName: "聖誕哥布靈"
  - Id: 1608
    Name: "瑪勒盜蟲"
    JapaneseName: "瑪勒盜蟲"
  - Id: 1609
    Name: "年獸"
    JapaneseName: "年獸"
  - Id: 1610
    Name: "殭屍"
    JapaneseName: "殭屍"
  - Id: 1611
    Name: "妖道"
    JapaneseName: "妖道"
  - Id: 1612
    Name: "妖君"
    JapaneseName: "妖君"
  - Id: 1613
    Name: "金屬波利"
    JapaneseName: "金屬波利"
  - Id: 1614
    Name: "礦石魔"
    JapaneseName: "礦石魔"
  - Id: 1615
    Name: "黑曜石"
    JapaneseName: "黑曜石"
  - Id: 1616
    Name: "礦工魔"
    JapaneseName: "礦工魔"
  - Id: 1617
    Name: "廢鐵暖爐"
    JapaneseName: "廢鐵暖爐"
  - Id: 1618
    Name: "溫古力安特"
    JapaneseName: "溫古力安特"
  - Id: 1619
    Name: "三葉鐵甲蟲"
    JapaneseName: "三葉鐵甲蟲"
  - Id: 1620
    Name: "廢氣魔"
    JapaneseName: "廢氣魔"
  - Id: 1621
    Name: "毒液魔"
    JapaneseName: "毒液魔"
  - Id: 1622
    Name: "玩偶熊"
    JapaneseName: "玩偶熊"
  - Id: 1623
    Name: "RSX-0806"
    JapaneseName: "RSX-0806"
  - Id: 1624
    Name: "廢鐵暖爐"
    JapaneseName: "廢鐵暖爐"
  - Id: 1625
    Name: "三葉鐵甲蟲"
    JapaneseName: "三葉鐵甲蟲"
  - Id: 1626
    Name: "暗黑祭司"
    JapaneseName: "暗黑祭司"
  - Id: 1627
    Name: "瘧蚊"
    JapaneseName: "瘧蚊"
  - Id: 1628
    Name: "摩爾"
    JapaneseName: "摩爾"
  - Id: 1629
    Name: "希爾士兵"
    JapaneseName: "希爾士兵"
  - Id: 1630
    Name: "白素貞"
    JapaneseName: "白素貞"
  - Id: 1631
    Name: "小青"
    JapaneseName: "小青"
  - Id: 1632
    Name: "小妖精"
    JapaneseName: "小妖精"
  - Id: 1633
    Name: "惡魔之眼"
    JapaneseName: "惡魔之眼"
  - Id: 1634
    Name: "闇●騎士領主"
    JapaneseName: "闇●騎士領主"
  - Id: 1635
    Name: "闇●十字刺客"
    JapaneseName: "闇●十字刺客"
  - Id: 1636
    Name: "闇●神工匠"
    JapaneseName: "闇●神工匠"
  - Id: 1637
    Name: "闇●神官"
    JapaneseName: "闇●神官"
  - Id: 1638
    Name: "闇●神射手"
    JapaneseName: "闇●神射手"
  - Id: 1639
    Name: "闇●超魔導師"
    JapaneseName: "闇●超魔導師"
  - Id: 1640
    Name: "騎士領主 賽依連"
    JapaneseName: "騎士領主 賽依連"
  - Id: 1641
    Name: "十字刺客 艾勒梅"
    JapaneseName: "十字刺客 艾勒梅"
  - Id: 1642
    Name: "神工匠 哈沃得"
    JapaneseName: "神工匠 哈沃得"
  - Id: 1643
    Name: "神官 瑪嘉雷特"
    JapaneseName: "神官 瑪嘉雷特"
  - Id: 1644
    Name: "神射手 迪文"
    JapaneseName: "神射手 迪文"
  - Id: 1645
    Name: "超魔導師 凱特莉"
    JapaneseName: "超魔導師 凱特莉"
  - Id: 1646
    Name: "闇●騎士領主 賽"
    JapaneseName: "闇●騎士領主 賽"
  - Id: 1647
    Name: "闇●十字刺客 艾"
    JapaneseName: "闇●十字刺客 艾"
  - Id: 1648
    Name: "闇●神工匠 哈沃"
    JapaneseName: "闇●神工匠 哈沃"
  - Id: 1649
    Name: "闇●神官 瑪嘉雷"
    JapaneseName: "闇●神官 瑪嘉雷"
  - Id: 1650
    Name: "闇●神射手 迪文"
    JapaneseName: "闇●神射手 迪文"
  - Id: 1651
    Name: "闇●超魔導師 凱"
    JapaneseName: "闇●超魔導師 凱"
  - Id: 1652
    Name: "闇●劍士"
    JapaneseName: "闇●劍士"
  - Id: 1653
    Name: "闇●盜賊"
    JapaneseName: "闇●盜賊"
  - Id: 1654
    Name: "闇●商人"
    JapaneseName: "闇●商人"
  - Id: 1655
    Name: "闇●服事"
    JapaneseName: "闇●服事"
  - Id: 1656
    Name: "闇●弓箭手"
    JapaneseName: "闇●弓箭手"
  - Id: 1657
    Name: "闇●魔法師"
    JapaneseName: "闇●魔法師"
  - Id: 1658
    Name: "闇●劍士 賽尼亞"
    JapaneseName: "闇●劍士 賽尼亞"
  - Id: 1659
    Name: "盜賊 特麗絲"
    JapaneseName: "盜賊 特麗絲"
  - Id: 1660
    Name: "商人 娣潔"
    JapaneseName: "商人 娣潔"
  - Id: 1661
    Name: "服事 艾貝西"
    JapaneseName: "服事 艾貝西"
  - Id: 1662
    Name: "弓箭手 伊卡勒斯"
    JapaneseName: "弓箭手 伊卡勒斯"
  - Id: 1663
    Name: "魔法師 龐德"
    JapaneseName: "魔法師 龐德"
  - Id: 1664
    Name: "紅真晶"
    JapaneseName: "紅真晶"
  - Id: 1665
    Name: "黃真晶"
    JapaneseName: "黃真晶"
  - Id: 1666
    Name: "綠真晶"
    JapaneseName: "綠真晶"
  - Id: 1667
    Name: "藍真晶"
    JapaneseName: "藍真晶"
  - Id: 1668
    Name: "阿克坦"
    JapaneseName: "阿克坦"
  - Id: 1669
    Name: "迪靡克"
    JapaneseName: "迪靡克"
  - Id: 1670
    Name: "暴風迪靡克"
    JapaneseName: "暴風迪靡克"
  - Id: 1671
    Name: "冰凍迪靡克"
    JapaneseName: "冰凍迪靡克"
  - Id: 1672
    Name: "崩裂迪靡克"
    JapaneseName: "崩裂迪靡克"
  - Id: 1673
    Name: "火焰迪靡克"
    JapaneseName: "火焰迪靡克"
  - Id: 1674
    Name: "莫內"
    JapaneseName: "莫內"
  - Id: 1675
    Name: "凡娜圖"
    JapaneseName: "凡娜圖"
  - Id: 1676
    Name: "褐凡娜圖"
    JapaneseName: "褐凡娜圖"
  - Id: 1677
    Name: "綠凡娜圖"
    JapaneseName: "綠凡娜圖"
  - Id: 1678
    Name: "橘凡娜圖"
    JapaneseName: "橘凡娜圖"
  - Id: 1679
    Name: "藍凡娜圖"
    JapaneseName: "藍凡娜圖"
  - Id: 1680
    Name: "希爾隊長"
    JapaneseName: "希爾隊長"
  - Id: 1681
    Name: "雙子星-S58"
    JapaneseName: "雙子星-S58"
  - Id: 1682
    Name: "消防魔"
    JapaneseName: "消防魔"
  - Id: 1683
    Name: "紅真晶"
    JapaneseName: "紅真晶"
  - Id: 1684
    Name: "阿克坦"
    JapaneseName: "阿克坦"
  - Id: 1685
    Name: "貝思波"
    JapaneseName: "貝思波"
  - Id: 1686
    Name: "獸人嬰兒"
    JapaneseName: "獸人嬰兒"
  - Id: 1687
    Name: "綠變色龍"
    JapaneseName: "綠變色龍"
  - Id: 1688
    Name: "嗒妮小姐"
    JapaneseName: "嗒妮小姐"
  - Id: 1689
    Name: "嫦娥"
    JapaneseName: "嫦娥"
  - Id: 1690
    Name: "搗藥小玉兔"
    JapaneseName: "搗藥小玉兔"
  - Id: 1691
    Name: "克萊本"
    JapaneseName: "克萊本"
  - Id: 1692
    Name: "微風"
    JapaneseName: "微風"
  - Id: 1693
    Name: "黃色等離子體"
    JapaneseName: "黃色等離子體"
  - Id: 1694
    Name: "紅色等離子體"
    JapaneseName: "紅色等離子體"
  - Id: 1695
    Name: "綠色等離子體"
    JapaneseName: "綠色等離子體"
  - Id: 1696
    Name: "紫色等離子體"
    JapaneseName: "紫色等離子體"
  - Id: 1697
    Name: "藍色等離子體"
    JapaneseName: "藍色等離子體"
  - Id: 1698
    Name: "死亡魔書"
    JapaneseName: "死亡魔書"
  - Id: 1699
    Name: "狂暴邪惡箱"
    JapaneseName: "狂暴邪惡箱"
  - Id: 1700
    Name: "監視者"
    JapaneseName: "監視者"
  - Id: 1701
    Name: "安息者"
    JapaneseName: "安息者"
  - Id: 1702
    Name: "代行刑者"
    JapaneseName: "代行刑者"
  - Id: 1703
    Name: "慰勞者"
    JapaneseName: "慰勞者"
  - Id: 1704
    Name: "塔納托斯的憎恨"
    JapaneseName: "塔納托斯的憎恨"
  - Id: 1705
    Name: "塔納托斯的絕望"
    JapaneseName: "塔納托斯的絕望"
  - Id: 1706
    Name: "塔納托斯的悲哀"
    JapaneseName: "塔納托斯的悲哀"
  - Id: 1707
    Name: "塔納托斯的苦惱"
    JapaneseName: "塔納托斯的苦惱"
  - Id: 1708
    Name: "魔劍士 達納托斯"
    JapaneseName: "魔劍士 達納托斯"
  - Id: 1709
    Name: "塔納托斯的憎恨"
    JapaneseName: "塔納托斯的憎恨"
  - Id: 1710
    Name: "塔納托斯的絕望"
    JapaneseName: "塔納托斯的絕望"
  - Id: 1711
    Name: "塔納托斯的悲哀"
    JapaneseName: "塔納托斯的悲哀"
  - Id: 1712
    Name: "塔納托斯的苦惱"
    JapaneseName: "塔納托斯的苦惱"
  - Id: 1713
    Name: "俄希托斯"
    JapaneseName: "俄希托斯"
  - Id: 1714
    Name: "紅貝勒斯"
    JapaneseName: "紅貝勒斯"
  - Id: 1715
    Name: "諾博斯"
    JapaneseName: "諾博斯"
  - Id: 1716
    Name: "灰俄希托斯"
    JapaneseName: "灰俄希托斯"
  - Id: 1717
    Name: "綠貝勒斯"
    JapaneseName: "綠貝勒斯"
  - Id: 1718
    Name: "黃諾博斯"
    JapaneseName: "黃諾博斯"
  - Id: 1719
    Name: "迪塔勒泰晤勒斯"
    JapaneseName: "迪塔勒泰晤勒斯"
  - Id: 1720
    Name: "三頭龍"
    JapaneseName: "三頭龍"
  - Id: 1721
    Name: "龍蛋"
    JapaneseName: "龍蛋"
  - Id: 1722
    Name: "萬聖節 南瓜先生"
    JapaneseName: "萬聖節 南瓜先生"
  - Id: 1723
    Name: "闇●神射手"
    JapaneseName: "闇●神射手"
  - Id: 1724
    Name: "紅真晶"
    JapaneseName: "紅真晶"
  - Id: 1725
    Name: "波利"
    JapaneseName: "波利"
  - Id: 1726
    Name: "瘋兔"
    JapaneseName: "瘋兔"
  - Id: 1727
    Name: "小野豬"
    JapaneseName: "小野豬"
  - Id: 1728
    Name: "沙漠幼狼"
    JapaneseName: "沙漠幼狼"
  - Id: 1729
    Name: "小巴風特"
    JapaneseName: "小巴風特"
  - Id: 1730
    Name: "小惡魔"
    JapaneseName: "小惡魔"
  - Id: 1731
    Name: "死靈"
    JapaneseName: "死靈"
  - Id: 1732
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1733
    Name: "齊爾"
    JapaneseName: "齊爾"
  - Id: 1734
    Name: "齊爾-D-01"
    JapaneseName: "齊爾-D-01"
  - Id: 1735
    Name: "愛麗瑟"
    JapaneseName: "愛麗瑟"
  - Id: 1736
    Name: "愛麗俄"
    JapaneseName: "愛麗俄"
  - Id: 1737
    Name: "愛麗莎"
    JapaneseName: "愛麗莎"
  - Id: 1738
    Name: "恆量魔"
    JapaneseName: "恆量魔"
  - Id: 1739
    Name: "愛麗削"
    JapaneseName: "愛麗削"
  - Id: 1740
    Name: "愛麗俄"
    JapaneseName: "愛麗俄"
  - Id: 1741
    Name: "甜餅人"
    JapaneseName: "甜餅人"
  - Id: 1742
    Name: "卡拉特小丑"
    JapaneseName: "卡拉特小丑"
  - Id: 1743
    Name: "邪惡禮盒"
    JapaneseName: "邪惡禮盒"
  - Id: 1744
    Name: "狂暴野貓"
    JapaneseName: "狂暴野貓"
  - Id: 1745
    Name: "恆量魔"
    JapaneseName: "恆量魔"
  - Id: 1746
    Name: "愛麗哲"
    JapaneseName: "愛麗哲"
  - Id: 1747
    Name: "青蛇"
    JapaneseName: "青蛇"
  - Id: 1748
    Name: "毒蛇"
    JapaneseName: "毒蛇"
  - Id: 1749
    Name: "米杜沙"
    JapaneseName: "米杜沙"
  - Id: 1750
    Name: "紅草"
    JapaneseName: "紅草"
  - Id: 1751
    Name: "蘭特克力斯"
    JapaneseName: "蘭特克力斯"
  - Id: 1752
    Name: "皮影魔"
    JapaneseName: "皮影魔"
  - Id: 1753
    Name: "彩色皮影魔"
    JapaneseName: "彩色皮影魔"
  - Id: 1754
    Name: "褐方體惡魔"
    JapaneseName: "褐方體惡魔"
  - Id: 1755
    Name: "黑方體惡魔"
    JapaneseName: "黑方體惡魔"
  - Id: 1756
    Name: "三頭龍"
    JapaneseName: "三頭龍"
  - Id: 1757
    Name: "黃俄希托斯"
    JapaneseName: "黃俄希托斯"
  - Id: 1758
    Name: "紅貝勒斯"
    JapaneseName: "紅貝勒斯"
  - Id: 1759
    Name: "灰俄希托斯"
    JapaneseName: "灰俄希托斯"
  - Id: 1760
    Name: "綠貝勒斯"
    JapaneseName: "綠貝勒斯"
  - Id: 1761
    Name: "皮影魔"
    JapaneseName: "皮影魔"
  - Id: 1762
    Name: "彩妝皮影魔"
    JapaneseName: "彩妝皮影魔"
  - Id: 1763
    Name: "褐方體惡魔"
    JapaneseName: "褐方體惡魔"
  - Id: 1764
    Name: "黑方體惡魔"
    JapaneseName: "黑方體惡魔"
  - Id: 1765
    Name: "巴基力 蘭特克力"
    JapaneseName: "巴基力 蘭特克力"
  - Id: 1766
    Name: "天使波利"
    JapaneseName: "天使波利"
  - Id: 1767
    Name: "惡魔波利"
    JapaneseName: "惡魔波利"
  - Id: 1768
    Name: "幽暗夢魘"
    JapaneseName: "幽暗夢魘"
  - Id: 1769
    Name: "阿卡布"
    JapaneseName: "阿卡布"
  - Id: 1770
    Name: "埃奇歐"
    JapaneseName: "埃奇歐"
  - Id: 1771
    Name: "潘貝勒克"
    JapaneseName: "潘貝勒克"
  - Id: 1772
    Name: "伊西拉"
    JapaneseName: "伊西拉"
  - Id: 1773
    Name: "異型"
    JapaneseName: "異型"
  - Id: 1774
    Name: "紅惡魔之眼"
    JapaneseName: "紅惡魔之眼"
  - Id: 1775
    Name: "雪獸"
    JapaneseName: "雪獸"
  - Id: 1776
    Name: "小雪獸"
    JapaneseName: "小雪獸"
  - Id: 1777
    Name: "冰巨人"
    JapaneseName: "冰巨人"
  - Id: 1778
    Name: "蓋俄斯提"
    JapaneseName: "蓋俄斯提"
  - Id: 1779
    Name: "水晶龍"
    JapaneseName: "水晶龍"
  - Id: 1780
    Name: "吃人草"
    JapaneseName: "吃人草"
  - Id: 1781
    Name: "捕蟲草"
    JapaneseName: "捕蟲草"
  - Id: 1782
    Name: "土狼"
    JapaneseName: "土狼"
  - Id: 1783
    Name: "迦利"
    JapaneseName: "迦利"
  - Id: 1784
    Name: "石頭波利"
    JapaneseName: "石頭波利"
  - Id: 1785
    Name: "阿特羅斯"
    JapaneseName: "阿特羅斯"
  - Id: 1786
    Name: "阿加波"
    JapaneseName: "阿加波"
  - Id: 1787
    Name: "艾基奧"
    JapaneseName: "艾基奧"
  - Id: 1788
    Name: "寒冰巨人"
    JapaneseName: "寒冰巨人"
  - Id: 1789
    Name: "冰柱"
    JapaneseName: "冰柱"
  - Id: 1790
    Name: "草精"
    JapaneseName: "草精"
  - Id: 1791
    Name: "瘋狂鬣狗"
    JapaneseName: "瘋狂鬣狗"
  - Id: 1792
    Name: "足球"
    JapaneseName: "足球"
  - Id: 1793
    Name: "邪惡摩艾"
    JapaneseName: "邪惡摩艾"
  - Id: 1794
    Name: "土狼"
    JapaneseName: "土狼"
  - Id: 1795
    Name: "血腥騎士"
    JapaneseName: "血腥騎士"
  - Id: 1796
    Name: "阿吾諾耶"
    JapaneseName: "阿吾諾耶"
  - Id: 1797
    Name: "法恩特"
    JapaneseName: "法恩特"
  - Id: 1798
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1799
    Name: "騎士領主 賽依連("
    JapaneseName: "騎士領主 賽依連("
  - Id: 1800
    Name: "十字刺客 艾勒梅"
    JapaneseName: "十字刺客 艾勒梅"
  - Id: 1801
    Name: "神工匠 哈沃得(G)"
    JapaneseName: "神工匠 哈沃得(G)"
  - Id: 1802
    Name: "神官 瑪嘉雷特(G)"
    JapaneseName: "神官 瑪嘉雷特(G)"
  - Id: 1803
    Name: "神射手 迪文(G)"
    JapaneseName: "神射手 迪文(G)"
  - Id: 1804
    Name: "超魔導師 凱特莉"
    JapaneseName: "超魔導師 凱特莉"
  - Id: 1805
    Name: "闇●騎士領主 賽"
    JapaneseName: "闇●騎士領主 賽"
  - Id: 1806
    Name: "闇●十字刺客 艾"
    JapaneseName: "闇●十字刺客 艾"
  - Id: 1807
    Name: "闇●神工匠 哈沃"
    JapaneseName: "闇●神工匠 哈沃"
  - Id: 1808
    Name: "闇●神官 瑪嘉雷"
    JapaneseName: "闇●神官 瑪嘉雷"
  - Id: 1809
    Name: "闇●神射手 迪文"
    JapaneseName: "闇●神射手 迪文"
  - Id: 1810
    Name: "闇●超魔導師 凱"
    JapaneseName: "闇●超魔導師 凱"
  - Id: 1811
    Name: "貍貓"
    JapaneseName: "貍貓"
  - Id: 1812
    Name: "南瓜魂"
    JapaneseName: "南瓜魂"
  - Id: 1813
    Name: "三頭龍"
    JapaneseName: "三頭龍"
  - Id: 1814
    Name: "月夜貓"
    JapaneseName: "月夜貓"
  - Id: 1815
    Name: "熱騰騰的米糕"
    JapaneseName: "熱騰騰的米糕"
  - Id: 1816
    Name: "葫蘆藤"
    JapaneseName: "葫蘆藤"
  - Id: 1817
    Name: "迪塔勒泰晤勒斯"
    JapaneseName: "迪塔勒泰晤勒斯"
  - Id: 1818
    Name: "鐘怪"
    JapaneseName: "鐘怪"
  - Id: 1819
    Name: "巫婆"
    JapaneseName: "巫婆"
  - Id: 1820
    Name: "大腳熊"
    JapaneseName: "大腳熊"
  - Id: 1821
    Name: "沙漠幼狼"
    JapaneseName: "沙漠幼狼"
  - Id: 1822
    Name: "小惡魔"
    JapaneseName: "小惡魔"
  - Id: 1823
    Name: "水靈龜"
    JapaneseName: "水靈龜"
  - Id: 1824
    Name: "卡侖寶寶"
    JapaneseName: "卡侖寶寶"
  - Id: 1825
    Name: "聖誕哥布靈"
    JapaneseName: "聖誕哥布靈"
  - Id: 1826
    Name: "麥斯特"
    JapaneseName: "麥斯特"
  - Id: 1827
    Name: "雪熊"
    JapaneseName: "雪熊"
  - Id: 1828
    Name: "狂暴野豬"
    JapaneseName: "狂暴野豬"
  - Id: 1829
    Name: "劍士監護人魔物"
    JapaneseName: "劍士監護人魔物"
  - Id: 1830
    Name: "弓箭手監護人魔"
    JapaneseName: "弓箭手監護人魔"
  - Id: 1831
    Name: "火蜥蝪"
    JapaneseName: "火蜥蝪"
  - Id: 1832
    Name: "伊夫利特"
    JapaneseName: "伊夫利特"
  - Id: 1833
    Name: "火鳥"
    JapaneseName: "火鳥"
  - Id: 1834
    Name: "火蜥蝪"
    JapaneseName: "火蜥蝪"
  - Id: 1835
    Name: "火鳥"
    JapaneseName: "火鳥"
  - Id: 1836
    Name: "岩漿波利"
    JapaneseName: "岩漿波利"
  - Id: 1837
    Name: "炙燄魔"
    JapaneseName: "炙燄魔"
  - Id: 1838
    Name: "礦坑小精靈"
    JapaneseName: "礦坑小精靈"
  - Id: 1839
    Name: "漂流浪人"
    JapaneseName: "漂流浪人"
  - Id: 1840
    Name: "黃金野豬"
    JapaneseName: "黃金野豬"
  - Id: 1841
    Name: "青蛇"
    JapaneseName: "青蛇"
  - Id: 1842
    Name: "毒蛇"
    JapaneseName: "毒蛇"
  - Id: 1843
    Name: "黑蛇"
    JapaneseName: "黑蛇"
  - Id: 1844
    Name: "蛇女伊絲"
    JapaneseName: "蛇女伊絲"
  - Id: 1845
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1846
    Name: "華麗金屬"
    JapaneseName: "華麗金屬"
  - Id: 1847
    Name: "波利"
    JapaneseName: "波利"
  - Id: 1848
    Name: "巴風特"
    JapaneseName: "巴風特"
  - Id: 1849
    Name: "俄塞里斯"
    JapaneseName: "俄塞里斯"
  - Id: 1850
    Name: "獸人英雄"
    JapaneseName: "獸人英雄"
  - Id: 1851
    Name: "流氓"
    JapaneseName: "流氓"
  - Id: 1852
    Name: "天使波利"
    JapaneseName: "天使波利"
  - Id: 1853
    Name: "惡魔波利"
    JapaneseName: "惡魔波利"
  - Id: 1854
    Name: "摩卡"
    JapaneseName: "摩卡"
  - Id: 1855
    Name: "毒魔菇"
    JapaneseName: "毒魔菇"
  - Id: 1856
    Name: "魔鍋蛋"
    JapaneseName: "魔鍋蛋"
  - Id: 1857
    Name: "冰波利"
    JapaneseName: "冰波利"
  - Id: 1858
    Name: "漂浮蟲"
    JapaneseName: "漂浮蟲"
  - Id: 1859
    Name: "曼陀羅魔花"
    JapaneseName: "曼陀羅魔花"
  - Id: 1860
    Name: "松鼠"
    JapaneseName: "松鼠"
  - Id: 1861
    Name: "巧克猴"
    JapaneseName: "巧克猴"
  - Id: 1862
    Name: "土撥鼠"
    JapaneseName: "土撥鼠"
  - Id: 1863
    Name: "彈簧兔"
    JapaneseName: "彈簧兔"
  - Id: 1864
    Name: "屠殺腐屍"
    JapaneseName: "屠殺腐屍"
  - Id: 1865
    Name: "襤褸腐屍"
    JapaneseName: "襤褸腐屍"
  - Id: 1866
    Name: "地獄貴賓狗"
    JapaneseName: "地獄貴賓狗"
  - Id: 1867
    Name: "惡耗女妖"
    JapaneseName: "惡耗女妖"
  - Id: 1868
    Name: "女妖"
    JapaneseName: "女妖"
  - Id: 1869
    Name: "火焰骷髏頭"
    JapaneseName: "火焰骷髏頭"
  - Id: 1870
    Name: "行妖術者"
    JapaneseName: "行妖術者"
  - Id: 1871
    Name: "墮落大神官 悉潘"
    JapaneseName: "墮落大神官 悉潘"
  - Id: 1872
    Name: "魔鬼蒼蠅"
    JapaneseName: "魔鬼蒼蠅"
  - Id: 1873
    Name: "貝雷傑"
    JapaneseName: "貝雷傑"
  - Id: 1874
    Name: "詛咒蠅王"
    JapaneseName: "詛咒蠅王"
  - Id: 1875
    Name: "王的屍體"
    JapaneseName: "王的屍體"
  - Id: 1876
    Name: "死靈騎士"
    JapaneseName: "死靈騎士"
  - Id: 1877
    Name: "元素"
    JapaneseName: "元素"
  - Id: 1878
    Name: "光芒草"
    JapaneseName: "光芒草"
  - Id: 1879
    Name: "可愛小玉兔"
    JapaneseName: "可愛小玉兔"
  - Id: 1880
    Name: "樹林哥布靈"
    JapaneseName: "樹林哥布靈"
  - Id: 1881
    Name: "雷斯"
    JapaneseName: "雷斯"
  - Id: 1882
    Name: "芭芭亞卡"
    JapaneseName: "芭芭亞卡"
  - Id: 1883
    Name: "樹林女巫"
    JapaneseName: "樹林女巫"
  - Id: 1884
    Name: "森林妖精"
    JapaneseName: "森林妖精"
  - Id: 1885
    Name: "青冠龍"
    JapaneseName: "青冠龍"
  - Id: 1886
    Name: "森林妖精的靈魂"
    JapaneseName: "森林妖精的靈魂"
  - Id: 1887
    Name: "水靈龜"
    JapaneseName: "水靈龜"
  - Id: 1888
    Name: "卡侖寶寶"
    JapaneseName: "卡侖寶寶"
  - Id: 1889
    Name: "卡侖"
    JapaneseName: "卡侖"
  - Id: 1890
    Name: "青冠龍"
    JapaneseName: "青冠龍"
  - Id: 1891
    Name: "巴基力 蘭特克力"
    JapaneseName: "巴基力 蘭特克力"
  - Id: 1892
    Name: "銀月魔女"
    JapaneseName: "銀月魔女"
  - Id: 1893
    Name: "深淵騎士"
    JapaneseName: "深淵騎士"
  - Id: 1894
    Name: "水滴波利"
    JapaneseName: "水滴波利"
  - Id: 1895
    Name: "騎士領主 賽依連"
    JapaneseName: "騎士領主 賽依連"
  - Id: 1896
    Name: "超魔導師 凱特莉"
    JapaneseName: "超魔導師 凱特莉"
  - Id: 1897
    Name: "巴風特"
    JapaneseName: "巴風特"
  - Id: 1898
    Name: "腐尸"
    JapaneseName: "腐尸"
  - Id: 1899
    Name: "劍士監護人魔物"
    JapaneseName: "劍士監護人魔物"
  - Id: 1900
    Name: "弓箭手監護人魔"
    JapaneseName: "弓箭手監護人魔"
  - Id: 1901
    Name: "禿鷹"
    JapaneseName: "禿鷹"
  - Id: 1902
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1903
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1904
    Name: "炸彈波利"
    JapaneseName: "炸彈波利"
  - Id: 1905
    Name: "防禦線"
    JapaneseName: "防禦線"
  - Id: 1906
    Name: "防禦線"
    JapaneseName: "防禦線"
  - Id: 1907
    Name: "第 1 守護石"
    JapaneseName: "第 1 守護石"
  - Id: 1908
    Name: "第 2 守護石"
    JapaneseName: "第 2 守護石"
  - Id: 1909
    Name: "糧食倉庫"
    JapaneseName: "糧食倉庫"
  - Id: 1910
    Name: "糧食倉庫"
    JapaneseName: "糧食倉庫"
  - Id: 1911
    Name: "中立旗子"
    JapaneseName: "中立旗子"
  - Id: 1912
    Name: "古恩雷姆旗子"
    JapaneseName: "古恩雷姆旗子"
  - Id: 1913
    Name: "庫魯雅旗子"
    JapaneseName: "庫魯雅旗子"
  - Id: 1914
    Name: "古恩雷姆水晶"
    JapaneseName: "古恩雷姆水晶"
  - Id: 1915
    Name: "庫魯雅水晶"
    JapaneseName: "庫魯雅水晶"
  - Id: 1916
    Name: "魔王夢羅克"
    JapaneseName: "魔王夢羅克"
  - Id: 1917
    Name: "負傷夢羅克"
    JapaneseName: "負傷夢羅克"
  - Id: 1918
    Name: "夢羅克門徒之邪"
    JapaneseName: "夢羅克門徒之邪"
  - Id: 1919
    Name: "夢羅克門徒之泥"
    JapaneseName: "夢羅克門徒之泥"
  - Id: 1920
    Name: "夢羅克門徒之活"
    JapaneseName: "夢羅克門徒之活"
  - Id: 1921
    Name: "夢羅克門徒之喜"
    JapaneseName: "夢羅克門徒之喜"
  - Id: 1922
    Name: "夢羅克門徒之小"
    JapaneseName: "夢羅克門徒之小"
  - Id: 1923
    Name: "夢羅克門徒之小"
    JapaneseName: "夢羅克門徒之小"
  - Id: 1924
    Name: "夢羅克門徒之小"
    JapaneseName: "夢羅克門徒之小"
  - Id: 1925
    Name: "夢羅克門徒之小"
    JapaneseName: "夢羅克門徒之小"
  - Id: 1926
    Name: "落跑的南瓜"
    JapaneseName: "落跑的南瓜"
  - Id: 1927
    Name: "慶典用 白幽靈"
    JapaneseName: "慶典用 白幽靈"
  - Id: 1928
    Name: "慶典用 小惡魔"
    JapaneseName: "慶典用 小惡魔"
  - Id: 1929
    Name: "巨大巴風特"
    JapaneseName: "巨大巴風特"
  - Id: 1930
    Name: "生氣的碧亞玫特"
    JapaneseName: "生氣的碧亞玫特"
  - Id: 1931
    Name: "祈望女神 薇希梅"
    JapaneseName: "祈望女神 薇希梅"
  - Id: 1932
    Name: "花園守衛"
    JapaneseName: "花園守衛"
  - Id: 1933
    Name: "花園巡視者"
    JapaneseName: "花園巡視者"
  - Id: 1934
    Name: "藍色花朵"
    JapaneseName: "藍色花朵"
  - Id: 1935
    Name: "紅色花朵"
    JapaneseName: "紅色花朵"
  - Id: 1936
    Name: "黃色花朵"
    JapaneseName: "黃色花朵"
  - Id: 1937
    Name: "恆量魔"
    JapaneseName: "恆量魔"
  - Id: 1938
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1939
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1940
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1941
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1942
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1943
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1944
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1945
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1946
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1947
    Name: "匹阿漫特"
    JapaneseName: "匹阿漫特"
  - Id: 1948
    Name: "闇●劍士"
    JapaneseName: "闇●劍士"
  - Id: 1949
    Name: "S守衛"
    JapaneseName: "S守衛"
  - Id: 1950
    Name: "B守衛"
    JapaneseName: "B守衛"
  - Id: 1951
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 1952
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 1953
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 1954
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 1955
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 1956
    Name: "夜勝魔"
    JapaneseName: "夜勝魔"
  - Id: 1957
    Name: "骷髏觸角魔"
    JapaneseName: "骷髏觸角魔"
  - Id: 1958
    Name: "骨頭之荊棘"
    JapaneseName: "骨頭之荊棘"
  - Id: 1959
    Name: "恢復之荊棘"
    JapaneseName: "恢復之荊棘"
  - Id: 1960
    Name: "魔力之荊棘"
    JapaneseName: "魔力之荊棘"
  - Id: 1961
    Name: "淨化之荊棘"
    JapaneseName: "淨化之荊棘"
  - Id: 1962
    Name: "糖果 小偷"
    JapaneseName: "糖果 小偷"
  - Id: 1963
    Name: "新年娃娃"
    JapaneseName: "新年娃娃"
  - Id: 1964
    Name: "夢魘"
    JapaneseName: "夢魘"
  - Id: 1965
    Name: "狂暴野貓"
    JapaneseName: "狂暴野貓"
  - Id: 1966
    Name: "死靈"
    JapaneseName: "死靈"
  - Id: 1967
    Name: "闇●劍士 賽尼亞"
    JapaneseName: "闇●劍士 賽尼亞"
  - Id: 1968
    Name: "海神"
    JapaneseName: "海神"
  - Id: 1969
    Name: "馬克"
    JapaneseName: "馬克"
  - Id: 1970
    Name: "人魚"
    JapaneseName: "人魚"
  - Id: 1971
    Name: "螃蟹"
    JapaneseName: "螃蟹"
  - Id: 1972
    Name: "水母"
    JapaneseName: "水母"
  - Id: 1973
    Name: "波利"
    JapaneseName: "波利"
  - Id: 1974
    Name: "愛爾蘭女妖首領"
    JapaneseName: "愛爾蘭女妖首領"
  - Id: 1975
    Name: "眼魔首領"
    JapaneseName: "眼魔首領"
  - Id: 1976
    Name: "惡精靈礦石"
    JapaneseName: "惡精靈礦石"
  - Id: 1977
    Name: "重金屬波利"
    JapaneseName: "重金屬波利"
  - Id: 1978
    Name: "地獄阿修羅機械"
    JapaneseName: "地獄阿修羅機械"
  - Id: 1979
    Name: "扎古丹"
    JapaneseName: "扎古丹"
  - Id: 1980
    Name: "榔鎚酷布靈"
    JapaneseName: "榔鎚酷布靈"
  - Id: 1981
    Name: "獸人守護隊長"
    JapaneseName: "獸人守護隊長"
  - Id: 1982
    Name: "獸人神射手"
    JapaneseName: "獸人神射手"
  - Id: 1983
    Name: "墮落的獸人怨魂"
    JapaneseName: "墮落的獸人怨魂"
  - Id: 1984
    Name: "女巫 柯莉戈拉魆"
    JapaneseName: "女巫 柯莉戈拉魆"
  - Id: 1985
    Name: "蒲公英成員"
    JapaneseName: "蒲公英成員"
  - Id: 1986
    Name: "塔塔丘"
    JapaneseName: "塔塔丘"
  - Id: 1987
    Name: "變異蜈蚣"
    JapaneseName: "變異蜈蚣"
  - Id: 1988
    Name: "豬籠草"
    JapaneseName: "豬籠草"
  - Id: 1989
    Name: "三角幼獅獸"
    JapaneseName: "三角幼獅獸"
  - Id: 1990
    Name: "硬石猛瑪"
    JapaneseName: "硬石猛瑪"
  - Id: 1991
    Name: "三角狂獅獸"
    JapaneseName: "三角狂獅獸"
  - Id: 1992
    Name: "獨角飛馬"
    JapaneseName: "獨角飛馬"
  - Id: 1993
    Name: "那迦"
    JapaneseName: "那迦"
  - Id: 1994
    Name: "魯修拉黃蜂"
    JapaneseName: "魯修拉黃蜂"
  - Id: 1995
    Name: "捕蟲堇妖"
    JapaneseName: "捕蟲堇妖"
  - Id: 1997
    Name: "噠噠喬"
    JapaneseName: "噠噠喬"
  - Id: 1998
    Name: "希斯利安"
    JapaneseName: "希斯利安"
  - Id: 1999
    Name: "變異蜈蚣幼蟲"
    JapaneseName: "變異蜈蚣幼蟲"
  - Id: 2000
    Name: "游戲管理員(男)"
    JapaneseName: "游戲管理員(男)"
  - Id: 2001
    Name: "游戲管理員(女)"
    JapaneseName: "游戲管理員(女)"
  - Id: 2002
    Name: "護身幽靈彈簧兔"
    JapaneseName: "護身幽靈彈簧兔"
  - Id: 2003
    Name: "護身幽靈白素貞"
    JapaneseName: "護身幽靈白素貞"
  - Id: 2004
    Name: "護身幽靈妖仙女"
    JapaneseName: "護身幽靈妖仙女"
  - Id: 2005
    Name: "藍色等離子體"
    JapaneseName: "藍色等離子體"
  - Id: 2006
    Name: "紫色等離子體"
    JapaneseName: "紫色等離子體"
  - Id: 2007
    Name: "紅色等離子體"
    JapaneseName: "紅色等離子體"
  - Id: 2008
    Name: "牛魔王"
    JapaneseName: "牛魔王"
  - Id: 2009
    Name: "牛魔王"
    JapaneseName: "牛魔王"
  - Id: 2010
    Name: "狂暴米諾斯(G)"
    JapaneseName: "狂暴米諾斯(G)"
  - Id: 2011
    Name: "萬聖節綠腐尸"
    JapaneseName: "萬聖節綠腐尸"
  - Id: 2012
    Name: "萬聖節腐尸"
    JapaneseName: "萬聖節腐尸"
  - Id: 2013
    Name: "暴躁龍"
    JapaneseName: "暴躁龍"
  - Id: 2014
    Name: "暴躁龍蛋"
    JapaneseName: "暴躁龍蛋"
  - Id: 2015
    Name: "黑暗捕蟲堇妖"
    JapaneseName: "黑暗捕蟲堇妖"
  - Id: 2016
    Name: "水精靈"
    JapaneseName: "水精靈"
  - Id: 2017
    Name: "刷尾負鼠"
    JapaneseName: "刷尾負鼠"
  - Id: 2018
    Name: "杜尼爾"
    JapaneseName: "杜尼爾"
  - Id: 2019
    Name: "異種神木"
    JapaneseName: "異種神木"
  - Id: 2020
    Name: "靈剋"
    JapaneseName: "靈剋"
  - Id: 2021
    Name: "妣拉"
    JapaneseName: "妣拉"
  - Id: 2022
    Name: "尼德霍格的影子"
    JapaneseName: "尼德霍格的影子"
  - Id: 2023
    Name: "黑影幽靈"
    JapaneseName: "黑影幽靈"
  - Id: 2024
    Name: "鈽鐳巨人"
    JapaneseName: "鈽鐳巨人"
  - Id: 2025
    Name: "瘋狂的禮物箱"
    JapaneseName: "瘋狂的禮物箱"
  - Id: 2026
    Name: "逃走的蒲公英成"
    JapaneseName: "逃走的蒲公英成"
  - Id: 2027
    Name: "黑影幽靈"
    JapaneseName: "黑影幽靈"
  - Id: 2030
    Name: "墮落的大神官希"
    JapaneseName: "墮落的大神官希"
  - Id: 2031
    Name: "蒲公英成員"
    JapaneseName: "蒲公英成員"
  - Id: 2032
    Name: "森林守衛"
    JapaneseName: "森林守衛"
  - Id: 2033
    Name: "金色鬱金香"
    JapaneseName: "金色鬱金香"
  - Id: 2035
    Name: "虛無之石"
    JapaneseName: "虛無之石"
  - Id: 2036
    Name: "瓦爾基麗雅的噩"
    JapaneseName: "瓦爾基麗雅的噩"
  - Id: 2039
    Name: "魔劍行刑者"
    JapaneseName: "魔劍行刑者"
  - Id: 2040
    Name: "魔劍獸牙怪"
    JapaneseName: "魔劍獸牙怪"
  - Id: 2041
    Name: "魔劍弒神者"
    JapaneseName: "魔劍弒神者"
  - Id: 2042
    Name: "銀色狙擊手"
    JapaneseName: "銀色狙擊手"
  - Id: 2043
    Name: "魔法傀儡(火)"
    JapaneseName: "魔法傀儡(火)"
  - Id: 2044
    Name: "魔法傀儡(水)"
    JapaneseName: "魔法傀儡(水)"
  - Id: 2045
    Name: "魔法傀儡(地)"
    JapaneseName: "魔法傀儡(地)"
  - Id: 2046
    Name: "魔法傀儡(風)"
    JapaneseName: "魔法傀儡(風)"
  - Id: 2047
    Name: "中邪的那迦"
    JapaneseName: "中邪的那迦"
  - Id: 2048
    Name: "中邪的的捕蟲堇"
    JapaneseName: "中邪的的捕蟲堇"
  - Id: 2049
    Name: "中邪的鈽鐳巨人"
    JapaneseName: "中邪的鈽鐳巨人"
  - Id: 2050
    Name: "沉醉於魔力的水"
    JapaneseName: "沉醉於魔力的水"
  - Id: 2052
    Name: "黑暗之王"
    JapaneseName: "黑暗之王"
  - Id: 2057
    Name: "變異老鼠"
    JapaneseName: "變異老鼠"
  - Id: 2066
    Name: "瘧蚊"
    JapaneseName: "瘧蚊"
  - Id: 2067
    Name: "瘧蚊"
    JapaneseName: "瘧蚊"
  - Id: 2068
    Name: "波伊塔塔"
    JapaneseName: "波伊塔塔"
  - Id: 2069
    Name: "亞拉"
    JapaneseName: "亞拉"
  - Id: 2070
    Name: "食人魚"
    JapaneseName: "食人魚"
  - Id: 2071
    Name: "無頭騾"
    JapaneseName: "無頭騾"
  - Id: 2072
    Name: "美洲虎"
    JapaneseName: "美洲虎"
  - Id: 2073
    Name: "巨嘴鳥"
    JapaneseName: "巨嘴鳥"
  - Id: 2074
    Name: "小綠人"
    JapaneseName: "小綠人"
  - Id: 2075
    Name: "狩獵者"
    JapaneseName: "狩獵者"
  - Id: 2076
    Name: "欺騙的影子"
    JapaneseName: "欺騙的影子"
  - Id: 2077
    Name: "幻象的影子"
    JapaneseName: "幻象的影子"
  - Id: 2078
    Name: "歡樂的影子"
    JapaneseName: "歡樂的影子"
  - Id: 2079
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 2080
    Name: "天使彩蛋"
    JapaneseName: "天使彩蛋"
  - Id: 2081
    Name: "變異海葵"
    JapaneseName: "變異海葵"
  - Id: 2082
    Name: "食人魚"
    JapaneseName: "食人魚"
  - Id: 2083
    Name: "獨角甲蟲"
    JapaneseName: "獨角甲蟲"
  - Id: 2084
    Name: "雙角甲蟲"
    JapaneseName: "雙角甲蟲"
  - Id: 2085
    Name: "鹿角甲蟲"
    JapaneseName: "鹿角甲蟲"
  - Id: 2086
    Name: "尖角甲蟲"
    JapaneseName: "尖角甲蟲"
  - Id: 2087
    Name: "女王甲蟲"
    JapaneseName: "女王甲蟲"
  - Id: 2088
    Name: "獨角甲蟲卵"
    JapaneseName: "獨角甲蟲卵"
  - Id: 2089
    Name: "雙角甲蟲卵"
    JapaneseName: "雙角甲蟲卵"
  - Id: 2090
    Name: "鹿角甲蟲卵"
    JapaneseName: "鹿角甲蟲卵"
  - Id: 2091
    Name: "尖角甲蟲卵"
    JapaneseName: "尖角甲蟲卵"
  - Id: 2092
    Name: "狡蛛"
    JapaneseName: "狡蛛"
  - Id: 2093
    Name: "布達林"
    JapaneseName: "布達林"
  - Id: 2094
    Name: "獸人英雄"
    JapaneseName: "獸人英雄"
  - Id: 2095
    Name: "虎王"
    JapaneseName: "虎王"
  - Id: 2096
    Name: "俄塞里斯"
    JapaneseName: "俄塞里斯"
  - Id: 2097
    Name: "德古拉男爵"
    JapaneseName: "德古拉男爵"
  - Id: 2098
    Name: "死靈"
    JapaneseName: "死靈"
  - Id: 2099
    Name: "蜂后"
    JapaneseName: "蜂后"
  - Id: 2100
    Name: "巴風特"
    JapaneseName: "巴風特"
  - Id: 2101
    Name: "死靈騎士"
    JapaneseName: "死靈騎士"
  - Id: 2102
    Name: "黑暗之王"
    JapaneseName: "黑暗之王"
  - Id: 2103
    Name: "寒冰龍"
    JapaneseName: "寒冰龍"
  - Id: 2104
    Name: "墨蛇君"
    JapaneseName: "墨蛇君"
  - Id: 2105
    Name: "烏龜將軍"
    JapaneseName: "烏龜將軍"
  - Id: 2106
    Name: "阿修羅機械戰士"
    JapaneseName: "阿修羅機械戰士"
  - Id: 2107
    Name: "墮落的大神官希"
    JapaneseName: "墮落的大神官希"
  - Id: 2108
    Name: "影魔"
    JapaneseName: "影魔"
  - Id: 2109
    Name: "蘭特克力斯"
    JapaneseName: "蘭特克力斯"
  - Id: 2110
    Name: "伊夫利特"
    JapaneseName: "伊夫利特"
  - Id: 2111
    Name: "闇●神工匠 哈沃"
    JapaneseName: "闇●神工匠 哈沃"
  - Id: 2112
    Name: "闇●騎士領主 賽"
    JapaneseName: "闇●騎士領主 賽"
  - Id: 2113
    Name: "闇●十字刺客 艾"
    JapaneseName: "闇●十字刺客 艾"
  - Id: 2126
    Name: "瘧蚊"
    JapaneseName: "瘧蚊"
  - Id: 2127
    Name: "蜂兵"
    JapaneseName: "蜂兵"
  - Id: 2128
    Name: "蜂兵"
    JapaneseName: "蜂兵"
  - Id: 2129
    Name: "魯修拉黃蜂"
    JapaneseName: "魯修拉黃蜂"
  - Id: 2130
    Name: "魯修拉黃蜂"
    JapaneseName: "魯修拉黃蜂"
  - Id: 2131
    Name: "殭屍龍"
    JapaneseName: "殭屍龍"
  - Id: 2132
    Name: "食人蜘蛛"
    JapaneseName: "食人蜘蛛"
  - Id: 2133
    Name: "瘋狂螳螂"
    JapaneseName: "瘋狂螳螂"
  - Id: 2134
    Name: "惡魔啄木鳥"
    JapaneseName: "惡魔啄木鳥"
  - Id: 2135
    Name: "突變常春藤"
    JapaneseName: "突變常春藤"
  - Id: 2136
    Name: "玩偶魔妖"
    JapaneseName: "玩偶魔妖"
  - Id: 2137
    Name: "異形毛毛怪"
    JapaneseName: "異形毛毛怪"
  - Id: 2138
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2139
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2140
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2141
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2142
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2143
    Name: "守護者記憶碎片("
    JapaneseName: "守護者記憶碎片("
  - Id: 2144
    Name: "鹿角甲蟲"
    JapaneseName: "鹿角甲蟲"
  - Id: 2145
    Name: "尖角甲蟲"
    JapaneseName: "尖角甲蟲"
  - Id: 2146
    Name: "尼德霍格的影子"
    JapaneseName: "尼德霍格的影子"
  - Id: 2147
    Name: "白草"
    JapaneseName: "白草"
  - Id: 2148
    Name: "藍草"
    JapaneseName: "藍草"
  - Id: 2149
    Name: "小野豬"
    JapaneseName: "小野豬"
  - Id: 2150
    Name: "西瓜"
    JapaneseName: "西瓜"
  - Id: 2151
    Name: "泰坦魔芋花"
    JapaneseName: "泰坦魔芋花"
  - Id: 2152
    Name: "科摩多龍"
    JapaneseName: "科摩多龍"
  - Id: 2153
    Name: "天堂鳥"
    JapaneseName: "天堂鳥"
  - Id: 2154
    Name: "巴拿斯帕堤"
    JapaneseName: "巴拿斯帕堤"
  - Id: 2155
    Name: "布托異竺"
    JapaneseName: "布托異竺"
  - Id: 2156
    Name: "讓特"
    JapaneseName: "讓特"
  - Id: 2157
    Name: "巴拿斯帕堤"
    JapaneseName: "巴拿斯帕堤"
  - Id: 2158
    Name: "蜂兵"
    JapaneseName: "蜂兵"
  - Id: 2159
    Name: "狂暴蜂兵"
    JapaneseName: "狂暴蜂兵"
  - Id: 2160
    Name: "魯修拉黃蜂"
    JapaneseName: "魯修拉黃蜂"
  - Id: 2161
    Name: "獨角甲蟲"
    JapaneseName: "獨角甲蟲"
  - Id: 2162
    Name: "雙角甲蟲 (噩夢)"
    JapaneseName: "雙角甲蟲 (噩夢)"
  - Id: 2163
    Name: "鹿角甲蟲"
    JapaneseName: "鹿角甲蟲"
  - Id: 2164
    Name: "尖角甲蟲"
    JapaneseName: "尖角甲蟲"
  - Id: 2165
    Name: "女王甲蟲"
    JapaneseName: "女王甲蟲"
  - Id: 2166
    Name: "獨角甲蟲卵"
    JapaneseName: "獨角甲蟲卵"
  - Id: 2167
    Name: "雙角甲蟲卵"
    JapaneseName: "雙角甲蟲卵"
  - Id: 2168
    Name: "鹿角甲蟲卵"
    JapaneseName: "鹿角甲蟲卵"
  - Id: 2169
    Name: "尖角甲蟲卵"
    JapaneseName: "尖角甲蟲卵"
  - Id: 2170
    Name: "黃金鹿角甲蟲"
    JapaneseName: "黃金鹿角甲蟲"
  - Id: 2171
    Name: "黃金尖角甲蟲"
    JapaneseName: "黃金尖角甲蟲"
  - Id: 2172
    Name: "黃金獨角甲蟲"
    JapaneseName: "黃金獨角甲蟲"
  - Id: 2173
    Name: "黃金雙角甲蟲"
    JapaneseName: "黃金雙角甲蟲"
  - Id: 2174
    Name: "遠古甲殼類"
    JapaneseName: "遠古甲殼類"
  - Id: 2175
    Name: "深海魷魚"
    JapaneseName: "深海魷魚"
  - Id: 2176
    Name: "深海大蟹"
    JapaneseName: "深海大蟹"
  - Id: 2177
    Name: "深海海螺"
    JapaneseName: "深海海螺"
  - Id: 2178
    Name: "深海貝殼"
    JapaneseName: "深海貝殼"
  - Id: 2179
    Name: "遠古庫克雷"
    JapaneseName: "遠古庫克雷"
  - Id: 2180
    Name: "遠古海神"
    JapaneseName: "遠古海神"
  - Id: 2181
    Name: "遠古異變魚"
    JapaneseName: "遠古異變魚"
  - Id: 2182
    Name: "遠古海馬"
    JapaneseName: "遠古海馬"
  - Id: 2183
    Name: "突變虎蜥人"
    JapaneseName: "突變虎蜥人"
  - Id: 2184
    Name: "深海人魚"
    JapaneseName: "深海人魚"
  - Id: 2185
    Name: "變形釣魚河童"
    JapaneseName: "變形釣魚河童"
  - Id: 2186
    Name: "古怪腔棘魚"
    JapaneseName: "古怪腔棘魚"
  - Id: 2187
    Name: "黑暗腔棘魚"
    JapaneseName: "黑暗腔棘魚"
  - Id: 2188
    Name: "怪異腔棘魚"
    JapaneseName: "怪異腔棘魚"
  - Id: 2189
    Name: "暴力腔棘魚"
    JapaneseName: "暴力腔棘魚"
  - Id: 2190
    Name: "變種腔棘魚"
    JapaneseName: "變種腔棘魚"
  - Id: 2191
    Name: "海草"
    JapaneseName: "海草"
  - Id: 2192
    Name: "章魚的小弟"
    JapaneseName: "章魚的小弟"
  - Id: 2193
    Name: "章魚腳"
    JapaneseName: "章魚腳"
  - Id: 2194
    Name: "邪惡章魚"
    JapaneseName: "邪惡章魚"
  - Id: 2195
    Name: "庫克雷"
    JapaneseName: "庫克雷"
  - Id: 2196
    Name: "海神"
    JapaneseName: "海神"
  - Id: 2197
    Name: "紅海星"
    JapaneseName: "紅海星"
  - Id: 2198
    Name: "大腳龍蝦"
    JapaneseName: "大腳龍蝦"
  - Id: 2199
    Name: "胖胖波利"
    JapaneseName: "胖胖波利"
  - Id: 2200
    Name: "泰尼"
    JapaneseName: "泰尼"
  - Id: 2201
    Name: "深海電鰻"
    JapaneseName: "深海電鰻"
  - Id: 2202
    Name: "魔鬼大烏賊"
    JapaneseName: "魔鬼大烏賊"
  - Id: 2203
    Name: "醬缸章魚"
    JapaneseName: "醬缸章魚"
  - Id: 2204
    Name: "賽杜拉"
    JapaneseName: "賽杜拉"
  - Id: 2206
    Name: "魔鬼大烏賊腳"
    JapaneseName: "魔鬼大烏賊腳"
  - Id: 2208
    Name: "野貓騎士"
    JapaneseName: "野貓騎士"
  - Id: 2209
    Name: "浮勒盜蟲"
    JapaneseName: "浮勒盜蟲"
  - Id: 2210
    Name: "聖誕節瘋兔"
    JapaneseName: "聖誕節瘋兔"
  - Id: 2211
    Name: "聖誕玩偶熊"
    JapaneseName: "聖誕玩偶熊"
  - Id: 2212
    Name: "冰暴騎士"
    JapaneseName: "冰暴騎士"
  - Id: 2213
    Name: "邪骸浪人"
    JapaneseName: "邪骸浪人"
  - Id: 2214
    Name: "妖仙女"
    JapaneseName: "妖仙女"
  - Id: 2215
    Name: "不死鳥"
    JapaneseName: "不死鳥"
  - Id: 2216
    Name: "熔巖蜥蜴"
    JapaneseName: "熔巖蜥蜴"
  - Id: 2217
    Name: "玩偶熊"
    JapaneseName: "玩偶熊"
  - Id: 2218
    Name: "章魚腳"
    JapaneseName: "章魚腳"
  - Id: 2219
    Name: "邪惡章魚"
    JapaneseName: "邪惡章魚"
  - Id: 2220
    Name: "惡魔的使者"
    JapaneseName: "惡魔的使者"
  - Id: 2221
    Name: "闇●聖殿十字軍"
    JapaneseName: "闇●聖殿十字軍"
  - Id: 2222
    Name: "闇●創造者"
    JapaneseName: "闇●創造者"
  - Id: 2223
    Name: "闇●智者"
    JapaneseName: "闇●智者"
  - Id: 2224
    Name: "闇●武術宗師"
    JapaneseName: "闇●武術宗師"
  - Id: 2225
    Name: "闇●神行太保"
    JapaneseName: "闇●神行太保"
  - Id: 2226
    Name: "闇●搞笑藝人"
    JapaneseName: "闇●搞笑藝人"
  - Id: 2227
    Name: "闇●冷豔舞姬"
    JapaneseName: "闇●冷豔舞姬"
  - Id: 2228
    Name: "聖殿十字軍 蘭達"
    JapaneseName: "聖殿十字軍 蘭達"
  - Id: 2229
    Name: "創造者 普拉"
    JapaneseName: "創造者 普拉"
  - Id: 2230
    Name: "智者 西里亞"
    JapaneseName: "智者 西里亞"
  - Id: 2231
    Name: "武術宗師 陳理歐"
    JapaneseName: "武術宗師 陳理歐"
  - Id: 2232
    Name: "神行太保 科迪"
    JapaneseName: "神行太保 科迪"
  - Id: 2233
    Name: "搞笑藝人 雅歐帕"
    JapaneseName: "搞笑藝人 雅歐帕"
  - Id: 2234
    Name: "冷豔舞姬 特蘭提"
    JapaneseName: "冷豔舞姬 特蘭提"
  - Id: 2235
    Name: "闇●聖殿十字軍 "
    JapaneseName: "闇●聖殿十字軍 "
  - Id: 2236
    Name: "闇●創造者 普拉"
    JapaneseName: "闇●創造者 普拉"
  - Id: 2237
    Name: "闇●智者 西里亞"
    JapaneseName: "闇●智者 西里亞"
  - Id: 2238
    Name: "闇●武術宗師 陳"
    JapaneseName: "闇●武術宗師 陳"
  - Id: 2239
    Name: "闇●神行太保 科"
    JapaneseName: "闇●神行太保 科"
  - Id: 2240
    Name: "闇●搞笑藝人 雅"
    JapaneseName: "闇●搞笑藝人 雅"
  - Id: 2241
    Name: "闇●冷豔舞姬 特"
    JapaneseName: "闇●冷豔舞姬 特"
  - Id: 2242
    Name: "餓壞了的實驗動"
    JapaneseName: "餓壞了的實驗動"
  - Id: 2243
    Name: "飢餓了的實驗動"
    JapaneseName: "飢餓了的實驗動"
  - Id: 2244
    Name: "闇●武術宗師"
    JapaneseName: "闇●武術宗師"
  - Id: 2245
    Name: "經驗測試"
    JapaneseName: "經驗測試"
  - Id: 2246
    Name: "伍坦戰士"
    JapaneseName: "伍坦戰士"
  - Id: 2247
    Name: "米糕"
    JapaneseName: "米糕"
  - Id: 2248
    Name: "黃金波利"
    JapaneseName: "黃金波利"
  - Id: 2249
    Name: "淘汰者傅立葉"
    JapaneseName: "淘汰者傅立葉"
  - Id: 2250
    Name: "女戰士蘿拉"
    JapaneseName: "女戰士蘿拉"
  - Id: 2251
    Name: "喬伊亞"
    JapaneseName: "喬伊亞"
  - Id: 2252
    Name: "埃維亞"
    JapaneseName: "埃維亞"
  - Id: 2253
    Name: "將軍大賢"
    JapaneseName: "將軍大賢"
  - Id: 2254
    Name: "衛士小賢"
    JapaneseName: "衛士小賢"
  - Id: 2255
    Name: "亡靈的守護者卡"
    JapaneseName: "亡靈的守護者卡"
  - Id: 2256
    Name: "魯盜"
    JapaneseName: "魯盜"
  - Id: 2257
    Name: "碧亞玫特"
    JapaneseName: "碧亞玫特"
  - Id: 2258
    Name: "碧亞玫特"
    JapaneseName: "碧亞玫特"
  - Id: 2259
    Name: "花園守衛"
    JapaneseName: "花園守衛"
  - Id: 2260
    Name: "花園守衛"
    JapaneseName: "花園守衛"
  - Id: 2261
    Name: "花園看守者"
    JapaneseName: "花園看守者"
  - Id: 2262
    Name: "花園看守者"
    JapaneseName: "花園看守者"
  - Id: 2263
    Name: "祈望女神"
    JapaneseName: "祈望女神"
  - Id: 2264
    Name: "闇●商人"
    JapaneseName: "闇●商人"
  - Id: 2265
    Name: "闇●商人"
    JapaneseName: "闇●商人"
  - Id: 2266
    Name: "闇●服事"
    JapaneseName: "闇●服事"
  - Id: 2267
    Name: "闇●服事"
    JapaneseName: "闇●服事"
  - Id: 2268
    Name: "闇●弓箭手"
    JapaneseName: "闇●弓箭手"
  - Id: 2269
    Name: "闇●弓箭手"
    JapaneseName: "闇●弓箭手"
  - Id: 2270
    Name: "闇●魔法師"
    JapaneseName: "闇●魔法師"
  - Id: 2271
    Name: "闇●魔法師"
    JapaneseName: "闇●魔法師"
  - Id: 2272
    Name: "闇●盜賊"
    JapaneseName: "闇●盜賊"
  - Id: 2273
    Name: "闇●盜賊"
    JapaneseName: "闇●盜賊"
  - Id: 2274
    Name: "闇●劍士"
    JapaneseName: "闇●劍士"
  - Id: 2275
    Name: "闇●劍士"
    JapaneseName: "闇●劍士"
  - Id: 2276
    Name: "死靈"
    JapaneseName: "死靈"
  - Id: 2277
    Name: "女戰士羅拉"
    JapaneseName: "女戰士羅拉"
  - Id: 2278
    Name: "埃維亞"
    JapaneseName: "埃維亞"
  - Id: 2279
    Name: "衛士小賢"
    JapaneseName: "衛士小賢"
  - Id: 2280
    Name: "魯盜"
    JapaneseName: "魯盜"
  - Id: 2281
    Name: "深淵魔影"
    JapaneseName: "深淵魔影"
  - Id: 2282
    Name: "深淵魔影"
    JapaneseName: "深淵魔影"
  - Id: 2283
    Name: "深淵暗黑祭司"
    JapaneseName: "深淵暗黑祭司"
  - Id: 2284
    Name: "深淵大斧犬妖"
    JapaneseName: "深淵大斧犬妖"
  - Id: 2285
    Name: "深淵犬妖"
    JapaneseName: "深淵犬妖"
  - Id: 2286
    Name: "深淵刺垂犬妖"
    JapaneseName: "深淵刺垂犬妖"
  - Id: 2287
    Name: "深淵犬妖弓箭手"
    JapaneseName: "深淵犬妖弓箭手"
  - Id: 2288
    Name: "瘋狂寶箱"
    JapaneseName: "瘋狂寶箱"
  - Id: 2289
    Name: "綠棉蟲"
    JapaneseName: "綠棉蟲"
  - Id: 2290
    Name: "盜蟲卵"
    JapaneseName: "盜蟲卵"
  - Id: 2291
    Name: "蜂兵"
    JapaneseName: "蜂兵"
  - Id: 2292
    Name: "鍬形蟲"
    JapaneseName: "鍬形蟲"
  - Id: 2293
    Name: "巨象甲蟲"
    JapaneseName: "巨象甲蟲"
  - Id: 2294
    Name: "艾吉歐蜈蚣"
    JapaneseName: "艾吉歐蜈蚣"
  - Id: 2295
    Name: "狂暴蜘蛛"
    JapaneseName: "狂暴蜘蛛"
  - Id: 2296
    Name: "狂暴螳螂"
    JapaneseName: "狂暴螳螂"
  - Id: 2297
    Name: "狂暴蜂兵"
    JapaneseName: "狂暴蜂兵"
  - Id: 2298
    Name: "刺尾蜻蜓"
    JapaneseName: "刺尾蜻蜓"
  - Id: 2299
    Name: "瓢蟲"
    JapaneseName: "瓢蟲"
  - Id: 2300
    Name: "蒼蠅"
    JapaneseName: "蒼蠅"
  - Id: 2301
    Name: "綠蒼蠅"
    JapaneseName: "綠蒼蠅"
  - Id: 2302
    Name: "赤蒼蠅"
    JapaneseName: "赤蒼蠅"
  - Id: 2303
    Name: "蟻后"
    JapaneseName: "蟻后"
  - Id: 2304
    Name: "黃金女王甲蟲"
    JapaneseName: "黃金女王甲蟲"
  - Id: 2305
    Name: "溫古力安特"
    JapaneseName: "溫古力安特"
  - Id: 2306
    Name: "黃金蟲"
    JapaneseName: "黃金蟲"
  - Id: 2307
    Name: "蜂后"
    JapaneseName: "蜂后"
  - Id: 2308
    Name: "閃楓"
    JapaneseName: "閃楓"
  - Id: 2309
    Name: "獨眼怪"
    JapaneseName: "獨眼怪"
  - Id: 2310
    Name: "昂坎圖"
    JapaneseName: "昂坎圖"
  - Id: 2311
    Name: "瑪那能革"
    JapaneseName: "瑪那能革"
  - Id: 2312
    Name: "猛酷巫師"
    JapaneseName: "猛酷巫師"
  - Id: 2313
    Name: "邪魔馬"
    JapaneseName: "邪魔馬"
  - Id: 2314
    Name: "惡魔嬰兒"
    JapaneseName: "惡魔嬰兒"
  - Id: 2315
    Name: "食屍鬼"
    JapaneseName: "食屍鬼"
  - Id: 2316
    Name: "食人波利"
    JapaneseName: "食人波利"
  - Id: 2317
    Name: "噩夢死神"
    JapaneseName: "噩夢死神"
  - Id: 2318
    Name: "噩夢死神"
    JapaneseName: "噩夢死神"
  - Id: 2319
    Name: "寶箱巨鱷"
    JapaneseName: "寶箱巨鱷"
  - Id: 2320
    Name: "巴庫暴龍"
    JapaneseName: "巴庫暴龍"
  - Id: 2321
    Name: "憤怒的巴庫暴龍"
    JapaneseName: "憤怒的巴庫暴龍"
  - Id: 2322
    Name: "月亮的巴庫暴龍"
    JapaneseName: "月亮的巴庫暴龍"
  - Id: 2323
    Name: "炸彈波利"
    JapaneseName: "炸彈波利"
  - Id: 2324
    Name: "梅納海葵"
    JapaneseName: "梅納海葵"
  - Id: 2325
    Name: "小巴風特"
    JapaneseName: "小巴風特"
  - Id: 2326
    Name: "啤酒企鵝"
    JapaneseName: "啤酒企鵝"
  - Id: 2327
    Name: "噩夢死神靈魂的"
    JapaneseName: "噩夢死神靈魂的"
  - Id: 2328
    Name: "銅鑼鼓"
    JapaneseName: "銅鑼鼓"
  - Id: 2329
    Name: "寶箱巨鱷的蛋"
    JapaneseName: "寶箱巨鱷的蛋"
  - Id: 2330
    Name: "寶箱巨鱷小兵"
    JapaneseName: "寶箱巨鱷小兵"
  - Id: 2331
    Name: "寶箱巨鱷海草"
    JapaneseName: "寶箱巨鱷海草"
  - Id: 2332
    Name: "寶箱巨鱷影子"
    JapaneseName: "寶箱巨鱷影子"
  - Id: 2333
    Name: "寶箱巨鱷弱點"
    JapaneseName: "寶箱巨鱷弱點"
  - Id: 2334
    Name: "食屍鬼"
    JapaneseName: "食屍鬼"
  - Id: 2335
    Name: "巴庫暴龍的遺物"
    JapaneseName: "巴庫暴龍的遺物"
  - Id: 2336
    Name: "多莫沃伊"
    JapaneseName: "多莫沃伊"
  - Id: 2337
    Name: "巴庫暴龍的意志"
    JapaneseName: "巴庫暴龍的意志"
  - Id: 2338
    Name: "噩夢醫院的魔豽"
    JapaneseName: "噩夢醫院的魔豽"
  - Id: 2339
    Name: "噩夢醫院的猛酷"
    JapaneseName: "噩夢醫院的猛酷"
  - Id: 2340
    Name: "惡魔嬰兒"
    JapaneseName: "惡魔嬰兒"
  - Id: 2341
    Name: "RWC Boss 2011"
    JapaneseName: "RWC Boss 2011"
  - Id: 2342
    Name: "赤焰小惡魔"
    JapaneseName: "赤焰小惡魔"
  - Id: 2343
    Name: "巴庫暴龍的意志"
    JapaneseName: "巴庫暴龍的意志"
  - Id: 2344
    Name: "祈望女神"
    JapaneseName: "祈望女神"
  - Id: 2345
    Name: "艾斯恩魔女"
    JapaneseName: "艾斯恩魔女"
  - Id: 2346
    Name: "寒冰龍"
    JapaneseName: "寒冰龍"
  - Id: 2347
    Name: "虎王"
    JapaneseName: "虎王"
  - Id: 2348
    Name: "狐仙"
    JapaneseName: "狐仙"
  - Id: 2349
    Name: "銀月魔女"
    JapaneseName: "銀月魔女"
  - Id: 2350
    Name: "塞杜拉"
    JapaneseName: "塞杜拉"
  - Id: 2351
    Name: "魔靈娃娃"
    JapaneseName: "魔靈娃娃"
  - Id: 2352
    Name: "RSX-0805"
    JapaneseName: "RSX-0805"
  - Id: 2353
    Name: "米洛斯-夢魘"
    JapaneseName: "米洛斯-夢魘"
  - Id: 2354
    Name: "木乃伊-夢魘"
    JapaneseName: "木乃伊-夢魘"
  - Id: 2355
    Name: "木乃伊犬-夢魘"
    JapaneseName: "木乃伊犬-夢魘"
  - Id: 2356
    Name: "邪惡箱-夢魘"
    JapaneseName: "邪惡箱-夢魘"
  - Id: 2357
    Name: "邪惡箱-夢魘"
    JapaneseName: "邪惡箱-夢魘"
  - Id: 2358
    Name: "捲甲蟲-夢魘"
    JapaneseName: "捲甲蟲-夢魘"
  - Id: 2359
    Name: "捲甲蟲-夢魘"
    JapaneseName: "捲甲蟲-夢魘"
  - Id: 2360
    Name: "狂爆木乃伊-夢魘"
    JapaneseName: "狂爆木乃伊-夢魘"
  - Id: 2361
    Name: "狂爆木乃伊-夢魘"
    JapaneseName: "狂爆木乃伊-夢魘"
  - Id: 2362
    Name: "古埃及王-夢魘"
    JapaneseName: "古埃及王-夢魘"
  - Id: 2363
    Name: "花妖精"
    JapaneseName: "花妖精"
  - Id: 2364
    Name: "花瓣怪蟲"
    JapaneseName: "花瓣怪蟲"
  - Id: 2365
    Name: "惡靈之霧"
    JapaneseName: "惡靈之霧"
  - Id: 2366
    Name: "古靈精怪書"
    JapaneseName: "古靈精怪書"
  - Id: 2367
    Name: "元素鬼火(藍)"
    JapaneseName: "元素鬼火(藍)"
  - Id: 2368
    Name: "元素鬼火(褐)"
    JapaneseName: "元素鬼火(褐)"
  - Id: 2369
    Name: "元素鬼火(紅)"
    JapaneseName: "元素鬼火(紅)"
  - Id: 2370
    Name: "元素鬼火(綠)"
    JapaneseName: "元素鬼火(綠)"
  - Id: 2371
    Name: "頑靈惡童"
    JapaneseName: "頑靈惡童"
  - Id: 2372
    Name: "土壤"
    JapaneseName: "土壤"
  - Id: 2373
    Name: "巖石"
    JapaneseName: "巖石"
  - Id: 2374
    Name: "灌木叢"
    JapaneseName: "灌木叢"
  - Id: 2375
    Name: "夢羅克分身"
    JapaneseName: "夢羅克分身"
  - Id: 2376
    Name: "夢羅克分身"
    JapaneseName: "夢羅克分身"
  - Id: 2377
    Name: "黃諾博斯"
    JapaneseName: "黃諾博斯"
  - Id: 2378
    Name: "鹿角甲蟲"
    JapaneseName: "鹿角甲蟲"
  - Id: 2379
    Name: "偷襪子的聖誕貍"
    JapaneseName: "偷襪子的聖誕貍"
  - Id: 2380
    Name: "偷禮物的聖誕貍"
    JapaneseName: "偷禮物的聖誕貍"
  - Id: 2398
    Name: "寶貝波利"
    JapaneseName: "寶貝波利"
  - Id: 2401
    Name: "波利"
    JapaneseName: "波利"
  - Id: 2402
    Name: "波波利"
    JapaneseName: "波波利"
  - Id: 2403
    Name: "波波利"
    JapaneseName: "波波利"
  - Id: 2404
    Name: "變異幽浮水母"
    JapaneseName: "變異幽浮水母"
  - Id: 2405
    Name: "石斧海盜骷髏"
    JapaneseName: "石斧海盜骷髏"
  - Id: 2406
    Name: "弱化的邪骸士兵"
    JapaneseName: "弱化的邪骸士兵"
  - Id: 2407
    Name: "蠻刀海盜骷髏"
    JapaneseName: "蠻刀海盜骷髏"
  - Id: 2408
    Name: "訓練用龍蛋Lv10"
    JapaneseName: "訓練用龍蛋Lv10"
  - Id: 2409
    Name: "訓練用龍蛋Lv50"
    JapaneseName: "訓練用龍蛋Lv50"
  - Id: 2410
    Name: "訓練用龍蛋Lv100"
    JapaneseName: "訓練用龍蛋Lv100"
  - Id: 2411
    Name: "訓練用龍蛋Lv150"
    JapaneseName: "訓練用龍蛋Lv150"
  - Id: 2413
    Name: "訓練用龍蛋火屬"
    JapaneseName: "訓練用龍蛋火屬"
  - Id: 2414
    Name: "落跑吧魔書"
    JapaneseName: "落跑吧魔書"
  - Id: 2415
    Name: "闇●騎士"
    JapaneseName: "闇●騎士"
  - Id: 2416
    Name: "闇●刺客"
    JapaneseName: "闇●刺客"
  - Id: 2417
    Name: "闇●鐵匠"
    JapaneseName: "闇●鐵匠"
  - Id: 2418
    Name: "闇●獵人"
    JapaneseName: "闇●獵人"
  - Id: 2419
    Name: "闇●巫師"
    JapaneseName: "闇●巫師"
  - Id: 2420
    Name: "闇●祭司"
    JapaneseName: "闇●祭司"
  - Id: 2421
    Name: "闇●十字軍"
    JapaneseName: "闇●十字軍"
  - Id: 2422
    Name: "闇●流氓"
    JapaneseName: "闇●流氓"
  - Id: 2423
    Name: "闇●煉金術師"
    JapaneseName: "闇●煉金術師"
  - Id: 2424
    Name: "闇●詩人"
    JapaneseName: "闇●詩人"
  - Id: 2425
    Name: "闇●舞孃"
    JapaneseName: "闇●舞孃"
  - Id: 2426
    Name: "闇●賢者"
    JapaneseName: "闇●賢者"
  - Id: 2427
    Name: "闇●武道家"
    JapaneseName: "闇●武道家"
  - Id: 2428
    Name: "闇●騎士"
    JapaneseName: "闇●騎士"
  - Id: 2429
    Name: "闇●刺客"
    JapaneseName: "闇●刺客"
  - Id: 2430
    Name: "闇●鐵匠"
    JapaneseName: "闇●鐵匠"
  - Id: 2431
    Name: "闇●獵人"
    JapaneseName: "闇●獵人"
  - Id: 2432
    Name: "闇●巫師"
    JapaneseName: "闇●巫師"
  - Id: 2433
    Name: "闇●祭司"
    JapaneseName: "闇●祭司"
  - Id: 2434
    Name: "闇●十字軍"
    JapaneseName: "闇●十字軍"
  - Id: 2435
    Name: "闇●流氓"
    JapaneseName: "闇●流氓"
  - Id: 2436
    Name: "闇●煉金術士"
    JapaneseName: "闇●煉金術士"
  - Id: 2437
    Name: "闇●詩人"
    JapaneseName: "闇●詩人"
  - Id: 2438
    Name: "闇●舞孃"
    JapaneseName: "闇●舞孃"
  - Id: 2439
    Name: "闇●賢者"
    JapaneseName: "闇●賢者"
  - Id: 2440
    Name: "闇●武道家"
    JapaneseName: "闇●武道家"
  - Id: 2441
    Name: "魔鬼孩子王"
    JapaneseName: "魔鬼孩子王"
  - Id: 2442
    Name: "魔鬼孩子王"
    JapaneseName: "魔鬼孩子王"
  - Id: 2443
    Name: "艾爾娜"
    JapaneseName: "艾爾娜"
  - Id: 2444
    Name: "古路娜"
    JapaneseName: "古路娜"
  - Id: 2445
    Name: "馬麗娜"
    JapaneseName: "馬麗娜"
  - Id: 2446
    Name: "艾澤拉"
    JapaneseName: "艾澤拉"
  - Id: 2447
    Name: "露奈"
    JapaneseName: "露奈"
  - Id: 2448
    Name: "茉琳"
    JapaneseName: "茉琳"
  - Id: 2449
    Name: "蘿莎蓮"
    JapaneseName: "蘿莎蓮"
  - Id: 2450
    Name: "盜賊波利"
    JapaneseName: "盜賊波利"
  - Id: 2451
    Name: "可疑的獸人嬰兒"
    JapaneseName: "可疑的獸人嬰兒"
  - Id: 2452
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2453
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2454
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2455
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2456
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2457
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2458
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2459
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2460
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2461
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2462
    Name: "寶物箱子"
    JapaneseName: "寶物箱子"
  - Id: 2464
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 2465
    Name: "惡靈"
    JapaneseName: "惡靈"
  - Id: 2466
    Name: "綠腐屍"
    JapaneseName: "綠腐屍"
  - Id: 2467
    Name: "捲甲蟲"
    JapaneseName: "捲甲蟲"
  - Id: 2468
    Name: "幽靈劍士"
    JapaneseName: "幽靈劍士"
  - Id: 2469
    Name: "四處徘徊的弓箭"
    JapaneseName: "四處徘徊的弓箭"
  - Id: 2470
    Name: "墮落的深淵騎士"
    JapaneseName: "墮落的深淵騎士"
  - Id: 2471
    Name: "怨念的卡利斯格"
    JapaneseName: "怨念的卡利斯格"
  - Id: 2472
    Name: "血腥騎士"
    JapaneseName: "血腥騎士"
  - Id: 2473
    Name: "毀滅的第1騎士團"
    JapaneseName: "毀滅的第1騎士團"
  - Id: 2474
    Name: "毀滅的第2騎士團"
    JapaneseName: "毀滅的第2騎士團"
  - Id: 2475
    Name: "墮落根莖"
    JapaneseName: "墮落根莖"
  - Id: 2476
    Name: "闇答萊屍"
    JapaneseName: "闇答萊屍"
  - Id: 2477
    Name: "孤魂怨靈"
    JapaneseName: "孤魂怨靈"
  - Id: 2478
    Name: "受詛咒書籍"
    JapaneseName: "受詛咒書籍"
  - Id: 2479
    Name: "受詛咒寶箱"
    JapaneseName: "受詛咒寶箱"
  - Id: 2480
    Name: "墮落神父"
    JapaneseName: "墮落神父"
  - Id: 2481
    Name: "守墓怨靈"
    JapaneseName: "守墓怨靈"
  - Id: 2482
    Name: "卡利斯格"
    JapaneseName: "卡利斯格"
  - Id: 2483
    Name: "惡夢之巴風特"
    JapaneseName: "惡夢之巴風特"
  - Id: 2484
    Name: "夢寐巴風特"
    JapaneseName: "夢寐巴風特"
  - Id: 2485
    Name: "惡夢之凱美拉"
    JapaneseName: "惡夢之凱美拉"
  - Id: 2495
    Name: "隱形怪物2"
    JapaneseName: "隱形怪物2"
  - Id: 2528
    Name: "驚駭森靈"
    JapaneseName: "驚駭森靈"
  - Id: 2529
    Name: "驚駭森靈皇后"
    JapaneseName: "驚駭森靈皇后"
  - Id: 2530
    Name: "黑暗驚駭森靈"
    JapaneseName: "黑暗驚駭森靈"
  - Id: 2531
    Name: "毒袋"
    JapaneseName: "毒袋"
  - Id: 2532
    Name: "驚駭森靈皇后"
    JapaneseName: "驚駭森靈皇后"
  - Id: 2533
    Name: "驚駭森靈皇后"
    JapaneseName: "驚駭森靈皇后"
  - Id: 2534
    Name: "驚駭森靈皇后"
    JapaneseName: "驚駭森靈皇后"
  - Id: 2535
    Name: "驚駭森靈皇后"
    JapaneseName: "驚駭森靈皇后"
  - Id: 2536
    Name: "隱形怪物3"
    JapaneseName: "隱形怪物3"
  - Id: 2537
    Name: "隱形怪物4"
    JapaneseName: "隱形怪物4"
  - Id: 2539
    Name: "隱形怪物5"
    JapaneseName: "隱形怪物5"
  - Id: 2540
    Name: "驚駭森靈卵"
    JapaneseName: "驚駭森靈卵"
  - Id: 2541
    Name: "驚駭森靈幼蟲"
    JapaneseName: "驚駭森靈幼蟲"
  - Id: 2542
    Name: "艾琳大長老"
    JapaneseName: "艾琳大長老"
  - Id: 2543
    Name: "斐揚警衛兵"
    JapaneseName: "斐揚警衛兵"
  - Id: 2544
    Name: "斐揚衛士"
    JapaneseName: "斐揚衛士"
  - Id: 2545
    Name: "溫馴的警犬"
    JapaneseName: "溫馴的警犬"
  - Id: 2546
    Name: "兇惡的警犬"
    JapaneseName: "兇惡的警犬"
  - Id: 2549
    Name: "雅樂西"
    JapaneseName: "雅樂西"
  - Id: 2550
    Name: "狄歐艾瑞默司"
    JapaneseName: "狄歐艾瑞默司"
  - Id: 2551
    Name: "吉分小偷"
    JapaneseName: "吉分小偷"
  - Id: 2552
    Name: "吉分鐵匠"
    JapaneseName: "吉分鐵匠"
  - Id: 2553
    Name: "生氣的吉芬流氓"
    JapaneseName: "生氣的吉芬流氓"
  - Id: 2554
    Name: "沛蒙"
    JapaneseName: "沛蒙"
  - Id: 2555
    Name: "奧樂德"
    JapaneseName: "奧樂德"
  - Id: 2556
    Name: "布魯德哈載"
    JapaneseName: "布魯德哈載"
  - Id: 2557
    Name: "庫洛雅庫瑪"
    JapaneseName: "庫洛雅庫瑪"
  - Id: 2558
    Name: "伊佛德斯"
    JapaneseName: "伊佛德斯"
  - Id: 2559
    Name: "萊采尼芮"
    JapaneseName: "萊采尼芮"
  - Id: 2560
    Name: "歐託莉柯"
    JapaneseName: "歐託莉柯"
  - Id: 2561
    Name: "朱朱"
    JapaneseName: "朱朱"
  - Id: 2562
    Name: "狄瓦伊"
    JapaneseName: "狄瓦伊"
  - Id: 2563
    Name: "培坎納比恩"
    JapaneseName: "培坎納比恩"
  - Id: 2564
    Name: "潘利爾"
    JapaneseName: "潘利爾"
  - Id: 2565
    Name: "艾爾馮斯"
    JapaneseName: "艾爾馮斯"
  - Id: 2566
    Name: "艾爾馮斯二世"
    JapaneseName: "艾爾馮斯二世"
  - Id: 2567
    Name: "吉芬鐵匠"
    JapaneseName: "吉芬鐵匠"
  - Id: 2568
    Name: "吉芬刺客"
    JapaneseName: "吉芬刺客"
  - Id: 2603
    Name: "迅捷屠殺腐屍"
    JapaneseName: "迅捷屠殺腐屍"
  - Id: 2604
    Name: "雄壯腐屍戰俘"
    JapaneseName: "雄壯腐屍戰俘"
  - Id: 2605
    Name: "菁英腐屍首領"
    JapaneseName: "菁英腐屍首領"
  - Id: 2606
    Name: "憤怒腐屍"
    JapaneseName: "憤怒腐屍"
  - Id: 2607
    Name: "狡猾扎古丹"
    JapaneseName: "狡猾扎古丹"
  - Id: 2608
    Name: "迅捷溜溜猴"
    JapaneseName: "迅捷溜溜猴"
  - Id: 2609
    Name: "雄壯溜溜猴"
    JapaneseName: "雄壯溜溜猴"
  - Id: 2610
    Name: "菁英森靈"
    JapaneseName: "菁英森靈"
  - Id: 2611
    Name: "憤怒伍坦戰士"
    JapaneseName: "憤怒伍坦戰士"
  - Id: 2612
    Name: "狡猾樹林哥布靈"
    JapaneseName: "狡猾樹林哥布靈"
  - Id: 2613
    Name: "迅捷狼"
    JapaneseName: "迅捷狼"
  - Id: 2614
    Name: "雄壯風魔巫師"
    JapaneseName: "雄壯風魔巫師"
  - Id: 2615
    Name: "菁英樹精"
    JapaneseName: "菁英樹精"
  - Id: 2616
    Name: "憤怒狂暴野貓"
    JapaneseName: "憤怒狂暴野貓"
  - Id: 2617
    Name: "狡猾妖仙女"
    JapaneseName: "狡猾妖仙女"
  - Id: 2618
    Name: "雄壯白幽靈"
    JapaneseName: "雄壯白幽靈"
  - Id: 2619
    Name: "菁英石斧海盜骷"
    JapaneseName: "菁英石斧海盜骷"
  - Id: 2620
    Name: "憤怒邪骸浪人"
    JapaneseName: "憤怒邪骸浪人"
  - Id: 2621
    Name: "狡猾薇歐莉"
    JapaneseName: "狡猾薇歐莉"
  - Id: 2622
    Name: "迅捷薇歐莉"
    JapaneseName: "迅捷薇歐莉"
  - Id: 2623
    Name: "雄壯薇歐莉"
    JapaneseName: "雄壯薇歐莉"
  - Id: 2624
    Name: "菁英毒液魔"
    JapaneseName: "菁英毒液魔"
  - Id: 2625
    Name: "憤怒褐凡娜圖"
    JapaneseName: "憤怒褐凡娜圖"
  - Id: 2626
    Name: "狡猾芭芭亞卡"
    JapaneseName: "狡猾芭芭亞卡"
  - Id: 2627
    Name: "迅捷潘貝勒克"
    JapaneseName: "迅捷潘貝勒克"
  - Id: 2628
    Name: "雄壯螃蟹"
    JapaneseName: "雄壯螃蟹"
  - Id: 2629
    Name: "菁英溫古力安特"
    JapaneseName: "菁英溫古力安特"
  - Id: 2630
    Name: "憤怒巨嘴鳥"
    JapaneseName: "憤怒巨嘴鳥"
  - Id: 2631
    Name: "狡猾惡魔嬰兒"
    JapaneseName: "狡猾惡魔嬰兒"
  - Id: 2632
    Name: "雄壯盜蟲"
    JapaneseName: "雄壯盜蟲"
  - Id: 2633
    Name: "菁英盜蟲"
    JapaneseName: "菁英盜蟲"
  - Id: 2634
    Name: "憤怒盜蟲"
    JapaneseName: "憤怒盜蟲"
  - Id: 2635
    Name: "狡猾突變蛙"
    JapaneseName: "狡猾突變蛙"
  - Id: 2636
    Name: "迅捷玩偶熊"
    JapaneseName: "迅捷玩偶熊"
  - Id: 2637
    Name: "雄壯塔塔丘"
    JapaneseName: "雄壯塔塔丘"
  - Id: 2638
    Name: "菁英白鼠"
    JapaneseName: "菁英白鼠"
  - Id: 2639
    Name: "憤怒塔嚕安"
    JapaneseName: "憤怒塔嚕安"
  - Id: 2640
    Name: "狡猾史汀"
    JapaneseName: "狡猾史汀"
  - Id: 2641
    Name: "迅捷灰森靈"
    JapaneseName: "迅捷灰森靈"
  - Id: 2642
    Name: "雄壯綠蒼蠅"
    JapaneseName: "雄壯綠蒼蠅"
  - Id: 2643
    Name: "菁英石頭波利"
    JapaneseName: "菁英石頭波利"
  - Id: 2644
    Name: "憤怒鐘乳巨石怪"
    JapaneseName: "憤怒鐘乳巨石怪"
  - Id: 2645
    Name: "狡猾瓢蟲"
    JapaneseName: "狡猾瓢蟲"
  - Id: 2646
    Name: "迅捷魔菇"
    JapaneseName: "迅捷魔菇"
  - Id: 2647
    Name: "雄壯岩石龜"
    JapaneseName: "雄壯岩石龜"
  - Id: 2648
    Name: "菁英邪骸士兵"
    JapaneseName: "菁英邪骸士兵"
  - Id: 2649
    Name: "憤怒邪骸士兵"
    JapaneseName: "憤怒邪骸士兵"
  - Id: 2650
    Name: "狡猾慰勞者"
    JapaneseName: "狡猾慰勞者"
  - Id: 2651
    Name: "迅捷鬼女"
    JapaneseName: "迅捷鬼女"
  - Id: 2652
    Name: "雄壯雪獸"
    JapaneseName: "雄壯雪獸"
  - Id: 2653
    Name: "菁英青蛇"
    JapaneseName: "菁英青蛇"
  - Id: 2654
    Name: "憤怒貍貓"
    JapaneseName: "憤怒貍貓"
  - Id: 2655
    Name: "狡猾沙妖"
    JapaneseName: "狡猾沙妖"
  - Id: 2656
    Name: "迅捷沙妖"
    JapaneseName: "迅捷沙妖"
  - Id: 2657
    Name: "雄壯皮影魔"
    JapaneseName: "雄壯皮影魔"
  - Id: 2658
    Name: "菁英邪骸戰士長"
    JapaneseName: "菁英邪骸戰士長"
  - Id: 2659
    Name: "憤怒邪骸戰士長"
    JapaneseName: "憤怒邪骸戰士長"
  - Id: 2660
    Name: "狡猾邪骸礦工"
    JapaneseName: "狡猾邪骸礦工"
  - Id: 2661
    Name: "迅捷小雪獸"
    JapaneseName: "迅捷小雪獸"
  - Id: 2662
    Name: "雄壯黑蛇"
    JapaneseName: "雄壯黑蛇"
  - Id: 2663
    Name: "菁英黑蛇"
    JapaneseName: "菁英黑蛇"
  - Id: 2664
    Name: "憤怒火忍西怒畢"
    JapaneseName: "憤怒火忍西怒畢"
  - Id: 2665
    Name: "狡猾安息者"
    JapaneseName: "狡猾安息者"
  - Id: 2666
    Name: "迅捷貝殼魔靈"
    JapaneseName: "迅捷貝殼魔靈"
  - Id: 2667
    Name: "雄壯闇●神射手"
    JapaneseName: "雄壯闇●神射手"
  - Id: 2668
    Name: "菁英海獺"
    JapaneseName: "菁英海獺"
  - Id: 2669
    Name: "憤怒賽杜拉"
    JapaneseName: "憤怒賽杜拉"
  - Id: 2670
    Name: "狡猾蠍子"
    JapaneseName: "狡猾蠍子"
  - Id: 2671
    Name: "迅捷小野豬"
    JapaneseName: "迅捷小野豬"
  - Id: 2672
    Name: "雄壯野豬"
    JapaneseName: "雄壯野豬"
  - Id: 2673
    Name: "菁英野豬"
    JapaneseName: "菁英野豬"
  - Id: 2674
    Name: "憤怒泥人"
    JapaneseName: "憤怒泥人"
  - Id: 2675
    Name: "狡猾火蜥蝪"
    JapaneseName: "狡猾火蜥蝪"
  - Id: 2676
    Name: "迅捷蠻刀海盜骷"
    JapaneseName: "迅捷蠻刀海盜骷"
  - Id: 2677
    Name: "雄壯土狼"
    JapaneseName: "雄壯土狼"
  - Id: 2678
    Name: "菁英羅達蛙"
    JapaneseName: "菁英羅達蛙"
  - Id: 2679
    Name: "憤怒羅達蛙"
    JapaneseName: "憤怒羅達蛙"
  - Id: 2680
    Name: "狡猾搖滾蝗蟲"
    JapaneseName: "狡猾搖滾蝗蟲"
  - Id: 2681
    Name: "迅捷飛行魔書"
    JapaneseName: "迅捷飛行魔書"
  - Id: 2682
    Name: "雄壯飛行魔書"
    JapaneseName: "雄壯飛行魔書"
  - Id: 2683
    Name: "菁英元宵童子"
    JapaneseName: "菁英元宵童子"
  - Id: 2684
    Name: "憤怒代行刑者"
    JapaneseName: "憤怒代行刑者"
  - Id: 2685
    Name: "狡猾代行刑者"
    JapaneseName: "狡猾代行刑者"
  - Id: 2686
    Name: "迅捷代行刑者"
    JapaneseName: "迅捷代行刑者"
  - Id: 2687
    Name: "雄壯諾可伊"
    JapaneseName: "雄壯諾可伊"
  - Id: 2688
    Name: "菁英消防魔"
    JapaneseName: "菁英消防魔"
  - Id: 2689
    Name: "狡猾紅海星"
    JapaneseName: "狡猾紅海星"
  - Id: 2690
    Name: "迅捷幽靈劍士"
    JapaneseName: "迅捷幽靈劍士"
  - Id: 2691
    Name: "雄壯幽靈劍士"
    JapaneseName: "雄壯幽靈劍士"
  - Id: 2692
    Name: "菁英闇●魔法師"
    JapaneseName: "菁英闇●魔法師"
  - Id: 2693
    Name: "憤怒尖角甲蟲"
    JapaneseName: "憤怒尖角甲蟲"
  - Id: 2694
    Name: "狡猾奈吉鳥"
    JapaneseName: "狡猾奈吉鳥"
  - Id: 2695
    Name: "迅捷草精"
    JapaneseName: "迅捷草精"
  - Id: 2696
    Name: "菁英波利"
    JapaneseName: "菁英波利"
  - Id: 2697
    Name: "憤怒波利"
    JapaneseName: "憤怒波利"
  - Id: 2698
    Name: "狡猾波利"
    JapaneseName: "狡猾波利"
  - Id: 2699
    Name: "迅捷波利"
    JapaneseName: "迅捷波利"
  - Id: 2700
    Name: "雄壯三葉鐵甲蟲"
    JapaneseName: "雄壯三葉鐵甲蟲"
  - Id: 2701
    Name: "菁英波波利"
    JapaneseName: "菁英波波利"
  - Id: 2702
    Name: "憤怒波波利"
    JapaneseName: "憤怒波波利"
  - Id: 2703
    Name: "狡猾波波利"
    JapaneseName: "狡猾波波利"
  - Id: 2704
    Name: "迅捷牛蛙"
    JapaneseName: "迅捷牛蛙"
  - Id: 2705
    Name: "雄壯毒魔菇"
    JapaneseName: "雄壯毒魔菇"
  - Id: 2706
    Name: "菁英黃色等離子"
    JapaneseName: "菁英黃色等離子"
  - Id: 2707
    Name: "憤怒漂浮蟲"
    JapaneseName: "憤怒漂浮蟲"
  - Id: 2708
    Name: "狡猾礦工魔"
    JapaneseName: "狡猾礦工魔"
  - Id: 2709
    Name: "迅捷食人魚"
    JapaneseName: "迅捷食人魚"
  - Id: 2710
    Name: "雄壯黑暗捕蟲堇"
    JapaneseName: "雄壯黑暗捕蟲堇"
  - Id: 2711
    Name: "菁英捕蟲堇妖"
    JapaneseName: "菁英捕蟲堇妖"
  - Id: 2712
    Name: "憤怒小雞"
    JapaneseName: "憤怒小雞"
  - Id: 2713
    Name: "狡猾劍魚"
    JapaneseName: "狡猾劍魚"
  - Id: 2714
    Name: "迅捷畢帝特地龍"
    JapaneseName: "迅捷畢帝特地龍"
  - Id: 2715
    Name: "雄壯畢帝特地龍"
    JapaneseName: "雄壯畢帝特地龍"
  - Id: 2716
    Name: "菁英梅納海葵"
    JapaneseName: "菁英梅納海葵"
  - Id: 2717
    Name: "憤怒梅納海葵"
    JapaneseName: "憤怒梅納海葵"
  - Id: 2718
    Name: "狡猾大嘴鳥"
    JapaneseName: "狡猾大嘴鳥"
  - Id: 2719
    Name: "迅捷帕莎納"
    JapaneseName: "迅捷帕莎納"
  - Id: 2720
    Name: "雄壯苗娃佩瑞絲"
    JapaneseName: "雄壯苗娃佩瑞絲"
  - Id: 2721
    Name: "菁英鴞裊首領"
    JapaneseName: "菁英鴞裊首領"
  - Id: 2722
    Name: "憤怒獸人戰士"
    JapaneseName: "憤怒獸人戰士"
  - Id: 2723
    Name: "狡猾獸人腐屍"
    JapaneseName: "狡猾獸人腐屍"
  - Id: 2724
    Name: "迅捷邪骸獸人"
    JapaneseName: "迅捷邪骸獸人"
  - Id: 2725
    Name: "雄壯獸人女戰士"
    JapaneseName: "雄壯獸人女戰士"
  - Id: 2726
    Name: "菁英監視者"
    JapaneseName: "菁英監視者"
  - Id: 2727
    Name: "憤怒廢氣魔"
    JapaneseName: "憤怒廢氣魔"
  - Id: 2728
    Name: "狡猾諾博斯"
    JapaneseName: "狡猾諾博斯"
  - Id: 2729
    Name: "迅捷諾博斯"
    JapaneseName: "迅捷諾博斯"
  - Id: 2730
    Name: "雄壯諾博斯"
    JapaneseName: "雄壯諾博斯"
  - Id: 2731
    Name: "菁英諾博斯"
    JapaneseName: "菁英諾博斯"
  - Id: 2732
    Name: "憤怒七彩夢魘"
    JapaneseName: "憤怒七彩夢魘"
  - Id: 2733
    Name: "狡猾守墓怨靈"
    JapaneseName: "狡猾守墓怨靈"
  - Id: 2734
    Name: "迅捷孤魂怨靈"
    JapaneseName: "迅捷孤魂怨靈"
  - Id: 2735
    Name: "雄壯豬籠草"
    JapaneseName: "雄壯豬籠草"
  - Id: 2736
    Name: "菁英行妖術者"
    JapaneseName: "菁英行妖術者"
  - Id: 2737
    Name: "憤怒邪惡禮盒"
    JapaneseName: "憤怒邪惡禮盒"
  - Id: 2738
    Name: "狡猾吃人草"
    JapaneseName: "狡猾吃人草"
  - Id: 2739
    Name: "迅捷木乃伊"
    JapaneseName: "迅捷木乃伊"
  - Id: 2740
    Name: "雄壯木乃伊"
    JapaneseName: "雄壯木乃伊"
  - Id: 2741
    Name: "菁英摩卡"
    JapaneseName: "菁英摩卡"
  - Id: 2742
    Name: "憤怒夢羅克門徒"
    JapaneseName: "憤怒夢羅克門徒"
  - Id: 2743
    Name: "狡猾夢羅克門徒"
    JapaneseName: "狡猾夢羅克門徒"
  - Id: 2744
    Name: "迅捷夢羅克門徒"
    JapaneseName: "迅捷夢羅克門徒"
  - Id: 2745
    Name: "雄壯摩爾"
    JapaneseName: "雄壯摩爾"
  - Id: 2746
    Name: "菁英米雅畢"
    JapaneseName: "菁英米雅畢"
  - Id: 2747
    Name: "憤怒米洛斯"
    JapaneseName: "憤怒米洛斯"
  - Id: 2748
    Name: "狡猾米洛斯"
    JapaneseName: "狡猾米洛斯"
  - Id: 2749
    Name: "迅捷米洛斯"
    JapaneseName: "迅捷米洛斯"
  - Id: 2750
    Name: "雄壯礦石魔"
    JapaneseName: "雄壯礦石魔"
  - Id: 2751
    Name: "菁英異形毛毛怪"
    JapaneseName: "菁英異形毛毛怪"
  - Id: 2752
    Name: "憤怒邪惡箱"
    JapaneseName: "憤怒邪惡箱"
  - Id: 2753
    Name: "狡猾邪惡箱"
    JapaneseName: "狡猾邪惡箱"
  - Id: 2754
    Name: "迅捷重金屬蝗蟲"
    JapaneseName: "迅捷重金屬蝗蟲"
  - Id: 2755
    Name: "雄壯金屬波利"
    JapaneseName: "雄壯金屬波利"
  - Id: 2756
    Name: "菁英金屬波利"
    JapaneseName: "菁英金屬波利"
  - Id: 2757
    Name: "憤怒人魚士兵"
    JapaneseName: "憤怒人魚士兵"
  - Id: 2758
    Name: "狡猾花妖精"
    JapaneseName: "狡猾花妖精"
  - Id: 2759
    Name: "迅捷米杜沙"
    JapaneseName: "迅捷米杜沙"
  - Id: 2760
    Name: "雄壯土撥鼠"
    JapaneseName: "雄壯土撥鼠"
  - Id: 2761
    Name: "菁英傀儡娃娃"
    JapaneseName: "菁英傀儡娃娃"
  - Id: 2762
    Name: "憤怒冰波利"
    JapaneseName: "憤怒冰波利"
  - Id: 2763
    Name: "狡猾馬爾杜克"
    JapaneseName: "狡猾馬爾杜克"
  - Id: 2764
    Name: "迅捷螳螂"
    JapaneseName: "迅捷螳螂"
  - Id: 2765
    Name: "雄壯曼陀羅魔花"
    JapaneseName: "雄壯曼陀羅魔花"
  - Id: 2766
    Name: "菁英瑪那能革"
    JapaneseName: "菁英瑪那能革"
  - Id: 2767
    Name: "憤怒狂暴米諾斯"
    JapaneseName: "憤怒狂暴米諾斯"
  - Id: 2768
    Name: "狡猾魔鍋蛋"
    JapaneseName: "狡猾魔鍋蛋"
  - Id: 2769
    Name: "迅捷岩漿波利"
    JapaneseName: "迅捷岩漿波利"
  - Id: 2770
    Name: "雄壯瘋兔"
    JapaneseName: "雄壯瘋兔"
  - Id: 2771
    Name: "菁英瘋兔"
    JapaneseName: "菁英瘋兔"
  - Id: 2772
    Name: "憤怒南瓜魂"
    JapaneseName: "憤怒南瓜魂"
  - Id: 2773
    Name: "狡猾魯修拉黃蜂"
    JapaneseName: "狡猾魯修拉黃蜂"
  - Id: 2774
    Name: "迅捷銀月魔女"
    JapaneseName: "迅捷銀月魔女"
  - Id: 2775
    Name: "雄壯猴桃木"
    JapaneseName: "雄壯猴桃木"
  - Id: 2776
    Name: "菁英寶貝波利"
    JapaneseName: "菁英寶貝波利"
  - Id: 2777
    Name: "憤怒玩偶魔妖"
    JapaneseName: "憤怒玩偶魔妖"
  - Id: 2778
    Name: "狡猾豹皮怪"
    JapaneseName: "狡猾豹皮怪"
  - Id: 2779
    Name: "迅捷雷斯"
    JapaneseName: "迅捷雷斯"
  - Id: 2780
    Name: "雄壯狂暴大腳熊"
    JapaneseName: "雄壯狂暴大腳熊"
  - Id: 2781
    Name: "菁英群葉貓"
    JapaneseName: "菁英群葉貓"
  - Id: 2782
    Name: "憤怒闇●流氓"
    JapaneseName: "憤怒闇●流氓"
  - Id: 2783
    Name: "狡猾闇●刺客"
    JapaneseName: "狡猾闇●刺客"
  - Id: 2784
    Name: "迅捷犬妖弓箭手"
    JapaneseName: "迅捷犬妖弓箭手"
  - Id: 2785
    Name: "雄壯大斧犬妖"
    JapaneseName: "雄壯大斧犬妖"
  - Id: 2786
    Name: "菁英礦坑小精靈"
    JapaneseName: "菁英礦坑小精靈"
  - Id: 2787
    Name: "憤怒巨象甲蟲"
    JapaneseName: "憤怒巨象甲蟲"
  - Id: 2788
    Name: "狡猾火鳥"
    JapaneseName: "狡猾火鳥"
  - Id: 2789
    Name: "迅捷傘妖"
    JapaneseName: "迅捷傘妖"
  - Id: 2790
    Name: "雄壯蛇女伊絲"
    JapaneseName: "雄壯蛇女伊絲"
  - Id: 2791
    Name: "菁英伊西拉"
    JapaneseName: "菁英伊西拉"
  - Id: 2792
    Name: "憤怒邪惡使者"
    JapaneseName: "憤怒邪惡使者"
  - Id: 2793
    Name: "狡猾米糕"
    JapaneseName: "狡猾米糕"
  - Id: 2794
    Name: "迅捷冰巨人"
    JapaneseName: "迅捷冰巨人"
  - Id: 2795
    Name: "雄壯亞拉"
    JapaneseName: "雄壯亞拉"
  - Id: 2796
    Name: "菁英妖君"
    JapaneseName: "菁英妖君"
  - Id: 2797
    Name: "憤怒赤蒼蠅"
    JapaneseName: "憤怒赤蒼蠅"
  - Id: 2798
    Name: "狡猾蜂兵"
    JapaneseName: "狡猾蜂兵"
  - Id: 2799
    Name: "迅捷獨角甲蟲"
    JapaneseName: "迅捷獨角甲蟲"
  - Id: 2800
    Name: "雄壯鍬形蟲"
    JapaneseName: "雄壯鍬形蟲"
  - Id: 2801
    Name: "菁英異形"
    JapaneseName: "菁英異形"
  - Id: 2802
    Name: "憤怒蚯蚓"
    JapaneseName: "憤怒蚯蚓"
  - Id: 2803
    Name: "狡猾希爾士兵"
    JapaneseName: "狡猾希爾士兵"
  - Id: 2804
    Name: "迅捷希爾隊長"
    JapaneseName: "迅捷希爾隊長"
  - Id: 2805
    Name: "雄壯獸人戰士長"
    JapaneseName: "雄壯獸人戰士長"
  - Id: 2806
    Name: "菁英鳥人哈比"
    JapaneseName: "菁英鳥人哈比"
  - Id: 2807
    Name: "憤怒鳥人哈比"
    JapaneseName: "憤怒鳥人哈比"
  - Id: 2808
    Name: "狡猾綠變色龍"
    JapaneseName: "狡猾綠變色龍"
  - Id: 2809
    Name: "迅捷將軍魔碑"
    JapaneseName: "迅捷將軍魔碑"
  - Id: 2810
    Name: "雄壯七彩大嘴鳥"
    JapaneseName: "雄壯七彩大嘴鳥"
  - Id: 2811
    Name: "菁英七彩大嘴鳥"
    JapaneseName: "菁英七彩大嘴鳥"
  - Id: 2812
    Name: "憤怒巨石怪"
    JapaneseName: "憤怒巨石怪"
  - Id: 2813
    Name: "狡猾刺刀哥布靈"
    JapaneseName: "狡猾刺刀哥布靈"
  - Id: 2814
    Name: "迅捷刺刀哥布靈"
    JapaneseName: "迅捷刺刀哥布靈"
  - Id: 2815
    Name: "雄壯魔羌"
    JapaneseName: "雄壯魔羌"
  - Id: 2816
    Name: "菁英魔羌"
    JapaneseName: "菁英魔羌"
  - Id: 2817
    Name: "憤怒深淵犬妖"
    JapaneseName: "憤怒深淵犬妖"
  - Id: 2818
    Name: "狡猾深淵犬妖"
    JapaneseName: "狡猾深淵犬妖"
  - Id: 2819
    Name: "迅捷深淵魔影"
    JapaneseName: "迅捷深淵魔影"
  - Id: 2820
    Name: "雄壯深淵魔影"
    JapaneseName: "雄壯深淵魔影"
  - Id: 2821
    Name: "菁英狂暴蜂兵"
    JapaneseName: "菁英狂暴蜂兵"
  - Id: 2822
    Name: "憤怒綠腐屍"
    JapaneseName: "憤怒綠腐屍"
  - Id: 2823
    Name: "狡猾綠腐屍"
    JapaneseName: "狡猾綠腐屍"
  - Id: 2824
    Name: "迅捷邪惡向日葵"
    JapaneseName: "迅捷邪惡向日葵"
  - Id: 2825
    Name: "雄壯邪惡向日葵"
    JapaneseName: "雄壯邪惡向日葵"
  - Id: 2826
    Name: "菁英蝙蝠弓箭手"
    JapaneseName: "菁英蝙蝠弓箭手"
  - Id: 2827
    Name: "憤怒蝙蝠弓箭手"
    JapaneseName: "憤怒蝙蝠弓箭手"
  - Id: 2828
    Name: "狡猾迦利"
    JapaneseName: "狡猾迦利"
  - Id: 2829
    Name: "迅捷海豹寶寶"
    JapaneseName: "迅捷海豹寶寶"
  - Id: 2830
    Name: "雄壯水靈龜"
    JapaneseName: "雄壯水靈龜"
  - Id: 2831
    Name: "菁英水靈龜"
    JapaneseName: "菁英水靈龜"
  - Id: 2832
    Name: "憤怒綠貝勒斯"
    JapaneseName: "憤怒綠貝勒斯"
  - Id: 2833
    Name: "狡猾吸血蝙蝠"
    JapaneseName: "狡猾吸血蝙蝠"
  - Id: 2834
    Name: "迅捷偽天使"
    JapaneseName: "迅捷偽天使"
  - Id: 2835
    Name: "雄壯綠棉蟲"
    JapaneseName: "雄壯綠棉蟲"
  - Id: 2836
    Name: "菁英綠棉蟲"
    JapaneseName: "菁英綠棉蟲"
  - Id: 2837
    Name: "憤怒爆炎蝙蝠"
    JapaneseName: "憤怒爆炎蝙蝠"
  - Id: 2838
    Name: "狡猾闇神官"
    JapaneseName: "狡猾闇神官"
  - Id: 2839
    Name: "迅捷長老樹精"
    JapaneseName: "迅捷長老樹精"
  - Id: 2840
    Name: "雄壯長老樹精"
    JapaneseName: "雄壯長老樹精"
  - Id: 2841
    Name: "菁英埃奇歐"
    JapaneseName: "菁英埃奇歐"
  - Id: 2842
    Name: "憤怒獵蠅"
    JapaneseName: "憤怒獵蠅"
  - Id: 2843
    Name: "迅捷森林妖姬"
    JapaneseName: "迅捷森林妖姬"
  - Id: 2844
    Name: "雄壯捕蟲草"
    JapaneseName: "雄壯捕蟲草"
  - Id: 2845
    Name: "菁英土波利"
    JapaneseName: "菁英土波利"
  - Id: 2846
    Name: "憤怒爆鑽傘蜥"
    JapaneseName: "憤怒爆鑽傘蜥"
  - Id: 2847
    Name: "狡猾紅蝙蝠"
    JapaneseName: "狡猾紅蝙蝠"
  - Id: 2848
    Name: "迅捷刺尾蜻蜓"
    JapaneseName: "迅捷刺尾蜻蜓"
  - Id: 2849
    Name: "雄壯暴躁龍"
    JapaneseName: "雄壯暴躁龍"
  - Id: 2850
    Name: "菁英狡蛛"
    JapaneseName: "菁英狡蛛"
  - Id: 2851
    Name: "憤怒土人"
    JapaneseName: "憤怒土人"
  - Id: 2852
    Name: "狡猾假面鬼"
    JapaneseName: "狡猾假面鬼"
  - Id: 2853
    Name: "迅捷暴風迪靡克"
    JapaneseName: "迅捷暴風迪靡克"
  - Id: 2854
    Name: "雄壯小惡魔"
    JapaneseName: "雄壯小惡魔"
  - Id: 2855
    Name: "菁英沙漠之狼"
    JapaneseName: "菁英沙漠之狼"
  - Id: 2856
    Name: "憤怒沙漠之狼"
    JapaneseName: "憤怒沙漠之狼"
  - Id: 2857
    Name: "狡猾兵蟻"
    JapaneseName: "狡猾兵蟻"
  - Id: 2858
    Name: "迅捷死亡魔書"
    JapaneseName: "迅捷死亡魔書"
  - Id: 2859
    Name: "雄壯死亡魔書"
    JapaneseName: "雄壯死亡魔書"
  - Id: 2860
    Name: "菁英死亡魔書"
    JapaneseName: "菁英死亡魔書"
  - Id: 2861
    Name: "憤怒暗黑祭司"
    JapaneseName: "憤怒暗黑祭司"
  - Id: 2862
    Name: "狡猾舞獅"
    JapaneseName: "狡猾舞獅"
  - Id: 2863
    Name: "迅捷克瑞米"
    JapaneseName: "迅捷克瑞米"
  - Id: 2864
    Name: "雄壯卡那多斯"
    JapaneseName: "雄壯卡那多斯"
  - Id: 2865
    Name: "菁英甜餅人"
    JapaneseName: "菁英甜餅人"
  - Id: 2866
    Name: "憤怒恆量魔"
    JapaneseName: "憤怒恆量魔"
  - Id: 2867
    Name: "狡猾科摩多龍"
    JapaneseName: "狡猾科摩多龍"
  - Id: 2868
    Name: "迅捷松鼠"
    JapaneseName: "迅捷松鼠"
  - Id: 2869
    Name: "雄壯松鼠"
    JapaneseName: "雄壯松鼠"
  - Id: 2870
    Name: "菁英古鐘魔"
    JapaneseName: "菁英古鐘魔"
  - Id: 2871
    Name: "憤怒古鐘魔"
    JapaneseName: "憤怒古鐘魔"
  - Id: 2872
    Name: "狡猾蒼蠅"
    JapaneseName: "狡猾蒼蠅"
  - Id: 2873
    Name: "迅捷突變蜈蚣"
    JapaneseName: "迅捷突變蜈蚣"
  - Id: 2874
    Name: "雄壯惡靈之霧"
    JapaneseName: "雄壯惡靈之霧"
  - Id: 2875
    Name: "菁英闇●智者"
    JapaneseName: "菁英闇●智者"
  - Id: 2876
    Name: "憤怒狂暴綠棉蟲"
    JapaneseName: "憤怒狂暴綠棉蟲"
  - Id: 2877
    Name: "狡猾卡拉特小丑"
    JapaneseName: "狡猾卡拉特小丑"
  - Id: 2878
    Name: "迅捷刺蝟蟲"
    JapaneseName: "迅捷刺蝟蟲"
  - Id: 2879
    Name: "雄壯獨眼怪"
    JapaneseName: "雄壯獨眼怪"
  - Id: 2880
    Name: "菁英微風"
    JapaneseName: "菁英微風"
  - Id: 2881
    Name: "憤怒微風"
    JapaneseName: "憤怒微風"
  - Id: 2882
    Name: "狡猾鈽鐳巨人"
    JapaneseName: "狡猾鈽鐳巨人"
  - Id: 2883
    Name: "迅捷血蝴蝶"
    JapaneseName: "迅捷血蝴蝶"
  - Id: 2884
    Name: "菁英大腳熊"
    JapaneseName: "菁英大腳熊"
  - Id: 2885
    Name: "憤怒巫婆"
    JapaneseName: "憤怒巫婆"
  - Id: 2886
    Name: "狡猾愛爾蘭女妖"
    JapaneseName: "狡猾愛爾蘭女妖"
  - Id: 2887
    Name: "迅捷惡耗女妖"
    JapaneseName: "迅捷惡耗女妖"
  - Id: 2888
    Name: "雄壯巴拿斯帕堤"
    JapaneseName: "雄壯巴拿斯帕堤"
  - Id: 2889
    Name: "菁英風靈龜"
    JapaneseName: "菁英風靈龜"
  - Id: 2890
    Name: "憤怒艾斯蜘蛛"
    JapaneseName: "憤怒艾斯蜘蛛"
  - Id: 2891
    Name: "狡猾艾吉歐蜈蚣"
    JapaneseName: "狡猾艾吉歐蜈蚣"
  - Id: 2892
    Name: "迅捷艾吉歐蜈蚣"
    JapaneseName: "迅捷艾吉歐蜈蚣"
  - Id: 2893
    Name: "雄壯捲甲蟲"
    JapaneseName: "雄壯捲甲蟲"
  - Id: 2894
    Name: "菁英捲甲蟲"
    JapaneseName: "菁英捲甲蟲"
  - Id: 2895
    Name: "憤怒阿修羅機械"
    JapaneseName: "憤怒阿修羅機械"
  - Id: 2896
    Name: "狡猾鹿角甲蟲"
    JapaneseName: "狡猾鹿角甲蟲"
  - Id: 2897
    Name: "迅捷古靈精怪書"
    JapaneseName: "迅捷古靈精怪書"
  - Id: 2898
    Name: "雄壯古靈精怪書"
    JapaneseName: "雄壯古靈精怪書"
  - Id: 2899
    Name: "憤怒虎蜥人"
    JapaneseName: "憤怒虎蜥人"
  - Id: 2900
    Name: "狡猾瘋狂螳螂"
    JapaneseName: "狡猾瘋狂螳螂"
  - Id: 2901
    Name: "迅捷瘋狂螳螂"
    JapaneseName: "迅捷瘋狂螳螂"
  - Id: 2902
    Name: "雄壯白蟻"
    JapaneseName: "雄壯白蟻"
  - Id: 2903
    Name: "菁英狂暴邪惡箱"
    JapaneseName: "菁英狂暴邪惡箱"
  - Id: 2904
    Name: "憤怒毒蛇"
    JapaneseName: "憤怒毒蛇"
  - Id: 2905
    Name: "狡猾蝸牛"
    JapaneseName: "狡猾蝸牛"
  - Id: 2906
    Name: "迅捷泰坦魔芋花"
    JapaneseName: "迅捷泰坦魔芋花"
  - Id: 2907
    Name: "雄壯鱷魚人"
    JapaneseName: "雄壯鱷魚人"
  - Id: 2908
    Name: "菁英愛麗莎"
    JapaneseName: "菁英愛麗莎"
  - Id: 2909
    Name: "憤怒愛麗瑟"
    JapaneseName: "憤怒愛麗瑟"
  - Id: 2910
    Name: "狡猾鐘怪"
    JapaneseName: "狡猾鐘怪"
  - Id: 2911
    Name: "迅捷阿卡布"
    JapaneseName: "迅捷阿卡布"
  - Id: 2912
    Name: "雄壯灰俄希托斯"
    JapaneseName: "雄壯灰俄希托斯"
  - Id: 2913
    Name: "菁英灰俄希托斯"
    JapaneseName: "菁英灰俄希托斯"
  - Id: 2914
    Name: "吉芬商店盜賊"
    JapaneseName: "吉芬商店盜賊"
  - Id: 2916
    Name: "大笨鐘"
    JapaneseName: "大笨鐘"
  - Id: 2917
    Name: "大鐘怪"
    JapaneseName: "大鐘怪"
  - Id: 2918
    Name: "時光守護者"
    JapaneseName: "時光守護者"
  - Id: 2919
    Name: "惡靈朽魔"
    JapaneseName: "惡靈朽魔"
  - Id: 2920
    Name: "邪靈長老"
    JapaneseName: "邪靈長老"
  - Id: 2921
    Name: "鴞裊子爵"
    JapaneseName: "鴞裊子爵"
  - Id: 2923
    Name: "鴞裊侯爵"
    JapaneseName: "鴞裊侯爵"
  - Id: 2937
    Name: "洛基的殘影"
    JapaneseName: "洛基的殘影"
  - Id: 2938
    Name: "魔神力量碎片"
    JapaneseName: "魔神力量碎片"
  - Id: 2939
    Name: "魔神影子"
    JapaneseName: "魔神影子"
  - Id: 2940
    Name: "魔神影子"
    JapaneseName: "魔神影子"
  - Id: 2941
    Name: "魔神影子"
    JapaneseName: "魔神影子"
  - Id: 2942
    Name: "魔神的追隨者"
    JapaneseName: "魔神的追隨者"
  - Id: 2943
    Name: "冰雷(暫譯)"
    JapaneseName: "冰雷(暫譯)"
  - Id: 2948
    Name: "受到詛咒的士兵"
    JapaneseName: "受到詛咒的士兵"
  - Id: 2949
    Name: "受到詛咒的守門"
    JapaneseName: "受到詛咒的守門"
  - Id: 2950
    Name: "無法獻出的心意"
    JapaneseName: "無法獻出的心意"
  - Id: 2951
    Name: "聲聲嘆息"
    JapaneseName: "聲聲嘆息"
  - Id: 2952
    Name: "以愛之名"
    JapaneseName: "以愛之名"
  - Id: 2953
    Name: "討人厭的回憶"
    JapaneseName: "討人厭的回憶"
  - Id: 2954
    Name: "崩壞的誓約"
    JapaneseName: "崩壞的誓約"
  - Id: 2955
    Name: "褪色的友情"
    JapaneseName: "褪色的友情"
  - Id: 2956
    Name: "祥和殺戮"
    JapaneseName: "祥和殺戮"
  - Id: 2957
    Name: "別問我是誰"
    JapaneseName: "別問我是誰"
  - Id: 2958
    Name: "往事只能回味"
    JapaneseName: "往事只能回味"
  - Id: 2959
    Name: "異變的王子"
    JapaneseName: "異變的王子"
  - Id: 2960
    Name: "火焰克魯斯"
    JapaneseName: "火焰克魯斯"
  - Id: 2961
    Name: "異變的王子(靈魂)"
    JapaneseName: "異變的王子(靈魂)"
  - Id: 2962
    Name: "惡魔波利"
    JapaneseName: "惡魔波利"
  - Id: 2963
    Name: "小樹椿"
    JapaneseName: "小樹椿"
  - Id: 2973
    Name: "噩夢大公"
    JapaneseName: "噩夢大公"
  - Id: 2987
    Name: "驚悚的裝飾樹"
    JapaneseName: "驚悚的裝飾樹"
  - Id: 2988
    Name: "安東尼奧"
    JapaneseName: "安東尼奧"
  - Id: 2989
    Name: "禮物包裝負責人"
    JapaneseName: "禮物包裝負責人"
  - Id: 2990
    Name: "玩具工廠警報兵"
    JapaneseName: "玩具工廠警報兵"
  - Id: 2991
    Name: "包裝好的箱子"
    JapaneseName: "包裝好的箱子"
  - Id: 2992
    Name: "工廠警衛的亡靈"
    JapaneseName: "工廠警衛的亡靈"
  - Id: 2993
    Name: "未領到禮物的幽"
    JapaneseName: "未領到禮物的幽"
  - Id: 2994
    Name: "尚未包裝的玩偶"
    JapaneseName: "尚未包裝的玩偶"
  - Id: 2995
    Name: "被釋放的玩具熊"
    JapaneseName: "被釋放的玩具熊"
  - Id: 2996
    Name: "席琳基米"
    JapaneseName: "席琳基米"
  - Id: 2997
    Name: "基米的幻影"
    JapaneseName: "基米的幻影"
  - Id: 2998
    Name: "虛弱的夢羅克"
    JapaneseName: "虛弱的夢羅克"
  - Id: 2999
    Name: "夢羅克的行妖術"
    JapaneseName: "夢羅克的行妖術"
  - Id: 3000
    Name: "夢羅克的行妖術"
    JapaneseName: "夢羅克的行妖術"
  - Id: 3001
    Name: "夢羅克的綠腐屍"
    JapaneseName: "夢羅克的綠腐屍"
  - Id: 3002
    Name: "夢羅克的俄塞里"
    JapaneseName: "夢羅克的俄塞里"
  - Id: 3003
    Name: "夢羅克的邪骸弓"
    JapaneseName: "夢羅克的邪骸弓"
  - Id: 3004
    Name: "夢羅克的惡靈"
    JapaneseName: "夢羅克的惡靈"
  - Id: 3005
    Name: "夢羅克的木乃伊"
    JapaneseName: "夢羅克的木乃伊"
  - Id: 3006
    Name: "夢羅克的南瓜魂"
    JapaneseName: "夢羅克的南瓜魂"
  - Id: 3007
    Name: "夢羅克的魁儡"
    JapaneseName: "夢羅克的魁儡"
  - Id: 3008
    Name: "夢羅克的漂浮蟲"
    JapaneseName: "夢羅克的漂浮蟲"
  - Id: 3009
    Name: "死者咒術士"
    JapaneseName: "死者咒術士"
  - Id: 3010
    Name: "墮落獸人嬰兒"
    JapaneseName: "墮落獸人嬰兒"
  - Id: 3011
    Name: "墮落沙漠幼狼"
    JapaneseName: "墮落沙漠幼狼"
  - Id: 3012
    Name: "墮落吸血蝙蝠"
    JapaneseName: "墮落吸血蝙蝠"
  - Id: 3013
    Name: "墮落獸人戰士"
    JapaneseName: "墮落獸人戰士"
  - Id: 3014
    Name: "墮落沙漠之狼"
    JapaneseName: "墮落沙漠之狼"
  - Id: 3015
    Name: "墮落劍魚"
    JapaneseName: "墮落劍魚"
  - Id: 3016
    Name: "墮落獸人腐屍"
    JapaneseName: "墮落獸人腐屍"
  - Id: 3017
    Name: "墮落木乃伊犬"
    JapaneseName: "墮落木乃伊犬"
  - Id: 3018
    Name: "墮落邪骸食人魚"
    JapaneseName: "墮落邪骸食人魚"
  - Id: 3019
    Name: "席琳基米"
    JapaneseName: "席琳基米"
  - Id: 3020
    Name: "火焰禿鷹"
    JapaneseName: "火焰禿鷹"
  - Id: 3021
    Name: "火焰泥人"
    JapaneseName: "火焰泥人"
  - Id: 3022
    Name: "火焰傘蜥"
    JapaneseName: "火焰傘蜥"
  - Id: 3023
    Name: "火焰巨石怪"
    JapaneseName: "火焰巨石怪"
  - Id: 3024
    Name: "傭兵A"
    JapaneseName: "傭兵A"
  - Id: 3025
    Name: "傭兵B"
    JapaneseName: "傭兵B"
  - Id: 3026
    Name: "火坑"
    JapaneseName: "火坑"
  - Id: 3027
    Name: "火蟻"
    JapaneseName: "火蟻"
  - Id: 3028
    Name: "索妮雅"
    JapaneseName: "索妮雅"
  - Id: 3029
    Name: "死神 安庫"
    JapaneseName: "死神 安庫"
  - Id: 3030
    Name: "站立的靈魂"
    JapaneseName: "站立的靈魂"
  - Id: 3039
    Name: "烈火夢羅克門徒"
    JapaneseName: "烈火夢羅克門徒"
  - Id: 3040
    Name: "猖狂夢羅克門徒"
    JapaneseName: "猖狂夢羅克門徒"
  - Id: 3041
    Name: "冰凍夢羅克門徒"
    JapaneseName: "冰凍夢羅克門徒"
  - Id: 3061
    Name: "飛來飛去的箱子"
    JapaneseName: "飛來飛去的箱子"
  - Id: 3069
    Name: "貝爾"
    JapaneseName: "貝爾"
  - Id: 3070
    Name: "貝爾"
    JapaneseName: "貝爾"
  - Id: 3071
    Name: "貝爾"
    JapaneseName: "貝爾"
  - Id: 3072
    Name: "貝爾"
    JapaneseName: "貝爾"
  - Id: 3073
    Name: "覺醒的貝爾"
    JapaneseName: "覺醒的貝爾"
  - Id: 3074
    Name: "時間支配者"
    JapaneseName: "時間支配者"
  - Id: 3075
    Name: "迅捷寶物箱子"
    JapaneseName: "迅捷寶物箱子"
  - Id: 3086
    Name: "斐揚傭兵"
    JapaneseName: "斐揚傭兵"
  - Id: 3087
    Name: "重生的半魔神"
    JapaneseName: "重生的半魔神"
  - Id: 3088
    Name: "冰霜蜘蛛"
    JapaneseName: "冰霜蜘蛛"
  - Id: 3089
    Name: "瘋狂卡薩"
    JapaneseName: "瘋狂卡薩"
  - Id: 3090
    Name: "瘋狂火蜥蜴"
    JapaneseName: "瘋狂火蜥蜴"
  - Id: 3091
    Name: "巴利納拉雷亞"
    JapaneseName: "巴利納拉雷亞"
  - Id: 3092
    Name: "穆希貝斯寇"
    JapaneseName: "穆希貝斯寇"
  - Id: 3093
    Name: "冰霜蜘蛛之核"
    JapaneseName: "冰霜蜘蛛之核"
  - Id: 3094
    Name: "火焰狼的核"
    JapaneseName: "火焰狼的核"
  - Id: 3095
    Name: "神的影子"
    JapaneseName: "神的影子"
  - Id: 3096
    Name: "重生的半魔神"
    JapaneseName: "重生的半魔神"
  - Id: 3097
    Name: "絕望之神夢羅克"
    JapaneseName: "絕望之神夢羅克"
  - Id: 3098
    Name: "太初的夢羅克"
    JapaneseName: "太初的夢羅克"
  - Id: 3099
    Name: "恢復的夢羅克"
    JapaneseName: "恢復的夢羅克"
  - Id: 3100
    Name: "符文的瑪娜"
    JapaneseName: "符文的瑪娜"
  - Id: 3101
    Name: "光輝的瑪娜"
    JapaneseName: "光輝的瑪娜"
  - Id: 3102
    Name: "生命的瑪娜"
    JapaneseName: "生命的瑪娜"
  - Id: 3103
    Name: "大地的瑪娜"
    JapaneseName: "大地的瑪娜"
  - Id: 3104
    Name: "海洋的瑪娜"
    JapaneseName: "海洋的瑪娜"
  - Id: 3105
    Name: "魔神的門徒 阿哈"
    JapaneseName: "魔神的門徒 阿哈"
  - Id: 3106
    Name: "魔神的門徒 許乃"
    JapaneseName: "魔神的門徒 許乃"
  - Id: 3108
    Name: "吉特巴"
    JapaneseName: "吉特巴"
  - Id: 3109
    Name: "吉特巴"
    JapaneseName: "吉特巴"
  - Id: 3122
    Name: "查爾斯頓1號"
    JapaneseName: "查爾斯頓1號"
  - Id: 3123
    Name: "查爾斯頓2號"
    JapaneseName: "查爾斯頓2號"
  - Id: 3124
    Name: "查爾斯頓3號"
    JapaneseName: "查爾斯頓3號"
  - Id: 3125
    Name: "步伐"
    JapaneseName: "步伐"
  - Id: 3126
    Name: "變異機器人"
    JapaneseName: "變異機器人"
  - Id: 3127
    Name: "通道保全設施"
    JapaneseName: "通道保全設施"
  - Id: 3128
    Name: "霹靂機器人"
    JapaneseName: "霹靂機器人"
  - Id: 3139
    Name: "覺醒腐屍"
    JapaneseName: "覺醒腐屍"
  - Id: 3140
    Name: "覺醒惡靈"
    JapaneseName: "覺醒惡靈"
  - Id: 3141
    Name: "覺醒綠腐屍"
    JapaneseName: "覺醒綠腐屍"
  - Id: 3142
    Name: "覺醒捲甲蟲"
    JapaneseName: "覺醒捲甲蟲"
  - Id: 3143
    Name: "覺醒四處徘徊的"
    JapaneseName: "覺醒四處徘徊的"
  - Id: 3144
    Name: "覺醒四處徘徊的"
    JapaneseName: "覺醒四處徘徊的"
  - Id: 3145
    Name: "覺醒墮落的深淵"
    JapaneseName: "覺醒墮落的深淵"
  - Id: 3146
    Name: "覺醒怨念的卡利"
    JapaneseName: "覺醒怨念的卡利"
  - Id: 3147
    Name: "覺醒血腥騎士"
    JapaneseName: "覺醒血腥騎士"
  - Id: 3148
    Name: "覺醒毀滅的第1騎"
    JapaneseName: "覺醒毀滅的第1騎"
  - Id: 3149
    Name: "覺醒毀滅的第2騎"
    JapaneseName: "覺醒毀滅的第2騎"
  - Id: 3150
    Name: "覺醒闇答萊屍"
    JapaneseName: "覺醒闇答萊屍"
  - Id: 3151
    Name: "覺醒墮落根莖"
    JapaneseName: "覺醒墮落根莖"
  - Id: 3153
    Name: "挖掘機器人"
    JapaneseName: "挖掘機器人"
  - Id: 3154
    Name: "巡邏機器人"
    JapaneseName: "巡邏機器人"
  - Id: 3155
    Name: "修繕機器人"
    JapaneseName: "修繕機器人"
  - Id: 3156
    Name: "勘查機器人"
    JapaneseName: "勘查機器人"
  - Id: 3157
    Name: "滅亡祈福會信徒"
    JapaneseName: "滅亡祈福會信徒"
  - Id: 3158
    Name: "滅亡祈福會信徒"
    JapaneseName: "滅亡祈福會信徒"
  - Id: 3161
    Name: "炸彈"
    JapaneseName: "炸彈"
  - Id: 3169
    Name: "射擊目標1"
    JapaneseName: "射擊目標1"
  - Id: 3170
    Name: "射擊目標2"
    JapaneseName: "射擊目標2"
  - Id: 3175
    Name: "直升機哥布靈"
    JapaneseName: "直升機哥布靈"
  - Id: 3176
    Name: "小妖精"
    JapaneseName: "小妖精"
  - Id: 3177
    Name: "惡魔之眼"
    JapaneseName: "惡魔之眼"
  - Id: 3178
    Name: "俄希托斯"
    JapaneseName: "俄希托斯"
  - Id: 3179
    Name: "灰俄希托斯"
    JapaneseName: "灰俄希托斯"
  - Id: 3180
    Name: "飛龍"
    JapaneseName: "飛龍"
  - Id: 3181
    Name: "暴走的船長裴陸"
    JapaneseName: "暴走的船長裴陸"
  - Id: 3182
    Name: "直升機哥布靈"
    JapaneseName: "直升機哥布靈"
  - Id: 3183
    Name: "小妖精"
    JapaneseName: "小妖精"
  - Id: 3184
    Name: "惡魔之眼"
    JapaneseName: "惡魔之眼"
  - Id: 3185
    Name: "灰俄希托斯"
    JapaneseName: "灰俄希托斯"
  - Id: 3186
    Name: "灰俄希托斯"
    JapaneseName: "灰俄希托斯"
  - Id: 3187
    Name: "飛龍"
    JapaneseName: "飛龍"
  - Id: 3188
    Name: "暴走的船長裴陸"
    JapaneseName: "暴走的船長裴陸"
  - Id: 3189
    Name: "滿月之狼"
    JapaneseName: "滿月之狼"
  - Id: 3190
    Name: "莎拉 艾琳"
    JapaneseName: "莎拉 艾琳"
  - Id: 3191
    Name: "古代中型基勘特"
    JapaneseName: "古代中型基勘特"
  - Id: 3192
    Name: "古代的基勘特斯"
    JapaneseName: "古代的基勘特斯"
  - Id: 3193
    Name: "準大型基勘特斯"
    JapaneseName: "準大型基勘特斯"
  - Id: 3194
    Name: "古代的基勘特斯"
    JapaneseName: "古代的基勘特斯"
  - Id: 3195
    Name: "大型基勘特斯"
    JapaneseName: "大型基勘特斯"
  - Id: 3196
    Name: "古代的基勘特斯"
    JapaneseName: "古代的基勘特斯"
  - Id: 3197
    Name: "變種蝙蝠弓箭手"
    JapaneseName: "變種蝙蝠弓箭手"
  - Id: 3198
    Name: "變種迦利"
    JapaneseName: "變種迦利"
  - Id: 3199
    Name: "邪惡半種人"
    JapaneseName: "邪惡半種人"
  - Id: 3200
    Name: "邪惡的凱美拉"
    JapaneseName: "邪惡的凱美拉"
  - Id: 3202
    Name: "有機南瓜"
    JapaneseName: "有機南瓜"
  - Id: 3203
    Name: "無機南瓜"
    JapaneseName: "無機南瓜"
  - Id: 3206
    Name: "閃亮波利"
    JapaneseName: "閃亮波利"
  - Id: 3208
    Name: "闇●十字斬首者"
    JapaneseName: "闇●十字斬首者"
  - Id: 3209
    Name: "闇●大主教"
    JapaneseName: "闇●大主教"
  - Id: 3210
    Name: "闇●咒術士"
    JapaneseName: "闇●咒術士"
  - Id: 3211
    Name: "闇●遊俠"
    JapaneseName: "闇●遊俠"
  - Id: 3212
    Name: "闇●機械工匠"
    JapaneseName: "闇●機械工匠"
  - Id: 3213
    Name: "闇●盧恩騎士"
    JapaneseName: "闇●盧恩騎士"
  - Id: 3214
    Name: "十字斬首者 艾勒"
    JapaneseName: "十字斬首者 艾勒"
  - Id: 3215
    Name: "大主教 瑪嘉雷特"
    JapaneseName: "大主教 瑪嘉雷特"
  - Id: 3216
    Name: "咒術士 凱特莉娜"
    JapaneseName: "咒術士 凱特莉娜"
  - Id: 3217
    Name: "游俠 迪文"
    JapaneseName: "游俠 迪文"
  - Id: 3218
    Name: "機械工匠 哈沃得"
    JapaneseName: "機械工匠 哈沃得"
  - Id: 3219
    Name: "盧恩騎士 賽依連"
    JapaneseName: "盧恩騎士 賽依連"
  - Id: 3220
    Name: "闇●十字斬首者 "
    JapaneseName: "闇●十字斬首者 "
  - Id: 3221
    Name: "闇●大主教 瑪嘉"
    JapaneseName: "闇●大主教 瑪嘉"
  - Id: 3222
    Name: "闇●遊俠 迪文"
    JapaneseName: "闇●遊俠 迪文"
  - Id: 3223
    Name: "闇●機械工匠 哈"
    JapaneseName: "闇●機械工匠 哈"
  - Id: 3224
    Name: "闇●咒術士 凱特"
    JapaneseName: "闇●咒術士 凱特"
  - Id: 3225
    Name: "闇●盧恩騎士 賽"
    JapaneseName: "闇●盧恩騎士 賽"
  - Id: 3226
    Name: "闇●皇家禁衛隊"
    JapaneseName: "闇●皇家禁衛隊"
  - Id: 3227
    Name: "闇●基因學者"
    JapaneseName: "闇●基因學者"
  - Id: 3228
    Name: "闇●妖術師"
    JapaneseName: "闇●妖術師"
  - Id: 3229
    Name: "闇●修羅"
    JapaneseName: "闇●修羅"
  - Id: 3230
    Name: "闇●魅影追蹤者"
    JapaneseName: "闇●魅影追蹤者"
  - Id: 3231
    Name: "闇●宮廷樂師"
    JapaneseName: "闇●宮廷樂師"
  - Id: 3232
    Name: "闇●浪姬舞者"
    JapaneseName: "闇●浪姬舞者"
  - Id: 3233
    Name: "皇家禁衛隊 蘭達"
    JapaneseName: "皇家禁衛隊 蘭達"
  - Id: 3234
    Name: "基因學者 普拉梅"
    JapaneseName: "基因學者 普拉梅"
  - Id: 3235
    Name: "妖術師 西里亞"
    JapaneseName: "妖術師 西里亞"
  - Id: 3236
    Name: "修羅 陳理歐"
    JapaneseName: "修羅 陳理歐"
  - Id: 3237
    Name: "魅影追蹤者 科迪"
    JapaneseName: "魅影追蹤者 科迪"
  - Id: 3238
    Name: "樂師 雅歐帕奇爾"
    JapaneseName: "樂師 雅歐帕奇爾"
  - Id: 3239
    Name: "舞者 特蘭提尼"
    JapaneseName: "舞者 特蘭提尼"
  - Id: 3240
    Name: "闇●皇家禁衛隊 "
    JapaneseName: "闇●皇家禁衛隊 "
  - Id: 3241
    Name: "闇●基因學者 普"
    JapaneseName: "闇●基因學者 普"
  - Id: 3242
    Name: "闇●妖術師 西里"
    JapaneseName: "闇●妖術師 西里"
  - Id: 3243
    Name: "闇●修羅 陳理歐"
    JapaneseName: "闇●修羅 陳理歐"
  - Id: 3244
    Name: "闇●魅影追蹤者 "
    JapaneseName: "闇●魅影追蹤者 "
  - Id: 3245
    Name: "闇●宮廷樂師 雅"
    JapaneseName: "闇●宮廷樂師 雅"
  - Id: 3246
    Name: "闇●浪姬舞者 特"
    JapaneseName: "闇●浪姬舞者 特"
  - Id: 3247
    Name: "綠惡靈之霧"
    JapaneseName: "綠惡靈之霧"
  - Id: 3248
    Name: "修復機器人"
    JapaneseName: "修復機器人"
  - Id: 3249
    Name: "探索機器人"
    JapaneseName: "探索機器人"
  - Id: 3250
    Name: "廢鐵機器人"
    JapaneseName: "廢鐵機器人"
  - Id: 3251
    Name: "GC109"
    JapaneseName: "GC109"
  - Id: 3252
    Name: "DR815"
    JapaneseName: "DR815"
  - Id: 3253
    Name: "系統訊息"
    JapaneseName: "系統訊息"
  - Id: 3254
    Name: "T_W_O"
    JapaneseName: "T_W_O"
  - Id: 3255
    Name: "惡臭綠腐屍"
    JapaneseName: "惡臭綠腐屍"
  - Id: 3256
    Name: "惡臭腐屍"
    JapaneseName: "惡臭腐屍"
  - Id: 3384
    Name: "波利"
    JapaneseName: "波利"
  - Id: 3385
    Name: "瘋兔"
    JapaneseName: "瘋兔"
  - Id: 3386
    Name: "綠棉蟲"
    JapaneseName: "綠棉蟲"
  - Id: 3387
    Name: "小雞"
    JapaneseName: "小雞"
  - Id: 3388
    Name: "禿鷹"
    JapaneseName: "禿鷹"
  - Id: 3389
    Name: "樹精"
    JapaneseName: "樹精"
  - Id: 3390
    Name: "魔菇"
    JapaneseName: "魔菇"
  - Id: 3391
    Name: "波波利"
    JapaneseName: "波波利"
  - Id: 3392
    Name: "狸貓"
    JapaneseName: "狸貓"
  - Id: 3393
    Name: "土人"
    JapaneseName: "土人"
  - Id: 3394
    Name: "大腳熊"
    JapaneseName: "大腳熊"
  - Id: 3395
    Name: "森靈"
    JapaneseName: "森靈"
  - Id: 3396
    Name: "狼"
    JapaneseName: "狼"
  - Id: 3397
    Name: "青蛇"
    JapaneseName: "青蛇"
  - Id: 3398
    Name: "毒蛇"
    JapaneseName: "毒蛇"
  - Id: 3399
    Name: "冰波利"
    JapaneseName: "冰波利"
  - Id: 3400
    Name: "摩卡"
    JapaneseName: "摩卡"
  - Id: 3401
    Name: "大嘴鳥"
    JapaneseName: "大嘴鳥"
  - Id: 3402
    Name: "兵蟻"
    JapaneseName: "兵蟻"
  - Id: 3403
    Name: "工蟻"
    JapaneseName: "工蟻"
  - Id: 3404
    Name: "白蟻"
    JapaneseName: "白蟻"
  - Id: 3405
    Name: "巨石怪"
    JapaneseName: "巨石怪"
  - Id: 3406
    Name: "蠍子"
    JapaneseName: "蠍子"
  - Id: 3407
    Name: "蒼蠅"
    JapaneseName: "蒼蠅"
  - Id: 3408
    Name: "重金屬蝗蟲"
    JapaneseName: "重金屬蝗蟲"
  - Id: 3409
    Name: "泥人"
    JapaneseName: "泥人"
  - Id: 3410
    Name: "奈吉鳥"
    JapaneseName: "奈吉鳥"
  - Id: 3411
    Name: "刺尾蜻蜓"
    JapaneseName: "刺尾蜻蜓"
  - Id: 3412
    Name: "綠變色龍"
    JapaneseName: "綠變色龍"
  - Id: 3413
    Name: "海獺"
    JapaneseName: "海獺"
  - Id: 3414
    Name: "啤酒企鵝"
    JapaneseName: "啤酒企鵝"
  - Id: 3415
    Name: "海豹寶寶"
    JapaneseName: "海豹寶寶"
  - Id: 3416
    Name: "鱷魚人"
    JapaneseName: "鱷魚人"
  - Id: 3417
    Name: "邪骸食人魚"
    JapaneseName: "邪骸食人魚"
  - Id: 3418
    Name: "三葉蟲"
    JapaneseName: "三葉蟲"
  - Id: 3419
    Name: "邪惡摩艾"
    JapaneseName: "邪惡摩艾"
  - Id: 3420
    Name: "森林妖姬"
    JapaneseName: "森林妖姬"
  - Id: 3421
    Name: "乖戾的蛙王"
    JapaneseName: "乖戾的蛙王"
  - Id: 3422
    Name: "乖戾的流浪之狼"
    JapaneseName: "乖戾的流浪之狼"
  - Id: 3423
    Name: "乖戾的蝗蟲之王"
    JapaneseName: "乖戾的蝗蟲之王"
  - Id: 3424
    Name: "乖戾的藍瘋兔"
    JapaneseName: "乖戾的藍瘋兔"
  - Id: 3425
    Name: "乖戾的凱美拉"
    JapaneseName: "乖戾的凱美拉"
  - Id: 3426
    Name: "虎王"
    JapaneseName: "虎王"
  - Id: 3427
    Name: "俄塞里斯"
    JapaneseName: "俄塞里斯"
  - Id: 3428
    Name: "皮里恩"
    JapaneseName: "皮里恩"
  - Id: 3429
    Name: "獸人英雄"
    JapaneseName: "獸人英雄"
  - Id: 3430
    Name: "塔奧群卡"
    JapaneseName: "塔奧群卡"
  - Id: 3431
    Name: "羅達蛙"
    JapaneseName: "羅達蛙"
  - Id: 3432
    Name: "狼"
    JapaneseName: "狼"
  - Id: 3433
    Name: "搖滾蝗蟲"
    JapaneseName: "搖滾蝗蟲"
  - Id: 3434
    Name: "瘋兔"
    JapaneseName: "瘋兔"
  - Id: 3435
    Name: "蝙蝠弓箭手"
    JapaneseName: "蝙蝠弓箭手"
  - Id: 3436
    Name: "大腳熊"
    JapaneseName: "大腳熊"
  - Id: 3437
    Name: "狂暴木乃伊"
    JapaneseName: "狂暴木乃伊"
  - Id: 3438
    Name: "泥人"
    JapaneseName: "泥人"
  - Id: 3439
    Name: "獸人戰士長"
    JapaneseName: "獸人戰士長"
  - Id: 3440
    Name: "邪惡摩艾"
    JapaneseName: "邪惡摩艾"
  - Id: 3442
    Name: "冰狼"
    JapaneseName: "冰狼"
  - Id: 3443
    Name: "塔皮"
    JapaneseName: "塔皮"
  - Id: 3444
    Name: "觀察者"
    JapaneseName: "觀察者"
  - Id: 3445
    Name: "強化邪骸弓箭手"
    JapaneseName: "強化邪骸弓箭手"
  - Id: 3446
    Name: "強化邪骸戰士"
    JapaneseName: "強化邪骸戰士"
  - Id: 3447
    Name: "強化邪骸士兵"
    JapaneseName: "強化邪骸士兵"
  - Id: 3448
    Name: "改造的闇答萊屍"
    JapaneseName: "改造的闇答萊屍"
  - Id: 3449
    Name: "強化闇答萊屍"
    JapaneseName: "強化闇答萊屍"
  - Id: 3450
    Name: "畢尤"
    JapaneseName: "畢尤"
  - Id: 3451
    Name: "不死軍團"
    JapaneseName: "不死軍團"
  - Id: 3452
    Name: "殭屍衛士"
    JapaneseName: "殭屍衛士"
  - Id: 3454
    Name: "可疑的入侵者"
    JapaneseName: "可疑的入侵者"
  - Id: 3455
    Name: "碟仙惡靈"
    JapaneseName: "碟仙惡靈"
  - Id: 3473
    Name: "歐內斯特 斯特凡"
    JapaneseName: "歐內斯特 斯特凡"
  - Id: 3474
    Name: "不朽受詛咒騎士"
    JapaneseName: "不朽受詛咒騎士"
  - Id: 3475
    Name: "不朽風魔巫師"
    JapaneseName: "不朽風魔巫師"
  - Id: 3476
    Name: "不死腐屍士兵"
    JapaneseName: "不死腐屍士兵"
  - Id: 3477
    Name: "不死要塞軍團士"
    JapaneseName: "不死要塞軍團士"
  - Id: 3478
    Name: "空中要塞鑰匙保"
    JapaneseName: "空中要塞鑰匙保"
  - Id: 3479
    Name: "不死腐屍突擊兵"
    JapaneseName: "不死腐屍突擊兵"
  - Id: 3480
    Name: "不死腐屍詛咒士"
    JapaneseName: "不死腐屍詛咒士"
  - Id: 3481
    Name: "不死影子"
    JapaneseName: "不死影子"
  - Id: 3482
    Name: "不死影子"
    JapaneseName: "不死影子"
  - Id: 3483
    Name: "不死影子"
    JapaneseName: "不死影子"
  - Id: 3484
    Name: "歐內斯特 斯特凡"
    JapaneseName: "歐內斯特 斯特凡"
  - Id: 3485
    Name: "畢尤的詛咒士兵"
    JapaneseName: "畢尤的詛咒士兵"
  - Id: 3487
    Name: "剁肉刀士兵"
    JapaneseName: "剁肉刀士兵"
  - Id: 3488
    Name: "憎惡鐮刀士兵"
    JapaneseName: "憎惡鐮刀士兵"
  - Id: 3489
    Name: "粉碎犁士兵"
    JapaneseName: "粉碎犁士兵"
  - Id: 3490
    Name: "不死軍團軍官"
    JapaneseName: "不死軍團軍官"
  - Id: 3495
    Name: "蛋黃波利"
    JapaneseName: "蛋黃波利"
  - Id: 3496
    Name: "群葉瘋兔"
    JapaneseName: "群葉瘋兔"
  - Id: 3497
    Name: "草地綠棉蟲"
    JapaneseName: "草地綠棉蟲"
  - Id: 3498
    Name: "狂野蜂兵"
    JapaneseName: "狂野蜂兵"
  - Id: 3499
    Name: "甜心羅達蛙"
    JapaneseName: "甜心羅達蛙"
  - Id: 3500
    Name: "狩獵沙漠之狼"
    JapaneseName: "狩獵沙漠之狼"
  - Id: 3501
    Name: "變形魔菇"
    JapaneseName: "變形魔菇"
  - Id: 3502
    Name: "偵查巴西利斯克"
    JapaneseName: "偵查巴西利斯克"
  - Id: 3503
    Name: "突擊巴西利斯克"
    JapaneseName: "突擊巴西利斯克"
  - Id: 3504
    Name: "特種巴西利斯克"
    JapaneseName: "特種巴西利斯克"
  - Id: 3505
    Name: "巨大蛋黃波利"
    JapaneseName: "巨大蛋黃波利"
  - Id: 3506
    Name: "叢林曼陀羅魔花"
    JapaneseName: "叢林曼陀羅魔花"
  - Id: 3507
    Name: "果實食人蜘蛛"
    JapaneseName: "果實食人蜘蛛"
  - Id: 3508
    Name: "蛋黃波利"
    JapaneseName: "蛋黃波利"
  - Id: 3510
    Name: "神殿衛士"
    JapaneseName: "神殿衛士"
  - Id: 3511
    Name: "憤怒的信徒"
    JapaneseName: "憤怒的信徒"
  - Id: 3512
    Name: "憤怒的信徒"
    JapaneseName: "憤怒的信徒"
  - Id: 3513
    Name: "憤努狗"
    JapaneseName: "憤努狗"
  - Id: 3514
    Name: "憤怒的大神官"
    JapaneseName: "憤怒的大神官"
  - Id: 3515
    Name: "冰封之心"
    JapaneseName: "冰封之心"
  - Id: 3516
    Name: "憤怒的儒閔"
    JapaneseName: "憤怒的儒閔"
  - Id: 3517
    Name: "憤怒的冰巨人"
    JapaneseName: "憤怒的冰巨人"
  - Id: 3518
    Name: "神殿衛士"
    JapaneseName: "神殿衛士"
  - Id: 3519
    Name: "憤怒的信徒"
    JapaneseName: "憤怒的信徒"
  - Id: 3520
    Name: "憤怒的信徒"
    JapaneseName: "憤怒的信徒"
  - Id: 3521
    Name: "憤努狗"
    JapaneseName: "憤努狗"
  - Id: 3522
    Name: "憤怒的大神官"
    JapaneseName: "憤怒的大神官"
  - Id: 3523
    Name: "冰封之心"
    JapaneseName: "冰封之心"
  - Id: 3524
    Name: "憤怒的儒閔"
    JapaneseName: "憤怒的儒閔"
  - Id: 3525
    Name: "憤怒的冰巨人"
    JapaneseName: "憤怒的冰巨人"
  - Id: 3526
    Name: "憤怒的水晶龍幻"
    JapaneseName: "憤怒的水晶龍幻"
  - Id: 3621
    Name: "小可愛"
    JapaneseName: "小可愛"
  - Id: 3622
    Name: "特殊警衛"
    JapaneseName: "特殊警衛"
  - Id: 3626
    Name: "強化邪心獵人"
    JapaneseName: "強化邪心獵人"
  - Id: 3627
    Name: "邪心獵人保鑣"
    JapaneseName: "邪心獵人保鑣"
  - Id: 3628
    Name: "闇●邪心獵人"
    JapaneseName: "闇●邪心獵人"
  - Id: 3629
    Name: "砸毀手槍的怨靈"
    JapaneseName: "砸毀手槍的怨靈"
  - Id: 3630
    Name: "埃琳娜 博克巴"
    JapaneseName: "埃琳娜 博克巴"
  - Id: 3631
    Name: "人類型凱美拉"
    JapaneseName: "人類型凱美拉"
  - Id: 3632
    Name: "物質型凱美拉"
    JapaneseName: "物質型凱美拉"
  - Id: 3633
    Name: "劇毒凱美拉"
    JapaneseName: "劇毒凱美拉"
  - Id: 3637
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3638
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3639
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3640
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3641
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3642
    Name: "邪骸戰士"
    JapaneseName: "邪骸戰士"
  - Id: 3643
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3644
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3645
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3646
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3647
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3648
    Name: "吸血蝙蝠"
    JapaneseName: "吸血蝙蝠"
  - Id: 3649
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3650
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3651
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3652
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3653
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3654
    Name: "腐屍"
    JapaneseName: "腐屍"
  - Id: 3658
    Name: "亡者君王"
    JapaneseName: "亡者君王"
  - Id: 3659
    Name: "亡者君王"
    JapaneseName: "亡者君王"
  - Id: 3660
    Name: "夢魘"
    JapaneseName: "夢魘"
  - Id: 3661
    Name: "夢魘"
    JapaneseName: "夢魘"
  - Id: 3662
    Name: "南瓜先生"
    JapaneseName: "南瓜先生"
  - Id: 3663
    Name: "南瓜先生"
    JapaneseName: "南瓜先生"
  - Id: 3664
    Name: "綠腐屍"
    JapaneseName: "綠腐屍"
  - Id: 3665
    Name: "綠腐屍"
    JapaneseName: "綠腐屍"
  - Id: 3666
    Name: "紅蝙蝠"
    JapaneseName: "紅蝙蝠"
  - Id: 3667
    Name: "紅蝙蝠"
    JapaneseName: "紅蝙蝠"
  - Id: 3736
    Name: "散彈槍草寇"
    JapaneseName: "散彈槍草寇"
  - Id: 3737
    Name: "左輪手槍草寇"
    JapaneseName: "左輪手槍草寇"
  - Id: 3738
    Name: "彎刀草寇"
    JapaneseName: "彎刀草寇"
  - Id: 3739
    Name: "郊狼"
    JapaneseName: "郊狼"
  - Id: 3740
    Name: "瓦斯特"
    JapaneseName: "瓦斯特"
  - Id: 3741
    Name: "蜘蛛戰車"
    JapaneseName: "蜘蛛戰車"
  - Id: 3742
    Name: "紫色礦石"
    JapaneseName: "紫色礦石"
  - Id: 3743
    Name: "海葵"
    JapaneseName: "海葵"
  - Id: 3744
    Name: "巡邏牛仔"
    JapaneseName: "巡邏牛仔"
  - Id: 3745
    Name: "視察牛仔"
    JapaneseName: "視察牛仔"
  - Id: 3746
    Name: "砍刀牛仔"
    JapaneseName: "砍刀牛仔"
  - Id: 3747
    Name: "精英散彈槍草寇"
    JapaneseName: "精英散彈槍草寇"
  - Id: 3748
    Name: "精英左輪手槍草"
    JapaneseName: "精英左輪手槍草"
  - Id: 3749
    Name: "精英彎刀草寇"
    JapaneseName: "精英彎刀草寇"
  - Id: 3750
    Name: "幻影紅蝙蝠"
    JapaneseName: "幻影紅蝙蝠"
  - Id: 3751
    Name: "活死人"
    JapaneseName: "活死人"
  - Id: 3752
    Name: "活死人"
    JapaneseName: "活死人"
  - Id: 3753
    Name: "活死人"
    JapaneseName: "活死人"
  - Id: 3754
    Name: "幻影夢魘"
    JapaneseName: "幻影夢魘"
  - Id: 3755
    Name: "毒血蘑菇"
    JapaneseName: "毒血蘑菇"
  - Id: 3756
    Name: "暴走的波蜜"
    JapaneseName: "暴走的波蜜"
  - Id: 3757
    Name: "憤怒的德古拉"
    JapaneseName: "憤怒的德古拉"
  - Id: 3758
    Name: "憤怒的月夜貓"
    JapaneseName: "憤怒的月夜貓"
  - Id: 3759
    Name: "憤怒的九尾狐"
    JapaneseName: "憤怒的九尾狐"
  - Id: 3760
    Name: "憤恨的殭屍"
    JapaneseName: "憤恨的殭屍"
  - Id: 3761
    Name: "憤恨的妖道"
    JapaneseName: "憤恨的妖道"
  - Id: 3762
    Name: "憤恨的鬼女"
    JapaneseName: "憤恨的鬼女"
  - Id: 3763
    Name: "含冤的士兵"
    JapaneseName: "含冤的士兵"
  - Id: 3764
    Name: "真理超魔導師"
    JapaneseName: "真理超魔導師"
  - Id: 3765
    Name: "狂熱的冒險家"
    JapaneseName: "狂熱的冒險家"
  - Id: 3787
    Name: "沼澤捲甲蟲"
    JapaneseName: "沼澤捲甲蟲"
  - Id: 3788
    Name: "溝鼠"
    JapaneseName: "溝鼠"
  - Id: 3790
    Name: "蜜糖土波利"
    JapaneseName: "蜜糖土波利"
  - Id: 3792
    Name: "憤怒蓋俄斯提"
    JapaneseName: "憤怒蓋俄斯提"
  - Id: 3793
    Name: "憤怒雪獸"
    JapaneseName: "憤怒雪獸"
  - Id: 3794
    Name: "憤怒冰巨人"
    JapaneseName: "憤怒冰巨人"
  - Id: 3795
    Name: "堅硬冰柱"
    JapaneseName: "堅硬冰柱"
  - Id: 3796
    Name: "甦醒水晶龍"
    JapaneseName: "甦醒水晶龍"
  - Id: 3797
    Name: "急凍布里德"
    JapaneseName: "急凍布里德"
  - Id: 3798
    Name: "急凍杰思"
    JapaneseName: "急凍杰思"
  - Id: 3799
    Name: "不祥風靈龜"
    JapaneseName: "不祥風靈龜"
  - Id: 3800
    Name: "不祥果樹龜"
    JapaneseName: "不祥果樹龜"
  - Id: 3801
    Name: "不祥水靈龜"
    JapaneseName: "不祥水靈龜"
  - Id: 3802
    Name: "不祥岩石龜"
    JapaneseName: "不祥岩石龜"
  - Id: 3803
    Name: "不祥火焰龜"
    JapaneseName: "不祥火焰龜"
  - Id: 3804
    Name: "不祥烏龜將軍"
    JapaneseName: "不祥烏龜將軍"
  - Id: 3810
    Name: "國王波利"
    JapaneseName: "國王波利"
  - Id: 3811
    Name: "巨大黃金波利"
    JapaneseName: "巨大黃金波利"
  - Id: 3812
    Name: "巨大萌萌波利"
    JapaneseName: "巨大萌萌波利"
  - Id: 3813
    Name: "強化土波利"
    JapaneseName: "強化土波利"
  - Id: 3814
    Name: "強化波波利"
    JapaneseName: "強化波波利"
  - Id: 3815
    Name: "強化波利"
    JapaneseName: "強化波利"
  - Id: 3816
    Name: "強化冰波利"
    JapaneseName: "強化冰波利"
  - Id: 3819
    Name: "神奇藥草"
    JapaneseName: "神奇藥草"
  - Id: 3820
    Name: "火熱炙燄魔"
    JapaneseName: "火熱炙燄魔"
  - Id: 3821
    Name: "火熱爆炎蝙蝠"
    JapaneseName: "火熱爆炎蝙蝠"
  - Id: 3826
    Name: "YSF01賽依連"
    JapaneseName: "YSF01賽依連"
  - Id: 20255
    Name: "紅色泰迪熊"
    JapaneseName: "紅色泰迪熊"
  - Id: 20256
    Name: "黃色泰迪熊"
    JapaneseName: "黃色泰迪熊"
  - Id: 20257
    Name: "綠色泰迪熊"
    JapaneseName: "綠色泰迪熊"
  - Id: 20258
    Name: "白色泰迪熊"
    JapaneseName: "白色泰迪熊"
  - Id: 20259
    Name: "藍色泰迪熊"
    JapaneseName: "藍色泰迪熊"
  - Id: 20260
    Name: "光芒泰迪熊"
    JapaneseName: "光芒泰迪熊"
  - Id: 20261
    Name: "勞碌礦工魔"
    JapaneseName: "勞碌礦工魔"
  - Id: 20262
    Name: "靈魂碎片"
    JapaneseName: "靈魂碎片"
  - Id: 20263
    Name: "邪念黑曜石"
    JapaneseName: "邪念黑曜石"
  - Id: 20264
    Name: "紅色泰迪熊"
    JapaneseName: "紅色泰迪熊"
  - Id: 20265
    Name: "黃色泰迪熊"
    JapaneseName: "黃色泰迪熊"
  - Id: 20266
    Name: "綠色泰迪熊"
    JapaneseName: "綠色泰迪熊"
  - Id: 20267
    Name: "白色泰迪熊"
    JapaneseName: "白色泰迪熊"
  - Id: 20268
    Name: "藍色泰迪熊"
    JapaneseName: "藍色泰迪熊"
  - Id: 20270
    Name: "古代三葉蟲"
    JapaneseName: "古代三葉蟲"
  - Id: 20271
    Name: "古代鐘乳巨石怪"
    JapaneseName: "古代鐘乳巨石怪"
  - Id: 20272
    Name: "古代邪惡摩艾"
    JapaneseName: "古代邪惡摩艾"
  - Id: 20273
    Name: "古代塔奧群卡"
    JapaneseName: "古代塔奧群卡"
  - Id: 20274
    Name: "古代石砲火樹"
    JapaneseName: "古代石砲火樹"
  - Id: 20275
    Name: "古代伍坦彈弓手"
    JapaneseName: "古代伍坦彈弓手"
  - Id: 20276
    Name: "古代伍坦戰士"
    JapaneseName: "古代伍坦戰士"
  - Id: 20277
    Name: "古代伍坦防禦者"
    JapaneseName: "古代伍坦防禦者"
  - Id: 20340
    Name: "EL-A17T"
    JapaneseName: "EL-A17T"
  - Id: 20341
    Name: "E-EA1L"
    JapaneseName: "E-EA1L"
  - Id: 20342
    Name: "E-EA2S"
    JapaneseName: "E-EA2S"
  - Id: 20343
    Name: "E-13EN0"
    JapaneseName: "E-13EN0"
  - Id: 20346
    Name: "米古爾"
    JapaneseName: "米古爾"
  - Id: 20347
    Name: "米古爾G"
    JapaneseName: "米古爾G"
  - Id: 20348
    Name: "A013-卡夫特"
    JapaneseName: "A013-卡夫特"
  - Id: 20349
    Name: "A013-朵洛爾"
    JapaneseName: "A013-朵洛爾"
  - Id: 20350
    Name: "A013-貝拉雷"
    JapaneseName: "A013-貝拉雷"
  - Id: 20352
    Name: "致命碰碰"
    JapaneseName: "致命碰碰"
  - Id: 20353
    Name: "絕望朵洛爾"
    JapaneseName: "絕望朵洛爾"
  - Id: 20355
    Name: "貝拉雷"
    JapaneseName: "貝拉雷"
  - Id: 20356
    Name: "高階貝拉雷"
    JapaneseName: "高階貝拉雷"
  - Id: 20357
    Name: "薩納雷"
    JapaneseName: "薩納雷"
  - Id: 20358
    Name: "高階薩納雷"
    JapaneseName: "高階薩納雷"
  - Id: 20359
    Name: "普拉加"
    JapaneseName: "普拉加"
  - Id: 20360
    Name: "異種普拉加"
    JapaneseName: "異種普拉加"
  - Id: 20361
    Name: "朵洛爾"
    JapaneseName: "朵洛爾"
  - Id: 20362
    Name: "異種朵洛爾"
    JapaneseName: "異種朵洛爾"
  - Id: 20363
    Name: "貝納姆"
    JapaneseName: "貝納姆"
  - Id: 20364
    Name: "異種貝納姆"
    JapaneseName: "異種貝納姆"
  - Id: 20365
    Name: "雙頭卡夫特"
    JapaneseName: "雙頭卡夫特"
  - Id: 20366
    Name: "異種雙頭卡夫特"
    JapaneseName: "異種雙頭卡夫特"
  - Id: 20367
    Name: "汙染幽靈劍士"
    JapaneseName: "汙染幽靈劍士"
  - Id: 20368
    Name: "汙染幽靈弓箭手"
    JapaneseName: "汙染幽靈弓箭手"
  - Id: 20369
    Name: "冰凍蝙蝠弓箭手"
    JapaneseName: "冰凍蝙蝠弓箭手"
  - Id: 20370
    Name: "汙染史汀"
    JapaneseName: "汙染史汀"
  - Id: 20371
    Name: "越獄腐屍"
    JapaneseName: "越獄腐屍"
  - Id: 20372
    Name: "堅硬火焰妖"
    JapaneseName: "堅硬火焰妖"
  - Id: 20373
    Name: "堅硬七彩夢魘"
    JapaneseName: "堅硬七彩夢魘"
  - Id: 20374
    Name: "堅硬七彩飛龍"
    JapaneseName: "堅硬七彩飛龍"
  - Id: 20375
    Name: "堅硬七彩地龍"
    JapaneseName: "堅硬七彩地龍"
  - Id: 20376
    Name: "堅硬爆炎蝙蝠"
    JapaneseName: "堅硬爆炎蝙蝠"
  - Id: 20377
    Name: "堅硬卡浩"
    JapaneseName: "堅硬卡浩"
  - Id: 20378
    Name: "堅硬熔岩巨石"
    JapaneseName: "堅硬熔岩巨石"
  - Id: 20379
    Name: "冰魔巫師"
    JapaneseName: "冰魔巫師"
  - Id: 20380
    Name: "火魔巫師"
    JapaneseName: "火魔巫師"
  - Id: 20381
    Name: "R48-85-貝斯帝亞"
    JapaneseName: "R48-85-貝斯帝亞"
  - Id: 20386
    Name: "詛咒施密特國王"
    JapaneseName: "詛咒施密特國王"
  - Id: 20387
    Name: "詛咒施密特國王"
    JapaneseName: "詛咒施密特國王"
  - Id: 20388
    Name: "女騎士的思念"
    JapaneseName: "女騎士的思念"
  - Id: 20389
    Name: "女騎士的思念"
    JapaneseName: "女騎士的思念"
  - Id: 20390
    Name: "騎士的冤魂"
    JapaneseName: "騎士的冤魂"
  - Id: 20391
    Name: "騎士的冤魂"
    JapaneseName: "騎士的冤魂"
  - Id: 20392
    Name: "墮落愛麗絲女僕"
    JapaneseName: "墮落愛麗絲女僕"
  - Id: 20419
    Name: "堅硬穆希貝斯寇"
    JapaneseName: "堅硬穆希貝斯寇"
  - Id: 20420
    Name: "汙染邪骸浪人"
    JapaneseName: "汙染邪骸浪人"
  - Id: 20421
    Name: "汙染蜘蛛女王"
    JapaneseName: "汙染蜘蛛女王"
  - Id: 20422
    Name: "汙染黑暗之王"
    JapaneseName: "汙染黑暗之王"
  - Id: 20426
    Name: "詛咒火焰"
    JapaneseName: "詛咒火焰"
  - Id: 20520
    Name: "混沌巴風特"
    JapaneseName: "混沌巴風特"
  - Id: 20525
    Name: "混沌小巴風特"
    JapaneseName: "混沌小巴風特"
  - Id: 20526
    Name: "混沌黑蛇"
    JapaneseName: "混沌黑蛇"
  - Id: 20527
    Name: "混沌赤蒼蠅"
    JapaneseName: "混沌赤蒼蠅"
  - Id: 20528
    Name: "混沌螳螂"
    JapaneseName: "混沌螳螂"
  - Id: 20529
    Name: "混沌幽靈波利"
    JapaneseName: "混沌幽靈波利"
  - Id: 20530
    Name: "混沌狂暴螳螂"
    JapaneseName: "混沌狂暴螳螂"
  - Id: 20531
    Name: "混沌波波利"
    JapaneseName: "混沌波波利"
  - Id: 20532
    Name: "混沌灰森靈"
    JapaneseName: "混沌灰森靈"
  - Id: 20536
    Name: "無名劍士"
    JapaneseName: "無名劍士"
  - Id: 20537
    Name: "無名劍士"
    JapaneseName: "無名劍士"
  - Id: 20538
    Name: "無名服事"
    JapaneseName: "無名服事"
  - Id: 20539
    Name: "無名商人"
    JapaneseName: "無名商人"
  - Id: 20541
    Name: "雷根貝勒高級保"
    JapaneseName: "雷根貝勒高級保"
  - Id: 20542
    Name: "雷根貝勒保鑣"
    JapaneseName: "雷根貝勒保鑣"
  - Id: 20543
    Name: "雷根修蘆科學家"
    JapaneseName: "雷根修蘆科學家"
  - Id: 20572
    Name: "希梅爾茲幻影"
    JapaneseName: "希梅爾茲幻影"
  - Id: 20573
    Name: "闇答萊屍幻影"
    JapaneseName: "闇答萊屍幻影"
  - Id: 20574
    Name: "變異中的白色騎"
    JapaneseName: "變異中的白色騎"
  - Id: 20575
    Name: "無限墮落根莖"
    JapaneseName: "無限墮落根莖"
  - Id: 20576
    Name: "變異中的卡利斯"
    JapaneseName: "變異中的卡利斯"
  - Id: 20577
    Name: "被詛咒的幽靈劍"
    JapaneseName: "被詛咒的幽靈劍"
  - Id: 20578
    Name: "被詛咒的幽靈弓"
    JapaneseName: "被詛咒的幽靈弓"
  - Id: 20592
    Name: "奪命毒霧"
    JapaneseName: "奪命毒霧"
  - Id: 20593
    Name: "絕命毒霧"
    JapaneseName: "絕命毒霧"
  - Id: 20598
    Name: "珠寶蜘蛛"
    JapaneseName: "珠寶蜘蛛"
  - Id: 20601
    Name: "珠寶溫古力安特"
    JapaneseName: "珠寶溫古力安特"
  - Id: 20602
    Name: "白色三葉鐵甲蟲"
    JapaneseName: "白色三葉鐵甲蟲"
  - Id: 20603
    Name: "深淵礦工魔"
    JapaneseName: "深淵礦工魔"
  - Id: 20604
    Name: "天使方體惡魔"
    JapaneseName: "天使方體惡魔"
  - Id: 20605
    Name: "天使方體惡魔"
    JapaneseName: "天使方體惡魔"
  - Id: 20606
    Name: "神聖彩色皮影魔"
    JapaneseName: "神聖彩色皮影魔"
  - Id: 20607
    Name: "神聖皮影魔"
    JapaneseName: "神聖皮影魔"
  - Id: 20608
    Name: "穹拱等離子體"
    JapaneseName: "穹拱等離子體"
  - Id: 20609
    Name: "光譜等離子體"
    JapaneseName: "光譜等離子體"
  - Id: 20610
    Name: "巴基力雷吉麗芙"
    JapaneseName: "巴基力雷吉麗芙"
  - Id: 20611
    Name: "巴基力英格麗"
    JapaneseName: "巴基力英格麗"
  - Id: 20612
    Name: "紫色貝勒斯"
    JapaneseName: "紫色貝勒斯"
  - Id: 20613
    Name: "珠寶邪惡箱"
    JapaneseName: "珠寶邪惡箱"
  - Id: 20614
    Name: "暗黑俄希托斯"
    JapaneseName: "暗黑俄希托斯"
  - Id: 20615
    Name: "銀白光俄希托斯"
    JapaneseName: "銀白光俄希托斯"
  - Id: 20616
    Name: "骷髏貝勒斯"
    JapaneseName: "骷髏貝勒斯"
  - Id: 20617
    Name: "骷髏俄希托斯"
    JapaneseName: "骷髏俄希托斯"
  - Id: 20618
    Name: "骷髏迪塔勒泰晤"
    JapaneseName: "骷髏迪塔勒泰晤"
  - Id: 20620
    Name: "卡帕"
    JapaneseName: "卡帕"
  - Id: 20621
    Name: "卡帕"
    JapaneseName: "卡帕"
  - Id: 20622
    Name: "花園監視者"
    JapaneseName: "花園監視者"
  - Id: 20624
    Name: "花園監視者"
    JapaneseName: "花園監視者"
  - Id: 20625
    Name: "花園監視者"
    JapaneseName: "花園監視者"
  - Id: 20626
    Name: "花園監視者"
    JapaneseName: "花園監視者"
  - Id: 20627
    Name: "花園監視者"
    JapaneseName: "花園監視者"
  - Id: 20630
    Name: "故障的β"
    JapaneseName: "故障的β"
  - Id: 20631
    Name: "故障的園丁"
    JapaneseName: "故障的園丁"
  - Id: 20633
    Name: "故障的搓澡師"
    JapaneseName: "故障的搓澡師"
  - Id: 20634
    Name: "故障的搓澡師"
    JapaneseName: "故障的搓澡師"
  - Id: 20635
    Name: "掃地機器人"
    JapaneseName: "掃地機器人"
  - Id: 20636
    Name: "掃地機器人"
    JapaneseName: "掃地機器人"
  - Id: 20637
    Name: "故障的倉管"
    JapaneseName: "故障的倉管"
  - Id: 20639
    Name: "故障的警衛型α"
    JapaneseName: "故障的警衛型α"
  - Id: 20640
    Name: "掃地機器人Ω"
    JapaneseName: "掃地機器人Ω"
  - Id: 20641
    Name: "故障的掃地機器"
    JapaneseName: "故障的掃地機器"
  - Id: 20642
    Name: "斯威蒂"
    JapaneseName: "斯威蒂"
  - Id: 20643
    Name: "熱池劍魚"
    JapaneseName: "熱池劍魚"
  - Id: 20644
    Name: "熱池馬克"
    JapaneseName: "熱池馬克"
  - Id: 20645
    Name: "熱池異變魚"
    JapaneseName: "熱池異變魚"
  - Id: 20646
    Name: "熱池食人魚"
    JapaneseName: "熱池食人魚"
  - Id: 20648
    Name: "大王喵喵"
    JapaneseName: "大王喵喵"
  - Id: 20649
    Name: "紅肉食人火龍果"
    JapaneseName: "紅肉食人火龍果"
  - Id: 20650
    Name: "黃肉食人火龍果"
    JapaneseName: "黃肉食人火龍果"
  - Id: 20651
    Name: "藍肉食人火龍果"
    JapaneseName: "藍肉食人火龍果"
  - Id: 20652
    Name: "紫肉食人火龍果"
    JapaneseName: "紫肉食人火龍果"
  - Id: 20653
    Name: "綠肉食人火龍果"
    JapaneseName: "綠肉食人火龍果"
  - Id: 20659
    Name: "大王喵喵"
    JapaneseName: "大王喵喵"
  - Id: 20660
    Name: "海朵"
    JapaneseName: "海朵"
  - Id: 20661
    Name: "多多"
    JapaneseName: "多多"
  - Id: 20662
    Name: "小閃"
    JapaneseName: "小閃"
  - Id: 20663
    Name: "食人火龍果"
    JapaneseName: "食人火龍果"
  - Id: 20664
    Name: "大眼"
    JapaneseName: "大眼"
  - Id: 20665
    Name: "韋爾波泰"
    JapaneseName: "韋爾波泰"
  - Id: 20667
    Name: "席瓦帕皮利亞"
    JapaneseName: "席瓦帕皮利亞"
  - Id: 20669
    Name: "帕皮拉"
    JapaneseName: "帕皮拉"
  - Id: 20670
    Name: "帕皮拉"
    JapaneseName: "帕皮拉"
  - Id: 20671
    Name: "帕皮拉盧巴"
    JapaneseName: "帕皮拉盧巴"
  - Id: 20672
    Name: "帕皮拉盧巴"
    JapaneseName: "帕皮拉盧巴"
  - Id: 20673
    Name: "帕皮拉盧巴"
    JapaneseName: "帕皮拉盧巴"
  - Id: 20674
    Name: "帕皮拉凱依"
    JapaneseName: "帕皮拉凱依"
  - Id: 20675
    Name: "帕皮拉凱依"
    JapaneseName: "帕皮拉凱依"
  - Id: 20676
    Name: "帕皮拉凱依"
    JapaneseName: "帕皮拉凱依"
  - Id: 20677
    Name: "艾里厄斯"
    JapaneseName: "艾里厄斯"
  - Id: 20678
    Name: "艾里厄斯"
    JapaneseName: "艾里厄斯"
  - Id: 20679
    Name: "守護者零件"
    JapaneseName: "守護者零件"
  - Id: 20680
    Name: "邪心獵人偵察兵"
    JapaneseName: "邪心獵人偵察兵"
  - Id: 20681
    Name: "邪心獵人偵察兵"
    JapaneseName: "邪心獵人偵察兵"
  - Id: 20682
    Name: "邪心獵人偵察兵"
    JapaneseName: "邪心獵人偵察兵"
  - Id: 20683
    Name: "書蟲"
    JapaneseName: "書蟲"
  - Id: 20684
    Name: "流浪魔法書"
    JapaneseName: "流浪魔法書"
  - Id: 20685
    Name: "下水道貝納姆"
    JapaneseName: "下水道貝納姆"
  - Id: 20686
    Name: "下水道藍鼠"
    JapaneseName: "下水道藍鼠"
  - Id: 20687
    Name: "下水道瀑布"
    JapaneseName: "下水道瀑布"
  - Id: 20688
    Name: "菁英貝拉雷"
    JapaneseName: "菁英貝拉雷"
  - Id: 20689
    Name: "魔癮朵洛爾"
    JapaneseName: "魔癮朵洛爾"
  - Id: 20690
    Name: "釋放魔力"
    JapaneseName: "釋放魔力"
  - Id: 20691
    Name: "魔癮普拉加"
    JapaneseName: "魔癮普拉加"
  - Id: 20692
    Name: "魔癮薩納雷"
    JapaneseName: "魔癮薩納雷"
  - Id: 20693
    Name: "強大魔力"
    JapaneseName: "強大魔力"
  - Id: 20694
    Name: "尖銳魔力"
    JapaneseName: "尖銳魔力"
  - Id: 20699
    Name: "邪心獵人偷襲兵"
    JapaneseName: "邪心獵人偷襲兵"
  - Id: 20773
    Name: "體諒墮天使"
    JapaneseName: "體諒墮天使"
  - Id: 20774
    Name: "幸福墮天使"
    JapaneseName: "幸福墮天使"
  - Id: 20775
    Name: "達納托斯的憤怒"
    JapaneseName: "達納托斯的憤怒"
  - Id: 20776
    Name: "達納托斯的恐懼"
    JapaneseName: "達納托斯的恐懼"
  - Id: 20777
    Name: "達納托斯的怨恨"
    JapaneseName: "達納托斯的怨恨"
  - Id: 20778
    Name: "達納托斯的後悔"
    JapaneseName: "達納托斯的後悔"
  - Id: 20779
    Name: "惡靈邪惡箱"
    JapaneseName: "惡靈邪惡箱"
  - Id: 20780
    Name: "亡靈魔書"
    JapaneseName: "亡靈魔書"
  - Id: 20781
    Name: "千年老妖"
    JapaneseName: "千年老妖"
  - Id: 20782
    Name: "鴉魔首領"
    JapaneseName: "鴉魔首領"
  - Id: 20783
    Name: "鴉魔男爵"
    JapaneseName: "鴉魔男爵"
  - Id: 20784
    Name: "魔劍士 達納托斯"
    JapaneseName: "魔劍士 達納托斯"
  - Id: 20787
    Name: "體諒墮天使"
    JapaneseName: "體諒墮天使"
  - Id: 20788
    Name: "帶來幸福者"
    JapaneseName: "帶來幸福者"
  - Id: 20789
    Name: "代行刑者"
    JapaneseName: "代行刑者"
  - Id: 20790
    Name: "安息者"
    JapaneseName: "安息者"
  - Id: 20791
    Name: "慰勞者"
    JapaneseName: "慰勞者"
  - Id: 20792
    Name: "達納托斯塔的憤"
    JapaneseName: "達納托斯塔的憤"
  - Id: 20793
    Name: "達納托斯塔的恐"
    JapaneseName: "達納托斯塔的恐"
  - Id: 20794
    Name: "達納托斯塔的怨"
    JapaneseName: "達納托斯塔的怨"
  - Id: 20795
    Name: "達納托斯塔的後"
    JapaneseName: "達納托斯塔的後"
  - Id: 20796
    Name: "達納托斯塔的憎"
    JapaneseName: "達納托斯塔的憎"
  - Id: 20797
    Name: "達納托斯的絕望"
    JapaneseName: "達納托斯的絕望"
  - Id: 20798
    Name: "達納托斯塔的悲"
    JapaneseName: "達納托斯塔的悲"
  - Id: 20799
    Name: "達納托斯塔的苦"
    JapaneseName: "達納托斯塔的苦"
  - Id: 20800
    Name: "監視者"
    JapaneseName: "監視者"
  - Id: 20801
    Name: "深海電鰻"
    JapaneseName: "深海電鰻"
  - Id: 20802
    Name: "深海人魚"
    JapaneseName: "深海人魚"
  - Id: 20803
    Name: "深海狄奧斯"
    JapaneseName: "深海狄奧斯"
  - Id: 20804
    Name: "深海烏賊"
    JapaneseName: "深海烏賊"
  - Id: 20805
    Name: "深海人魚士兵"
    JapaneseName: "深海人魚士兵"
  - Id: 20806
    Name: "深海賽杜拉"
    JapaneseName: "深海賽杜拉"
  - Id: 20807
    Name: "深海異變魚"
    JapaneseName: "深海異變魚"
  - Id: 20808
    Name: "深海海神"
    JapaneseName: "深海海神"
  - Id: 20809
    Name: "深海劍魚"
    JapaneseName: "深海劍魚"
  - Id: 20810
    Name: "深海大腳龍蝦"
    JapaneseName: "深海大腳龍蝦"
  - Id: 20811
    Name: "深海魔鬼大烏賊"
    JapaneseName: "深海魔鬼大烏賊"
  - Id: 20843
    Name: "深海魔女"
    JapaneseName: "深海魔女"
  - Id: 20844
    Name: "祈願墮天使"
    JapaneseName: "祈願墮天使"
  - Id: 20845
    Name: "歡笑墮天使"
    JapaneseName: "歡笑墮天使"
  - Id: 20919
    Name: "噩夢小丑皇"
    JapaneseName: "噩夢小丑皇"
  - Id: 20934
    Name: "R001-貝斯蒂亞"
    JapaneseName: "R001-貝斯蒂亞"
  - Id: 21064
    Name: "測試用魔物(小型)"
    JapaneseName: "測試用魔物(小型)"
  - Id: 21065
    Name: "測試用魔物(中型)"
    JapaneseName: "測試用魔物(中型)"
  - Id: 21066
    Name: "測試用魔物(大型)"
    JapaneseName: "測試用魔物(大型)"
  - Id: 21067
    Name: "測試用魔物(無型)"
    JapaneseName: "測試用魔物(無型)"
  - Id: 21068
    Name: "測試用魔物(龍族)"
    JapaneseName: "測試用魔物(龍族)"
  - Id: 21069
    Name: "測試用魔物(動物"
    JapaneseName: "測試用魔物(動物"
  - Id: 21070
    Name: "測試用魔物(人類"
    JapaneseName: "測試用魔物(人類"
  - Id: 21071
    Name: "測試用魔物(昆蟲"
    JapaneseName: "測試用魔物(昆蟲"
  - Id: 21072
    Name: "測試用魔物(魚貝"
    JapaneseName: "測試用魔物(魚貝"
  - Id: 21073
    Name: "測試用魔物(惡魔"
    JapaneseName: "測試用魔物(惡魔"
  - Id: 21074
    Name: "測試用魔物(植物"
    JapaneseName: "測試用魔物(植物"
  - Id: 21075
    Name: "測試用魔物(天使"
    JapaneseName: "測試用魔物(天使"
  - Id: 21076
    Name: "測試用魔物(不死"
    JapaneseName: "測試用魔物(不死"
  - Id: 21077
    Name: "測試用魔物(無屬"
    JapaneseName: "測試用魔物(無屬"
  - Id: 21078
    Name: "測試用魔物(水屬"
    JapaneseName: "測試用魔物(水屬"
  - Id: 21079
    Name: "測試用魔物(地屬"
    JapaneseName: "測試用魔物(地屬"
  - Id: 21080
    Name: "測試用魔物(火屬"
    JapaneseName: "測試用魔物(火屬"
  - Id: 21081
    Name: "測試用魔物(風屬"
    JapaneseName: "測試用魔物(風屬"
  - Id: 21082
    Name: "測試用魔物(毒屬"
    JapaneseName: "測試用魔物(毒屬"
  - Id: 21083
    Name: "測試用魔物(聖屬"
    JapaneseName: "測試用魔物(聖屬"
  - Id: 21084
    Name: "測試用魔物(暗屬"
    JapaneseName: "測試用魔物(暗屬"
  - Id: 21085
    Name: "測試用魔物(念屬"
    JapaneseName: "測試用魔物(念屬"
  - Id: 21086
    Name: "測試用魔物(不死"
    JapaneseName: "測試用魔物(不死"
"""
