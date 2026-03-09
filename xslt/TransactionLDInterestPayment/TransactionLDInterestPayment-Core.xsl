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
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <account1>
            <infra:code>
               <xsl:value-of select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:accountNumber"/>
            </infra:code>
         </account1>
      </xsl:if>
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
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <accountingDate>
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
            </xsl:call-template>
         </accountingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="depositLoan">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <depositLoan>
            <infra:code>
               <xsl:value-of select="concat(b:statemententry[e:transactionCode/@Rank=$MinRank]/e:ourReference,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
            </infra:code>
         </depositLoan>
      </xsl:if>
   </xsl:template>
   <xsl:template name="depositLoanCurrency"/>
   <xsl:template name="depositLoanCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="incomeFeesTaxesCounter"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="interestAmount">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <interestAmount>
            <xsl:choose>
               <xsl:when test="(b:statemententry/e:amountFcy = '' or not(b:statemententry/e:amountFcy)) and (b:statemententry/e:amountLcy = '' or not(b:statemententry/e:amountLcy))">
                  <xsl:value-of select="0"/>
               </xsl:when>
               <xsl:when test="b:statemententry/e:amountFcy = '' or not(b:statemententry/e:amountFcy)">
                  <xsl:value-of select="b:statemententry/e:amountLcy"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:statemententry/e:amountFcy"/>
               </xsl:otherwise>
            </xsl:choose>
         </interestAmount>
      </xsl:if>
   </xsl:template>
   <xsl:template name="notepad"/>
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
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="status">
      <status>90</status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCode">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <transactionCode>
            <xsl:value-of select="concat('SE_',b:statemententry[e:transactionCode/@Rank=$MinRank]/e:statementNumber,$COMPANY_POSTFIX_SEPARATOR,b:statemententry[e:transactionCode/@Rank=$MinRank]/e:mnemonic)"/>
         </transactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="transactionDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <transactionDate>
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:bookingDate"/>
            </xsl:call-template>
         </transactionDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>0</amount>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP1'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>0</amount>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP2'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>0</amount>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP3'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>0</amount>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP4'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <xsl:choose>
            <xsl:when test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 464">
               <amount>
                  <xsl:choose>
                     <xsl:when test="(b:statemententry/e:amountFcy = '' or not(b:statemententry/e:amountFcy)) and (b:statemententry/e:amountLcy = '' or not(b:statemententry/e:amountLcy))">
                        <xsl:value-of select="0"/>
                     </xsl:when>
                     <xsl:when test="b:statemententry/e:amountFcy = '' or not(b:statemententry/e:amountFcy)">
                        <xsl:value-of select="b:statemententry/e:amountLcy"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="b:statemententry/e:amountFcy"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </amount>
            </xsl:when>
            <xsl:otherwise>
               <amount>0</amount>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 464">
            <currency>
               <infra:code>
                  <xsl:value-of select="b:statemententry/e:currency"/>
               </infra:code>
            </currency>
         </xsl:if>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP9'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="'LD_PAY_INTERESTS'"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <xsl:variable name="MinRank">
         <xsl:call-template name="setMinRank"/>
      </xsl:variable>
      <xsl:if test="b:statemententry/e:transactionCode[@Rank=$MinRank] = 424 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 434 or b:statemententry/e:transactionCode[@Rank=$MinRank] = 444">
         <valueDate>
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="b:statemententry[e:transactionCode/@Rank=$MinRank]/e:valueDate"/>
            </xsl:call-template>
         </valueDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="referenceNature"/>
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
-->