-- SouthPacific
-- Author: blkbutterfly74
-- DateCreated: 1/14/2023 10:25:54 PM
--------------------------------------------------------------
INSERT INTO Types
		(Type,					Kind)
VALUES	('MAPSIZE_MASSIVE',		'KIND_MAPSIZE');
-------------------------------------	
-- Maps
-------------------------------------	
INSERT INTO Maps
		(MapSizeType,			Name,							Description,						DefaultPlayers,	NumNaturalWonders,	GridWidth,	GridHeight,	PlateValue,	Continents)
VALUES	('MAPSIZE_MASSIVE',		'LOC_MAPSIZE_MASSIVE_NAME',		'LOC_MAPSIZE_MASSIVE_DESCRIPTION',	6,				4,					128,		95,			4,			3);

-- rejig HUGE size as default for south pacific
Update Maps SET DefaultPlayers = 6, NumNaturalWonders = 4, GridWidth = 128, GridHeight = 80, PlateValue = 4, Continents = 3 WHERE MapSizeType = 'MAPSIZE_HUGE';

-------------------------------------	
-- Map_GreatPersonClasses
-------------------------------------				
INSERT INTO Map_GreatPersonClasses
		(MapSizeType,			GreatPersonClassType,			MaxWorldInstances)
VALUES	('MAPSIZE_MASSIVE',		'GREAT_PERSON_CLASS_PROPHET',	4);
-------------------------------------	
-- Maps_XP2
-------------------------------------	
INSERT INTO Maps_XP2
		(MapSizeType,		CO2For1DegreeTempRise,	DesertPlotCountToLabel,	MountainPlotCountToLabel)
SELECT	'MAPSIZE_MASSIVE',	1000000,				5,						5 WHERE EXISTS (SELECT * FROM Technologies WHERE TechnologyType='TECH_SEASTEADS');

-- south pacific huge
Update Maps_XP2 Set CO2For1DegreeTempRise = 500000 where MapSizeType = 'MAPSIZE_HUGE';