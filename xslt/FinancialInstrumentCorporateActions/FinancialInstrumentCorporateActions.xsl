<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CaEvent" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentSecurity">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSecurity"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" name="BatchFinancialInstrumentSecurity">
			<xsl:apply-templates select="b:FinancialInstrumentSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" name="BatchMultiFinancialInstrumentSecurity">
			<xsl:apply-templates select="c:MultiFinancialInstrumentSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentSecurity">
		<CaEvent>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentCorporateActions',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:for-each select="b:subsStartDtGroup">
					<xsl:call-template name="mappingFinancialInstrumentCorporateActions"/>
				</xsl:for-each>
				<xsl:for-each select="b:redmStartDtGroup">
					<xsl:call-template name="mappingFinancialInstrumentCorporateActions"/>
				</xsl:for-each>
				<xsl:for-each select="b:minInvtCcyGroup">
					<xsl:call-template name="mappingFinancialInstrumentCorporateActions"/>
				</xsl:for-each>
				<!-- BEG - FinancialInstrumentCorporateActions delete only if previousEvent minInvtCcy exists and CurrentEvent doesn't-->
				<xsl:for-each select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:minInvtCcyGroup">
					<xsl:if test="not(../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:minInvtCcyGroup/b:minInvtCcy = b:minInvtCcy)">
						<xsl:call-template name="mappingFinancialInstrumentCorporateActions"/>
					</xsl:if>
				</xsl:for-each>
				<!-- END - FinancialInstrumentCorporateActions delete only if previousEvent minInvtCcy exists and CurrentEvent doesn't-->
				<xsl:choose>
					<xsl:when test="(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate != '' or ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate) and not(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate) ">
						<xsl:call-template name="mappingIPOdelete"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="b:ipoStartDate != ''">
							<xsl:call-template name="mappingIPO"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</DataGroup>
		</CaEvent>
	</xsl:template>
	<xsl:template name="mappingFinancialInstrumentCorporateActions">
	   <xsl:param name="subAssetType" select="../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subAssetType"/>
		<xsl:if test="($g_filterBySubAssetType='Y' and $subAssetType and contains(concat(' ',$list_SubAssetType_FinancialInstrumentCorporateActions,' '),concat(' ',$subAssetType,' '))) or 
                                    (../b:subAssetTypeTapInstrType and ../b:subAssetTypeTapInstrType='MUTUALFUND')">
			<CaGeneral>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('FinancialInstrumentCorporateActions.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<!-- BEG - FinancialInstrumentCorporateActions delete only if previousEvent minInvtCcy exists and CurrentEvent doesn't-->
				<xsl:if test="b:minInvtCcy and not(../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:minInvtCcyGroup/b:minInvtCcy = b:minInvtCcy)">
					<xsl:attribute name="mode">
						<xsl:value-of select="'delete'"/>
					</xsl:attribute>
				</xsl:if>
				<!-- END - FinancialInstrumentCorporateActions delete only if previousEvent minInvtCcy exists and CurrentEvent doesn't-->
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="announcementDate"/>
				<xsl:call-template name="code"/>
				<xsl:call-template name="description"/>
				<xsl:call-template name="effectiveDate"/>
				<xsl:call-template name="eventType"/>
				<xsl:call-template name="instrument"/>
				<xsl:call-template name="mandatory"/>
				<xsl:call-template name="messageType"/>
				<xsl:call-template name="nexusStatus"/>
				<xsl:call-template name="processingStatus"/>
				<xsl:call-template name="provider"/>
				<xsl:call-template name="senderReferenceCode"/>
				<xsl:call-template name="shortDescription"/>
				<xsl:call-template name="subEventType"/>
				<!-- caDetail tag not required in case of delete for previousEvent minInvtCcy exists and CurrentEvent doesn't-->
				<xsl:if test="not(b:minInvtCcy) or (../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:minInvtCcyGroup/b:minInvtCcy = b:minInvtCcy)">
					<caDetail>
						<xsl:call-template name="addExistingSecu"/>
						<xsl:call-template name="addSubscribedResultSecu"/>
						<xsl:call-template name="availableDate"/>
						<xsl:call-template name="caOptionType"/>
						<xsl:call-template name="conversionPeriodBegindate"/>
						<xsl:call-template name="conversionPeriodEndDate"/>
						<xsl:call-template name="creditedSecurityInstrument"/>
						<xsl:call-template name="debitedSecurityInstrument"/>
						<xsl:call-template name="defaultProcess"/>
						<xsl:call-template name="dispositionFraction"/>
						<xsl:call-template name="drawDate"/>
						<xsl:call-template name="exchangeRate"/>
						<xsl:call-template name="exDate"/>
						<xsl:call-template name="exercicePeriodBeginDate"/>
						<xsl:call-template name="exercicePeriodEndDate"/>
						<xsl:call-template name="exercicePrice"/>
						<xsl:call-template name="firstDealingDate"/>
						<xsl:call-template name="fullProviderInfo"/>
						<xsl:call-template name="grossDividendRate"/>
						<xsl:call-template name="interestPeriodBeginDate"/>
						<xsl:call-template name="interestPeriodEndDate"/>
						<xsl:call-template name="interestRate"/>
						<xsl:call-template name="intermediateInstrument"/>
						<xsl:call-template name="intemediateExpirationDate"/>
						<xsl:call-template name="intemediateIndicativePrice"/>
						<xsl:call-template name="intemediateMarketPrice"/>
						<xsl:call-template name="intermediateTradingPeriodBeginDate"/>
						<xsl:call-template name="intermediateTradingPeriodEndDate"/>
						<xsl:call-template name="intermediateSell"/>
						<xsl:call-template name="ipoLotSize"/>
						<xsl:call-template name="issuePrice"/>
						<xsl:call-template name="issueType"/>
						<xsl:call-template name="marketDeadlineDate"/>
						<xsl:call-template name="marketPrice"/>
						<xsl:call-template name="maxSubscriptionAmt"/>
						<xsl:call-template name="maxSubscriptionPrice"/>
						<xsl:call-template name="meetingDate"/>
						<xsl:call-template name="minHoldingAmt"/>
						<xsl:call-template name="minimumHoldingPeriod"/>
						<xsl:call-template name="minimumHoldingPeriodUnit"/>
						<xsl:call-template name="minInitSubscriptionAmt"/>
						<xsl:call-template name="minRedemptionAmt"/>
						<xsl:call-template name="minRedemptionCurr"/>
						<xsl:call-template name="minSipAmt"/>
						<xsl:call-template name="minSubscriptionAmt"/>
						<xsl:call-template name="minSubscriptionCurr"/>
						<xsl:call-template name="minSubscriptionPrice"/>
						<xsl:call-template name="netDividendRate"/>
						<xsl:call-template name="newToOld"/>
						<xsl:call-template name="newToRights"/>
						<xsl:call-template name="nextDetailAnnonceDate"/>
						<xsl:call-template name="offerPeriodBeginDate"/>
						<xsl:call-template name="offerPeriodEndDate"/>
						<xsl:call-template name="offerPricePaid"/>
						<xsl:call-template name="offerPriceReceived"/>
						<xsl:call-template name="offerPriceCurrency"/>
						<xsl:call-template name="optionCurrency"/>
						<xsl:call-template name="optionInstrument"/>
						<xsl:call-template name="optionNumber"/>
						<xsl:call-template name="overrideMinHoldingDays"/>
						<xsl:call-template name="paymentDate"/>
						<xsl:call-template name="protectDate"/>
						<xsl:call-template name="recordDate"/>
						<xsl:call-template name="redemptionDate"/>
						<xsl:call-template name="redemptionDays"/>
						<xsl:call-template name="redemptionPeriodBegin"/>
						<xsl:call-template name="redemptionPeriodEnd"/>
						<xsl:call-template name="redemptionPrice"/>
						<xsl:call-template name="redemptionRate"/>
						<xsl:call-template name="refundDate"/>
						<xsl:call-template name="reinvestmentPrice"/>
						<xsl:call-template name="responseDeadlineDate"/>
						<xsl:call-template name="rightsToUnderlying"/>
						<xsl:call-template name="sequenceNumber"/>
						<xsl:call-template name="subscriptionDate"/>
						<xsl:call-template name="subscriptionEndTime"/>
						<xsl:call-template name="subscriptionPeriodBegin"/>
						<xsl:call-template name="subscriptionPeriodEnd"/>
						<xsl:call-template name="subscriptionPrice"/>
						<xsl:call-template name="withholdingTaxRate"/>
						<xsl:call-template name="mbFields_caDetail"/>
					</caDetail>
				</xsl:if>
				<xsl:call-template name="mbFields"/>
			</CaGeneral>
		</xsl:if>
	</xsl:template>
	<!-- IPO Structure for delete-->


	<xsl:template name="mappingIPOdelete">
		<CaGeneral mode="delete">
			<xsl:attribute name="description">
				<xsl:value-of select="concat('FinancialInstrumentCorporateActions.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="announcementDate_ipo"/>
			<xsl:call-template name="code_ipo"/>
			<xsl:call-template name="description_ipo"/>
			<xsl:call-template name="effectiveDate_ipo"/>
			<xsl:call-template name="eventType_ipo"/>
			<xsl:call-template name="instrument_ipo"/>
			<xsl:call-template name="mandatory_ipo"/>
			<xsl:call-template name="messageType_ipo"/>
			<xsl:call-template name="nexusStatus_ipo"/>
			<xsl:call-template name="processingStatus_ipo"/>
			<xsl:call-template name="provider_ipo"/>
			<xsl:call-template name="senderReferenceCode_ipo"/>
			<xsl:call-template name="shortDescription_ipo"/>
			<xsl:call-template name="subEventType_ipo"/>
			<caDetail>
				<xsl:call-template name="addExistingSecu_ipo"/>
				<xsl:call-template name="addSubscribedResultSecu_ipo"/>
				<xsl:call-template name="availableDate_ipo"/>
				<xsl:call-template name="caOptionType_ipo"/>
				<xsl:call-template name="conversionPeriodBegindate_ipo"/>
				<xsl:call-template name="conversionPeriodEndDate_ipo"/>
				<xsl:call-template name="creditedSecurityInstrument_ipo"/>
				<xsl:call-template name="debitedSecurityInstrument_ipo"/>
				<xsl:call-template name="defaultProcess_ipo"/>
				<xsl:call-template name="dispositionFraction_ipo"/>
				<xsl:call-template name="drawDate_ipo"/>
				<xsl:call-template name="exchangeRate_ipo"/>
				<xsl:call-template name="exDate_ipo"/>
				<xsl:call-template name="exercicePeriodBeginDate_ipo"/>
				<xsl:call-template name="exercicePeriodEndDate_ipo"/>
				<xsl:call-template name="exercicePrice_ipo"/>
				<xsl:call-template name="firstDealingDate_ipo"/>
				<xsl:call-template name="fullProviderInfo_ipo"/>
				<xsl:call-template name="grossDividendRate_ipo"/>
				<xsl:call-template name="interestPeriodBeginDate_ipo"/>
				<xsl:call-template name="interestPeriodEndDate_ipo"/>
				<xsl:call-template name="interestRate_ipo"/>
				<xsl:call-template name="intermediateInstrument_ipo"/>
				<xsl:call-template name="intemediateExpirationDate_ipo"/>
				<xsl:call-template name="intemediateIndicativePrice_ipo"/>
				<xsl:call-template name="intemediateMarketPrice_ipo"/>
				<xsl:call-template name="intermediateTradingPeriodBeginDate_ipo"/>
				<xsl:call-template name="intermediateTradingPeriodEndDate_ipo"/>
				<xsl:call-template name="intermediateSell_ipo"/>
				<xsl:call-template name="ipoLotSize_ipo"/>
				<xsl:call-template name="issuePrice_ipo"/>
				<xsl:call-template name="issueType_ipo"/>
				<xsl:call-template name="marketDeadlineDate_ipo"/>
				<xsl:call-template name="marketPrice_ipo"/>
				<xsl:call-template name="maxSubscriptionAmt_ipo"/>
				<xsl:call-template name="maxSubscriptionPrice_ipo"/>
				<xsl:call-template name="meetingDate_ipo"/>
				<xsl:call-template name="minHoldingAmt_ipo"/>
				<xsl:call-template name="minimumHoldingPeriod_ipo"/>
				<xsl:call-template name="minimumHoldingPeriodUnit_ipo"/>
				<xsl:call-template name="minInitSubscriptionAmt_ipo"/>
				<xsl:call-template name="minRedemptionAmt_ipo"/>
				<xsl:call-template name="minRedemptionCurr_ipo"/>
				<xsl:call-template name="minSipAmt_ipo"/>
				<xsl:call-template name="minSubscriptionAmt_ipo"/>
				<xsl:call-template name="minSubscriptionCurr_ipo"/>
				<xsl:call-template name="minSubscriptionPrice_ipo"/>
				<xsl:call-template name="netDividendRate_ipo"/>
				<xsl:call-template name="newToOld_ipo"/>
				<xsl:call-template name="newToRights_ipo"/>
				<xsl:call-template name="nextDetailAnnonceDate_ipo"/>
				<xsl:call-template name="offerPeriodBeginDate_ipo"/>
				<xsl:call-template name="offerPeriodEndDate_ipo"/>
				<xsl:call-template name="offerPricePaid_ipo"/>
				<xsl:call-template name="offerPriceReceived_ipo"/>
				<xsl:call-template name="offerPriceCurrency_ipo"/>
				<xsl:call-template name="optionCurrency_ipo"/>
				<xsl:call-template name="optionInstrument_ipo"/>
				<xsl:call-template name="optionNumber_ipo"/>
				<xsl:call-template name="overrideMinHoldingDays_ipo"/>
				<xsl:call-template name="paymentDate_ipo"/>
				<xsl:call-template name="protectDate_ipo"/>
				<xsl:call-template name="recordDate_ipo"/>
				<xsl:call-template name="redemptionDate_ipo"/>
				<xsl:call-template name="redemptionDays_ipo"/>
				<xsl:call-template name="redemptionPeriodBegin_ipo"/>
				<xsl:call-template name="redemptionPeriodEnd_ipo"/>
				<xsl:call-template name="redemptionPrice_ipo"/>
				<xsl:call-template name="redemptionRate_ipo"/>
				<xsl:call-template name="refundDate_ipo"/>
				<xsl:call-template name="reinvestmentPrice_ipo"/>
				<xsl:call-template name="responseDeadlineDate_ipo"/>
				<xsl:call-template name="rightsToUnderlying_ipo"/>
				<xsl:call-template name="sequenceNumber_ipo"/>
				<xsl:call-template name="subscriptionDate_ipo"/>
				<xsl:call-template name="subscriptionEndTime_ipo"/>
				<xsl:call-template name="subscriptionPeriodBegin_ipo"/>
				<xsl:call-template name="subscriptionPeriodEnd_ipo"/>
				<xsl:call-template name="subscriptionPrice_ipo"/>
				<xsl:call-template name="withholdingTaxRate_ipo"/>
				<xsl:call-template name="mbFields_caDetail_ipo"/>
			</caDetail>
			<xsl:call-template name="mbFields_ipo"/>
		</CaGeneral>
	</xsl:template>

	<!-- IPO Structure for insert-->


	<xsl:template name="mappingIPO">
		<CaGeneral>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('FinancialInstrumentCorporateActions.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="announcementDate_ipo1"/>
			<xsl:call-template name="code_ipo1"/>
			<xsl:call-template name="description_ipo1"/>
			<xsl:call-template name="effectiveDate_ipo1"/>
			<xsl:call-template name="eventType_ipo1"/>
			<xsl:call-template name="instrument_ipo1"/>
			<xsl:call-template name="mandatory_ipo1"/>
			<xsl:call-template name="messageType_ipo1"/>
			<xsl:call-template name="nexusStatus_ipo1"/>
			<xsl:call-template name="processingStatus_ipo1"/>
			<xsl:call-template name="provider_ipo1"/>
			<xsl:call-template name="senderReferenceCode_ipo1"/>
			<xsl:call-template name="shortDescription_ipo1"/>
			<xsl:call-template name="subEventType_ipo1"/>
			<caDetail>
				<xsl:call-template name="addExistingSecu_ipo1"/>
				<xsl:call-template name="addSubscribedResultSecu_ipo1"/>
				<xsl:call-template name="availableDate_ipo1"/>
				<xsl:call-template name="caOptionType_ipo1"/>
				<xsl:call-template name="conversionPeriodBegindate_ipo1"/>
				<xsl:call-template name="conversionPeriodEndDate_ipo1"/>
				<xsl:call-template name="creditedSecurityInstrument_ipo1"/>
				<xsl:call-template name="debitedSecurityInstrument_ipo1"/>
				<xsl:call-template name="defaultProcess_ipo1"/>
				<xsl:call-template name="dispositionFraction_ipo1"/>
				<xsl:call-template name="drawDate_ipo1"/>
				<xsl:call-template name="exchangeRate_ipo1"/>
				<xsl:call-template name="exDate_ipo1"/>
				<xsl:call-template name="exercicePeriodBeginDate_ipo1"/>
				<xsl:call-template name="exercicePeriodEndDate_ipo1"/>
				<xsl:call-template name="exercicePrice_ipo1"/>
				<xsl:call-template name="firstDealingDate_ipo1"/>
				<xsl:call-template name="fullProviderInfo_ipo1"/>
				<xsl:call-template name="grossDividendRate_ipo1"/>
				<xsl:call-template name="interestPeriodBeginDate_ipo1"/>
				<xsl:call-template name="interestPeriodEndDate_ipo1"/>
				<xsl:call-template name="interestRate_ipo1"/>
				<xsl:call-template name="intermediateInstrument_ipo1"/>
				<xsl:call-template name="intemediateExpirationDate_ipo1"/>
				<xsl:call-template name="intemediateIndicativePrice_ipo1"/>
				<xsl:call-template name="intemediateMarketPrice_ipo1"/>
				<xsl:call-template name="intermediateTradingPeriodBeginDate_ipo1"/>
				<xsl:call-template name="intermediateTradingPeriodEndDate_ipo1"/>
				<xsl:call-template name="intermediateSell_ipo1"/>
				<xsl:call-template name="ipoLotSize_ipo1"/>
				<xsl:call-template name="issuePrice_ipo1"/>
				<xsl:call-template name="issueType_ipo1"/>
				<xsl:call-template name="marketDeadlineDate_ipo1"/>
				<xsl:call-template name="marketPrice_ipo1"/>
				<xsl:call-template name="maxSubscriptionAmt_ipo1"/>
				<xsl:call-template name="maxSubscriptionPrice_ipo1"/>
				<xsl:call-template name="meetingDate_ipo1"/>
				<xsl:call-template name="minHoldingAmt_ipo1"/>
				<xsl:call-template name="minHoldingDays_ipo1"/>
				<xsl:call-template name="minInitSubscriptionAmt_ipo1"/>
				<xsl:call-template name="minRedemptionAmt_ipo1"/>
				<xsl:call-template name="minRedemptionCurr_ipo1"/>
				<xsl:call-template name="minSipAmt_ipo1"/>
				<xsl:call-template name="minSubscriptionAmt_ipo1"/>
				<xsl:call-template name="minSubscriptionCurr_ipo1"/>
				<xsl:call-template name="minSubscriptionPrice_ipo1"/>
				<xsl:call-template name="netDividendRate_ipo1"/>
				<xsl:call-template name="newToOld_ipo1"/>
				<xsl:call-template name="newToRights_ipo1"/>
				<xsl:call-template name="nextDetailAnnonceDate_ipo1"/>
				<xsl:call-template name="offerPeriodBeginDate_ipo1"/>
				<xsl:call-template name="offerPeriodEndDate_ipo1"/>
				<xsl:call-template name="offerPricePaid_ipo1"/>
				<xsl:call-template name="offerPriceReceived_ipo1"/>
				<xsl:call-template name="offerPriceCurrency_ipo1"/>
				<xsl:call-template name="optionCurrency_ipo1"/>
				<xsl:call-template name="optionInstrument_ipo1"/>
				<xsl:call-template name="optionNumber_ipo1"/>
				<xsl:call-template name="overrideMinHoldingDays_ipo1"/>
				<xsl:call-template name="paymentDate_ipo1"/>
				<xsl:call-template name="protectDate_ipo1"/>
				<xsl:call-template name="recordDate_ipo1"/>
				<xsl:call-template name="redemptionDate_ipo1"/>
				<xsl:call-template name="redemptionDays_ipo1"/>
				<xsl:call-template name="redemptionPeriodBegin_ipo1"/>
				<xsl:call-template name="redemptionPeriodEnd_ipo1"/>
				<xsl:call-template name="redemptionPrice_ipo1"/>
				<xsl:call-template name="redemptionRate_ipo1"/>
				<xsl:call-template name="refundDate_ipo1"/>
				<xsl:call-template name="reinvestmentPrice_ipo1"/>
				<xsl:call-template name="responseDeadlineDate_ipo1"/>
				<xsl:call-template name="rightsToUnderlying_ipo1"/>
				<xsl:call-template name="sequenceNumber_ipo1"/>
				<xsl:call-template name="subscriptionDate_ipo1"/>
				<xsl:call-template name="subscriptionEndTime_ipo1"/>
				<xsl:call-template name="subscriptionPeriodBegin_ipo1"/>
				<xsl:call-template name="subscriptionPeriodEnd_ipo1"/>
				<xsl:call-template name="subscriptionPrice_ipo1"/>
				<xsl:call-template name="withholdingTaxRate_ipo1"/>
				<xsl:call-template name="mbFields_caDetail_ipo1"/>
			</caDetail>
			<xsl:call-template name="mbFields_ipo1"/>
		</CaGeneral>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiFinancialInstrumentSecurity"></template>
			<template match="b:FinancialInstrumentSecurity"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->