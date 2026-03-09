<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecuritySellReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:param name="list_SubAssetType" select="'301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699'"/>
   <xsl:param name="list_TransCode" select="'SEL SSL FRD FSO MFR'"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
		  <xsl:choose>
	  	   <xsl:when test="../../b:tapSleevePtf != ''">
			 <xsl:value-of select="../../b:tapSleevePtf"/>
		   </xsl:when>
		   <xsl:otherwise>
        	 <xsl:value-of select="../b:custSecAcc"/>
		   </xsl:otherwise>
		 </xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="boPortfolio">
      <boPortfolio>
         <infra:code>
            <xsl:if test="../../b:tapSleevePtf != ''">
				 <xsl:value-of select="../b:custSecAcc"/>
		   </xsl:if>
         </infra:code>
      </boPortfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <reversalIndicator>1</reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode">
      <reversedTransactionCode>
         <xsl:choose>
			<xsl:when test="starts-with(../../b:tapRefId,'X')">
				<xsl:value-of select="../../b:tapRefId"/>
			</xsl:when>
			<xsl:when test="substring(../../b:tapRefId,string-length(../../b:tapRefId)-3) = '-RHT'">
				<xsl:value-of select="substring-before(../../b:tapRefId,'-RHT')"/>
			</xsl:when>			
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		 </xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:choose>
			<xsl:when test="starts-with(../../b:tapRefId,'X')">
				<xsl:value-of select="concat(../../b:tapRefId,'_R')"/>
			</xsl:when>
			<xsl:when test="substring(../../b:tapRefId,string-length(../../b:tapRefId)-3) = '-RHT'">
				<xsl:value-of select="concat(substring-before(../../b:tapRefId,'-RHT'),'_R')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>    
      </transactionCode>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="../b:custTotNom"/>
      </quantity>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="../../b:securityCode"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../../b:id"/>
		</sourceSystemCode>
	</xsl:template>
   <xsl:template name="account1"/>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type"/>
   <xsl:template name="valueDate">
	<valueDate>
      <xsl:value-of select="../../b:valueDate"/>
    </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accountCurrency"/>
   <xsl:template name="accruedInterests"/>
   <xsl:template name="accruedInterestCounter"/>
   <xsl:template name="broker"/>
   <xsl:template name="compoundOrderCode"/>
   <xsl:template name="compoundOrderMaster"/>
   <xsl:template name="compoundOrderSlave"/>
   <xsl:template name="contactMethod"/>
   <xsl:template name="depositaryAccount"/>
   <xsl:template name="exCoupon"/>
   <xsl:template name="executionSetCriteria"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="limitPrice"/>
   <xsl:template name="orderType"/>
   <xsl:template name="orderValidityType"/>
   <xsl:template name="originalOrderCode"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="price"/>
   <xsl:template name="securityCcyNetAmount"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="stopPrice"/>
   <xsl:template name="targetAmount"/>
   <xsl:template name="targetNature"/>
   <xsl:template name="targetObjective"/>
   <xsl:template name="trader"/>
   <xsl:template name="tradeCurrency"/>
   <xsl:template name="tradeCcyGrossAmount"/>
   <xsl:template name="tradeCcyNetAmount"/>
   <xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="tradeDate">
   	<tradeDate>
      <xsl:value-of select="../../b:tradeDate"/>
    </tradeDate>
   </xsl:template>
   <xsl:template name="validityDate"/>
   <xsl:template name="hierOperNature">
	  	<xsl:if test="../../b:tapHierOrder and ../../b:tapHierOrder !=''">
			<hierOperNature>
				<xsl:value-of select="../../b:tapHierOrder"/>
			</hierOperNature>
		</xsl:if>
  	</xsl:template>
   <xsl:template name="accountingDate_transferIn">
      <accountingDate>
         <xsl:value-of select="../../b:tradeDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio_transferIn">
      <xsl:param name="index"/>
      <portfolio>
         <infra:code>
		 <xsl:choose>
		 	<xsl:when test="../../b:portfolioNoJoinGroup/b:portfolioNoJoinList/b:portfolioNoJoin[$index]">
				<xsl:value-of select="../../b:portfolioNoJoinGroup/b:portfolioNoJoinList/b:portfolioNoJoin[$index]"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="../../b:samHistIdJoinList/b:samHistIdJoin[$index]"/>
			</xsl:otherwise>
         </xsl:choose>
		 </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator_transferIn">
      <reversalIndicator>
         <xsl:value-of select="'1'"/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode_transferIn">
      <reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="status_transferIn">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode_transferIn">
      <transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
				</xsl:otherwise>
			</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="currentAccount_transferIn">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="../b:cuIncomeAcc"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="quantity_transferIn">
      <quantity>
         <xsl:value-of select="../b:cuIncomeAmt"/>
      </quantity>
   </xsl:template>
   <xsl:template name="sourceSystemCode_transferIn">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
   <xsl:template name="account1_transferIn"/>
   <xsl:template name="account1CcyTradeCcyExchangeRate_transferIn"/>
   <xsl:template name="account1NetAmount_transferIn"/>
   <xsl:template name="account2_transferIn"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate_transferIn"/>
   <xsl:template name="account2NetAmount_transferIn"/>
   <xsl:template name="account3_transferIn"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate_transferIn"/>
   <xsl:template name="account3NetAmount_transferIn"/>
   <xsl:template name="accountingCode_transferIn"/>
   <xsl:template name="cashPortfolio_transferIn"/>
   <xsl:template name="commonReference_transferIn"/>
   <xsl:template name="ContractNumber_transferIn"/>
   <xsl:template name="intermediary_transferIn"/>
   <xsl:template name="market_transferIn"/>
   <xsl:template name="notepad_transferIn"/>
   <xsl:template name="portfolioManager_transferIn"/>
   <xsl:template name="remark_transferIn"/>
   <xsl:template name="subType_transferIn"/>
   <xsl:template name="transactionFeesTaxesCounter_transferIn"/>
   <xsl:template name="type_transferIn"/>
   <xsl:template name="valueDate_transferIn">
   	<valueDate>
      <xsl:value-of select="../../b:valueDate"/>
    </valueDate>
	</xsl:template>
   <xsl:template name="userDefinedField_transferIn"/>
   <xsl:template name="mbFields_transferIn"/>
   <xsl:template name="transactionCcyGrossAmount_transferIn"/>
   <xsl:template name="transactionCcyNetAmount_transferIn"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate_transferIn"/>
   <xsl:template name="transactionCurrency_transferIn"/>
   <xsl:template name="transactionDate_transferIn">
	    <transactionDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</transactionDate>
   </xsl:template>
   <xsl:template name="accountingDate_transferOut">
      <accountingDate>
         <xsl:value-of select="../../b:tradeDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio_transferOut">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:custSecAcc"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator_transferOut">
      <reversalIndicator>
         <xsl:value-of select="'1'"/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode_transferOut">
      <reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="status_transferOut">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode_transferOut">
      <transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_R')"/>
				</xsl:otherwise>
			</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="currentAccount_transferOut">
      <currentAccount>
         <infra:code>
            <xsl:value-of select="../b:cuIncomeAcc"/>
         </infra:code>
      </currentAccount>
   </xsl:template>
   <xsl:template name="quantity_transferOut">
      <quantity>
         <xsl:value-of select="../b:cuIncomeAmt"/>
      </quantity>
   </xsl:template>
   <xsl:template name="sourceSystemCode_transferOut">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
   <xsl:template name="account1_transferOut"/>
   <xsl:template name="account1CcyTradeCcyExchangeRate_transferOut"/>
   <xsl:template name="account1NetAmount_transferOut"/>
   <xsl:template name="account2_transferOut"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate_transferOut"/>
   <xsl:template name="account2NetAmount_transferOut"/>
   <xsl:template name="account3_transferOut"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate_transferOut"/>
   <xsl:template name="account3NetAmount_transferOut"/>
   <xsl:template name="accountingCode_transferOut"/>
   <xsl:template name="cashPortfolio_transferOut"/>
   <xsl:template name="commonReference_transferOut"/>
   <xsl:template name="ContractNumber_transferOut"/>
   <xsl:template name="intermediary_transferOut"/>
   <xsl:template name="market_transferOut"/>
   <xsl:template name="notepad_transferOut"/>
   <xsl:template name="portfolioManager_transferOut"/>
   <xsl:template name="remark_transferOut"/>
   <xsl:template name="subType_transferOut"/>
   <xsl:template name="transactionFeesTaxesCounter_transferOut"/>
   <xsl:template name="type_transferOut"/>
   <xsl:template name="valueDate_transferOut">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
   <xsl:template name="userDefinedField_transferOut"/>
   <xsl:template name="mbFields_transferOut"/>
   <xsl:template name="transactionCcyGrossAmount_transferOut"/>
   <xsl:template name="transactionCcyNetAmount_transferOut"/>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate_transferOut"/>
   <xsl:template name="transactionCurrency_transferOut"/>
   <xsl:template name="transactionDate_transferOut">
   	<transactionDate>
		<xsl:value-of select="../../b:tradeDate"/>
	</transactionDate>
   </xsl:template>
   <xsl:template name="account1_switchfee"/>
   <xsl:template name="account1CcyTradeCcyExchangeRate_switchfee"/>
   <xsl:template name="account1NetAmount_switchfee"/>
   <xsl:template name="account2_switchfee"/>
   <xsl:template name="accountingDate_switchfee"/>
   <xsl:template name="transactionFeesTaxesCounter_switchfee"/>
   <xsl:template name="transactionCode_switchfee">
      <transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,'_',.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F','_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F','_R')"/>
				</xsl:otherwise>
			</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="commonReference_switchfee"/>
   <xsl:template name="contactMethod_switchfee"/>
   <xsl:template name="depositaryAccount_switchfee"/>
   <xsl:template name="security_switchfee">
      <security>
         <infra:code>
            <xsl:value-of select="../../b:securityCode"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate_switchfee"/>
   <xsl:template name="stockExchange_switchfee"/>
   <xsl:template name="tradeCurrency_switchfee"/>
   <xsl:template name="tradeDate_switchfee">
   	<tradeDate>
      <xsl:value-of select="../../b:tradeDate"/>
    </tradeDate>
   </xsl:template>
   <xsl:template name="tradeCcyPortfolioCcyExchangeRate_switchfee"/>
   <xsl:template name="tradeCcyGrossAmount_switchfee"/>
   <xsl:template name="tradeCcyNetAmount_switchfee"/>
   <xsl:template name="portfolio_switchfee">
      <portfolio>
         <infra:code>
            <xsl:value-of select="."/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity_switchfee">
      <quantity>
         <xsl:value-of select=" '0' "/>
      </quantity>
   </xsl:template>
   <xsl:template name="price_switchfee">
      <price>
         <xsl:value-of select=" '0' "/>
      </price>
   </xsl:template>
   <xsl:template name="remark_switchfee"/>
   <xsl:template name="reversalIndicator_switchfee">
      <reversalIndicator>1</reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode_switchfee">
      <reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',../b:custSecAcc,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F')"/>
				</xsl:otherwise>
			</xsl:choose>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="sourceSystemCode_switchfee">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
   <xsl:template name="status_switchfee">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type_switchfee"/>
   <xsl:template name="valueDate_switchfee">
   		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
   <xsl:template name="notepad_switchfee"/>
   <xsl:template name="subType_switchfee"/>
   <xsl:template name="accruedInterests_switchfee"/>
   <xsl:template name="executionSetCriteria_switchfee"/>
   <xsl:template name="originalOrderCode_switchfee"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate_switchfee"/>
   <xsl:template name="account2NetAmount_switchfee"/>
   <xsl:template name="account3_switchfee"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate_switchfee"/>
   <xsl:template name="account3NetAmount_switchfee"/>
   <xsl:template name="accountingCode_switchfee"/>
   <xsl:template name="cashPortfolio_switchfee"/>
   <xsl:template name="ContractNumber_switchfee"/>
   <xsl:template name="intermediary_switchfee"/>
   <xsl:template name="market_switchfee"/>
   <xsl:template name="portfolioManager_switchfee"/>
   <xsl:template name="userDefinedField_switchfee"/>
   <xsl:template name="mbFields_switchfee"/>
   <xsl:template name="accountCurrency_switchfee"/>
   <xsl:template name="accruedInterestCounter_switchfee"/>
   <xsl:template name="broker_switchfee"/>
   <xsl:template name="compoundOrderCode_switchfee"/>
   <xsl:template name="compoundOrderMaster_switchfee"/>
   <xsl:template name="compoundOrderSlave_switchfee"/>
   <xsl:template name="exCoupon_switchfee"/>
   <xsl:template name="initiatedBy_switchfee"/>
   <xsl:template name="initiator_switchfee"/>
   <xsl:template name="limitPrice_switchfee"/>
   <xsl:template name="orderType_switchfee"/>
   <xsl:template name="orderValidityType_switchfee"/>
   <xsl:template name="positionCriteria1_switchfee"/>
   <xsl:template name="positionCriteria2_switchfee"/>
   <xsl:template name="positionCriteria3_switchfee"/>
   <xsl:template name="securityCcyNetAmount_switchfee"/>
   <xsl:template name="stopPrice_switchfee"/>
   <xsl:template name="targetAmount_switchfee"/>
   <xsl:template name="targetNature_switchfee"/>
   <xsl:template name="targetObjective_switchfee"/>
   <xsl:template name="trader_switchfee"/>
   <xsl:template name="validityDate_switchfee"/>
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