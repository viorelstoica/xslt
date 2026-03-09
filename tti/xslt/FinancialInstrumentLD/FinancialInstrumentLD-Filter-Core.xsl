<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDeposits" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDeposits"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDeposits" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDeposits"
                exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:LdLoansAndDeposits">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[b:cusPortId != '']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter1">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[b:memoAccount = 'NO']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter2">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[b:dealerBook = '' or not(b:dealerBook)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter3">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter4"/>
	</xsl:template>

	<!-- Condition 5 -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter4">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[b:status = 'CUR']" mode="filter5"/>
	</xsl:template>

	<!-- Condition 6 -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter5">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits[('21050' &lt;= b:category and b:category &lt;= '21074') or ('21001' &lt;= b:category and b:category &lt;= '21039') or ('21045' &lt;= b:category and b:category &lt;= '21049')]" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter-custo">
		<xsl:apply-templates select="self::b:LdLoansAndDeposits" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:LdLoansAndDeposits" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionFiduciaryInitiate" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionFiduciaryInitiate\TransactionFiduciaryInitiate.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionFiduciaryInitiate\TransactionFiduciaryInitiateCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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