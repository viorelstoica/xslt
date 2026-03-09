<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderT24Expiration" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXOrderT24Expiration" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXOrderT24Expiration" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderT24Expiration" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiDXOrderT24Expiration">
      <xsl:apply-templates select="c:CurrentEvent/b:DXOrderT24Expiration"/>
   </xsl:template>
   <xsl:template match="batch:BatchDXOrderT24Expiration">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDXOrderT24Expiration" name="BatchDXOrderT24Expiration">
         <xsl:apply-templates select="b:DXOrderT24Expiration"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiDXOrderT24Expiration">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderT24Expiration" name="BatchMultiDXOrderT24Expiration">
         <xsl:apply-templates select="c:MultiDXOrderT24Expiration"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:DXOrderT24Expiration">
      <F2B>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('DXOrderT24Expiration',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('DXOrderT24Expiration.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <OrderLifeCycle>
                  <Acknowledgment>
                     <xsl:call-template name="buySellIndicator"/>
                     <xsl:call-template name="cashPortfolio"/>
                     <xsl:call-template name="channel"/>
                     <xsl:call-template name="contractNumber"/>
                     <xsl:call-template name="limitPrice"/>
                     <xsl:call-template name="notepad"/>
                     <xsl:call-template name="omsOrderReference"/>
                     <xsl:call-template name="orderMode"/>
                     <xsl:call-template name="orderPriceType"/>
                     <xsl:call-template name="orderStatus"/>
                     <xsl:call-template name="orderType"/>
                     <xsl:call-template name="orderValidityType"/>
                     <xsl:call-template name="pmsOrderReference"/>
                     <xsl:call-template name="portfolio"/>
                     <xsl:call-template name="priceRule"/>
                     <xsl:call-template name="quantity"/>
                     <xsl:call-template name="remark"/>
                     <xsl:call-template name="security"/>
                     <xsl:call-template name="sourceSystemCode"/>
                     <xsl:call-template name="stockExchange"/>
                     <xsl:call-template name="stopPrice"/>
                     <xsl:call-template name="subType"/>
                     <xsl:call-template name="switchFrom"/>
                     <xsl:call-template name="switchTo"/>
                     <xsl:call-template name="tradeType"/>
                     <xsl:call-template name="type"/>
                     <xsl:call-template name="validityDate"/>
                     <xsl:call-template name="userDefinedField"/>
                     <xsl:call-template name="mbFields"/>
                  </Acknowledgment>
               </OrderLifeCycle>
            </Security>
         </DataGroup>
      </F2B>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="DXOrderT24Expiration" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DXOrderT24Expiration\DXOrderT24Expiration.xml" htmlbaseurl="" outputurl="..\..\TestFiles\DXOrderT24Expiration\DXOrderT24ExpirationGWP.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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