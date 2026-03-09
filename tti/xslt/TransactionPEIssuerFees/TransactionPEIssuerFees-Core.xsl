<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">


	<xsl:template name="account1CcyFTCcyExchangeRate"/>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:account"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling = 'YES'">
					<xsl:value-of select="sum(../b:chargedAmtSubGroup/b:chargedAmt)"/>
				</xsl:when>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyFTCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyFTCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="feesTaxesCcyPortfolioCcyExchangeRate"/>

	<xsl:template name="feesTaxesCounter">
	<feesTaxesCounter>
	<infra:code>PTF_PE_ISSUER_FEE</infra:code>
	</feesTaxesCounter>
	</xsl:template>

	<xsl:template name="feesTaxesCurrency">
		<feesTaxesCurrency>
			<infra:code>
				<xsl:value-of select="../../b:accountCcy"/>
			</infra:code>
		</feesTaxesCurrency>
	</xsl:template>
	<xsl:template name="feesTaxesAmount">
		<feesTaxesAmount>
			
				<xsl:choose>
					<xsl:when test="$PEWorkflowhandling = 'YES'">
						<xsl:value-of select="sum(../b:chargedAmtSubGroup/b:chargedAmt)"/>
					</xsl:when>
				</xsl:choose>
			
		</feesTaxesAmount>
	</xsl:template>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="quantity"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
	<sourceSystemCode>
			<xsl:value-of select="../../b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
	<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('PTFISSFEE_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,../../b:mnemonic)"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type">
	<type>
	<infra:code>
		<xsl:value-of select="'PE_ISSUER_FEE'"/>
	</infra:code>
	</type>
	</xsl:template>
	<xsl:template name="valueDate">
	<valueDate>
		<xsl:value-of select="../b:valueDate"/>
	</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
</xsl:stylesheet>