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
   <xsl:template name="account1_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <account1>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate_O"/>
   <xsl:template name="account1NetAmount_O"/>
   <xsl:template name="account2_O"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate_O"/>
   <xsl:template name="account2NetAmount_O"/>
   <xsl:template name="account3_O"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate_O"/>
   <xsl:template name="account3NetAmount_O"/>
   <xsl:template name="accountingCode_O"/>
   <xsl:template name="commonReference_O"/>
   <xsl:template name="intermediary_O"/>
   <xsl:template name="market_O"/>
   <xsl:template name="accountingDate_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter1_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != ''">
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_CHARGES']/e:amountFcy),$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_CHARGES']/e:amountLcy),$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <type>
            <infra:code>
               <xsl:text>CASH_OP_TOT_CHARGES</xsl:text>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter2_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != ''">
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_TAXES']/e:amountFcy),$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_TAXES']/e:amountLcy),$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <type>
            <infra:code>CASH_OP_TOT_TAXES</infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="transactionCode_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCode>
         <xsl:value-of select="concat('SE_',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNo,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="currentAccount_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <currentAccount>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="transactionCurrency_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:currencyAcc"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
   <xsl:template name="transactionDate_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="portfolio_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <quantity>
         <xsl:choose>
            <xsl:when test="not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy) or b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = ''">
               <xsl:choose>
                  <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy &lt; 0">
                     <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy,$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy &lt; '0'">
                     <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy,$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
   <xsl:template name="sourceSystemCode_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <sourceSystemCode>
         <xsl:value-of select="concat(substring-before(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,';'),'_',substring-after(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,';'))"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status_O">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType_O"/>
   <xsl:template name="type_O">
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
   <xsl:template name="valueDate_O">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="cashPortfolio_O"/>
   <xsl:template name="ContractNumber_O"/>
   <xsl:template name="notepad_O"/>
   <xsl:template name="portfolioManager_O"/>
   <xsl:template name="remark_O"/>
   <xsl:template name="reversalIndicator_O"/>
   <xsl:template name="reversedTransactionCode_O"/>
   <xsl:template name="userDefinedField_O"/>
   <xsl:template name="mbFields_O"/>
   <xsl:template name="transactionCcyGrossAmount_O"/>
   <xsl:template name="transactionCcyNetAmount_O"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate_O"/>
   <xsl:template name="account1_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <account1>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate_I"/>
   <xsl:template name="account1NetAmount_I"/>
   <xsl:template name="account2_I"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate_I"/>
   <xsl:template name="account2NetAmount_I"/>
   <xsl:template name="account3_I"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate_I"/>
   <xsl:template name="account3NetAmount_I"/>
   <xsl:template name="accountingCode_I"/>
   <xsl:template name="commonReference_I"/>
   <xsl:template name="intermediary_I"/>
   <xsl:template name="market_I"/>
   <xsl:template name="accountingDate_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter1_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != ''">
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_CHARGES']/e:amountFcy),$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_CHARGES']/e:amountLcy),$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <type>
            <infra:code>
               <xsl:text>CASH_OP_TOT_CHARGES</xsl:text>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter2_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != ''">
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_TAXES']/e:amountFcy),$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(-1 * sum( b:statemententry[e:transactionCode/@Rank!=$MinRank and e:transactionCode/@BalancePosition='CASH_OP_TOT_TAXES']/e:amountLcy),$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <type>
            <infra:code>CASH_OP_TOT_TAXES</infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="transactionCode_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCode>
         <xsl:value-of select="concat('SE_',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNo,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="currentAccount_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <currentAccount>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="transactionCurrency_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:currencyAcc"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
   <xsl:template name="transactionDate_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="portfolio_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <quantity>
         <xsl:choose>
            <xsl:when test="not(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy) or b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy = ''">
               <xsl:choose>
                  <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy &lt; 0">
                     <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy,$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy &lt; '0'">
                     <xsl:value-of select="format-number(-1 * b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy,$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
   <xsl:template name="sourceSystemCode_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <sourceSystemCode>
         <xsl:value-of select="concat(substring-before(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,';'),'_',substring-after(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transReference,';'))"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status_I">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType_I"/>
   <xsl:template name="type_I">
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
   <xsl:template name="valueDate_I">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="cashPortfolio_I"/>
   <xsl:template name="ContractNumber_I"/>
   <xsl:template name="notepad_I"/>
   <xsl:template name="portfolioManager_I"/>
   <xsl:template name="remark_I"/>
   <xsl:template name="reversalIndicator_I"/>
   <xsl:template name="reversedTransactionCode_I"/>
   <xsl:template name="userDefinedField_I"/>
   <xsl:template name="mbFields_I"/>
   <xsl:template name="transactionCcyGrossAmount_I"/>
   <xsl:template name="transactionCcyNetAmount_I"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate_I"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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