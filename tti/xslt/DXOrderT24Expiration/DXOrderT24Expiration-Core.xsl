<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" 
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderT24Expiration" 
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXOrderT24Expiration"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXOrderT24Expiration" 
                xmlns:ns1="http://www.temenos.com/T24/OrderService/OrderExpiry"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" 
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderT24Expiration" 
                exclude-result-prefixes="b c batch multibatch ns1" version="1.0">
   <xsl:template name="buySellIndicator"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="channel"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="limitPrice"/>
   <xsl:template name="notepad"/>
   <xsl:template name="omsOrderReference">
      <omsOrderReference>
         <xsl:value-of select="substring-before(b:orderexpiry/ns1:idOrder,'-')"/>
      </omsOrderReference>
   </xsl:template>
   <xsl:template name="orderMode"/>
   <xsl:template name="orderPriceType"/>
   <xsl:template name="orderStatus">
      <orderStatus>5</orderStatus>
   </xsl:template>
   <xsl:template name="orderType"/>
   <xsl:template name="orderValidityType"/>
   <xsl:template name="pmsOrderReference">
      <pmsOrderReference>
         <xsl:value-of select="b:orderexpiry/ns1:tapRefId"/>
      </pmsOrderReference>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:orderexpiry/ns1:priSecAcc"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="priceRule"/>
   <xsl:template name="quantity"/>
   <xsl:template name="remark"/>
   <xsl:template name="security"/>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="substring-before(b:orderexpiry/ns1:idOrder,'-')"/>
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
            <xsl:value-of select="b:orderexpiry/ns1:priAcc"/>
         </infra:value>
         <infra:type>string</infra:type>
      </userDefinedField>
   </xsl:template>
   <xsl:template name="mbFields"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="file:///c:/Users/vdi/Desktop/20160921_145700_488_48_prefilter_DXOrderT24Expiration_b3b3b21f-59f0-4cb1-b441-6c58bdaca07f.xml" htmlbaseurl=""
		          outputurl="file:///c:/Users/vdi/Desktop/20160921_145700_488_48_prefilter_DXOrderT24Expiration_b3b3b21f-59f0-4cb1-b441-6c58bdaca07fOUT.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength=""
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
