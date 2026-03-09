<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionContractMaster" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOptionContractMaster" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOptionContractMaster" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOptionContractMaster" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentExoticOptionContractMaster">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentExoticOptionContractMaster"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentExoticOptionContractMaster">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentExoticOptionContractMaster" name="BatchFinancialInstrumentExoticOptionContractMaster">
			<xsl:apply-templates select="b:FinancialInstrumentExoticOptionContractMaster"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentExoticOptionContractMaster">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentExoticOptionContractMaster" name="BatchMultiFinancialInstrumentExoticOptionContractMaster">
			<xsl:apply-templates select="c:MultiFinancialInstrumentExoticOptionContractMaster"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentExoticOptionContractMaster">
		<StructuredProducts>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentExoticOptionContractMaster',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<ExoticOption>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentExoticOptionContractMaster.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="synonym"/>
					<xsl:call-template name="shortName"/>
					<xsl:call-template name="longName"/>
					<xsl:call-template name="multilingualLongName"/>
					<xsl:call-template name="notepad"/>
					<xsl:call-template name="userDefinedField-custo"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
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
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tickSize"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="beginDate"/>
					<xsl:call-template name="category"/>
					<xsl:call-template name="commonReference"/>
					<xsl:call-template name="complexity"/>
					<xsl:call-template name="complexityLevel"/>
					<xsl:call-template name="contractMaster"/>
					<xsl:call-template name="contractSize"/>
					<xsl:call-template name="exerciseCurrency"/>
					<xsl:call-template name="expirationDate"/>
					<xsl:call-template name="instrumentClass"/>
					<xsl:call-template name="islamicCompliance"/>
					<xsl:call-template name="lastTradeDate"/>
					<xsl:call-template name="marketDirectiveCategory"/>
					<xsl:call-template name="riskLevel"/>
					<xsl:call-template name="subNature"/>
					<xsl:call-template name="underlying"/>
					<xsl:call-template name="usageNature"/>
					<xsl:call-template name="yieldCurve"/>
				</ExoticOption>
			</DataGroup>
		</StructuredProducts>
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