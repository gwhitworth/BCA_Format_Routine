DROP FUNCTION IF EXISTS [dbo].[FNC_FORMAT_LEGAL]
GO
/*********************************************************************************************************************
Function: FNC_FORMAT_LEGAL

Purpose: This is a common function to generate legal lines. Legal descriptive prefix is associated with
       each legal field.  This version includes NTS formatting.

Parameter: @p_line_length, @p_line_number, 
         @p_jurisdiction,  
         @p_parcel, @p_parcel_length,
         @p_lot, @p_lot_length,
         @p_strata_lot, @p_strata_lot_length,
         @p_block, @p_block_length,
         @p_sub_block, @p_sub_block_length,
         @p_plan, @p_plan_length,
         @p_sub_lot, @p_sub_lot_length,
         @p_part_1, @p_part_2,
         @p_part_3, @p_part_4,
         @p_part_length,
         @p_district_lot, @p_district_lot_length,
         @p_legal_subdivision, @p_legal_subdivision_length,
         @p_section, @p_section_length,
         @p_township, @p_township_length,
         @p_range, @p_range_length,
         @p_meridian, @p_meridian_length,
         @p_bcaao_group, @p_bcaao_group_length,
         @p_land_district, @p_land_district_length,
         @p_portion, @p_portion_length,
         @p_except_plan, @p_except_plan_length,
         @p_legal_text, @p_legal_text_length,
         @p_air_space_parcel, @p_air_space_parcel_length,
         @p_lease_licence_num, @p_lease_licence_num_length,
         @p_mf_num, @p_mf_num_length,
         @p_mhr_number, @p_mhr_number_length,
         @p_bay_no, @p_bay_no_length,
         @p_mobile_park_name, @p_mobile_park_name_length,
         @p_park_folio_id, @p_park_folio_id_length,
         @p_pid1, @p_pid2, 
         @p_pid3, @p_pid4,
         @p_pid5, @p_pid_length,
         @p_nts_block_num, @p_nts_block_num_length,
         @p_nts_exception, @p_nts_exception_length,
         @p_nts_map_num, @p_nts_map_num_length,
         @p_nts_quarter_unit, @p_nts_quarter_unit_length,
         @p_nts_unit, @p_nts_unit_length
         @p_project_num, @p_project_num

Return/result: a legal line with fixed line length
      
Assumption: 

Modified History: 
Version     Date       Purpose				Author
---------------------------------------------------------------------------------------------------------------------
1.0        Nov 2018    original build		Gerry Whitworth
*********************************************************************************************************************/
CREATE FUNCTION [dbo].[FNC_FORMAT_LEGAL]
(
	@p_line_length				INT, 
	@p_line_number				INT, 
    @p_jurisdiction				VARCHAR(50),  
    @p_parcel					VARCHAR(50),  
	@p_parcel_length			INT,
    @p_lot						VARCHAR(50),  
	@p_lot_length				INT,
    @p_strata_lot				VARCHAR(50),  
	@p_strata_lot_length		INT,
    @p_block					VARCHAR(50),  
	@p_block_length				INT,
    @p_sub_block				VARCHAR(50),  
	@p_sub_block_length			INT,
    @p_plan						VARCHAR(50),  
	@p_plan_length				INT,
    @p_sub_lot					VARCHAR(50),  
	@p_sub_lot_length			INT,
    @p_part_1					VARCHAR(50),
	@p_part_2					VARCHAR(50),
    @p_part_3					VARCHAR(50),  
	@p_part_4					VARCHAR(50),  
    @p_part_length				INT,
    @p_district_lot				VARCHAR(50),  
	@p_district_lot_length		INT,
    @p_legal_subdivision		VARCHAR(50),  
	@p_legal_subdivision_length INT,
    @p_section					VARCHAR(50),  
	@p_section_length			INT,
    @p_township					VARCHAR(50),  
	@p_township_length			INT,
    @p_range					VARCHAR(50),  
	@p_range_length				INT,
    @p_meridian					VARCHAR(50),  
	@p_meridian_length			INT,
    @p_bcaao_group				VARCHAR(50),  
	@p_bcaao_group_length		INT,
    @p_land_district			VARCHAR(50),  
	@p_land_district_length		INT,
    @p_portion					VARCHAR(50),  
	@p_portion_length			INT,
    @p_except_plan				VARCHAR(50),  
	@p_except_plan_length		INT,
    @p_legal_text				VARCHAR(50),  
	@p_legal_text_length		INT,
    @p_air_space_parcel			VARCHAR(50),  
	@p_air_space_parcel_length	INT,
    @p_lease_licence_num		VARCHAR(50),  
	@p_lease_licence_num_length INT,
    @p_mf_num					VARCHAR(50),  
	@p_mf_num_length			INT,
    @p_mhr_number				VARCHAR(50),  
	@p_mhr_number_length		INT,
    @p_bay_no					VARCHAR(50),  
	@p_bay_no_length			INT,
    @p_mobile_park_name			VARCHAR(50),  
	@p_mobile_park_name_length INT,
    @p_park_folio_id			VARCHAR(50), 
	@p_park_folio_id_length		INT,
    @p_pid1						VARCHAR(50),  
	@p_pid2						VARCHAR(50),  
    @p_pid3						VARCHAR(50),  
	@p_pid4						VARCHAR(50),  
    @p_pid5						VARCHAR(50),   
	@p_pid_length				INT,
    @p_nts_block_num			VARCHAR(50),  
	@p_nts_block_num_length		INT,
    @p_nts_exception			VARCHAR(50),  
	@p_nts_exception_length		INT,
    @p_nts_map_num				VARCHAR(50),  
	@p_nts_map_num_length		INT,
    @p_nts_quarter_unit			VARCHAR(50),  
	@p_nts_quarter_unit_length	INT,
    @p_nts_unit					VARCHAR(50),  
	@p_nts_unit_length			INT,
    @p_project_num				VARCHAR(50),
	@p_proj_num_length INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @RtnLegalDesc	VARCHAR(max) = '',
			@NTS			VARCHAR(max)

	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA]([dbo].[FNC_GET_PART](CAST(@p_project_num AS VARCHAR(50))), ',', 'Pipeline Project:', '');
	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_parcel, @p_parcel_length))), ',', 'Parcel', '');
	IF @p_strata_lot IS NOT NULL
	   SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_strata_lot, @p_strata_lot_length))), ',', 'Strata Lot', '');
	ELSE
	   SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_lot, @p_lot_length))), ',', 'Lot', '');

	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_block, @p_block_length))), ',', 'Block', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_sub_block, @p_sub_block_length)), ',', 'Sub Block', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_plan, @p_plan_length)), ',', 'Plan', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_sub_lot, @p_sub_lot_length)), ',', [sbo].[FNC_SUB_LOT](@p_jurisdiction), '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_part_1, @p_part_length))), ' ', 'Part', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_part_2, @p_part_length))), ' ', 'of', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_part_3, @p_part_length))), ' ', 'of', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_part_4, @p_part_length))), ' ', 'of', '');
	IF SUBSTRING(TRIM(@RtnLegalDesc), LEN(TRIM(@RtnLegalDesc)), 1) <> ',' 
	SET @RtnLegalDesc = trim(@RtnLegalDesc) + ', '
	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_district_lot, @p_district_lot_length)), ',', 'District Lot', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_legal_subdivision, @p_legal_subdivision_length)), ',', 'Legal Subdivision', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_section, @p_section_length)), ',', 'Section', '')
						+ [dbo].[FNC_APPEND_DATA]([dbo].[FNC_TOWNSHIP_DESC](@p_township), ',', 'Township', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_range, @p_range_length)), ',', 'Range', '')
						+ [dbo].[FNC_APPEND_DATA]([dbo].[FNC_MERIDIAN_DESC](@p_meridian), ',', 'Meridian', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART](@p_bcaao_group, @p_bcaao_group_length)), ',', 'Group', '')
						+ [dbo].[FNC_APPEND_DATA]([dbo].[FNC_DISTRICT_DESC](@p_land_district), ',', '', 'Land District')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_portion, @p_portion_length))), ',', 'Portion', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_except_plan, @p_except_plan_length))), ',', 'Except Plan', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_legal_text, @p_legal_text_length))), ',', '', '');

	IF @p_nts_quarter_unit IS NOT NULL
	BEGIN
	   SET @NTS =  'NTS:' + [dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_nts_quarter_unit, @p_nts_quarter_unit_length));
   
	   IF @p_nts_unit IS NOT NULL OR @p_nts_exception IS NOT NULL
		  SET @NTS =	@NTS + '-' + [dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_nts_exception, @p_nts_exception_length))
						+ [dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_nts_unit, @p_nts_unit_length));

	   IF @p_nts_block_num IS NOT NULL
		  SET @NTS = @NTS + '-' + [dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_nts_block_num, @p_nts_block_num_length));
   
	   IF @p_nts_map_num IS NOT NULL
		  SET @NTS =@NTS + '/' + [dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_nts_map_num, @p_nts_map_num_length));
   
	   SET @NTS =  @NTS + ', '
   
	   SET @RtnLegalDesc = @RtnLegalDesc + @NTS
	END

	IF @p_strata_lot IS NOT NULL
	BEGIN
	   IF @p_lot IS NOT NULL
		   SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_lot, @p_lot_length))), ',', 'Lot', '');
	END
	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_air_space_parcel, @p_air_space_parcel_length))), ',', 'Air Space Parcel', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_lease_licence_num, @p_lease_licence_num_length))), ',', 'Lease/Permit/Licence #', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_mf_num, @p_mf_num_length))), ',', 'Managed Forest', '')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_mhr_number, @p_mhr_number_length))), ',', 'Manufactured Home Reg.#', '');
	IF @p_mhr_number IS NOT NULL
	BEGIN
	   IF @p_bay_no IS NOT NULL
			SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_bay_no, @p_bay_no_length))), ',', 'Bay #', '');
	END
	SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_mobile_park_name, @p_mobile_park_name_length))), ',', '', 'Manufactured Home Park')
						+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FNC_MAX_LEN](@p_park_folio_id, @p_park_folio_id_length))), ',', 'MHP Roll #', '');
               
	IF @p_jurisdiction IN ('407', '410', '411', '414', '415')              
	   SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid1), @p_pid_length)), '', 'Parcel ID Number', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid2), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid3), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid4), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid5), @p_pid_length)), '', ',', '')
	ELSE
	   SET @RtnLegalDesc = @RtnLegalDesc + [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid1), @p_pid_length)), '', 'Pid #', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid2), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid3), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid4), @p_pid_length)), '', ',', '')
							+ [dbo].[FNC_APPEND_DATA](([dbo].[FNC_GET_PART]([dbo].[FORMAT_PID](@p_pid5), @p_pid_length)), '', ',', '')

	-- remove trailing comma
	SET @RtnLegalDesc = TRIM(@RtnLegalDesc)

	IF SUBSTRING(@RtnLegalDesc, LEN(TRIM(@RtnLegalDesc)), 1) = ','
	   SET @RtnLegalDesc = SUBSTRING(@RtnLegalDesc, 1, LEN(TRIM(@RtnLegalDesc)) - 1);

	RETURN @RtnLegalDesc
END
