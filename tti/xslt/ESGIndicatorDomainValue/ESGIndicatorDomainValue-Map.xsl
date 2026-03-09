<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/BusIndicator"
    xmlns:b="http://www.temenos.com/T24/event/TTI/EBLookupESG"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchEBLookupESG"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiEBLookupESG"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiEBLookupESG" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="ESGIndicatorDomainValue-Core.xsl"/>
    <xsl:import href="ESGIndicatorDomainValue-Custo.xsl"/>
	<xsl:import href="ESGIndicatorDomainValue.xsl"/>
    
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\EBLookupSampleXML.xml" htmlbaseurl="" outputurl="..\EBLookupSampleXMLout.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator=""/>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->