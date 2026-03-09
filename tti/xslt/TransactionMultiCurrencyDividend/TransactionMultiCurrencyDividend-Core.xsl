<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:choose>
               <xsl:when test="../b:qualifyHolding = b:optionNom">
                  <xsl:value-of select="../b:accountNo"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:divCcyAccount"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:choose>
            <xsl:when test="../b:qualifyHolding = b:optionNom">
               <xsl:value-of select="../b:netAmtAccCur"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:netAmtCuDivCcy"/>
            </xsl:otherwise>
         </xsl:choose>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="../b:PayDateJoin"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"><!-- Avoid empty values when 0 -->
      <xsl:variable name="decimalformatZ" select="'0.########################################'"/><!-- Ensure parameter values are not NaN -->
      <xsl:variable name="sourceTaxDivCcyNb">
         <xsl:value-of select="format-number(b:sourceTaxDivCcy,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="localTaxDivCcyNb">
         <xsl:value-of select="format-number(b:localTaxDivCcy,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="commDivCcyNb">
         <xsl:value-of select="format-number(b:commDivCcy,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="commTaxAmtDivCcyNb">
         <xsl:value-of select="format-number(b:commTaxAmtDivCcy,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="othChgTaxDivCcyNb">
         <xsl:value-of select="format-number(b:othChgTaxDivCcy,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="optTaxCreditNb">
         <xsl:value-of select="format-number(b:optTaxCredit,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="sourceTaxAmtNb">
         <xsl:value-of select="format-number(../b:sourceTaxAmt,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="localTaxAmtNb">
         <xsl:value-of select="format-number(../b:localTaxAmtList/b:localTaxAmt,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="commissionAmtNb">
         <xsl:value-of select="format-number(../b:commissionAmt,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="commTaxAmtNb">
         <xsl:value-of select="format-number(../b:commTaxAmt,$decimalformatZ,'nan2zero')"/>
      </xsl:variable>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP1'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="../b:qualifyHolding = b:optionNom">
                  <xsl:value-of select="$sourceTaxAmtNb + $localTaxAmtNb"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="$sourceTaxDivCcyNb + $localTaxDivCcyNb"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP2'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP3'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:choose>
               <xsl:when test="../b:qualifyHolding = b:optionNom">
                  <xsl:value-of select="$commissionAmtNb + $commTaxAmtNb"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="$commDivCcyNb + $commTaxAmtDivCcyNb"/>
               </xsl:otherwise>
            </xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP4'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP5'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP6'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="$othChgTaxDivCcyNb"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP7'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP8'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
		 	<xsl:variable name="index" select="@index"/>
		 	<xsl:choose>
         		<xsl:when test="../b:qualifyHolding = b:optionNom">
            		<xsl:value-of select="b:optTaxCredit"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="../b:taxCreditDivCcyList/b:taxCreditDivCcy[@index = $index] != ''">
							<xsl:value-of select="../b:taxCreditDivCcyList/b:taxCreditDivCcy[@index = $index]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP9'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
      <transactionFeesTaxesCounter>
         <amount>
            <xsl:value-of select="'0'"/>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:optCurrency"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                  <xsl:with-param name="boBP" select="'BP10'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="Index" select="@index"/>
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
				<xsl:choose>
					<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
						<xsl:value-of select="concat(../b:tapRefId,'_R')"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_',$Index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
               			<xsl:value-of select="concat(../b:entitlementId,'_',$Index,'_R',$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
            <xsl:otherwise>
				<xsl:choose>
					<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
						<xsl:value-of select="../b:tapRefId"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_', ../b:entitlementId,'_',$Index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
               			<xsl:value-of select="concat(../b:entitlementId,'_',$Index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
            		</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="depositaryAccount">
      <xsl:choose>
   		<xsl:when test="../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../b:subAccount != ''">
					<xsl:value-of select="concat(../b:depository,'_',../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
   </xsl:template>
   <xsl:template name="coaReference">
      <coaReference>
         <xsl:value-of select="../b:diaryId"/>
      </coaReference>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="../b:securityNo"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="dividendCurrency">
      <dividendCurrency>
         <infra:code>
            <xsl:value-of select="b:optCurrency"/>
         </infra:code>
      </dividendCurrency>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:value-of select="../b:PayDateJoin"/>
      </transactionDate>
   </xsl:template>
   <xsl:template name="dividendCcyGrossAmount">
      <xsl:choose>
         <xsl:when test="../b:qualifyHolding = b:optionNom">
            <xsl:if test="b:entitlementAmt !='' and b:optTaxCredit !=''">
               <dividendCcyGrossAmount>
			   	  <xsl:value-of select="format-number(b:entitlementAmt + b:optTaxCredit,$decimalformat,'nan2zero')"/>
               </dividendCcyGrossAmount>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
		 	<xsl:if test="b:entAmtDivCcy !='' and ../b:taxCreditDivCcyList/b:taxCreditDivCcy !=''">
			<xsl:variable name="index" select="@index"/>
               <dividendCcyGrossAmount>
			   	  <xsl:value-of select="format-number(b:entAmtDivCcy + ../b:taxCreditDivCcyList/b:taxCreditDivCcy[@index = $index],$decimalformat,'nan2zero')"/>
               </dividendCcyGrossAmount>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="dividendCcyNetAmount">
      <xsl:choose>
         <xsl:when test="../b:qualifyHolding = b:optionNom">
            <xsl:if test="../b:netAmount !=''">
               <dividendCcyNetAmount>
                  <xsl:value-of select="../b:netAmount"/>
               </dividendCcyNetAmount>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:if test="b:netAmtCuDivCcy != ''">
               <dividendCcyNetAmount>
                  <xsl:value-of select="b:netAmtCuDivCcy"/>
               </dividendCcyNetAmount>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="nominalOrUnit">
      <nominalOrUnit>
         <xsl:value-of select="b:optionNom"/>
      </nominalOrUnit>
   </xsl:template>
   <xsl:template name="cashDividend">
      <cashDividend>
         <xsl:value-of select="b:optCcyDivRate"/>
      </cashDividend>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <xsl:variable name="Index" select="@index"/>
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
         <reversalIndicator>
            <xsl:value-of select="'1'"/>
         </reversalIndicator>
         <reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../b:tapRefId and (../b:tapRefId != '' or ../b:tapRefId != 'NULL')">
						<xsl:value-of select="../b:tapRefId"/>
					</xsl:when>
					<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
						<xsl:value-of select="concat(../b:tapOperCode, '_',../b:entitlementId,'_',$Index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
            			<xsl:value-of select="concat(../b:entitlementId,'_',$Index,$COMPANY_POSTFIX_SEPARATOR,../b:CompanyMnemonicJoin)"/>
         			</xsl:otherwise>
				</xsl:choose>
		 </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="../b:entitlementId"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat('ENT_',../b:eventType)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="../b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="account1CcyDividendCcyExchangeRate"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyDividendCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyDividendCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="dividendCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="securityCcyNetAmount"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="subType"/>
   <xsl:template name="typeInstrument"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="positionCriteria1">
   	<positionCriteria1>
		<xsl:call-template name="extCustodianTranslation">
			<xsl:with-param name="boExtCustodian">
				<xsl:value-of select="../b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</positionCriteria1>
   </xsl:template>
   <xsl:template name="mbFields"/>
   <xsl:template name="exDate">
	    <exDate>
			<xsl:value-of select="../b:diaryExDate"/>
		</exDate>
	</xsl:template>
   <xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
   </xsl:template>
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