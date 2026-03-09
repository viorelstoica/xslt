<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.temenos.com/T24/event/TTI/FundsTransferTransactionCashCredit"  xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <xsl:if test="b:commissionCode = 'CREDIT LESS CHARGES'">
         <account1>
            <infra:code>
               <xsl:choose>
                  <xsl:when test="b:chargesAcctNo != ''">
                     <xsl:value-of select="b:chargesAcctNo"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:creditAcctNo"/>
                  </xsl:otherwise>
               </xsl:choose>
            </infra:code>
         </account1>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:choose>
            <xsl:when test="b:commissionCode = 'CREDIT LESS CHARGES'">
               <xsl:value-of select="substring(b:totalChargeAmt,4)"/>
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="accountingCode">
      <accountingCode>
         <xsl:value-of select="b:id"/>
      </accountingCode>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
		  <xsl:choose>
		  	<xsl:when test="b:IdPortfolioSecAccMasterJoinList/b:IdPortfolioSecAccMasterJoin">
				<xsl:value-of select="b:IdPortfolioSecAccMasterJoinList/b:IdPortfolioSecAccMasterJoin"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:IdPortfolioSecAccMasterHistJoin"/>
			</xsl:otherwise>
          </xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
      </sourceSystemCode>
   </xsl:template>
	<xsl:template name="status">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
	  <xsl:variable name="status1">
		<xsl:value-of select="substring(b:status, string-length(b:status) - 2)" />
	</xsl:variable>
      <status>
         <xsl:choose>
            <xsl:when test="$opStatus = 'INPUT-INPUT'">
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'TOVALIDATE'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:when test="$opStatus = 'INPUT-DELETE'">
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'CANCELLED'"/>
               </xsl:call-template>
            </xsl:when>
			<xsl:when test="$opStatus = 'INPUT-AUTHORISE' and $status1 = 'FWD'">
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'EXECUTED'"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:value-of select="concat('FT_',b:id,'_C',$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="substring(b:totalChargeAmt,4) &gt; 0 and b:commissionCode = 'CREDIT LESS CHARGES'">
                  <xsl:choose>
                     <xsl:when test="b:totalTaxAmount">
                        <xsl:value-of select="format-number(substring(b:totalChargeAmt,4) - substring(b:totalTaxAmount,4),$decimalformat,'nan2zero')"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="substring(b:totalChargeAmt,4)"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="0"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="substring(b:totalChargeAmt,1,3)"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>CASH_OP_TOT_CHARGES</infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="substring(b:totalTaxAmount,4) &gt; 0 and b:commissionCode = 'CREDIT LESS CHARGES'">
                  <xsl:value-of select="substring(b:totalTaxAmount,4)"/>
               </xsl:when>
               <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="substring(b:totalChargeAmt,1,3)"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>CASH_OP_TOT_TAXES</infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:choose>
               <xsl:when test="$POSTFIX_FTOPTYPE = 'Y' ">
                  <xsl:value-of select="concat('FT_',b:transactionType,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="concat('FT_',b:transactionType)"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:creditValueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="currentAccount">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="b:creditAcctNo"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:choose>
            <xsl:when test="substring(b:totalChargeAmt,4) &gt; 0 and b:commissionCode = 'CREDIT LESS CHARGES' and (not(b:chargesAcctNo) or b:chargesAcctNo = '')">
               <xsl:value-of select="format-number(substring(b:amountCredited,4) + substring(b:totalChargeAmt,4),$decimalformat,'nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="substring(b:amountCredited,4)"/>
            </xsl:otherwise>
         </xsl:choose>
      </quantity>
   </xsl:template>
	<xsl:template name="transactionDate">
      <transactionDate>
	  <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
	  <xsl:variable name="status1">
		<xsl:value-of select="substring(b:status, string-length(b:status) - 2)" />
	</xsl:variable>
	  <xsl:choose>
			<xsl:when test="$opStatus = 'INPUT-AUTHORISE' and $status1 = 'FWD'">
               <xsl:value-of select="b:eventCommon/ns0:today"/>
			   </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:processingDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
   </xsl:template>
   <xsl:template name="originalAmount">
   	  <xsl:if test="b:creditAmount and b:creditAmount != ''">
	      <originalAmount>
	         <xsl:value-of select="b:creditAmount"/>
	      </originalAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="counterpartCurrency">
   	  <xsl:if test="b:debitCurrency and b:debitCurrency != ''">
	      <counterpartCurrency>
		  	 <infra:code>
	         	<xsl:value-of select="b:debitCurrency"/>
			 </infra:code>
	      </counterpartCurrency>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="counterpartOriginalAmount">
      <xsl:if test="b:debitAmount and b:debitAmount != ''">
	      <counterpartOriginalAmount>
	         <xsl:value-of select="b:debitAmount"/>
	      </counterpartOriginalAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="counterpartAccount">
      <xsl:if test="b:debitAcctNo and b:debitAcctNo != '' ">
	      <counterpartAccount>
	         <xsl:value-of select="b:debitAcctNo"/>
	      </counterpartAccount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="extBankAccOwnerName">
   	  <xsl:if test="b:debitCustomer and b:debitCustomer != ''">
	      <extBankAccOwnerName>
	         <xsl:value-of select="b:debitCustomer"/>
	      </extBankAccOwnerName>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="chargedCustomer">
   	  <xsl:if test="b:chargedCustomer and b:chargedCustomer != ''">
	      <chargedCustomer>
	         <xsl:value-of select="b:chargedCustomer"/>
	      </chargedCustomer>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="commissionCode">
      <xsl:if test="b:commissionCode and b:commissionCode != ''">
	      <commissionCode>
		     <xsl:choose>
			 	<xsl:when test="b:commissionCode = 'NONE'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:commissionCode = 'CREDIT LESS CHARGES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:commissionCode = 'DEBIT PLUS CHARGES'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:commissionCode = 'WAIVE'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
			 </xsl:choose>   
	      </commissionCode>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="bankFeeAmount">
      <xsl:if test="b:commissionAmtGroup/b:commissionAmt and b:commissionAmtGroup/b:commissionAmt != ''">
	      <bankFeeAmount>
	         <xsl:value-of select="substring(b:commissionAmtGroup/b:commissionAmt,4)"/>
	      </bankFeeAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="chargeCode">
      <xsl:if test="b:chargeCode and b:chargeCode != ''">
	      <chargeCode>
	         <xsl:choose>
			 	<xsl:when test="b:chargeCode = 'NONE'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:chargeCode = 'CREDIT LESS CHARGES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:chargeCode = 'DEBIT PLUS CHARGES'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:chargeCode = 'WAIVE'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
			 </xsl:choose>  
	      </chargeCode>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="chargeAmount">
      <xsl:if test="b:chargeAmtGroup/b:chargeAmt and b:chargeAmtGroup/b:chargeAmt != ''">
	      <chargeAmount>
	         <xsl:value-of select="substring(b:chargeAmtGroup/b:chargeAmt,4)"/>
	      </chargeAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="totalChargedAmount">
      <xsl:if test="b:totalChargeAmt and b:totalChargeAmt != ''">
	      <totalChargedAmount>
	         <xsl:value-of select="substring(b:totalChargeAmt,4)"/>
	      </totalChargedAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="counterpartAmount">
   	  <xsl:if test="b:amountDebited and b:amountDebited != ''">
	      <counterpartAmount>
	         <xsl:value-of select="substring(b:amountDebited,4)"/>
	      </counterpartAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="fxClientRate">
      <xsl:if test="b:customerRate and b:customerRate != ''">
	      <fxClientRate>
	         <xsl:value-of select="b:customerRate"/>
	      </fxClientRate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="fxMarketRate">
   	  <xsl:if test="b:treasuryRate and b:treasuryRate != ''">
	      <fxMarketRate>
	         <xsl:value-of select="b:treasuryRate"/>
	      </fxMarketRate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="originalNetAmount">
   	  <xsl:if test="b:amountCredited and b:amountCredited != ''">
	      <originalNetAmount>
	         <xsl:value-of select="substring(b:amountCredited,4)"/>
	      </originalNetAmount>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/> 
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="transactionCurrency"/>
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