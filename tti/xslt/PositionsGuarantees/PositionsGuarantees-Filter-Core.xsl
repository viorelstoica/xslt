<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsGuarantees" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsGuarantees" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsGuarantees" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsGuarantees" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionsGuarantees">
		<xsl:apply-templates select="self::b:PositionsGuarantees[b:portfolioMemoJoin = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter1">
		<xsl:apply-templates select="self::b:PositionsGuarantees[not(b:dealerBook)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter2">
		<xsl:apply-templates select="self::b:PositionsGuarantees[b:customerTypeJoinList/b:customerTypeJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter3">
		<xsl:apply-templates select="self::b:PositionsGuarantees[not(b:status = 'MAT' or b:status = 'LIQ')]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter4">
		<xsl:apply-templates select="self::b:PositionsGuarantees[contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD')]" mode="filter5"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter5">
		<xsl:apply-templates select="self::b:PositionsGuarantees[b:dealNo = b:dealNoBalancesJoin]" mode="filter6"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter6">
		<xsl:apply-templates select="self::b:PositionsGuarantees[normalize-space(b:prinBalanceJoinGroup[last()]/b:prinBalanceJoin) != '0']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:PositionsGuarantees" mode="filter7">
		<xsl:apply-templates select="self::b:PositionsGuarantees[b:contractType ='CA' or b:contractType = 'CL']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionsGuarantees" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionsGuarantees" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:PositionsGuarantees" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>


	<!-- Condition 1 -->
	<xsl:template match="b:prinBalanceJoinGroup">
		<xsl:apply-templates select="self::b:prinBalanceJoinGroup[translate(b:prinEffDateJoin,'-','') &lt;= translate(../b:eventCommon/ns0:today,'-','')]" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:prinBalanceJoinGroup" mode="filter1">
		<xsl:apply-templates select="self::b:prinBalanceJoinGroup[b:prinBalanceJoin and b:prinBalanceJoin != '0']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:prinBalanceJoinGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:prinBalanceJoinGroup" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:prinBalanceJoinGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>