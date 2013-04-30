package managers 
{
	import flash.display.Bitmap;
	/**
	 * a library class to deal with images
	 * 
	 * the majority of this class is static so that it can be referenced anywhere within the 
	 *  project without having to initialize a manager object
	 * 
	 * @author Kyler Mulherin
	 */
	
	 
	public class ImageManager extends Manager 
	{
		//IMAGE FILES ARE EMBEDDED AT COMPILE TIME, NOT AT RUN-TIME
		[Embed(source = "../../lib/traffic-cones.png", 									mimeType = "image/png")] 	private static var ImgMissing:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconCastle.png", 			mimeType = "image/png")] 	private static var ImgIconCastle:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconScroll.png", 			mimeType = "image/png")] 	private static var ImgIconScroll:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconWizard.png", 			mimeType = "image/png")] 	private static var ImgIconWizard:Class; 
		[Embed(source = "../../lib/sprites/navigation/panels/backgroundCavern.png", 	mimeType = "image/png")] 	private static var ImgBackgroundCavern:Class; 
		[Embed(source = "../../lib/sprites/navigation/panels/titleScreen.png", 			mimeType = "image/png")] 	private static var ImgTitleScreen:Class; 
		
		//ENEMIES
		//canyon
		[Embed(source = "../../lib/sprites/enemies/canyon/boss/ragenfyreFLAMEON.png", 			mimeType = "image/png")] 	private static var ImgCanyonBossRagenFyre:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/boss/ragenfyreTheImmortal.png",	 	mimeType = "image/png")] 	private static var ImgCanyonBossRagenFyre2:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/common/burrower.png", 				mimeType = "image/png")] 	private static var ImgCanyonCommonBurrower:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/common/goblinFighter.png", 			mimeType = "image/png")] 	private static var ImgCanyonCommonGoblinFighter:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/common/goblinSlinger.png", 			mimeType = "image/png")] 	private static var ImgCanyonCommonGoblinSlinger:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/common/sandGoblinArcher.png", 		mimeType = "image/png")] 	private static var ImgCanyonCommonSandGoblinArcher:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/common/sandGoblinSpearman.png", 		mimeType = "image/png")] 	private static var ImgCanyonCommonSandGoblinSpearman:Class; 
		[Embed(source = "../../lib/sprites/enemies/canyon/uncommon/goblinFanatic.png", 			mimeType = "image/png")] 	private static var ImgCanyonUncommonGoblinFanatic:Class; 
		//cave
		[Embed(source = "../../lib/sprites/enemies/cave/boss/demonGoldy.png", 					mimeType = "image/png")] 	private static var ImgCaveBossDemonGoldy:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/burrower.png", 					mimeType = "image/png")] 	private static var ImgCaveCommonBurrower:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/goblinArcher.png", 				mimeType = "image/png")] 	private static var ImgCaveCommonGoblinArcher:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/goblinSlinger.png", 				mimeType = "image/png")] 	private static var ImgCaveCommonGoblinSlinger:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/goblinSpearman.png", 			mimeType = "image/png")] 	private static var ImgCaveCommonGoblinSpearman:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/goblinWarrior.png", 				mimeType = "image/png")] 	private static var ImgCaveCommonGoblinWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/impGreen.png", 					mimeType = "image/png")] 	private static var ImgCaveCommonImpGreen:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/moltenWarrior.png", 				mimeType = "image/png")] 	private static var ImgCaveCommonMoltenWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/common/skeletonWarrior.png", 			mimeType = "image/png")] 	private static var ImgCaveCommonSkeletonWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/uncommon/goblinFanatic.png", 			mimeType = "image/png")] 	private static var ImgCaveUncommonGoblinFanatic:Class; 
		[Embed(source = "../../lib/sprites/enemies/cave/uncommon/skeletonMage.png", 			mimeType = "image/png")] 	private static var ImgCaveUncommonSkeletonMage:Class; 
		//desert
		[Embed(source = "../../lib/sprites/enemies/desert/boss/nackacrong.png", 				mimeType = "image/png")] 	private static var ImgDesertBossNackacrong:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/boss/nackacrongHelmed.png",			mimeType = "image/png")] 	private static var ImgDesertBossNackacrongHelmed:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/common/burrower.png", 				mimeType = "image/png")] 	private static var ImgDesertCommonBurrower:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/common/carrionFeeder.png", 			mimeType = "image/png")] 	private static var ImgDesertCommonCarrionFeeder:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/common/sandGoblinArcher.png", 		mimeType = "image/png")] 	private static var ImgDesertCommonSandGoblinArcher:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/common/sandGoblinFighter.png", 		mimeType = "image/png")] 	private static var ImgDesertCommonSandGoblinFighter:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/common/sandGoblinSpearman.png", 		mimeType = "image/png")] 	private static var ImgDesertCommonSandGoblinSpearman:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/rare/scorpio.png", 					mimeType = "image/png")] 	private static var ImgDesertRareScorpio:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/rare/vrack.png", 						mimeType = "image/png")] 	private static var ImgDesertRareVrack:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/uncommon/burrowerSpiked.png", 		mimeType = "image/png")] 	private static var ImgDesertUncommonBurrowerSpiked:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/uncommon/sandGoblinAssassin.png",		mimeType = "image/png")] 	private static var ImgDesertUncommonSandGoblinAssassin:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/uncommon/sandGoblinAssassin2.png",	mimeType = "image/png")] 	private static var ImgDesertUncommonSandGoblinAssassin2:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/uncommon/scarabBrute.png", 			mimeType = "image/png")] 	private static var ImgDesertUncommonScarabBrute:Class; 
		[Embed(source = "../../lib/sprites/enemies/desert/uncommon/scarabGiant.png", 			mimeType = "image/png")] 	private static var ImgDesertUncommonScarabGiant:Class; 
		//forest
		[Embed(source = "../../lib/sprites/enemies/forest/boss/mossTroll.png", 					mimeType = "image/png")] 	private static var ImgForestBossMossTroll:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/gnarlerBlocker.png", 			mimeType = "image/png")] 	private static var ImgForestCommonGnarlerBlocker:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/gnarlerWarrior.png", 			mimeType = "image/png")] 	private static var ImgForestCommonGnarlerWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/impPurple.png", 				mimeType = "image/png")] 	private static var ImgForestCommonImgPurple:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/spiderJumper1.png", 			mimeType = "image/png")] 	private static var ImgForestCommonSpiderJumper1:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/spiderJumper2.png", 			mimeType = "image/png")] 	private static var ImgForestCommonSpiderJumper2:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/common/wolfDemon.png", 				mimeType = "image/png")] 	private static var ImgForestCommonWolfDemon:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/rare/bigFoot.png", 					mimeType = "image/png")] 	private static var ImgForestRareBigFoot:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/rare/forestRaptor.png", 				mimeType = "image/png")] 	private static var ImgForestRareForestRaptor:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/uncommon/dryad.png", 					mimeType = "image/png")] 	private static var ImgForestUncommonDryad:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/uncommon/gnarlerSage.png", 			mimeType = "image/png")] 	private static var ImgForestUncommonGnarlerSage:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/uncommon/wildboar.png", 				mimeType = "image/png")] 	private static var ImgForestUncommonWildBoar:Class; 
		[Embed(source = "../../lib/sprites/enemies/forest/uncommon/wolfAlpha.png", 				mimeType = "image/png")] 	private static var ImgForestUncommonWolfAlpha:Class; 
		//hill
		[Embed(source = "../../lib/sprites/enemies/hills/boss/shaneTheWizard.png", 				mimeType = "image/png")] 	private static var ImgHillBossShaneTheWizard:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/boss/shaneTheWizardwithElemental.png", mimeType = "image/png")] 	private static var ImgHillBossShaneTheWizardWithElemental:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/common/vargath.png", 					mimeType = "image/png")] 	private static var ImgHillCommonVargath:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/common/wolfDemon.png", 				mimeType = "image/png")] 	private static var ImgHillCommonWolfDemon:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/rare/yeti.png", 						mimeType = "image/png")] 	private static var ImgHillRareYeti:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/uncommon/vargathBrute.png", 			mimeType = "image/png")] 	private static var ImgHillUncommonVargathBrute:Class; 
		[Embed(source = "../../lib/sprites/enemies/hills/uncommon/wolfAlpha.png", 				mimeType = "image/png")] 	private static var ImgHillUncommonWolfAlpha:Class; 
		//mountains
		[Embed(source = "../../lib/sprites/enemies/mountain/boss/moltenBeast.png", 				mimeType = "image/png")] 	private static var ImgMountainBossMoltenBeast:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/common/goblinBasic.png", 			mimeType = "image/png")] 	private static var ImgMountainCommonGoblinBasic:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/common/moltenMan.png", 				mimeType = "image/png")] 	private static var ImgMountainCommonMoltenMan:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/common/moltenWarrior.png", 			mimeType = "image/png")] 	private static var ImgMountainCommonMoltenWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/rare/moltenThug.png", 				mimeType = "image/png")] 	private static var ImgMountainRareMoltenThug:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/rare/roc.png", 						mimeType = "image/png")] 	private static var ImgMountainRareRoc:Class; 
		[Embed(source = "../../lib/sprites/enemies/mountain/uncommon/spikedBurrower.png", 		mimeType = "image/png")] 	private static var ImgMountainUncommonSpikedBurrower:Class; 
		//plains
		[Embed(source = "../../lib/sprites/enemies/plains/common/hobtaVanguard.png", 			mimeType = "image/png")] 	private static var ImgPlainsCommonHobtaVanguard:Class; 
		[Embed(source = "../../lib/sprites/enemies/plains/common/wolfDemonWhite.png", 			mimeType = "image/png")] 	private static var ImgPlainsCommonWolfDemonWhite:Class; 
		[Embed(source = "../../lib/sprites/enemies/plains/rare/beloom.png", 					mimeType = "image/png")] 	private static var ImgPlainsRareBeloom:Class; 
		[Embed(source = "../../lib/sprites/enemies/plains/rare/raptorDune.png", 				mimeType = "image/png")] 	private static var ImgPlainsRareRaptorDune:Class; 
		//savannah
		[Embed(source = "../../lib/sprites/enemies/savannah/common/carrionFeeder.png", 			mimeType = "image/png")] 	private static var ImgSavannahCommonCarrionFeeder:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/common/gnarlerBlocker.png", 		mimeType = "image/png")] 	private static var ImgSavannahCommonGnarlerBlocker:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/common/gnarlerWarrior.png", 		mimeType = "image/png")] 	private static var ImgSavannahCommonGnarlerWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/common/leonaiGuardian.png", 		mimeType = "image/png")] 	private static var ImgSavannahCommonLeoniaGuardian:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/common/leonaiSunSage.png", 			mimeType = "image/png")] 	private static var ImgSavannahCommonLeoniaSunSage:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/common/wildCat.png", 				mimeType = "image/png")] 	private static var ImgSavannahCommonWildCat:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/rare/bezzle.png", 					mimeType = "image/png")] 	private static var ImgSavannahRareBezzle:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/rare/elephantMonster.png", 			mimeType = "image/png")] 	private static var ImgSavannahRareElephantMonster:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/hyenaBeast.png", 			mimeType = "image/png")] 	private static var ImgSavannahUncommonHyenaBeast:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/leonaiHuntress.png", 		mimeType = "image/png")] 	private static var ImgSavannahUncommonLeonaiHuntress:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/leonaiSunPriest.png", 		mimeType = "image/png")] 	private static var ImgSavannahUncommonLeonaiSunPriest:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/lionBeast.png", 			mimeType = "image/png")] 	private static var ImgSavannahUncommonLionBeast:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/scarabBrute.png", 			mimeType = "image/png")] 	private static var ImgSavannahUncommonScarabBrute:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/scarabGiant.png", 			mimeType = "image/png")] 	private static var ImgSavannahUncommonScarabGiant:Class; 
		[Embed(source = "../../lib/sprites/enemies/savannah/uncommon/wildBoar.png", 			mimeType = "image/png")] 	private static var ImgSavannahUncommonWildBoar:Class; 
		//swamp
		[Embed(source = "../../lib/sprites/enemies/swamp/boss/kramTheSpine.png", 				mimeType = "image/png")] 	private static var ImgSwampBossKramTheSpine:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/drakkonFrenzyWarrior.png", 		mimeType = "image/png")] 	private static var ImgSwampCommonDrakkonFrenzyWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/drakkonMen.png", 				mimeType = "image/png")] 	private static var ImgSwampCommonDrakkonMen:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/gnarlerBlocker.png", 			mimeType = "image/png")] 	private static var ImgSwampCommonGnarlerBlocker:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/gnarlerWarrior.png", 			mimeType = "image/png")] 	private static var ImgSwampCommonGnarlerWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/impBrown.png", 					mimeType = "image/png")] 	private static var ImgSwampCommonImpBrown:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/skeletonArcher.png", 			mimeType = "image/png")] 	private static var ImgSwampCommonSkeletonArcher:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/skeletonWarrior.png", 			mimeType = "image/png")] 	private static var ImgSwampCommonSkeletonWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/common/zombie.png", 					mimeType = "image/png")] 	private static var ImgSwampCommonZombie:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/uncommon/drakkonHonorGuard.png", 		mimeType = "image/png")] 	private static var ImgSwampUncommonDrakkonHonorGuard:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/uncommon/gnarlerSage.png", 			mimeType = "image/png")] 	private static var ImgSwampUncommonGnarlerSage:Class; 
		[Embed(source = "../../lib/sprites/enemies/swamp/uncommon/skeletonMage.png", 			mimeType = "image/png")] 	private static var ImgSwampUncommonSkeletonMage:Class; 
		//wetlands
		[Embed(source = "../../lib/sprites/enemies/wetlands/boss/Kylaaa.png", 					mimeType = "image/png")] 	private static var ImgWetlandsBossKylaaa:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/boss/KylaaaArmored.png", 			mimeType = "image/png")] 	private static var ImgWetlandsBossKylaaaArmored:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/common/drakkonFrenzyWarrior.png", 	mimeType = "image/png")] 	private static var ImgWetlandsCommonDrakkonFrenzyWarrior:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/common/drakkonSpearman.png", 		mimeType = "image/png")] 	private static var ImgWetlandsCommonDrakkonSpearman:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/common/hobtaVanguard.png", 			mimeType = "image/png")] 	private static var ImgWetlandsCommonHobtaVanguard:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/common/impBlue.png", 				mimeType = "image/png")] 	private static var ImgWetlandsCommonImpBlue:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/common/wolfDemonWhite.png", 		mimeType = "image/png")] 	private static var ImgWetlandsCommonWolfDemonWhite:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/rare/drakkonVoodoo.png", 			mimeType = "image/png")] 	private static var ImgWetlandsRareDrakkonVoodoo:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/rare/werewolfWhite.png", 			mimeType = "image/png")] 	private static var ImgWetlandsRareWerewolfWhite:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/uncommon/drakkonHonorGuard.png", 	mimeType = "image/png")] 	private static var ImgWetlandsUncommonDrakkonHonorGuard:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/uncommon/hobtaFighter.png", 		mimeType = "image/png")] 	private static var ImgWetlandsUncommonHobtaFighter:Class; 
		[Embed(source = "../../lib/sprites/enemies/wetlands/uncommon/wolfAlphaWhite.png", 		mimeType = "image/png")] 	private static var ImgWetlandsUncommonWolfAlphaWhite:Class; 
		
		//HEROES
		//need to import the heroes here
		
		//accessors
		public static function Nothing():Bitmap										{ return new Bitmap(); }					//debug graphics
		public static function MissingImage():Bitmap 								{ return new ImgMissing(); }
		public static function BackgroundCavern():Bitmap							{ return new ImgBackgroundCavern(); } 		//background images
		public static function TitleScreen():Bitmap									{ return new ImgTitleScreen(); }
		public static function IconCastle():Bitmap 									{ return new ImgIconCastle(); }				//navigation icons
		public static function IconScroll():Bitmap 									{ return new ImgIconScroll(); }
		public static function IconWizard():Bitmap 									{ return new ImgIconWizard(); }
		public static function EnemyCanyonBossRagenFyre():Bitmap					{ return new ImgCanyonBossRagenFyre(); }	//enemies
		public static function EnemyCanyonBossRagenFyre2():Bitmap					{ return new ImgCanyonBossRagenFyre2(); }
		public static function EnemyCanyonCommonBurrower():Bitmap					{ return new ImgCanyonCommonBurrower(); }
		public static function EnemyCanyonCommonGoblinFighter():Bitmap				{ return new ImgCanyonCommonGoblinFighter(); }
		public static function EnemyCanyonCommonGoblinSlinger():Bitmap				{ return new ImgCanyonCommonGoblinSlinger(); }
		public static function EnemyCanyonCommonSandGoblinArcher():Bitmap			{ return new ImgCanyonCommonSandGoblinArcher(); }
		public static function EnemyCanyonCommonSandGoblinSpearman():Bitmap			{ return new ImgCanyonCommonSandGoblinSpearman(); }
		public static function EnemyCanyonUncommonGoblinFanatic():Bitmap			{ return new ImgCanyonUncommonGoblinFanatic(); }
		public static function EnemyCaveBossDemonGoldy():Bitmap						{ return new ImgCaveBossDemonGoldy(); }
		public static function EnemyCaveCommonBurrower():Bitmap						{ return new ImgCaveCommonBurrower(); }
		public static function EnemyCaveCommonGoblinArcher():Bitmap					{ return new ImgCaveCommonGoblinArcher(); }
		public static function EnemyCaveCommonGoblinSlinger():Bitmap				{ return new ImgCaveCommonGoblinSlinger(); }
		public static function EnemyCaveCommonGoblinSpearman():Bitmap				{ return new ImgCaveCommonGoblinSpearman(); }
		public static function EnemyCaveCommonGoblinWarrior():Bitmap				{ return new ImgCaveCommonGoblinWarrior(); }
		public static function EnemyCaveCommonImpGreen():Bitmap						{ return new ImgCaveCommonImpGreen(); }
		public static function EnemyCaveCommonMoltenWarrior():Bitmap				{ return new ImgCaveCommonMoltenWarrior(); }
		public static function EnemyCaveCommonSkeletonWarrior():Bitmap				{ return new ImgCaveCommonSkeletonWarrior(); }
		public static function EnemyCaveUncommonGoblinFanatic():Bitmap				{ return new ImgCaveUncommonGoblinFanatic(); }
		public static function EnemyCaveUncommonSkeletonMage():Bitmap				{ return new ImgCaveUncommonSkeletonMage(); }
		public static function EnemyDesertBossNackacrong():Bitmap					{ return new ImgDesertBossNackacrong(); }
		public static function EnemyDesertBossNackacrongHelmed():Bitmap				{ return new ImgDesertBossNackacrongHelmed(); }
		public static function EnemyDesertCommonBurrower():Bitmap					{ return new ImgDesertCommonBurrower(); }
		public static function EnemyDesertCommonCarrionFeeder():Bitmap				{ return new ImgDesertCommonCarrionFeeder(); }
		public static function EnemyDesertCommonSandGoblinArcher():Bitmap			{ return new ImgDesertCommonSandGoblinArcher(); }
		public static function EnemyDesertCommonSandGoblinSpearman():Bitmap			{ return new ImgDesertCommonSandGoblinSpearman(); }
		public static function EnemyDesertRareScorpio():Bitmap						{ return new ImgDesertRareScorpio(); }
		public static function EnemyDesertRareVrack():Bitmap						{ return new ImgDesertRareVrack(); }
		public static function EnemyDesertUncommonBurrowerSpiked():Bitmap			{ return new ImgDesertUncommonBurrowerSpiked(); }
		public static function EnemyDesertUncommonSandGoblinAssassin():Bitmap		{ return new ImgDesertUncommonSandGoblinAssassin(); }
		public static function EnemyDesertUncommonSandGoblinAssassin2():Bitmap		{ return new ImgDesertUncommonSandGoblinAssassin2(); }
		public static function EnemyDesertUncommonScarabBrute():Bitmap				{ return new ImgDesertUncommonScarabBrute(); }
		public static function EnemyDesertUncommonScarabGiant():Bitmap				{ return new ImgDesertUncommonScarabGiant(); }
		public static function EnemyForestBossMossTroll():Bitmap					{ return new ImgForestBossMossTroll(); }
		public static function EnemyForestCommonGnarlerBlocker():Bitmap				{ return new ImgForestCommonGnarlerBlocker(); }
		public static function EnemyForestCommonGnarlerWarrior():Bitmap				{ return new ImgForestCommonGnarlerWarrior(); }
		public static function EnemyForestCommonImpPurple():Bitmap					{ return new ImgForestCommonImgPurple(); }
		public static function EnemyForestCommonSpiderJumper1():Bitmap				{ return new ImgForestCommonSpiderJumper1(); }
		public static function EnemyForestCommonSpiderJumper2():Bitmap				{ return new ImgForestCommonSpiderJumper2(); }
		public static function EnemyForestCommonWolfDemon():Bitmap					{ return new ImgForestCommonWolfDemon(); }
		public static function EnemyForestRareBigFoot():Bitmap						{ return new ImgForestRareBigFoot(); }
		public static function EnemyForestRareForestRaptor():Bitmap					{ return new ImgForestRareForestRaptor(); }
		public static function EnemyForestUncommonDryad():Bitmap					{ return new ImgForestUncommonDryad(); }
		public static function EnemyForestUncommonGnarlerSage():Bitmap				{ return new ImgForestUncommonGnarlerSage(); }
		public static function EnemyForestUncommonWildBoar():Bitmap					{ return new ImgForestUncommonWildBoar(); }
		public static function EnemyForestUncommonWolfAlpha():Bitmap				{ return new ImgForestUncommonWolfAlpha(); }
		public static function EnemyHillsBossShaneTheWizard():Bitmap				{ return new ImgHillBossShaneTheWizard(); }
		public static function EnemyHillsBossShaneTheWizardWithElemental():Bitmap	{ return new ImgHillBossShaneTheWizardWithElemental(); }
		public static function EnemyHillsCommonVargath():Bitmap						{ return new ImgHillCommonVargath(); }
		public static function EnemyHillsCommonWolfDemon():Bitmap					{ return new ImgHillCommonWolfDemon(); }
		public static function EnemyHillsRareYeti():Bitmap							{ return new ImgHillRareYeti(); }
		public static function EnemyHillsUncommonVargathBrute():Bitmap				{ return new ImgHillUncommonVargathBrute(); }
		public static function EnemyHillsUncommonWolfAlpha():Bitmap					{ return new ImgHillUncommonWolfAlpha(); }
		public static function EnemyMountiansBossMoltenBeast():Bitmap				{ return new ImgMountainBossMoltenBeast(); }
		public static function EnemyMountiansCommonGoblinBasic():Bitmap				{ return new ImgMountainCommonGoblinBasic(); }
		public static function EnemyMountiansCommonMoltenMan():Bitmap				{ return new ImgMountainCommonMoltenMan(); }
		public static function EnemyMountiansCommonMoltenWarrior():Bitmap			{ return new ImgMountainCommonMoltenWarrior(); }
		public static function EnemyMountiansRareMoltenThug():Bitmap				{ return new ImgMountainRareMoltenThug(); }
		public static function EnemyMountiansRareRoc():Bitmap						{ return new ImgMountainRareRoc(); }
		public static function EnemyMountiansUncommonSpikedBurrower():Bitmap		{ return new ImgMountainUncommonSpikedBurrower(); }
		public static function EnemyPlainsCommonCommonHobtaVanguard():Bitmap		{ return new ImgPlainsCommonHobtaVanguard(); }
		public static function EnemyPlainCommonsWolfDemonWhite():Bitmap				{ return new ImgPlainsCommonWolfDemonWhite(); }
		public static function EnemyPlainsRareBeloom():Bitmap						{ return new ImgPlainsRareBeloom(); }
		public static function EnemyPlainsRareRaptorDune():Bitmap					{ return new ImgPlainsRareRaptorDune(); }
		public static function EnemySavannahCommonCarrionFeeder():Bitmap			{ return new ImgSavannahCommonCarrionFeeder(); }
		public static function EnemySavannahCommonGnarlerBlocker():Bitmap			{ return new ImgSavannahCommonGnarlerBlocker(); }
		public static function EnemySavannahCommonGnarlerWarrior():Bitmap			{ return new ImgSavannahCommonGnarlerWarrior(); }
		public static function EnemySavannahCommonLeonaiGuardian():Bitmap			{ return new ImgSavannahCommonLeoniaGuardian(); }
		public static function EnemySavannahCommonLeonaiSunSage():Bitmap			{ return new ImgSavannahCommonLeoniaSunSage(); }
		public static function EnemySavannahCommonWildCat():Bitmap					{ return new ImgSavannahCommonWildCat(); }
		public static function EnemySavannahRareBezzle():Bitmap						{ return new ImgSavannahRareBezzle(); }
		public static function EnemySavannaRareElephantMonster():Bitmap				{ return new ImgSavannahRareElephantMonster(); }
		public static function EnemySavannahUncommonHyenaBeast():Bitmap				{ return new ImgSavannahUncommonHyenaBeast(); }
		public static function EnemySavannahUncommonLeonaiHuntress():Bitmap			{ return new ImgSavannahUncommonLeonaiHuntress(); }
		public static function EnemySavannahUncommonLeonaiSunPriest():Bitmap		{ return new ImgSavannahUncommonLeonaiSunPriest(); }
		public static function EnemySavannahUncommonLionBeast():Bitmap				{ return new ImgSavannahUncommonLionBeast(); }
		public static function EnemySavannahUncommonScarabBrute():Bitmap			{ return new ImgSavannahUncommonScarabBrute(); }
		public static function EnemySavannahUncommonScarabGiant():Bitmap			{ return new ImgSavannahUncommonScarabGiant(); }
		public static function EnemySavannahUncommonWildBoard():Bitmap				{ return new ImgSavannahUncommonWildBoar(); }
		public static function EnemySwampBossKramTheSpine():Bitmap					{ return new ImgSwampBossKramTheSpine(); }
		public static function EnemySwampCommonDrakkonFrenzyWarrior():Bitmap		{ return new ImgSwampCommonDrakkonFrenzyWarrior(); }
		public static function EnemySwampCommonDrakkonMen():Bitmap					{ return new ImgSwampCommonDrakkonMen(); }
		public static function EnemySwampCommonGnarlerBlocker():Bitmap				{ return new ImgSwampCommonGnarlerBlocker(); }
		public static function EnemySwampCommonGnarlerWarrior():Bitmap				{ return new ImgSwampCommonGnarlerWarrior(); }
		public static function EnemySwampCommonImpBrown():Bitmap					{ return new ImgSwampCommonImpBrown(); }
		public static function EnemySwampCommonSkeletonArcher():Bitmap				{ return new ImgSwampCommonSkeletonArcher(); }
		public static function EnemySwampCommonSkeletonWarrior():Bitmap				{ return new ImgSwampCommonSkeletonWarrior(); }
		public static function EnemySwampCommonZombie():Bitmap						{ return new ImgSwampCommonZombie(); }
		public static function EnemySwampUncommonDrakkonHonorGuard():Bitmap			{ return new ImgSwampUncommonDrakkonHonorGuard(); }
		public static function EnemySwampUncommonGnarlerSage():Bitmap				{ return new ImgSwampUncommonGnarlerSage(); }
		public static function EnemySwampUncommonSkeletonMage():Bitmap				{ return new ImgSwampUncommonSkeletonMage(); }
		public static function EnemyWetlandsBossKylaaa():Bitmap						{ return new ImgWetlandsBossKylaaa(); }
		public static function EnemyWetlandsBossKylaaaArmored():Bitmap				{ return new ImgWetlandsBossKylaaaArmored(); }
		public static function EnemyWetlandsCommonDrakkonFrenzyWarrior():Bitmap		{ return new ImgWetlandsCommonDrakkonFrenzyWarrior(); }
		public static function EnemyWetlandsCommonDrakkonSpearman():Bitmap			{ return new ImgWetlandsCommonDrakkonSpearman(); }
		public static function EnemyWetlandsCommonHobtaVanguard():Bitmap			{ return new ImgWetlandsCommonHobtaVanguard(); }
		public static function EnemyWetlandsCommonImpBlue():Bitmap					{ return new ImgWetlandsCommonImpBlue(); }
		public static function EnemyWetlandsCommonWolfDemonWhite():Bitmap			{ return new ImgWetlandsCommonWolfDemonWhite(); }
		public static function EnemyWetlandsRareDrakkonVoodoo():Bitmap				{ return new ImgWetlandsRareDrakkonVoodoo(); }
		public static function EnemyWetlandsRareWereWolfWhite():Bitmap				{ return new ImgWetlandsRareWerewolfWhite(); }
		public static function EnemyWetlandsUncommonDrakkonHonorGuard():Bitmap		{ return new ImgWetlandsUncommonDrakkonHonorGuard(); }
		public static function EnemyWetlandsUncommonHobtaFighter():Bitmap			{ return new ImgWetlandsUncommonHobtaFighter(); }
		public static function EnemyWetlandsUncommonWolfAlphaWhite():Bitmap			{ return new ImgWetlandsUncommonWolfAlphaWhite(); }
		
		
		
		
		
		private static var images:Object = new Array();
			images["nothing"]					= Nothing;				//debug
			images["traffic-cones.png"] 		= MissingImage;
			images["backgroundCavern.png"]		= BackgroundCavern;		//background images
			images["titleScreen.png"]			= TitleScreen;
			images["iconCastle.png"]			= IconCastle;           //navigation icons
			images["iconScroll.png"]			= IconScroll;
			images["iconWizard.png"]			= IconWizard;
			
			images["canyon/boss/ragenfyreFLAMEON.png"]				= EnemyCanyonBossRagenFyre;					//enemies
			images["canyon/boss/ragenfyreTheImmortal.png"] 			= EnemyCanyonBossRagenFyre2;				//NAMING FORMAT NEEDS TO MATCH 
			images["canyon/common/burrower.png"] 					= EnemyCanyonCommonBurrower;				// 	ONLINE DATABASE IMAGE PATH
			images["canyon/common/goblinFighter.png"] 				= EnemyCanyonCommonGoblinFighter;	
			images["canyon/common/goblinSlinger.png"] 				= EnemyCanyonCommonGoblinSlinger;	
			images["canyon/common/sandGoblinArcher.png"] 			= EnemyCanyonCommonSandGoblinArcher;	
			images["canyon/common/sandGoblinSpearman.png"] 			= EnemyCanyonCommonSandGoblinSpearman;	
			images["canyon/uncommon/goblinFanatic.png"] 			= MissingImage;	
			images["cave/boss/demonGoldy.png"] 						= MissingImage;	
			images["cave/common/burrower.png"] 						= MissingImage;	
			images["cave/common/goblinArcher.png"] 					= MissingImage;	
			images["cave/common/goblinSlinger.png"] 				= MissingImage;	
			images["cave/common/goblinSpearman.png"] 				= MissingImage;	
			images["cave/common/goblinWarrior.png"] 				= MissingImage;	
			images["cave/common/impGreen.png"] 						= MissingImage;	
			images["cave/common/moltenWarrior.png"] 				= MissingImage;	
			images["cave/common/skeletonWarrior.png"] 				= MissingImage;	
			images["cave/uncommon/goblinFanatic.png"] 				= MissingImage;	
			images["cave/uncommon/skeletonMage.png"] 				= MissingImage;	
			images["desert/boss/nackacrong.png"] 					= MissingImage;	
			images["desert/boss/nackacrongHelmed.png"] 				= MissingImage;	
			images["desert/common/burrower.png"] 					= MissingImage;	
			images["desert/common/carrionFeeder.png"] 				= MissingImage;	
			images["desert/common/sandGoblinArcher.png"] 			= MissingImage;	
			images["desert/common/sandGoblinFighter.png"] 			= MissingImage;	
			images["desert/common/sandGoblinSpearman.png"] 			= MissingImage;	
			images["desert/rare/scorpio.png"] 						= MissingImage;	
			images["desert/rare/vrack.png"] 						= MissingImage;	
			images["desert/uncommon/burrowerSpiked.png"] 			= MissingImage;	
			images["desert/uncommon/sandGoblinAssassin.png"] 		= MissingImage;	
			images["desert/uncommon/sandGoblinAssassin2.png"] 		= MissingImage;	
			images["desert/uncommon/scarabBrute.png"] 				= MissingImage;	
			images["desert/uncommon/scarabGiant.png"] 				= MissingImage;	
			images["forest/boss/mossTroll.png"] 					= MissingImage;	
			images["forest/common/gnarlerBlocker.png"] 				= MissingImage;	
			images["forest/common/gnarlerWarrior.png"] 				= MissingImage;	
			images["forest/common/impPurple.png"] 					= MissingImage;	
			images["forest/common/spiderJumper1.png"] 				= MissingImage;	
			images["forest/common/spiderJumper2.png"] 				= MissingImage;	
			images["forest/common/wolfDemon.png"] 					= MissingImage;	
			images["forest/rare/bigFoot.png"] 						= MissingImage;	
			images["forest/rare/forestRaptor.png"] 					= MissingImage;	
			images["forest/uncommon/dryad.png"] 					= MissingImage;	
			images["forest/uncommon/gnarlerSage.png"]		 		= MissingImage;	
			images["forest/uncommon/wildboar.png"] 					= MissingImage;	
			images["forest/uncommon/wolfAlpha.png"] 				= MissingImage;	
			images["hills/boss/shaneTheWizard.png"] 				= MissingImage;	
			images["hills/boss/shaneTheWizardwithElemental.png"] 	= MissingImage;	
			images["hills/common/vargath.png"] 						= MissingImage;	
			images["hills/common/wolfDemon.png"] 					= MissingImage;	
			images["hills/rare/yeti.png"] 							= MissingImage;	
			images["hills/uncommon/vargathBrute.png"] 				= MissingImage;	
			images["hills/uncommon/wolfAlpha.png"] 					= MissingImage;	
			images["mountain/boss/moltenBeast.png"] 				= MissingImage;	
			images["mountain/common/goblinBasic.png"] 				= MissingImage;	
			images["mountain/common/moltenMan.png"] 				= MissingImage;	
			images["mountain/common/moltenWarrior.png"] 			= MissingImage;	
			images["mountain/rare/moltenThug.png"] 					= MissingImage;	
			images["mountain/rare/roc.png"] 						= MissingImage;	
			images["mountain/uncommon/spikedBurrower.png"] 			= MissingImage;	
			images["plains/common/hobtaVanguard.png"] 				= MissingImage;	
			images["plains/common/wolfDemonWhite.png"] 				= MissingImage;	
			images["plains/rare/beloom.png"] 						= MissingImage;	
			images["plains/rare/raptorDune.png"] 					= MissingImage;	
			images["savannah/common/carrionFeeder.png"] 			= MissingImage;	
			images["savannah/common/gnarlerBlocker.png"] 			= MissingImage;	
			images["savannah/common/gnarlerWarrior.png"] 			= MissingImage;	
			images["savannah/common/leonaiGuardian.png"] 			= MissingImage;	
			images["savannah/common/leonaiSunSage.png"] 			= MissingImage;	
			images["savannah/common/wildCat.png"] 					= MissingImage;	
			images["savannah/rare/bezzle.png"] 						= MissingImage;	
			images["savannah/rare/elephantMonster.png"] 			= MissingImage;	
			images["savannah/uncommon/hyenaBeast.png"] 				= MissingImage;	
			images["savannah/uncommon/leonaiHuntress.png"] 			= MissingImage;	
			images["savannah/uncommon/leonaiSunPriest.png"] 		= MissingImage;	
			images["savannah/uncommon/lionBeast.png"] 				= MissingImage;	
			images["savannah/uncommon/scarabBrute.png"] 			= MissingImage;	
			images["savannah/uncommon/scarabGiant.png"] 			= MissingImage;	
			images["savannah/uncommon/wildBoar.png"] 				= MissingImage;	
			images["swamp/boss/kramTheSpine.png"] 					= MissingImage;	
			images["swamp/common/drakkonFrenzyWarrior.png"] 		= MissingImage;	
			images["swamp/common/drakkonMen.png"] 					= MissingImage;	
			images["swamp/common/gnarlerBlocker.png"] 				= MissingImage;	
			images["swamp/common/gnarlerWarrior.png"]		 		= MissingImage;	
			images["swamp/common/impBrown.png"] 					= MissingImage;	
			images["swamp/common/skeletonArcher.png"] 				= MissingImage;	
			images["swamp/common/skeletonWarrior.png"] 				= MissingImage;	
			images["swamp/common/zombie.png"] 						= MissingImage;	
			images["swamp/uncommon/drakkonHonorGuard.png"] 			= MissingImage;	
			images["swamp/uncommon/gnarlerSage.png"] 				= MissingImage;	
			images["swamp/uncommon/skeletonMage.png"] 				= MissingImage;	
			images["wetlands/boss/Kylaaa.png"] 						= MissingImage;	
			images["wetlands/boss/KylaaaArmored.png"] 				= MissingImage;	
			images["wetlands/common/drakkonFrenzyWarrior.png"] 		= MissingImage;	
			images["wetlands/common/drakkonSpearman.png"] 			= MissingImage;	
			images["wetlands/common/hobtaVanguard.png"] 			= MissingImage;	
			images["wetlands/common/impBlue.png"] 					= MissingImage;	
			images["wetlands/common/wolfDemonWhite.png"] 			= MissingImage;	
			images["wetlands/rare/drakkonVoodoo.png"] 				= MissingImage;	
			images["wetlands/rare/werewolfWhite.png"] 				= MissingImage;	
			images["wetlands/uncommon/drakkonHonorGuard.png"] 		= MissingImage;	
			images["wetlands/uncommon/hobtaFighter.png"] 			= MissingImage;	
			images["wetlands/uncommon/wolfAlphaWhite.png"] 			= MissingImage;	
				
			
			
		public static function getImageByName(fileName:String):Bitmap
		{
			if (images[fileName] == null) 
			{
				trace("getImageByName(" + fileName + ")...");
				trace("\t-missing bitmap.");
				return ImgMissing();
			}
			
			return (images[fileName] as Function).call();
		}
			
		public function ImageManager() 
		{
			
		}
		
		
		override public function cleanUp():void 
		{
			//super.cleanUp();
		}

		
		
		
	}

}