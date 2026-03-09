<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/DXT24StatusChange" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDXT24StatusChange"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDXT24StatusChange" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDXT24StatusChange" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:DXT24StatusChange">
		<xsl:apply-templates select="self::b:DXT24StatusChange[b:memoAccountList/b:memoAccount = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:DXT24StatusChange" mode="filter1">
		<xsl:apply-templates select="self::b:DXT24StatusChange[not(b:dealerBookList/b:dealerBook)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:DXT24StatusChange" mode="filter2">
		<xsl:apply-templates select="self::b:DXT24StatusChange[b:customerTypeCustomerSecurityJoinGroup[@index = '1']/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:DXT24StatusChange" mode="filter3">
		<xsl:apply-templates select="self::b:DXT24StatusChange[substring(b:tapRefId,1,1) = 'I']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:DXT24StatusChange" mode="filter4">
		<xsl:apply-templates select="self::b:DXT24StatusChange[(../../c:CurrentEvent/b:DXT24StatusChange/b:orderStatus='TRANSMITTED' and not(../../c:PreviousEvent/b:DXT24StatusChange/b:orderStatus = 'MODIFICATION REQUEST') and not(../../c:PreviousEvent/b:DXT24StatusChange/b:orderStatus = 'CANCELLATION REQUEST')) or (../../c:CurrentEvent/b:DXT24StatusChange/b:orderStatus='EXPIRED')or (../../c:CurrentEvent/b:DXT24StatusChange/b:orderStatus='REJECTED')]" mode="filter5"/>
	</xsl:template>

	<xsl:template match="b:DXT24StatusChange" mode="filter5">
		<xsl:apply-templates select="self::b:DXT24StatusChange[((b:parent = 'NO' or b:parent ='' or not(b:parent)) and b:parentChildRef !='') or (not(b:parent) and not(b:parentChildRef))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:DXT24StatusChange" mode="filter-custo">
		<xsl:apply-templates select="self::b:DXT24StatusChange" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:DXT24StatusChange" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>