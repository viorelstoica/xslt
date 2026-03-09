<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionOpenDerivativeBuy" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionOpenDerivativeBuy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionOpenDerivativeBuy" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionOpenDerivativeBuy" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="BP1">
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='FTT.CU']/*[local-name() = 'priCommAmt'] &lt; 0">
					<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='FTT.CU']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='FTT.CU']/*[local-name() = 'priCommAmt'] &gt; 0">
					<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='FTT.CU']/*[local-name() = 'priCommAmt']"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:tradeCcy"/>
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
			<xsl:choose>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='VAT.BNK.COMMISS']/*[local-name() = 'priCommAmt'] &lt; 0">
					<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='VAT.BNK.COMMISS']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='VAT.BNK.COMMISS']/*[local-name() = 'priCommAmt'] &gt; 0">
					<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='VAT.BNK.COMMISS']/*[local-name() = 'priCommAmt']"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:tradeCcy"/>
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
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.BRKR.COMM']/*[local-name() = 'priCommAmt'] &lt; 0">
					<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.BRKR.COMM']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.BRKR.COMM']/*[local-name() = 'priCommAmt'] &gt; 0">
					<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.BRKR.COMM']/*[local-name() = 'priCommAmt']"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:tradeCcy"/>
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
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp'] = 'BANK.COMMISSION']/*[local-name() = 'priCommAmt'] &lt; 0">
					<xsl:value-of select="format-number(-1 * *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp'] = 'BANK.COMMISSION']/*[local-name() = 'priCommAmt'],$decimalformat, 'nan2zero')"/>
				</xsl:when>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp'] = 'BANK.COMMISSION']/*[local-name() = 'priCommAmt'] &gt; 0">
					<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp'] = 'BANK.COMMISSION']/*[local-name() = 'priCommAmt']"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:tradeCcy"/>
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
	<xsl:template name="BP7">
		<xsl:variable name="amount">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.FEES.MISC']/*[local-name() = 'priCommAmt'] &lt; 0">
					<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.FEES.MISC']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.FEES.MISC']/*[local-name() = 'priCommAmt'] &gt; 0">
					<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CU.FEES.MISC']/*[local-name() = 'priCommAmt']"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="normalize-space($amount) != ''">
			<transactionFeesTaxesCounter>
				<amount>
					<xsl:value-of select="$amount"/>
				</amount>
				<currency>
					<infra:code>
						<xsl:value-of select="b:tradeCcy"/>
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
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:dxExchangeMnemonic)"/>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="DXTrade" userelativepaths="yes" externalpreview="no" url="DXin.xml" htmlbaseurl="" outputurl="DXout.xml" processortype="saxon8" useresolver="yes" profilemode="0" profiledepth="" profilelength="" urlprofilexml=""
		          commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->