<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/F2B"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXT24StatusChange"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="buySellIndicator"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="channel"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="limitPrice"/>
   <xsl:template name="notepad"/>
   <xsl:template name="omsOrderReference">
      <omsOrderReference>
         <xsl:value-of select="substring-before(b:id,'-')"/>
      </omsOrderReference>
   </xsl:template>
   <xsl:template name="orderMode"/>
   <xsl:template name="orderPriceType"/>
   <xsl:template name="orderStatus">
      <orderStatus>
         <xsl:choose>
            <xsl:when test="b:orderStatus = 'TRANSMITTED'">
               <xsl:value-of select=" '70' "/>
            </xsl:when>
            <xsl:when test="b:orderStatus = 'REJECTED'">
               <xsl:value-of select=" '15' "/>
            </xsl:when>
         </xsl:choose>
      </orderStatus>
   </xsl:template>
   <xsl:template name="orderType"/>
   <xsl:template name="orderValidityType"/>
   <xsl:template name="pmsOrderReference">
      <pmsOrderReference>
         <xsl:value-of select="b:tapRefId"/>
      </pmsOrderReference>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:priSecAccGroup[@index='1']/b:priSecAcc"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="priceRule"/>
   <xsl:template name="quantity"/>
   <xsl:template name="remark"/>
   <xsl:template name="security"/>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="substring-before(b:id,'-')"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="stockExchange"/>
   <xsl:template name="stopPrice"/>
   <xsl:template name="subType"/>
   <xsl:template name="switchFrom"/>
   <xsl:template name="switchTo"/>
   <xsl:template name="tradeType"/>
   <xsl:template name="type"/>
   <xsl:template name="validityDate"/>
   <xsl:template name="userDefinedField">
      <userDefinedField>
         <infra:name>account</infra:name>
         <infra:value>
            <xsl:value-of select="b:priSecAccGroup[@index='1']/b:priAccount"/>
         </infra:value>
         <infra:type>string</infra:type>
      </userDefinedField>
   </xsl:template>
   <xsl:template name="mbFields"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///c:/Users/vdi/Desktop/20160921_145700_488_48_prefilter_DXT24StatusChange_b3b3b21f-59f0-4cb1-b441-6c58bdaca07f.xml" htmlbaseurl=""
		          outputurl="file:///c:/Users/vdi/Desktop/20160921_145700_488_48_prefilter_DXT24StatusChange_b3b3b21f-59f0-4cb1-b441-6c58bdaca07fOUT.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
