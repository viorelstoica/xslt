<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecuritySell" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecuritySell"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecuritySell" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecuritySell"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:TransactionSecuritySell">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:TransactionSecuritySell[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:TransactionSecuritySell" mode="filter1">
		<xsl:apply-templates select="self::b:TransactionSecuritySell[($g_filterBySubAssetType='Y' and b:subAssetTypeJoin and contains($list_SubAssetType_TransactionSecuritySell,b:subAssetTypeJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
									 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:TransactionSecuritySell" mode="filter2">
		<xsl:variable name="ifFilterWholeRecord">
			<xsl:for-each select="b:customerNoGroup/b:custSecAcc">
				<xsl:variable name="index" select="../@index"/>
				<xsl:variable name="index1">
						<xsl:for-each select="../../b:customerTypeCustomerSecurityJoinGroup[@index = $index]/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin">
						<xsl:if test=". = 'CUSTOMER'">
							<xsl:value-of select="@index"/>
						</xsl:if>
						</xsl:for-each>
					</xsl:variable>
				<xsl:variable name="checkPortfolioConditionVar">
					<xsl:call-template name="checkPortfolioCondition">
						<xsl:with-param name="xsltName" select="'TransactionSecuritySell'"/>
						<xsl:with-param name="memoAccount" select="../../b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin[@index = $index]"/>
						<xsl:with-param name="dealerBook" select="../../b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin[@index = $index]"/>
						<xsl:with-param name="customerType" select="../../b:customerTypeCustomerSecurityJoinGroup[@index = $index]/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin[@index = $index1]"/>
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
		<xsl:apply-templates select="self::b:TransactionSecuritySell[contains($ifFilterWholeRecord,'Y')]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:TransactionSecuritySell" mode="filter3">
		<xsl:apply-templates select="self::b:TransactionSecuritySell[(b:parent != 'YES' or not(b:parent))]" mode="filter-custo"/>
	</xsl:template>	
	<!-- Custo placeholder -->
	<xsl:template match="b:TransactionSecuritySell" mode="filter-custo">
		<xsl:apply-templates select="self::b:TransactionSecuritySell" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:TransactionSecuritySell" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc">
		<xsl:variable name="index" select="../@index"/>
		<xsl:variable name="index1">
						<xsl:for-each select="../../b:customerTypeCustomerSecurityJoinGroup[@index = $index]/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin">
						<xsl:if test=". = 'CUSTOMER'">
							<xsl:value-of select="@index"/>
						</xsl:if>
						</xsl:for-each>
					</xsl:variable>
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionSecuritySell'"/>
				<xsl:with-param name="memoAccount" select="../../b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin[@index = $index]"/>
				<xsl:with-param name="dealerBook" select="../../b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin[@index = $index]"/>
				<xsl:with-param name="customerType" select="../../b:customerTypeCustomerSecurityJoinGroup[@index = $index]/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin[@index = $index1]"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::node()[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc" mode="filter1">
		<xsl:variable name="index" select="../@index"/>
		<xsl:apply-templates select="self::node()[contains($list_TransCode_TransactionSecuritySell,../b:custTransCode) or (contains($peFundsTransCodeSell,../b:custTransCode) and ../../b:peFund= 'YES' and (../../b:peType = 'CAPITAL CALL' or ../../b:peType = 'ACTUAL PE SECURITY'))]"
		                     mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:customerNoGroup/b:custSecAcc" mode="filter2">
		<xsl:variable name="index" select="../@index"/>
		<xsl:apply-templates select="self::node()[not(contains($sectPendTransNamesOutSupportedTypes,../b:custTransCode))]" mode="filter-custo"/>
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
</xsl:stylesheet>