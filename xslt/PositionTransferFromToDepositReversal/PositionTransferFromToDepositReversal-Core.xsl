<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferFromToDepositReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferFromToDepositReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferFromToDepositReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferFromToDepositReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="newQuantity">
		<newQuantity>
			<xsl:value-of select="b:noNominal"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount">
		<newSecurityDepositaryAccount>
			<infra:code>
				<xsl:value-of select="../b:depositoryTo"/>
			</infra:code>
		</newSecurityDepositaryAccount>
	</xsl:template>
	<xsl:template name="oldSecurity">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAcct"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>1</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="index" select="@index"/>
		<reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:value-of select="concat(../b:tapOperCode,'_','ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
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
		<xsl:variable name="index" select="@index"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:value-of select="concat(../b:tapOperCode,'_','ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic,'_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic,'_R')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="adjustmentCounter"/>
	<xsl:template name="adjustmentNature"/>
	<xsl:template name="adjustmentPortfolio"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="communication"/>
	<xsl:template name="initiator"/>
	<xsl:template name="newSecurity"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate"/>
	<xsl:template name="newSecurityNetAmount"/>
	<xsl:template name="newSecurityPositionCriteria1"/>
	<xsl:template name="newSecurityPositionCriteria2"/>
	<xsl:template name="newSecurityPositionCriteria3"/>
	<xsl:template name="newSecurityPositionCurrency"/>
	<xsl:template name="notepad"/>
	<xsl:template name="oldCcyGrossAmount"/>
	<xsl:template name="oldCcyNetAmount"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="oldPrice"/>
	<xsl:template name="oldQuantity"/>
	<xsl:template name="oldSecurityDepositaryAccount"/>
	<xsl:template name="oldSecurityPositionCriteria1"/>
	<xsl:template name="oldSecurityPositionCriteria2"/>
	<xsl:template name="oldSecurityPositionCriteria3"/>
	<xsl:template name="oldSecurityPositionCurrency"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="subType"/>
	<xsl:template name="supplementaryAmount"/>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../b:tradeDate"/>
		</transactionDate>
   </xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="valueDate">
	<valueDate>
      <xsl:value-of select="../b:valueDate"/>
    </valueDate>
   </xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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