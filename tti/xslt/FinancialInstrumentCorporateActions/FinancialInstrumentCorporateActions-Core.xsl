<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CaEvent" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<!--Corporate ActionsOverview-->
	<xsl:template name="code">
		<xsl:choose>
			<xsl:when test="b:subsStartDt and b:subsStartDt !=''">
				<code>
					<xsl:value-of select="concat(b:subsStartDt,$COMPANY_POSTFIX_SEPARATOR,'Subscription')"/>
				</code>
			</xsl:when>
			<xsl:when test="(not(b:subsStartDt) or b:subsStartDt ='') and b:subsEndDt and b:subsEndDt !=''">
				<code>
					<xsl:value-of select="concat(b:subsEndDt,$COMPANY_POSTFIX_SEPARATOR,'Subscription')"/>
				</code>
			</xsl:when>
			<xsl:when test="b:redmStartDt and b:redmStartDt !=''">
				<code>
					<xsl:value-of select="concat(b:redmStartDt,$COMPANY_POSTFIX_SEPARATOR,'Redemption')"/>
				</code>
			</xsl:when>
			<xsl:when test="(not(b:redmStartDt) or b:redmStartDt ='') and b:redmEndDt and b:redmEndDt !=''">
				<code>
					<xsl:value-of select="concat(b:redmEndDt,$COMPANY_POSTFIX_SEPARATOR,'Redemption')"/>
				</code>
			</xsl:when>
			<xsl:otherwise>
				<code>
					<xsl:value-of select="concat('MIN_MAX',$COMPANY_POSTFIX_SEPARATOR,b:minInvtCcy)"/>
				</code>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="eventType">
		<xsl:choose>
			<xsl:when test="(b:subsStartDt and b:subsStartDt !='') or (b:subsEndDt and b:subsEndDt !='')">
				<eventType>
					<infra:code>
						<xsl:value-of select="'Subscription'"/>
					</infra:code>
				</eventType>
			</xsl:when>
			<xsl:when test="(b:redmStartDt and b:redmStartDt !='') or (b:redmEndDt and b:redmEndDt !='')">
				<eventType>
					<infra:code>
						<xsl:value-of select="'Redemption'"/>
					</infra:code>
				</eventType>
			</xsl:when>
			<xsl:otherwise>
				<eventType>
					<infra:code>
						<xsl:value-of select="'Min_Max_Amounts'"/>
					</infra:code>
				</eventType>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="mandatory">
		<mandatory>
			<xsl:value-of select="'0'"/>
		</mandatory>
	</xsl:template>
	<xsl:template name="processingStatus">
		<processingStatus>
			<xsl:value-of select="'1'"/>
		</processingStatus>
	</xsl:template>
	<xsl:template name="effectiveDate">
		<xsl:choose>
			<xsl:when test="b:subsStartDt and b:subsStartDt !=''">
				<effectiveDate>
					<xsl:value-of select="b:subsStartDt"/>
				</effectiveDate>
			</xsl:when>
			<xsl:when test="(not(b:subsStartDt) or b:subsStartDt ='') and b:subsEndDt and b:subsEndDt !=''">
				<effectiveDate>
					<xsl:value-of select="b:subsEndDt"/>
				</effectiveDate>
			</xsl:when>
			<xsl:when test="b:redmStartDt and b:redmStartDt !=''">
				<effectiveDate>
					<xsl:value-of select="b:redmStartDt"/>
				</effectiveDate>
			</xsl:when>
			<xsl:when test="(not(b:redmStartDt) or b:redmStartDt ='') and b:redmEndDt and b:redmEndDt !=''">
				<effectiveDate>
					<xsl:value-of select="b:redmEndDt"/>
				</effectiveDate>
			</xsl:when>
			<xsl:otherwise>
				<effectiveDate>
					<xsl:value-of select="../b:setUpDate"/>
				</effectiveDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="announcementDate"/>
	<xsl:template name="shortDescription">
		<xsl:choose>
			<xsl:when test="(b:subsStartDt and b:subsStartDt !='') or (b:subsEndDt and b:subsEndDt !='')">
				<shortDescription>
					<xsl:value-of select="'Subscription'"/>
				</shortDescription>
			</xsl:when>
			<xsl:when test="(b:redmStartDt and b:redmStartDt !='') or (b:redmEndDt and b:redmEndDt !='')">
				<shortDescription>
					<xsl:value-of select="'Redemption'"/>
				</shortDescription>
			</xsl:when>
			<xsl:otherwise>
				<shortDescription>
					<xsl:value-of select="'Min_Max_Amounts'"/>
				</shortDescription>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="description">
		<xsl:choose>
			<xsl:when test="(b:subsStartDt and b:subsStartDt !='') or (b:subsEndDt and b:subsEndDt !='')">
				<description>
					<xsl:value-of select="'Subscription'"/>
				</description>
			</xsl:when>
			<xsl:when test="(b:redmStartDt and b:redmStartDt !='') or (b:redmEndDt and b:redmEndDt !='')">
				<description>
					<xsl:value-of select="'Redemption'"/>
				</description>
			</xsl:when>
			<xsl:otherwise>
				<description>
					<xsl:value-of select="'Min_Max_Amounts'"/>
				</description>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="nexusStatus">
		<nexusStatus>
			<xsl:value-of select="'0'"/>
		</nexusStatus>
	</xsl:template>
	<xsl:template name="provider">
		<provider>
			<infra:code>
				<xsl:value-of select="'MANUAL'"/>
			</infra:code>
		</provider>
	</xsl:template>
	<!--Corporate ActionsOverview end-->

	<!--Corporate Actions Details -->
	<xsl:template name="minHoldingAmt">
		<xsl:if test="../b:minimumHolding and ../b:minimumHolding != ''">
			<minHoldingAmt>
				<xsl:value-of select="../b:minimumHolding"/>
			</minHoldingAmt>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minimumHoldingPeriod">
		<xsl:choose>
			<xsl:when test="../b:minHoldPeriod and ../b:minHoldPeriod != ''">
				<minimumHoldingPeriod>
					<xsl:choose>
						<xsl:when test="string-length(../b:minHoldPeriod) = '2'">
							<xsl:value-of select="substring(../b:minHoldPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(../b:minHoldPeriod) = '3'">
							<xsl:value-of select="substring(../b:minHoldPeriod, 1, 2)"/>
						</xsl:when>
					</xsl:choose>
				</minimumHoldingPeriod>
			</xsl:when>
			<xsl:otherwise>
				<minimumHoldingPeriod>
					<xsl:value-of select="'0'"/>
				</minimumHoldingPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minimumHoldingPeriodUnit">
		<xsl:choose>
			<xsl:when test="../b:minHoldPeriod = '' or not(../b:minHoldPeriod)">
				<minimumHoldingPeriodUnit>
					<xsl:value-of select="'0'"/>
				</minimumHoldingPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="lastCharMinHoldPeriod">
					<xsl:choose>
						<xsl:when test="string-length(../b:minHoldPeriod) = '2'">
							<xsl:value-of select="substring(../b:minHoldPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(../b:minHoldPeriod) = '3'">
							<xsl:value-of select="substring(../b:minHoldPeriod, 3)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$lastCharMinHoldPeriod = 'D'">
						<minimumHoldingPeriodUnit>
							<xsl:value-of select="'1'"/>
						</minimumHoldingPeriodUnit>
					</xsl:when>
					<xsl:when test="$lastCharMinHoldPeriod = 'M'">
						<minimumHoldingPeriodUnit>
							<xsl:value-of select="'4'"/>
						</minimumHoldingPeriodUnit>
					</xsl:when>
					<xsl:when test="$lastCharMinHoldPeriod = 'Y'">
						<minimumHoldingPeriodUnit>
							<xsl:value-of select="'7'"/>
						</minimumHoldingPeriodUnit>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minInitSubscriptionAmt">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy != '' and b:minInitInvt and b:minInitInvt != ''">
			<minInitSubscriptionAmt>
				<xsl:value-of select="b:minInitInvt"/>
			</minInitSubscriptionAmt>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minSipAmt">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy != '' and b:minSip and b:minSip != ''">
			<minSipAmt>
				<xsl:value-of select="b:minSip"/>
			</minSipAmt>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minSubscriptionAmt">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy != '' and b:minSubsInvt and b:minSubsInvt != ''">
			<minSubscriptionAmt>
				<xsl:value-of select="b:minSubsInvt"/>
			</minSubscriptionAmt>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minSubscriptionCurr">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy!=''">
			<minSubscriptionCurr>
				<infra:code>
					<xsl:value-of select="b:minInvtCcy"/>
				</infra:code>
			</minSubscriptionCurr>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minRedemptionAmt">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy != '' and b:minRedemAmt and b:minRedemAmt!= ''">
			<minRedemptionAmt>
				<xsl:value-of select="b:minRedemAmt"/>
			</minRedemptionAmt>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minRedemptionCurr">
		<xsl:if test="b:minInvtCcy and b:minInvtCcy!=''">
			<minRedemptionCurr>
				<infra:code>
					<xsl:value-of select="b:minInvtCcy"/>
				</infra:code>
			</minRedemptionCurr>
		</xsl:if>
	</xsl:template>
	<xsl:template name="subscriptionPeriodBegin">
		<xsl:if test="b:subsStartDt and b:subsStartDt!=''">
			<subscriptionPeriodBegin>
				<xsl:value-of select="b:subsStartDt"/>
			</subscriptionPeriodBegin>
		</xsl:if>
	</xsl:template>
	<xsl:template name="subscriptionPeriodEnd">
		<xsl:if test="b:subsEndDt and b:subsEndDt!=''">
			<subscriptionPeriodEnd>
				<xsl:value-of select="b:subsEndDt"/>
			</subscriptionPeriodEnd>
		</xsl:if>
	</xsl:template>
	<xsl:template name="redemptionPeriodBegin">
		<xsl:if test="b:redmStartDt and b:redmStartDt!=''">
			<redemptionPeriodBegin>
				<xsl:value-of select="b:redmStartDt"/>
			</redemptionPeriodBegin>
		</xsl:if>
	</xsl:template>
	<xsl:template name="redemptionPeriodEnd">
		<xsl:if test="b:redmEndDt and b:redmEndDt!=''">
			<redemptionPeriodEnd>
				<xsl:value-of select="b:redmEndDt"/>
			</redemptionPeriodEnd>
		</xsl:if>
	</xsl:template>
	<xsl:template name="redemptionDays"/>
	<xsl:template name="recordDate">
		<xsl:choose>
			<xsl:when test="b:subsStartDt and b:subsStartDt !=''">
				<recordDate>
					<xsl:value-of select="b:subsStartDt"/>
				</recordDate>
			</xsl:when>
			<xsl:when test="(not(b:subsStartDt) or b:subsStartDt ='') and b:subsEndDt and b:subsEndDt !=''">
				<recordDate>
					<xsl:value-of select="b:subsEndDt"/>
				</recordDate>
			</xsl:when>
			<xsl:when test="b:redmStartDt and b:redmStartDt !=''">
				<recordDate>
					<xsl:value-of select="b:redmStartDt"/>
				</recordDate>
			</xsl:when>
			<xsl:when test="(not(b:redmStartDt) or b:redmStartDt ='') and b:redmEndDt and b:redmEndDt !=''">
				<recordDate>
					<xsl:value-of select="b:redmEndDt"/>
				</recordDate>
			</xsl:when>
			<xsl:otherwise>
				<recordDate>
					<xsl:value-of select="../b:setUpDate"/>
				</recordDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="overrideMinHoldingDays">
		<xsl:if test="../b:minHoldOverride and ../b:minHoldOverride != ''">
			<overrideMinHoldingDays>
				<xsl:if test="../b:minHoldOverride ='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:if>
				<xsl:if test="../b:minHoldOverride ='NO'">
					<xsl:value-of select="'0'"/>
				</xsl:if>
			</overrideMinHoldingDays>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sequenceNumber">
		<sequenceNumber>
			<xsl:value-of select="'1'"/>
		</sequenceNumber>
	</xsl:template>
	<xsl:template name="optionCurrency"/>
	<xsl:template name="defaultProcess">
		<defaultProcess>
			<xsl:value-of select="'0'"/>
		</defaultProcess>
	</xsl:template>
	<xsl:template name="dispositionFraction">
		<dispositionFraction>
			<xsl:value-of select="'0'"/>
		</dispositionFraction>
	</xsl:template>
	<xsl:template name="optionNumber">
		<optionNumber>
			<xsl:value-of select="'1'"/>
		</optionNumber>
	</xsl:template>
	<xsl:template name="caOptionType">
		<xsl:choose>
			<xsl:when test="(b:subsStartDt and b:subsStartDt !='') or (b:subsEndDt and b:subsEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Subscription'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:when test="(b:redmStartDt and b:redmStartDt !='') or (b:redmEndDt and b:redmEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Redemption'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:otherwise>
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Min_Max_Amounts'"/>
					</infra:code>
				</caOptionType>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--Corporate Actions Deails End-->

	<xsl:template name="messageType"/>
	<xsl:template name="senderReferenceCode"/>
	<xsl:template name="subEventType"/>
	<xsl:template name="addExistingSecu"/>
	<xsl:template name="addSubscribedResultSecu"/>
	<xsl:template name="availableDate"/>
	<xsl:template name="conversionPeriodBegindate"/>
	<xsl:template name="conversionPeriodEndDate"/>
	<xsl:template name="creditedSecurityInstrument"/>
	<xsl:template name="debitedSecurityInstrument"/>
	<xsl:template name="drawDate"/>
	<xsl:template name="exchangeRate"/>
	<xsl:template name="exDate"/>
	<xsl:template name="exercicePeriodBeginDate"/>
	<xsl:template name="exercicePeriodEndDate"/>
	<xsl:template name="exercicePrice"/>
	<xsl:template name="firstDealingDate"/>
	<xsl:template name="fullProviderInfo"/>
	<xsl:template name="grossDividendRate"/>
	<xsl:template name="interestPeriodBeginDate"/>
	<xsl:template name="interestPeriodEndDate"/>
	<xsl:template name="interestRate"/>
	<xsl:template name="intermediateInstrument"/>
	<xsl:template name="intemediateExpirationDate"/>
	<xsl:template name="intemediateIndicativePrice"/>
	<xsl:template name="intemediateMarketPrice"/>
	<xsl:template name="intermediateTradingPeriodBeginDate"/>
	<xsl:template name="intermediateTradingPeriodEndDate"/>
	<xsl:template name="intermediateSell"/>
	<xsl:template name="ipoLotSize"/>
	<xsl:template name="issuePrice"/>
	<xsl:template name="issueType"/>
	<xsl:template name="marketDeadlineDate"/>
	<xsl:template name="marketPrice"/>
	<xsl:template name="maxSubscriptionAmt"/>
	<xsl:template name="maxSubscriptionPrice"/>
	<xsl:template name="meetingDate"/>
	<xsl:template name="minSubscriptionPrice"/>
	<xsl:template name="netDividendRate"/>
	<xsl:template name="newToOld"/>
	<xsl:template name="newToRights"/>
	<xsl:template name="nextDetailAnnonceDate"/>
	<xsl:template name="offerPeriodBeginDate"/>
	<xsl:template name="offerPeriodEndDate"/>
	<xsl:template name="offerPricePaid"/>
	<xsl:template name="offerPriceReceived"/>
	<xsl:template name="offerPriceCurrency"/>
	<xsl:template name="optionInstrument"/>
	<xsl:template name="paymentDate"/>
	<xsl:template name="protectDate"/>
	<xsl:template name="redemptionDate"/>
	<xsl:template name="redemptionPrice"/>
	<xsl:template name="redemptionRate"/>
	<xsl:template name="refundDate"/>
	<xsl:template name="reinvestmentPrice"/>
	<xsl:template name="responseDeadlineDate"/>
	<xsl:template name="rightsToUnderlying"/>
	<xsl:template name="subscriptionDate"/>
	<xsl:template name="subscriptionEndTime"/>
	<xsl:template name="subscriptionPrice"/>
	<xsl:template name="withholdingTaxRate"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="mbFields_caDetail"/>

	<!--Corporate ActionsOverview TPO for delete-->

	<xsl:template name="code_ipo">
		<code>
			<xsl:value-of select=" 'IPO' "/>
		</code>
	</xsl:template>
	<xsl:template name="instrument_ipo">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="eventType_ipo">
		<eventType>
			<infra:code>
				<xsl:value-of select="$IPO_CORP_ACT_EVENT_TYPE"/>
			</infra:code>
		</eventType>
	</xsl:template>
	<xsl:template name="mandatory_ipo">
		<mandatory>
			<xsl:value-of select="'0'"/>
		</mandatory>
	</xsl:template>
	<xsl:template name="processingStatus_ipo">
		<processingStatus>
			<xsl:value-of select="'1'"/>
		</processingStatus>
	</xsl:template>
	<xsl:template name="effectiveDate_ipo">
		<effectiveDate>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate"/>
		</effectiveDate>
	</xsl:template>
	<xsl:template name="announcementDate_ipo"/>
	<xsl:template name="shortDescription_ipo">
		<shortDescription>
			<xsl:value-of select="'Initial Public Offering'"/>
		</shortDescription>
	</xsl:template>
	<xsl:template name="description_ipo">
		<description>
			<xsl:value-of select="'Initial Public Offering'"/>
		</description>
	</xsl:template>
	<xsl:template name="nexusStatus_ipo">
		<nexusStatus>
			<xsl:value-of select="'0'"/>
		</nexusStatus>
	</xsl:template>
	<xsl:template name="provider_ipo">
		<provider>
			<infra:code>
				<xsl:value-of select="'MANUAL'"/>
			</infra:code>
		</provider>
	</xsl:template>

	<!--Corporate ActionsOverview TPO for delete end-->

	<!--Corporate Actions Details TPO for delete-->

	<xsl:template name="optionNumber_ipo">
		<optionNumber>
			<xsl:value-of select="'1'"/>
		</optionNumber>
	</xsl:template>
	<xsl:template name="issueType_ipo">
		<xsl:if test="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:typeOfIssue and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:typeOfIssue != ''">
			<issueType>
				<xsl:if test="b:typeOfIssue ='SINGLEBID'">
					<xsl:value-of select="'1'"/>
				</xsl:if>
				<xsl:if test="b:typeOfIssue ='BOOKBUILD'">
					<xsl:value-of select="'2'"/>
				</xsl:if>
			</issueType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ipoLotSize_ipo">
		<ipoLotSize>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoLotSize"/>
		</ipoLotSize>
	</xsl:template>
	<xsl:template name="paymentDate_ipo">
		<paymentDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoAllotmentDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoAllotmentDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</paymentDate>
	</xsl:template>
	<xsl:template name="refundDate_ipo">
		<refundDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoRefundDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoRefundDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</refundDate>
	</xsl:template>
	<xsl:template name="firstDealingDate_ipo">
		<firstDealingDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoListingDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoListingDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</firstDealingDate>
	</xsl:template>
	<xsl:template name="responseDeadlineDate_ipo">
		<responseDeadlineDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoIntCutOffDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoIntCutOffDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</responseDeadlineDate>
	</xsl:template>
	<xsl:template name="recordDate_ipo">
		<recordDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</recordDate>
	</xsl:template>
	<xsl:template name="caOptionType_ipo">
		<xsl:choose>
			<xsl:when test="(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsStartDt and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsStartDt !='') or (../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsEndDt and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Subscription'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:when test="(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmStartDt and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmStartDt !='') or (../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmEndDt and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Redemption'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:otherwise>
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Min_Max_Amounts'"/>
					</infra:code>
				</caOptionType>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minHoldingAmt_ipo"/>
	<xsl:template name="minSubscriptionPrice_ipo">
		<minSubscriptionPrice>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:minOfferPrice"/>
		</minSubscriptionPrice>
	</xsl:template>
	<xsl:template name="maxSubscriptionPrice_ipo">
		<maxSubscriptionPrice>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:maxOfferPrice"/>
		</maxSubscriptionPrice>
	</xsl:template>
	<xsl:template name="subscriptionPrice_ipo">
		<subscriptionPrice>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:issueOfferPrice"/>
		</subscriptionPrice>
	</xsl:template>
	<xsl:template name="minInitSubscriptionAmt_ipo"/>
	<xsl:template name="minSipAmt_ipo"/>
	<xsl:template name="minSubscriptionAmt_ipo">
		<minSubscriptionAmt>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:minInvestmentValue"/>
		</minSubscriptionAmt>
	</xsl:template>
	<xsl:template name="maxSubscriptionAmt_ipo">
		<maxSubscriptionAmt>
			<xsl:value-of select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:maxInvestmentValue"/>
		</maxSubscriptionAmt>
	</xsl:template>
	<xsl:template name="minSubscriptionCurr_ipo"/>
	<xsl:template name="minRedemptionCurr_ipo"/>
	<xsl:template name="minRedemptionAmt_ipo"/>
	<xsl:template name="minimumHoldingPeriod_ipo"/>
	<xsl:template name="minimumHoldingPeriodUnit_ipo"/>
	<xsl:template name="overrideMinHoldingDays_ipo"/>
	<xsl:template name="subscriptionPeriodBegin_ipo">
		<subscriptionPeriodBegin>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</subscriptionPeriodBegin>
	</xsl:template>
	<xsl:template name="subscriptionPeriodEnd_ipo">
		<subscriptionPeriodEnd>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoEndDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoEndDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</subscriptionPeriodEnd>
	</xsl:template>
	<xsl:template name="subscriptionEndTime_ipo">
		<xsl:if test="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoEndTime and ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoEndTime != ''">
			<subscriptionEndTime>
				<xsl:value-of select="substring(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:ipoEndTime, 5)"/>
			</subscriptionEndTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="redemptionPeriodBegin_ipo"/>
	<xsl:template name="redemptionPeriodEnd_ipo"/>
	<xsl:template name="sequenceNumber_ipo">
		<sequenceNumber>
			<xsl:value-of select="'1'"/>
		</sequenceNumber>
	</xsl:template>
	<xsl:template name="dispositionFraction_ipo">
		<dispositionFraction>
			<xsl:value-of select="'0'"/>
		</dispositionFraction>
	</xsl:template>
	<xsl:template name="defaultProcess_ipo">
		<defaultProcess>
			<xsl:value-of select="'0'"/>
		</defaultProcess>
	</xsl:template>

	<!--Corporate Actions Deails TPO End for delete-->

	<xsl:template name="messageType_ipo"/>
	<xsl:template name="senderReferenceCode_ipo"/>
	<xsl:template name="subEventType_ipo"/>
	<xsl:template name="addExistingSecu_ipo"/>
	<xsl:template name="addSubscribedResultSecu_ipo"/>
	<xsl:template name="availableDate_ipo"/>
	<xsl:template name="conversionPeriodBegindate_ipo"/>
	<xsl:template name="conversionPeriodEndDate_ipo"/>
	<xsl:template name="creditedSecurityInstrument_ipo"/>
	<xsl:template name="debitedSecurityInstrument_ipo"/>
	<xsl:template name="drawDate_ipo"/>
	<xsl:template name="exchangeRate_ipo"/>
	<xsl:template name="exDate_ipo"/>
	<xsl:template name="exercicePeriodBeginDate_ipo"/>
	<xsl:template name="exercicePeriodEndDate_ipo"/>
	<xsl:template name="exercicePrice_ipo"/>
	<xsl:template name="fullProviderInfo_ipo"/>
	<xsl:template name="grossDividendRate_ipo"/>
	<xsl:template name="interestPeriodBeginDate_ipo"/>
	<xsl:template name="interestPeriodEndDate_ipo"/>
	<xsl:template name="interestRate_ipo"/>
	<xsl:template name="intermediateInstrument_ipo"/>
	<xsl:template name="intemediateExpirationDate_ipo"/>
	<xsl:template name="intemediateIndicativePrice_ipo"/>
	<xsl:template name="intemediateMarketPrice_ipo"/>
	<xsl:template name="intermediateTradingPeriodBeginDate_ipo"/>
	<xsl:template name="intermediateTradingPeriodEndDate_ipo"/>
	<xsl:template name="intermediateSell_ipo"/>
	<xsl:template name="issuePrice_ipo"/>
	<xsl:template name="marketDeadlineDate_ipo"/>
	<xsl:template name="marketPrice_ipo"/>
	<xsl:template name="meetingDate_ipo"/>
	<xsl:template name="netDividendRate_ipo"/>
	<xsl:template name="newToOld_ipo"/>
	<xsl:template name="newToRights_ipo"/>
	<xsl:template name="nextDetailAnnonceDate_ipo"/>
	<xsl:template name="offerPeriodBeginDate_ipo"/>
	<xsl:template name="offerPeriodEndDate_ipo"/>
	<xsl:template name="offerPricePaid_ipo"/>
	<xsl:template name="offerPriceReceived_ipo"/>
	<xsl:template name="offerPriceCurrency_ipo"/>
	<xsl:template name="optionInstrument_ipo"/>
	<xsl:template name="protectDate_ipo"/>
	<xsl:template name="redemptionDate_ipo"/>
	<xsl:template name="redemptionPrice_ipo"/>
	<xsl:template name="redemptionRate_ipo"/>
	<xsl:template name="reinvestmentPrice_ipo"/>
	<xsl:template name="rightsToUnderlying_ipo"/>
	<xsl:template name="subscriptionDate_ipo"/>
	<xsl:template name="withholdingTaxRate_ipo"/>
	<xsl:template name="mbFields_ipo"/>
	<xsl:template name="optionCurrency_ipo"/>
	<xsl:template name="mbFields_caDetail_ipo"/>
	<xsl:template name="redemptionDays_ipo"/>



	<!--Corporate ActionsOverview TPO for insert-->

	<xsl:template name="code_ipo1">
		<code>
			<xsl:value-of select=" 'IPO' "/>
		</code>
	</xsl:template>
	<xsl:template name="instrument_ipo1">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="eventType_ipo1">
		<eventType>
			<infra:code>
				<xsl:value-of select="$IPO_CORP_ACT_EVENT_TYPE"/>
			</infra:code>
		</eventType>
	</xsl:template>
	<xsl:template name="mandatory_ipo1">
		<mandatory>
			<xsl:value-of select="'0'"/>
		</mandatory>
	</xsl:template>
	<xsl:template name="processingStatus_ipo1">
		<processingStatus>
			<xsl:value-of select="'1'"/>
		</processingStatus>
	</xsl:template>
	<xsl:template name="effectiveDate_ipo1">
		<effectiveDate>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate"/>
		</effectiveDate>
	</xsl:template>
	<xsl:template name="announcementDate_ipo1"/>
	<xsl:template name="shortDescription_ipo1">
		<shortDescription>
			<xsl:value-of select="'Initial Public Offering'"/>
		</shortDescription>
	</xsl:template>
	<xsl:template name="description_ipo1">
		<description>
			<xsl:value-of select="'Initial Public Offering'"/>
		</description>
	</xsl:template>
	<xsl:template name="nexusStatus_ipo1">
		<nexusStatus>
			<xsl:value-of select="'0'"/>
		</nexusStatus>
	</xsl:template>
	<xsl:template name="provider_ipo1">
		<provider>
			<infra:code>
				<xsl:value-of select="'MANUAL'"/>
			</infra:code>
		</provider>
	</xsl:template>

	<!--Corporate ActionsOverview TPO for insert end-->

	<!--Corporate Actions Details TPO for insert-->

	<xsl:template name="optionNumber_ipo1">
		<optionNumber>
			<xsl:value-of select="'1'"/>
		</optionNumber>
	</xsl:template>
	<xsl:template name="issueType_ipo1">
		<xsl:if test="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:typeOfIssue and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:typeOfIssue != ''">
			<issueType>
				<xsl:if test="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:typeOfIssue ='SINGLEBID'">
					<xsl:value-of select="'1'"/>
				</xsl:if>
				<xsl:if test="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:typeOfIssue ='BOOKBUILD'">
					<xsl:value-of select="'2'"/>
				</xsl:if>
			</issueType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ipoLotSize_ipo1">
		<ipoLotSize>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoLotSize"/>
		</ipoLotSize>
	</xsl:template>
	<xsl:template name="paymentDate_ipo1">
		<paymentDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoAllotmentDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoAllotmentDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</paymentDate>
	</xsl:template>
	<xsl:template name="refundDate_ipo1">
		<refundDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoRefundDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoRefundDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</refundDate>
	</xsl:template>
	<xsl:template name="firstDealingDate_ipo1">
		<firstDealingDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoListingDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoListingDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</firstDealingDate>
	</xsl:template>
	<xsl:template name="responseDeadlineDate_ipo1">
		<responseDeadlineDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoIntCutOffDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoIntCutOffDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</responseDeadlineDate>
	</xsl:template>
	<xsl:template name="recordDate_ipo1">
		<recordDate>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</recordDate>
	</xsl:template>
	<xsl:template name="caOptionType_ipo1">
		<xsl:choose>
			<xsl:when test="(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsStartDt and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsStartDt !='') or (../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsEndDt and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:subsStartDtGroup/b:subsEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Subscription'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:when test="(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmStartDt and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmStartDt !='') or (../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmEndDt and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:redmStartDtGroup/b:redmEndDt !='')">
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Redemption'"/>
					</infra:code>
				</caOptionType>
			</xsl:when>
			<xsl:otherwise>
				<caOptionType>
					<infra:code>
						<xsl:value-of select="'Min_Max_Amounts'"/>
					</infra:code>
				</caOptionType>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="minHoldingAmt_ipo1"/>
	<xsl:template name="minSubscriptionPrice_ipo1">
		<minSubscriptionPrice>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:minOfferPrice"/>
		</minSubscriptionPrice>
	</xsl:template>
	<xsl:template name="maxSubscriptionPrice_ipo1">
		<maxSubscriptionPrice>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:maxOfferPrice"/>
		</maxSubscriptionPrice>
	</xsl:template>
	<xsl:template name="subscriptionPrice_ipo1">
		<subscriptionPrice>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:issueOfferPrice"/>
		</subscriptionPrice>
	</xsl:template>
	<xsl:template name="minInitSubscriptionAmt_ipo1"/>
	<xsl:template name="minSipAmt_ipo1"/>
	<xsl:template name="minSubscriptionAmt_ipo1">
		<minSubscriptionAmt>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:minInvestmentValue"/>
		</minSubscriptionAmt>
	</xsl:template>
	<xsl:template name="maxSubscriptionAmt_ipo1">
		<maxSubscriptionAmt>
			<xsl:value-of select="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:maxInvestmentValue"/>
		</maxSubscriptionAmt>
	</xsl:template>
	<xsl:template name="minSubscriptionCurr_ipo1"/>
	<xsl:template name="minRedemptionCurr_ipo1"/>
	<xsl:template name="minRedemptionAmt_ipo1"/>
	<xsl:template name="minHoldingDays_ipo1"/>
	<xsl:template name="overrideMinHoldingDays_ipo1"/>
	<xsl:template name="subscriptionPeriodBegin_ipo1">
		<subscriptionPeriodBegin>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoStartDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</subscriptionPeriodBegin>
	</xsl:template>
	<xsl:template name="subscriptionPeriodEnd_ipo1">
		<subscriptionPeriodEnd>
			<xsl:choose>
				<xsl:when test="string-length(translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoEndDate,'-','')) = '8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoEndDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</subscriptionPeriodEnd>
	</xsl:template>
	<xsl:template name="subscriptionEndTime_ipo1">
		<xsl:if test="../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoEndTime and ../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoEndTime != ''">
			<subscriptionEndTime>
				<xsl:value-of select="concat(../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:ipoEndTime,':00')"/>
			</subscriptionEndTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="redemptionPeriodBegin_ipo1"/>
	<xsl:template name="redemptionPeriodEnd_ipo1"/>
	<xsl:template name="sequenceNumber_ipo1">
		<sequenceNumber>
			<xsl:value-of select="'1'"/>
		</sequenceNumber>
	</xsl:template>
	<xsl:template name="dispositionFraction_ipo1">
		<dispositionFraction>
			<xsl:value-of select="'0'"/>
		</dispositionFraction>
	</xsl:template>
	<xsl:template name="defaultProcess_ipo1">
		<defaultProcess>
			<xsl:value-of select="'0'"/>
		</defaultProcess>
	</xsl:template>

	<!--Corporate Actions Deails TPO End for insert-->

	<xsl:template name="messageType_ipo1"/>
	<xsl:template name="senderReferenceCode_ipo1"/>
	<xsl:template name="subEventType_ipo1"/>
	<xsl:template name="addExistingSecu_ipo1"/>
	<xsl:template name="addSubscribedResultSecu_ipo1"/>
	<xsl:template name="availableDate_ipo1"/>
	<xsl:template name="conversionPeriodBegindate_ipo1"/>
	<xsl:template name="conversionPeriodEndDate_ipo1"/>
	<xsl:template name="creditedSecurityInstrument_ipo1"/>
	<xsl:template name="debitedSecurityInstrument_ipo1"/>
	<xsl:template name="drawDate_ipo1"/>
	<xsl:template name="exchangeRate_ipo1"/>
	<xsl:template name="exDate_ipo1"/>
	<xsl:template name="exercicePeriodBeginDate_ipo1"/>
	<xsl:template name="exercicePeriodEndDate_ipo1"/>
	<xsl:template name="exercicePrice_ipo1"/>
	<xsl:template name="fullProviderInfo_ipo1"/>
	<xsl:template name="grossDividendRate_ipo1"/>
	<xsl:template name="interestPeriodBeginDate_ipo1"/>
	<xsl:template name="interestPeriodEndDate_ipo1"/>
	<xsl:template name="interestRate_ipo1"/>
	<xsl:template name="intermediateInstrument_ipo1"/>
	<xsl:template name="intemediateExpirationDate_ipo1"/>
	<xsl:template name="intemediateIndicativePrice_ipo1"/>
	<xsl:template name="intemediateMarketPrice_ipo1"/>
	<xsl:template name="intermediateTradingPeriodBeginDate_ipo1"/>
	<xsl:template name="intermediateTradingPeriodEndDate_ipo1"/>
	<xsl:template name="intermediateSell_ipo1"/>
	<xsl:template name="issuePrice_ipo1"/>
	<xsl:template name="marketDeadlineDate_ipo1"/>
	<xsl:template name="marketPrice_ipo1"/>
	<xsl:template name="meetingDate_ipo1"/>
	<xsl:template name="netDividendRate_ipo1"/>
	<xsl:template name="newToOld_ipo1"/>
	<xsl:template name="newToRights_ipo1"/>
	<xsl:template name="nextDetailAnnonceDate_ipo1"/>
	<xsl:template name="offerPeriodBeginDate_ipo1"/>
	<xsl:template name="offerPeriodEndDate_ipo1"/>
	<xsl:template name="offerPricePaid_ipo1"/>
	<xsl:template name="offerPriceReceived_ipo1"/>
	<xsl:template name="offerPriceCurrency_ipo1"/>
	<xsl:template name="optionInstrument_ipo1"/>
	<xsl:template name="protectDate_ipo1"/>
	<xsl:template name="redemptionDate_ipo1"/>
	<xsl:template name="redemptionPrice_ipo1"/>
	<xsl:template name="redemptionRate_ipo1"/>
	<xsl:template name="reinvestmentPrice_ipo1"/>
	<xsl:template name="rightsToUnderlying_ipo1"/>
	<xsl:template name="subscriptionDate_ipo1"/>
	<xsl:template name="withholdingTaxRate_ipo1"/>
	<xsl:template name="mbFields_ipo1"/>
	<xsl:template name="optionCurrency_ipo1"/>
	<xsl:template name="mbFields_caDetail_ipo1"/>
	<xsl:template name="redemptionDays_ipo1"/>
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