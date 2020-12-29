-- SouthPacific
-- Author: blkbutterfly74
-- DateCreated: 12/21/2017 4:51:03 AM
-- Creates a Huge map of the South Pacific ocean
-- based off Caribbean map scripts
-- Thanks to Firaxis
-----------------------------------------------------------------------------

include "MapEnums"
include "MapUtilities"
include "MountainsCliffs"
include "RiversLakes"
include "FeatureGenerator"
include "TerrainGenerator"
include "NaturalWonderGenerator"
include "ResourceGenerator"
include "AssignStartingPlots"

--g_FEATURE_GIANTS_CAUSEWAY					= GetGameInfoIndex("Features", "FEATURE_GIANTS_CAUSEWAY");
--g_FEATURE_EYJAFJALLAJOKULL					= GetGameInfoIndex("Features", "FEATURE_EYJAFJALLAJOKULL");

local g_iW, g_iH;
local g_iFlags = {};
local g_continentsFrac = nil;
local g_iNumTotalLandTiles = 0; 
local landStrips = {
		{0, 78, 79},
		{0, 189, 192},
		{0, 196, 199},
		{1, 81, 81},
		{1, 191, 193},
		{1, 199, 199},
		{2, 84, 85},
		{2, 90, 90},
		{2, 192, 194},
		{3, 90, 90},
		{3, 193, 193},
		{4, 94, 95},
		{5, 93, 95},
		{5, 97, 98},
		{6, 97, 98},
		{6, 100, 100},
		{7, 100, 101},
		{8, 100, 100},
		{9, 102, 103},
		{10, 27, 28},
		{10, 102, 104},
		{10, 191, 191},
		{11, 190, 191},
		{12, 183, 184},
		{15, 75, 75},
		{19, 32, 32},
		{24, 34, 34},
		{25, 18, 19},
		{25, 24, 25},
		{25, 28, 29},
		{26, 18, 19},
		{26, 25, 25},
		{26, 27, 29},
		{26, 33, 34},
		{28, 26, 26},
		{28, 32, 34},
		{28, 194, 194},
		{29, 16, 16},
		{29, 28, 28},
		{29, 32, 32},
		{30, 25, 26},
		{30, 28, 29},
		{30, 34, 34},
		{31, 26, 26},
		{31, 36, 36},
		{32, 2, 3},
		{32, 30, 30},
		{32, 36, 36},
		{33, 5, 5},
		{33, 30, 32},
		{34, 5, 5},
		{34, 10, 10},
		{34, 31, 32},
		{34, 36, 38},
		{34, 10, 11},
		{35, 14, 14},
		{35, 88, 88},
		{36, 16, 16},
		{36, 33, 33},
		{36, 37, 38},
		{37, 1, 2},
		{37, 8, 9},
		{37, 20, 20},
		{37, 30, 30},
		{37, 32, 33},
		{37, 37, 37},
		{37, 89, 89},
		{39, 31, 32},
		{39, 92, 93},
		{41, 4, 4},
		{41, 40, 40},
		{41, 96, 96},
		{44, 40, 40},
		{44, 98, 99},
		{45, 39, 40},
		{45, 99, 99},
		{46, 4, 4},
		{46, 40, 40},
		{48, 41, 41},
		{49, 28, 28},
		{49, 43, 44},
		{50, 33, 33},
		{51, 43, 44},
		{51, 47, 47},
		{52, 45, 45},
		{53, 47, 47},
		{54, 70, 71},
		{55, 3, 4},
		{55, 65, 65},
		{56, 0, 0},
		{56, 104, 104},
		{57, 0, 0},
		{57, 5, 5},
		{57, 8, 8},
		{57, 13, 13},
		{57, 65, 65},
		{57, 69, 69},
		{57, 71, 71},
		{58, 3, 3},
		{58, 5, 5},
		{59, 13, 14},
		{59, 46, 46},
		{59, 102, 102},
		{60, 4, 5},
		{61, 5,  6},
		{62, 6, 6},
		{62, 8, 8},
		{63, 9, 10},
		{63, 12, 12},
		{63, 48, 48},
		{63, 51, 51},
		{64, 7, 7},
		{64, 12, 13},
		{64, 15, 15},
		{64, 50, 50},
		{64, 132, 132},
		{65, 9, 10},
		{65, 13, 14},
		{65, 16, 16},
		{65, 20, 20},
		{65, 52, 52},
		{65, 69, 69},
		{66, 0, 0},
		{66, 10, 10},
		{66, 16, 16},
		{66, 97, 98},
		{66, 133, 134},
		{67, 14, 14},
		{67, 17, 17},
		{67, 53, 53},
		{67, 71, 71},
		{67, 133, 133},
		{68, 14, 15},
		{68, 25, 26},
		{68, 28, 28},
		{68, 91, 91},
		{68, 113, 113},
		{68, 135, 135},
		{69, 0, 0},
		{69, 17, 18},
		{69, 91, 92},
		{69, 136, 136},
		{70, 6, 6},
		{70, 14, 14},
		{70, 18, 19},
		{70, 26, 26},
		{70, 53, 53},
		{70, 71, 71},
		{70, 82, 82},
		{71, 1, 2},
		{71, 14, 15},
		{71, 28, 28},
		{71, 34, 34},
		{71, 45, 45},
		{72, 55, 55},
		{72, 57, 57},
		{73, 15, 15},
		{73, 48, 48},
		{74, 15, 15},
		{74, 27, 27},
		{74, 61, 61},
		{74, 87, 87},
		{75, 29, 29},
		{75, 68, 69},
		{76, 29, 29},
		{76, 57, 58},
		{76, 69, 72},
		{76, 74, 75},
		{76, 131, 131},
		{77, 27, 27},
		{77, 77, 77},
		{77, 121, 121},
		{77, 123, 123},
		{78, 27, 28},
		{78, 30, 30},
		{78, 117, 118},
		{79, 28, 28},
		{79, 63, 63},
		{79, 120, 120},
		{79, 122, 122},
		{80, 53, 53},
		{80, 66, 66},
		{80, 117, 117},
		{80, 122, 123},
		{80, 128, 129},
		{80, 133, 133},
		{81, 29, 30},
		{81, 49, 49},
		{81, 51, 54},
		{81, 104, 104},
		{81, 109, 110},
		{81, 112, 112},
		{81, 125, 126},
		{82, 6, 6},
		{82, 48, 49},
		{82, 56, 56},
		{82, 66, 66},
		{82, 106, 106},
		{82, 110, 110},
		{82, 124, 124},
		{82, 127, 127},
		{82, 130, 130},
		{82, 136, 137},
		{83, 6, 6},
		{83, 30, 31},
		{83, 48, 52},
		{83, 112, 112},
		{83, 114, 115},
		{83, 122, 122},
		{83, 128, 128},
		{83, 132, 132},
		{84, 19, 19},
		{84, 49, 51},
		{84, 56, 57},
		{84, 87, 87},
		{84, 115, 115},
		{84, 129, 129},
		{84, 131, 132},
		{84, 132, 132},
		{85, 19, 19},
		{85, 32, 32},
		{85, 53, 53},
		{85, 65, 66},
		{85, 140, 141},
		{86, 12, 12},
		{86, 20, 21},
		{86, 50, 51},
		{86, 54, 54},
		{86, 57, 57},
		{86, 63, 63},
		{86, 65, 65},
		{86, 94, 94},
		{86, 96, 96},
		{86, 131, 131},
		{86, 135, 135},
		{87, 10, 10},
		{87, 21, 22},
		{87, 33, 33},
		{87, 65, 65},
		{87, 132, 132},
		{88, 22, 23},
		{88, 64, 64},
		{88, 97, 97},
		{88, 99, 99},
		{89, 23, 24},
		{89, 27, 27},
		{89, 56, 56},
		{89, 136, 136},
		{90, 6, 6},
		{90, 11, 11},
		{90, 24, 25},
		{90, 29, 29},
		{90, 63, 64},
		{90, 94, 94},
		{90, 140, 140},
		{91, 2, 2},
		{91, 13, 13},
		{91, 25, 26},
		{91, 30, 30},
		{91, 98, 98},
		{91, 104, 104},
		{91, 132, 132},
		{91, 142, 142},
		{92, 0, 0},
		{92, 5, 5},
		{92, 26, 28},
		{92, 62, 62},
		{93, 28, 29},
		{93, 108, 108},
		{93, 111, 111},
		{94, 5, 5},
		{94, 114, 114},
		{94, 139, 139},
		{94, 143, 143},
		{95, 118, 118},
		{95, 151, 151},
		{96, 13, 13},
		{96, 156, 157},
		{97, 0, 0},
		{97, 163, 163},
		{98, 0, 1},
		{98, 13, 13},
		{98, 153, 153},
		{99, 0, 0},
		{99, 60, 61},
		{100, 0, 0},
		{101, 0, 0},
		{102, 0, 1},
		{102, 94, 94},
		{103, 0, 1},
		{103, 124, 125},
		{104, 0, 1},
		{105, 0, 1},
		{105, 30, 30},
		{106, 0, 1},
		{106, 58, 58},
		{107, 0, 1},
		{107, 12, 12},
		{108, 0, 0},
		{109, 0, 0},
		{110, 0, 0},
		{111, 12, 12},
		{116, 39, 40},
		{117, 40, 41},
		{118, 40, 42},
		{119, 41, 42},
		{120, 42, 45},   
};

