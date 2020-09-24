REM batch file to preprocess covariates (mask to study area, repreoject, convert to 30m etc.) for modeling soil depth on the upper colorado river basin.
REM This forces them to all align so that I can stack for predictions. To run this I copy the code into a text editor, rename with a .bat extension and then use OSGeo4W to run the .bat file. 
REM note that I deleted most original and intermediate files after reprojecting and resampling to reduce file size (this had to be done as I ran out of file storage!).  
REM set a path to the 7zip .exe to use for extracting compressed files.  
SET PATH=%PATH%;C:\Program Files\7-Zip\

REM Set file paths to the boundary to use as a cutline (cfile) and the general folder location. The buffer is for covariates with > the pixel size (30m) because it keeps the large pixels from getting no_data values along the edges. 
SET cfile=Z:\UCRB\Boundaries\CO_River_watershed_Meade_5070.shp
SET cfile_buff=Z:\UCRB\Boundaries\CO_River_watershed_Meade_5070_2500buffer.shp

SET sfolder=Z:\UCRB\Covariates

REM Colby's covariates derived from the USTD (US terrain derivatives) dataset.
REM uncomment the following if you want to delay the script from running (for example if you want to let all the files finish downloading first). 18000 = seconds (3 hours)
REM timeout 18000

REM Uncomment the following to unpack all .xz files. Could put this into a loop if I wanted. https://superuser.com/questions/1361011/batch-file-for-loop-7-zip-extract-specific-file-extension
REM 7z x %sfolder%\ColbyCovariates\mbi_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\mca_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\mc_mosaic.tif.xz  -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\sl_mosaic.tif.xz  -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\spi_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\swi_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\tc_mosaic.tif.xz  -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\tpi_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\tri_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\tsc_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\twi_mosaic.tif.xz -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\cs_mosaic.tif.xz  -o%sfolder%\ColbyCovariates
REM 7z x %sfolder%\ColbyCovariates\mxc_mosaic.tif.xz -o%sfolder%\ColbyCovariates

REM THE NEXT TIME THAT I RUN SOMETHING LIKE THIS I NEED TO MAKE SURE TO ADD -co COMPRESS=DEFLATE TO EACH GDALWARP AS THIS DRAMATICALLY REDUCES FILE SIZE

REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\ca_mosaic.tif    %sfolder%\ColbyCovariates\ca_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\cc_mosaic.tif    %sfolder%\ColbyCovariates\cc_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\ci_mosaic.tif    %sfolder%\ColbyCovariates\ci_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mrrtf_mosaic.tif %sfolder%\ColbyCovariates\mrrtf_mosaic_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mrvbf_mosaic.tif %sfolder%\ColbyCovariates\mrvbf_mosaic_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\planc_mosaic.tif %sfolder%\ColbyCovariates\planc_mosaic_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\po_mosaic.tif    %sfolder%\ColbyCovariates\po_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\profc_mosaic.tif %sfolder%\ColbyCovariates\profc_mosaic_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mbi_mosaic.tif   %sfolder%\ColbyCovariates\mbi_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mca_mosaic.tif   %sfolder%\ColbyCovariates\mca_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mc_mosaic.tif    %sfolder%\ColbyCovariates\mc_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\sl_mosaic.tif    %sfolder%\ColbyCovariates\sl_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\spi_mosaic.tif   %sfolder%\ColbyCovariates\spi_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\swi_mosaic.tif   %sfolder%\ColbyCovariates\swi_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\tc_mosaic.tif    %sfolder%\ColbyCovariates\tc_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\tpi_mosaic.tif   %sfolder%\ColbyCovariates\tpi_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\tri_mosaic.tif   %sfolder%\ColbyCovariates\tri_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\tsc_mosaic.tif   %sfolder%\ColbyCovariates\tsc_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\twi_mosaic.tif   %sfolder%\ColbyCovariates\twi_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\cs_mosaic.tif    %sfolder%\ColbyCovariates\cs_mosaic_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\dah_mosaic.tif   %sfolder%\ColbyCovariates\dah_mosaic_m.tif   -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\gmph_mosaic.tif  %sfolder%\ColbyCovariates\gmph_mosaic_m.tif  -wo NUM_THREADS=30 -wm 1000 -tr 30 30                      

