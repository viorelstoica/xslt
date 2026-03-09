<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionOpenDerivativeBuyReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionOpenDerivativeBuyReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionOpenDerivativeBuyReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionOpenDerivativeBuyReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:priSecAccGroup/b:priSecAcc"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>
			<xsl:value-of select="'1'"/>
		</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode,'_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
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
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode,'_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin,'_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin,'_R')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:priSecAccGroup/b:priLots"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoin = 'OTC'">
					<xsl:choose>
						<xsl:when test="b:tapRefId and b:tapRefId != ''">		
							<xsl:value-of select="b:tapRefId"/>		
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldValSubGroup[1]/b:usrFldVal and b:exoticTypeGroup/b:usrFldValSubGroup[2]/b:usrFldVal)">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='1']/b:usrFldVal,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='2']/b:usrFldVal)"/>
						</xsl:when>
						<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldValSubGroup[1]/b:usrFldVal)">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType,'/',b:exoticTypeGroup/b:usrFldValSubGroup[@index='1']/b:usrFldVal)"/>
						</xsl:when>
						<xsl:when test="b:exoticTypeGroup/b:exoticType">
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:exoticTypeGroup/b:exoticType)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1))"/>
						</xsl:otherwise>
					</xsl:choose>																									
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="hedgeTrade">
		<xsl:if test="b:priSecAccGroup/b:priHedgeTrade = 'HEDGE'">
			<hedgeTrade>
				<xsl:value-of select="'1'"/>
			</hedgeTrade>
		</xsl:if>
	</xsl:template>
	<xsl:template name="orderTypeD">
		<xsl:if test="b:priSecAccGroup/b:priStrategy and b:priSecAccGroup/b:priStrategy !=''">
			<orderTypeD>
				<infra:code>
					<xsl:call-template name="orderTypeTranslation">
						<xsl:with-param name="orderType" select="b:priSecAccGroup/b:priStrategy"/>
					</xsl:call-template>
				</infra:code>
			</orderTypeD>
		</xsl:if>
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
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="compundOrderCode"/>
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
	<xsl:template name="paymentOptionE"/>
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
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="validityDate"/>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'OTC' and b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="b:exchangeTypeJoin = 'OTC' and b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceTransactionCode">
		<referenceTransactionCode>
			<xsl:if test="(b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoin = 'NORMAL' and b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (b:exchangeTypeJoin = 'OTC' and b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (b:exchangeTypeJoin = 'OTC' and b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
			</xsl:if>
		</referenceTransactionCode>
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