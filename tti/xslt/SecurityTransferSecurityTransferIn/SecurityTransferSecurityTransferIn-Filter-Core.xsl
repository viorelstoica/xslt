<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected  area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecurityTransfer">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecurityTransfer[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecurityTransfer" mode="filter1">
		<xsl:apply-templates select="self::b:SecurityTransfer[(b:peFund= 'YES' and contains($peFundsTransferInTypes,b:transactionType) and ((b:peType= 'ACTUAL PE SECURITY' and b:custRemarksList/b:custRemarks= 'Unit Allotment') or (b:peType= 'DRAWDOWN' and b:custRemarksList/b:custRemarks= 'Recallable Return of Capital'))) or (contains($securityTransferInSupportedTypes,b:transactionType) and contains($securityTransfersWithoutPaymentDeliveryInstr, b:deliveryInstr) and (b:secHoldSettle = 'NO' or b:secHoldSettle = '')) or (contains($securityTransferInSupportedTypes,b:transactionType) and contains($securityTransfersWithoutPaymentDeliveryInstr, b:deliveryInstr) and b:secHoldSettle = 'YES' and b:tapRefId != '') or (contains($sectPendTransNamesInSupportedTypes,b:transactionType) and b:secHoldSettle = 'YES')]"
		                     mode="filter-custo"/>
	</xsl:template>
	
	<!-- Custo placeholder -->
	<xsl:template match="b:SecurityTransfer" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecurityTransfer" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SecurityTransfer" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>