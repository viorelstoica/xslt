<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionDerivativeMarginRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionDerivativeMarginRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionDerivativeMarginRev" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionDerivativeMarginRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionDerivativeMarginRev">
		<xsl:apply-templates select="self::b:TransactionDerivativeMarginRev[b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionDerivativeMarginRev" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionDerivativeMarginRev[not(b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionDerivativeMarginRev" mode="filter2">
		<xsl:apply-templates select="self::b:TransactionDerivativeMarginRev[b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionDerivativeMarginRev" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionDerivativeMarginRev[b:tradeStatus ='RNA' or not(b:tradeStatus)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionDerivativeMarginRev" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionDerivativeMarginRev" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:TransactionDerivativeMarginRev" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- Condition 1 -->
	<xsl:template match="b:dateGroup">
		<xsl:apply-templates select="self::b:dateGroup[b:amount !='0']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:dateGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:dateGroup" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:dateGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionDerivativeMarginRev" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionDerivativeMarginRev\TransactionDerivativeMarginRev.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionDerivativeMarginRev\TransactionDerivativeMarginRevCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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