<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/AAAccountAccrual" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="b:APPLICATIONAAARRANGEMENTACTIVITYDetails/b:applicationaaArrangementActivitycurrency"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="dataNature">
		<dataNature>18</dataNature>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:APPLICATIONACCOUNTDetails/b:applicationaccountaccountNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="validity">
		<validity>
			<xsl:value-of select="b:eventCommonDetails/b:eventCommon/ns0:today"/>
		</validity>
	</xsl:template>
	<xsl:template name="value">
		<xsl:choose>
			<xsl:when test="contains(b:APPLICATIONAAINTERESTACCRUALSDetails/b:applicationaaInterestAccrualsid,'DRINTEREST')">
				<value>
					<xsl:value-of select="(-1)*(b:APPLICATIONAAINTERESTACCRUALSDetails/b:applicationaaInterestAccrualstotAccrAmtGroup[position()=last()]/b:applicationaaInterestAccrualstotAccrAmt)"/>
				</value>
			</xsl:when>
			<xsl:when test="contains(b:APPLICATIONAAINTERESTACCRUALSDetails/b:applicationaaInterestAccrualsid,'CRINTEREST')">
				<value>
					<xsl:value-of select="b:APPLICATIONAAINTERESTACCRUALSDetails/b:applicationaaInterestAccrualstotAccrAmtGroup[position()=last()]/b:applicationaaInterestAccrualstotAccrAmt"/>
				</value>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="valueType"/>
	<xsl:template name="mbFields"/>
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