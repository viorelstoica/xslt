<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/FiPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../../GlobalTemplate/ESP/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="../FinancialInstrumentFixedIncome-Core.xsl"/>
    <xsl:import href="../FinancialInstrumentFixedIncome-Custo.xsl"/>
	<xsl:import href="FinancialInstrumentFixedIncome-Core.xsl"/>
    <xsl:import href="FinancialInstrumentFixedIncome-Custo.xsl"/>
	<xsl:import href="../FinancialInstrumentFixedIncome.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
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