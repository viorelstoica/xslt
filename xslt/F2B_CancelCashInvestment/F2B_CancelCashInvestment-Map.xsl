<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0"
	xmlns="http://www.temenos.com/T24/OFSML/150"
    xmlns:b="http://www.odcgroup.com/F2B_MM_FX"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:paymentorder="http://www.temenos.com/T24/paymentorder" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="F2B_CancelCashInvestment-Core.xsl"/>
    <xsl:import href="F2B_CancelCashInvestment-Custo.xsl"/>
	<xsl:import href="F2B_CancelCashInvestment.xsl"/>
    
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\DailyTrack\TTI-2686\CancelCashTransfer\orderinstr.xml" htmlbaseurl=""
		          outputurl="..\..\..\..\DailyTrack\TTI-2686\CancelCashTransfer\orderinstrout1.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\t24Schemas\OfsmlProxy.xsd" destSchemaRoot="T24Batch" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\gwpackSchemas\F2B.xsd" srcSchemaRoot="F2B" AssociatedInstance="file:///w:/TTI_TRUNK2/gwpackSchemas/F2B.xsd" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="T24Batch/xsl:for-each" x="205" y="54"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose" x="191" y="51"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]" x="145" y="45"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]" x="99" y="39"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]" x="53" y="33"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]" x="7" y="27"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]" x="0" y="21"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]" x="0" y="144"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]/=[0]" x="0" y="138"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="166"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="43"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="49"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/=[1]" x="7" y="55"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/=[1]" x="53" y="61"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/=[1]" x="99" y="67"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose" x="121" y="21"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]" x="242" y="77"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]/=[0]" x="196" y="71"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]/=[1]" x="196" y="99"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/xsl:when/xsl:value-of" x="31" y="51"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/=[1]" x="242" y="105"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/xsl:when[1]/xsl:value-of" x="198" y="113"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]" x="123" y="202"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/=[0]" x="77" y="196"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]" x="77" y="224"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]/=[0]" x="31" y="218"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]/=[1]" x="31" y="246"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when[1]/ofsTransactionInput/field[1]/xsl:value-of" x="158" y="113"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->