<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderAcknowledgment"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOrderAcknowledgment" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderAcknowledgment" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOrderAcknowledgment" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Allow only if SCENARIO 1 OR SCENARIO 2 conditions are satisfied -->
	<!-- Common filter for scenarios 1 and 2 -->
	<xsl:template match="b:OrderAcknowledgment">
		<xsl:apply-templates select="self::b:OrderAcknowledgment[b:tapRefId and b:tapRefId != '']" mode="filter1.1"/>
	</xsl:template>

	<!--- BEG - SCENARIO 1 - If any condition fails, jump to SCENARIO 2 filter checks. -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter1.1">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'OrderAcknowledgment'"/>
				<xsl:with-param name="memoAccount" select="b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$checkPortfolioConditionVar = 'true'">
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter1.2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter1.2">
		<xsl:choose>
			<xsl:when test="b:SubAssetTypeSecurityMasterJoin">
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter1.3"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter1.3">
		<xsl:choose>
			<xsl:when test="$ScB2FAcknowledgmentActive = 'Y' and (  
			                 (starts-with(b:tapRefId,'D') and b:dealStatus= 'TRANSMITTED') or 
			                 (starts-with(b:tapRefId,'I') and (b:dealStatus= 'GROUPED' or not(b:dealStatus) or b:dealStatus = '')) or 
			                 (starts-with(b:tapRefId,'I') and (b:dealStatus= 'TRANSMITTED')))">
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter-custo"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--- END - SCENARIO 1 -->

	<!-- OR -->

	<!--- BEG - SCENARIO 2 -->
	<!-- Condition 1 -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter2">
		<xsl:param name="memoAccount" select="b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin"/>
		<xsl:apply-templates select="self::b:OrderAcknowledgment[$memoAccount= 'YES' or $memoAccount = 'Y']" mode="filter2.1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter2.1">
		<xsl:apply-templates select="self::b:OrderAcknowledgment[b:parent = 'YES' or b:parent = 'Y']" mode="filter2.2"/>
	</xsl:template>
	
    <!-- Condition 3 -->
    <xsl:template match="b:OrderAcknowledgment" mode="filter2.2">
        <xsl:apply-templates select="self::b:OrderAcknowledgment[$ScB2FAcknowledgmentActive = 'Y']" mode="filter-custo"/>
    </xsl:template>
    
	
	<!--- END - SCENARIO 2 -->

	<!-- Custo placeholder -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter-custo">
		<xsl:apply-templates select="self::b:OrderAcknowledgment" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:OrderAcknowledgment" mode="filter-final">
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