<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>

	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:fixingDate"/>
		</accountingDate>
	</xsl:template>

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:customerAccount"/>
			</infra:code>
		</account1>
	</xsl:template>

	<xsl:template name="profitLossCounter">
		<profitLossCounter>
			<infra:code>
				<xsl:choose>

					<xsl:when test="./b:settlementAmount &gt; 0">
						<xsl:value-of select="$SY_ACCUDECU_BP_TYPE_CAPITAL_PROFIT"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$SY_ACCUDECU_BP_TYPE_CAPITAL_LOSS"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</profitLossCounter>
	</xsl:template>

	<xsl:template name="originalSecurity">

		<originalSecurity>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../b:tapRefId and ../b:tapRefId!=''">
						<xsl:value-of select="../b:tapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:id,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</originalSecurity>
	</xsl:template>

	<xsl:template name="newInstrumentQuantity">

		<newInstrumentQuantity>
			<xsl:value-of select="./b:settlementAmount"/>
		</newInstrumentQuantity>
	</xsl:template>

	<xsl:template name="transactionCode">

		<transactionCode>
			<xsl:value-of select="concat(../b:id,'.',./b:fixingDate)"/>
		</transactionCode>
	</xsl:template>

	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../b:customerAccount"/>
			</infra:code>
		</security>
	</xsl:template>

	<xsl:template name="positionCurrency">

		<positionCurrency>
			<infra:code>
				<xsl:value-of select="../b:contractCcy"/>
			</infra:code>
		</positionCurrency>
	</xsl:template>

	<xsl:template name="transactionDate">

		<transactionDate>
			<xsl:value-of select="./b:fixingDate"/>
		</transactionDate>
	</xsl:template>

	<xsl:template name="originalInstrumentQuantity">

		<originalInstrumentQuantity>
			<xsl:value-of select="./b:settlementAmount"/>
		</originalInstrumentQuantity>
	</xsl:template>

	<xsl:template name="sourceSystemCode">

		<sourceSystemCode>
			<xsl:value-of select="../b:id"/>
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
		<xsl:choose>
			<xsl:when test="../b:productType = 'ACCUMULATOR'">
				<type>
					<infra:code>
						<xsl:value-of select="'SY_ACCU_CASH_SETTLE'"/>
					</infra:code>
				</type>
			</xsl:when>
			<xsl:otherwise>
				<type>
					<infra:code>
						<xsl:value-of select="'SY_DECU_CASH_SETTLE'"/>
					</infra:code>
				</type>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="./b:fixingDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="quote"/>
	<xsl:template name="referenceNature"/>
	<xsl:template name="referenceOperationCode"/>
	<xsl:template name="adjustmentNature">
	   <adjustmentNature>1</adjustmentNature>
	</xsl:template>
	<xsl:template name="depositaryAccount"/>
	<xsl:template name="originalDepositaryAccount"/>
	<xsl:template name="supplementAmount">
	   <supplementAmount/>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="originalPositionCriteria1"/>
	<xsl:template name="originalPositionCriteria2"/>
	<xsl:template name="originalPositionCriteria3"/>
	<xsl:template name="originalSecurityPositionCurrency"/>
	<xsl:template name="PositionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="trader"/>
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