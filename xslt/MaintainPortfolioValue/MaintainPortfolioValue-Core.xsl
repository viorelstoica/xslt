<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:choose>
					<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
						<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId)"/>
					</xsl:when>
					<xsl:otherwise>
            			<xsl:value-of select="b:entitlementId"/>
					</xsl:otherwise>
			</xsl:choose>
		</code>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:accountNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:netAmtAccCur"/>
		</quantity>
	</xsl:template>
	<xsl:template name="exDate">
		<xsl:if test="b:optStatus = 'PAID' or b:optStatus = 'ELECTED'">
			<exDate>
				<xsl:value-of select="b:eventCommon/ns0:today"/>
			</exDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate">
		<xsl:if test="b:optStatus = 'COMPLETED'">
			<endDate>
				<xsl:value-of select="b:PayDateJoin"/>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
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