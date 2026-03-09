<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FullPartialExecution"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFullPartialExecution" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFullPartialExecution" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFullPartialExecution" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFullPartialExecution">
		<xsl:apply-templates select="c:CurrentEvent/b:FullPartialExecution"/>
	</xsl:template>
	<xsl:template match="batch:BatchFullPartialExecution">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFullPartialExecution" name="BatchFullPartialExecution">
			<xsl:apply-templates select="b:FullPartialExecution"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFullPartialExecution">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFullPartialExecution" name="BatchMultiFullPartialExecution">
			<xsl:apply-templates select="c:MultiFullPartialExecution"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FullPartialExecution">
		<F2B mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FullPartialExecution',b:id)"/>
			</xsl:attribute>
			<xsl:if test="(b:orderStatus = 'REJECTED' and not(starts-with(b:TapRefSecOpenOrderJoin, 'D')) and b:DealStatusFromSoo != 'CANCELLED') or 
                                b:cancelRemainOrd = 'YES' or
                                ($SC_CASH_ORDER_CHG_STATUS_IF_T24_EXEC = 'Y' and b:orderType = 'CASH' and
                                       b:nominalBalance = 0)
                                or 				
			                (
		                        b:securityAcctGroup/b:cuSubscriptionAmount and                                  
		                        (format-number(b:securityAcctGroup/b:cuSubscriptionAmount,'0.##','nan2zero') =                                   
		                        format-number(b:securityAcctGroup/b:cuRefundAmount,'0.##','nan2zero'))                              
		                    )">
				<DataGroup>
					<Security>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FullPartialExecution.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<OrderLifeCycle>
							<Acknowledgment>
								<xsl:call-template name="ack_buySellIndicator"/>
								<xsl:call-template name="ack_cashPortfolio"/>
								<xsl:call-template name="ack_channel"/>
								<xsl:call-template name="ack_contractNumber"/>
								<xsl:call-template name="ack_limitPrice"/>
								<xsl:call-template name="ack_notepad"/>
								<xsl:call-template name="ack_omsOrderReference"/>
								<xsl:call-template name="ack_orderMode"/>
								<xsl:call-template name="ack_orderPriceType"/>
								<xsl:call-template name="ack_orderStatus"/>
								<xsl:call-template name="ack_orderType"/>
								<xsl:call-template name="ack_orderValidityType"/>
								<xsl:call-template name="ack_pmsOrderReference"/>
								<xsl:call-template name="ack_portfolio"/>
								<xsl:call-template name="ack_priceRule"/>
								<xsl:call-template name="ack_quantity"/>
								<xsl:call-template name="ack_remark"/>
								<xsl:call-template name="ack_security"/>
								<xsl:call-template name="ack_sourceSystemCode"/>
								<xsl:call-template name="ack_stockExchange"/>
								<xsl:call-template name="ack_stopPrice"/>
								<xsl:call-template name="ack_subType"/>
								<xsl:call-template name="ack_switchFrom"/>
								<xsl:call-template name="ack_switchTo"/>
								<xsl:call-template name="ack_tradeType"/>
								<xsl:call-template name="ack_type"/>
								<xsl:call-template name="ack_validityDate"/>
								<xsl:call-template name="ack_userDefinedField"/>
								<xsl:call-template name="ack_mbFields"/>
							</Acknowledgment>
						</OrderLifeCycle>
					</Security>
				</DataGroup>
			</xsl:if>
             <xsl:if test = "(b:orderStatus != 'REJECTED') and
                             not(
                              b:securityAcctGroup/b:cuSubscriptionAmount and 
                                 (format-number(b:securityAcctGroup/b:cuSubscriptionAmount,'0.##','nan2zero') = 
                                  format-number(b:securityAcctGroup/b:cuRefundAmount,'0.##','nan2zero'))
                              )">
				
				<xsl:variable name="previousEventBroker">
					<xsl:choose>
						<xsl:when test="../../c:PreviousEvent/b:FullPartialExecution/b:brokerNoGroup">
							<xsl:for-each select="../../c:PreviousEvent/b:FullPartialExecution/b:brokerNoGroup">
								<xsl:if test="position()=last()">
									<xsl:value-of select="@index"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="not(../../c:PreviousEvent/b:FullPartialExecution/b:brokerNoGroup)">
							<xsl:value-of select="'0'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>

				<xsl:for-each select="b:brokerNoGroup/b:brokerNo">
					<xsl:if test="(../@index &gt;= $previousEventBroker)">
						<DataGroup>
							<Security>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('FullPartialExecution.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<OrderLifeCycle>
									<Execution>
										<xsl:choose>
											<xsl:when test="../../b:nominalBalance = '0' and position()=last()">
												<Full>
													<xsl:call-template name="ExecutionObject">
														<xsl:with-param name="fullOrPartial" select="'full'"/>
													</xsl:call-template>
												</Full>
											</xsl:when>
											<xsl:otherwise>
												<Partial>
													<xsl:call-template name="ExecutionObject">
														<xsl:with-param name="fullOrPartial" select="'partial'"/>
													</xsl:call-template>
												</Partial>
											</xsl:otherwise>
										</xsl:choose>
									</Execution>
								</OrderLifeCycle>
							</Security>
						</DataGroup>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
		</F2B>
	</xsl:template>
	<xsl:template name="ExecutionObject">
		<xsl:param name="fullOrPartial"/>
		<xsl:call-template name="account1"/>
		<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
		<xsl:call-template name="account1NetAmount"/>
		<xsl:call-template name="account2"/>
		<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
		<xsl:call-template name="account2NetAmount"/>
		<xsl:call-template name="account3"/>
		<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
		<xsl:call-template name="account3NetAmount"/>
		<xsl:call-template name="boAccount"/>
		<xsl:call-template name="boPortfolio"/>
		<xsl:call-template name="broker"/>
		<xsl:call-template name="cashPortfolio"/>
		<xsl:call-template name="contractNumber"/>
		<xsl:call-template name="depositaryAccount"/>
		<xsl:call-template name="executionSequenceNumber"/>
		<xsl:call-template name="executionDate"/>
		<xsl:call-template name="executionSetCriteria"/>
		<xsl:call-template name="executionStatus"/>
		<xsl:call-template name="mainBusinessEntity"/>
		<xsl:call-template name="notepad"/>
		<xsl:call-template name="omsOrderReference"/>
		<xsl:call-template name="orderMode"/>
		<xsl:call-template name="partialFullIndicator">
			<xsl:with-param name="fullOrPartial" select="$fullOrPartial"/>
		</xsl:call-template>
		<xsl:call-template name="pmsOrderReference"/>
		<xsl:call-template name="portfolio"/>
		<xsl:call-template name="price"/>
		<xsl:call-template name="quantity"/>
		<xsl:call-template name="security"/>
		<xsl:call-template name="sourceSystemCode"/>
		<xsl:call-template name="stockExchange"/>
		<xsl:call-template name="subType"/>
		<xsl:call-template name="tradeCcyGrossAmount"/>
		<xsl:call-template name="tradeCcyNetAmount"/>
		<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
		<xsl:call-template name="tradeCurrency"/>
		<xsl:call-template name="tradeDate"/>
		<xsl:call-template name="transactionFeesTaxesCounter"/>
		<xsl:call-template name="type"/>
		<xsl:call-template name="userDefinedField"/>
		<xsl:call-template name="valueDate"/>
		<xsl:call-template name="mbFields"/>
	</xsl:template>
</xsl:stylesheet>