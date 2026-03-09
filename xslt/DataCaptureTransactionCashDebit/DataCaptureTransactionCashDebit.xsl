<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/DataCaptureTransactionCashDebit" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDataCaptureTransactionCashDebit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDataCaptureTransactionCashDebit" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDataCaptureTransactionCashDebit" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiDataCaptureTransactionCashDebit">
      <xsl:apply-templates select="c:CurrentEvent/b:DataCaptureTransactionCashDebit"/>
   </xsl:template>
   <xsl:template match="batch:BatchDataCaptureTransactionCashDebit">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDataCaptureTransactionCashDebit" name="BatchDataCaptureTransactionCashDebit">
         <xsl:apply-templates select="b:DataCaptureTransactionCashDebit"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiDataCaptureTransactionCashDebit">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDataCaptureTransactionCashDebit" name="BatchMultiDataCaptureTransactionCashDebit">
         <xsl:apply-templates select="c:MultiDataCaptureTransactionCashDebit"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:DataCaptureTransactionCashDebit">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('DataCaptureTransactionCashDebit',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Cash>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('DataCaptureTransactionCashDebit.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <transferOut>
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
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="ContractNumber"/>
				  <xsl:call-template name="intermediary"/>
				  <xsl:call-template name="market"/>
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
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="currentAccount"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="transactionCcyGrossAmount"/>
                  <xsl:call-template name="transactionCcyNetAmount"/>
                  <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="transactionCurrency"/>
                  <xsl:call-template name="transactionDate"/>
               </transferOut>
            </Cash>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="CashPosition" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CashPosition\CashPosition.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CashPosition\CashPosition_GWP.xml" processortype="jaxp"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="Customer" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Customer\Customer.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Customer\Customer_GWP.xml" processortype="jaxp" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="CustomerType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CustomerType\CustomerType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CustomerType\CustomerTypeGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="yes" name="DataCaptureTransactionCashDebit" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DataCaptureTransactionCashDebit\DataCaptureTransactionCashDebit.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\DataCaptureTransactionCashDebit\DataCaptureTransactionCashDebitCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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