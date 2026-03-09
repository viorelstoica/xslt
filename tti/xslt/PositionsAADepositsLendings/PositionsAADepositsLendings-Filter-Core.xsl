<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsAADepositsLendings" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsAADepositsLendings"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsAADepositsLendings" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsAADepositsLendings"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionsAADepositsLendings">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[((b:arrStatus = 'AUTH' or b:arrStatus = 'AUTH-FWD') and $AA_INTERFACE_INPUT_DEALS = 'Y') or (b:arrStatus =  'CURRENT')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter1">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[b:productLine = 'DEPOSITS' or b:productLine = 'LENDING']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
    <xsl:template match="b:PositionsAADepositsLendings" mode="filter2">
        <xsl:variable name="TotalAccr"
                      select="format-number(sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:openBalance) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:creditMvmt) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:debitMvmt),'0.00','nan2zero')"/>
        <xsl:apply-templates select="self::b:PositionsAADepositsLendings[(b:arrStatus = 'AUTH' or b:arrStatus = 'AUTH-FWD') or (b:arrStatus =  'CURRENT' and $TotalAccr != 0)]" mode="filter3"/>
    </xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter3">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[b:aaPortfolioList/b:aaPortfolio != '']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter4">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[b:arrangementId != '']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter5">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[b:memoAccountFlagList/b:memoAccountFlag = 'NO']" mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter6">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 8 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter7">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings[not(b:dealerBookList/b:dealerBook)]" mode="filter8"/>
	</xsl:template>
	<!-- Condition 9 -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter8">
		<xsl:variable name="custoCondition">
			<xsl:call-template name="aaCustoAdditionalSelectionCriteria"/>
		</xsl:variable>
		<xsl:apply-templates select="self::node()[$custoCondition = '1']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionsAADepositsLendings" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionsAADepositsLendings" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="PositionsAADepositsLendings" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PositionsAADepositsLendings\PositionsAADepositsLendings.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PositionsAADepositsLendings\PositionsAADepositsLendingsCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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