<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<xsl:template name="ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="TAP.DECI.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="TAP.DECI.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="TAP.DECI.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="TAP.DECI.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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