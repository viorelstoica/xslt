<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/AcEntry/AcEntry" xmlns:batch="http://www.temenos.com/T24/event/AcEntry/BatchAcEntry" xmlns:c="http://www.temenos.com/T24/event/AcEntry/MultiAcEntry" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:e="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcEntry/BatchMultiAcEntry" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="setMinRank">
      <xsl:for-each select="b:statemententry/e:transactionCode/@Rank">
         <xsl:sort data-type="number" order="descending" select="."/>
         <xsl:if test="position()=last()">
            <xsl:value-of select="."/>
         </xsl:if>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="account1">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>   
       <account1>
            <infra:code>
                <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
            </infra:code>
       </account1>
   </xsl:template>
   <xsl:template name="contractNumber"/>
   <xsl:template name="depositLoan">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <depositLoan>
         <infra:code>
            <xsl:choose>
               <xsl:when test="(contains(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference, ';'))">
                  <xsl:value-of select="concat(substring-before(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,';'), $COMPANY_POSTFIX_SEPARATOR, b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference, $COMPANY_POSTFIX_SEPARATOR, b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </depositLoan>
   </xsl:template>
   <xsl:template name="interestAmount">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <interestAmount>
         <xsl:choose>
            <xsl:when test="(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)) and (b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy))">
               <xsl:value-of select="0"/>
            </xsl:when>
            <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = '' or not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy)">
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy"/>
            </xsl:otherwise>
         </xsl:choose>
      </interestAmount>
   </xsl:template>
   <xsl:template name="portfolio">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCode>
         <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNo,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:processingDate"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="valueDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="account1CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyDepositLoanCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="depositLoanCurrency"/>
   <xsl:template name="depositLoanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="incomeFeesTaxesCounter"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <sourceSystemCode>
         <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNo"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="type">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <type>
         <infra:code>
            <xsl:choose>
               <xsl:when test="$POSTFIX_TROPTYPE = 'Y' ">
                  <xsl:value-of select="concat('TR_',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transactionCode,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="concat('TR_',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transactionCode)"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="referenceNature"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->