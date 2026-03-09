<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FullPartialExecution" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFullPartialExecution"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFullPartialExecution" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFullPartialExecution"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FullPartialExecution">
		<xsl:apply-templates select="self::b:FullPartialExecution[b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:FullPartialExecution" mode="filter1">
		<xsl:apply-templates select="self::b:FullPartialExecution[not(b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:FullPartialExecution" mode="filter2">
		<xsl:apply-templates select="self::b:FullPartialExecution[b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:FullPartialExecution" mode="filter3">
		<xsl:apply-templates select="self::b:FullPartialExecution[b:cuAllotedAmountList/b:cuAllotedAmount != '' and b:cuAllotedAmountList/b:cuAllotedAmount = '0']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:FullPartialExecution" mode="filter4">
		<xsl:apply-templates select="self::b:FullPartialExecution[b:scStdSecTradeChargeTime = 'EXECUTION']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FullPartialExecution" mode="filter-custo">
		<xsl:apply-templates select="self::b:FullPartialExecution" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FullPartialExecution" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->