-------------------------------------------------------------------------------
function GenerateMap()
	print("Generating South Pacific Map");
	local pPlot;

	-- Set globals
	g_iW, g_iH = Map.GetGridSize();
	g_iFlags = TerrainBuilder.GetFractalFlags();
	local temperature = 0;
	
	plotTypes = GeneratePlotTypes();
	terrainTypes = GenerateTerrainTypesSouthPacific(plotTypes, g_iW, g_iH, g_iFlags, true);

	for i = 0, (g_iW * g_iH) - 1, 1 do
		pPlot = Map.GetPlotByIndex(i);
		if (plotTypes[i] == g_PLOT_TYPE_HILLS) then
			terrainTypes[i] = terrainTypes[i] + 1;
		end
		TerrainBuilder.SetTerrainType(pPlot, terrainTypes[i]);
	end

	-- Temp
	AreaBuilder.Recalculate();
	local biggest_area = Areas.FindBiggestArea(false);
	print("After Adding Hills: ", biggest_area:GetPlotCount());

	-- Place lakes before rivers so they may act as river sources
	AddLakes();

	-- River generation is affected by plot types, originating from highlands and preferring to traverse lowlands.
	AddRivers();

	AddFeatures();
	
	print("Adding cliffs");
	AddCliffs(plotTypes, terrainTypes);
	
	local args = {
		numberToPlace = GameInfo.Maps[Map.GetMapSize()].NumNaturalWonders,
		--Invalid = {g_FEATURE_CRATER_LAKE, g_FEATURE_DEAD_SEA, g_FEATURE_PIOPIOTAHI, g_FEATURE_YOSEMITE, g_FEATURE_GIANTS_CAUSEWAY, g_FEATURE_EYJAFJALLAJOKULL},
	};

	local nwGen = NaturalWonderGenerator.Create(args);

	AreaBuilder.Recalculate();
	TerrainBuilder.AnalyzeChokepoints();
	TerrainBuilder.StampContinents();
	
	local resourcesConfig = MapConfiguration.GetValue("resources");
	local startConfig = MapConfiguration.GetValue("start");-- Get the start config

	local args = {
		resources = resourcesConfig,
		iWaterLux = 4,
		START_CONFIG = startConfig,
	}
	local resGen = ResourceGenerator.Create(args);

	print("Creating start plot database.");
	-- START_MIN_Y and START_MAX_Y is the percent of the map ignored for major civs' starting positions.
	local args = {
		MIN_MAJOR_CIV_FERTILITY = 50,
		MIN_MINOR_CIV_FERTILITY = 5, 
		MIN_BARBARIAN_FERTILITY = 1,
		START_MIN_Y = 15,
		START_MAX_Y = 15,
		WATER = true,
		START_CONFIG = startConfig,
	};
	local start_plot_database = AssignStartingPlots.Create(args)

	local GoodyGen = AddGoodies(g_iW, g_iH);
