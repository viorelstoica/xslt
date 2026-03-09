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
            <xsl:value-of select="concat('CoaMerger',b:diaryId)"/>
         </xsl:attribute><!-- Status -->
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable><!-- Count the number of new securities, if only cash, the old position must be sold -->
         <xsl:variable name="nbNewSecGroupsWithNominal" select="count(descendant::b:optionDescGroup/b:newSecuritySubGroup[b:nominal])"/><!-- Entitlement options (cash or security) are in nodes 'entitlementAmtGroup' -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="nbNewSecGroupsWithNominal" select="$nbNewSecGroupsWithNominal"/>
            <xsl:with-param name="opStatus" select="$opStatus"/>
         </xsl:apply-templates>
      </CorporateActionPMS>
   </xsl:template><!-- EntitlementAmtGroup -->
   <xsl:template match="b:optionDescGroup">
      <xsl:param name="nbNewSecGroupsWithNominal"/><!-- indicates there are new securities -->
      <xsl:param name="opStatus"/><!-- transaction status -->
      <xsl:choose><!-- Cash only, doing a sell -->
         <xsl:when test="$nbNewSecGroupsWithNominal = 0"><!-- no new securities -->
            <xsl:if test="b:entitlementAmt != 0 ">
               <DataGroup>
                  <OddLotSale>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionMerger.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <xsl:call-template name="account1_OddLotSale"/>
                     <xsl:call-template name="account1CcysaleCcyExchangeRate_OddLotSale"/>
                     <xsl:call-template name="account1NetAmount_OddLotSale"/>
                     <xsl:call-template name="account2_OddLotSale"/>
                     <xsl:call-template name="account2CcysaleCcyExchangeRate_OddLotSale"/>
                     <xsl:call-template name="account2NetAmount_OddLotSale"/>
                     <xsl:call-template name="account3_OddLotSale"/>
                     <xsl:call-template name="account3CcysaleCcyExchangeRate_OddLotSale"/>
                     <xsl:call-template name="account3NetAmount_OddLotSale"/>
                     <xsl:call-template name="accountingCode_OddLotSale"/>
                     <xsl:call-template name="accountingDate_OddLotSale"/>
                     <xsl:call-template name="accruedInterestCounter_OddLotSale"/>
                     <xsl:call-template name="accruedInterests_OddLotSale"/>
                     <xsl:call-template name="cashPortfolio_OddLotSale"/>
                     <xsl:call-template name="coaReference_OddLotSale"/>
					 <xsl:call-template name="commonReference_OddLotSale"/>
                     <xsl:call-template name="contractNumber_OddLotSale"/>
                     <xsl:call-template name="depositaryAccount_OddLotSale"/>
                     <xsl:call-template name="initiator_OddLotSale"/>
                     <xsl:call-template name="notepad_OddLotSale"/>
                     <xsl:call-template name="portfolio_OddLotSale"/>
                     <xsl:call-template name="portfolioManager_OddLotSale"/>
                     <xsl:call-template name="remark_OddLotSale"/>
                     <xsl:call-template name="reversalIndicator_OddLotSale"/>
                     <xsl:call-template name="reversedTransactionCode_OddLotSale"/>
                     <xsl:call-template name="saleCcyGrossAmount_OddLotSale"/>
                     <xsl:call-template name="saleCcyNetAmount_OddLotSale"/>
                     <xsl:call-template name="saleCcyPortfolioCcyExchangeRate_OddLotSale"/>
                     <xsl:call-template name="saleCurrency_OddLotSale"/>
                     <xsl:call-template name="salePrice_OddLotSale"/>
                     <xsl:call-template name="security_OddLotSale"/>
                     <xsl:call-template name="securityCcyNetAmount_OddLotSale"/>
                     <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_OddLotSale"/>
                     <xsl:call-template name="sourceSystemCode_OddLotSale"/>
                     <xsl:call-template name="status_OddLotSale"/>
                     <xsl:call-template name="subType_OddLotSale"/>
                     <xsl:call-template name="positionCriteria1_OddLotSale"/>
                     <xsl:call-template name="positionCriteria2_OddLotSale"/>
                     <xsl:call-template name="positionCriteria3_OddLotSale"/>
                     <xsl:call-template name="transactionCode_OddLotSale"/>
                     <xsl:call-template name="saleDate_OddLotSale"/>
                     <xsl:call-template name="transactionFeesTaxesCounter_OddLotSale"/>
                     <xsl:call-template name="type_OddLotSale"/>
                     <xsl:call-template name="typeInstrument_OddLotSale"/>
                     <xsl:call-template name="valueDate_OddLotSale"/>
                     <xsl:call-template name="userDefinedField_OddLotSale"/>
                     <xsl:call-template name="mbFields_OddLotSale"/>
                     <xsl:call-template name="oddLotQuantity_OddLotSale"/>
					 <xsl:call-template name="exDate_OddLotSale"/>
					 <xsl:call-template name="splitPortfolio_OddLotSale"/>
                  </OddLotSale>
               </DataGroup>
            </xsl:if>
         </xsl:when><!-- End of Sell part --><!-- Cash and securities -->
         <xsl:otherwise><!-- 2 steps: 1 with the cash, 1 for all newSecuritySubGroup --><!-- Generate cash part, if any cash  -->
            <xsl:if test="b:entitlementAmt != 0">
               <DataGroup>
                  <Merger>
                     <Cash>
                        <Link>
                           <xsl:attribute name="description">
                              <xsl:value-of select="concat('TransactionMerger.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                           </xsl:attribute>
                           <xsl:attribute name="sequenceNumber">
                              <xsl:call-template name="calcSeqNum">
                                 <xsl:with-param name="creationTime">
                                    <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:attribute>
                           <xsl:call-template name="account1"/>
                           <xsl:call-template name="account1CcyPositionCcyExchangeRate"/>
                           <xsl:call-template name="account1NetAmount"/>
                           <xsl:call-template name="account2"/>
                           <xsl:call-template name="account2CcyPositionCcyExchangeRate"/>
                           <xsl:call-template name="account2NetAmount"/>
                           <xsl:call-template name="account3"/>
                           <xsl:call-template name="account3CcyPositionCcyExchangeRate"/>
                           <xsl:call-template name="account3NetAmount"/>
                           <xsl:call-template name="accountingCode"/>
                           <xsl:call-template name="accountingDate"/>
                           <xsl:call-template name="cashPortfolio"/>
						   <xsl:call-template name="commonReference"/>
                           <xsl:call-template name="contractNumber"/>
                           <xsl:call-template name="notepad"/>
                           <xsl:call-template name="portfolio"/>
                           <xsl:call-template name="portfolioManager"/>
                           <xsl:call-template name="remark"/>
                           <xsl:call-template name="reversalIndicator"/>
                           <xsl:call-template name="reversedTransactionCode"/>
                           <xsl:call-template name="sourceSystemCode"/>
                           <xsl:call-template name="status"/>
                           <xsl:call-template name="subType"/>
                           <xsl:call-template name="transactionCode"/>
                           <xsl:call-template name="transactionFeesTaxesCounter"/>
                           <xsl:call-template name="type"/>
                           <xsl:call-template name="typeInstrument"/>
                           <xsl:call-template name="valueDate"/>
                           <xsl:call-template name="userDefinedField"/>
                           <xsl:call-template name="mbFields"/>
                           <xsl:call-template name="coaReference"/>
                           <xsl:call-template name="initiator"/>
                           <xsl:call-template name="originalSecurityDepositaryAccount"/>
                           <xsl:call-template name="originalSecurity"/>
                           <xsl:call-template name="originalSecurityPositionCriteria1"/>
                           <xsl:call-template name="originalSecurityPositionCriteria2"/>
                           <xsl:call-template name="originalSecurityPositionCriteria3"/>
                           <xsl:call-template name="originalSecurityPositionCurrency"/>
                           <xsl:call-template name="positionCriteria1"/>
                           <xsl:call-template name="positionCriteria2"/>
                           <xsl:call-template name="positionCriteria3"/>
                           <xsl:call-template name="positionCurrency"/>
                           <xsl:call-template name="profitLossCounter"/>
                           <xsl:call-template name="transactionDate"/>
                           <xsl:call-template name="cashAmount"/>
                           <xsl:call-template name="currentAccount"/>
                        </Link>
                     </Cash>
                  </Merger>
               </DataGroup>
            </xsl:if><!-- Generate the security parts -->
            <xsl:apply-templates select="b:newSecuritySubGroup">
               <xsl:with-param name="opStatus" select="$opStatus"/>
            </xsl:apply-templates>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template><!-- End of template for entitlementAmtGroup Cash Link --><!-- Template for Old Sec Link --><!-- Removing old position and creating new one by adjustment PL -->
   <xsl:template match="b:newSecuritySubGroup">
      <xsl:param name="opStatus"/><!-- transaction status --><!-- Print record -->
      <DataGroup>
         <Merger>
            <OldSecurity>
               <Link>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionMerger.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="account1_OldSecurity"/>
                  <xsl:call-template name="account1CcyPositionCcyExchangeRate_OldSecurity"/>
                  <xsl:call-template name="account1NetAmount_OldSecurity"/>
                  <xsl:call-template name="account2_OldSecurity"/>
                  <xsl:call-template name="account2CcyPositionCcyExchangeRate_OldSecurity"/>
                  <xsl:call-template name="account2NetAmount_OldSecurity"/>
                  <xsl:call-template name="account3_OldSecurity"/>
                  <xsl:call-template name="account3CcyPositionCcyExchangeRate_OldSecurity"/>
                  <xsl:call-template name="account3NetAmount_OldSecurity"/>
                  <xsl:call-template name="accountingCode_OldSecurity"/>
                  <xsl:call-template name="accountingDate_OldSecurity"/>
                  <xsl:call-template name="cashPortfolio_OldSecurity"/>
				  <xsl:call-template name="commonReference_OldSecurity"/>
                  <xsl:call-template name="contractNumber_OldSecurity"/>
                  <xsl:call-template name="notepad_OldSecurity"/>
                  <xsl:call-template name="portfolio_OldSecurity"/>
                  <xsl:call-template name="portfolioManager_OldSecurity"/>
                  <xsl:call-template name="remark_OldSecurity"/>
                  <xsl:call-template name="reversalIndicator_OldSecurity"/>
                  <xsl:call-template name="reversedTransactionCode_OldSecurity"/>
                  <xsl:call-template name="sourceSystemCode_OldSecurity"/>
                  <xsl:call-template name="status_OldSecurity"/>
                  <xsl:call-template name="subType_OldSecurity"/>
                  <xsl:call-template name="transactionCode_OldSecurity"/>
                  <xsl:call-template name="transactionFeesTaxesCounter_OldSecurity"/>
                  <xsl:call-template name="type_OldSecurity"/>
                  <xsl:call-template name="typeInstrument_OldSecurity"/>
                  <xsl:call-template name="valueDate_OldSecurity"/>
                  <xsl:call-template name="userDefinedField_OldSecurity"/>
                  <xsl:call-template name="mbFields_OldSecurity"/>
                  <xsl:call-template name="coaReference_OldSecurity"/>
				  <xsl:call-template name="exDate_OldSecurity"/>
                  <xsl:call-template name="initiator_OldSecurity"/>
                  <xsl:call-template name="newQuantity_OldSecurity"/>
                  <xsl:call-template name="newSecurity_OldSecurity"/>
                  <xsl:call-template name="newSecurityDepositaryAccount_OldSecurity"/>
                  <xsl:call-template name="newSecurityPositionCriteria1_OldSecurity"/>
                  <xsl:call-template name="newSecurityPositionCriteria2_OldSecurity"/>
                  <xsl:call-template name="newSecurityPositionCriteria3_OldSecurity"/>
                  <xsl:call-template name="newSecurityPositionCurrency_OldSecurity"/>
                  <xsl:call-template name="oldQuantity_OldSecurity"/>
                  <xsl:call-template name="oldSecurity_OldSecurity"/>
                  <xsl:call-template name="oldSecurityDepositaryAccount_OldSecurity"/>
                  <xsl:call-template name="oldSecurityPositionCriteria1_OldSecurity"/>
                  <xsl:call-template name="oldSecurityPositionCriteria2_OldSecurity"/>
                  <xsl:call-template name="oldSecurityPositionCriteria3_OldSecurity"/>
                  <xsl:call-template name="oldSecuritypositionCurrency_OldSecurity"/>
				  <xsl:call-template name="splitPortfolio_OldSecurity"/>
                  <xsl:call-template name="transactionDate_OldSecurity"/>
                  <xsl:call-template name="unitaryCostPrice_OldSecurity"/>
				  
               </Link>
            </OldSecurity>
         </Merger>
      </DataGroup>
   </xsl:template><!-- End of template for Old Sec Link -->
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