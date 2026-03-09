<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFiduciary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFiduciary" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFiduciary" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFdFiduciary">
		<xsl:apply-templates select="c:CurrentEvent/b:FdFiduciary"/>
	</xsl:template>
	<xsl:template match="batch:BatchFdFiduciary">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFdFiduciary" name="BatchFdFiduciary">
			<xsl:apply-templates select="b:FdFiduciary"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFdFiduciary">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFdFiduciary" name="BatchMultiFdFiduciary">
			<xsl:apply-templates select="c:MultiFdFiduciary"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FdFiduciary">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionFiduciaryChangePrincipal',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:for-each select="../../c:PreviousEvent/b:FdFiduciary/b:changeDateGroup/b:orderIdSubGroup[b:chngStatus = 'PAYMENT']">
				    
					<xsl:variable name="changeDate" select="../b:changeDate" />
					<xsl:variable name="orderId" select="b:orderId"/>
					<xsl:variable name="indexOfChangeDateGroup" select="@index"/>					
					<xsl:variable name="orderIdIndexOfJoinedFdFidOrder" select="../../b:orderNosIdList/b:orderNosId[. = $orderId]/@index" />
					<xsl:if test="not(../../../../c:CurrentEvent/b:FdFiduciary/b:changeDateGroup[b:changeDate = $changeDate and b:orderIdSubGroup/b:orderId = $orderId])
									and not(
									           count(../../b:changeDateGroup/b:orderIdSubGroup[b:orderId = $orderId]) = 1 
                                                and 
									           ../../b:fdFidOrderReimburseReqList/b:fdFidOrderReimburseReq[@index = $orderIdIndexOfJoinedFdFidOrder] = 'YES'
									           
									       )
									and 
										(../../b:orderNosGroup[b:orderNos = $orderId]/b:orderAmt and 
										not (../../b:orderNosGroup[b:orderNos = $orderId]/b:orderAmt = 
												../../../../c:PreviousEvent/b:FdFiduciary/b:changeDateGroup/b:orderIdSubGroup[b:orderId = $orderId]/b:prinChange)
									
										)
									">
						<xsl:choose>
							<xsl:when test="b:prinChange &gt; 0">
								<DepositLoan>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('TransactionFiduciaryChangePrincipal.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="depositCapitalIncreaseTemplate">
										<xsl:with-param name="orderIdIndexOfJoinedFdFidOrder" select="$orderIdIndexOfJoinedFdFidOrder"/>
										<xsl:with-param name="indexOfChangeDateGroup" select="$indexOfChangeDateGroup"/>
										<xsl:with-param name="orderId" select="$orderId"/>
									</xsl:call-template>
								</DepositLoan>
							</xsl:when>
							<xsl:otherwise>
								<DepositLoan>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('TransactionFiduciaryChangePrincipal.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="depositCapitalDecreaseTemplate">
										<xsl:with-param name="orderIdIndexOfJoinedFdFidOrder" select="$orderIdIndexOfJoinedFdFidOrder"/>
										<xsl:with-param name="indexOfChangeDateGroup" select="$indexOfChangeDateGroup"/>
											<xsl:with-param name="orderId" select="$orderId"/>
									</xsl:call-template>
								</DepositLoan>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</xsl:for-each>
			</DataGroup>
		</TransactionPMS>
	</xsl:template>
	<xsl:template name="depositCapitalDecreaseTemplate">
		<xsl:param name="orderIdIndexOfJoinedFdFidOrder"/>
		<xsl:param name="indexOfChangeDateGroup"/>
		<xsl:param name="orderId"/>
		<depositcapitalDecrease>
			<xsl:call-template name="account1_D">
				<xsl:with-param name="index" select="$orderIdIndexOfJoinedFdFidOrder"/>
			</xsl:call-template>
			<xsl:call-template name="account1CcyDepositCcyExchangeRate_D"/>
			<xsl:call-template name="account1NetAmount_D"/>
			<xsl:call-template name="account2_D"/>
			<xsl:call-template name="account2CcyDepositCcyExchangeRate_D"/>
			<xsl:call-template name="account2NetAmount_D"/>
			<xsl:call-template name="account3_D"/>
			<xsl:call-template name="account3CcyDepositCcyExchangeRate_D"/>
			<xsl:call-template name="account3NetAmount_D"/>
			<xsl:call-template name="accountingCode_D"/>
			<xsl:call-template name="accountingDate_D"/>
			<xsl:call-template name="cashPortfolio_D"/>
			<xsl:call-template name="commonReference_D"/>
			<xsl:call-template name="contractNumber_D"/>
			<xsl:call-template name="counterparty_D"/>
			<xsl:call-template name="deposit_D">
				<xsl:with-param name="orderId" select="$orderId"/>
			</xsl:call-template>
			<xsl:call-template name="depositCurrency_D"/>
			<xsl:call-template name="depositCcyPortfolioCcyExchangeRate_D"/>
			<xsl:call-template name="fusionRule_D"/>
			<xsl:call-template name="initiatedBy_D"/>
			<xsl:call-template name="initiator_D"/>
			<xsl:call-template name="notepad_D"/>
			<xsl:call-template name="portfolio_D">
				<xsl:with-param name="index" select="$orderIdIndexOfJoinedFdFidOrder"/>
			</xsl:call-template>
			<xsl:call-template name="portfolioManager_D"/>
			<xsl:call-template name="remark_D"/>
			<xsl:call-template name="referenceTransactionCode_D"/>
			<xsl:call-template name="reversalIndicator_D"/>
			<xsl:call-template name="reversedTransactionCode_D"/>
			<xsl:call-template name="sourceSystemCode_D"/>
			<xsl:call-template name="status_D"/>
			<xsl:call-template name="subType_D"/>
			<xsl:call-template name="trader_D"/>
			<xsl:call-template name="transactionCode_D">
				<xsl:with-param name="orderId" select="$orderId"/>
			</xsl:call-template>
			<xsl:call-template name="transactionDate_D"/>
			<xsl:call-template name="transactionFeesTaxesCounter_D"/>
			<xsl:call-template name="type_D"/>
			<xsl:call-template name="valueDate_D"/>
			<xsl:call-template name="userDefinedField_D"/>
			<xsl:call-template name="mbFields_D"/>
			<xsl:call-template name="accruedInterestAmount_D"/>
			<xsl:call-template name="depositCapitalDecrease_D"/>
			<xsl:call-template name="expirationDate_D"/>
			<xsl:call-template name="depositInterestRate_D"/>
			<xsl:call-template name="referenceNature_D"/>
			<xsl:call-template name="renewalAmount_D"/>
			<xsl:call-template name="renewalEndDate_D"/>
			<xsl:call-template name="renewalInterestRate_D"/>
			<xsl:call-template name="renewalMode_D"/>
			<xsl:call-template name="renewalPeriod_D"/>
			<xsl:call-template name="renewalPeriodNumber_D"/>
			<xsl:call-template name="renewalTreatment_D"/>
		</depositcapitalDecrease>
	</xsl:template>
	<xsl:template name="depositCapitalIncreaseTemplate">
		<xsl:param name="orderIdIndexOfJoinedFdFidOrder"/>
		<xsl:param name="indexOfChangeDateGroup"/>
		<xsl:param name="orderId"/>
		<depositcapitalIncrease>
			<xsl:call-template name="account1_I">
				<xsl:with-param name="index" select="$orderIdIndexOfJoinedFdFidOrder"/>
			</xsl:call-template>
			<xsl:call-template name="account1CcyDepositCcyExchangeRate_I"/>
			<xsl:call-template name="account1NetAmount_I"/>
			<xsl:call-template name="account2_I"/>
			<xsl:call-template name="account2CcyDepositCcyExchangeRate_I"/>
			<xsl:call-template name="account2NetAmount_I"/>
			<xsl:call-template name="account3_I"/>
			<xsl:call-template name="account3CcyDepositCcyExchangeRate_I"/>
			<xsl:call-template name="account3NetAmount_I"/>
			<xsl:call-template name="accountingCode_I"/>
			<xsl:call-template name="accountingDate_I"/>
			<xsl:call-template name="cashPortfolio_I"/>
			<xsl:call-template name="commonReference_I"/>
			<xsl:call-template name="contractNumber_I"/>
			<xsl:call-template name="counterparty_I"/>
			<xsl:call-template name="deposit_I">
				<xsl:with-param name="orderId" select="$orderId"/>
			</xsl:call-template>
			<xsl:call-template name="depositCurrency_I"/>
			<xsl:call-template name="depositCcyPortfolioCcyExchangeRate_I"/>
			<xsl:call-template name="fusionRule_I"/>
			<xsl:call-template name="initiatedBy_I"/>
			<xsl:call-template name="initiator_I"/>
			<xsl:call-template name="notepad_I"/>
			<xsl:call-template name="portfolio_I">
				<xsl:with-param name="index" select="$orderIdIndexOfJoinedFdFidOrder"/>
			</xsl:call-template>
			<xsl:call-template name="portfolioManager_I"/>
			<xsl:call-template name="remark_I"/>
			<xsl:call-template name="referenceTransactionCode_I"/>
			<xsl:call-template name="reversalIndicator_I"/>
			<xsl:call-template name="reversedTransactionCode_I"/>
			<xsl:call-template name="sourceSystemCode_I"/>
			<xsl:call-template name="status_I"/>
			<xsl:call-template name="subType_I"/>
			<xsl:call-template name="trader_I"/>
			<xsl:call-template name="transactionCode_I">
				<xsl:with-param name="orderId" select="$orderId"/>
			</xsl:call-template>
			<xsl:call-template name="transactionDate_I"/>
			<xsl:call-template name="transactionFeesTaxesCounter_I"/>
			<xsl:call-template name="type_I"/>
			<xsl:call-template name="valueDate_I"/>
			<xsl:call-template name="userDefinedField_I"/>
			<xsl:call-template name="mbFields_I"/>
			<xsl:call-template name="accruedInterestAmount_I"/>
			<xsl:call-template name="depositCapitalIncrease_I"/>
			<xsl:call-template name="depositInterestRate_I"/>
			<xsl:call-template name="expirationDate_I"/>
			<xsl:call-template name="referenceNature_I"/>
			<xsl:call-template name="renewalAmount_I"/>
			<xsl:call-template name="renewalEndDate_I"/>
			<xsl:call-template name="renewalInterestRate_I"/>
			<xsl:call-template name="renewalMode_I"/>
			<xsl:call-template name="renewalPeriod_I"/>
			<xsl:call-template name="renewalPeriodNumber_I"/>
			<xsl:call-template name="renewalTreatment_I"/>
		</depositcapitalIncrease>
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