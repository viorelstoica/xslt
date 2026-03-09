<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="omsOrderReference">
		<omsOrderReference>
			<xsl:value-of select="b:id"/>
		</omsOrderReference>
	</xsl:template>
	<xsl:template name="pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="b:tapRefId"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf and b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcc"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<xsl:if test="b:tapSleevePtf and b:tapSleevePtf !=''">
			<boPortfolio>
				<infra:code>
					<xsl:value-of select="b:securityAcc"/>
				</infra:code>
			</boPortfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="boRoutingBusinessEntityId">
      <boRoutingBusinessEntityId>
         <xsl:value-of select="b:coCode"/>
      </boRoutingBusinessEntityId>
   </xsl:template>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="buySellIndicator"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="channel"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="notepad"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="orderPriceType"/>
	<xsl:template name="orderStatus"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="priceRule"/>
	<xsl:template name="quantity"/>
	<xsl:template name="remark"/>
	<xsl:template name="security"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="subType"/>
	<xsl:template name="switchFrom"/>
	<xsl:template name="switchTo"/>
	<xsl:template name="tradeType"/>
	<xsl:template name="type"/>
	<xsl:template name="validityDate"/>
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