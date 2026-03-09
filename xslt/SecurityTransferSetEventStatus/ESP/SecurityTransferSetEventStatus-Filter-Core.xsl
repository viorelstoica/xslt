<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecurityTransfer">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecurityTransfer[$opStatus = 'INPUT-DELETE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecurityTransfer" mode="filter1">
		<xsl:apply-templates select="self::b:SecurityTransfer[contains($f2bSecurityTransferInType,concat(' ',b:transactionType,' ')) or contains($f2bSecurityTransferOutType,concat(' ',b:transactionType,' '))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecurityTransfer" mode="filter2">
		<xsl:apply-templates select="self::b:SecurityTransfer[contains($f2bSecurityTransferFREDeliveryInstr,concat(' ',b:deliveryInstr,' '))]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:SecurityTransfer" mode="filter3">
		<xsl:apply-templates select="self::b:SecurityTransfer[b:tapRefId and b:tapRefId != '']" mode="filter4"/>
	</xsl:template>
    <!-- Condition 5 -->
	<xsl:template match="b:SecurityTransfer" mode="filter4">
		<xsl:apply-templates select="self::b:SecurityTransfer[b:transferCancel and b:transferCancel = 'Cancellation.Accepted']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SecurityTransfer" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecurityTransfer" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SecurityTransfer" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\supdate.xml" htmlbaseurl="" outputurl="..\..\supdatefil.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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