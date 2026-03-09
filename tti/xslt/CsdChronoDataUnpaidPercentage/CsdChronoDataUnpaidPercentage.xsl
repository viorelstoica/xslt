<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ChronoDataUnpaidPercentage" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchChronoDataUnpaidPercentage" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiChronoDataUnpaidPercentage" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiChronoDataUnpaidPercentage" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiChronoDataUnpaidPercentage">
      <xsl:apply-templates select="c:CurrentEvent/b:ChronoDataUnpaidPercentage"/>
   </xsl:template>
   <xsl:template match="batch:BatchChronoDataUnpaidPercentage">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchChronoDataUnpaidPercentage" name="BatchChronoDataUnpaidPercentage">
         <xsl:apply-templates select="b:ChronoDataUnpaidPercentage"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiChronoDataUnpaidPercentage">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiChronoDataUnpaidPercentage" name="BatchMultiChronoDataUnpaidPercentage">
         <xsl:apply-templates select="c:MultiChronoDataUnpaidPercentage"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:ChronoDataUnpaidPercentage">
    <FiPMS mode="INSUPD" output="chrono">
        <DataGroup>
            <xsl:for-each select="b:cpnDateGroup">
      
                <!-- =============================== -->
                <!-- L3 : COMPLEXITY DELTA -->
                <!-- =============================== -->
                <xsl:if test="../b:complexity != ../../../c:PreviousEvent/b:ChronoDataUnpaidPercentage/b:complexity">
                    <xsl:if test="../b:complexity = '1' or ../b:complexity = '2'">
                        <ChronologicalData>
                            <xsl:attribute name="description">
                                <xsl:value-of
                                    select="concat(
                                        'CsdChronoDataUnpaidPercentage.xsl+',
                                        name(/*), '+',
                                        ../b:eventCommon/ns0:eventId, '+',
                                        ../b:eventCommon/ns0:creationTime
                                    )"/>
                            </xsl:attribute>

                            <xsl:attribute name="sequenceNumber">
                                <xsl:call-template name="calcSeqNum">
                                    <xsl:with-param name="creationTime"
                                        select="../b:eventCommon/ns0:creationTime"/>
                                </xsl:call-template>
                            </xsl:attribute>

                            <xsl:call-template name="currency"/>
                            <xsl:call-template name="dataNatureComplex"/>
                            <xsl:call-template name="instrument"/>
                            <xsl:call-template name="validity"/>
                            <xsl:call-template name="valueComplex"/>
                            <xsl:call-template name="provider"/>
                            <xsl:call-template name="valueType"/>
                            <xsl:call-template name="mbFields"/>
                        </ChronologicalData>
                    </xsl:if>
                </xsl:if>

                <!-- =============================== -->
                <!-- L3 : LIQUIDITY DELTA  -->
                <!-- =============================== -->
                <xsl:if test="../b:csdLiqtyAlt != ../../../c:PreviousEvent/b:ChronoDataUnpaidPercentage/b:csdLiqtyAlt">
                    <xsl:if test="../b:csdLiqtyAlt != ''">
                        <ChronologicalData>
                            <xsl:attribute name="description">
                                <xsl:value-of
                                    select="concat(
                                        'CsdChronoDataUnpaidPercentage.xsl+',
                                        name(/*), '+',
                                        ../b:eventCommon/ns0:eventId, '+',
                                        ../b:eventCommon/ns0:creationTime
                                    )"/>
                            </xsl:attribute>

                            <xsl:attribute name="sequenceNumber">
                                <xsl:call-template name="calcSeqNum">
                                    <xsl:with-param name="creationTime"
                                        select="../b:eventCommon/ns0:creationTime"/>
                                </xsl:call-template>
                            </xsl:attribute>

                            <xsl:call-template name="currency"/>
                            <xsl:call-template name="dataNatureLiq"/>
                            <xsl:call-template name="instrument"/>
                            <xsl:call-template name="validity"/>
                            <xsl:call-template name="valueLiq"/>
                            <xsl:call-template name="provider"/>
                            <xsl:call-template name="valueType"/>
                            <xsl:call-template name="mbFields"/>
                        </ChronologicalData>
                    </xsl:if>
                </xsl:if>

                <!-- =============================== -->
                <!-- L3 : RISK LEVEL DELTA -->
                <!-- =============================== -->
                <xsl:if
                    test="../b:riskTypeIndGroup[1]/b:regRiskLevel
                          != ../../../c:PreviousEvent/b:ChronoDataUnpaidPercentage/b:riskTypeIndGroup[1]/b:regRiskLevel">
                    <xsl:if test="../b:riskTypeIndGroup[1]/b:riskTypeInd = 'MRM'">
                        <ChronologicalData>
                            <xsl:attribute name="description">
                                <xsl:value-of
                                    select="concat(
                                        'CsdChronoDataUnpaidPercentage.xsl+',
                                        name(/*), '+',
                                        ../b:eventCommon/ns0:eventId, '+',
                                        ../b:eventCommon/ns0:creationTime
                                    )"/>
                            </xsl:attribute>

                            <xsl:attribute name="sequenceNumber">
                                <xsl:call-template name="calcSeqNum">
                                    <xsl:with-param name="creationTime"
                                        select="../b:eventCommon/ns0:creationTime"/>
                                </xsl:call-template>
                            </xsl:attribute>

                            <xsl:call-template name="currency"/>
                            <xsl:call-template name="dataNatureRisk"/>
                            <xsl:call-template name="instrument"/>
                            <xsl:call-template name="validity"/>
                            <xsl:call-template name="valueRisk"/>
                            <xsl:call-template name="provider"/>
                            <xsl:call-template name="valueType"/>
                            <xsl:call-template name="mbFields"/>
                        </ChronologicalData>
                    </xsl:if>
                </xsl:if>

            </xsl:for-each>
        </DataGroup>
    </FiPMS>
</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="ChronoDataUnpaidPercentage" userelativepaths="yes" externalpreview="no" url="..\..\..\..\..\..\20260109_120107_538_63_msgin_BatchMultiChronoDataUnpaidPercentage_f1841d9b-56dc-42ba-96f4-1c4c98d8ff62.xml" htmlbaseurl=""
		          outputurl="..\..\..\..\..\..\ChronoMap.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none"
		          postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<scenario default="no" name="Currency" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Currency\Currency.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Currency\CurrencyGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<scenario default="no" name="CurrencyMarket" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CurrencyMarket\CurrencyMarket.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CurrencyMarket\CurrencyMarketGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<scenario default="no" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<scenario default="no" name="Stock" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Stock\Stock.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Stock\StockGWP.xml" processortype="saxon8" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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