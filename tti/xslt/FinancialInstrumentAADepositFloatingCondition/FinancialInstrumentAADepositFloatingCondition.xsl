<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:batch="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" exclude-result-prefixes="a b c d e f g h i j k l ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="batch:BatchAAAFlow">
      <xsl:element xmlns="http://www.temenos.com/T24/event/AAAExtractor/BatchAAAFlow" name="BatchAAAFlow">
         <xsl:apply-templates select="c:AAAFlow"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="c:AAAFlow">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentAADepositFloatingCondition',c:aatxncontext/b:aaArrangementId)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:apply-templates select="c:interestrecords[contains($list_idComp2_FinancialInstrumentAADepositFloatingCondition,concat(' ',a:idComp2,' '))]/a:intRateDetails"/>
         </DataGroup>
      </FiPMS>
   </xsl:template>
   <xsl:template match="c:interestrecords/a:intRateDetails">
      <Event>
         <xsl:attribute name="description">
            <xsl:value-of select="concat('FinancialInstrumentAADepositFloatingCondition.xsl+', name(/*), '+', ../../c:eventCommon/ns0:eventId, '+', ../../c:eventCommon/ns0:creationTime)"/>
         </xsl:attribute>
         <xsl:attribute name="sequenceNumber">
            <xsl:call-template name="calcSeqNum">
               <xsl:with-param name="creationTime">
                  <xsl:value-of select="../../c:eventCommon/ns0:creationTime"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:attribute>
         <floatingCondition>
            <xsl:call-template name="benchmark"/>
            <xsl:call-template name="endDate"/>
            <xsl:call-template name="firstBenchmarkDate"/>
            <xsl:call-template name="firstResetDate"/>
            <xsl:call-template name="interestRate"/>
            <xsl:call-template name="maximumRate"/>
            <xsl:call-template name="minimumRate"/>
            <xsl:call-template name="resetFrequencyNumber"/>
            <xsl:call-template name="resetFrequencyUnit"/>
            <xsl:call-template name="spreadRate"/>
            <xsl:call-template name="scheduledDate"/>
            <xsl:call-template name="validityDate"/>
			<xsl:call-template name="userDefinedField"/>
            <xsl:call-template name="mbFields"/>
            <xsl:call-template name="instrument"/>
         </floatingCondition>
      </Event>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\..\..\GWPACK_6.3.2\gwpack\XML Schema\FiPMS.xsd" destSchemaRoot="FiPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" srcSchemaRoot="AAAFlow" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="batch:BatchAAAFlow">
				<block path="xsl:element/xsl:apply-templates" x="322" y="126"/>
			</template>
			<template match="c:interestrecords/a:intRateDetails">
				<block path="Event/xsl:attribute/xsl:value-of" x="322" y="95"/>
				<block path="Event/xsl:attribute/xsl:value-of/name[1]" x="276" y="117"/>
				<block path="Event/xsl:attribute[1]/xsl:call-template" x="362" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template" x="282" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[1]" x="242" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[2]" x="202" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[3]" x="162" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[4]" x="122" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[5]" x="82" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[6]" x="42" y="95"/>
				<block path="Event/floatingCondition/xsl:call-template[7]" x="322" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[8]" x="362" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[9]" x="282" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[10]" x="242" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[11]" x="202" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[12]" x="162" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[13]" x="122" y="55"/>
				<block path="Event/floatingCondition/xsl:call-template[14]" x="82" y="55"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->