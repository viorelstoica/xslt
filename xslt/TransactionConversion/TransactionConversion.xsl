<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/><!-- notes: FT defined on first secu bought, cost price of old secu transferred on first secu bought -->
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
            <xsl:value-of select="concat('CoaConversion',b:diaryId)"/>
         </xsl:attribute><!-- Index of first optionDescGroup having a new security to put FT and report original cost price -->
         <xsl:variable name="idxFirstOptDescGroupWithSecu" select="b:optionDescGroup[b:optionNom][b:newSecuritySubGroup]/@index"/><!-- select optionDescGroup -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="idxFirstOptDescGroupWithSecu" select="$idxFirstOptDescGroupWithSecu"/>
         </xsl:apply-templates>
      </GenericCOA>
   </xsl:template><!-- Template handling elected optionDescGroup -->
   <xsl:template match="b:optionDescGroup[b:optionNom != 0]">
      <xsl:param name="idxFirstOptDescGroupWithSecu"/><!-- variables for evaluating the different cases --><!--   exchange against another security -->
      <xsl:variable name="ConversionIntoSecurityCriteria">
         <xsl:call-template name="conversionIntoSecurityCriteria"/>
      </xsl:variable><!--   sell -->
      <xsl:variable name="ConversionSellCriteria">
         <xsl:call-template name="conversionSellCriteria"/>
      </xsl:variable><!--   lapse -->
      <xsl:variable name="ConversionLapseCriteria">
         <xsl:call-template name="conversionLapseCriteria"/>
      </xsl:variable><!--   oversubscribe -->
      <xsl:variable name="ConversionOversubscribeCriteria">
         <xsl:call-template name="conversionOversubscribeCriteria"/>
      </xsl:variable><!--   no action -->
      <xsl:variable name="ConversionNoActionCriteria">
         <xsl:call-template name="conversionNoActionCriteria"/>
      </xsl:variable><!--   custo, if other action is needed -->
      <xsl:variable name="ConversionCustoCriteria">
         <xsl:call-template name="conversionCustoCriteria"/>
      </xsl:variable>
      <xsl:choose><!-- Conversion into new securities -->
         <xsl:when test="$ConversionIntoSecurityCriteria = 'true'"><!-- Buy new securities -->
            <xsl:apply-templates select="b:newSecuritySubGroup">
               <xsl:with-param name="idxFirstOptDescGroupWithSecu" select="$idxFirstOptDescGroupWithSecu"/>
            </xsl:apply-templates><!-- Transfer cost price of old securities -->
            <xsl:call-template name="exchangeOriginalSecu"/>
         </xsl:when><!-- Sell the originalSecurity -->
         <xsl:when test="$ConversionSellCriteria = 'true'">
            <xsl:call-template name="sellOriginalSecu"/>
         </xsl:when><!-- Lapse -->
         <xsl:when test="$ConversionLapseCriteria = 'true'">
            <xsl:call-template name="lapseOriginalSecu"/>
         </xsl:when><!-- Over subscribe -->
         <xsl:when test="$ConversionOversubscribeCriteria = 'true'">
            <xsl:call-template name="overSubscribe"/>
         </xsl:when><!-- No action -->
         <xsl:when test="$ConversionNoActionCriteria = 'true'">
            <xsl:call-template name="ConversionNoAction"/>
         </xsl:when><!-- Custo -->
         <xsl:when test="$ConversionCustoCriteria = 'true'">
            <xsl:call-template name="ConversionCusto"/>
         </xsl:when><!-- Otherwise -->
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template><!-- end of templage optionDescGroup --><!-- default template for unselected optionDescGroup -->
   <xsl:template match="b:optionDescGroup">
      <xsl:param name="idxFirstOptDescGroupWithSecu"/>
   </xsl:template><!-- end of default on unselected optionDescGroup --><!-- Original secu are exchanged against new securities; first buy new secu, then exchange the original secu -->
   <xsl:template match="b:newSecuritySubGroup">
      <xsl:param name="idxFirstOptDescGroupWithSecu"/><!-- Creation of a buy -->
      <DataGroup>
         <Buy>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionConversion.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
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
			<xsl:call-template name="tradeCcy"/>
            <xsl:call-template name="tradeCcyGrossAmount"/>
            <xsl:call-template name="tradeCcyNetAmount"/>
            <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
            <xsl:call-template name="tradeCurrency"/>
			<xsl:call-template name="tradeExchangeRate"/>
            <xsl:call-template name="tradePrice"/>
            <xsl:call-template name="tradeQuantity"/>
            <xsl:call-template name="transactionCode"/>
            <xsl:call-template name="transactionDate"/>
            <xsl:call-template name="transactionFeesTaxesCounter">
				<xsl:with-param name="idxFirstOptDescGroupWithSecu" select="$idxFirstOptDescGroupWithSecu"/>
			</xsl:call-template>
            <xsl:call-template name="type"/>
            <xsl:call-template name="typeInstrument"/>
            <xsl:call-template name="valueDate"/>
            <xsl:call-template name="userDefinedField"/>
            <xsl:call-template name="mbFields"/>
         </Buy>
      </DataGroup>
   </xsl:template><!-- End of template for buy shares and exchange original security --><!-- template to exchange old securities -->
   <xsl:template name="exchangeOriginalSecu"><!-- Print record -->
      <DataGroup>
         <Adjustment>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionConversion.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="account1_Adj"/>
            <xsl:call-template name="account1CcyoldSecCcyExchangeRate_Adj"/>
            <xsl:call-template name="account1NetAmount_Adj"/>
            <xsl:call-template name="account2_Adj"/>
            <xsl:call-template name="account2CcyoldSecCcyExchangeRate_Adj"/>
            <xsl:call-template name="account2NetAmount_Adj"/>
            <xsl:call-template name="account3_Adj"/>
            <xsl:call-template name="account3CcyoldSecCcyExchangeRate_Adj"/>
            <xsl:call-template name="account3NetAmount_Adj"/>
            <xsl:call-template name="accountingCode_Adj"/>
            <xsl:call-template name="accountingDate_Adj"/>
            <xsl:call-template name="accruedInterestAmount_Adj"/>
            <xsl:call-template name="accruedInterestCounter_Adj"/>
            <xsl:call-template name="adjustmentCounter_Adj"/>
            <xsl:call-template name="adjustmentNature_Adj"/>
            <xsl:call-template name="adjustmentPortfolio_Adj"/>
            <xsl:call-template name="cashPortfolio_Adj"/>
            <xsl:call-template name="coaReference_Adj"/>
			<xsl:call-template name="commonReference_Adj"/>
            <xsl:call-template name="communication_Adj"/>
			<xsl:call-template name="exDate_Adj"/>
            <xsl:call-template name="initiator_Adj"/>
            <xsl:call-template name="newQuantity_Adj"/>
            <xsl:call-template name="newSecurity_Adj"/>
            <xsl:call-template name="newSecurityCcyPositionCcyExchangeRate_Adj"/>
            <xsl:call-template name="newSecurityDepositaryAccount_Adj"/>
            <xsl:call-template name="newSecurityNetAmount_Adj"/>
            <xsl:call-template name="newSecurityPositionCriteria1_Adj"/>
            <xsl:call-template name="newSecurityPositionCriteria2_Adj"/>
            <xsl:call-template name="newSecurityPositionCriteria3_Adj"/>
            <xsl:call-template name="newSecurityPositionCurrency_Adj"/>
            <xsl:call-template name="notepad_Adj"/>
            <xsl:call-template name="oldCcyGrossAmount_Adj"/>
            <xsl:call-template name="oldCcyNetAmount_Adj"/>
            <xsl:call-template name="oldCcyPortfolioCcyExchangeRate_Adj"/>
            <xsl:call-template name="oldPrice_Adj"/>
            <xsl:call-template name="oldQuantity_Adj"/>
            <xsl:call-template name="oldSecurity_Adj"/>
            <xsl:call-template name="oldSecurityDepositaryAccount_Adj"/>
            <xsl:call-template name="oldSecurityPositionCriteria1_Adj"/>
            <xsl:call-template name="oldSecurityPositionCriteria2_Adj"/>
            <xsl:call-template name="oldSecurityPositionCriteria3_Adj"/>
            <xsl:call-template name="oldSecurityPositionCurrency_Adj"/>
            <xsl:call-template name="portfolio_Adj"/>
            <xsl:call-template name="portfolioManager_Adj"/>
            <xsl:call-template name="remark_Adj"/>
            <xsl:call-template name="reversalIndicator_Adj"/>
            <xsl:call-template name="reversedTransactionCode_Adj"/>
            <xsl:call-template name="sourceSystemCode_Adj"/>
			<xsl:call-template name="splitPortfolio_Adj"/>
            <xsl:call-template name="status_Adj"/>
            <xsl:call-template name="subType_Adj"/>
            <xsl:call-template name="supplementaryAmount_Adj"/>
            <xsl:call-template name="transactionCode_Adj"/>
            <xsl:call-template name="transactionDate_Adj"/>
            <xsl:call-template name="transactionFeesTaxesCounter_Adj"/>
            <xsl:call-template name="type_Adj"/>
            <xsl:call-template name="typeInstrument_Adj"/>
            <xsl:call-template name="valueDate_Adj"/>
            <xsl:call-template name="userDefinedField_Adj"/>
            <xsl:call-template name="mbFields_Adj"/>
         </Adjustment>
      </DataGroup>
   </xsl:template><!-- End of exchangeOriginalSecu --><!-- template to sell original securities -->
   <xsl:template name="sellOriginalSecu"><!-- Print record -->
      <DataGroup>
         <Sell>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionConversion.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="account1_Sell"/>
            <xsl:call-template name="account1CcyTradeCcyExchangeRate_Sell"/>
            <xsl:call-template name="account1NetAmount_Sell"/>
            <xsl:call-template name="account2_Sell"/>
            <xsl:call-template name="account2CcyTradeCcyExchangeRate_Sell"/>
            <xsl:call-template name="account2NetAmount_Sell"/>
            <xsl:call-template name="account3_Sell"/>
            <xsl:call-template name="account3CcyTradeCcyExchangeRate_Sell"/>
            <xsl:call-template name="account3NetAmount_Sell"/>
            <xsl:call-template name="accountingCode_Sell"/>
            <xsl:call-template name="accountingDate_Sell"/>
            <xsl:call-template name="accruedInterestAmount_Sell"/>
            <xsl:call-template name="accruedInterestCounter_Sell"/>
            <xsl:call-template name="cashPortfolio_Sell"/>
            <xsl:call-template name="coaReference_Sell"/>
			<xsl:call-template name="commonReference_Sell"/>
            <xsl:call-template name="communication_Sell"/>
            <xsl:call-template name="depositaryAccount_Sell"/>
			<xsl:call-template name="exDate_Sell"/>
            <xsl:call-template name="initiator_Sell"/>
            <xsl:call-template name="notepad_Sell"/>
            <xsl:call-template name="portfolio_Sell"/>
            <xsl:call-template name="portfolioManager_Sell"/>
            <xsl:call-template name="positionCriteria1_Sell"/>
            <xsl:call-template name="positionCriteria2_Sell"/>
            <xsl:call-template name="positionCriteria3_Sell"/>
            <xsl:call-template name="remark_Sell"/>
            <xsl:call-template name="reversalIndicator_Sell"/>
            <xsl:call-template name="reversedTransactionCode_Sell"/>
            <xsl:call-template name="security_Sell"/>
            <xsl:call-template name="securityCcyNetAmount_Sell"/>
            <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Sell"/>
            <xsl:call-template name="sourceSystemCode_Sell"/>
			<xsl:call-template name="splitPortfolio_Sell"/>
            <xsl:call-template name="status_Sell"/>
            <xsl:call-template name="subType_Sell"/>
            <xsl:call-template name="supplementaryAmount_Sell"/>
            <xsl:call-template name="tradeCcyGrossAmount_Sell"/>
            <xsl:call-template name="tradeCcyNetAmount_Sell"/>
            <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
            <xsl:call-template name="tradeCurrency_Sell"/>
            <xsl:call-template name="tradePrice_Sell"/>
            <xsl:call-template name="tradeQuantity_Sell"/>
            <xsl:call-template name="transactionCode_Sell"/>
            <xsl:call-template name="transactionDate_Sell"/>
            <xsl:call-template name="transactionFeesTaxesCounter_Sell"/>
            <xsl:call-template name="type_Sell"/>
            <xsl:call-template name="typeInstrument_Sell"/>
            <xsl:call-template name="valueDate_Sell"/>
            <xsl:call-template name="userDefinedField_Sell"/>
            <xsl:call-template name="mbFields_Sell"/>
         </Sell>
      </DataGroup>
   </xsl:template><!-- end of sellOriginalSecu template --><!-- template to remove original securities -->
   <xsl:template name="lapseOriginalSecu"><!-- Creation of a negative investment -->
      <DataGroup>
         <Investment>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionConversion.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
   </xsl:template><!-- end of lapseOriginalSecu template --><!-- template to oversubscribe -->
   <xsl:template name="overSubscribe"><!-- Creation of a buy -->
      <DataGroup>
         <Buy>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionConversion.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="account1_Buy"/>
            <xsl:call-template name="account1CcyTradeCcyExchangeRate_Buy"/>
            <xsl:call-template name="account1NetAmount_Buy"/>
            <xsl:call-template name="account2_Buy"/>
            <xsl:call-template name="account2CcyTradeCcyExchangeRate_Buy"/>
            <xsl:call-template name="account2NetAmount_Buy"/>
            <xsl:call-template name="account3_Buy"/>
            <xsl:call-template name="account3CcyTradeCcyExchangeRate_Buy"/>
            <xsl:call-template name="account3NetAmount_Buy"/>
            <xsl:call-template name="accountingCode_Buy"/>
            <xsl:call-template name="accountingDate_Buy"/>
            <xsl:call-template name="accruedInterestAmount_Buy"/>
            <xsl:call-template name="accruedInterestCounter_Buy"/>
            <xsl:call-template name="cashPortfolio_Buy"/>
            <xsl:call-template name="coaReference_Buy"/>
            <xsl:call-template name="communication_Buy"/>
            <xsl:call-template name="depositaryAccount_Buy"/>
			<xsl:call-template name="exDate_Buy"/>
            <xsl:call-template name="initiator_Buy"/>
            <xsl:call-template name="notepad_Buy"/>
            <xsl:call-template name="portfolio_Buy"/>
            <xsl:call-template name="portfolioManager_Buy"/>
            <xsl:call-template name="positionCriteria1_Buy"/>
            <xsl:call-template name="positionCriteria2_Buy"/>
            <xsl:call-template name="positionCriteria3_Buy"/>
            <xsl:call-template name="remark_Buy"/>
            <xsl:call-template name="reversalIndicator_Buy"/>
            <xsl:call-template name="reversedTransactionCode_Buy"/>
            <xsl:call-template name="security_Buy"/>
            <xsl:call-template name="securityCcyNetAmount_Buy"/>
            <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Buy"/>
            <xsl:call-template name="sourceSystemCode_Buy"/>
			<xsl:call-template name="splitPortfolio_Buy"/>
            <xsl:call-template name="status_Buy"/>
            <xsl:call-template name="subType_Buy"/>
            <xsl:call-template name="supplementaryAmount_Buy"/>
            <xsl:call-template name="tradeCcyGrossAmount_Buy"/>
            <xsl:call-template name="tradeCcyNetAmount_Buy"/>
            <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Buy"/>
            <xsl:call-template name="tradeCurrency_Buy"/>
            <xsl:call-template name="tradePrice_Buy"/>
            <xsl:call-template name="tradeQuantity_Buy"/>
            <xsl:call-template name="transactionCode_Buy"/>
            <xsl:call-template name="transactionDate_Buy"/>
            <xsl:call-template name="transactionFeesTaxesCounter_Buy"/>
            <xsl:call-template name="type_Buy"/>
            <xsl:call-template name="typeInstrument_Buy"/>
            <xsl:call-template name="valueDate_Buy"/>
            <xsl:call-template name="userDefinedField_Buy"/>
            <xsl:call-template name="mbFields_Buy"/>
         </Buy>
      </DataGroup>
   </xsl:template><!-- end of overSubscribe template --><!-- template to noAction -->
   <xsl:template name="ConversionNoAction"/><!-- end of noAction template --><!-- template to Custo -->
   <xsl:template name="ConversionCusto"/><!-- end of Custo template -->
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