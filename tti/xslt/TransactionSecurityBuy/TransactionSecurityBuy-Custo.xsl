<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecurityBuy" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecurityBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBuy" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="printTradeFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:variable name="intraSwitchFund">
			<xsl:choose>
				<xsl:when test="($caller = 'TransactionSecurityBuy' or $caller = 'TransactionSecuritySell' or $caller = 'SecTradeBuyActualSettlement' or $caller = 'SecTradeSellActualSettlement') and (../../*[local-name() = 'switchSuspCatJoin'] = ../../*[local-name() = 'custAccNoCategoryList']/*[local-name() = 'custAccNoCategory'])">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tradeFeesTaxesVar">
			<xsl:choose>
				<xsl:when test="$intraSwitchFund = '0' and (../../*[local-name() = 'originalSec'] = '' or not(../../*[local-name() = 'originalSec']))">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="BP1">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP2">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP3">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP4">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP5">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP6">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP7">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP8">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP9">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP10"/>
	</xsl:template>
	<xsl:template name="BP1">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amountVal">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="amount">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'STAMP.DUTY.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount1">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'PTM.LEVY.FEES.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount2">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'FTT.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount3">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'HK.LEVY.FEES.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount4">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'HK.FRC.LEVY.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="total">
						<xsl:value-of select="format-number(number($amount + $amount1 + $amount2 + $amount3 + $amount4),$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:value-of select="$total"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amountVal) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amountVal"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="sumAmt" select="sum(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'VAT.BNK.COMMISS' or *[local-name() = 'cuChargeTaxType'] = 'VAT.SETUP.FEE' or *[local-name() = 'cuChargeTaxType'] = 'VAT.CU']/*[local-name() = 'cuChargeTaxAmt'])"/>
					<xsl:value-of select="format-number($sumAmt, '#.00', 'nan2zero')"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
	<xsl:template name="BP3">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="amount7">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'CU.PERF.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount8">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'THIRD.BROKERAGE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount9">
						<xsl:value-of select="format-number(number($amount7 + $amount8),$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:value-of select="$amount9"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'BROKER_COMMISSION'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BP4">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="amount10">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'BANK.COMMISSION']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount11">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'DELIVERY.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount12">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SETUP.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount13">
						<xsl:value-of select="format-number(number($amount10 + $amount11 + $amount12),$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:value-of select="$amount13"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
	<xsl:template name="BP5">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../*[local-name() = 'cuStampTax']"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'STAMP_AND_COMM_TAX'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BP6">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="../*[local-name() = 'custTransCode' and text() = 'SWO']">
					<xsl:variable name="amount15">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SWITCH.FUND.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:value-of select="$amount15"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
					</infra:code>
				</currency>
				<type>
					<infra:code>
						<xsl:value-of select="'SUBSCR_REDEMP'"/>
					</infra:code>
				</type>
			</transactionFeesTaxesCounter>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BP7">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../*[local-name() = 'cuFeesMisc']"/>
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
						<xsl:choose>
							<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT')">
								<xsl:value-of select="../../*[local-name() = 'currency']"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
							</xsl:otherwise>
						</xsl:choose>
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
	<!--	<xsl:template name="BP8">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(../*[local-name() = 'cuReallowAmt'], $decimalformat,'nan2zero') + format-number(../*[local-name() = 'cuDiscAmt'],$decimalformat,'nan2zero')"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
		</xsl:if>
	</xsl:template> -->
	<xsl:template name="BP9">
		<xsl:param name="tradeFeesTaxesVar"/>
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="$tradeFeesTaxesVar = '1'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="amount15">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ISS.DISC.REV.TAX']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount16">
						<xsl:value-of select="format-number(sum(../*[local-name() = 'cuWhtTaxList']/*[local-name() = 'cuWhtTax']),$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount17">
						<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuTaxTcySubGroup'][*[local-name() = 'cuTaxType'] = 'FDR']/*[local-name() = 'cuTaxTcy'],$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:variable name="amount18">
						<xsl:value-of select="format-number(number($amount15 + $amount16 + $amount17),$decimalformat,'nan2zero')"/>
					</xsl:variable>
					<xsl:value-of select="$amount18"/>
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
						<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
	<!-- <xsl:template name="BP10">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
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
	</xsl:template>  -->
	<!-- END of protected area  -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\..\..\Users\m.gopinath\Downloads\3.6.2024\tti_config_9.5.3_mb_9.5.3\config\postfilter.xml" htmlbaseurl=""
		          outputurl="..\..\..\..\..\..\Users\m.gopinath\Downloads\3.6.2024\tti_config_9.5.3_mb_9.5.3\config\postout6.xml" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\..\..\..\..\Users\m.gopinath\Downloads\3.6.2024\tti_config_9.5.3_mb_9.5.3\config\postfilter.xml" srcSchemaRoot="tns:TransactionSecurityBuy" AssociatedInstance="" loaderFunction="document"
			              loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template name="printTradeFeesAndTaxes">
				<block path="xsl:call-template" x="283" y="0"/>
				<block path="xsl:call-template[1]" x="323" y="0"/>
				<block path="xsl:call-template[2]" x="243" y="0"/>
				<block path="xsl:call-template[3]" x="203" y="0"/>
				<block path="xsl:call-template[4]" x="163" y="0"/>
				<block path="xsl:call-template[5]" x="123" y="0"/>
				<block path="xsl:call-template[6]" x="83" y="0"/>
				<block path="xsl:call-template[7]" x="43" y="0"/>
				<block path="xsl:call-template[8]" x="283" y="40"/>
				<block path="xsl:call-template[9]" x="323" y="40"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->