<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecTradeScSettlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecTradeScSettlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecTradeScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecTradeScSettlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiSecTradeScSettlement">
		<xsl:apply-templates select="c:CurrentEvent/b:SecTradeScSettlement"/>
	</xsl:template>
	<xsl:template match="batch:BatchSecTradeScSettlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSecTradeScSettlement" name="BatchSecTradeScSettlement">
			<xsl:apply-templates select="b:SecTradeScSettlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiSecTradeScSettlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSecTradeScSettlement" name="BatchMultiSecTradeScSettlement">
			<xsl:apply-templates select="c:MultiSecTradeScSettlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:SecTradeScSettlement">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('SecTradeSellActualSettlement',b:id)"/>
			</xsl:attribute>
			<xsl:for-each select="b:customerNoGroup/b:custSecAcc">
				<xsl:variable name="index" select="../@index"/>
				<xsl:variable name="ccyAccXRate">
					<xsl:choose>
						<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
							<xsl:value-of select="format-number(../b:cuAmountDue div ../b:cuNetAmTrd, $decimalformat, 'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(../b:cuNetAmTrd div ../b:cuAmountDue, $decimalformat, 'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="ccyInstrXRate">
					<xsl:choose>
						<xsl:when test="../../b:securityCurrency = ../../b:tradeCcy and ../b:cuRefCcy = ../b:cuAccountCcy">
							<xsl:value-of select="$ccyAccXRate"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
									<xsl:value-of select="format-number(../../b:grBkCostRefCcyJoin div ../b:cuGrossAmSec, $decimalformat, 'nan2zero')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number(../b:cuGrossAmSec div ../../b:grBkCostRefCcyJoin, $decimalformat, 'nan2zero')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="ccyOpXRate">
					<xsl:choose>
						<xsl:when test="../b:cuRefCcy = ../b:cuAccountCcy">
							<xsl:value-of select="$ccyAccXRate"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
									<xsl:value-of select="format-number(../../b:grBkCostRefCcyJoin div ../b:cuGrossAmTrd, $decimalformat, 'nan2zero')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="format-number(../b:cuGrossAmTrd div ../../b:grBkCostRefCcyJoin, $decimalformat, 'nan2zero')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- The interest amount, which may be present or not. Make sure a reliable variable exists -->
				<xsl:variable name="intrAmount">
					<xsl:choose>
						<xsl:when test="../b:custIntrAmt">
							<xsl:value-of select="../b:custIntrAmt"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="0"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- Amounts to be debited to acc1 and acc2 -->
				<xsl:variable name="acc2Amount">
					<!-- T24 provides seggregated buy amount as negative value, we need positive -->
					<xsl:value-of select="- ../b:cuIncomeAmt"/>
				</xsl:variable>
				<xsl:variable name="acc1Amount">
					<xsl:choose>
						<xsl:when test="../b:cuIncomeAmt">
							<xsl:value-of select="format-number(../b:cuAmountDue - (- ../b:cuIncomeAmt),$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="../b:cuAmountDue"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<DataGroup>
					<Security>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('SecTradeBuyActualSettlement.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<sale>
							<xsl:call-template name="account1"/>
							<xsl:call-template name="account1CcyTradeCcyExchangeRate">
								<xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
							</xsl:call-template>
							<xsl:call-template name="account1NetAmount">
								<xsl:with-param name="acc1Amount" select="$acc1Amount"/>
							</xsl:call-template>
							<xsl:call-template name="account2"/>
							<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
							<xsl:call-template name="account2NetAmount"/>
							<xsl:call-template name="account3"/>
							<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
							<xsl:call-template name="account3NetAmount"/>
							<xsl:call-template name="accountingCode"/>
							<xsl:call-template name="accountingDate"/>
							<xsl:call-template name="cashPortfolio"/>
							<xsl:call-template name="commonReference"/>
							<xsl:call-template name="ContractNumber"/>
							<xsl:call-template name="intermediary"/>
							<xsl:call-template name="market"/>
							<xsl:call-template name="notepad"/>
							<xsl:call-template name="portfolio"/>
							<xsl:call-template name="portfolioManager"/>
							<xsl:call-template name="remark"/>
							<xsl:call-template name="reversalIndicator"/>
							<xsl:call-template name="reversedTransactionCode"/>
							<xsl:call-template name="sourceSystemCode"/>
							<xsl:call-template name="status"/>
							<xsl:call-template name="subType"/>
							<xsl:call-template name="transactionCode"/>
							<xsl:call-template name="transactionFeesTaxesCounter"/>
							<xsl:call-template name="type"/>
							<xsl:call-template name="valueDate"/>
							<xsl:call-template name="userDefinedField"/>
							<xsl:call-template name="userDefinedField-custo"/>
							<xsl:call-template name="mbFields"/>
							<xsl:call-template name="accountCurrency"/>
							<xsl:call-template name="accruedInterests">
								<xsl:with-param name="intrAmount" select="$intrAmount"/>
							</xsl:call-template>
							<xsl:call-template name="accruedInterestCounter"/>
							<xsl:call-template name="boAccount"/>
							<xsl:call-template name="boPortfolio"/>
							<xsl:call-template name="broker"/>
							<xsl:call-template name="compoundOrderCode"/>
							<xsl:call-template name="compoundOrderMaster"/>
							<xsl:call-template name="compoundOrderSlave"/>
							<xsl:call-template name="contactMethod"/>
							<xsl:call-template name="depositaryAccount"/>
							<xsl:call-template name="exCoupon"/>
							<xsl:call-template name="executionSetCriteria"/>
							<xsl:call-template name="initiatedBy"/>
							<xsl:call-template name="initiator"/>
							<xsl:call-template name="limitPrice"/>
							<xsl:call-template name="orderType"/>
							<xsl:call-template name="orderValidityType"/>
							<xsl:call-template name="originalOrderCode"/>
							<xsl:call-template name="paymentDate"/>
							<xsl:call-template name="paymentStatus"/>
							<xsl:call-template name="paymentOptionE"/>
							<xsl:call-template name="positionCriteria1"/>
							<xsl:call-template name="positionCriteria2"/>
							<xsl:call-template name="positionCriteria3"/>
							<xsl:call-template name="price"/>
							<xsl:call-template name="quantity"/>
							<xsl:call-template name="security"/>
							<xsl:call-template name="securityCcyNetAmount"/>
							<xsl:call-template name="securityCcyPortfolioCcyExchangeRate">
								<xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
								<xsl:with-param name="ccyInstrXRate" select="$ccyInstrXRate"/>
							</xsl:call-template>
							<xsl:call-template name="settlementDate"/>
							<xsl:call-template name="settlementStatus"/>
							<xsl:call-template name="splitPortfolio"/>
							<xsl:call-template name="stockExchange"/>
							<xsl:call-template name="stopPrice"/>
							<xsl:call-template name="targetAmount"/>
							<xsl:call-template name="targetNature"/>
							<xsl:call-template name="targetObjective"/>
							<xsl:call-template name="trader"/>
							<xsl:call-template name="tradeCurrency"/>
							<xsl:call-template name="tradeCcyGrossAmount"/>
							<xsl:call-template name="tradeCcyNetAmount"/>
							<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate">
								<xsl:with-param name="ccyAccXRate" select="$ccyAccXRate"/>
								<xsl:with-param name="ccyOpXRate" select="$ccyOpXRate"/>
							</xsl:call-template>
							<xsl:call-template name="tradeDate"/>
							<xsl:call-template name="validityDate"/>
						</sale>
					</Security>
				</DataGroup>
			</xsl:for-each>
		</TransactionPMS>
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