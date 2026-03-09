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
            <xsl:value-of select="concat('TransactionRightsDistributionGenericCOA',b:diaryId)"/>
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
      
	     <!--<xsl:when test="../b:upfrontPaymentDiaryJoin = 'Y' and ../b:optStatus = 'PAID' and ../b:netAmtAccCur != 0 and b:entitlementAmt = 0">-->
		 <xsl:if test="b:entitlementAmt and number(b:entitlementAmt) != '0' and ../b:upfrontPaymentDiaryJoin = 'YES' and ../b:optStatus = 'PAID' and ../b:netAmtAccCur != 0">
		    <DataGroup>
		      <Withdrawal>
				<xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionRightsDistributionGenericCOA.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>

                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="account1_Wd"/>
                  <xsl:call-template name="account1CcyTradeCcyExchangeRate_Wd"/>
                  <xsl:call-template name="account1NetAmount_Wd"/>
                  <xsl:call-template name="account2_Wd"/>
                  <xsl:call-template name="account2CcyTradeCcyExchangeRate_Wd"/>
                  <xsl:call-template name="account2NetAmount_Wd"/>
                  <xsl:call-template name="account3_Wd"/>
                  <xsl:call-template name="account3CcyTradeCcyExchangeRate_Wd"/>
                  <xsl:call-template name="account3NetAmount_Wd"/>
                  <xsl:call-template name="accountingCode_Wd"/>
                  <xsl:call-template name="accountingDate_Wd"/>
                  <xsl:call-template name="accruedInterestAmount_Wd"/>
                  <xsl:call-template name="accruedInterestCounter_Wd"/>
                  <xsl:call-template name="cashPortfolio_Wd"/>
                  <xsl:call-template name="coaReference_Wd"/>
				  <xsl:call-template name="commonReference_Wd"/>
                  <xsl:call-template name="communication_Wd"/>
                  <xsl:call-template name="depositaryAccount_Wd"/>
				  <xsl:call-template name="exDate_Wd"/>
                  <xsl:call-template name="initiator_Wd"/>
                  <xsl:call-template name="notepad_Wd"/>
                  <xsl:call-template name="portfolio_Wd"/>
                  <xsl:call-template name="portfolioManager_Wd"/>
                  <xsl:call-template name="positionCriteria1_Wd"/>
                  <xsl:call-template name="positionCriteria2_Wd"/>
                  <xsl:call-template name="positionCriteria3_Wd"/>
                  <xsl:call-template name="remark_Wd"/>
                  <xsl:call-template name="reversalIndicator_Wd"/>
                  <xsl:call-template name="reversedTransactionCode_Wd"/>
                  <xsl:call-template name="security_Wd"/>
                  <xsl:call-template name="sourceSystemCode_Wd"/>
				  <xsl:call-template name="splitPortfolio_Wd"/>
                  <xsl:call-template name="status_Wd"/>
                  <xsl:call-template name="subType_Wd"/>
                  <xsl:call-template name="supplementaryAmount_Wd"/>
                  <xsl:call-template name="tradeCcyGrossAmount_Wd"/>
                  <xsl:call-template name="tradeCcyNetAmount_Wd"/>
                  <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Wd"/>
                  <xsl:call-template name="tradeCurrency_Wd"/>
                  <xsl:call-template name="tradePrice_Wd"/>
                  <xsl:call-template name="tradeQuantity_Wd"/>
                  <xsl:call-template name="transactionCode_Wd"/>
                  <xsl:call-template name="transactionDate_Wd"/>
                  <xsl:call-template name="transactionFeesTaxesCounter_Wd"/>
                  <xsl:call-template name="type_Wd"/>
                  <xsl:call-template name="typeInstrument_Wd"/>
                  <xsl:call-template name="valueDate_Wd"/>
                  <xsl:call-template name="userDefinedField_Wd"/>
                  <xsl:call-template name="mbFields_Wd"/>  
		      </Withdrawal>
			</DataGroup>
			</xsl:if>
			 <xsl:if test="b:entitlementAmt and number(b:entitlementAmt) != '0' and ../b:upfrontPaymentDiaryJoin = 'YES' and ../b:optStatus = 'COMPLETED' and ../b:netAmtAccCur != 0">
		  <!--<xsl:when test="b:upfrontPaymentDiaryJoin = 'Y' and b:optStatus = 'COMPLETED' and b:netAmtAccCur != 0 and b:entitlementAmt = 0">-->
            <DataGroup>
               <Investment>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionRightsDistributionGenericCOA.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
         </xsl:if>
         <xsl:if test="@index='2' and b:optionNom != 0 and ../b:optStatus = 'COMPLETED'"><!-- Sell the position -->
            <DataGroup>
               <Sell>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionRightsDistributionGenericCOA.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
         </xsl:if>
         <!-- end of: entilementAmt exists -->
 
   </xsl:template><!-- End of template OptionDescGroup -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\Users\bsfaizahamed\Documents\Mani\TransactionRights.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->