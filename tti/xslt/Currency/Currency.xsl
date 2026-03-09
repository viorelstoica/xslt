<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Currency" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCurrency" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCurrency" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCurrency" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiCurrency">
      <xsl:apply-templates select="c:CurrentEvent/b:Currency"/>
   </xsl:template>
   <xsl:template match="batch:BatchCurrency">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCurrency" name="BatchCurrency">
         <xsl:apply-templates select="b:Currency"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiCurrency">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCurrency" name="BatchMultiCurrency">
         <xsl:apply-templates select="c:MultiCurrency"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:Currency">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('currency',b:currencyCode)"/>
         </xsl:attribute>
         <DataGroup>
            <Country>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('Currency.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code_Country"/>
               <xsl:call-template name="synonym_Country"/>
               <xsl:call-template name="shortName_Country"/>
               <xsl:call-template name="longName_Country"/>
               <xsl:call-template name="multilingualLongName_Country"/>
               <xsl:call-template name="notepad_Country"/>
               <xsl:call-template name="userDefinedField_Country"/>
               <xsl:call-template name="mbFields_Country"/>
               <xsl:call-template name="currency_Country"/>
               <xsl:call-template name="nature_Country"/>
            </Country>
            <Currency>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('Currency.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code_Currency"/>
               <xsl:call-template name="synonym_Currency"/>
               <xsl:call-template name="shortName_Currency"/>
               <xsl:call-template name="longName_Currency"/>
               <xsl:call-template name="multilingualLongName_Currency"/>
               <xsl:call-template name="notepad_Currency"/>
               <xsl:call-template name="userDefinedField_Currency"/>
               <xsl:call-template name="mbFields_Currency"/>
               <xsl:call-template name="country_Currency"/>
               <xsl:call-template name="euroConvertionDate_Currency"/>
               <xsl:call-template name="euroExchangeRate_Currency"/>
               <xsl:call-template name="rank_Currency"/>
               <xsl:call-template name="roundingRule_Currency"/>
               <xsl:call-template name="roundingUnit_Currency"/>
            </Currency>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Currency" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Currency\Currency.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Currency\CurrencyCusto.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->