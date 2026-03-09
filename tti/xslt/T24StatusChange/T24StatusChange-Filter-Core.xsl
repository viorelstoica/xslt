<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/T24StatusChange"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchT24StatusChange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiT24StatusChange" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiT24StatusChange" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:T24StatusChange">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'T24StatusChange'"/>
				<xsl:with-param name="memoAccount" select="b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:T24StatusChange[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:T24StatusChange" mode="filter1">
		<xsl:apply-templates select="self::b:T24StatusChange[($g_filterBySubAssetType='Y' and b:SubAssetTypeSecurityMasterJoin and contains($list_SubAssetType_T24StatusChange,b:SubAssetTypeSecurityMasterJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
									 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:T24StatusChange" mode="filter2">
		<xsl:apply-templates select="self::b:T24StatusChange[((b:dealStatus = 'TRANSMITTED' or b:dealStatus = 'CANCELLED') and not(b:orderStatus)) or (b:dealStatus = 'TRANSMITTED' and b:orderStatus = 'ACCEPTED' and ../../c:PreviousEvent/b:T24StatusChange/b:orderStatus = 'SENT' and not(b:nominalRecdGroup/b:nominalRecd))]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:T24StatusChange" mode="filter3">
		<xsl:apply-templates select="self::b:T24StatusChange[b:parent = 'NO' or not(b:parent)]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:T24StatusChange" mode="filter4">
		<xsl:apply-templates select="self::b:T24StatusChange[not(b:dealStatus = ../../c:PreviousEvent/b:T24StatusChange/b:dealStatus) or ((b:dealStatus = ../../c:PreviousEvent/b:T24StatusChange/b:dealStatus) and b:orderStatus)]" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:T24StatusChange" mode="filter5">
		<xsl:apply-templates select="self::b:T24StatusChange[starts-with(b:tapRefId,'I')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:T24StatusChange" mode="filter-custo">
		<xsl:apply-templates select="self::b:T24StatusChange" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:T24StatusChange" mode="filter-final">
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