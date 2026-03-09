<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/T24StatusChangeCancelUpdate"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchT24StatusChangeCancelUpdate" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiT24StatusChangeCancelUpdate" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiT24StatusChangeCancelUpdate" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 - Portfolio Filter -->
	<xsl:template match="b:T24StatusChangeCancelUpdate">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'T24StatusChangeCancelUpdate'"/>
				<xsl:with-param name="memoAccount" select="b:memoSecAccMasterJoinList/b:memoSecAccMasterJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerSecAccMasterJoinList/b:dealerSecAccMasterJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[$checkPortfolioConditionVar = 'true']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter1">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[($g_filterBySubAssetType='Y' and b:SubAssetTypeSecurityMasterJoin and contains($list_SubAssetType_T24StatusChangeCancelUpdate,b:SubAssetTypeSecurityMasterJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
									 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter2">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[b:parent = 'NO' or not(b:parent)]" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter3">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[starts-with(b:tapRefId,'I')]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter4">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[b:currNo != '1']" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter5">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[(../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:dealStatus = 'CANCELLED' and  ../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus != 'Int Cancellation Accepted') or (../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus  = 'Cancellation Rejected') or (../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:dealStatus = '' or not(../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:dealStatus) and (../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus != 'Cancellation Requested' or ../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus ='' or not(../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus))  ) or (../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:dealStatus = 'TRANSMITTED' and ../../c:PreviousEvent/b:T24StatusChangeCancelUpdate/b:dealStatus = 'TRANSMITTED' and (../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus != 'Cancellation Requested' or ../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus ='' or not(../../c:CurrentEvent/b:T24StatusChangeCancelUpdate/b:orderStatus)))]"
		                     mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter6">
		<xsl:variable name="operationStatusValue">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage">
					<xsl:value-of select="b:eventCommon/ns0:transactionStage"/>
				</xsl:with-param>
				<xsl:with-param name="recordStatus">
					<xsl:value-of select="b:recordStatus"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate[($operationStatusValue != 'INPUT-INPUT') and ($operationStatusValue != 'REVERSE-INPUT') and ($operationStatusValue != 'REVERSE-AUTHORISE')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter-custo">
		<xsl:apply-templates select="self::b:T24StatusChangeCancelUpdate" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:T24StatusChangeCancelUpdate" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>