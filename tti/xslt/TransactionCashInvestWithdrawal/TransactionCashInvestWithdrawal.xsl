<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/AcEntry/AcEntry" xmlns:batch="http://www.temenos.com/T24/event/AcEntry/BatchAcEntry" xmlns:c="http://www.temenos.com/T24/event/AcEntry/MultiAcEntry" xmlns:d="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:e="http://www.temenos.com/T24/AccountingEventsService/StatementEntry" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/AcEntry/BatchMultiAcEntry" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiAcEntry">
      <xsl:apply-templates select="c:CurrentEvent/b:AcEntry"/>
   </xsl:template>
   <xsl:template match="batch:BatchAcEntry">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAcEntry" name="BatchAcEntry">
         <xsl:apply-templates select="b:AcEntry"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiAcEntry">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAcEntry" name="BatchMultiAcEntry">
         <xsl:apply-templates select="c:MultiAcEntry"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:AcEntry">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <TransactionPMS>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('TransactionCashInvestWithdrawal',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:transactionCode)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:if test="(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != '' and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy &lt; 0) or (b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy != '' and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy &lt; 0)">
               <Cash>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionCashInvestWithdrawal.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <transferOut>
                     <xsl:call-template name="account1_O"/>
                     <xsl:call-template name="account1CcyTradeCcyExchangeRate_O"/>
                     <xsl:call-template name="account1NetAmount_O"/>
                     <xsl:call-template name="account2_O"/>
                     <xsl:call-template name="account2CcyTradeCcyExchangeRate_O"/>
                     <xsl:call-template name="account2NetAmount_O"/>
                     <xsl:call-template name="account3_O"/>
                     <xsl:call-template name="account3CcyTradeCcyExchangeRate_O"/>
                     <xsl:call-template name="account3NetAmount_O"/>
                     <xsl:call-template name="accountingCode_O"/>
                     <xsl:call-template name="accountingDate_O"/>
                     <xsl:call-template name="cashPortfolio_O"/>
                     <xsl:call-template name="commonReference_O"/>
                     <xsl:call-template name="ContractNumber_O"/>
					 <xsl:call-template name="intermediary_O"/>
				     <xsl:call-template name="market_O"/>
                     <xsl:call-template name="notepad_O"/>
                     <xsl:call-template name="portfolio_O"/>
                     <xsl:call-template name="portfolioManager_O"/>
                     <xsl:call-template name="remark_O"/>
                     <xsl:call-template name="reversalIndicator_O"/>
                     <xsl:call-template name="reversedTransactionCode_O"/>
                     <xsl:call-template name="sourceSystemCode_O"/>
                     <xsl:call-template name="status_O"/>
                     <xsl:call-template name="subType_O"/>
                     <xsl:call-template name="transactionCode_O"/>
                     <xsl:call-template name="transactionFeesTaxesCounter1_O"/>
                     <xsl:call-template name="transactionFeesTaxesCounter2_O"/>
                     <xsl:call-template name="type_O"/>
                     <xsl:call-template name="valueDate_O"/>
                     <xsl:call-template name="userDefinedField_O"/>
                     <xsl:call-template name="mbFields_O"/>
                     <xsl:call-template name="currentAccount_O"/>
                     <xsl:call-template name="quantity_O"/>
                     <xsl:call-template name="transactionCcyGrossAmount_O"/>
                     <xsl:call-template name="transactionCcyNetAmount_O"/>
                     <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_O"/>
                     <xsl:call-template name="transactionCurrency_O"/>
                     <xsl:call-template name="transactionDate_O"/>
                  </transferOut>
               </Cash>
            </xsl:if>
            <xsl:if test="(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy != '' and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountFcy &gt; 0) or (b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy != '' and b:statemententry[e:transactionCode/@Rank=$MinRank]/e:amountLcy &gt; 0)">
               <Cash>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('TransactionCashInvestment.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <transferIn>
                     <xsl:call-template name="account1_I"/>
                     <xsl:call-template name="account1CcyTradeCcyExchangeRate_I"/>
                     <xsl:call-template name="account1NetAmount_I"/>
                     <xsl:call-template name="account2_I"/>
                     <xsl:call-template name="account2CcyTradeCcyExchangeRate_I"/>
                     <xsl:call-template name="account2NetAmount_I"/>
                     <xsl:call-template name="account3_I"/>
                     <xsl:call-template name="account3CcyTradeCcyExchangeRate_I"/>
                     <xsl:call-template name="account3NetAmount_I"/>
                     <xsl:call-template name="accountingCode_I"/>
                     <xsl:call-template name="accountingDate_I"/>
                     <xsl:call-template name="cashPortfolio_I"/>
					 <xsl:call-template name="commonReference_I"/>
                     <xsl:call-template name="ContractNumber_I"/>
				     <xsl:call-template name="intermediary_I"/>
				     <xsl:call-template name="market_I"/>
                     <xsl:call-template name="notepad_I"/>
                     <xsl:call-template name="portfolio_I"/>
                     <xsl:call-template name="portfolioManager_I"/>
                     <xsl:call-template name="remark_I"/>
                     <xsl:call-template name="reversalIndicator_I"/>
                     <xsl:call-template name="reversedTransactionCode_I"/>
                     <xsl:call-template name="sourceSystemCode_I"/>
                     <xsl:call-template name="status_I"/>
                     <xsl:call-template name="subType_I"/>
                     <xsl:call-template name="transactionCode_I"/>
                     <xsl:call-template name="transactionFeesTaxesCounter1_I"/>
                     <xsl:call-template name="transactionFeesTaxesCounter2_I"/>
                     <xsl:call-template name="type_I"/>
                     <xsl:call-template name="valueDate_I"/>
                     <xsl:call-template name="userDefinedField_I"/>
                     <xsl:call-template name="mbFields_I"/>
                     <xsl:call-template name="currentAccount_I"/>
                     <xsl:call-template name="quantity_I"/>
                     <xsl:call-template name="transactionCcyGrossAmount_I"/>
                     <xsl:call-template name="transactionCcyNetAmount_I"/>
                     <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate_I"/>
                     <xsl:call-template name="transactionCurrency_I"/>
                     <xsl:call-template name="transactionDate_I"/>
                  </transferIn>
               </Cash>
            </xsl:if>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionCashInvestWithdrawal\TransactionCashInvestWithdrawal.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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