REM REM for reasons still not yet clear. mxc mosaic appears to be corrupted. Probably need to redo. 
REM REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\ColbyCovariates\mxc_mosaic.tif   %sfolder%\ColbyCovariates\mxc_mosaic_m.tif  -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM REM Julius' Covariates
REM REM Landsat
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_51\L51_std.tif %sfolder%\JuliusCovariates\Landsat\L5_51\L51_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_57\L57_std.tif %sfolder%\JuliusCovariates\Landsat\L5_57\L57_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_54\L54_med.tif %sfolder%\JuliusCovariates\Landsat\L5_54\L54_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_54\L54_std.tif %sfolder%\JuliusCovariates\Landsat\L5_54\L54_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_43\L43_std.tif %sfolder%\JuliusCovariates\Landsat\L5_43\L43_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_43\L43_med.tif %sfolder%\JuliusCovariates\Landsat\L5_43\L43_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_51\L51_med.tif %sfolder%\JuliusCovariates\Landsat\L5_51\L51_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_57\L57_med.tif %sfolder%\JuliusCovariates\Landsat\L5_57\L57_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM REM Thermal
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_TIR\TIR_std.tif %sfolder%\JuliusCovariates\Landsat\L5_TIR\TIR_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30 
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\Landsat\L5_TIR\TIR_med.tif %sfolder%\JuliusCovariates\Landsat\L5_TIR\TIR_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM REM Radar
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\SentinalRadar\vv_med.tif %sfolder%\JuliusCovariates\SentinalRadar\vv_med_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30                                                                                                                            
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\JuliusCovariates\SentinalRadar\vv_std.tif %sfolder%\JuliusCovariates\SentinalRadar\vv_std_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM REM Pelletier Covariates (regolith thickness predictions)
REM REM First need to crop the original large dataset to something more manageable (projwin taken from QGIS by drawing a box around the general area of the study). Then reproject, crop, and rescale. 
REM gdal_translate -projwin -117.13334339199999 44.767923482999976 -104.06667881599998 32.63459209099998 %sfolder%/PelletierCovariates/upland_valley-bottom_and_lowland_sedimentary_deposit_thickness.tif %sfolder%/PelletierCovariates\upland_valley-bottom_and_lowland_sedimentary_deposit_thickness_c.tif
REM gdalwarp -s_srs EPSG:4326 -t_srs EPSG:5070 -r bilinear -of Byte -cutline %cfile% -crop_to_cutline %sfolder%/PelletierCovariates/upland_valley-bottom_and_lowland_sedimentary_deposit_thickness_c.tif %sfolder%/PelletierCovariates/upland_valley-bottom_and_lowland_sedimentary_deposit_thickness_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30


