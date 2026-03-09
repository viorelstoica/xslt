<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/StockExchange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiStockExchange" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c">

	<xsl:template name="mbFields">
		<mbFields>
			<mbField>
				<name>primary_exchange_id.code</name>
				<value>
					<xsl:if test="b:primaryExchg and b:primaryExchg !=''">
						<xsl:value-of select="concat('MKT_',b:primaryExchg)"/>
					</xsl:if>
				</value>
				<type>string</type>
			</mbField>
		</mbFields>
	</xsl:template>
	<xsl:template name="synonym">
		<xsl:if test="b:mktIdnCode and b:mktIdnCode != ''">
			<synonym>
				<xsl:call-template name="active_Stock"/>
				<xsl:call-template name="beginDate_Stock"/>
				<code>
					<xsl:value-of select="b:mktIdnCode"/>
				</code>
				<codification>
					<xsl:value-of select="'PCK_MB_EUR_MIC_CODE'"/>
				</codification>
				<xsl:call-template name="endDate_Stock"/>
				<xsl:call-template name="status_Stock"/>
				<xsl:call-template name="mbFields_Stock"/>
			</synonym>
		</xsl:if>
	</xsl:template>

	<xsl:template name="active_Stock"/>
	<xsl:template name="beginDate_Stock"/>
	<xsl:template name="endDate_Stock"/>
	<xsl:template name="status_Stock"/>
	<xsl:template name="mbFields_Stock"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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