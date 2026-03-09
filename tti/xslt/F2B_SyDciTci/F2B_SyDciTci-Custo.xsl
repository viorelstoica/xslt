<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<xsl:template name="USERDEF.FIELDS">
		<!-- START Best Execution Development GOPI M -->
		<field name="CSD.CONTACT.BY">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_ACCT_HOLDER'">
					<xsl:value-of select="'Account Holder'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_PWR_ATTORNEY'">
					<xsl:value-of select="'Attorney'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_BENEF_OWNER'">
					<xsl:value-of select="'Beneficial Owner'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_ACCT_OTHER'">
					<xsl:value-of select="'Other'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_SIGNATORY'">
					<xsl:value-of select="'Signatory'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_THIRD_MANAGER'">
					<xsl:value-of select="'Third Party Manager'"/>
				</xsl:when>
				<!-- Optional: handle NULL or missing value -->
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.CONT.DATE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='communication_d']/infra:value != 'NULL'">
					<xsl:variable name="date" select="b:userDefinedField[infra:name='communication_d']/infra:value"/>
					<xsl:value-of select="concat(substring($date, 7, 4), substring($date, 4, 2), substring($date, 1, 2))"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.CONT.METHOD">
			<xsl:choose>
				<xsl:when test="b:contactMethod = 'PCK_GL_EMAIL'">
					<xsl:value-of select="'Email'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_OTHER'">
					<xsl:value-of select="'Other'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_FAX'">
					<xsl:value-of select="'Facsimile'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_INTERNET'">
					<xsl:value-of select="'Internet'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_LETTER'">
					<xsl:value-of select="'Letter Post'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_MEETING'">
					<xsl:value-of select="'Meeting'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_PHONE'">
					<xsl:value-of select="'Telephone'"/>
				</xsl:when>
				<!-- Optional: handle NULL or missing value -->
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.ORDER.INR">
			<xsl:choose>
				<xsl:when test="b:initiatedBy = '2'">
					<xsl:value-of select="'Bank'"/>
				</xsl:when>
				<xsl:when test="b:initiatedBy = '1'">
					<xsl:value-of select="'Client'"/>
				</xsl:when>
				<xsl:when test="b:initiatedBy = ''">
					<xsl:value-of select="''"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<!-- END Best Execution Development GOPI M-->
		<field name="CSD.TRADE.INSTR">
			<xsl:value-of select="b:attribute[@name = 'OP_REMARK']"/>
		</field>
	</xsl:template>
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