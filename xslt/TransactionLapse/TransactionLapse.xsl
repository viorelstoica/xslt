<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
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
      <GenericCOA>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('CoaLapse',b:diaryId)"/>
         </xsl:attribute><!-- Transaction status: opStatus -->
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable><!-- Call optionDescGroup -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="opStatus" select="$opStatus"/>
         </xsl:apply-templates>
      </GenericCOA>
   </xsl:template><!-- optionDescGroup -->
   <xsl:template match="b:optionDescGroup">
      <xsl:param name="opStatus"/><!-- transaction status -->
      <xsl:choose>
         <xsl:when test="(b:entitlementAmt) and (b:entitlementAmt != 0)"><!-- Sell the position -->
            <DataGroup>
               <Sell>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionLapse.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="account1"/>
                  <xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account1NetAmount"/>
                  <xsl:call-template name="account2"/>
                  <xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account2NetAmount"/>
                  <xsl:call-template name="account3"/>
                  <xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account3NetAmount"/>
                  <xsl:call-template name="accountingCode"/>
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="accruedInterestAmount"/>
                  <xsl:call-template name="accruedInterestCounter"/>
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="coaReference"/>
				  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="communication"/>
                  <xsl:call-template name="depositaryAccount"/>
				  <xsl:call-template name="exDate"/>
                  <xsl:call-template name="initiator"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="remark"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="security"/>
                  <xsl:call-template name="securityCcyNetAmount"/>
                  <xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="sourceSystemCode"/>
				  <xsl:call-template name="splitPortfolio"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="supplementaryAmount"/>
                  <xsl:call-template name="tradeCcyGrossAmount"/>
                  <xsl:call-template name="tradeCcyNetAmount"/>
                  <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="tradeCurrency"/>
                  <xsl:call-template name="tradePrice"/>
                  <xsl:call-template name="tradeQuantity"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="transactionFeesTaxesCounter"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="typeInstrument"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
               </Sell>
            </DataGroup>
         </xsl:when>
         <xsl:otherwise><!-- Investment negative -->
            <DataGroup>
               <Investment>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionLapse.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="account1_Inv"/>
                  <xsl:call-template name="account1CcyTradeCcyExchangeRate_Inv"/>
                  <xsl:call-template name="account1NetAmount_Inv"/>
                  <xsl:call-template name="account2_Inv"/>
                  <xsl:call-template name="account2CcyTradeCcyExchangeRate_Inv"/>
                  <xsl:call-template name="account2NetAmount_Inv"/>
                  <xsl:call-template name="account3_Inv"/>
                  <xsl:call-template name="account3CcyTradeCcyExchangeRate_Inv"/>
                  <xsl:call-template name="account3NetAmount_Inv"/>
                  <xsl:call-template name="accountingCode_Inv"/>
                  <xsl:call-template name="accountingDate_Inv"/>
                  <xsl:call-template name="accruedInterestAmount_Inv"/>
                  <xsl:call-template name="accruedInterestCounter_Inv"/>
                  <xsl:call-template name="cashPortfolio_Inv"/>
                  <xsl:call-template name="coaReference_Inv"/>
				  <xsl:call-template name="commonReference_Inv"/>
                  <xsl:call-template name="communication_Inv"/>
                  <xsl:call-template name="depositaryAccount_Inv"/>
				   <xsl:call-template name="exDate_Inv"/>
                  <xsl:call-template name="initiator_Inv"/>
                  <xsl:call-template name="notepad_Inv"/>
                  <xsl:call-template name="portfolio_Inv"/>
                  <xsl:call-template name="portfolioManager_Inv"/>
                  <xsl:call-template name="positionCriteria1_Inv"/>
                  <xsl:call-template name="positionCriteria2_Inv"/>
                  <xsl:call-template name="positionCriteria3_Inv"/>
                  <xsl:call-template name="remark_Inv"/>
                  <xsl:call-template name="reversalIndicator_Inv"/>
                  <xsl:call-template name="reversedTransactionCode_Inv"/>
                  <xsl:call-template name="security_Inv"/>
                  <xsl:call-template name="sourceSystemCode_Inv"/>
				  <xsl:call-template name="splitPortfolio_Inv"/>
                  <xsl:call-template name="status_Inv"/>
                  <xsl:call-template name="subType_Inv"/>
                  <xsl:call-template name="supplementaryAmount_Inv"/>
                  <xsl:call-template name="tradeCcyGrossAmount_Inv"/>
                  <xsl:call-template name="tradeCcyNetAmount_Inv"/>
                  <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Inv"/>
                  <xsl:call-template name="tradeCurrency_Inv"/>
                  <xsl:call-template name="tradePrice_Inv"/>
                  <xsl:call-template name="tradeQuantity_Inv"/>
                  <xsl:call-template name="transactionCode_Inv"/>
                  <xsl:call-template name="transactionDate_Inv"/>
                  <xsl:call-template name="transactionFeesTaxesCounter_Inv"/>
                  <xsl:call-template name="type_Inv"/>
                  <xsl:call-template name="typeInstrument_Inv"/>
                  <xsl:call-template name="valueDate_Inv"/>
                  <xsl:call-template name="userDefinedField_Inv"/>
                  <xsl:call-template name="mbFields_Inv"/>
               </Investment>
            </DataGroup>
         </xsl:otherwise><!-- end of: entilementAmt exists -->
      </xsl:choose>
   </xsl:template><!-- End of template OptionDescGroup -->
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