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
            <xsl:value-of select="concat('TransactionWarrantExercise',b:diaryId)"/>
         </xsl:attribute><!-- Count the number of new securities, if only cash, the old position must be sold -->
         <xsl:variable name="nbOptionGroup" select="count(descendant::b:optionDescGroup[b:optionNom != 0][b:newSecuritySubGroup/b:newSecurity != ../b:securityNo])"/>
         <xsl:variable name="nbNewSecuSubGroup" select="count(descendant::b:optionDescGroup[b:optionNom != 0]/b:newSecuritySubGroup[b:newSecurity != ../../b:securityNo])"/>
		 <xsl:variable name="sumEntitlementAmt" select="format-number(sum(child::b:optionDescGroup[b:optionNom]/b:entitlementAmt),$decimalformat,'nan2zero')"/>
		 <xsl:variable name="sumOptionNom" select="format-number(sum(child::b:optionDescGroup[b:entitlementAmt != 0]/b:optionNom),$decimalformat,'nan2zero')"/>
		 <!-- call template for selected optionDescGroup -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="nbOptionGroup" select="$nbOptionGroup"/>
            <xsl:with-param name="nbNewSecurities" select="$nbNewSecuSubGroup"/>
			<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
			<xsl:with-param name="sumOptionNom" select="$sumOptionNom"/>
         </xsl:apply-templates>
      </GenericCOA>
   </xsl:template>
   <xsl:template match="b:optionDescGroup[b:optionNom != 0]">
      <xsl:param name="nbOptionGroup"/>
      <xsl:param name="nbNewSecurities"/>
	  <xsl:param name="sumEntitlementAmt"/>
	  <xsl:param name="sumOptionNom"/>
	  <!-- variables for evaluating the different cases -->
      <xsl:variable name="WarrantExerciseExchangeAgainstSecurityCriteria">
         <xsl:call-template name="warrantExerciseExchangeAgainstSecurityCriteria"/>
      </xsl:variable>
      <xsl:variable name="WarrantExerciseSellCriteria">
         <xsl:call-template name="warrantExerciseSellCriteria"/>
      </xsl:variable>
      <xsl:variable name="WarrantExerciseLapseCriteria">
         <xsl:call-template name="warrantExerciseLapseCriteria"/>
      </xsl:variable>
      <xsl:variable name="WarrantExerciseDoNothingCriteria">
         <xsl:call-template name="warrantExerciseDoNothingCriteria"/>
      </xsl:variable>
      <xsl:variable name="WarrantExerciseCusto1Criteria">
         <xsl:call-template name="warrantExerciseCusto1Criteria"/>
      </xsl:variable><!-- Choose the action -->
      <xsl:choose><!-- exchange the warrants -->
         <xsl:when test="$WarrantExerciseExchangeAgainstSecurityCriteria = 'true'"><!-- 1. Buy all the new securities --><!-- 2. Exchange the warrants -->
            <xsl:apply-templates select="b:newSecuritySubGroup">
               <xsl:with-param name="nbOptionGroup" select="$nbOptionGroup"/>
			   <xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
			   <xsl:with-param name="nbNewSecurities" select="$nbNewSecurities"/>
			   <xsl:with-param name="sumOptionNom" select="$sumOptionNom"/>
            </xsl:apply-templates>
         </xsl:when><!-- sell the warrants -->
         <xsl:when test="$WarrantExerciseSellCriteria = 'true'">
            <xsl:call-template name="sellWarrants">
               <xsl:with-param name="nbNewSecurities" select="$nbNewSecurities"/>
            </xsl:call-template>
         </xsl:when><!-- lapse -->
         <xsl:when test="$WarrantExerciseLapseCriteria = 'true'">
            <xsl:call-template name="lapseWarrants"/>
         </xsl:when><!-- do nothing -->
         <xsl:when test="$WarrantExerciseDoNothingCriteria = 'true'">
            <xsl:call-template name="doNothingWarrants"/>
         </xsl:when><!--   custo, if other action is needed -->
         <xsl:when test="$WarrantExerciseCusto1Criteria = 'true'">
            <xsl:call-template name="custo1Warrants"/>
         </xsl:when><!--   otherwise -->
         <xsl:otherwise>
            <DataGroup/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template><!-- Buy new securities -->
   <xsl:template match="b:newSecuritySubGroup">
      <xsl:param name="nbOptionGroup"/>
	  <xsl:param name="sumEntitlementAmt"/>
	  <xsl:param name="nbNewSecurities"/>
	  <xsl:param name="sumOptionNom"/>
	  <!-- Creation of a buy -->
      <DataGroup>
         <Buy>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionWarrantExercise.xsl+', name(../../*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
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
            <xsl:call-template name="account1NetAmount">
               <xsl:with-param name="nbNewSecurities" select="$nbNewSecurities"/>
			   <xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
            </xsl:call-template>
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
            <xsl:call-template name="transactionFeesTaxesCounter">
				<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
				<xsl:with-param name="nbNewSecurities" select="$nbNewSecurities"/>
			</xsl:call-template>
            <xsl:call-template name="type"/>
            <xsl:call-template name="typeInstrument"/>
            <xsl:call-template name="valueDate"/>
            <xsl:call-template name="userDefinedField"/>
            <xsl:call-template name="mbFields"/>
         </Buy>
      </DataGroup>
	  <!-- End of template for buy new shares -->
	
      <!-- template to exchange the original security -->
	  <DataGroup>
         <Adjustment>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionWarrantExercise.xsl+', name(../../*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
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
            <xsl:call-template name="oldQuantity_Adj">
		    	<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
				<xsl:with-param name="sumOptionNom" select="$sumOptionNom"/>
			</xsl:call-template>
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
	  <!-- end of template to exchange the original security -->
   </xsl:template>
   <!-- template to sell warrants -->
   <xsl:template name="sellWarrants">
      <xsl:param name="nbNewSecurities"/>
      <DataGroup>
         <Sell>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionWarrantExercise.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
            <xsl:call-template name="account1NetAmount_Sell">
               <xsl:with-param name="nbNewSecurities" select="$nbNewSecurities"/>
            </xsl:call-template>
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
   </xsl:template><!-- end of sellWarrants template --><!-- template to withdraw the warrants -->
   <xsl:template name="lapseWarrants">
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
            <xsl:call-template name="account1_Lapse"/>
            <xsl:call-template name="account1CcyTradeCcyExchangeRate_Lapse"/>
            <xsl:call-template name="account1NetAmount_Lapse"/>
            <xsl:call-template name="account2_Lapse"/>
            <xsl:call-template name="account2CcyTradeCcyExchangeRate_Lapse"/>
            <xsl:call-template name="account2NetAmount_Lapse"/>
            <xsl:call-template name="account3_Lapse"/>
            <xsl:call-template name="account3CcyTradeCcyExchangeRate_Lapse"/>
            <xsl:call-template name="account3NetAmount_Lapse"/>
            <xsl:call-template name="accountingCode_Lapse"/>
            <xsl:call-template name="accountingDate_Lapse"/>
            <xsl:call-template name="accruedInterestAmount_Lapse"/>
            <xsl:call-template name="accruedInterestCounter_Lapse"/>
            <xsl:call-template name="cashPortfolio_Lapse"/>
            <xsl:call-template name="coaReference_Lapse"/>
		    <xsl:call-template name="commonReference_Lapse"/>
            <xsl:call-template name="communication_Lapse"/>
            <xsl:call-template name="depositaryAccount_Lapse"/>
			<xsl:call-template name="exDate_Lapse"/>
            <xsl:call-template name="initiator_Lapse"/>
            <xsl:call-template name="notepad_Lapse"/>
            <xsl:call-template name="portfolio_Lapse"/>
            <xsl:call-template name="portfolioManager_Lapse"/>
            <xsl:call-template name="positionCriteria1_Lapse"/>
            <xsl:call-template name="positionCriteria2_Lapse"/>
            <xsl:call-template name="positionCriteria3_Lapse"/>
            <xsl:call-template name="remark_Lapse"/>
            <xsl:call-template name="reversalIndicator_Lapse"/>
            <xsl:call-template name="reversedTransactionCode_Lapse"/>
            <xsl:call-template name="security_Lapse"/>
            <xsl:call-template name="sourceSystemCode_Lapse"/>
			<xsl:call-template name="splitPortfolio_Lapse"/>
            <xsl:call-template name="status_Lapse"/>
            <xsl:call-template name="subType_Lapse"/>
            <xsl:call-template name="supplementaryAmount_Lapse"/>
            <xsl:call-template name="tradeCcyGrossAmount_Lapse"/>
            <xsl:call-template name="tradeCcyNetAmount_Lapse"/>
            <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Lapse"/>
            <xsl:call-template name="tradeCurrency_Lapse"/>
            <xsl:call-template name="tradePrice_Lapse"/>
            <xsl:call-template name="tradeQuantity_Lapse"/>
            <xsl:call-template name="transactionCode_Lapse"/>
            <xsl:call-template name="transactionDate_Lapse"/>
            <xsl:call-template name="transactionFeesTaxesCounter_Lapse"/>
            <xsl:call-template name="type_Lapse"/>
            <xsl:call-template name="typeInstrument_Lapse"/>
            <xsl:call-template name="valueDate_Lapse"/>
            <xsl:call-template name="userDefinedField_Lapse"/>
            <xsl:call-template name="mbFields_Lapse"/>
         </Investment>
      </DataGroup>
   </xsl:template><!-- template to do nothing warrants -->
   <xsl:template name="doNothingWarrants">
      <DataGroup/>
   </xsl:template><!-- template for custo1. Allow full customisation by the customer (not linked to any transaction nature) -->
   <xsl:template name="custo1Warrants">
      <DataGroup/>
   </xsl:template><!-- Default template for optionDescGroup -->
   <xsl:template match="b:optionDescGroup"/>
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