<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronologicalDataFixedIncome"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataFixedIncome" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiChronologicalDataFixedIncome" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataFixedIncome" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiChronologicalDataFixedIncome">
		<xsl:apply-templates select="c:CurrentEvent/b:ChronologicalDataFixedIncome"/>
	</xsl:template>
	<xsl:template match="batch:BatchChronologicalDataFixedIncome">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchChronologicalDataFixedIncome" name="BatchChronologicalDataFixedIncome">
			<xsl:apply-templates select="b:ChronologicalDataFixedIncome"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiChronologicalDataFixedIncome">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiChronologicalDataFixedIncome" name="BatchMultiChronologicalDataFixedIncome">
			<xsl:apply-templates select="c:MultiChronologicalDataFixedIncome"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ChronologicalDataFixedIncome">
		<FiPMS mode="INSUPD" output="ChronologicalDataFixedIncome">
			<DataGroup>
				<xsl:for-each select="b:currentYieldGroup">
					<xsl:if test="b:duration != ''">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_duration"/>
							<xsl:call-template name="dataNature_duration"/>
							<xsl:call-template name="instrument_duration"/>
							<xsl:call-template name="validity_duration"/>
							<xsl:call-template name="value_duration"/>
							<xsl:call-template name="provider_duration"/>
							<xsl:call-template name="valueType_duration"/>
							<xsl:call-template name="mbFields_duration"/>
						</ChronologicalData>
					</xsl:if>
					<xsl:if test="b:durationModify != ''">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_durationModify"/>
							<xsl:call-template name="dataNature_durationModify"/>
							<xsl:call-template name="instrument_durationModify"/>
							<xsl:call-template name="validity_durationModify"/>
							<xsl:call-template name="value_durationModify"/>
							<xsl:call-template name="provider_durationModify"/>
							<xsl:call-template name="valueType_durationModify"/>
							<xsl:call-template name="mbFields_durationModify"/>
						</ChronologicalData>
					</xsl:if>
					<xsl:if test="((b:yieldToMat and b:yieldToMat!= '' and not(../../../c:PreviousEvent/b:ChronologicalDataFixedIncome/b:currentYieldGroup/b:yieldToMat) ) or (b:yieldToMat and b:yieldToMat!= '' and(../../../c:PreviousEvent/b:ChronologicalDataFixedIncome/b:currentYieldGroup/b:yieldToMat != b:yieldToMat) ))">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_yieldToMat"/>
							<xsl:call-template name="dataNature_yieldToMat"/>
							<xsl:call-template name="instrument_yieldToMat"/>
							<xsl:call-template name="validity_yieldToMat"/>
							<xsl:call-template name="value_yieldToMat"/>
							<xsl:call-template name="provider_yieldToMat"/>
							<xsl:call-template name="valueType_yieldToMat"/>
							<xsl:call-template name="mbFields_yieldToMat"/>
						</ChronologicalData>
					</xsl:if>
					<xsl:if test="b:currentYield != ''">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_currentYield"/>
							<xsl:call-template name="dataNature_currentYield"/>
							<xsl:call-template name="instrument_currentYield"/>
							<xsl:call-template name="validity_currentYield"/>
							<xsl:call-template name="value_currentYield"/>
							<xsl:call-template name="provider_currentYield"/>
							<xsl:call-template name="valueType_currentYield"/>
							<xsl:call-template name="mbFields_currentYield"/>
						</ChronologicalData>
					</xsl:if>
					<xsl:if test="b:yieldToLife != ''">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_yieldToLife"/>
							<xsl:call-template name="dataNature_yieldToLife"/>
							<xsl:call-template name="instrument_yieldToLife"/>
							<xsl:call-template name="validity_yieldToLife"/>
							<xsl:call-template name="value_yieldToLife"/>
							<xsl:call-template name="provider_yieldToLife"/>
							<xsl:call-template name="valueType_yieldToLife"/>
							<xsl:call-template name="mbFields_yieldToLife"/>
						</ChronologicalData>
					</xsl:if>
					<xsl:if test="b:convexity != ''">
						<ChronologicalData>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="currency_convexity"/>
							<xsl:call-template name="dataNature_convexity"/>
							<xsl:call-template name="instrument_convexity"/>
							<xsl:call-template name="validity_convexity"/>
							<xsl:call-template name="value_convexity"/>
							<xsl:call-template name="provider_convexity"/>
							<xsl:call-template name="valueType_convexity"/>
							<xsl:call-template name="mbFields_convexity"/>
						</ChronologicalData>
					</xsl:if>
				</xsl:for-each>
				<xsl:if test="b:priceEarnRatio != ''">
					<ChronologicalData>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('ChronologicalDataFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="currency_priceEarnRatio"/>
						<xsl:call-template name="dataNature_priceEarnRatio"/>
						<xsl:call-template name="instrument_priceEarnRatio"/>
						<xsl:call-template name="validity_priceEarnRatio"/>
						<xsl:call-template name="value_priceEarnRatio"/>
						<xsl:call-template name="provider_priceEarnRatio"/>
						<xsl:call-template name="valueType_priceEarnRatio"/>
						<xsl:call-template name="mbFields_priceEarnRatio"/>
					</ChronologicalData>
				</xsl:if>
			</DataGroup>
		</FiPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="ChronologicalDataFixedIncome" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\ChronologicalDataFixedIncome\ChronologicalDataFixedIncome.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\ChronologicalDataFixedIncome\ChronologicalDataFixedIncomeCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="Currency" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Currency\Currency.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Currency\CurrencyGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="CurrencyMarket" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CurrencyMarket\CurrencyMarket.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CurrencyMarket\CurrencyMarketGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<scenario default="no" name="Stock" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Stock\Stock.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Stock\StockGWP.xml" processortype="saxon8" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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