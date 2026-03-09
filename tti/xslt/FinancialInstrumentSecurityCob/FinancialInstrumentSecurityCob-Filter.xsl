<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/FiPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurityCob"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurityCob"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurityCob"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurityCob" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="FinancialInstrumentSecurityCob-Filter-Core.xsl"/>
    <xsl:import href="FinancialInstrumentSecurityCob-Filter-Custo.xsl"/>
    <xsl:strip-space elements="*"/>
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
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
		<scenario default="yes" name="FinancialInstrumentFixedIncome" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentFixedIncome\FinancialInstrumentFixedIncome2.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentFixedIncome\FinancialInstrumentFixedIncome2Filter.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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
		<scenario default="no" name="FinancialInstrumentSector" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentSector\FinancialInstrumentSector.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentSector\FinancialInstrumentSector_T24.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentFixedIncome\FinancialInstrumentFixedIncome.xml" srcSchemaRoot="MultiFinancialInstrumentFixedIncome" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="b:FinancialInstrumentFixedIncome">
				<block path="FiPMS/xsl:attribute[1]/xsl:value-of" x="196" y="54"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[1]" x="236" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[2]" x="156" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[3]" x="116" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[4]" x="76" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[5]" x="36" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[6]" x="236" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[7]" x="156" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[8]" x="116" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[9]" x="76" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[10]" x="36" y="50"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[11]" x="196" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[12]" x="236" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[13]" x="156" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[14]" x="116" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[15]" x="76" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[16]" x="36" y="130"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[17]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[18]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[19]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[20]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[21]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[22]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[23]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[24]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[25]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[26]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[27]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[28]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[29]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[30]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[31]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[32]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[33]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[34]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[35]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[36]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[37]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[38]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[39]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[40]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[41]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[42]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[43]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[44]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[45]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[46]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[47]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[48]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[49]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[50]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[51]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[52]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[53]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[54]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[55]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[56]" x="196" y="90"/>
				<block path="FiPMS/DataGroup/Bond/xsl:call-template[57]" x="196" y="90"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->