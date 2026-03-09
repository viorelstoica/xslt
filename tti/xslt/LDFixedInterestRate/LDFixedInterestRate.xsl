<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDepositsOldNew" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDepositsOldNew" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:param name="list_auth" select="' CURRENT AUTH-FWD '"/><!-- FILTER -->
   <xsl:template match="c:MultiLdLoansAndDepositsOldNew">
      <xsl:apply-templates select="c:CurrentEvent/b:LdLoansAndDepositsOldNew"/>
   </xsl:template>
   <xsl:template match="batch:BatchLdLoansAndDepositsOldNew">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDepositsOldNew" name="BatchLdLoansAndDepositsOldNew">
         <xsl:apply-templates select="b:LdLoansAndDepositsOldNew"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiLdLoansAndDepositsOldNew">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDepositsOldNew" name="BatchMultiLdLoansAndDepositsOldNew">
         <xsl:apply-templates select="c:MultiLdLoansAndDepositsOldNew"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:LdLoansAndDepositsOldNew"><!-- END FILTER -->
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('LDFixedInterestRate',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Event>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('LDFixedInterestRate.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <interestSchedule>
                  <xsl:call-template name="endDate"/>
                  <xsl:call-template name="interestRate"/>
                  <xsl:call-template name="scheduledDate"/>
                  <xsl:call-template name="validityDate"/>
                  <xsl:call-template name="instrument"/>
               </interestSchedule>
            </Event>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\loans and depositsoldnew\LdLoansAndDepositsOldNewfilterGWP.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\loans and depositsoldnew\FinancialInstrumentAADepositsInterestRateILCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\loans and depositsoldnew\input.xml" srcSchemaRoot="multi:MultiLdLoansAndDepositsOldNew" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="c:MultiLdLoansAndDepositsOldNew"></template>
			<template match="b:LdLoansAndDepositsOldNew">
				<block path="FiPMS/xsl:attribute[1]/xsl:value-of" x="384" y="54"/>
				<block path="FiPMS/DataGroup/Event/xsl:attribute/xsl:value-of" x="384" y="108"/>
				<block path="FiPMS/DataGroup/Event/xsl:attribute/xsl:value-of/name[1]" x="338" y="130"/>
				<block path="FiPMS/DataGroup/Event/xsl:attribute[1]/xsl:call-template" x="424" y="126"/>
				<block path="FiPMS/DataGroup/Event/interestSchedule/xsl:call-template" x="344" y="144"/>
				<block path="FiPMS/DataGroup/Event/interestSchedule/xsl:call-template[1]" x="304" y="144"/>
				<block path="FiPMS/DataGroup/Event/interestSchedule/xsl:call-template[2]" x="264" y="144"/>
				<block path="FiPMS/DataGroup/Event/interestSchedule/xsl:call-template[3]" x="224" y="144"/>
				<block path="FiPMS/DataGroup/Event/interestSchedule/xsl:call-template[4]" x="184" y="144"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->