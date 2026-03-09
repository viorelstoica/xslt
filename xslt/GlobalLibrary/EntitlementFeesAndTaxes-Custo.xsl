<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:corporate="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0 corporate" version="1.0">
	<!-- START of protected area  -->
	<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Core.xsl"/>
	<xsl:decimal-format NaN="0" name="nan2zero"/>
	<xsl:variable name="decimalformatZ" select="'0.#################'"/>
	<xsl:template name="BP5">
		<xsl:variable name="stampAccCcy" select="b:stampAccCcy"/>
		<xsl:variable name="stampAccCcyNb">
			<xsl:value-of select="format-number(b:stampAccCcy,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:param name="sumManTaxAcyNb"/>
		<xsl:param name="sumScAmtAcyNb"/>
		<xsl:param name="currencyFT"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$sumManTaxAcyNb + $sumScAmtAcyNb + $stampAccCcyNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currencyFT"/>
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
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