REM REM Tomislav Covariates (soil thickness predictions)
REM REM First need to crop the original large dataset to something more manageable (projwin taken from QGIS by drawing a box around the general area of the study). Then reproject, crop, and rescale. 
REM gdal_translate -projwin -117.13334339199999 44.767923482999976 -104.06667881599998 32.63459209099998 -ot Float32 -of GTiff %sfolder%TomiCovariates/BDRICM_M_250m_ll.tif %sfolder%TomiCovariates/BDRICM_M_250m_ll_c.tif
REM gdalwarp  -s_srs EPSG:4326 -t_srs EPSG:5070 -r bilinear -cutline %cfile% -crop_to_cutline %sfolder%\TomiCovariates\BDRICM_M_250m_ll_c.tif %sfolder%\TomiCovariates\BDRICM_M_250m_ll_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM gdal_translate -projwin -117.13334339199999 44.767923482999976 -104.06667881599998 32.63459209099998 %sfolder%TomiCovariates/BDRLOG_M_250m_ll.tif %sfolder%TomiCovariates/BDRLOG_M_250m_ll_c.tif
REM gdalwarp  -s_srs EPSG:4326 -t_srs EPSG:5070 -r bilinear -cutline %cfile% -crop_to_cutline %sfolder%\TomiCovariates\BDRLOG_M_250m_ll_c.tif %sfolder%\TomiCovariates\BDRLOG_M_250m_ll_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM gdal_translate -projwin -117.13334339199999 44.767923482999976 -104.06667881599998 32.63459209099998 %sfolder%TomiCovariates/BDTICM_M_250m_ll.tif %sfolder%TomiCovariates/BDTICM_M_250m_ll_c.tif
REM gdalwarp  -s_srs EPSG:4326 -t_srs EPSG:5070 -r bilinear -cutline %cfile% -crop_to_cutline %sfolder%\TomiCovariates\BDTICM_M_250m_ll_c.tif %sfolder%\TomiCovariates\BDTICM_M_250m_ll_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM REM Travis' covariates
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\CAlog_10_rs.tif    %sfolder%\TravisCovariates\CAlog_10_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\EASTNESS_rs.tif    %sfolder%\TravisCovariates\EASTNESS_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\ELEVm.tif          %sfolder%\TravisCovariates\ELEVm_m.tif            -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\GAP.tif            %sfolder%\TravisCovariates\GAP_m.tif              -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\iwahashiLF.tif     %sfolder%\TravisCovariates\iwahashiLF_m.tif       -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\LFELEMS.tif        %sfolder%\TravisCovariates\LFELEMS_m.tif          -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\NENESS_rs.tif      %sfolder%\TravisCovariates\NENESS_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\NLCDcl.tif         %sfolder%\TravisCovariates\NLCDcl_m.tif           -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\NWNESS_rs.tif      %sfolder%\TravisCovariates\NWNESS_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\PCURV_rs.tif       %sfolder%\TravisCovariates\PCURV_rs_m.tif         -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\ppt_ann_rs.tif     %sfolder%\TravisCovariates\ppt_ann_rs_m.tif       -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\ppt_ratio_rs.tif   %sfolder%\TravisCovariates\ppt_ratio_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\PROTINDEX_rs.tif   %sfolder%\TravisCovariates\PROTINDEX_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT128_rs.tif    %sfolder%\TravisCovariates\RELHT128_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT16_rs.tif     %sfolder%\TravisCovariates\RELHT16_rs_m.tif       -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT1_rs.tif      %sfolder%\TravisCovariates\RELHT1_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT2_rs.tif      %sfolder%\TravisCovariates\RELHT2_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT32_rs.tif     %sfolder%\TravisCovariates\RELHT32_rs_m.tif       -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT4_rs.tif      %sfolder%\TravisCovariates\RELHT4_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT64_rs.tif     %sfolder%\TravisCovariates\RELHT64_rs_m.tif       -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELHT8_rs.tif      %sfolder%\TravisCovariates\RELHT8_rs_m.tif        -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT128_rs.tif  %sfolder%\TravisCovariates\RELMNHT128_rs_m.tif    -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT16_rs.tif   %sfolder%\TravisCovariates\RELMNHT16_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT1_rs.tif    %sfolder%\TravisCovariates\RELMNHT1_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT2_rs.tif    %sfolder%\TravisCovariates\RELMNHT2_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT32_rs.tif   %sfolder%\TravisCovariates\RELMNHT32_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT4_rs.tif    %sfolder%\TravisCovariates\RELMNHT4_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT64_rs.tif   %sfolder%\TravisCovariates\RELMNHT64_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\RELMNHT8_rs.tif    %sfolder%\TravisCovariates\RELMNHT8_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\SLOPE_rs.tif       %sfolder%\TravisCovariates\SLOPE_rs_m.tif         -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\SOUTHNESS_rs.tif   %sfolder%\TravisCovariates\SOUTHNESS_rs_m.tif     -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\TCURV_rs.tif       %sfolder%\TravisCovariates\TCURV_rs_m.tif         -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%\TravisCovariates\temp_ann_rs.tif    %sfolder%\TravisCovariates\temp_ann_rs_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM REM USGS Gamma radiometrics covariates (bilinear resampling)                                                                                                                                                                                                                        
REM gdalwarp  -cutline %cfile_buff% -crop_to_cutline %sfolder%\USGSCovariates\gammaAbsbDose.tif    %sfolder%\USGSCovariates\gammaAbsbDose_buff_m.tif  -wo NUM_THREADS=30 -wm 1000 -r bilinear -tr 30 30                      
REM gdalwarp  -cutline %cfile_buff% -crop_to_cutline %sfolder%\USGSCovariates\gammaPotassium.tif   %sfolder%\USGSCovariates\gammaPotassium_buff_m.tif -wo NUM_THREADS=30 -wm 1000 -r bilinear -tr 30 30                      
REM gdalwarp  -cutline %cfile_buff% -crop_to_cutline %sfolder%\USGSCovariates\gammaThorium.tif     %sfolder%\USGSCovariates\gammaThorium_buff_m.tif   -wo NUM_THREADS=30 -wm 1000 -r bilinear -tr 30 30                      
REM gdalwarp  -cutline %cfile_buff% -crop_to_cutline %sfolder%\USGSCovariates\gammaUranium.tif     %sfolder%\USGSCovariates\gammaUranium_buff_m.tif   -wo NUM_THREADS=30 -wm 1000 -r bilinear -tr 30 30                      


