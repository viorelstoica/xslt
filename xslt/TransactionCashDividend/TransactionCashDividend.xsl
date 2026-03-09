<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionEntitlement">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionEntitlement"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionEntitlement">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" name="BatchTransactionEntitlement">
         <xsl:apply-templates select="b:TransactionEntitlement"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionEntitlement">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" name="BatchMultiTransactionEntitlement">
         <xsl:apply-templates select="c:MultiTransactionEntitlement"/>
      </xsl:element>
   </xsl:template>


   <xsl:template match="b:TransactionEntitlement">
      <CorporateActionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('CoaCashDividend',b:diaryId)"/>
         </xsl:attribute>
		 <xsl:if test="b:eventType != 'PEFUNDDIST'">
         <DataGroup>
            <CashDividend>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('TransactionCashDividend.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="account1"/>
               <xsl:call-template name="account1CcyDividendCcyExchangeRate"/>
               <xsl:call-template name="account1NetAmount"/>
               <xsl:call-template name="account2"/>
               <xsl:call-template name="account2CcyDividendCcyExchangeRate"/>
               <xsl:call-template name="account2NetAmount"/>
               <xsl:call-template name="account3"/>
               <xsl:call-template name="account3CcyDividendCcyExchangeRate"/>
               <xsl:call-template name="account3NetAmount"/>
               <xsl:call-template name="accountingCode"/>
               <xsl:call-template name="accountingDate"/>
               <xsl:call-template name="cashDividend"/>
               <xsl:call-template name="cashPortfolio"/>
               <xsl:call-template name="coaReference"/>
			   <xsl:call-template name="commonReference"/>
               <xsl:call-template name="contractNumber"/>
               <xsl:call-template name="depositaryAccount"/>
               <xsl:call-template name="dividendCcyGrossAmount"/>
               <xsl:call-template name="dividendCcyNetAmount"/>
               <xsl:call-template name="dividendCcyPortfolioCcyExchangeRate"/>
               <xsl:call-template name="dividendCurrency"/>
			   <xsl:call-template name="exDate"/>
               <xsl:call-template name="initiator"/>
               <xsl:call-template name="nominalOrUnit"/>
               <xsl:call-template name="notepad"/>
               <xsl:call-template name="remark"/>
               <xsl:call-template name="reversalIndicator"/>
               <xsl:call-template name="reversedTransactionCode"/>
               <xsl:call-template name="portfolio"/>
               <xsl:call-template name="portfolioManager"/>
			   <xsl:call-template name="positionCriteria1"/>
               <xsl:call-template name="security"/>
               <xsl:call-template name="securityCcyNetAmount"/>
               <xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
               <xsl:call-template name="sourceSystemCode"/>
			   <xsl:call-template name="splitPortfolio"/>
               <xsl:call-template name="status"/>
               <xsl:call-template name="subType"/>
               <xsl:call-template name="transactionCode"/>
               <xsl:call-template name="transactionDate"/>
               <xsl:call-template name="transactionFeesTaxesCounter"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="typeInstrument"/>
               <xsl:call-template name="valueDate"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
            </CashDividend>
         </DataGroup>
		 </xsl:if>
		 <xsl:if test="b:eventType = 'PEFUNDDIST' and b:optionDescGroup/b:entitlementAmt and b:optionDescGroup/b:entitlementAmt != 0 and b:peType= 'ACTUAL PE SECURITY'">
         <DataGroup>
            <CashDividend>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('TransactionCashDividend.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="account1_PEFUNDDIST"/>
               <xsl:call-template name="account1CcyDividendCcyExchangeRate_PEFUNDDIST"/>
               <xsl:call-template name="account1NetAmount_PEFUNDDIST"/>
               <xsl:call-template name="account2_PEFUNDDIST"/>
               <xsl:call-template name="account2CcyDividendCcyExchangeRate_PEFUNDDIST"/>
               <xsl:call-template name="account2NetAmount_PEFUNDDIST"/>
               <xsl:call-template name="account3_PEFUNDDIST"/>
               <xsl:call-template name="account3CcyDividendCcyExchangeRate_PEFUNDDIST"/>
               <xsl:call-template name="account3NetAmount_PEFUNDDIST"/>
               <xsl:call-template name="accountingCode_PEFUNDDIST"/>
               <xsl:call-template name="accountingDate_PEFUNDDIST"/>
               <xsl:call-template name="cashDividend_PEFUNDDIST"/>
               <xsl:call-template name="cashPortfolio_PEFUNDDIST"/>
               <xsl:call-template name="coaReference_PEFUNDDIST"/>
			   <xsl:call-template name="commonReference_PEFUNDDIST"/>
               <xsl:call-template name="contractNumber_PEFUNDDIST"/>
               <xsl:call-template name="depositaryAccount_PEFUNDDIST"/>
               <xsl:call-template name="dividendCcyGrossAmount_PEFUNDDIST"/>
               <xsl:call-template name="dividendCcyNetAmount_PEFUNDDIST"/>
               <xsl:call-template name="dividendCcyPortfolioCcyExchangeRate_PEFUNDDIST"/>
               <xsl:call-template name="dividendCurrency_PEFUNDDIST"/>
			   <xsl:call-template name="exDate_PEFUNDDIST"/>
               <xsl:call-template name="initiator_PEFUNDDIST"/>
               <xsl:call-template name="nominalOrUnit_PEFUNDDIST"/>
               <xsl:call-template name="notepad_PEFUNDDIST"/>
               <xsl:call-template name="remark_PEFUNDDIST"/>
               <xsl:call-template name="reversalIndicator_PEFUNDDIST"/>
               <xsl:call-template name="reversedTransactionCode_PEFUNDDIST"/>
               <xsl:call-template name="portfolio_PEFUNDDIST"/>
               <xsl:call-template name="portfolioManager_PEFUNDDIST"/>
			   <xsl:call-template name="positionCriteria1_PEFUNDDIST"/>
               <xsl:call-template name="security_PEFUNDDIST"/>
               <xsl:call-template name="securityCcyNetAmount_PEFUNDDIST"/>
               <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_PEFUNDDIST"/>
               <xsl:call-template name="sourceSystemCode_PEFUNDDIST"/>
			   <xsl:call-template name="splitPortfolio_PEFUNDDIST"/>
               <xsl:call-template name="status_PEFUNDDIST"/>
               <xsl:call-template name="subType_PEFUNDDIST"/>
               <xsl:call-template name="transactionCode_PEFUNDDIST"/>
               <xsl:call-template name="transactionDate_PEFUNDDIST"/>
               <xsl:call-template name="transactionFeesTaxesCounter_PEFUNDDIST"/>
               <xsl:call-template name="type_PEFUNDDIST"/>
               <xsl:call-template name="typeInstrument_PEFUNDDIST"/>
               <xsl:call-template name="valueDate_PEFUNDDIST"/>
               <xsl:call-template name="userDefinedField_PEFUNDDIST"/>
               <xsl:call-template name="mbFields_PEFUNDDIST"/>
            </CashDividend>
         </DataGroup>
		 </xsl:if>
		 
      </CorporateActionPMS>
   </xsl:template><!-- End of template CashDividend -->
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