<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderGroupingCutOffDateChange"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOrderGroupingCutOffDateChange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderGroupingCutOffDateChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOrderGroupingCutOffDateChange" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiOrderGroupingCutOffDateChange">
		<xsl:apply-templates select="c:CurrentEvent/b:OrderGroupingCutOffDateChange"/>
	</xsl:template>
	<xsl:template match="batch:BatchOrderGroupingCutOffDateChange">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchOrderGroupingCutOffDateChange" name="BatchOrderGroupingCutOffDateChange">
			<xsl:apply-templates select="b:OrderGroupingCutOffDateChange"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiOrderGroupingCutOffDateChange">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiOrderGroupingCutOffDateChange" name="BatchMultiOrderGroupingCutOffDateChange">
			<xsl:apply-templates select="c:MultiOrderGroupingCutOffDateChange"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:OrderGroupingCutOffDateChange">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('OrderGroupingCutOffDateChange',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<FundShare>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('OrderGroupingCutOffDateChange.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
		  			<xsl:call-template name="infra:synonym-custo"/>
					<xsl:call-template name="infra:synonym"/>
					<xsl:call-template name="infra:shortName"/>
					<xsl:call-template name="infra:longName"/>
					<xsl:call-template name="infra:multilingualLongName"/>
		  			<xsl:call-template name="infra:notepad-custo"/>
					<xsl:call-template name="infra:notepad"/>
		  			<xsl:call-template name="infra:userDefinedField-custo"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="active"/>
					<xsl:call-template name="euroConversionDate"/>
					<xsl:call-template name="euroConversionRule"/>
					<xsl:call-template name="euroNewInstrument"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="mainStockExchange"/>
					<xsl:call-template name="minimumQuantity"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="provider"/>
					<xsl:call-template name="referenceCurrency"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="roundLotQuantity"/>
		  			<xsl:call-template name="sector-custo"/>
					<xsl:call-template name="sector"/>
					<xsl:call-template name="stockExchange"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tickSize"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="beginDate"/>
					<xsl:call-template name="capitalGainTax"/>
					<xsl:call-template name="complexity"/>
					<xsl:call-template name="complexityLevel"/>
					<xsl:call-template name="cutOffTime"/>
					<xsl:call-template name="cutOffTimeZone"/>
					<xsl:call-template name="dividendFrequencyNumber"/>
					<xsl:call-template name="dividendFrequencyUnit"/>
					<xsl:call-template name="eligibleWrapFund"/>
					<xsl:call-template name="faceValue"/>
					<xsl:call-template name="islamicCompliance"/>
					<xsl:call-template name="issueQuantity"/>
					<xsl:call-template name="issueQuote"/>
					<xsl:call-template name="issuer"/>
					<xsl:call-template name="marketDirectiveCategory"/>
					<xsl:call-template name="minimumTradingAmount"/>
					<xsl:call-template name="referenceIndex"/>
					<xsl:call-template name="riskCurrency"/>
					<xsl:call-template name="riskLevel"/>
					<xsl:call-template name="roundLotAmount"/>
					<xsl:call-template name="stpOrder"/>
					<xsl:call-template name="subNature"/>
					<xsl:call-template name="tradeNature"/>
					<xsl:call-template name="votingRights"/>
					<xsl:call-template name="witholdingTax"/>
					<xsl:call-template name="dividend"/>
					<xsl:call-template name="composition"/>
                    <xsl:call-template name="commonReference"/>
					<xsl:call-template name="coolCancelF"/>
					<xsl:call-template name="coolPeriod"/>
					<xsl:call-template name="coolPeriodUnit"/>
					<xsl:call-template name="fundIncomeStyleE"/>
					<xsl:call-template name="parentInstrument"/>
					<xsl:call-template name="redemption"/>
					<xsl:call-template name="reinvestmentAllowedF"/>
					<xsl:call-template name="switchOrderAmt"/>
					<xsl:call-template name="switchOrderPerc"/>
					<xsl:call-template name="switchOrderUnit"/>
				</FundShare>
			</DataGroup>
		</FiPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\SpAirBagCertificates\AIRBAG1.xml" htmlbaseurl="" outputurl="..\..\TestFiles\SpAirBagCertificates\AIRBAG12.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
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