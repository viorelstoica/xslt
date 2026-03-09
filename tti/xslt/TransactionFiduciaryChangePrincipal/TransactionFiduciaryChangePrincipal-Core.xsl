<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">




	<!--Deposit Capital Increase Templates-->
	<xsl:template name="account1_I">
		<xsl:param name="index"/>
		<account1>
			<infra:code>
				<xsl:if test="not(../../b:fdFidOrderPrinLiqAcctList/b:fdFidOrderPrinLiqAcct[@index=$index]) or ../../b:fdFidOrderPrinLiqAcctList/b:fdFidOrderPrinLiqAcct[@index=$index] != ''">
					<xsl:value-of select="../../b:fdFidOrderDrawDownAcctList/b:fdFidOrderDrawDownAcct[@index=$index]"/>
				</xsl:if>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDepositCcyExchangeRate_I"/>
	<xsl:template name="account1NetAmount_I"/>
	<xsl:template name="account2_I"/>
	<xsl:template name="account2CcyDepositCcyExchangeRate_I"/>
	<xsl:template name="account2NetAmount_I"/>
	<xsl:template name="account3_I"/>
	<xsl:template name="account3CcyDepositCcyExchangeRate_I"/>
	<xsl:template name="account3NetAmount_I"/>
	<xsl:template name="accountingCode_I"/>
	<xsl:template name="accountingDate_I">
		<accountingDate>
			<xsl:value-of select="../b:changeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_I"/>
	<xsl:template name="commonReference_I"/>
	<xsl:template name="contractNumber_I"/>
	<xsl:template name="counterparty_I"/>
	<xsl:template name="deposit_I">
		<xsl:param name="orderId"/>
		<deposit>
			<infra:code>
				<xsl:value-of select="concat($orderId, $COMPANY_POSTFIX_SEPARATOR, ../../b:companyMnemonic)"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="depositCurrency_I">
		<depositCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currency"/>
			</infra:code>
		</depositCurrency>
	</xsl:template>
	<xsl:template name="depositCcyPortfolioCcyExchangeRate_I"/>
	<xsl:template name="fusionRule_I"/>
	<xsl:template name="initiatedBy_I"/>
	<xsl:template name="initiator_I"/>
	<xsl:template name="notepad_I"/>
	<xsl:template name="portfolio_I">
		<xsl:param name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:fdFidOrderCusPortIdList/b:fdFidOrderCusPortId[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_I"/>
	<xsl:template name="remark_I"/>
	<xsl:template name="referenceTransactionCode_I"/>
	<xsl:template name="reversalIndicator_I"/>
	<xsl:template name="reversedTransactionCode_I"/>
	<xsl:template name="sourceSystemCode_I"/>
	<xsl:template name="status_I">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_I"/>
	<xsl:template name="trader_I"/>
	<xsl:template name="transactionCode_I">
		<xsl:param name="orderId"/>
		<transactionCode>
			<xsl:value-of select="concat(../../b:id, translate(../b:changeDate, '-', ''), $orderId, $COMPANY_POSTFIX_SEPARATOR, ../../b:companyMnemonic)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_I">
		<transactionDate>
			<xsl:value-of select="../b:changeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_I"/>
    <xsl:template name="type_I">
       <type>
           <infra:code>FD_PRINC</infra:code>
       </type>  
    </xsl:template>
	<xsl:template name="valueDate_I">
		<valueDate>
			<xsl:value-of select="../b:changeDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_I"/>
	<xsl:template name="mbFields_I"/>
	<xsl:template name="accruedInterestAmount_I">
		<accruedInterestAmount>0</accruedInterestAmount>
	</xsl:template>
	<xsl:template name="depositCapitalIncrease_I">
		<depositCapitalIncrease>
			<xsl:value-of select="b:prinChange"/>
		</depositCapitalIncrease>
	</xsl:template>
	<xsl:template name="depositInterestRate_I"/>
	<xsl:template name="expirationDate_I"/>
	<xsl:template name="referenceNature_I"/>
	<xsl:template name="renewalAmount_I"/>
	<xsl:template name="renewalEndDate_I"/>
	<xsl:template name="renewalInterestRate_I"/>
	<xsl:template name="renewalMode_I"/>
	<xsl:template name="renewalPeriod_I"/>
	<xsl:template name="renewalPeriodNumber_I"/>
	<xsl:template name="renewalTreatment_I"/>

	<!--Deposit Capital Decrease Templates-->
	<xsl:template name="account1_D">
		<xsl:param name="index"/>
		<account1>
			<infra:code>
				<xsl:if test="not(../../b:fdFidOrderPrinLiqAcctList/b:fdFidOrderPrinLiqAcct[@index=$index]) or ../../b:fdFidOrderPrinLiqAcctList/b:fdFidOrderPrinLiqAcct[@index=$index] != ''">
					<xsl:value-of select="../../b:fdFidOrderDrawDownAcctList/b:fdFidOrderDrawDownAcct[@index=$index]"/>
				</xsl:if>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDepositCcyExchangeRate_D"/>
	<xsl:template name="account1NetAmount_D"/>
	<xsl:template name="account2_D"/>
	<xsl:template name="account2CcyDepositCcyExchangeRate_D"/>
	<xsl:template name="account2NetAmount_D"/>
	<xsl:template name="account3_D"/>
	<xsl:template name="account3CcyDepositCcyExchangeRate_D"/>
	<xsl:template name="account3NetAmount_D"/>
	<xsl:template name="accountingCode_D"/>
	<xsl:template name="accountingDate_D">
		<accountingDate>
			<xsl:value-of select="../b:changeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_D"/>
	<xsl:template name="commonReference_D"/>
	<xsl:template name="contractNumber_D"/>
	<xsl:template name="counterparty_D"/>
	<xsl:template name="deposit_D">
		<xsl:param name="orderId"/>
		<deposit>
			<infra:code>
				<xsl:value-of select="concat($orderId, $COMPANY_POSTFIX_SEPARATOR, ../../b:companyMnemonic)"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="depositCurrency_D">
		<depositCurrency>
			<infra:code>
				<xsl:value-of select="../../b:currency"/>
			</infra:code>
		</depositCurrency>
	</xsl:template>
	<xsl:template name="depositCcyPortfolioCcyExchangeRate_D"/>
	<xsl:template name="fusionRule_D"/>
	<xsl:template name="initiatedBy_D"/>
	<xsl:template name="initiator_D"/>
	<xsl:template name="notepad_D"/>
	<xsl:template name="portfolio_D">
		<xsl:param name="index" select="@index"/>
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:fdFidOrderCusPortIdList/b:fdFidOrderCusPortId[@index=$index]"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_D"/>
	<xsl:template name="remark_D"/>
	<xsl:template name="referenceTransactionCode_D"/>
	<xsl:template name="reversalIndicator_D"/>
	<xsl:template name="reversedTransactionCode_D"/>
	<xsl:template name="sourceSystemCode_D"/>
	<xsl:template name="status_D">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_D"/>
	<xsl:template name="trader_D"/>
	<xsl:template name="transactionCode_D">
		<xsl:param name="orderId"/>
		<transactionCode>
			<xsl:value-of select="concat(../../b:id, translate(../b:changeDate, '-', ''), $orderId, $COMPANY_POSTFIX_SEPARATOR, ../../b:companyMnemonic)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate_D">
		<transactionDate>
			<xsl:value-of select="../b:changeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_D"/>
    <xsl:template name="type_D">
       <type>
           <infra:code>FD_PRINC</infra:code>
       </type>  
    </xsl:template>
	<xsl:template name="valueDate_D">
		<valueDate>
			<xsl:value-of select="../b:changeDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField_D"/>
	<xsl:template name="mbFields_D"/>
	<xsl:template name="accruedInterestAmount_D">
		<accruedInterestAmount>0</accruedInterestAmount>
	</xsl:template>
	<xsl:template name="depositCapitalDecrease_D">
		<depositCapitalDecrease>
			<xsl:value-of select="format-number(-1 * (b:prinChange),$decimalformat,'nan2zero')"/>
		</depositCapitalDecrease>
	</xsl:template>
	<xsl:template name="expirationDate_D"/>
	<xsl:template name="depositInterestRate_D"/>
	<xsl:template name="referenceNature_D"/>
	<xsl:template name="renewalAmount_D"/>
	<xsl:template name="renewalEndDate_D"/>
	<xsl:template name="renewalInterestRate_D"/>
	<xsl:template name="renewalMode_D"/>
	<xsl:template name="renewalPeriod_D"/>
	<xsl:template name="renewalPeriodNumber_D"/>
	<xsl:template name="renewalTreatment_D"/>
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