REM REM Landclassification covariates. If gdal_rasterize doesn't work, it probably has something to do with projections. It seems to be happy in geographic coordinates. 
REM gdal_rasterize -l CO_River_watershed_Meade_NAD83_EcoL3 -a US_L3CODE -tr 30 30 -a_nodata 0 -ot Int16 %sfolder%/LandClassCovariates/CO_River_watershed_Meade_NAD83_EcoL3.shp %sfolder%/LandClassCovariates/us_eco_l3_m.tif
REM gdalwarp  -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%/LandClassCovariates/us_eco_l3.tif    %sfolder%/LandClassCovariates/us_eco_l3_m.tif      -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM gdal_rasterize -l mlra_v42_UCRB -a MLRA_ID -tr 30 30 -a_nodata 0 -ot Int16 %sfolder%/LandClassCovariates/US_MLRA/mlra_v42_UCRB.shp %sfolder%/LandClassCovariates/mlra_UCRB.tif
REM gdalwarp -cutline %cfile% -crop_to_cutline -co COMPRESS=DEFLATE %sfolder%/LandClassCovariates/mlra_UCRB.tif    %sfolder%/LandClassCovariates/mlra_UCRB_m.tif  -wo NUM_THREADS=30 -wm 1000 -tr 30 30

REM REM For what ever reason the following didn't project exactly quite right. Reproject. 
REM SET ssource="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs"
REM SET tsource="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
REM gdalwarp -t_srs %tsource%  %sfolder%\TravisCovariates\ELEVm_m.tif         %sfolder%\TravisCovariates\ELEVm_m2.tif
REM gdalwarp -t_srs %tsource%  %sfolder%\TravisCovariates\LFELEMS_m.tif       %sfolder%\TravisCovariates\LFELEMS_m2.tif
REM gdalwarp -t_srs %tsource%  %sfolder%/LandClassCovariates/mlra_UCRB_m.tif  %sfolder%/LandClassCovariates/mlra_UCRB_m2.tif
REM gdalwarp -t_srs %tsource%  %sfolder%/LandClassCovariates/us_eco_l3_m.tif  %sfolder%/LandClassCovariates/us_eco_l3_m2.tif 
REM gdalwarp -t_srs %tsource%  %sfolder%\USGSCovariates\gammaAbsbDose_m.tif   %sfolder%\USGSCovariates\gammaAbsbDose_m2.tif                       
REM gdalwarp -t_srs %tsource%  %sfolder%\USGSCovariates\gammaPotassium_m.tif  %sfolder%\USGSCovariates\gammaPotassium_m2.tif                      
REM gdalwarp -t_srs %tsource%  %sfolder%\USGSCovariates\gammaThorium_m.tif    %sfolder%\USGSCovariates\gammaThorium_m2.tif                        
REM gdalwarp -t_srs %tsource%  %sfolder%\USGSCovariates\gammaUranium_m.tif    %sfolder%\USGSCovariates\gammaUranium_m2.tif   












REM The following code creates latitude and longitude covariates. If this makes sense. 
REM # used the r.latlong tool in grass GIS to create lat/long rasters from slope_rs.tif.
REM # used the following gdal commands to reproject lat/long rasters to match the other rasters. Kind of funny to reproject lat/long !
REM gdalwarp -t_srs "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs" longitude.tif longitude_aea.tif
REM gdalwarp -t_srs "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs" latitude.tif latitude_aea.tif
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\latitude_aea.tif %sfolder%\latitude_aea_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
REM gdalwarp  -cutline %cfile% -crop_to_cutline %sfolder%\longitude_aea.tif %sfolder%\longitude_aea_m.tif -wo NUM_THREADS=30 -wm 1000 -tr 30 30
