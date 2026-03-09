<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerDocument" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerDocument" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerDocument" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerDocument" xmlns:infra="http://www.odcgroup.com/InfraPMS">
	<!-- _@GVA$Date: 2024-04-22 19:24:24 +0200 (Mon, 22 Apr 2024) $@_  -->
	<xsl:template name="title">
		<title>
			<xsl:choose>
				<xsl:when test="b:csdDocNameList/b:csdDocName[@index='1'] and b:csdDocNameList/b:csdDocName[@index='1'] != ''">
					<xsl:value-of select="b:csdDocNameList/b:csdDocName[@index='1']"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after(b:id,'*')"/>
				</xsl:otherwise>
			</xsl:choose>
		</title>
	</xsl:template>
	<!-- BEG - JPP20240419 - pb when not sigdate (avoid null value) -->
	<xsl:template name="userDefinedField">
		<xsl:if test="b:sigDate and b:sigDate != ''">
			<userDefinedField>
				<infra:name>effective_d</infra:name>
				<infra:value>
					<xsl:value-of select="concat(substring(b:sigDate, 9, 2),'/',substring(b:sigDate, 6, 2),'/',substring(b:sigDate, 1, 4))"/>
				</infra:value>
			</userDefinedField>
		</xsl:if>
		<xsl:if test="b:endDate and b:endDate != ''">
			<userDefinedField>
				<infra:name>ud_end_d</infra:name>
				<infra:value>
					<xsl:value-of select="concat(substring(b:endDate, 9, 2),'/',substring(b:endDate, 6, 2),'/',substring(b:endDate, 1, 4))"/>
				</infra:value>
			</userDefinedField>
		</xsl:if>
	</xsl:template>
	<!-- END - JPP20240419 - pb when not sigdate avoid null value -->
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