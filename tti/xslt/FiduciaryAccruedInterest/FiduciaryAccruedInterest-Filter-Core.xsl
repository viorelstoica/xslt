<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrderCob" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:FdFidOrderCob">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'FiduciaryAccruedInterest'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeList/b:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFidOrderCob[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>

    <!-- Condition 2 -->
    <xsl:template match="b:FdFidOrderCob" mode="filter1">
        <xsl:apply-templates select="self::b:FdFidOrderCob[b:eventCommon/ns0:application = 'FD.SOD.PERFORM.ACCRUALS' or b:eventCommon/ns0:application = 'FD.EOD.PERFORM.ACCRUALS']" mode="filter-custo"/>
    </xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:FdFidOrderCob" mode="filter-custo">
		<xsl:apply-templates select="self::b:FdFidOrderCob" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FdFidOrderCob" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\ChronologicalDataCAAccruedInterestsLoad\ChronologicalDataCAAccruedInterestsLoad_Custo.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->