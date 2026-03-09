<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="BP1">
		<xsl:variable name="totalAmount" select="sum(
            b:cuChargeTaxTypeGroup[
                b:cuChargeTaxType = 'STAMP.DUTY.CU' 
            ]/b:cuChargeTaxAmt
        )"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="not($totalAmount) or $totalAmount = 0">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$totalAmount"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:securityCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'FOREIGN_FEE'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BP2">
		<xsl:variable name="amount">
			<xsl:variable name="amtNode" select="sum(b:cuChargeTaxTypeGroup[b:cuChargeTaxType = 'VAT.BNK.COMMISS' or b:cuChargeTaxType = 'VAT.THIRD.BROKER']/b:cuChargeTaxAmt)"/>
			<!--xsl:value-of select="format-number($amtNode,$decimalformat,'nan2zero')"/-->
			<xsl:value-of select="format-number($amtNode,$decimalformat,'nan2zero')"/>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:securityCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'LOCAL_TAX'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<!--xsl:template name="BP3">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="b:securityCcy"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:value-of select="'BROKER_COMMISSION'"/>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template> -->
	<xsl:template name="BP4">
		<xsl:variable name="totalAmount1" select="sum(
            b:cuChargeTaxTypeGroup[
                b:cuChargeTaxType = 'BANK.COMMISSION' 
            ]/b:cuChargeTaxAmt
        )"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="not($totalAmount1) or $totalAmount1 = 0">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$totalAmount1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:securityCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'BANK_COMMISSION'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<!-- <xsl:template name="BP5">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="format-number(sum(*[local-name() = 'cuTax']|*[local-name() = 'cuStampTax']),$decimalformat,'nan2zero')"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="b:securityCcy"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:value-of select="'STAMP_AND_COMM_TAX'"/>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP6">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="b:securityCcy"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:value-of select="'SUBSCR_REDEMP'"/>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template> -->
	<xsl:template name="BP7">
		<xsl:variable name="totalAmount2" select="sum(
            b:cuChargeTaxTypeGroup[
                b:cuChargeTaxType = 'CU.FEES.MISC' 
            ]/b:cuChargeTaxAmt
        )"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="not($totalAmount2) or $totalAmount2 = 0">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$totalAmount2"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:securityCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'OTHER'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<!-- <xsl:template name="BP8">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="b:securityCcy"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:value-of select="'DISCOUNT_REALLOW'"/>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template> -->
	<xsl:template name="BP9">
		<xsl:variable name="additionalAmount" select="sum(
            b:cuTaxTypeGroup[
                b:cuTaxType = 'FDR'
            ]/b:cuTaxTcy
        )"/>
		<xsl:variable name="totalAmount3" select="sum(
            b:cuChargeTaxTypeGroup[
                b:cuChargeTaxType = 'ISS.DISC.REV.TAX'
            ]/b:cuChargeTaxAmt
        )+ $additionalAmount"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="not($totalAmount3) or $totalAmount3 = 0">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$totalAmount3"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:securityCcy"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'WITH_TAX'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>