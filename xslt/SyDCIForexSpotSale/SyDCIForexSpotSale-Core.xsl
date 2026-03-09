<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:fixingDate,'-','')"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="currentAccountCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
         <reversalIndicator>
            <xsl:value-of select=" '1' "/>
         </reversalIndicator>
      </xsl:if>
   </xsl:template>
   <xsl:template name="reversedTransactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <reversedTransactionCode>
         <xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
	         <xsl:choose>
	            <xsl:when test="b:tapRefId">
                   <xsl:value-of select="b:tapRefId"/>
	            </xsl:when>
	            <xsl:otherwise>
                   <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
	            </xsl:otherwise>
	         </xsl:choose>
	     </xsl:if>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="status">
      <status>
         <xsl:value-of select=" '90' "/>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select=" 'FX_SP' "/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="fxMarketRate"/>
   <xsl:template name="fxRateDirection"/>
   <xsl:template name="fxClientRate"/>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="purchasedCcyCurrentAccount">
      <purchasedCcyCurrentAccount>
         <infra:code>
            <xsl:if test="b:exerciseCcy = b:alternateCcy1">
               <xsl:value-of select="b:custAltCcyAcc1"/>
            </xsl:if>
            <xsl:if test="b:exerciseCcy = b:alternateCcy2">
               <xsl:value-of select="b:custAltCcyAcc2"/>
            </xsl:if>         
         </infra:code>
      </purchasedCcyCurrentAccount>
   </xsl:template>
   <xsl:template name="purchasedCcyNetAmount">
      <purchasedCcyNetAmount>
         <xsl:choose>
            <xsl:when test="b:exerciseCcy = b:alternateCcy1">
		         <xsl:choose>
		            <xsl:when test="b:convertInterest = 'YES'">
		               <xsl:value-of select="format-number(b:depAmtAltCcy1 + b:intAmtAltCcy1, $decimalformat, 'nan2zero')"/>
		            </xsl:when>
		            <xsl:otherwise>
                       <xsl:value-of select="format-number(b:depAmtAltCcy1, $decimalformat, 'nan2zero')"/>
		            </xsl:otherwise>
		         </xsl:choose>            
            </xsl:when>
            <!-- exercis ccy = altnernate ccy 2 -->
            <xsl:otherwise>
                 <xsl:choose>
                    <xsl:when test="b:convertInterest = 'YES'">
                       <xsl:value-of select="format-number(b:depAmtAltCcy2 + b:intAmtAltCcy2, $decimalformat, 'nan2zero')"/>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="format-number(b:depAmtAltCcy2, $decimalformat, 'nan2zero')"/>
                    </xsl:otherwise>
                 </xsl:choose>            
            </xsl:otherwise>
         </xsl:choose>
      </purchasedCcyNetAmount>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:choose>
            <xsl:when test="b:convertInterest = 'YES'">
               <xsl:value-of select="format-number(b:depositAmount + b:interestAmount,$decimalformat,'nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:depositAmount"/>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
   <xsl:template name="soldCurrencyCurrentAccount">
      <soldCurrencyCurrentAccount>
         <infra:code>
            <xsl:value-of select="b:custDepositAcc"/>
         </infra:code>
      </soldCurrencyCurrentAccount>
   </xsl:template>
   <xsl:template name="spotExchangeRate"/>
   <xsl:template name="transactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
                <xsl:choose>
                    <xsl:when test="b:tapRefId">
                        <xsl:value-of select="concat(b:tapRefId, '_R')"/>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="concat(b:id,'_R',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="b:tapRefId">
                        <xsl:value-of select="b:tapRefId"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>
                    </xsl:otherwise>
                </xsl:choose>            
            </xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:fixingDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:fixingDate,'-','')"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="fxMarginP"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\IntegrationStudio\TTI\schemas\SyTci\TTI-SyTci.xsd" srcSchemaRoot="SyTci" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template name="account1"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->