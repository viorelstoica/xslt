<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/DepositsLoansFloatingCondition"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDepositsLoansFloatingCondition" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDepositsLoansFloatingCondition" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDepositsLoansFloatingCondition" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DepositsLoansFloatingCondition">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[b:idComp2 = 'DEPOSITINT' or b:idComp2 = 'PRINCIPALINT']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter1">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[b:rateTierType = 'SINGLE']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter2">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[b:periodicIndexGroup/b:periodicIndex != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter3">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[b:arrStatusAAArrangementJoin]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter4">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[contains($list_ArrStatus_Activ_DepositsLoansFloatingCondition,concat(' ',b:arrStatusAAArrangementJoin,' '))]" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter5">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition[not(contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD'))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter-custo">
		<xsl:apply-templates select="self::b:DepositsLoansFloatingCondition" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:DepositsLoansFloatingCondition" mode="filter-final">
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