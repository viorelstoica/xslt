<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrderNotification"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrderNotification" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrderNotification" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrderNotification" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="b:PaymentOrderNotification">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:choose>
				<xsl:when test="b:paymentOrderCreditAccountPortfolioNoList/b:paymentOrderCreditAccountPortfolioNo and b:paymentOrderCreditAccountPortfolioNoList/b:paymentOrderCreditAccountPortfolioNo != ''">
					<xsl:call-template name="checkPortfolioConditionCsdEam">
						<xsl:with-param name="xsltName" select="'CsdTransactionPaymentOrderNotificationCredit'"/>
						<xsl:with-param name="memoAccount" select="b:paymentOrderCreditAccountPortfolioMemoAccountList/b:paymentOrderCreditAccountPortfolioMemoAccount"/>
						<xsl:with-param name="dealerBook" select="b:paymentOrderCreditAccountPortfolioDealerBookList/b:paymentOrderCreditAccountPortfolioDealerBook"/>
						<xsl:with-param name="customerType" select="b:paymentOrderCreditAccountPortfolioCustomerTypeGroup/b:paymentOrderCreditAccountPortfolioCustomerTypeList/b:paymentOrderCreditAccountPortfolioCustomerType"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="checkPortfolioConditionCsdEam">
						<xsl:with-param name="xsltName" select="'CsdTransactionPaymentOrderNotificationCredit'"/>
						<xsl:with-param name="memoAccount" select="b:paymentOrderCreditAccountSamHistIdMemoAccount"/>
						<xsl:with-param name="dealerBook" select="b:paymentOrderCreditAccountSamHistIdDealerBook"/>
						<xsl:with-param name="customerType" select="b:paymentOrderCreditAccountSamHistIdCustomerTypeList/b:paymentOrderCreditAccountSamHistIdCustomerType"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="((b:paymentOrderTapRefId = '' or not(b:paymentOrderTapRefId)) or (b:paymentOrderTapRefId != '' and b:paymentOrderTapOperNature = 'IN'))">
				<xsl:apply-templates select="self::b:PaymentOrderNotification[b:paymentComplete = 'YES' and $checkPortfolioConditionVar = 'true' and (b:paymentOrderProduct = 'EAMOTHERDR' or b:paymentOrderProduct ='EAMOTHERCR' or b:paymentOrderProduct ='EAMSIC' or b:paymentOrderProduct ='EAMEUROSIC' or b:paymentOrderProduct ='EAMSEPA' or b:paymentOrderProduct ='EAMSWIFT')]" mode="filter-custo"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="self::b:PaymentOrderNotification[b:paymentComplete = 'YES' and b:paymentOrderTapRefId != '' and b:paymentOrderTapOperNature = 'WI'  and (b:paymentOrderProduct = 'EAMOTHERDR' or b:paymentOrderProduct ='EAMOTHERCR' or b:paymentOrderProduct ='EAMSIC' or b:paymentOrderProduct ='EAMEUROSIC' or b:paymentOrderProduct ='EAMSEPA' or b:paymentOrderProduct ='EAMSWIFT')]" mode="filter-custo"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PaymentOrderNotification" mode="filter-custo">
		<xsl:apply-templates select="self::b:PaymentOrderNotification" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PaymentOrderNotification" mode="filter-final">
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