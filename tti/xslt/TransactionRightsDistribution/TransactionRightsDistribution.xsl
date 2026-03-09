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
            <xsl:value-of select="concat('CoaRightsDistribution',substring-before(b:entitlementId,'.'))"/>
         </xsl:attribute><!-- Transaction status: opStatus -->
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable><!-- Receive rights -->
         <xsl:if test="b:optStatus = 'PENDING'">
            <xsl:apply-templates select="b:secNoGroup">
               <xsl:with-param name="opStatus" select="$opStatus"/>
            </xsl:apply-templates>
         </xsl:if><!-- Exchange rights -->
         <xsl:if test="b:optStatus = 'COMPLETED'">
            <xsl:variable name="nbGroupsPrice" select="count(descendant::b:optionDescGroup/b:newSecuritySubGroup[b:price])"/><!-- select groups where shares are bough (to put FT ) -->
            <xsl:apply-templates select="b:optionDescGroup[b:newSecuritySubGroup[b:price]]">
               <xsl:with-param name="nbPriceOptions" select="$nbGroupsPrice"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:apply-templates>
         </xsl:if>
      </CorporateActionPMS>
   </xsl:template><!-- Template for rights distribution -->
   <xsl:template match="b:secNoGroup[b:secNominal]">
      <xsl:param name="opStatus"/><!-- Print record -->
      <DataGroup>
         <RightsDistribution>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionRightsDistribution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
			<xsl:call-template name="exDate"/>
            <xsl:call-template name="rightDepositaryAccount"/>
            <xsl:call-template name="rightQuantity"/>
            <xsl:call-template name="rightUnitaryCostPrice"/>
            <xsl:call-template name="right"/>
		    <xsl:call-template name="splitPortfolio"/>
         </RightsDistribution>
      </DataGroup>
   </xsl:template><!-- End of template for RightsDistribution (qty &gt; 0)--><!-- Template for rights exchange --><!-- Step 1: Buy new shares --><!-- Get the groups having a price and having been elected (optionNom) -->
   <xsl:template match="b:optionDescGroup[b:newSecuritySubGroup[b:price]]">
      <xsl:param name="nbPriceOptions"/>
      <xsl:param name="opStatus"/><!-- Creation of a buy -->
      <xsl:variable name="secuBought" select="b:newSecuritySubGroup[1]/b:newSecurity"/>
      <xsl:if test="b:optionNom != 0">
         <DataGroup>
            <Conversion>
               <Link>
                  <TransferIn>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionRightsDistribution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <xsl:call-template name="account1_TransferIn"/>
                     <xsl:call-template name="account1CcyPurchaseCcyExchangeRate_TransferIn"/>
                     <xsl:call-template name="account1NetAmount_TransferIn"/>
                     <xsl:call-template name="account2_TransferIn"/>
                     <xsl:call-template name="account2CcyPurchaseCcyExchangeRate_TransferIn"/>
                     <xsl:call-template name="account2NetAmount_TransferIn"/>
                     <xsl:call-template name="account3_TransferIn"/>
                     <xsl:call-template name="account3CcyPurchaseCcyExchangeRate_TransferIn"/>
                     <xsl:call-template name="account3NetAmount_TransferIn"/>
                     <xsl:call-template name="accountingCode_TransferIn"/>
                     <xsl:call-template name="accountingDate_TransferIn"/>
                     <xsl:call-template name="accruedInterests_TransferIn"/>
                     <xsl:call-template name="accruedInterestCounter_TransferIn"/>
                     <xsl:call-template name="cashPortfolio_TransferIn"/>
                     <xsl:call-template name="coaReference_TransferIn"/>
					 <xsl:call-template name="commonReference_TransferIn"/>
                     <xsl:call-template name="contractNumber_TransferIn"/>
                     <xsl:call-template name="depositaryAccount_TransferIn"/>
                     <xsl:call-template name="initiator_TransferIn"/>
                     <xsl:call-template name="notepad_TransferIn"/>
                     <xsl:call-template name="portfolio_TransferIn"/>
                     <xsl:call-template name="portfolioManager_TransferIn"/>
                     <xsl:call-template name="positionCriteria1_TransferIn"/>
                     <xsl:call-template name="positionCriteria2_TransferIn"/>
                     <xsl:call-template name="positionCriteria3_TransferIn"/>
                     <xsl:call-template name="purchaseCcyGrossAmount_TransferIn"/>
                     <xsl:call-template name="purchaseCcyNetAmount_TransferIn"/>
                     <xsl:call-template name="purchaseCcyPortfolioCcyExchangeRate_TransferIn"/>
                     <xsl:call-template name="purchaseCurrency_TransferIn"/>
                     <xsl:call-template name="purchasePrice_TransferIn"/>
                     <xsl:call-template name="remark_TransferIn"/>
                     <xsl:call-template name="reversalIndicator_TransferIn"/>
                     <xsl:call-template name="reversedTransactionCode_TransferIn"/>
                     <xsl:call-template name="security_TransferIn"/>
                     <xsl:call-template name="securityCcyNetAmount_TransferIn"/>
                     <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_TransferIn"/>
                     <xsl:call-template name="sourceSystemCode_TransferIn"/>
                     <xsl:call-template name="status_TransferIn"/>
                     <xsl:call-template name="subType_TransferIn"/>
                     <xsl:call-template name="transactionCode_TransferIn"/>
                     <xsl:call-template name="purchaseDate_TransferIn"/>
                     <xsl:call-template name="transactionFeesTaxesCounter_TransferIn"/>
                     <xsl:call-template name="type_TransferIn"/>
                     <xsl:call-template name="typeInstrument_TransferIn"/>
                     <xsl:call-template name="valueDate_TransferIn"/>
                     <xsl:call-template name="userDefinedField_TransferIn"/>
                     <xsl:call-template name="mbFields_TransferIn"/>
                     <xsl:call-template name="conversionQuantity_TransferIn"/>
					 <xsl:call-template name="exDate_TransferIn"/>
		             <xsl:call-template name="splitPortfolio_TransferIn"/>
                  </TransferIn>
               </Link>
            </Conversion>
         </DataGroup><!-- End of Buy --><!-- Exchange the exercised options -->
         <DataGroup>
            <Conversion>
               <Link>
                  <TransferOut>
                     <xsl:attribute name="description">
                        <xsl:value-of select="concat('TransactionRightsDistribution.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                     </xsl:attribute>
                     <xsl:attribute name="sequenceNumber">
                        <xsl:call-template name="calcSeqNum">
                           <xsl:with-param name="creationTime">
                              <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:attribute>
                     <xsl:call-template name="account1_TransferOut"/>
                     <xsl:call-template name="account1CcyPositionCcyExchangeRate_TransferOut"/>
                     <xsl:call-template name="account1NetAmount_TransferOut"/>
                     <xsl:call-template name="account2_TransferOut"/>
                     <xsl:call-template name="account2CcyPositionCcyExchangeRate_TransferOut"/>
                     <xsl:call-template name="account2NetAmount_TransferOut"/>
                     <xsl:call-template name="account3_TransferOut"/>
                     <xsl:call-template name="account3CcyPositionCcyExchangeRate_TransferOut"/>
                     <xsl:call-template name="account3NetAmount_TransferOut"/>
                     <xsl:call-template name="accountingCode_TransferOut"/>
                     <xsl:call-template name="accountingDate_TransferOut"/>
                     <xsl:call-template name="cashPortfolio_TransferOut"/>
					 <xsl:call-template name="commonReference_TransferOut"/>
                     <xsl:call-template name="contractNumber_TransferOut"/>
                     <xsl:call-template name="notepad_TransferOut"/>
                     <xsl:call-template name="portfolio_TransferOut"/>
                     <xsl:call-template name="portfolioManager_TransferOut"/>
                     <xsl:call-template name="remark_TransferOut"/>
                     <xsl:call-template name="reversalIndicator_TransferOut"/>
                     <xsl:call-template name="reversedTransactionCode_TransferOut"/>
                     <xsl:call-template name="sourceSystemCode_TransferOut"/>
                     <xsl:call-template name="status_TransferOut"/>
                     <xsl:call-template name="subType_TransferOut"/>
                     <xsl:call-template name="transactionCode_TransferOut"/>
                     <xsl:call-template name="transactionFeesTaxesCounter_TransferOut"/>
                     <xsl:call-template name="type_TransferOut"/>
                     <xsl:call-template name="typeInstrument_TransferOut"/>
                     <xsl:call-template name="valueDate_TransferOut"/>
                     <xsl:call-template name="userDefinedField_TransferOut"/>
                     <xsl:call-template name="mbFields_TransferOut"/>
                     <xsl:call-template name="coaReference_TransferOut"/>
					 <xsl:call-template name="exDate_TransferOut"/>
                     <xsl:call-template name="initiator_TransferOut"/>
                     <xsl:call-template name="newQuantity_TransferOut"/>
                     <xsl:call-template name="newSecurity_TransferOut"/>
                     <xsl:call-template name="newSecurityDepositaryAccount_TransferOut"/>
                     <xsl:call-template name="newSecurityPositionCriteria1_TransferOut"/>
                     <xsl:call-template name="newSecurityPositionCriteria2_TransferOut"/>
                     <xsl:call-template name="newSecurityPositionCriteria3_TransferOut"/>
                     <xsl:call-template name="newSecurityPositionCurrency_TransferOut"/>
                     <xsl:call-template name="oldQuantity_TransferOut">
                        <xsl:with-param name="secuBought" select="$secuBought"/>
                     </xsl:call-template>
                     <xsl:call-template name="oldSecurity_TransferOut">
                        <xsl:with-param name="secuBought" select="$secuBought"/>
                     </xsl:call-template>
                     <xsl:call-template name="oldSecurityDepositaryAccount_TransferOut"/>
                     <xsl:call-template name="oldSecurityPositionCriteria1_TransferOut"/>
                     <xsl:call-template name="oldSecurityPositionCriteria2_TransferOut"/>
                     <xsl:call-template name="oldSecurityPositionCriteria3_TransferOut"/>
                     <xsl:call-template name="oldSecuritypositionCurrency_TransferOut"/>
					 <xsl:call-template name="splitPortfolio_TransferOut"/>
                     <xsl:call-template name="transactionDate_TransferOut"/>
                     <xsl:call-template name="unitaryCostPrice_TransferOut"/> 
                  </TransferOut>
               </Link>
            </Conversion>
         </DataGroup><!-- End of Removal of rights by adj PL -->
      </xsl:if><!-- End of if optionNom != 0 --><!--/xsl:template--><!-- End of template for buy shares and exchange options --><!-- Removing unused rights (LAPSE) --><!-- The default of optionDescGroup: is the lapse of rights, should have 1 node --><!--xsl:template match="b:optionDescGroup">
    <xsl:param name="nbPriceOptions"/>
    <xsl:param name="opStatus"/--><!-- Print record -->
      <!-- End of Removal of rights by adj PL -->
   </xsl:template><!-- end of default on newSecuritySubGroup (LAPSE) -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
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