<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:accountNo"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyPositionCcyExchangeRate">
      <xsl:if test="b:netAmount != 0">
         <account1CcyPositionCcyExchangeRate>
            <xsl:value-of select="format-number(b:netAmtAccCur div b:netAmount,'#.#########','nan2zero')"/>
         </account1CcyPositionCcyExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:value-of select="format-number(b:netAmtAccCur * (-1),'#.##','nan2zero')"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:PayDateJoin"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
         <reversalIndicator>
            <xsl:value-of select="'1'"/>
         </reversalIndicator>
         <reversedTransactionCode>
		 	<xsl:choose>
			 <xsl:when test="b:tapOperCode and b:tapOperCode != ''">
		 		<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
		 	 </xsl:when>
			 <xsl:otherwise>
            	<xsl:value-of select="concat(b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
			</xsl:otherwise>
			</xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
	  	<xsl:choose>
			<xsl:when test="b:tapOperCode and b:tapOperCode != ''">			
         		<xsl:choose>
            		<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               			<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
            		</xsl:when>
            		<xsl:otherwise>
               			<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
            		</xsl:otherwise>
         		</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
						<xsl:value-of select="concat(b:entitlementId,'_R',$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:entitlementId,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <xsl:call-template name="printEntitlementFeesAndTaxes">
         <xsl:with-param name="sourceTax" select="b:sourceTaxAmt"/>
         <xsl:with-param name="fgnCharges" select="b:fgnChargesAmt"/>
         <xsl:with-param name="foreignChgesTax" select="b:foreignChgesTax"/>
         <xsl:with-param name="sumlocalTaxAmt" select="format-number(sum(b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
         <xsl:with-param name="commission" select="b:commissionAmt"/>
         <xsl:with-param name="commTax" select="b:commTaxAmt"/>
         <xsl:with-param name="sumManTaxAcy" select="format-number(sum(b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
         <xsl:with-param name="sumScAmtAcy" select="format-number(sum(b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
         <xsl:with-param name="currencyFT" select="b:currency"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat('ENT_',b:eventType)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="coaReference">
      <coaReference>
         <xsl:value-of select="b:diaryId"/>
      </coaReference>
   </xsl:template>
   <xsl:template name="newQuantity">
      <newQuantity>
         <xsl:value-of select="b:secNoGroup[@index='2']/b:secNominal"/>
      </newQuantity>
   </xsl:template>
   <xsl:template name="newSecurity">
      <newSecurity>
         <infra:code>
            <xsl:value-of select="b:secNoGroup[@index='2']/b:secNo"/>
         </infra:code>
      </newSecurity>
   </xsl:template>
   <xsl:template name="newSecurityDepositaryAccount">
      <xsl:choose>
   		<xsl:when test="b:depository != ''">
		<newSecurityDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</newSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
   </xsl:template>
   <xsl:template name="oldQuantity">
      <oldQuantity>
         <xsl:value-of select="b:secNoGroup/b:secNominal"/>
      </oldQuantity>
   </xsl:template>
   <xsl:template name="oldSecurity">
      <oldSecurity>
         <infra:code>
            <xsl:value-of select="b:secNoGroup/b:secNo"/>
         </infra:code>
      </oldSecurity>
   </xsl:template>
   <xsl:template name="oldSecurityDepositaryAccount">
      <xsl:choose>
   		<xsl:when test="b:depository != ''">
		<oldSecurityDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</oldSecurityDepositaryAccount>
		</xsl:when>
   </xsl:choose>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:value-of select="b:PayDateJoin"/>
      </transactionDate>
   </xsl:template>
   <xsl:template name="unitaryCostPrice">
      <unitaryCostPrice>0</unitaryCostPrice>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:entitlementId"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyPositionCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyPositionCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="typeInstrument"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="initiator"/>
   <xsl:template name="newSecurityPositionCriteria1"/>
   <xsl:template name="newSecurityPositionCriteria2"/>
   <xsl:template name="newSecurityPositionCriteria3"/>
   <xsl:template name="newSecurityPositionCurrency"/>
   <xsl:template name="oldSecurityPositionCriteria1">
   	<oldSecurityPositionCriteria1>
		<xsl:call-template name="extCustodianTranslation">
			<xsl:with-param name="boExtCustodian">
				<xsl:value-of select="b:extCustodian"/>
			</xsl:with-param>
		</xsl:call-template>
	</oldSecurityPositionCriteria1>
   </xsl:template>
   <xsl:template name="oldSecurityPositionCriteria2"/>
   <xsl:template name="oldSecurityPositionCriteria3"/>
   <xsl:template name="oldSecuritypositionCurrency"/>
   <xsl:template name="exDate">
	    <exDate>
			<xsl:value-of select="b:diaryExDate"/>
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