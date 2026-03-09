<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDxPrice"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyDxPrice" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyDxPrice" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyDxPrice" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiSyDxPrice">
		<xsl:apply-templates select="c:CurrentEvent/b:SyDxPrice"/>
	</xsl:template>
	<xsl:template match="batch:BatchSyDxPrice">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPrice" name="BatchSyDxPrice">
			<xsl:apply-templates select="b:SyDxPrice"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiSyDxPrice">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPrice" name="BatchMultiSyDxPrice">
			<xsl:apply-templates select="c:MultiSyDxPrice"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:SyDxPrice">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('SyDxPrice',b:id)"/>
			</xsl:attribute>
			<xsl:if test="starts-with(b:dealReference,'SY')">
				<DataGroup>
					<Price>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('SyDxPrice.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="currency"/>
						<xsl:call-template name="instrument"/>
						<xsl:call-template name="provider"/>
						<xsl:call-template name="quotationDate"/>
						<xsl:call-template name="stockExchange"/>
						<xsl:call-template name="value"/>
						<xsl:call-template name="valueType"/>
						<xsl:call-template name="valueTermType"/>
						<xsl:call-template name="priceCalculationRule"/>
						<xsl:call-template name="mbFields"/>
					</Price>
				</DataGroup>
			</xsl:if>
			<xsl:if test="starts-with(b:dealReference,'DXTRA')">
				<DataGroup>
					<PortfolioInstrumentPrice>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('SyDxPrice.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="currency_PortfolioInstrumentPrice"/>
						<xsl:call-template name="instrument_PortfolioInstrumentPrice"/>
						<xsl:call-template name="portfolio_PortfolioInstrumentPrice"/>
						<xsl:call-template name="price_PortfolioInstrumentPrice"/>
						<xsl:call-template name="priceCalculationRule_PortfolioInstrumentPrice"/>
						<xsl:call-template name="quantity_PortfolioInstrumentPrice"/>
						<xsl:call-template name="quote_PortfolioInstrumentPrice"/>
						<xsl:call-template name="quotedDate_PortfolioInstrumentPrice"/>
						<xsl:call-template name="value_PortfolioInstrumentPrice"/>
						<xsl:call-template name="mbFields_PortfolioInstrumentPrice"/>
					</PortfolioInstrumentPrice>
				</DataGroup>
			</xsl:if>
		</FiPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="SyDxPrice" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\SyDxPrice\SyDxPrice.xml" htmlbaseurl="" outputurl="..\..\TestFiles\SyDxPrice\SyDxPriceGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
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