<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockedSecurityPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="depositaryAccount">
      <xsl:choose>
   		<xsl:when test="b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
   </xsl:template>
   <xsl:template name="lockingUnlocking">
      <lockingUnlocking>
         <xsl:value-of select="'1'"/>
      </lockingUnlocking>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:securityAccount"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:nomAmtBlocked"/>
      </quantity>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="b:securityNumber"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat(b:id, '_LOCK')"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionCurrency">
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:securityCurrencyJoin"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="lockingDate"/>
   <xsl:template name="lockingTransactionCode"/>
   <xsl:template name="lockingType"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="type"/>
   <xsl:template name="validityDate"/>
   <xsl:template name="valueDate"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="endDate"/>
   <xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
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