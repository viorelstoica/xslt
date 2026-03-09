<?xml version="1.0" encoding="UTF-8"?>
<!-- _@GVA$Date: 2024-05-17 11:55:37 +0200 (Fri, 17 May 2024) $@_   -->
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">
	<!-- START of protected area  -->
<xsl:template name="infra:userDefinedField">
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_mir_univer_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <!-- When csdMirUniv is 'Yes' -->
                <xsl:when test="b:csdMirUniv = 'Yes'">
                    <xsl:value-of select="2"/>
                </xsl:when>

                <!-- When csdMirUniv is 'No' -->
                <xsl:when test="b:csdMirUniv = 'No'">
                    <xsl:value-of select="1"/>
                </xsl:when>

                <!-- For 'None' or 'Undefined' (when csdMirUniv is empty or not 'Yes'/'No') -->
                <xsl:otherwise>
                    <xsl:value-of select="0"/>
                </xsl:otherwise>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_type_recomendation_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdTypofRec ='Notdefined'">
                    <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:when test="b:csdTypofRec ='Recommended'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdTypofRec ='Followed'">
                    <xsl:value-of select="2"/>
                </xsl:when>
                <xsl:when test="b:csdTypofRec ='Grandfathered'">
                    <xsl:value-of select="3"/>
                </xsl:when>
                <xsl:when test="b:csdTypofRec ='Growth'">
                    <xsl:value-of select="4"/>
                </xsl:when>
                <xsl:when test="b:csdTypofRec ='SpecialOpportunities'">
                    <xsl:value-of select="5"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_internal_view_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdIntView ='Notdefined'">
                    <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='HighConviction'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='Buy'">
                    <xsl:value-of select="2"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='Hold'">
                    <xsl:value-of select="3"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='Sell'">
                    <xsl:value-of select="4"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='UnderReview'">
                    <xsl:value-of select="5"/>
                </xsl:when>
                <xsl:when test="b:csdIntView ='Restricted'">
                    <xsl:value-of select="6"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_esg_leader_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdEsgLeader ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdEsgLeader ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_price_target_n'"/>
        </infra:name>
        <infra:value>
            <xsl:value-of select="b:csdPrcTarget"/>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_initiation_date_d'"/>
        </infra:name>
        <infra:value>
		<xsl:if test="b:csdInitDate!='' and b:csdInitDate">
            <xsl:value-of select="concat(substring(b:csdInitDate, 9, 2),'-',substring(b:csdInitDate, 6, 2),'-',substring(b:csdInitDate, 1, 4))"/>
        </xsl:if>
		</infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_termination_date_d'"/>
        </infra:name>
        <infra:value>
		<xsl:if test="b:csdTermDate!='' and b:csdTermDate">
            <xsl:value-of select="concat(substring(b:csdTermDate, 9, 2),'-',substring(b:csdTermDate, 6, 2),'-',substring(b:csdTermDate, 1, 4))"/>
        </xsl:if>
		</infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_investment_style_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdInvstStyle ='Notdefined'">
                    <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:when test="b:csdInvstStyle ='Core'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdInvstStyle ='Satellite'">
                    <xsl:value-of select="2"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_bonds_selection_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdBndsSel ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdBndsSel ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
<xsl:variable name="kidEligibility">
    <xsl:for-each select="b:instrumentTypeGroup/b:instrumentType">
        <infra:userDefinedField>
            <infra:name>kid_eligible_f</infra:name>
            <infra:value>
                <xsl:if test=". = 'PRIIP' or . = 'UCITS' or . = 'FinSA'">
                    <xsl:value-of select="'1'"/>
                </xsl:if>
                <xsl:if test="not(. = 'PRIIP' or . = 'UCITS' or . = 'FinSA')">
                    <xsl:value-of select="'0'"/>
                </xsl:if>
            </infra:value>
        </infra:userDefinedField>
    </xsl:for-each>
</xsl:variable>
<infra:userDefinedField>
    <infra:name>kid_eligible_f</infra:name>
    <infra:value>
        <xsl:choose>
            <xsl:when test="contains($kidEligibility, '1')">
                <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'0'"/>
            </xsl:otherwise>
        </xsl:choose>
    </infra:value>
</infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ins_invest_horizn_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
				<xsl:when test="b:investTenorList/b:investTenor[@index='1'] ='' or (not(b:investTenorList/b:investTenor[@index='1']))">
                    <xsl:value-of select="100"/>
                </xsl:when>
                <xsl:when test="b:investTenorList/b:investTenor[@index='1'] ='NotDefined'">
                    <xsl:value-of select="100"/>
                </xsl:when>
                <xsl:when test="b:investTenorList/b:investTenor[@index='1']='VeryShortTerm'">
                    <xsl:value-of select="101"/>
                </xsl:when>
                <xsl:when test="b:investTenorList/b:investTenor[@index='1'] ='ShortTerm'">
                    <xsl:value-of select="102"/>
                </xsl:when>
				<xsl:when test="b:investTenorList/b:investTenor[@index='1'] ='MediumTerm'">
                    <xsl:value-of select="103"/>
                </xsl:when>
                <xsl:when test="b:investTenorList/b:investTenor[@index='1'] ='LongTerm'">
                    <xsl:value-of select="104"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<xsl:choose>
			<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'ISAeligible'">
				<infra:userDefinedField>
					<infra:name>ud_isa_eligible_f</infra:name>
					<infra:value>
						<xsl:value-of select="'1'"/>
					</infra:value>
				</infra:userDefinedField>
			</xsl:when>
			<xsl:otherwise>
				<infra:userDefinedField>
					<infra:name>ud_isa_eligible_f</infra:name>
					<infra:value>
						<xsl:value-of select="'0'"/>
					</infra:value>
				</infra:userDefinedField>
			</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
			<xsl:when test="b:instrumentTypeGroup/b:instrumentType = 'ELIG.DURATION.ABAT'">
				<infra:userDefinedField>
					<infra:name>ud_elig_hlding_dur_abatment_f</infra:name>
					<infra:value>
						<xsl:value-of select="'1'"/>
					</infra:value>
				</infra:userDefinedField>
			</xsl:when>
			<xsl:otherwise>
				<infra:userDefinedField>
					<infra:name>ud_elig_hlding_dur_abatment_f</infra:name>
					<infra:value>
						<xsl:value-of select="'0'"/>
					</infra:value>
				</infra:userDefinedField>
			</xsl:otherwise>
	</xsl:choose>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_uk_rep_status_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdUkRepSts ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdUkRepSts ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_parent_com_name_c</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdPrtCpName"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_ultmte_prent_comp_name_t</infra:name>
        <infra:value>
            <xsl:for-each select="b:csdUltPtcmpnmList/b:csdUltPtcmpnm[@index]">         
				<xsl:value-of select="."/>               
	        </xsl:for-each>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_prnt_cmp_con_ri_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdPtCpCyRk"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_ulti_par_com_cy_rs_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdUtPtcpcyrk"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_prnt_cmp_cntry_domi_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdPtCpCyDo"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_ultmte_prnt_cmpcon_n_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdUtPtCpDo"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_boletas_elig_status_f</infra:name>
        <infra:value>
           <xsl:choose>
                <xsl:when test="b:csdBoletsElig ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdBoletsElig ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_mir_int_rating_issuer</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdMirInIssr = 'S&amp;P'">
						<xsl:value-of select="'S_P'"/>
					</xsl:when>
					<xsl:when test="b:csdMirInIssr = 'FITCH'">
						<xsl:value-of select="'FITCH'"/>
					</xsl:when>
					<xsl:when test="b:csdMirInIssr = 'DAGONG'">
						<xsl:value-of select="'DAGONG'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'MOODY_S'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>	
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_mir_int_rating</infra:name>
			<infra:value>
				<xsl:value-of select="b:csdMirInRate"/>
			</infra:value>
		</infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_cfi_t</infra:name>
        <infra:value>
            <xsl:value-of select="b:csdClsFinIns"/>
        </infra:value>
    </infra:userDefinedField>
	<xsl:variable name="PEAEligibility">
    <xsl:for-each select="b:instrumentTypeGroup/b:instrumentType">
        <xsl:if test=". = 'PEA.Eligible'">
            <xsl:value-of select="'1'"/>
        </xsl:if>
    </xsl:for-each>
	</xsl:variable>

	<xsl:variable name="PEASME">
    <xsl:for-each select="b:instrumentTypeGroup/b:instrumentType">
        <xsl:if test=". = 'PEA.SME'">
            <xsl:value-of select="'1'"/>
        </xsl:if>
    </xsl:for-each>
	</xsl:variable>

	<infra:userDefinedField>
    <infra:name>ud_pea_eligible_e</infra:name>
    <infra:value>
        <xsl:choose>
            <xsl:when test="contains($PEAEligibility, '1') and contains($PEASME, '1')">
                <xsl:value-of select="'3'"/>
            </xsl:when>
            <xsl:when test="contains($PEAEligibility, '') and contains($PEASME, '1')">
                <xsl:value-of select="'2'"/>
            </xsl:when>
            <xsl:when test="contains($PEAEligibility, '1') and contains($PEASME, '')">
                <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'0'"/>
            </xsl:otherwise>
        </xsl:choose>
    </infra:value>
	</infra:userDefinedField>
	
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_sc_irs_code_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdIrsCode ='1'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdIrsCode ='2'">
                    <xsl:value-of select="2"/>
                </xsl:when>
                <xsl:when test="b:csdIrsCode ='3'">
                    <xsl:value-of select="3"/>
                </xsl:when>	
                <xsl:when test="b:csdIrsCode =''">
                    <xsl:value-of select="0"/>
                </xsl:when>				
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_issue_date_d'"/>
        </infra:name>
        <infra:value>
		<xsl:if test="b:issueDate!='' and b:issueDate">
            <xsl:value-of select="concat(substring(b:issueDate, 9, 2),'-',substring(b:issueDate, 6, 2),'-',substring(b:issueDate, 1, 4))"/>
        </xsl:if>
		</infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_domicile_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:securityDomicile"/>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_allfunds_mir_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdAfbMirAva ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdAfbMirAva ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_traspasos_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdEligTrasp ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdEligTrasp ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdInvAvl ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdInvAvl ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_mir_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdInvAvlMir ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdInvAvlMir ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
</xsl:template>
<xsl:template name="infra:longName">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
		<infra:longName>
			<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</infra:longName>
	</xsl:if>
</xsl:template>
<xsl:template name="infra:multilingualLongName">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'en'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'fr'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='FR']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'de'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='DE']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:call-template name="OldNewDenomConcatManagment">
		<xsl:with-param name="CurrentEvent" select="./b:descriptList/b:descript"/>
		<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:descriptList/b:descript"/>
	</xsl:call-template>
</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
