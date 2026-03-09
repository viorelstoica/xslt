<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockingTransaction"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockingTransaction" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockingTransaction" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransaction" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:LockingTransaction">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'LockingTransaction'"/>
				<xsl:with-param name="memoAccount" select="b:portfolioMemoJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeJoinList/b:customerTypeJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:LockingTransaction[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:LockingTransaction" mode="filter1">
		<xsl:apply-templates select="self::b:LockingTransaction[($g_filterBySubAssetType='Y' and b:subAssetTypeJoin and contains($list_SubAssetType_LockingTransaction,concat(' ',b:subAssetTypeJoin,' '))) or
										($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
										 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
										 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
										 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:LockingTransaction" mode="filter2">
		<xsl:apply-templates select="self::b:LockingTransaction[b:product != 'SY']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:LockingTransaction" mode="filter-custo">
		<xsl:apply-templates select="self::b:LockingTransaction" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:LockingTransaction" mode="filter-final">
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