<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferDelete"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferDelete" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferDelete" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferDelete" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionTransferDelete">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferDelete[$opStatus = 'INPUT-DELETE' or $opStatus = 'HOLD-DELETE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferDelete" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferDelete[not(b:secHoldSettle) or b:secHoldSettle != 'Yes']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferDelete" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferDelete[b:secAcctFrom and b:secAcctTo and (b:secAcctFrom != b:secAcctTo)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferDelete" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferDelete[b:memoAccountSecurityAccountFrom = 'NO' and b:memoAccountSecurityAccountTo = 'NO']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferDelete" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferDelete[not(b:dealerBookSecurityAccountFrom) and not(b:dealerBookSecurityAccountTo)]" mode="filter5"/>
	</xsl:template>
	<xsl:template match="b:PositionTransferDelete" mode="filter5">
		<xsl:apply-templates select="self::b:PositionTransferDelete[b:customerTypeSecurityAccountFromJoinList/b:customerTypeSecurityAccountFromJoin = 'CUSTOMER' and b:customerTypeSecurityAccountToJoinList/b:customerTypeSecurityAccountToJoin = 'CUSTOMER']" mode="filter6"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:PositionTransferDelete" mode="filter6">
		<xsl:apply-templates select="self::b:PositionTransferDelete[b:tapRefId and b:tapRefId != '']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferDelete" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferDelete" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferDelete" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\..\DailyTrack\TTI-2686\PrefilterSecurityTransferDelete.xml" htmlbaseurl=""
		          outputurl="..\..\..\..\..\DailyTrack\TTI-2686\PostfilterSecurityTransferDelete.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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