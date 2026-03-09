<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolio" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolio" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:Portfolio">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'Portfolio'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:dealerBook"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:Portfolio[$checkPortfolioConditionVar = 'true']" mode="filter3"/>
	</xsl:template>
	
	<!-- Condition 3 -->
	<xsl:template match="b:Portfolio" mode="filter3">
    <xsl:copy>
        <xsl:apply-templates select="@* | node()[not(self::b:accountNosGroup or self::b:incAccountNoGroup)]"/>

        <xsl:for-each select="b:accountNosGroup">
            <xsl:variable name="currIndex" select="@index"/>
            <xsl:variable name="categoryValue" select="../b:accountNosCategoryJoinList/b:accountNosCategoryJoin[@index = $currIndex]"/>
            <xsl:variable name="IsSuspenseAccountCategoryVar">
                <xsl:call-template name="IsSuspenseAccountCategory">
                    <xsl:with-param name="category" select="$categoryValue"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:if test="(number($categoryValue) &gt;= 1001 and number($categoryValue) &lt;= 1998) or ($IsSuspenseAccountCategoryVar = 'true')">
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>

        <xsl:for-each select="b:incAccountNoGroup">
            <xsl:variable name="currIndex" select="@index"/>
            <xsl:variable name="categoryValue" select="../b:incAccountNoCategoryJoinList/b:incAccountNoCategoryJoin[@index = $currIndex]"/>
            <xsl:variable name="IsSuspenseAccountCategoryVar">
                <xsl:call-template name="IsSuspenseAccountCategory">
                    <xsl:with-param name="category" select="$categoryValue"/>
                </xsl:call-template>
            </xsl:variable>

            <xsl:if test="(number($categoryValue) &gt;= 1001 and number($categoryValue) &lt;= 1998) or ($IsSuspenseAccountCategoryVar = 'true')">
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:if>
        </xsl:for-each>
    </xsl:copy>
</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:Portfolio" mode="filter-custo">
		<xsl:apply-templates select="self::b:Portfolio" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:Portfolio" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>