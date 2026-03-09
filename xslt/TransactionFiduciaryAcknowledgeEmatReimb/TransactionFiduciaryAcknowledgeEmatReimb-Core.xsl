<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="account1">
		<xsl:variable name="index" select="@index"/>
		<account1>
			<infra:code>
				<xsl:value-of select="../b:fdFidOrderDrawDownAcctList/b:fdFidOrderDrawDownAcct[@index=$index]"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="accountingDate">
		<xsl:variable name="index" select="@index"/>
		<accountingDate>
			<xsl:choose>
				<xsl:when test="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index] and ../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]!=''">
					<xsl:value-of select="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:fdFidOrderPrinChangeGroup[@index=$index]/b:fdFidOrderPrinChangeSubGroup[position()=last()]/b:fdFidOrderChangeDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="deposit">
		<xsl:variable name="index" select="@index"/>
		<deposit>
			<infra:code>
				<xsl:value-of select="concat(../b:orderNosGroup[@index=$index]/b:orderNos,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="portfolio">
		<xsl:variable name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:fdFidOrderCusPortIdList/b:fdFidOrderCusPortId[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'PLACED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="index" select="@index"/>
		<transactionCode>
			<xsl:value-of select="translate(../b:fdFidOrderTapRefIdList/b:fdFidOrderTapRefId[@index=$index], '%', '_')"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:variable name="index" select="@index"/>
		<transactionDate>
			<xsl:choose>
				<xsl:when test="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index] and ../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]!=''">
					<xsl:value-of select="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:fdFidOrderPrinChangeGroup[@index=$index]/b:fdFidOrderPrinChangeSubGroup[position()=last()]/b:fdFidOrderChangeDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
       <type>
           <infra:code>FD_MATRE</infra:code>
       </type>      
    </xsl:template>
	<xsl:template name="valueDate">
		<xsl:variable name="index" select="@index"/>
		<valueDate>
			<xsl:choose>
				<xsl:when test="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index] and ../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]!=''">
					<xsl:value-of select="../b:fdFidOrderEarlyMatDateList/b:fdFidOrderEarlyMatDate[@index=$index]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:fdFidOrderPrinChangeGroup[@index=$index]/b:fdFidOrderPrinChangeSubGroup[position()=last()]/b:fdFidOrderChangeDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</valueDate>
	</xsl:template>
	<xsl:template name="depositAmount">
		<xsl:variable name="index" select="@index"/>
		<depositAmount>
			<xsl:value-of select="../b:fdFidOrderAmountList/b:fdFidOrderAmount[@index=$index]"/>
		</depositAmount>
	</xsl:template>
	<xsl:template name="account1CcyDepositCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDepositCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDepositCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="depositCurrency">
		<depositCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</depositCurrency>
	</xsl:template>
	<xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="referenceTransactionCode"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="referenceNature"/>
	<xsl:template name="depositInterestRate"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="renewalAmount"/>
	<xsl:template name="renewalEndDate"/>
	<xsl:template name="renewalInterestrate"/>
	<xsl:template name="renewalMode"/>
	<xsl:template name="renewalPeriod"/>
	<xsl:template name="renewalPeriodNumber"/>
	<xsl:template name="renewalTreatment"/>
	<xsl:template name="lockNature"/>
	<xsl:template name="interestAmount"/>
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