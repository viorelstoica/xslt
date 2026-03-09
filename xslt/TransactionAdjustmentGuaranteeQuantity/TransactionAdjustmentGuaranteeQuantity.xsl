<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAdjustmentGuaranteeQuantity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAdjustmentGuaranteeQuantity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAdjustmentGuaranteeQuantity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAdjustmentGuaranteeQuantity" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionAdjustmentGuaranteeQuantity">
      <xsl:apply-templates select="c:CurrentEvent/b:TransactionAdjustmentGuaranteeQuantity"/>
   </xsl:template>
   <xsl:template match="batch:BatchTransactionAdjustmentGuaranteeQuantity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionAdjustmentGuaranteeQuantity" name="BatchTransactionAdjustmentGuaranteeQuantity">
         <xsl:apply-templates select="b:TransactionAdjustmentGuaranteeQuantity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiTransactionAdjustmentGuaranteeQuantity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAdjustmentGuaranteeQuantity" name="BatchMultiTransactionAdjustmentGuaranteeQuantity">
         <xsl:apply-templates select="c:MultiTransactionAdjustmentGuaranteeQuantity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:TransactionAdjustmentGuaranteeQuantity">
      <GenericCOA mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('TransactionAdjustmentGuaranteeQuantity',b:id)"/>
         </xsl:attribute>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:pastSchedDateGroup">
               <Adjustment>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionAdjustmentGuaranteeQuantity.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
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
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="supplementaryAmount"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="transactionFeesTaxesCounter"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="typeInstrument"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
               </Adjustment>
            </xsl:for-each>
         </DataGroup>
      </GenericCOA>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionAdjustmentGuaranteeQuantity" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionAdjustmentGuaranteeQuantity\TransactionAdjustmentGuaranteeQuantity.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionAdjustmentGuaranteeQuantity\TransactionAdjustmentGuaranteeQuantityGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
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