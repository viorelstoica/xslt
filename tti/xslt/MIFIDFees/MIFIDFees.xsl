<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiMIFID">
		<xsl:apply-templates select="c:CurrentEvent/b:MIFID"/>
	</xsl:template>
	<xsl:template match="batch:BatchMIFID">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMIFID" name="BatchMIFID">
			<xsl:apply-templates select="b:MIFID"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiMIFID">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" name="BatchMultiMIFID">
			<xsl:apply-templates select="c:MultiMIFID"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:MIFID">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('MIFID',b:id)"/>
			</xsl:attribute>
			<xsl:for-each select="b:codeGroup/b:code">
				<xsl:call-template name="mappingProductFees"/>
			</xsl:for-each>
		</FiPMS>
	</xsl:template>
	<xsl:template name="mappingProductFees">
		<DataGroup>
			<ProductFees>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('MIFIDFees.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="calculationRule"/>
				<xsl:call-template name="currency"/>
				<xsl:call-template name="category"/>
				<xsl:call-template name="dataNature"/>
				<xsl:call-template name="exanteExpost"/>
				<xsl:call-template name="feeType"/>
				<xsl:call-template name="instrument"/>
				<xsl:call-template name="maximumRange"/>
				<xsl:call-template name="minimumRange"/>
				<xsl:call-template name="rank"/>
				<xsl:call-template name="validity"/>
				<xsl:call-template name="value"/>
				<xsl:call-template name="quotationCode"/>
				<xsl:call-template name="userDefinedField"/>
				<xsl:call-template name="mbFields"/>
			</ProductFees>
		</DataGroup>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryCusto.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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