<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/><!-- notes: OptionDescGroup contains either (cash) or (cash and security (max 1 newSecurity)) --><!--        FT set fully on the security buy, if any -->
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
            <xsl:value-of select="concat('CoaReinvest',b:diaryId)"/>
         </xsl:attribute><!-- Status -->
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable><!-- Check if there is a security bought -->
         <xsl:variable name="nbNewSecuSubGroup" select="count(child::b:optionDescGroup[b:optionNom]/b:newSecuritySubGroup)"/><!-- Analyse optionDescGroup -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="opStatus" select="$opStatus"/>
            <xsl:with-param name="nbNewSecuSubGroup" select="$nbNewSecuSubGroup"/>
         </xsl:apply-templates>
      </GenericCOA>
   </xsl:template><!-- Template optionDescGroup for all having an optionNom (option choosen) -->
   <xsl:template match="b:optionDescGroup">
      <xsl:param name="opStatus"/><!-- transaction status -->
      <xsl:param name="nbNewSecuSubGroup"/><!-- Check if there is a security in this optionDescGroup -->
      <xsl:variable name="secuGroup" select="count(child::b:newSecuritySubGroup)"/><!-- Always doing a cash income first -->
      <DataGroup>
         <Income>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionReinvest.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="account1"/>
            <xsl:call-template name="account1CcyIncomeCcyExchangeRate"/>
            <xsl:call-template name="account1NetAmount">
               <xsl:with-param name="nbNewSecuSubGroup" select="$nbNewSecuSubGroup"/>
            </xsl:call-template>
            <xsl:call-template name="account2"/>
            <xsl:call-template name="account2CcyIncomeCcyExchangeRate"/>
            <xsl:call-template name="account2NetAmount"/>
            <xsl:call-template name="account3"/>
            <xsl:call-template name="account3CcyIncomeCcyExchangeRate"/>
            <xsl:call-template name="account3NetAmount"/>
            <xsl:call-template name="accountingCode"/>
            <xsl:call-template name="accountingDate"/>
            <xsl:call-template name="cashPortfolio"/>
            <xsl:call-template name="coaReference"/>
			<xsl:call-template name="commonReference"/>
            <xsl:call-template name="communication"/>
            <xsl:call-template name="depositaryAccount"/>
			<xsl:call-template name="exDate"/>
            <xsl:call-template name="income"/>
            <xsl:call-template name="incomeCcyGrossAmount"/>
            <xsl:call-template name="incomeCcyNetAmount"/>
            <xsl:call-template name="incomeCcyPortfolioCcyExchangeRate"/>
            <xsl:call-template name="incomeCounter"/>
            <xsl:call-template name="incomeCurrency"/>
            <xsl:call-template name="initiator"/>
            <xsl:call-template name="nominalOrUnit"/>
            <xsl:call-template name="notepad"/>
            <xsl:call-template name="portfolio"/>
            <xsl:call-template name="portfolioManager"/>
			<xsl:call-template name="positionCriteria1"/>
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
            <xsl:call-template name="transactionCode"/>
            <xsl:call-template name="transactionDate"/>
            <xsl:call-template name="transactionFeesTaxesCounter">
               <xsl:with-param name="nbNewSecuSubGroup" select="$nbNewSecuSubGroup"/>
            </xsl:call-template>
            <xsl:call-template name="type"/>
            <xsl:call-template name="typeInstrument"/>
            <xsl:call-template name="valueDate"/>
            <xsl:call-template name="userDefinedField"/>
            <xsl:call-template name="mbFields"/>
         </Income><!-- end of Income -->
      </DataGroup><!-- end of DataGroup Income --><!-- Buy new security if in a security group -->
      <xsl:if test="$secuGroup &gt; 0">
         <DataGroup>
            <Buy>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('TransactionReinvest.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
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
			   <xsl:call-template name="commonReference_Buy"/>
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
            </Buy><!-- End of Buy -->
         </DataGroup><!-- End of DataGroup Buy -->
      </xsl:if>
   </xsl:template><!-- End of: optionDescGroup[b:optionNom] -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionReinvest\TransactionReinvest.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\Online\TransactionEntitlement\TransactionEntitlement_TransactionEntitlementFilterCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
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