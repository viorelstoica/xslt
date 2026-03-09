<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferScSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferScSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->

	<!-- BEG - Allow securityAcctGroup only if securityNo = scSettlementSecurityNo -->
	<!-- Condition 1 -->
	<xsl:template match="b:securityAcctGroup">
		<xsl:apply-templates select="self::b:securityAcctGroup[b:securityNo = ../b:scSettlementSecurityNo]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:securityAcctGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:securityAcctGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:securityAcctGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Allow securityAcctGroup only if securityNo = scSettlementSecurityNo -->

	<!-- BEG - Filter for whole record -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionTransferScSettlement">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:secAcctFrom and b:secAcctFrom != '']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:secAcctTo and b:secAcctTo != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:secAcctTo != b:secAcctFrom]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[(not(b:depositoryFrom) or b:depositoryFrom = '' and (not(b:depositoryTo) or b:depositoryTo = '') or (b:depositoryFrom and b:depositoryTo and (b:depositoryFrom = b:depositoryTo)))]"
		                     mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 portfolio filter for secAcctFrom -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter5">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'PTPtfToPtfWithdrActualSettlement'"/>
				<xsl:with-param name="memoAccount" select="b:secAcctFromMemoAccount"/>
				<xsl:with-param name="dealerBook" select="b:secAcctFromDealerBook"/>
				<xsl:with-param name="customerType" select="b:secAcctFromCustomerTypeJoinList/b:secAcctFromCustomerTypeJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[$checkPortfolioConditionVar = 'true']" mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 portfolio filter for secAcctTo -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter6">
		<xsl:variable name="checkPortfolioConditionVar1">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'PTPtfToPtfWithdrActualSettlement1'"/>
				<xsl:with-param name="memoAccount" select="b:secAcctToMemoAccount"/>
				<xsl:with-param name="dealerBook" select="b:secAcctToDealerBook"/>
				<xsl:with-param name="customerType" select="b:secAcctToCustomerTypeJoinList/b:secAcctToCustomerTypeJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[$checkPortfolioConditionVar1 = 'true']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 8 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter7">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains(concat(' ',$sectPendTransNamesOutSupportedTypes,' '),concat(' ',b:transTypeDr,' ')) or contains(concat(' ',$securityTransferOutSupportedTypes,' '),concat(' ',b:transTypeDr,' '))]"
		                     mode="filter8"/>
	</xsl:template>
	<!-- Condition 9 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter8">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:application = 'POSITION.TRANSFER']" mode="filter9"/>
	</xsl:template>
	<!-- Condition 10 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter9">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains(concat(' ',$sectPendTransNamesOutSupportedTypes,' '),concat(' ',b:transCode,' ')) or contains(concat(' ',$securityTransferOutSupportedTypes,' '),concat(' ',b:transCode,' '))]"
		                     mode="filter10"/>
	</xsl:template>
	<!-- Condition 11 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter10">
		<xsl:variable name="ifSecurityNoPresent">
			<xsl:for-each select="b:securityAcctGroup">
				<xsl:choose>
					<xsl:when test="b:securityNo = ../b:scSettlementSecurityNo">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains($ifSecurityNoPresent,'Y')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter for whole record -->
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