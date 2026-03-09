<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="ModelBankSpecificFields">
		<xsl:if test="b:attribute[@name = 'initiatedBy'] != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:attribute[@name = 'initiatedBy'] = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:attribute[@name = 'initiatedBy'] = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:attribute[@name = 'initiatedBy'] = '2' and b:attribute[@name = 'ptf_service_type_e'] = '1'">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'manager_nci_c'] != '' and b:attribute[@name = 'manager_nci_c'] != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:attribute[@name = 'portfolioManager'],'-',b:attribute[@name = 'manager_nci_c'])"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:attribute[@name = 'manager_nci_c'] = '' or b:attribute[@name = 'manager_nci_c'] = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:attribute[@name = 'portfolioManager']"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:attribute[@name = 'initiatedBy'] != '2' or b:attribute[@name = 'ptf_service_type_e'] != '1'">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'decision_maker_type_e'] = '2' and (b:attribute[@name = 'decision_maker_nci_c'] != '' or b:attribute[@name = 'decision_maker_nci_c'] != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:attribute[@name = 'decision_maker'],'-',b:attribute[@name = 'decision_maker_nci_c'])"/>
					</field>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'decision_maker_type_e'] = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:attribute[@name = 'decision_maker']"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:attribute[@name = 'initiatedBy'] = '2' and (b:attribute[@name = 'ptf_service_type_e'] = '1' or b:attribute[@name = 'ptf_service_type_e'] = '2')">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'manager_nci_c'] != '' and b:attribute[@name = 'manager_nci_c'] != 'NULL'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:attribute[@name = 'portfolioManager'],'-',b:attribute[@name = 'manager_nci_c'])"/>
					</field>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'manager_nci_c'] = '' or b:attribute[@name = 'manager_nci_c'] = 'NULL'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:attribute[@name = 'portfolioManager']"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:attribute[@name = 'initiatedBy'] != '2' or not(b:attribute[@name = 'ptf_service_type_e'] = '1' or b:attribute[@name = 'ptf_service_type_e'] = '2')">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'instruction_maker_type_e'] = '2' and (b:attribute[@name = 'instruction_maker_nci_c'] != '' and b:attribute[@name = 'instruction_maker_nci_c'] != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:attribute[@name = 'instruction_maker'],'-',b:attribute[@name = 'instruction_maker_nci_c'])"/>
					</field>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'instruction_maker_type_e'] = '3'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:attribute[@name = 'instruction_maker']"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="b:attribute[@name = 'manager_nci_c'] != ''">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:attribute[@name = 'portfolioManager'],'-',b:attribute[@name = 'manager_nci_c'])"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:attribute[@name = 'portfolioManager']"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="b:attribute[@name = 'trader_nci_c'] != ''">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:attribute[@name = 'trader'],'-',b:attribute[@name = 'trader_nci_c'])"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:attribute[@name = 'trader']"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:attribute[@name = 'client_nci_c'] != '' and b:attribute[@name = 'client_type_e'] = '2'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:attribute[@name = 'client_third_party_id'],'-',b:attribute[@name = 'client_nci_c'])"/>
				</field>
			</xsl:when>
			<xsl:when test="b:attribute[@name = 'client_type_e'] = '3'"/>
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