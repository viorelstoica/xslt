<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/><!-- notes: F&T set on first new Security -->
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
            <xsl:value-of select="concat('CoaDistribution',b:diaryId)"/>
         </xsl:attribute><!-- Transaction status: opStatus -->
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable><!-- Knowing if there is new security -->
         <xsl:variable name="nbOptionDescGroupWithNewSecurity" select="count(child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup])"/><!-- Get nodes with a newSecuritySubGroup -->
         <xsl:variable name="nodesWithNewSecurity" select="child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup]"/><!--Security part -->
         <xsl:apply-templates select="b:optionDescGroup">
            <xsl:with-param name="opStatus" select="$opStatus"/>
            <xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
            <xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$nodesWithNewSecurity/@index"/>
         </xsl:apply-templates>
      </GenericCOA>
   </xsl:template><!-- Template optionDescGroup for all having an optionNom (option choosen) -->
   <xsl:template match="b:optionDescGroup">
      <xsl:param name="nbOptionDescGroupWithNewSecurity"/><!-- indicates there are new securities -->
      <xsl:param name="opStatus"/>
      <xsl:param name="idxFirstOptDescGroupWithNewSecu"/>
      <xsl:apply-templates select="b:newSecuritySubGroup">
         <xsl:with-param name="opStatus" select="$opStatus"/>
         <xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
         <xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$idxFirstOptDescGroupWithNewSecu"/>
      </xsl:apply-templates>
   </xsl:template><!-- End of: b:optionDescGroup[b:optionNom] -->
   <xsl:template match="b:newSecuritySubGroup">
      <xsl:param name="opStatus"/><!-- transaction status -->
      <xsl:param name="nbOptionDescGroupWithNewSecurity"/><!-- indicates there are new securities -->
      <xsl:param name="idxFirstOptDescGroupWithNewSecu"/><!-- index first optionDescGroup with newSecuritySubGroup --><!-- Security part -->
      <DataGroup>
         <Adjustment>
            <xsl:attribute name="description">
               <xsl:value-of select="concat('TransactionDistribution.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>
            <xsl:attribute name="sequenceNumber">
               <xsl:call-template name="calcSeqNum">
                  <xsl:with-param name="creationTime">
                     <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:attribute>
            <xsl:call-template name="account1"/>
            <xsl:call-template name="account1CcyoldSecCcyExchangeRate"/>
            <xsl:call-template name="account1NetAmount"/>
            <xsl:call-template name="account2"/>
            <xsl:call-template name="account2CcyoldSecCcyExchangeRate"/>
            <xsl:call-template name="account2NetAmount"/>
            <xsl:call-template name="account3"/>
            <xsl:call-template name="account3CcyoldSecCcyExchangeRate"/>
            <xsl:call-template name="account3NetAmount"/>
            <xsl:call-template name="accountingCode"/>
            <xsl:call-template name="accountingDate"/>
            <xsl:call-template name="accruedInterestAmount"/>
            <xsl:call-template name="accruedInterestCounter"/>
            <xsl:call-template name="adjustmentCounter"/>
            <xsl:call-template name="adjustmentNature"/>
            <xsl:call-template name="adjustmentPortfolio"/>
            <xsl:call-template name="cashPortfolio"/>
            <xsl:call-template name="coaReference"/>
			<xsl:call-template name="commonReference"/>
            <xsl:call-template name="communication"/>
			<xsl:call-template name="exDate"/>
            <xsl:call-template name="initiator"/>
            <xsl:call-template name="newQuantity"/>
            <xsl:call-template name="newSecurity"/>
            <xsl:call-template name="newSecurityCcyPositionCcyExchangeRate"/>
            <xsl:call-template name="newSecurityDepositaryAccount"/>
            <xsl:call-template name="newSecurityNetAmount"/>
            <xsl:call-template name="newSecurityPositionCriteria1"/>
            <xsl:call-template name="newSecurityPositionCriteria2"/>
            <xsl:call-template name="newSecurityPositionCriteria3"/>
            <xsl:call-template name="newSecurityPositionCurrency"/>
            <xsl:call-template name="notepad"/>
            <xsl:call-template name="oldCcyGrossAmount"/>
            <xsl:call-template name="oldCcyNetAmount"/>
            <xsl:call-template name="oldCcyPortfolioCcyExchangeRate"/>
            <xsl:call-template name="oldPrice"/>
            <xsl:call-template name="oldQuantity"/>
            <xsl:call-template name="oldSecurity"/>
            <xsl:call-template name="oldSecurityDepositaryAccount"/>
            <xsl:call-template name="oldSecurityPositionCriteria1"/>
            <xsl:call-template name="oldSecurityPositionCriteria2"/>
            <xsl:call-template name="oldSecurityPositionCriteria3"/>
            <xsl:call-template name="oldSecurityPositionCurrency"/>
            <xsl:call-template name="portfolio"/>
            <xsl:call-template name="portfolioManager"/>
            <xsl:call-template name="remark"/>
            <xsl:call-template name="reversalIndicator"/>
            <xsl:call-template name="reversedTransactionCode"/>
            <xsl:call-template name="sourceSystemCode"/>
			<xsl:call-template name="splitPortfolio"/>
            <xsl:call-template name="status"/>
            <xsl:call-template name="subType"/>
            <xsl:call-template name="supplementaryAmount"/>
            <xsl:call-template name="transactionCode"/>
            <xsl:call-template name="transactionDate"/>
            <xsl:call-template name="transactionFeesTaxesCounter">
               <xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$idxFirstOptDescGroupWithNewSecu"/>
            </xsl:call-template>
            <xsl:call-template name="type"/>
            <xsl:call-template name="typeInstrument"/>
            <xsl:call-template name="valueDate"/>
            <xsl:call-template name="userDefinedField"/>
            <xsl:call-template name="mbFields"/>
         </Adjustment>
         <xsl:if test=" ../b:entitlementAmt != ''  and ../b:entitlementAmt != 0">
            <Income>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('TransactionDistribution.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="Income_account1"/>
               <xsl:call-template name="Income_account1CcyIncomeCcyExchangeRate"/>
               <xsl:call-template name="Income_account1NetAmount"/>
               <xsl:call-template name="Income_account2"/>
               <xsl:call-template name="Income_account2CcyIncomeCcyExchangeRate"/>
               <xsl:call-template name="Income_account2NetAmount"/>
               <xsl:call-template name="Income_account3"/>
               <xsl:call-template name="Income_account3CcyIncomeCcyExchangeRate"/>
               <xsl:call-template name="Income_account3NetAmount"/>
               <xsl:call-template name="Income_accountingCode"/>
               <xsl:call-template name="Income_accountingDate"/>
               <xsl:call-template name="Income_cashPortfolio"/>
               <xsl:call-template name="Income_coaReference"/>
			   <xsl:call-template name="Income_commonReference"/>
               <xsl:call-template name="Income_communication"/>
               <xsl:call-template name="Income_depositaryAccount"/>
			   <xsl:call-template name="Income_exDate"/>
               <xsl:call-template name="Income_income"/>
               <xsl:call-template name="Income_incomeCcyGrossAmount"/>
               <xsl:call-template name="Income_incomeCcyNetAmount"/>
               <xsl:call-template name="Income_incomeCcyPortfolioCcyExchangeRate"/>
               <xsl:call-template name="Income_incomeCounter"/>
               <xsl:call-template name="Income_incomeCurrency"/>
               <xsl:call-template name="Income_initiator"/>
               <xsl:call-template name="Income_nominalOrUnit"/>
               <xsl:call-template name="Income_notepad"/>
               <xsl:call-template name="Income_portfolio"/>
               <xsl:call-template name="Income_portfolioManager"/>
			   <xsl:call-template name="Income_positionCriteria1"/>
               <xsl:call-template name="Income_remark"/>
               <xsl:call-template name="Income_reversalIndicator"/>
               <xsl:call-template name="Income_reversedTransactionCode"/>
               <xsl:call-template name="Income_security"/>
               <xsl:call-template name="Income_securityCcyNetAmount"/>
               <xsl:call-template name="Income_securityCcyPortfolioCcyExchangeRate"/>
               <xsl:call-template name="Income_sourceSystemCode"/>
			   <xsl:call-template name="Income_splitPortfolio"/>
               <xsl:call-template name="Income_status"/>
               <xsl:call-template name="Income_subType"/>
               <xsl:call-template name="Income_transactionCode"/>
               <xsl:call-template name="Income_transactionDate"/>
               <xsl:call-template name="Income_transactionFeesTaxesCounter"/>
               <xsl:call-template name="Income_type"/>
               <xsl:call-template name="Income_typeInstrument"/>
               <xsl:call-template name="Income_valueDate"/>
               <xsl:call-template name="Income_userDefinedField"/>
               <xsl:call-template name="Income_mbFields"/>
            </Income>
         </xsl:if>
      </DataGroup>
   </xsl:template><!-- End of: b:newSecuritySubGroup --><!-- Default template for optionDescGroup --><!--<xsl:template match="b:optionDescGroup">
    <xsl:param name="opStatus"/>
    <xsl:param name="nbOptionDescGroupWithNewSecurity"/>--><!-- indicates there are new securities --><!--</xsl:template>-->
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
--><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionEntitlement\TransactionEntitlement.xml" htmlbaseurl="..\..\TestFiles\TransactionConversion\TransactionConversion2.xml"
		          outputurl="..\..\TestFiles\TransactionEntitlement\TransactionEntitlementGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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