<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/AutoUnblock" xmlns:b="http://www.temenos.com/T24/event/TTI/UnlockingTransaction" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchUnlockingTransaction"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:UnlockingTransaction">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'UnlockingTransaction'"/>
				<xsl:with-param name="memoAccount" select="b:autoUnblockRec/ns1:memoAccount"/>
				<xsl:with-param name="dealerBook" select="b:autoUnblockRec/ns1:dealerBook"/>
				<xsl:with-param name="customerType" select="b:autoUnblockRec/ns1:customerType"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:UnlockingTransaction[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:UnlockingTransaction" mode="filter1">
		<xsl:apply-templates select="self::b:UnlockingTransaction[($g_filterBySubAssetType='Y' and b:autoUnblockRec/ns1:subAssetType and contains($list_SubAssetType_LockingTransaction,concat(' ',b:autoUnblockRec/ns1:subAssetType,' '))) or
										($g_filterBySubAssetType != 'Y' and b:autoUnblockRec/ns1:subAssetTypeTapInstrType and (b:autoUnblockRec/ns1:subAssetTypeTapInstrType='STOCK' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='MUTUALFUND' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='FIXEDINCOME' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='CONVBOND' or 
									 b:autoUnblockRec/ns1:subAssetTypeTapInstrType='DISCINSTR' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='COMMODITY' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='AIRBAGCERT' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='BONUSNOTES' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:autoUnblockRec/ns1:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='DISCOUNTCERT' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='TWINWINCERT' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:autoUnblockRec/ns1:subAssetTypeTapInstrType='REVCONVEQLK' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='REVCONVCREDLK' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:autoUnblockRec/ns1:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:UnlockingTransaction" mode="filter-custo">
		<xsl:apply-templates select="self::b:UnlockingTransaction" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:UnlockingTransaction" mode="filter-final">
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