end

-- Input a Hash; Export width, height, and wrapX
function GetMapInitData(MapSize)
	local Width = 199;
	local Height = 120;
	local WrapX = false;
	return {Width = Width, Height = Height, WrapX = WrapX,}
end
-------------------------------------------------------------------------------
function GeneratePlotTypes()
	print("Generating Plot Types");
	local plotTypes = {};

	-- Start with it all as water
	for x = 0, g_iW - 1 do
		for y = 0, g_iH - 1 do
			local i = y * g_iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			plotTypes[i] = g_PLOT_TYPE_OCEAN;
			TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_OCEAN);
		end
	end

	-- Each land strip is defined by: Y, X Start, X End
	local xOffset = 0;
	local yOffset = 0;
		
	for i, v in ipairs(landStrips) do
		local y = g_iH - (v[1] + yOffset);   -- inverted
		local xStart = v[2] + xOffset;
		local xEnd = v[3] + xOffset; 
		for x = xStart, xEnd do
			local i = y * g_iW + x;
			local pPlot = Map.GetPlotByIndex(i);
			plotTypes[i] = g_PLOT_TYPE_LAND;
			TerrainBuilder.SetTerrainType(pPlot, g_TERRAIN_TYPE_GRASS);  -- temporary setting so can calculate areas
			g_iNumTotalLandTiles = g_iNumTotalLandTiles + 1;
		end
	end
		
	AreaBuilder.Recalculate();

	--	world_age
	local world_age_new = 5;
	local world_age_normal = 3;
	local world_age_old = 2;

	local world_age = MapConfiguration.GetValue("world_age");
	if (world_age == 1) then
		world_age = world_age_new;
	elseif (world_age == 2) then
		world_age = world_age_normal;
	elseif (world_age == 3) then
		world_age = world_age_old;
	else
		world_age = 2 + TerrainBuilder.GetRandomNumber(4, "Random World Age - Lua");
	end
	
	local args = {};
	args.world_age = world_age;
	args.iW = g_iW;
	args.iH = g_iH
	args.iFlags = g_iFlags;
	args.blendRidge = 10;
	args.blendFract = 1;
	args.extra_mountains = 4;
	plotTypes = ApplyTectonics(args, plotTypes);

	return plotTypes;
