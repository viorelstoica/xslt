<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolio" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolio" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="status">
		<status>
			<xsl:choose>
				<xsl:when test="b:csdPtfStatus ='0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:csdPtfStatus ='1'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:csdPtfStatus ='2'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:csdPtfStatus ='4'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="b:csdPtfStatus ='7'">
					<xsl:value-of select="'7'"/>
				</xsl:when>
				<xsl:when test="b:csdPtfStatus ='8'">
					<xsl:value-of select="'8'"/>
				</xsl:when>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="infra:userDefinedField">
		<infra:userDefinedField>
			<infra:name>ud_policy_typ_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdPolicyType ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPolicyType ='A'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdPolicyType ='B'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdPolicyType ='C'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdPolicyType ='D'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdPolicyType ='N'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ukrnd_type_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdUkrndTyp ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='0'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='1'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='2'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='3'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='4'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:csdUkrndTyp ='5'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>tax_status_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdTaxStatus ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='5'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='6'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='7'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='8'">
						<xsl:value-of select="'8'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='9'">
						<xsl:value-of select="'9'"/>
					</xsl:when>
					<xsl:when test="b:csdTaxStatus ='10'">
						<xsl:value-of select="'10'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_lomgroup_c</infra:name>
			<infra:value>
				<xsl:value-of select="b:csdGroupId"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>strategy_id</infra:name>
			<infra:value>
				<xsl:value-of select="b:csdPtfInvPrf"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>object_id</infra:name>
			<infra:value>
				<xsl:value-of select="b:id"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>linked_entity_dict_id</infra:name>
			<infra:value>
				<xsl:value-of select="Portfolio"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>link_nat_e</infra:name>
			<infra:value>
				<xsl:value-of select="0"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ptf_pea_type_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdPeaType ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdPeaType ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdPeaType ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_all_in_fee_f</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdAllInFee ='Yes'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdAllInFee ='No'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_noblock_tapnarrative_c</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdNoblkTapnr">
						<xsl:value-of select="b:csdNoblkTapnr"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_blocking_narrative_c</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:blockingNarr">
						<xsl:value-of select="b:blockingNarr"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ptf_inv_size_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdInvSize ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdInvSize ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdInvSize ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdInvSize ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ptf_asset_specificity_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdAsstSpec ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdAsstSpec ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdAsstSpec ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdAsstSpec ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdAsstSpec ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ptf_region_preference_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdRegPref ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdRegPref ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdRegPref ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdRegPref ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdRegPref ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_ptf_esg_preference_f</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdEsgPref ='Y'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdEsgPref ='N'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<xsl:variable name="invSize">
			<xsl:choose>
				<xsl:when test="b:csdInvSize = '-1'">None</xsl:when>
				<xsl:when test="b:csdInvSize = '1'">Affluent</xsl:when>
				<xsl:when test="b:csdInvSize = '2'">Standard</xsl:when>
				<xsl:when test="b:csdInvSize = '3'">UHNW</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="asstSpec">
			<xsl:choose>
				<xsl:when test="b:csdAsstSpec = '-1'">None</xsl:when>
				<xsl:when test="b:csdAsstSpec = '1'">Equity</xsl:when>
				<xsl:when test="b:csdAsstSpec = '2'">Fixed Income</xsl:when>
				<xsl:when test="b:csdAsstSpec = '3'">Structured Products</xsl:when>
				<xsl:when test="b:csdAsstSpec = '4'">Private Assets</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="regPref">
			<xsl:choose>
				<xsl:when test="b:csdRegPref = '-1'">None</xsl:when>
				<xsl:when test="b:csdRegPref = '1'">USA</xsl:when>
				<xsl:when test="b:csdRegPref = '2'">Europe</xsl:when>
				<xsl:when test="b:csdRegPref = '3'">Canada</xsl:when>
				<xsl:when test="b:csdRegPref = '4'">Switzerland</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ecgPref">
			<xsl:choose>
				<xsl:when test="b:csdEsgPref = 'Y'">Yes</xsl:when>
				<xsl:when test="b:csdEsgPref = 'N'">No</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<infra:userDefinedField>
			<infra:name>ud_mngt_typology_t</infra:name>
			<infra:value>
				<xsl:value-of select="concat($invSize,' ',$ecgPref,' ',$asstSpec,' ',$regPref)"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_broker_portfolio_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:brokerOnly ='YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>ud_port_risk_grade_e</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:csdRiskGrade ='-1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:csdRiskGrade ='1'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:csdRiskGrade ='2'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:csdRiskGrade ='3'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:csdRiskGrade ='4'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="portfolioType">
		<portfolioType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:csdPtfEamFlg ='Yes'">
						<xsl:value-of select="'EAM'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'None'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolioType>
	</xsl:template>
	<!--RNJ-MIR - Custom mappings for service type-->
	<xsl:template name="serviceType">
		<serviceType>
			<xsl:choose>
				<xsl:when test="not(b:managedAccount) or b:managedAccount = '' or b:managedAccount = '99'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:managedAccount = '11'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:managedAccount = '12'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:managedAccount = '10'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</serviceType>
	</xsl:template>
	<xsl:template name="paymentInstruction">
		<!-- BEG - paymentInstruction for accountNosGroup -->
		<xsl:for-each select="b:accountNosGroup">
			<paymentInstruction>
				<account>
					<infra:code>
						<xsl:value-of select="b:accountNos"/>
					</infra:code>
				</account>
				<!-- Send currency ONLY when accountCcy != referenceCurrency -->
				<xsl:if test="b:accountCcy != ../b:referenceCurrency">
					<currency>
						<infra:code>
							<xsl:value-of select="b:accountCcy"/>
						</infra:code>
					</currency>
				</xsl:if>
				<operationNature>0</operationNature>
			</paymentInstruction>
		</xsl:for-each>
		<!--  Remove the payment instructions for the accounts that do not exist anymore as accountNo -->
		<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:accountNosGroup/b:accountNos">
			<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:accountNosGroup[b:accountNos = current()])">
				<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:accountNosGroup[b:accountCcy = current()/following-sibling::b:accountCcy])">
					<paymentInstruction mode="delete">
						<account>
							<infra:code>
								<xsl:value-of select="."/>
							</infra:code>
						</account>
						<currency>
							<infra:code>
								<xsl:value-of select="../b:accountCcy"/>
							</infra:code>
						</currency>
						<operationNature>0</operationNature>
					</paymentInstruction>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<!-- END - paymentInstruction for accountNosGroup -->
		<!-- BEG - paymentInstruction for incAccountNoGroup -->
		<xsl:if test="b:exclIncValuationScParameterJoin = 'YES'">
			<xsl:for-each select="b:incAccountNoGroup">
				<paymentInstruction>
					<account>
						<infra:code>
							<xsl:value-of select="b:incAccountNo"/>
						</infra:code>
					</account>
					<currency>
						<infra:code>
							<xsl:value-of select="b:incAccountCcy"/>
						</infra:code>
					</currency>
					<operationNature>3</operationNature>
				</paymentInstruction>
			</xsl:for-each>
			<!--  Remove the payment instructions for the accounts that do not exist anymore as accountNo -->
			<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:incAccountNoGroup/b:incAccountNo">
				<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:incAccountNoGroup[b:incAccountNo = current()])">
					<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:incAccountNoGroup[b:incAccountCcy = current()/following-sibling::b:incAccountCcy])">
						<paymentInstruction mode="delete">
							<account>
								<infra:code>
									<xsl:value-of select="."/>
								</infra:code>
							</account>
							<currency>
								<infra:code>
									<xsl:value-of select="../b:incAccountCcy"/>
								</infra:code>
							</currency>
							<operationNature>3</operationNature>
						</paymentInstruction>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<!-- END - paymentInstruction for incAccountNoGroup -->
	</xsl:template> -->
	<!-- END of protected area  -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.
<metaInformation>
    <scenarios/>
    <MapperMetaTag>
        <MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
        <MapperBlockPosition></MapperBlockPosition>
        <TemplateContext></TemplateContext>
        <MapperFilter side="source"></MapperFilter>
    </MapperMetaTag>
</metaInformation>
-->