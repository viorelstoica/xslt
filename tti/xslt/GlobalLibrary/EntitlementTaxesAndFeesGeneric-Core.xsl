<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
 <xsl:decimal-format NaN="0" name="nan2zero"/>
  <xsl:template name="printEntitlementFeesAndTaxes_generic">
    <xsl:param name="sourceTax"/>
    <xsl:param name="fgnCharges"/>
    <xsl:param name="foreignChgesTax"/>
    <xsl:param name="sumlocalTaxAmt"/>
    <xsl:param name="commission"/>
    <xsl:param name="commTax"/>
    <xsl:param name="sumManTaxAcy"/>
    <xsl:param name="sumScAmtAcy"/>
    <xsl:param name="taxCredit"/>
    <xsl:param name="taxRefund"/>
    <xsl:param name="currencyFT"/>
    <!-- Avoid empty values when 0 -->
     <xsl:variable name="decimalformatZ" select="'0.#################'"/>
    <!-- Ensure parameter values are not NaN -->
    <xsl:variable name="sourceTaxNb">
      <xsl:value-of select="format-number($sourceTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="fgnChargesNb">
      <xsl:value-of select="format-number($fgnCharges,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="foreignChgesTaxNb">
      <xsl:value-of select="format-number($foreignChgesTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumlocalTaxAmtNb">
      <xsl:value-of select="format-number($sumlocalTaxAmt,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="commissionNb">
      <xsl:value-of select="format-number($commission,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="commTaxNb">
      <xsl:value-of select="format-number($commTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumManTaxAcyNb">
      <xsl:value-of select="format-number($sumManTaxAcy,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumScAmtAcyNb">
      <xsl:value-of select="format-number($sumScAmtAcy,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="taxCreditNb">
      <xsl:value-of select="format-number($taxCredit,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="taxRefundNb">
      <xsl:value-of select="format-number($taxRefund,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:call-template name="BP1">
      <xsl:with-param name="fgnChargesNb" select="$fgnChargesNb"/>
      <xsl:with-param name="foreignChgesTaxNb" select="$foreignChgesTaxNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP2">
      <xsl:with-param name="sourceTaxNb" select="$sourceTaxNb"/>
      <xsl:with-param name="sumlocalTaxAmtNb" select="$sumlocalTaxAmtNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP3">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP4">
      <xsl:with-param name="commissionNb" select="$commissionNb"/>
      <xsl:with-param name="commTaxNb" select="$commTaxNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP5">
      <xsl:with-param name="sumManTaxAcyNb" select="$sumManTaxAcyNb"/>
      <xsl:with-param name="sumScAmtAcyNb" select="$sumScAmtAcyNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP6">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP7">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP8">
      <xsl:with-param name="taxRefundNb" select="$taxRefundNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP9">
      <xsl:with-param name="taxCreditNb" select="$taxCreditNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
    <xsl:call-template name="BP10">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="BP1">
    <xsl:param name="fgnChargesNb"/>
    <xsl:param name="foreignChgesTaxNb"/>
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$fgnChargesNb + $foreignChgesTaxNb"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP2">
    <xsl:param name="sourceTaxNb"/>
    <xsl:param name="sumlocalTaxAmtNb"/>
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$sourceTaxNb + $sumlocalTaxAmtNb"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP3">
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP4">
    <xsl:param name="commissionNb"/>
    <xsl:param name="commTaxNb"/>
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$commissionNb + $commTaxNb"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP5">
    <xsl:param name="sumManTaxAcyNb"/>
    <xsl:param name="sumScAmtAcyNb"/>
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$sumManTaxAcyNb + $sumScAmtAcyNb"/>
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
  <xsl:template name="BP6">
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP7">
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP8">
    <xsl:param name="currencyFT"/>
    <xsl:param name="taxRefundNb"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$taxRefundNb * (-1)"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP9">
    <xsl:param name="currencyFT"/>
    <xsl:param name="taxCreditNb"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="$taxCreditNb"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP10">
    <xsl:param name="currencyFT"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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


  <xsl:template name="printEntitlementFeesAndTaxesWithProportion">
    <xsl:param name="sourceTax"/>
    <xsl:param name="fgnCharges"/>
    <xsl:param name="foreignChgesTax"/>
    <xsl:param name="sumlocalTaxAmt"/>
    <xsl:param name="commission"/>
    <xsl:param name="commTax"/>
    <xsl:param name="sumManTaxAcy"/>
    <xsl:param name="sumScAmtAcy"/>
    <xsl:param name="taxCredit"/>
    <xsl:param name="taxRefund"/>
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <!-- Avoid empty values when 0 -->
    <xsl:variable name="decimalformatZ" select="'0.########################################'"/>
    <!-- Ensure parameter values are not NaN -->
    <xsl:variable name="sourceTaxNb">
      <xsl:value-of select="format-number($sourceTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="fgnChargesNb">
      <xsl:value-of select="format-number($fgnCharges,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="foreignChgesTaxNb">
      <xsl:value-of select="format-number($foreignChgesTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumlocalTaxAmtNb">
      <xsl:value-of select="format-number($sumlocalTaxAmt,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="commissionNb">
      <xsl:value-of select="format-number($commission,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="commTaxNb">
      <xsl:value-of select="format-number($commTax,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumManTaxAcyNb">
      <xsl:value-of select="format-number($sumManTaxAcy,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="sumScAmtAcyNb">
      <xsl:value-of select="format-number($sumScAmtAcy,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="taxCreditNb">
      <xsl:value-of select="format-number($taxCredit,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:variable name="taxRefundNb">
      <xsl:value-of select="format-number($taxRefund,$decimalformatZ,'nan2zero')"/>
    </xsl:variable>
    <xsl:call-template name="BP1WithProportion">
      <xsl:with-param name="fgnChargesNb" select="$fgnChargesNb"/>
      <xsl:with-param name="foreignChgesTaxNb" select="$foreignChgesTaxNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP2WithProportion">
      <xsl:with-param name="sourceTaxNb" select="$sourceTaxNb"/>
      <xsl:with-param name="sumlocalTaxAmtNb" select="$sumlocalTaxAmtNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP3WithProportion">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP4WithProportion">
      <xsl:with-param name="commissionNb" select="$commissionNb"/>
      <xsl:with-param name="commTaxNb" select="$commTaxNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP5WithProportion">
      <xsl:with-param name="sumManTaxAcyNb" select="$sumManTaxAcyNb"/>
      <xsl:with-param name="sumScAmtAcyNb" select="$sumScAmtAcyNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP6WithProportion">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP7WithProportion">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP8WithProportion">
      <xsl:with-param name="taxRefundNb" select="$taxRefundNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP9WithProportion">
      <xsl:with-param name="taxCreditNb" select="$taxCreditNb"/>
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
    <xsl:call-template name="BP10WithProportion">
      <xsl:with-param name="currencyFT" select="$currencyFT"/>
	  <xsl:with-param name="Proportion" select="$Proportion"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="BP1WithProportion">
    <xsl:param name="fgnChargesNb"/>
    <xsl:param name="foreignChgesTaxNb"/>
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number(($fgnChargesNb + $foreignChgesTaxNb) * $Proportion ,$decimalformat,'nan2zero')"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP2WithProportion">
    <xsl:param name="sourceTaxNb"/>
    <xsl:param name="sumlocalTaxAmtNb"/>
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number(($sourceTaxNb + $sumlocalTaxAmtNb) * $Proportion ,$decimalformat,'nan2zero')"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP3WithProportion">
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP4WithProportion">
    <xsl:param name="commissionNb"/>
    <xsl:param name="commTaxNb"/>
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number(($commissionNb + $commTaxNb) * $Proportion ,$decimalformat,'nan2zero')"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP5WithProportion">
    <xsl:param name="sumManTaxAcyNb"/>
    <xsl:param name="sumScAmtAcyNb"/>
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number(($sumManTaxAcyNb + $sumScAmtAcyNb) * $Proportion ,$decimalformat,'nan2zero')"/>
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
  <xsl:template name="BP6WithProportion">
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP7WithProportion">
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP8WithProportion">
    <xsl:param name="currencyFT"/>
    <xsl:param name="taxRefundNb"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number(($taxRefundNb * (-1)) * $Proportion ,$decimalformat,'nan2zero')"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP9WithProportion">
    <xsl:param name="currencyFT"/>
    <xsl:param name="taxCreditNb"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="format-number($taxCreditNb * $Proportion ,$decimalformat,'nan2zero')"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
  </xsl:template>
  <xsl:template name="BP10WithProportion">
    <xsl:param name="currencyFT"/>
	<xsl:param name="Proportion"/>
    <transactionFeesTaxesCounter>
      <amount>
        <xsl:value-of select="'0'"/>
      </amount>
      <currency>
        <infra:code>
          <xsl:value-of select="$currencyFT"/>
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
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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