end

function InitFractal(args)

	if(args == nil) then args = {}; end

	local continent_grain = args.continent_grain or 2;
	local rift_grain = args.rift_grain or -1; -- Default no rifts. Set grain to between 1 and 3 to add rifts. - Bob
	local invert_heights = args.invert_heights or false;
	local polar = args.polar or true;
	local ridge_flags = args.ridge_flags or g_iFlags;

	local fracFlags = {};
	
	if(invert_heights) then
		fracFlags.FRAC_INVERT_HEIGHTS = true;
	end
	
	if(polar) then
		fracFlags.FRAC_POLAR = true;
	end
	
	if(rift_grain > 0 and rift_grain < 4) then
		local riftsFrac = Fractal.Create(g_iW, g_iH, rift_grain, {}, 6, 5);
		g_continentsFrac = Fractal.CreateRifts(g_iW, g_iH, continent_grain, fracFlags, riftsFrac, 6, 5);
	else
		g_continentsFrac = Fractal.Create(g_iW, g_iH, continent_grain, fracFlags, 6, 5);	
	end

	-- Use Brian's tectonics method to weave ridgelines in to the continental fractal.
	-- Without fractal variation, the tectonics come out too regular.
	--
	--[[ "The principle of the RidgeBuilder code is a modified Voronoi diagram. I 
	added some minor randomness and the slope might be a little tricky. It was 
	intended as a 'whole world' modifier to the fractal class. You can modify 
	the number of plates, but that is about it." ]]-- Brian Wade - May 23, 2009
	--
	local MapSizeTypes = {};
	for row in GameInfo.Maps() do
		MapSizeTypes[row.MapSizeType] = row.PlateValue;
	end
	local sizekey = Map.GetMapSize();

	local numPlates = MapSizeTypes[sizekey] or 4

	-- Blend a bit of ridge into the fractal.
	-- This will do things like roughen the coastlines and build inland seas. - Brian

	g_continentsFrac:BuildRidges(numPlates, {}, 1, 2);
end

function AddFeatures()
	print("Adding Features");

	-- Get Rainfall setting input by user.
	local rainfall = MapConfiguration.GetValue("rainfall");
	if rainfall == 4 then
		rainfall = 1 + TerrainBuilder.GetRandomNumber(3, "Random Rainfall - Lua");
	end

	local args = {rainfall = rainfall, iJunglePercent = 50, iMarshPercent = 8, iForestPercent = 10, iReefPercent = 50}	-- jungle & marsh max coverage
	local featuregen = FeatureGenerator.Create(args);

	featuregen:AddFeatures();
end
------------------------------------------------------------------------------
function GenerateTerrainTypesSouthPacific(plotTypes, iW, iH, iFlags, bNoCoastalMountains)
	print("Generating Terrain Types");
	local terrainTypes = {};

	local fracXExp = -1;
	local fracYExp = -1;
	local grain_amount = 3;

	islands = Fractal.Create(iW, iH, 
									grain_amount, iFlags, 
									fracXExp, fracYExp);
																									
	iPlainsTop = islands:GetHeight(85);
	iPlainsBottom = islands:GetHeight(50);			
	iGrassTop = islands:GetHeight(50);
	iGrassBottom = islands:GetHeight(0);

	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;
			if (plotTypes[index] == g_PLOT_TYPE_OCEAN) then
				if (IsAdjacentToLand(plotTypes, iX, iY)) then
					terrainTypes[index] = g_TERRAIN_TYPE_COAST;
				else
					terrainTypes[index] = g_TERRAIN_TYPE_OCEAN;
				end
			end
		end
	end

	if (bNoCoastalMountains == true) then
		plotTypes = RemoveCoastalMountains(plotTypes, terrainTypes);
	end

	for iX = 0, iW - 1 do
		for iY = 0, iH - 1 do
			local index = (iY * iW) + iX;

			local islandsVal = islands:GetHeight(iX, iY);

			if (plotTypes[index] == g_PLOT_TYPE_MOUNTAIN) then
				terrainTypes[index] = g_TERRAIN_TYPE_DESERT_MOUNTAIN;

				if ((islandsVal >= iGrassBottom) and (islandsVal <= iGrassTop)) then
					terrainTypes[index] = g_TERRAIN_TYPE_GRASS_MOUNTAIN;
				elseif ((islandsVal >= iPlainsBottom) and (islandsVal <= iPlainsTop)) then
					terrainTypes[index] = g_TERRAIN_TYPE_PLAINS_MOUNTAIN;
				end

			elseif (plotTypes[index] ~= g_PLOT_TYPE_OCEAN) then
				terrainTypes[index] = g_TERRAIN_TYPE_DESERT;
		
				if ((islandsVal >= iGrassBottom) and (islandsVal <= iGrassTop)) then
					terrainTypes[index] = g_TERRAIN_TYPE_GRASS;
				elseif ((islandsVal >= iPlainsBottom) and (islandsVal <= iPlainsTop)) then
					terrainTypes[index] = g_TERRAIN_TYPE_PLAINS;
				end
			end
		end
	end

	local bExpandCoasts = true;

	if bExpandCoasts == false then
		return
	end

	print("Expanding coasts");
	for iI = 0, 2 do
		local shallowWaterPlots = {};
		for iX = 0, iW - 1 do
			for iY = 0, iH - 1 do
				local index = (iY * iW) + iX;
				if (terrainTypes[index] == g_TERRAIN_TYPE_OCEAN) then
					-- Chance for each eligible plot to become an expansion is 1 / iExpansionDiceroll.
					-- Default is two passes at 1/4 chance per eligible plot on each pass.
					if (IsAdjacentToShallowWater(terrainTypes, iX, iY) and TerrainBuilder.GetRandomNumber(4, "add shallows") == 0) then
						table.insert(shallowWaterPlots, index);
					end
				end
			end
		end
		for i, index in ipairs(shallowWaterPlots) do
			terrainTypes[index] = g_TERRAIN_TYPE_COAST;
		end
	end
	
	return terrainTypes; 
end
------------------------------------------------------------------------------
function FeatureGenerator:AddIceAtPlot(plot, iX, iY)
	return false;
end

------------------------------------------------------------------------------
function CustomGetMultiTileFeaturePlotList(pPlot, eFeatureType, aPlots)

	-- First check this plot itself
	if (not TerrainBuilder.CanHaveFeature(pPlot, eFeatureType, true)) then
		return false;
	else
		table.insert(aPlots, pPlot:GetIndex());
	end

	-- Which type of custom placement is it?
	local customPlacement = GameInfo.Features[eFeatureType].CustomPlacement;

	-- 6 tiles in a straight line
	if (customPlacement == "PLACEMENT_REEF_EXTENDED") then

		for i = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
			local pPlots = {};
			local iNumFound = 1;	
			local bBailed = false;			
			pPlots[iNumFound] = Map.GetAdjacentPlot(pPlot:GetX(), pPlot:GetY(), i);
			if (pPlots[iNumFound] ~= nil and TerrainBuilder.CanHaveFeature(pPlots[iNumFound], eFeatureType, true)) then

				while iNumFound < 5 do
					iNumFound = iNumFound + 1;
					pPlots[iNumFound] = Map.GetAdjacentPlot(pPlots[iNumFound - 1]:GetX(), pPlots[iNumFound - 1]:GetY(), i);
					if (pPlots[iNumFound] == nil) then
						bBailed = true;
						break;
					elseif not TerrainBuilder.CanHaveFeature(pPlots[iNumFound], eFeatureType, true) then
						bBailed = true;
						break;
					end
				end

				if not bBailed then
					for j = 1, 5 do
						table.insert(aPlots, pPlots[j]:GetIndex());
					end
					print ("Found valid Extended Barrier Reef location at: " .. tostring(pPlot:GetX()) .. ", " .. tostring(pPlot:GetY()));
					return true;
				end
			end
		end
	end

	return false;
end

------------------------------------------------------------------------------
function FeatureGenerator:AddReefAtPlot(plot, iX, iY)

	--Reef Check. First see if it can place the feature.
	if(TerrainBuilder.CanHaveFeature(plot, g_FEATURE_REEF)) then
		self.iNumReefablePlots = self.iNumReefablePlots + 1;
		if(math.ceil(self.iReefCount * 100 / self.iNumReefablePlots) <= self.iReefMaxPercent) then
				--Weight based on adjacent plots
				local iScore  = 1.5 * math.abs(iY - self.iNumEquator);
				local iAdjacent = TerrainBuilder.GetAdjacentFeatureCount(plot, g_FEATURE_REEF);

				if(iAdjacent == 0 ) then
					iScore = iScore + 100;
				elseif(iAdjacent == 1) then
					iScore = iScore + 125;
				elseif (iAdjacent == 2) then
					iScore = iScore  + 150;
				elseif (iAdjacent == 3 or iAdjacent == 4) then
					iScore = iScore + 175;
				else
					iScore = iScore + 10000;
				end

				if(TerrainBuilder.GetRandomNumber(300, "Resource Placement Score Adjust") >= iScore) then
					TerrainBuilder.SetFeatureType(plot, g_FEATURE_REEF);
					self.iReefCount = self.iReefCount + 1;
				end
		end
	end
end