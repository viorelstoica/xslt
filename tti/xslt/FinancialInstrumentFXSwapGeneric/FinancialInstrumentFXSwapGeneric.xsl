<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentForex">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentForex"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex" name="BatchFinancialInstrumentForex">
			<xsl:apply-templates select="b:FinancialInstrumentForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex" name="BatchMultiFinancialInstrumentForex">
			<xsl:apply-templates select="c:MultiFinancialInstrumentForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentForex">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentFXSwapGeneric',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<FxSwap>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentFXSwapGeneric.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
					<xsl:call-template name="infra:synonym"/>
					<xsl:call-template name="infra:shortName"/>
					<xsl:call-template name="infra:longName"/>
					<xsl:call-template name="infra:multilingualLongName"/>
					<xsl:call-template name="infra:notepad"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="active"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="currencyReceived"/>
					<xsl:call-template name="yieldCurve"/>
					<xsl:call-template name="currencyPaid"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="paidLegYieldCurve"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="generic"/>
				</FxSwap>
			</DataGroup>
			<!-- End of if 'SW' -->
		</FiPMS>
	</xsl:template>
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