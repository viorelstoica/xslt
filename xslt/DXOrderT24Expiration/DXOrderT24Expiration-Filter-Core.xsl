<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" 
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXOrderT24Expiration" 
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXOrderT24Expiration"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXOrderT24Expiration" 
                xmlns:ns1="http://www.temenos.com/T24/OrderService/OrderExpiry"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" 
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXOrderT24Expiration" 
                exclude-result-prefixes="b c batch multibatch ns1" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DXOrderT24Expiration">
		<xsl:apply-templates select="self::b:DXOrderT24Expiration[substring(b:orderexpiry/ns1:tapRefId,1,1) = 'I'
		                                                          and (
		                                                              not(b:orderexpiry/ns1:parentChildRef) 
		                                                              or (b:orderexpiry/ns1:parentChildRef and b:orderexpiry/ns1:parentChildRef != b:orderexpiry/ns1:tapRefId)
		                                                             )
		                                                          ]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:DXOrderT24Expiration" mode="filter-custo">
		<xsl:apply-templates select="self::b:DXOrderT24Expiration" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:DXOrderT24Expiration" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="DxStockExchange" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DxStockExchange\DxStockExchange.xml" htmlbaseurl="" outputurl="..\..\TestFiles\DxStockExchange\DxStockExchangeCusto.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->