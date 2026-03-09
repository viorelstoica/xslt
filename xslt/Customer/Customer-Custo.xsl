<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Customer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="classification">
		<classification>
			<xsl:choose>
				<xsl:when test="b:csdMfdInvCtg ='-1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:csdMfdInvCtg ='0'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:csdMfdInvCtg ='1'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:csdMfdInvCtg ='2'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
			</xsl:choose>
		</classification>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<name>status_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdClntStatus ='0'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdClntStatus ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdClntStatus ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdClntStatus ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdClntStatus ='7'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
					<xsl:when test="b:csdClntStatus ='8'">
						<xsl:value-of select="'8'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_fatca_client_e</name>
			<value>
				<xsl:value-of select="b:csdFatca"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_ukrnd_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdUkrnd ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrnd ='No'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_cl_invstmnt_prof_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCltInvPrf ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdCltInvPrf ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdCltInvPrf ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdCltInvPrf ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdCltInvPrf ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_life_insurance_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLifeIns ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdLifeIns ='No'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_life_insurance_t</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLifeIns ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdLifeIns ='No'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_ultimte_bo_id.code</name>
			<value>
				<xsl:value-of select="b:csdUlBoNat"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_sub_type_id.code</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdClntSubtyp ='ASC-ASN'">
						<xsl:value-of select="'ASC-ASN'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='ASC-ASP'">
						<xsl:value-of select="'ASC-ASP'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COL-COL'">
						<xsl:value-of select="'COL-COL'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COL-USU'">
						<xsl:value-of select="'COL-USU'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-COM'">
						<xsl:value-of select="'COM-COM'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-DOM'">
						<xsl:value-of select="'COM-DOM'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-FOR'">
						<xsl:value-of select="'COM-FOR'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-HDC'">
						<xsl:value-of select="'COM-HDC'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-HOC'">
						<xsl:value-of select="'COM-HOC'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-INF'">
						<xsl:value-of select="'COM-INF'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-OPC'">
						<xsl:value-of select="'COM-OPC'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-PAR'">
						<xsl:value-of select="'COM-PAR'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-RFI'">
						<xsl:value-of select="'COM-RFI'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-SOE'">
						<xsl:value-of select="'COM-SOE'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-UFN-N'">
						<xsl:value-of select="'COM-UFN-N'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-UFN-O'">
						<xsl:value-of select="'COM-UFN-O'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-UFN-P'">
						<xsl:value-of select="'COM-UFN-P'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-UTS'">
						<xsl:value-of select="'COM-UTS'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='FOU-FND'">
						<xsl:value-of select="'FOU-FND'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='FOU-FNO'">
						<xsl:value-of select="'FOU-FNO'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='FOU-FNP'">
						<xsl:value-of select="'FOU-FNP'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='IND-IND'">
						<xsl:value-of select="'IND-IND'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='IND-USU'">
						<xsl:value-of select="'IND-USU'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='JNT-JNT'">
						<xsl:value-of select="'JNT-JNT'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='JNT-USU'">
						<xsl:value-of select="'JNT-USU'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='LIN-LIN'">
						<xsl:value-of select="'LIN-LIN'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='LIF-LIF'">
						<xsl:value-of select="'LIF-LIF'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='TRU-TRU'">
						<xsl:value-of select="'TRU-TRU'"/>
					</xsl:when>
					<xsl:when test="b:csdClntSubtyp ='COM-SEC'">
						<xsl:value-of select="'COM-SEC'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>fi_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdBndsKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdBndsKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdBndsKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdBndsKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdBndsKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>futures_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdDeriKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdDeriKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdDeriKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdDeriKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdDeriKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>equity_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdEquitiesKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdEquitiesKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdEquitiesKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdEquitiesKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdEquitiesKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>commodities_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdGldDepoKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdGldDepoKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdGldDepoKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdGldDepoKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdGldDepoKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>dualccy_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdMnymrktKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdMnymrktKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdMnymrktKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdMnymrktKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdMnymrktKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>realestate_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdPvtEqKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPvtEqKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdPvtEqKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdPvtEqKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdPvtEqKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>etf_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdInvtfundKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdInvtfundKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdInvtfundKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdInvtfundKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdInvtfundKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>mf_unit_trusts_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdShrsMfKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdShrsMfKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdShrsMfKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdShrsMfKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdShrsMfKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>sp_cap_protection_exp_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdStrcPrdKe ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdStrcPrdKe ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdStrcPrdKe ='0'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdStrcPrdKe ='2'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdStrcPrdKe ='3'">
						<xsl:value-of select="'101'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_traspasos_mandate_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdTrspMdFlg ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!-- adding LEI for REQ136292-Core_Trading_Canadian Markers-->
		<userDefinedField>
			<name>ud_lei_c</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLeiCode">
						<xsl:value-of select="b:csdLeiCode"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!-- End of adding LEI for REQ136292-Core_Trading_Canadian Markers-->
		<!-- adding for REQ142063-Wealth Planning_CLMi Data in TAP -->
		<!-- Knowledge -->
		<userDefinedField>
			<name>ud_mmktins_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdMmktiKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_bndfrmsecudebt_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdBdfrmsdKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_equ_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdEquKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shmf_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdShmfKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_sainvfnd_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdSifKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_gldmetdep_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdGldmdKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_strucpro_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdStrproKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_prveq_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdPeKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_derprd_knwl_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdDpKnw ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!-- Years since first investment -->
		<userDefinedField>
			<name>ud_mktins_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdMktinYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_bndsecdbt_yr_fst_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdBfsdYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_eq_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdEquYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdEquYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdEquYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdEquYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shrmf_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdShmfYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_sanvfnd_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdSifYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdSifYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdSifYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdSifYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_gldmtdp_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdGldmdYysfi ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdYysfi ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdYysfi ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdYysfi ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_strucprd_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdStrprYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_pveq_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdPeYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPeYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdPeYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdPeYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_derprdt_yr_first_inv_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdDpYsfin ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdDpYsfin ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdDpYsfin ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdDpYsfin ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!-- Average invested amount -->
		<userDefinedField>
			<name>ud_mktins_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdMmktiAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdMmktiAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdMmktiAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdMmktiAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_bndscdbt_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdBsecdAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdBsecdAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdBsecdAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdBsecdAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_eq_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdEqagiAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdEqagiAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdEqagiAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdEqagiAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shmfnd_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdShmfAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_sanvfnd_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdSifAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdSifAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdSifAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdSifAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_gldmetdp_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdGldmdAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_strucprod_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdStrprAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_prvequ_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdPeAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPeAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdPeAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdPeAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_dervprd_avg_inv_amt_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdDpAvgia ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdDpAvgia ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdDpAvgia ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdDpAvgia ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!--Number of transactions-->
		<userDefinedField>
			<name>ud_mmktins_txn_n</name>
			<value>
				<xsl:value-of select="b:csdMmktiNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_bndfrmsecudebt_txn_n</name>
			<value>
				<xsl:value-of select="b:csdBfsdNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_equ_txn_n</name>
			<value>
				<xsl:value-of select="b:csdEquNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shmf_txn_n</name>
			<value>
				<xsl:value-of select="b:csdShmfNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_sainvfnd_txn_n</name>
			<value>
				<xsl:value-of select="b:csdSinvfnNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_gldmetdep_txn_n</name>
			<value>
				<xsl:value-of select="b:csdGldmdepNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_strucpro_txn_n</name>
			<value>
				<xsl:value-of select="b:csdStrproNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_prveq_txn_n</name>
			<value>
				<xsl:value-of select="b:csdPeNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_derprd_txn_n</name>
			<value>
				<xsl:value-of select="b:csdDpNt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<!--Target Market K&E-->
		<userDefinedField>
			<name>ud_mktins_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdMktinsTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinsTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinsTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinsTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdMktinsTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_bndfrmsecudbt_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdBfsdTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdBfsdTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_eq_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdEquTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdEquTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdEquTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdEquTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdEquTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shrmf_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdShmfTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdShmfTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_shrinvfnd_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdSifTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdSifTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdSifTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdSifTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdSifTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_gldmtdep_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdGldmdTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdGldmdTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_strucprd_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdStrprTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdStrprTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_pvteq_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdPeTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPeTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdPeTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdPeTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdPeTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_deriprd_tmke_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdDpTmke ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdDpTmke ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdDpTmke ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdDpTmke ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdDpTmke ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!--Start Best Execution in Climi FSD -->
		<userDefinedField>
			<name>ud_eam_flag_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCusEamFlg ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<!--Start Best Execution in Climi FSD -->
		<!-- End of REQ142063-Wealth Planning_CLMi Data in TAP -->
		<userDefinedField>
			<name>ud_client_serv_center_id.code</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCtrBrCode">
						<xsl:value-of select="b:csdCtrBrCode"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_clnt_vul_status_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCustVuln ='Y'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdCustVuln ='N'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_lei_start_d</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLeiStDate !=''">
						<xsl:value-of select="concat(substring(b:csdLeiStDate, 9, 2),'/',substring(b:csdLeiStDate, 6, 2),'/',substring(b:csdLeiStDate, 1, 4))"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_lei_end_d</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLeiEdDate !=''">
						<xsl:value-of select="concat(substring(b:csdLeiEdDate, 9, 2),'/',substring(b:csdLeiEdDate, 6, 2),'/',substring(b:csdLeiEdDate, 1, 4))"/>
					</xsl:when>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_crn_number_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCrnNo ='YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdCrnNo ='NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_clawbck_amt_n</name>
			<value>
				<xsl:value-of select="b:csdClawbckAmt"/>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_compliance_alert_f</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCmplAlert ='YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdCmplAlert ='NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_cust_qi_statu_c</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdCustQiSt">
						<xsl:value-of select="b:csdCustQiSt"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_fatca_supp_info_c</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdFatcaStat">
						<xsl:value-of select="b:csdFatcaStat"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</value>
			<type>string</type>
		</userDefinedField>
		<userDefinedField>
			<name>ud_loss_tolerance_id</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdLossTolnc ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdLossTolnc ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdLossTolnc ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdLossTolnc ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdLossTolnc ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_port_invest_obj_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdInvObjctv ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdInvObjctv ='A'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdInvObjctv ='B'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdInvObjctv ='C'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
		<userDefinedField>
			<name>ud_port_invest_horizn_e</name>
			<value>
				<xsl:choose>
					<xsl:when test="b:csdTimeHorzn ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdTimeHorzn ='A'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdTimeHorzn ='B'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdTimeHorzn ='C'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdTimeHorzn ='D'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</value>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="taxationCountry">
		<taxationCountry>
			<code>
				<xsl:value-of select="b:effTaxRes"/>
			</code>
		</taxationCountry>
	</xsl:template>
	<xsl:template name="issuerRole">
		<issuerRole>
			<xsl:choose>
				<xsl:when test="b:sector = '3901'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</issuerRole>
	</xsl:template>
	<xsl:template name="dataSecuProf">
		<xsl:if test="b:sector = '3901'">
			<dataSecuProf>
				<code>
					<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
				</code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>