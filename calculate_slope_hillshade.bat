:: this file needs to be in the "data" directory which includes all necessary files
:: gdal_merge -o dem_merge.tif N45E014.hgt n45_e013_1arc_v3.tif enable this line in order to generate necessary "dem_merge.tif" file
ogr2ogr -f "ESRI Shapefile" output_folder gadm36_SVN.gpkg
ogr2ogr -sql "SELECT * FROM gadm36_SVN_2 WHERE NAME_2 = 'Izola'" -f "ESRI Shapefile" output_folder\izola.shp output_folder\gadm36_SVN_2.dbf
ogrinfo output_folder\izola.shp -so
gdalwarp -dstnodata -9999 -t_srs EPSG:32632 -cutline output_folder\izola.shp -crop_to_cutline dem_merge.tif dem_merge_clip_izola.tif
gdaldem slope dem_merge_clip_izola.tif slope_izola.tif
gdaldem hillshade dem_merge_clip_izola.tif hillshade_izola.tif