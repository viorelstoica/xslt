<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecTradeScSettlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecTradeScSettlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecTradeScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecTradeScSettlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - Filter custSecAcc -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc">
		<xsl:variable name="index" select="../@index"/>
		<xsl:variable name="index1">
						<xsl:for-each select="../../b:custSecAccCustomerTypeJoinGroup[@index = $index]/b:custSecAccCustomerTypeJoinList/b:custSecAccCustomerTypeJoin">
						<xsl:if test=". = 'CUSTOMER'">
							<xsl:value-of select="@index"/>
						</xsl:if>
						</xsl:for-each>
					</xsl:variable>
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'SecTradeSellActualSettlement'"/>
				<xsl:with-param name="memoAccount" select="../../b:custSecAccMemoAccountList/b:custSecAccMemoAccount[@index = $index]"/>
				<xsl:with-param name="dealerBook" select="../../b:custSecAccDealerBookList/b:custSecAccDealerBook[@index = $index]"/>
				<xsl:with-param name="customerType" select="../../b:custSecAccCustomerTypeJoinGroup[@index = $index]/b:custSecAccCustomerTypeJoinList/b:custSecAccCustomerTypeJoin[@index = $index1]"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::node()[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc" mode="filter1">
		<xsl:variable name="index" select="../@index"/>
		<xsl:apply-templates select="self::node()[contains($list_TransCode_TransactionSecuritySell,../b:custTransCode) or (contains($peFundsTransCodeSell,../b:custTransCode) and ../../b:peFund= 'YES' and (../../b:peType = 'CAPITAL CALL' or ../../b:peType = 'ACTUAL PE SECURITY'))]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter custSecAcc -->

	<!-- BEG - Filter Whole Record -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecTradeScSettlement">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecTradeScSettlement[$opStatus = 'INPUT-AUTHORISE' or $opStatus = 'AUTHORISE' or $opStatus = 'JOB-PROCESS']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter1">
		<xsl:apply-templates select="self::b:SecTradeScSettlement[($g_filterBySubAssetType='Y' and b:subAssetType and contains($list_SubAssetType_TransactionSecuritySell,b:subAssetType)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or 
									 b:subAssetTypeTapInstrType='CONVBOND' or b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or
									 b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or 
									 b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or b:subAssetTypeTapInstrType='REVCONVEQLK' or 
									 b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter2">
		<xsl:apply-templates select="self::b:SecTradeScSettlement[b:cashHoldSettle = 'YES' or b:SecHoldSettle = 'YES']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter3">
		<xsl:apply-templates select="self::b:SecTradeScSettlement[b:application = 'SEC.TRADE']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 Donot Filter if atleast one b:customerNoGroup/b:custSecAcc" remains after applying filter on these groups -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter4">
		<xsl:variable name="ifFilterWholeRecord">
			<xsl:for-each select="b:customerNoGroup/b:custSecAcc">
				<xsl:variable name="index" select="../@index"/>
				<xsl:variable name="index1">
						<xsl:for-each select="../../b:custSecAccCustomerTypeJoinGroup[@index = $index]/b:custSecAccCustomerTypeJoinList/b:custSecAccCustomerTypeJoin">
						<xsl:if test=". = 'CUSTOMER'">
							<xsl:value-of select="@index"/>
						</xsl:if>
						</xsl:for-each>
					</xsl:variable>
				<xsl:variable name="checkPortfolioConditionVar">
					<xsl:call-template name="checkPortfolioCondition">
						<xsl:with-param name="xsltName" select="'SecTradeSellActualSettlement'"/>
						<xsl:with-param name="memoAccount" select="../../b:custSecAccMemoAccountList/b:custSecAccMemoAccount[@index = $index]"/>
						<xsl:with-param name="dealerBook" select="../../b:custSecAccDealerBookList/b:custSecAccDealerBook[@index = $index]"/>
						<xsl:with-param name="customerType" select="../../b:custSecAccCustomerTypeJoinGroup[@index = $index]/b:custSecAccCustomerTypeJoinList/b:custSecAccCustomerTypeJoin[@index = $index1]"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$checkPortfolioConditionVar = 'true' and (contains($list_TransCode_TransactionSecuritySell,../b:custTransCode) or (contains($peFundsTransCodeSell,../b:custTransCode) and ../../b:peFund= 'YES' and (../../b:peType = 'CAPITAL CALL' or ../../b:peType = 'ACTUAL PE SECURITY')))">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecTradeScSettlement[contains($ifFilterWholeRecord,'Y')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecTradeScSettlement" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SecTradeScSettlement" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter Whole Record -->
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