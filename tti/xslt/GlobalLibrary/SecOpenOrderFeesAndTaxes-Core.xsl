<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printSecOpenOrderFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:param name="cuEbvFees"/>
		<xsl:param name="cuForeignFee"/>
		<xsl:param name="cuBrkrComm"/>
		<xsl:param name="cuCommission"/>
		<xsl:param name="cuCommTax"/>
		<xsl:param name="cuStampTax"/>
		<xsl:param name="cuChargeTaxAmt"/>
		<xsl:param name="cuChargeTaxType"/>
		<xsl:param name="cuFeesMisc"/>
		<xsl:param name="cuDiscAmt"/>
		<xsl:param name="cuWhtTax"/>
		<xsl:param name="tradeCcy"/>
		<!-- Avoid empty values when 0 -->
		<xsl:variable name="decimalformatZ" select="'0.########################################'"/>
		<!-- Ensure parameter values are not NaN -->
		<xsl:variable name="cuEbvFeesNb">
			<xsl:value-of select="format-number($cuEbvFees,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuForeignFeeNb">
			<xsl:value-of select="format-number($cuForeignFee,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuBrkrCommNb">
			<xsl:value-of select="format-number($cuBrkrComm,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuCommissionNb">
			<xsl:value-of select="format-number($cuCommission,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuCommTaxNb">
			<xsl:value-of select="format-number($cuCommTax,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuStampTaxNb">
			<xsl:value-of select="format-number($cuStampTax,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuChargeTaxAmtNb">
			<xsl:value-of select="format-number($cuChargeTaxAmt,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuChargeTaxTypeNb">
			<xsl:value-of select="$cuChargeTaxType"/>
		</xsl:variable>
		<xsl:variable name="cuFeesMiscNb">
			<xsl:value-of select="format-number($cuFeesMisc,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuDiscAmtNb">
			<xsl:value-of select="format-number($cuDiscAmt,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="cuWhtTaxNb">
			<xsl:value-of select="format-number($cuWhtTax,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>

		<xsl:call-template name="BP1">
			<xsl:with-param name="cuEbvFeesNb" select="$cuEbvFeesNb"/>
			<xsl:with-param name="cuForeignFeeNb" select="$cuForeignFeeNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP2">
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP3">
			<xsl:with-param name="cuBrkrCommNb" select="$cuBrkrCommNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP4">
			<xsl:with-param name="cuCommissionNb" select="$cuCommissionNb"/>
			<xsl:with-param name="cuCommTaxNb" select="$cuCommTaxNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP5">
			<xsl:with-param name="cuStampTaxNb" select="$cuStampTaxNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP6">
			<xsl:with-param name="cuChargeTaxTypeNb" select="$cuChargeTaxTypeNb"/>
			<xsl:with-param name="cuChargeTaxAmtNb" select="$cuChargeTaxAmtNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP7">
			<xsl:with-param name="cuFeesMiscNb" select="$cuFeesMiscNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP8">
			<xsl:with-param name="cuDiscAmtNb" select="$cuDiscAmtNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP9">
			<xsl:with-param name="cuWhtTaxNb" select="$cuWhtTaxNb"/>
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP10">
			<xsl:with-param name="tradeCcy" select="$tradeCcy"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="BP1">
		<xsl:param name="cuEbvFeesNb"/>
		<xsl:param name="cuForeignFeeNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$cuEbvFeesNb or $cuForeignFeeNb">
						<xsl:value-of select="$cuEbvFeesNb + $cuForeignFeeNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuBrkrCommNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$cuBrkrCommNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuCommissionNb"/>
		<xsl:param name="cuCommTaxNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$cuCommissionNb + $cuCommTaxNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuStampTaxNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$cuStampTaxNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuChargeTaxTypeNb"/>
		<xsl:param name="cuChargeTaxAmtNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:variable name="entryLoadVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.LOAD.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="salesTaxVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="exitLoadVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'EXIT.LOAD.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="exitSalesTaxVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'EXIT.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="switchCommissionVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SWITCH.COMM.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="switchTaxVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SWITCH.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="turnOverFeeVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'TURNOVERFEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="cancChargeVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'CANC.CHARGE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="entryRebateVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'RB.ENTRY.LOAD']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="eLChDiscountVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.LOAD.CH.DI']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="minHoldingFeeVar">
					<xsl:value-of select="format-number(*[local-name() = 'custNumberGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'MIN.HOLDING.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="bpAmount6Var">
					<xsl:value-of select="format-number(number($entryLoadVar + $salesTaxVar + $exitLoadVar + $exitSalesTaxVar + $switchCommissionVar + $switchTaxVar + $turnOverFeeVar + $cancChargeVar + $minHoldingFeeVar - $entryRebateVar - $eLChDiscountVar),$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:value-of select="round($bpAmount6Var * 100) div 100"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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
		<xsl:param name="cuFeesMiscNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$cuFeesMiscNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuDiscAmtNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$cuDiscAmtNb">
						<xsl:value-of select="$cuDiscAmtNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="cuWhtTaxNb"/>
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$cuWhtTaxNb">
						<xsl:value-of select="$cuWhtTaxNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
		<xsl:param name="tradeCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$tradeCcy"/>
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->