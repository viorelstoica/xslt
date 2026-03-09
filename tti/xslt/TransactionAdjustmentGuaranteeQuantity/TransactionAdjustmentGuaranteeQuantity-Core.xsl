<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAdjustmentGuaranteeQuantity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:pastSchedDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="adjustmentNature">
      <adjustmentNature>1</adjustmentNature>
   </xsl:template>
   <xsl:template name="newSecurity">
      <newSecurity>
         <infra:code>
            <xsl:value-of select="concat(../b:dealNo,$COMPANY_POSTFIX_SEPARATOR,../b:coMnemonic)"/>
         </infra:code>
      </newSecurity>
   </xsl:template>
   <xsl:template name="oldPrice">
      <oldPrice>0</oldPrice>
   </xsl:template>
   <xsl:template name="oldQuantity">
      <xsl:if test="b:pastSchedAmount != ''">
         <oldQuantity>
            <xsl:choose>
               <xsl:when test="b:pastSchedType = 'PRN'">
                  <xsl:choose>
                     <xsl:when test="../b:contractType = 'CA'">
                        <xsl:value-of select="format-number(-1 * b:pastSchedAmount,$decimalformat,'nan2zero')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="b:pastSchedAmount"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="b:pastSchedType = 'INV' or b:pastSchedType = 'MAT'">
                  <xsl:choose>
                     <xsl:when test="../b:contractType = 'CA'">
                        <xsl:value-of select="b:pastSchedAmount"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="format-number(-1 * b:pastSchedAmount,$decimalformat,'nan2zero')"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
            </xsl:choose>
         </oldQuantity>
      </xsl:if>
   </xsl:template>
   <xsl:template name="oldSecurity">
      <oldSecurity>
         <infra:code>
            <xsl:value-of select="concat(../b:dealNo,$COMPANY_POSTFIX_SEPARATOR,../b:coMnemonic)"/>
         </infra:code>
      </oldSecurity>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:cusPortId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="concat(../b:dealNo,$COMPANY_POSTFIX_SEPARATOR,../b:coMnemonic,b:pastSchedType,b:pastSchedDate)"/>
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
      <xsl:variable name="index" select="@index"/>
      <transactionCode>
         <xsl:value-of select="concat(../b:dealNo,$COMPANY_POSTFIX_SEPARATOR,../b:coMnemonic,'_',b:pastSchedType,'_',$index)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <xsl:if test="b:pastSchedDate != ''">
         <transactionDate>
            <xsl:value-of select="b:pastSchedDate"/>
         </transactionDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>MD_GuaranteeQuantity</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <xsl:if test="b:pastSchedDate != ''">
         <valueDate>
            <xsl:value-of select="b:pastSchedDate"/>
         </valueDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1"/>
   <xsl:template name="account1CcyoldSecCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyoldSecCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyoldSecCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accruedInterestAmount"/>
   <xsl:template name="accruedInterestCounter"/>
   <xsl:template name="adjustmentCounter"/>
   <xsl:template name="adjustmentPortfolio"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="coaReference"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="communication"/>
   <xsl:template name="initiator"/>
   <xsl:template name="newQuantity"/>
   <xsl:template name="newSecurityCcyPositionCcyExchangeRate"/>
   <xsl:template name="newSecurityDepositaryAccount"/>
   <xsl:template name="newSecurityNetAmount"/>
   <xsl:template name="newSecurityPositionCriteria1"/>
   <xsl:template name="newSecurityPositionCriteria2"/>
   <xsl:template name="newSecurityPositionCriteria3"/>
   <xsl:template name="newSecurityPositionCurrency"/>
   <xsl:template name="notepad"/>
   <xsl:template name="oldCcyGrossAmount"/>
   <xsl:template name="oldCcyNetAmount"/>
   <xsl:template name="oldCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="oldSecurityDepositaryAccount"/>
   <xsl:template name="oldSecurityPositionCriteria1"/>
   <xsl:template name="oldSecurityPositionCriteria2"/>
   <xsl:template name="oldSecurityPositionCriteria3"/>
   <xsl:template name="oldSecurityPositionCurrency"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="supplementaryAmount"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="typeInstrument"/>
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