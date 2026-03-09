<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PEProductEvents"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPEProductEvents" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPEProductEvents" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPEProductEvents" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPEProductEvents">
		<xsl:apply-templates select="c:CurrentEvent/b:PEProductEvents"/>
	</xsl:template>
	<xsl:template match="batch:BatchPEProductEvents">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPEProductEvents" name="BatchPEProductEvents">
			<xsl:apply-templates select="b:PEProductEvents"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPEProductEvents">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPEProductEvents" name="BatchMultiPEProductEvents">
			<xsl:apply-templates select="c:MultiPEProductEvents"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PEProductEvents">
		<FiPMS processDeletes="first">
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('PEProductEvents',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<!-- Mapping Condition 1.1 -->
				<xsl:for-each select="b:saveCapCallRefGroup">
					<xsl:variable name="Index" select="./@index"/>
					<xsl:variable name="saveCapCallRefVar" select="b:saveCapCallRef"/>
					<xsl:variable name="isSameGroupVar">
						<xsl:for-each select="../../../c:PreviousEvent/b:PEProductEvents/b:saveCapCallRefGroup">
							<xsl:choose>
								<xsl:when test="not(b:saveCapCallRef = $saveCapCallRefVar)">
									<xsl:value-of select="'YES'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NO'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:variable>
					<xsl:if test="not(contains($isSameGroupVar,'NO')) or not(../../../c:PreviousEvent/b:PEProductEvents/b:saveCapCallRefGroup)">
						<!-- CapitalCall -->
						<FundShare>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_CapitalCall"/>
							<xsl:call-template name="infra:synonym_CapitalCall"/>
							<xsl:call-template name="infra:shortName_CapitalCall"/>
							<xsl:call-template name="infra:longName_CapitalCall"/>
							<xsl:call-template name="infra:multilingualLongName_CapitalCall"/>
							<xsl:call-template name="infra:notepad_CapitalCall"/>
							<xsl:call-template name="infra:userDefinedField_CapitalCall"/>
							<xsl:call-template name="infra:mbFields_CapitalCall"/>
							<xsl:call-template name="active_CapitalCall"/>
							<xsl:call-template name="euroConversionDate_CapitalCall"/>
							<xsl:call-template name="euroConversionRule_CapitalCall"/>
							<xsl:call-template name="euroNewInstrument_CapitalCall"/>
							<xsl:call-template name="mainBusinessEntity_CapitalCall"/>
							<xsl:call-template name="mainStockExchange_CapitalCall"/>
							<xsl:call-template name="minimumQuantity_CapitalCall"/>
							<xsl:call-template name="priceCalculationRule_CapitalCall"/>
							<xsl:call-template name="provider_CapitalCall"/>
							<xsl:call-template name="referenceCurrency_CapitalCall"/>
							<xsl:call-template name="riskCountry_CapitalCall"/>
							<xsl:call-template name="riskNature_CapitalCall"/>
							<xsl:call-template name="roundLotQuantity_CapitalCall"/>
							<xsl:call-template name="sector_CapitalCall"/>
							<xsl:call-template name="stockExchange_CapitalCall"/>
							<xsl:call-template name="subType_CapitalCall"/>
							<xsl:call-template name="taxCountry_CapitalCall"/>
							<xsl:call-template name="tickSize_CapitalCall"/>
							<xsl:call-template name="tradable_CapitalCall"/>
							<xsl:call-template name="type_CapitalCall"/>
							<xsl:call-template name="valuationRule_CapitalCall"/>
							<xsl:call-template name="beginDate_CapitalCall"/>
							<xsl:call-template name="capitalGainTax_CapitalCall"/>
							<xsl:call-template name="complexity_CapitalCall"/>
							<xsl:call-template name="complexityLevel_CapitalCall"/>
							<xsl:call-template name="cutOffTime_CapitalCall"/>
							<xsl:call-template name="cutOffTimeZone_CapitalCall"/>
							<xsl:call-template name="dividendFrequencyNumber_CapitalCall"/>
							<xsl:call-template name="dividendFrequencyUnit_CapitalCall"/>
							<xsl:call-template name="eligibleWrapFund_CapitalCall"/>
							<xsl:call-template name="faceValue_CapitalCall"/>
							<xsl:call-template name="islamicCompliance_CapitalCall"/>
							<xsl:call-template name="issueQuantity_CapitalCall"/>
							<xsl:call-template name="issueQuote_CapitalCall"/>
							<xsl:call-template name="issuer_CapitalCall"/>
							<xsl:call-template name="marketDirectiveCategory_CapitalCall"/>
							<xsl:call-template name="minimumTradingAmount_CapitalCall"/>
							<xsl:call-template name="referenceIndex_CapitalCall"/>
							<xsl:call-template name="riskCurrency_CapitalCall"/>
							<xsl:call-template name="riskLevel_CapitalCall"/>
							<xsl:call-template name="roundLotAmount_CapitalCall"/>
							<xsl:call-template name="stpOrder_CapitalCall"/>
							<xsl:call-template name="subNature_CapitalCall"/>
							<xsl:call-template name="tradeNature_CapitalCall"/>
							<xsl:call-template name="votingRights_CapitalCall"/>
							<xsl:call-template name="witholdingTax_CapitalCall"/>
							<xsl:call-template name="dividend_CapitalCall"/>
							<xsl:call-template name="composition_CapitalCall"/>
							<xsl:call-template name="commonReference_CapitalCall"/>
							<xsl:call-template name="coolCancelF_CapitalCall"/>
							<xsl:call-template name="coolPeriod_CapitalCall"/>
							<xsl:call-template name="coolPeriodUnit_CapitalCall"/>
							<xsl:call-template name="fundIncomeStyleE_CapitalCall"/>
							<xsl:call-template name="parentInstrument_CapitalCall"/>

							

							<redemption>
								<xsl:call-template name="announcementDate_CapitalCallRedem"/>
								<xsl:call-template name="code_CapitalCallRedem"/>
								<xsl:call-template name="currency_CapitalCallRedem"/>
								<xsl:call-template name="endDate_CapitalCallRedem"/>
								<xsl:call-template name="effectiveMaturityDate_CapitalCallRedem"/>
								<xsl:call-template name="exchnageRate_CapitalCallRedem"/>
								<xsl:call-template name="exDate_CapitalCallRedem"/>
								<xsl:call-template name="nature_CapitalCallRedem"/>
								<xsl:call-template name="noticeDays_CapitalCallRedem"/>
								<xsl:call-template name="proportionAppliedOn_CapitalCallRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_CapitalCallRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_CapitalCallRedem"/>
								<xsl:call-template name="redemptionQuote_CapitalCallRedem"/>
								<xsl:call-template name="redemptionPercentage_CapitalCallRedem"/>
								<xsl:call-template name="validityDate_CapitalCallRedem"/>
								<xsl:call-template name="mbFields_CapitalCallRedem"/>
							</redemption>
							<xsl:call-template name="reinvestmentAllowedF_CapitalCall"/>
							<xsl:call-template name="switchOrderAmt_CapitalCall"/>
							<xsl:call-template name="switchOrderPerc_CapitalCall"/>
							<xsl:call-template name="switchOrderUnit_CapitalCall"/>
						</FundShare>
						<xsl:if test="b:saveUnitsIssued = 'YES'">
							<!-- Allot Units -->
							<FundShare>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="infra:code_Allot"/>
								<xsl:call-template name="infra:synonym_Allot"/>
								<xsl:call-template name="infra:shortName_Allot"/>
								<xsl:call-template name="infra:longName_Allot"/>
								<xsl:call-template name="infra:multilingualLongName_Allot"/>
								<xsl:call-template name="infra:notepad_Allot"/>
								<xsl:call-template name="infra:userDefinedField_Allot"/>
								<xsl:call-template name="infra:mbFields_Allot"/>
								<xsl:call-template name="active_Allot"/>
								<xsl:call-template name="euroConversionDate_Allot"/>
								<xsl:call-template name="euroConversionRule_Allot"/>
								<xsl:call-template name="euroNewInstrument_Allot"/>
								<xsl:call-template name="mainBusinessEntity_Allot"/>
								<xsl:call-template name="mainStockExchange_Allot"/>
								<xsl:call-template name="minimumQuantity_Allot"/>
								<xsl:call-template name="priceCalculationRule_Allot"/>
								<xsl:call-template name="provider_Allot"/>
								<xsl:call-template name="referenceCurrency_Allot"/>
								<xsl:call-template name="riskCountry_Allot"/>
								<xsl:call-template name="riskNature_Allot"/>
								<xsl:call-template name="roundLotQuantity_Allot"/>
								<xsl:call-template name="sector_Allot"/>
								<xsl:call-template name="stockExchange_Allot"/>
								<xsl:call-template name="subType_Allot"/>
								<xsl:call-template name="taxCountry_Allot"/>
								<xsl:call-template name="tickSize_Allot"/>
								<xsl:call-template name="tradable_Allot"/>
								<xsl:call-template name="type_Allot"/>
								<xsl:call-template name="valuationRule_Allot"/>
								<xsl:call-template name="beginDate_Allot"/>
								<xsl:call-template name="capitalGainTax_Allot"/>
								<xsl:call-template name="complexity_Allot"/>
								<xsl:call-template name="complexityLevel_Allot"/>
								<xsl:call-template name="cutOffTime_Allot"/>
								<xsl:call-template name="cutOffTimeZone_Allot"/>
								<xsl:call-template name="dividendFrequencyNumber_Allot"/>
								<xsl:call-template name="dividendFrequencyUnit_Allot"/>
								<xsl:call-template name="eligibleWrapFund_Allot"/>
								<xsl:call-template name="faceValue_Allot"/>
								<xsl:call-template name="islamicCompliance_Allot"/>
								<xsl:call-template name="issueQuantity_Allot"/>
								<xsl:call-template name="issueQuote_Allot"/>
								<xsl:call-template name="issuer_Allot"/>
								<xsl:call-template name="marketDirectiveCategory_Allot"/>
								<xsl:call-template name="minimumTradingAmount_Allot"/>
								<xsl:call-template name="referenceIndex_Allot"/>
								<xsl:call-template name="riskCurrency_Allot"/>
								<xsl:call-template name="riskLevel_Allot"/>
								<xsl:call-template name="roundLotAmount_Allot"/>
								<xsl:call-template name="stpOrder_Allot"/>
								<xsl:call-template name="subNature_Allot"/>
								<xsl:call-template name="tradeNature_Allot"/>
								<xsl:call-template name="votingRights_Allot"/>
								<xsl:call-template name="witholdingTax_Allot"/>
								<xsl:call-template name="dividend_Allot"/>
								<xsl:call-template name="composition_Allot"/>
								<xsl:call-template name="commonReference_Allot"/>
								<xsl:call-template name="coolCancelF_Allot"/>
								<xsl:call-template name="coolPeriod_Allot"/>
								<xsl:call-template name="coolPeriodUnit_Allot"/>
								<xsl:call-template name="fundIncomeStyleE_Allot"/>
								<xsl:call-template name="parentInstrument_Allot"/>
								<redemption>
									<xsl:call-template name="announcementDate_AllotRedem"/>
									<xsl:call-template name="code_AllotRedem"/>
									<xsl:call-template name="currency_AllotRedem"/>
									<xsl:call-template name="endDate_AllotRedem"/>
									<xsl:call-template name="effectiveMaturityDate_AllotRedem"/>
									<xsl:call-template name="exchnageRate_AllotRedem"/>
									<xsl:call-template name="exDate_AllotRedem"/>
									<xsl:call-template name="nature_AllotRedem"/>
									<xsl:call-template name="noticeDays_AllotRedem"/>
									<xsl:call-template name="proportionAppliedOn_AllotRedem"/>
									<xsl:call-template name="redemptionFrequenceyNumber_AllotRedem"/>
									<xsl:call-template name="redemptionFrequenceyUnit_AllotRedem"/>
									<xsl:call-template name="redemptionQuote_AllotRedem"/>
									<xsl:call-template name="redemptionPercentage_AllotRedem"/>
									<xsl:call-template name="validityDate_AllotRedem"/>
									<xsl:call-template name="mbFields_AllotRedem"/>
								</redemption>
								<xsl:call-template name="reinvestmentAllowedF_Allot"/>
								<xsl:call-template name="switchOrderAmt_Allot"/>
								<xsl:call-template name="switchOrderPerc_Allot"/>
								<xsl:call-template name="switchOrderUnit_Allot"/>
							</FundShare>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
				<!-- Mapping Condition 1.2 -->
				<xsl:for-each select="b:saveCapCallRefGroup">
					<xsl:variable name="Index" select="./@index"/>
					<xsl:variable name="saveCapCallRefVar" select="b:saveCapCallRef"/>
					<xsl:variable name="saveUnitsIssuedVar" select="b:saveUnitsIssued"/>
					<xsl:variable name="isSameGroupVar">
						<xsl:for-each select="../../../c:PreviousEvent/b:PEProductEvents/b:saveCapCallRefGroup">
							<xsl:choose>
								<xsl:when test="b:saveCapCallRef = $saveCapCallRefVar and $saveUnitsIssuedVar = 'YES' and b:saveUnitsIssued = 'NO'">
									<xsl:value-of select="'YES'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NO'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:variable>
					<xsl:if test="contains($isSameGroupVar,'YES')">
						<!-- Allot Units -->
						<FundShare>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PEEventsIL.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_Allot"/>
							<xsl:call-template name="infra:synonym_Allot"/>
							<xsl:call-template name="infra:shortName_Allot"/>
							<xsl:call-template name="infra:longName_Allot"/>
							<xsl:call-template name="infra:multilingualLongName_Allot"/>
							<xsl:call-template name="infra:notepad_Allot"/>
							<xsl:call-template name="infra:userDefinedField_Allot"/>
							<xsl:call-template name="infra:mbFields_Allot"/>
							<xsl:call-template name="active_Allot"/>
							<xsl:call-template name="euroConversionDate_Allot"/>
							<xsl:call-template name="euroConversionRule_Allot"/>
							<xsl:call-template name="euroNewInstrument_Allot"/>
							<xsl:call-template name="mainBusinessEntity_Allot"/>
							<xsl:call-template name="mainStockExchange_Allot"/>
							<xsl:call-template name="minimumQuantity_Allot"/>
							<xsl:call-template name="priceCalculationRule_Allot"/>
							<xsl:call-template name="provider_Allot"/>
							<xsl:call-template name="referenceCurrency_Allot"/>
							<xsl:call-template name="riskCountry_Allot"/>
							<xsl:call-template name="riskNature_Allot"/>
							<xsl:call-template name="roundLotQuantity_Allot"/>
							<xsl:call-template name="sector_Allot"/>
							<xsl:call-template name="stockExchange_Allot"/>
							<xsl:call-template name="subType_Allot"/>
							<xsl:call-template name="taxCountry_Allot"/>
							<xsl:call-template name="tickSize_Allot"/>
							<xsl:call-template name="tradable_Allot"/>
							<xsl:call-template name="type_Allot"/>
							<xsl:call-template name="valuationRule_Allot"/>
							<xsl:call-template name="beginDate_Allot"/>
							<xsl:call-template name="capitalGainTax_Allot"/>
							<xsl:call-template name="complexity_Allot"/>
							<xsl:call-template name="complexityLevel_Allot"/>
							<xsl:call-template name="cutOffTime_Allot"/>
							<xsl:call-template name="cutOffTimeZone_Allot"/>
							<xsl:call-template name="dividendFrequencyNumber_Allot"/>
							<xsl:call-template name="dividendFrequencyUnit_Allot"/>
							<xsl:call-template name="eligibleWrapFund_Allot"/>
							<xsl:call-template name="faceValue_Allot"/>
							<xsl:call-template name="islamicCompliance_Allot"/>
							<xsl:call-template name="issueQuantity_Allot"/>
							<xsl:call-template name="issueQuote_Allot"/>
							<xsl:call-template name="issuer_Allot"/>
							<xsl:call-template name="marketDirectiveCategory_Allot"/>
							<xsl:call-template name="minimumTradingAmount_Allot"/>
							<xsl:call-template name="referenceIndex_Allot"/>
							<xsl:call-template name="riskCurrency_Allot"/>
							<xsl:call-template name="riskLevel_Allot"/>
							<xsl:call-template name="roundLotAmount_Allot"/>
							<xsl:call-template name="stpOrder_Allot"/>
							<xsl:call-template name="subNature_Allot"/>
							<xsl:call-template name="tradeNature_Allot"/>
							<xsl:call-template name="votingRights_Allot"/>
							<xsl:call-template name="witholdingTax_Allot"/>
							<xsl:call-template name="dividend_Allot"/>
							<xsl:call-template name="composition_Allot"/>
							<xsl:call-template name="commonReference_Allot"/>
							<xsl:call-template name="coolCancelF_Allot"/>
							<xsl:call-template name="coolPeriod_Allot"/>
							<xsl:call-template name="coolPeriodUnit_Allot"/>
							<xsl:call-template name="fundIncomeStyleE_Allot"/>
							<xsl:call-template name="parentInstrument_Allot"/>
							<redemption>
								<xsl:call-template name="announcementDate_AllotRedem"/>
								<xsl:call-template name="code_AllotRedem"/>
								<xsl:call-template name="currency_AllotRedem"/>
								<xsl:call-template name="endDate_AllotRedem"/>
								<xsl:call-template name="effectiveMaturityDate_AllotRedem"/>
								<xsl:call-template name="exchnageRate_AllotRedem"/>
								<xsl:call-template name="exDate_AllotRedem"/>
								<xsl:call-template name="nature_AllotRedem"/>
								<xsl:call-template name="noticeDays_AllotRedem"/>
								<xsl:call-template name="proportionAppliedOn_AllotRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_AllotRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_AllotRedem"/>
								<xsl:call-template name="redemptionQuote_AllotRedem"/>
								<xsl:call-template name="redemptionPercentage_AllotRedem"/>
								<xsl:call-template name="validityDate_AllotRedem"/>
								<xsl:call-template name="mbFields_AllotRedem"/>
							</redemption>
							<xsl:call-template name="reinvestmentAllowedF_Allot"/>
							<xsl:call-template name="switchOrderAmt_Allot"/>
							<xsl:call-template name="switchOrderPerc_Allot"/>
							<xsl:call-template name="switchOrderUnit_Allot"/>
						</FundShare>
					</xsl:if>
				</xsl:for-each>
				<!-- Mapping Condition 2 -->
				<xsl:for-each select="b:saveReturnOfCapPercGroup">
					<xsl:variable name="Index" select="./@index"/>
					<xsl:variable name="saveReturnOfCapPercVar" select="b:saveReturnOfCapPerc"/>
					<xsl:variable name="savePercentageBasisVar" select="b:savePercentageBasis"/>
					<xsl:variable name="saveIntPercRocVar" select="b:saveIntPercRoc"/>
					<xsl:variable name="saveReturnDateVar" select="translate(b:saveReturnDate,'-','')"/>
					<xsl:variable name="isSameGroupVar">
						<xsl:for-each select="../../../c:PreviousEvent/b:PEProductEvents/b:saveReturnOfCapPercGroup">
							<xsl:choose>
								<xsl:when test="not(b:saveReturnOfCapPerc = $saveReturnOfCapPercVar and b:savePercentageBasis = $savePercentageBasisVar and b:saveIntPercRoc = $saveIntPercRocVar)">
									<xsl:value-of select="'YES'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NO'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:variable>
					<!-- Mapping Condition 2.1 and 2.2 -->
					<xsl:if test="not(contains($isSameGroupVar,'NO')) or not(../../../c:PreviousEvent/b:PEProductEvents/b:saveReturnOfCapPercGroup)">
						<xsl:variable name="saveCapCallRefGroupRanks">
							<xsl:for-each select="../../../c:CurrentEvent/b:PEProductEvents/b:saveCapCallRefGroup/b:saveCapCallDate">
								<xsl:sort data-type="number" order="descending" select="translate(.,'-','')"/>
								<xsl:if test="translate(.,'-','') &lt;= $saveReturnDateVar">
									<xsl:value-of select="concat(../@index,'Y')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:variable>
						<xsl:variable name="saveCapCallRefGroupIndex" select="substring-before($saveCapCallRefGroupRanks,'Y')"/>

						<xsl:if test="$saveCapCallRefGroupIndex != ''">
							
							<xsl:choose>
								<!--Mapping Condition 2.3.1 -->
								<xsl:when test="(../../../c:CurrentEvent/b:PEProductEvents/b:saveCapCallRefGroup[@index=$saveCapCallRefGroupIndex][starts-with(b:saveUnitsIssued,'PR') or b:saveUnitsIssued='YES' or b:saveUnitsIssued='RETURNED' and (translate(b:saveUnitsIssueDate,'-','') &lt;= $saveReturnDateVar)]) or $saveCapCallRefGroupIndex !=''">
									<!-- CapReturnAfterAU -->
									<FundShare>
										<xsl:attribute name="description">
											<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
										</xsl:attribute>
										<xsl:attribute name="sequenceNumber">
											<xsl:call-template name="calcSeqNum">
												<xsl:with-param name="creationTime">
													<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:attribute>
										<xsl:call-template name="infra:code_CapReturnAfterAU"/>
										<xsl:call-template name="infra:synonym_CapReturnAfterAU"/>
										<xsl:call-template name="infra:shortName_CapReturnAfterAU"/>
										<xsl:call-template name="infra:longName_CapReturnAfterAU"/>
										<xsl:call-template name="infra:multilingualLongName_CapReturnAfterAU"/>
										<xsl:call-template name="infra:notepad_CapReturnAfterAU"/>
										<xsl:call-template name="infra:userDefinedField_CapReturnAfterAU"/>
										<xsl:call-template name="infra:mbFields_CapReturnAfterAU"/>
										<xsl:call-template name="active_CapReturnAfterAU"/>
										<xsl:call-template name="euroConversionDate_CapReturnAfterAU"/>
										<xsl:call-template name="euroConversionRule_CapReturnAfterAU"/>
										<xsl:call-template name="euroNewInstrument_CapReturnAfterAU"/>
										<xsl:call-template name="mainBusinessEntity_CapReturnAfterAU"/>
										<xsl:call-template name="mainStockExchange_CapReturnAfterAU"/>
										<xsl:call-template name="minimumQuantity_CapReturnAfterAU"/>
										<xsl:call-template name="priceCalculationRule_CapReturnAfterAU"/>
										<xsl:call-template name="provider_CapReturnAfterAU"/>
										<xsl:call-template name="referenceCurrency_CapReturnAfterAU"/>
										<xsl:call-template name="riskCountry_CapReturnAfterAU"/>
										<xsl:call-template name="riskNature_CapReturnAfterAU"/>
										<xsl:call-template name="roundLotQuantity_CapReturnAfterAU"/>
										<xsl:call-template name="sector_CapReturnAfterAU"/>
										<xsl:call-template name="stockExchange_CapReturnAfterAU"/>
										<xsl:call-template name="subType_CapReturnAfterAU"/>
										<xsl:call-template name="taxCountry_CapReturnAfterAU"/>
										<xsl:call-template name="tickSize_CapReturnAfterAU"/>
										<xsl:call-template name="tradable_CapReturnAfterAU"/>
										<xsl:call-template name="type_CapReturnAfterAU"/>
										<xsl:call-template name="valuationRule_CapReturnAfterAU"/>
										<xsl:call-template name="beginDate_CapReturnAfterAU"/>
										<xsl:call-template name="capitalGainTax_CapReturnAfterAU"/>
										<xsl:call-template name="complexity_CapReturnAfterAU"/>
										<xsl:call-template name="complexityLevel_CapReturnAfterAU"/>
										<xsl:call-template name="cutOffTime_CapReturnAfterAU"/>
										<xsl:call-template name="cutOffTimeZone_CapReturnAfterAU"/>
										<xsl:call-template name="dividendFrequencyNumber_CapReturnAfterAU"/>
										<xsl:call-template name="dividendFrequencyUnit_CapReturnAfterAU"/>
										<xsl:call-template name="eligibleWrapFund_CapReturnAfterAU"/>
										<xsl:call-template name="faceValue_CapReturnAfterAU"/>
										<xsl:call-template name="islamicCompliance_CapReturnAfterAU"/>
										<xsl:call-template name="issueQuantity_CapReturnAfterAU"/>
										<xsl:call-template name="issueQuote_CapReturnAfterAU"/>
										<xsl:call-template name="issuer_CapReturnAfterAU"/>
										<xsl:call-template name="marketDirectiveCategory_CapReturnAfterAU"/>
										<xsl:call-template name="minimumTradingAmount_CapReturnAfterAU"/>
										<xsl:call-template name="referenceIndex_CapReturnAfterAU"/>
										<xsl:call-template name="riskCurrency_CapReturnAfterAU"/>
										<xsl:call-template name="riskLevel_CapReturnAfterAU"/>
										<xsl:call-template name="roundLotAmount_CapReturnAfterAU"/>
										<xsl:call-template name="stpOrder_CapReturnAfterAU"/>
										<xsl:call-template name="subNature_CapReturnAfterAU"/>
										<xsl:call-template name="tradeNature_CapReturnAfterAU"/>
										<xsl:call-template name="votingRights_CapReturnAfterAU"/>
										<xsl:call-template name="witholdingTax_CapReturnAfterAU"/>
										<xsl:call-template name="dividend_CapReturnAfterAU"/>
										<xsl:call-template name="composition_CapReturnAfterAU"/>
										<xsl:call-template name="commonReference_CapReturnAfterAU"/>
										<xsl:call-template name="coolCancelF_CapReturnAfterAU"/>
										<xsl:call-template name="coolPeriod_CapReturnAfterAU"/>
										<xsl:call-template name="coolPeriodUnit_CapReturnAfterAU"/>
										<xsl:call-template name="fundIncomeStyleE_CapReturnAfterAU"/>
										<xsl:call-template name="parentInstrument_CapReturnAfterAU"/>
										<redemption>
											<xsl:call-template name="announcementDate_CapReturnAfterAURedem"/>
											<xsl:call-template name="code_CapReturnAfterAURedem"/>
											<xsl:call-template name="currency_CapReturnAfterAURedem"/>
											<xsl:call-template name="endDate_CapReturnAfterAURedem"/>
											<xsl:call-template name="effectiveMaturityDate_CapReturnAfterAURedem"/>
											<xsl:call-template name="exchnageRate_CapReturnAfterAURedem"/>
											<xsl:call-template name="exDate_CapReturnAfterAURedem"/>
											<xsl:call-template name="nature_CapReturnAfterAURedem"/>
											<xsl:call-template name="noticeDays_CapReturnAfterAURedem"/>
											<xsl:call-template name="proportionAppliedOn_CapReturnAfterAURedem"/>
											<xsl:call-template name="redemptionFrequenceyNumber_CapReturnAfterAURedem"/>
											<xsl:call-template name="redemptionFrequenceyUnit_CapReturnAfterAURedem"/>
											<xsl:call-template name="redemptionQuote_CapReturnAfterAURedem"/>
											<xsl:call-template name="redemptionPercentage_CapReturnAfterAURedem"/>
											<xsl:call-template name="validityDate_CapReturnAfterAURedem"/>
											<xsl:call-template name="eventAmount_CapReturnAfterAURedem"/>
											<xsl:call-template name="mbFields_CapReturnAfterAURedem"/>
										</redemption>
										<xsl:call-template name="reinvestmentAllowedF_CapReturnAfterAU"/>
										<xsl:call-template name="switchOrderAmt_CapReturnAfterAU"/>
										<xsl:call-template name="switchOrderPerc_CapReturnAfterAU"/>
										<xsl:call-template name="switchOrderUnit_CapReturnAfterAU"/>
										
									</FundShare>
								</xsl:when>
								<!-- Mapping Condition 2.3.2 -->
								<xsl:when test="../../../c:CurrentEvent/b:PEProductEvents/b:saveCapCallRefGroup[@index=$saveCapCallRefGroupIndex][starts-with(b:saveUnitsIssued,'PR') or b:saveUnitsIssued='NO' or b:saveUnitsIssued='RETURNED' or (translate(b:saveUnitsIssueDate,'-','') &gt; $saveReturnDateVar)]">
									<!-- CapReturnBeforeAU -->
									<FundShare>
										<xsl:attribute name="description">
											<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
										</xsl:attribute>
										<xsl:attribute name="sequenceNumber">
											<xsl:call-template name="calcSeqNum">
												<xsl:with-param name="creationTime">
													<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:attribute>
										<xsl:call-template name="infra:code_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:synonym_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:shortName_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:longName_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:multilingualLongName_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:notepad_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:userDefinedField_CapReturnBeforeAU"/>
										<xsl:call-template name="infra:mbFields_CapReturnBeforeAU"/>
										<xsl:call-template name="active_CapReturnBeforeAU"/>
										<xsl:call-template name="euroConversionDate_CapReturnBeforeAU"/>
										<xsl:call-template name="euroConversionRule_CapReturnBeforeAU"/>
										<xsl:call-template name="euroNewInstrument_CapReturnBeforeAU"/>
										<xsl:call-template name="mainBusinessEntity_CapReturnBeforeAU"/>
										<xsl:call-template name="mainStockExchange_CapReturnBeforeAU"/>
										<xsl:call-template name="minimumQuantity_CapReturnBeforeAU"/>
										<xsl:call-template name="priceCalculationRule_CapReturnBeforeAU"/>
										<xsl:call-template name="provider_CapReturnBeforeAU"/>
										<xsl:call-template name="referenceCurrency_CapReturnBeforeAU"/>
										<xsl:call-template name="riskCountry_CapReturnBeforeAU"/>
										<xsl:call-template name="riskNature_CapReturnBeforeAU"/>
										<xsl:call-template name="roundLotQuantity_CapReturnBeforeAU"/>
										<xsl:call-template name="sector_CapReturnBeforeAU"/>
										<xsl:call-template name="stockExchange_CapReturnBeforeAU"/>
										<xsl:call-template name="subType_CapReturnBeforeAU"/>
										<xsl:call-template name="taxCountry_CapReturnBeforeAU"/>
										<xsl:call-template name="tickSize_CapReturnBeforeAU"/>
										<xsl:call-template name="tradable_CapReturnBeforeAU"/>
										<xsl:call-template name="type_CapReturnBeforeAU"/>
										<xsl:call-template name="valuationRule_CapReturnBeforeAU"/>
										<xsl:call-template name="beginDate_CapReturnBeforeAU"/>
										<xsl:call-template name="capitalGainTax_CapReturnBeforeAU"/>
										<xsl:call-template name="complexity_CapReturnBeforeAU"/>
										<xsl:call-template name="complexityLevel_CapReturnBeforeAU"/>
										<xsl:call-template name="cutOffTime_CapReturnBeforeAU"/>
										<xsl:call-template name="cutOffTimeZone_CapReturnBeforeAU"/>
										<xsl:call-template name="dividendFrequencyNumber_CapReturnBeforeAU"/>
										<xsl:call-template name="dividendFrequencyUnit_CapReturnBeforeAU"/>
										<xsl:call-template name="eligibleWrapFund_CapReturnBeforeAU"/>
										<xsl:call-template name="faceValue_CapReturnBeforeAU"/>
										<xsl:call-template name="islamicCompliance_CapReturnBeforeAU"/>
										<xsl:call-template name="issueQuantity_CapReturnBeforeAU"/>
										<xsl:call-template name="issueQuote_CapReturnBeforeAU"/>
										<xsl:call-template name="issuer_CapReturnBeforeAU"/>
										<xsl:call-template name="marketDirectiveCategory_CapReturnBeforeAU"/>
										<xsl:call-template name="minimumTradingAmount_CapReturnBeforeAU"/>
										<xsl:call-template name="referenceIndex_CapReturnBeforeAU"/>
										<xsl:call-template name="riskCurrency_CapReturnBeforeAU"/>
										<xsl:call-template name="riskLevel_CapReturnBeforeAU"/>
										<xsl:call-template name="roundLotAmount_CapReturnBeforeAU"/>
										<xsl:call-template name="stpOrder_CapReturnBeforeAU"/>
										<xsl:call-template name="subNature_CapReturnBeforeAU"/>
										<xsl:call-template name="tradeNature_CapReturnBeforeAU"/>
										<xsl:call-template name="votingRights_CapReturnBeforeAU"/>
										<xsl:call-template name="witholdingTax_CapReturnBeforeAU"/>
										<xsl:call-template name="dividend_CapReturnBeforeAU"/>
										<xsl:call-template name="composition_CapReturnBeforeAU"/>
										<xsl:call-template name="commonReference_CapReturnBeforeAU"/>
										<xsl:call-template name="coolCancelF_CapReturnBeforeAU"/>
										<xsl:call-template name="coolPeriod_CapReturnBeforeAU"/>
										<xsl:call-template name="coolPeriodUnit_CapReturnBeforeAU"/>
										<xsl:call-template name="fundIncomeStyleE_CapReturnBeforeAU"/>
										<xsl:call-template name="parentInstrument_CapReturnBeforeAU"/>
										<redemption>
											<xsl:call-template name="announcementDate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="code_CapReturnBeforeAURedem"/>
											<xsl:call-template name="currency_CapReturnBeforeAURedem"/>
											<xsl:call-template name="endDate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="effectiveMaturityDate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="exchnageRate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="exDate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="nature_CapReturnBeforeAURedem"/>
											<xsl:call-template name="noticeDays_CapReturnBeforeAURedem"/>
											<xsl:call-template name="proportionAppliedOn_CapReturnBeforeAURedem"/>
											<xsl:call-template name="redemptionFrequenceyNumber_CapReturnBeforeAURedem"/>
											<xsl:call-template name="redemptionFrequenceyUnit_CapReturnBeforeAURedem"/>
											<xsl:call-template name="redemptionQuote_CapReturnBeforeAURedem"/>
											<xsl:call-template name="redemptionPercentage_CapReturnBeforeAURedem"/>
											<xsl:call-template name="validityDate_CapReturnBeforeAURedem"/>
											<xsl:call-template name="eventAmount_CapReturnBeforeAURedem"/>
											<xsl:call-template name="mbFields_CapReturnBeforeAURedem"/>
										</redemption>
										<xsl:call-template name="reinvestmentAllowedF_CapReturnBeforeAU"/>
										<xsl:call-template name="switchOrderAmt_CapReturnBeforeAU"/>
										<xsl:call-template name="switchOrderPerc_CapReturnBeforeAU"/>
										<xsl:call-template name="switchOrderUnit_CapReturnBeforeAU"/>
										
									</FundShare>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
				<!-- Mapping Condition 3 -->
				<xsl:for-each select="b:saveCommitRednPercGroup">
					<xsl:variable name="Index" select="./@index"/>
					<xsl:variable name="saveCommitRednPercVar" select="b:saveCommitRednPerc"/>
					<xsl:variable name="saveCommitRednDateVar" select="b:saveCommitRednDate"/>
					<xsl:variable name="isSameGroupVar">
						<xsl:for-each select="../../../c:PreviousEvent/b:PEProductEvents/b:saveCommitRednPercGroup">
							<xsl:choose>
								<xsl:when test="not(b:saveCommitRednPerc = $saveCommitRednPercVar and b:saveCommitRednDate = $saveCommitRednDateVar)">
									<xsl:value-of select="'YES'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NO'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:variable>
					<xsl:if test="not(contains($isSameGroupVar,'NO')) or not(../../../c:PreviousEvent/b:PEProductEvents/b:saveCommitRednPercGroup)">
						<!-- CommitmentReduction -->
						<FundShare>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_CommitRedn"/>
							<xsl:call-template name="infra:synonym_CommitRedn"/>
							<xsl:call-template name="infra:shortName_CommitRedn"/>
							<xsl:call-template name="infra:longName_CommitRedn"/>
							<xsl:call-template name="infra:multilingualLongName_CommitRedn"/>
							<xsl:call-template name="infra:notepad_CommitRedn"/>
							<xsl:call-template name="infra:userDefinedField_CommitRedn"/>
							<xsl:call-template name="infra:mbFields_CommitRedn"/>
							<xsl:call-template name="active_CommitRedn"/>
							<xsl:call-template name="euroConversionDate_CommitRedn"/>
							<xsl:call-template name="euroConversionRule_CommitRedn"/>
							<xsl:call-template name="euroNewInstrument_CommitRedn"/>
							<xsl:call-template name="mainBusinessEntity_CommitRedn"/>
							<xsl:call-template name="mainStockExchange_CommitRedn"/>
							<xsl:call-template name="minimumQuantity_CommitRedn"/>
							<xsl:call-template name="priceCalculationRule_CommitRedn"/>
							<xsl:call-template name="provider_CommitRedn"/>
							<xsl:call-template name="referenceCurrency_CommitRedn"/>
							<xsl:call-template name="riskCountry_CommitRedn"/>
							<xsl:call-template name="riskNature_CommitRedn"/>
							<xsl:call-template name="roundLotQuantity_CommitRedn"/>
							<xsl:call-template name="sector_CommitRedn"/>
							<xsl:call-template name="stockExchange_CommitRedn"/>
							<xsl:call-template name="subType_CommitRedn"/>
							<xsl:call-template name="taxCountry_CommitRedn"/>
							<xsl:call-template name="tickSize_CommitRedn"/>
							<xsl:call-template name="tradable_CommitRedn"/>
							<xsl:call-template name="type_CommitRedn"/>
							<xsl:call-template name="valuationRule_CommitRedn"/>
							<xsl:call-template name="beginDate_CommitRedn"/>
							<xsl:call-template name="capitalGainTax_CommitRedn"/>
							<xsl:call-template name="complexity_CommitRedn"/>
							<xsl:call-template name="complexityLevel_CommitRedn"/>
							<xsl:call-template name="cutOffTime_CommitRedn"/>
							<xsl:call-template name="cutOffTimeZone_CommitRedn"/>
							<xsl:call-template name="dividendFrequencyNumber_CommitRedn"/>
							<xsl:call-template name="dividendFrequencyUnit_CommitRedn"/>
							<xsl:call-template name="eligibleWrapFund_CommitRedn"/>
							<xsl:call-template name="faceValue_CommitRedn"/>
							<xsl:call-template name="islamicCompliance_CommitRedn"/>
							<xsl:call-template name="issueQuantity_CommitRedn"/>
							<xsl:call-template name="issueQuote_CommitRedn"/>
							<xsl:call-template name="issuer_CommitRedn"/>
							<xsl:call-template name="marketDirectiveCategory_CommitRedn"/>
							<xsl:call-template name="minimumTradingAmount_CommitRedn"/>
							<xsl:call-template name="referenceIndex_CommitRedn"/>
							<xsl:call-template name="riskCurrency_CommitRedn"/>
							<xsl:call-template name="riskLevel_CommitRedn"/>
							<xsl:call-template name="roundLotAmount_CommitRedn"/>
							<xsl:call-template name="stpOrder_CommitRedn"/>
							<xsl:call-template name="subNature_CommitRedn"/>
							<xsl:call-template name="tradeNature_CommitRedn"/>
							<xsl:call-template name="votingRights_CommitRedn"/>
							<xsl:call-template name="witholdingTax_CommitRedn"/>
							<xsl:call-template name="dividend_CommitRedn"/>
							<xsl:call-template name="composition_CommitRedn"/>
							<xsl:call-template name="commonReference_CommitRedn"/>
							<xsl:call-template name="coolCancelF_CommitRedn"/>
							<xsl:call-template name="coolPeriod_CommitRedn"/>
							<xsl:call-template name="coolPeriodUnit_CommitRedn"/>
							<xsl:call-template name="fundIncomeStyleE_CommitRedn"/>
							<xsl:call-template name="parentInstrument_CommitRedn"/>
							<redemption>
								<xsl:call-template name="announcementDate_CommitRednRedem"/>
								<xsl:call-template name="code_CommitRednRedem"/>
								<xsl:call-template name="currency_CommitRednRedem"/>
								<xsl:call-template name="endDate_CommitRednRedem"/>
								<xsl:call-template name="effectiveMaturityDate_CommitRednRedem"/>
								<xsl:call-template name="exchnageRate_CommitRednRedem"/>
								<xsl:call-template name="exDate_CommitRednRedem"/>
								<xsl:call-template name="nature_CommitRednRedem"/>
								<xsl:call-template name="noticeDays_CommitRednRedem"/>
								<xsl:call-template name="proportionAppliedOn_CommitRednRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_CommitRednRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_CommitRednRedem"/>
								<xsl:call-template name="redemptionQuote_CommitRednRedem"/>
								<xsl:call-template name="redemptionPercentage_CommitRednRedem"/>
								<xsl:call-template name="validityDate_CommitRednRedem"/>
								<xsl:call-template name="mbFields_CommitRednRedem"/>
							</redemption>
							<xsl:call-template name="reinvestmentAllowedF_CommitRedn"/>
							<xsl:call-template name="switchOrderAmt_CommitRedn"/>
							<xsl:call-template name="switchOrderPerc_CommitRedn"/>
							<xsl:call-template name="switchOrderUnit_CommitRedn"/>
						</FundShare>
					</xsl:if>
				</xsl:for-each>
				<!-- Mapping Condition 4 -->
				<xsl:for-each select="b:saveMaturityPriceGroup">
					<!-- Maturity -->
					<FundShare>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="infra:code_MaturityPrice"/>
						<xsl:call-template name="infra:synonym_MaturityPrice"/>
						<xsl:call-template name="infra:shortName_MaturityPrice"/>
						<xsl:call-template name="infra:longName_MaturityPrice"/>
						<xsl:call-template name="infra:multilingualLongName_MaturityPrice"/>
						<xsl:call-template name="infra:notepad_MaturityPrice"/>
						<xsl:call-template name="infra:userDefinedField_MaturityPrice"/>
						<xsl:call-template name="infra:mbFields_MaturityPrice"/>
						<xsl:call-template name="active_MaturityPrice"/>
						<xsl:call-template name="euroConversionDate_MaturityPrice"/>
						<xsl:call-template name="euroConversionRule_MaturityPrice"/>
						<xsl:call-template name="euroNewInstrument_MaturityPrice"/>
						<xsl:call-template name="mainBusinessEntity_MaturityPrice"/>
						<xsl:call-template name="mainStockExchange_MaturityPrice"/>
						<xsl:call-template name="minimumQuantity_MaturityPrice"/>
						<xsl:call-template name="priceCalculationRule_MaturityPrice"/>
						<xsl:call-template name="provider_MaturityPrice"/>
						<xsl:call-template name="referenceCurrency_MaturityPrice"/>
						<xsl:call-template name="riskCountry_MaturityPrice"/>
						<xsl:call-template name="riskNature_MaturityPrice"/>
						<xsl:call-template name="roundLotQuantity_MaturityPrice"/>
						<xsl:call-template name="sector_MaturityPrice"/>
						<xsl:call-template name="stockExchange_MaturityPrice"/>
						<xsl:call-template name="subType_MaturityPrice"/>
						<xsl:call-template name="taxCountry_MaturityPrice"/>
						<xsl:call-template name="tickSize_MaturityPrice"/>
						<xsl:call-template name="tradable_MaturityPrice"/>
						<xsl:call-template name="type_MaturityPrice"/>
						<xsl:call-template name="valuationRule_MaturityPrice"/>
						<xsl:call-template name="beginDate_MaturityPrice"/>
						<xsl:call-template name="capitalGainTax_MaturityPrice"/>
						<xsl:call-template name="complexity_MaturityPrice"/>
						<xsl:call-template name="complexityLevel_MaturityPrice"/>
						<xsl:call-template name="cutOffTime_MaturityPrice"/>
						<xsl:call-template name="cutOffTimeZone_MaturityPrice"/>
						<xsl:call-template name="dividendFrequencyNumber_MaturityPrice"/>
						<xsl:call-template name="dividendFrequencyUnit_MaturityPrice"/>
						<xsl:call-template name="eligibleWrapFund_MaturityPrice"/>
						<xsl:call-template name="faceValue_MaturityPrice"/>
						<xsl:call-template name="islamicCompliance_MaturityPrice"/>
						<xsl:call-template name="issueQuantity_MaturityPrice"/>
						<xsl:call-template name="issueQuote_MaturityPrice"/>
						<xsl:call-template name="issuer_MaturityPrice"/>
						<xsl:call-template name="marketDirectiveCategory_MaturityPrice"/>
						<xsl:call-template name="minimumTradingAmount_MaturityPrice"/>
						<xsl:call-template name="referenceIndex_MaturityPrice"/>
						<xsl:call-template name="riskCurrency_MaturityPrice"/>
						<xsl:call-template name="riskLevel_MaturityPrice"/>
						<xsl:call-template name="roundLotAmount_MaturityPrice"/>
						<xsl:call-template name="stpOrder_MaturityPrice"/>
						<xsl:call-template name="subNature_MaturityPrice"/>
						<xsl:call-template name="tradeNature_MaturityPrice"/>
						<xsl:call-template name="votingRights_MaturityPrice"/>
						<xsl:call-template name="witholdingTax_MaturityPrice"/>
						<xsl:call-template name="dividend_MaturityPrice"/>
						<xsl:call-template name="composition_MaturityPrice"/>
						<xsl:call-template name="commonReference_MaturityPrice"/>
						<xsl:call-template name="coolCancelF_MaturityPrice"/>
						<xsl:call-template name="coolPeriod_MaturityPrice"/>
						<xsl:call-template name="coolPeriodUnit_MaturityPrice"/>
						<xsl:call-template name="fundIncomeStyleE_MaturityPrice"/>
						<xsl:call-template name="parentInstrument_MaturityPrice"/>
						<redemption>
							<xsl:call-template name="announcementDate_MaturityPriceRedem"/>
							<xsl:call-template name="code_MaturityPriceRedem"/>
							<xsl:call-template name="currency_MaturityPriceRedem"/>
							<xsl:call-template name="endDate_MaturityPriceRedem"/>
							<xsl:call-template name="effectiveMaturityDate_MaturityPriceRedem"/>
							<xsl:call-template name="exchnageRate_MaturityPriceRedem"/>
							<xsl:call-template name="exDate_MaturityPriceRedem"/>
							<xsl:call-template name="nature_MaturityPriceRedem"/>
							<xsl:call-template name="noticeDays_MaturityPriceRedem"/>
							<xsl:call-template name="proportionAppliedOn_MaturityPriceRedem"/>
							<xsl:call-template name="redemptionFrequenceyNumber_MaturityPriceRedem"/>
							<xsl:call-template name="redemptionFrequenceyUnit_MaturityPriceRedem"/>
							<xsl:call-template name="redemptionQuote_MaturityPriceRedem"/>
							<xsl:call-template name="redemptionPercentage_MaturityPriceRedem"/>
							<xsl:call-template name="validityDate_MaturityPriceRedem"/>
							<xsl:call-template name="mbFields_MaturityPriceRedem"/>
						</redemption>
						<xsl:call-template name="reinvestmentAllowedF_MaturityPrice"/>
						<xsl:call-template name="switchOrderAmt_MaturityPrice"/>
						<xsl:call-template name="switchOrderPerc_MaturityPrice"/>
						<xsl:call-template name="switchOrderUnit_MaturityPrice"/>
					</FundShare>
				</xsl:for-each>

				<!-- Mapping Condition 5 -->
				
					<!-- condition 5.1 Commitment -->
					
						<FundShare>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_commitment"/>
							<xsl:call-template name="infra:synonym_commitment"/>
							<xsl:call-template name="infra:shortName_commitment"/>
							<xsl:call-template name="infra:longName_commitment"/>
							<xsl:call-template name="infra:multilingualLongName_commitment"/>
							<xsl:call-template name="infra:notepad_commitment"/>
							<xsl:call-template name="infra:userDefinedField_commitment"/>
							<xsl:call-template name="infra:mbFields_commitment"/>
							<xsl:call-template name="active_commitment"/>
							<xsl:call-template name="euroConversionDate_commitment"/>
							<xsl:call-template name="euroConversionRule_commitment"/>
							<xsl:call-template name="euroNewInstrument_commitment"/>
							<xsl:call-template name="mainBusinessEntity_commitment"/>
							<xsl:call-template name="mainStockExchange_commitment"/>
							<xsl:call-template name="minimumQuantity_commitment"/>
							<xsl:call-template name="priceCalculationRule_commitment"/>
							<xsl:call-template name="provider_commitment"/>
							<xsl:call-template name="referenceCurrency_commitment"/>
							<xsl:call-template name="riskCountry_commitment"/>
							<xsl:call-template name="riskNature_commitment"/>
							<xsl:call-template name="roundLotQuantity_commitment"/>
							<xsl:call-template name="sector_commitment"/>
							<xsl:call-template name="stockExchange_commitment"/>
							<xsl:call-template name="subType_commitment"/>
							<xsl:call-template name="taxCountry_commitment"/>
							<xsl:call-template name="tickSize_commitment"/>
							<xsl:call-template name="tradable_commitment"/>
							<xsl:call-template name="type_commitment"/>
							<xsl:call-template name="valuationRule_commitment"/>
							<xsl:call-template name="beginDate_commitment"/>
							<xsl:call-template name="capitalGainTax_commitment"/>
							<xsl:call-template name="complexity_commitment"/>
							<xsl:call-template name="complexityLevel_commitment"/>
							<xsl:call-template name="cutOffTime_commitment"/>
							<xsl:call-template name="cutOffTimeZone_commitment"/>
							<xsl:call-template name="dividendFrequencyNumber_commitment"/>
							<xsl:call-template name="dividendFrequencyUnit_commitment"/>
							<xsl:call-template name="eligibleWrapFund_commitment"/>
							<xsl:call-template name="faceValue_commitment"/>
							<xsl:call-template name="islamicCompliance_commitment"/>
							<xsl:call-template name="issueQuantity_commitment"/>
							<xsl:call-template name="issueQuote_commitment"/>
							<xsl:call-template name="issuer_commitment"/>
							<xsl:call-template name="marketDirectiveCategory_commitment"/>
							<xsl:call-template name="minimumTradingAmount_commitment"/>
							<xsl:call-template name="referenceIndex_commitment"/>
							<xsl:call-template name="riskCurrency_commitment"/>
							<xsl:call-template name="riskLevel_commitment"/>
							<xsl:call-template name="roundLotAmount_commitment"/>
							<xsl:call-template name="stpOrder_commitment"/>
							<xsl:call-template name="subNature_commitment"/>
							<xsl:call-template name="tradeNature_commitment"/>
							<xsl:call-template name="votingRights_commitment"/>
							<xsl:call-template name="witholdingTax_commitment"/>
							<xsl:call-template name="dividend_commitment"/>
							<xsl:call-template name="composition_commitment"/>
							<xsl:call-template name="commonReference_commitment"/>
							<xsl:call-template name="coolCancelF_commitment"/>
							<xsl:call-template name="coolPeriod_commitment"/>
							<xsl:call-template name="coolPeriodUnit_commitment"/>
							<xsl:call-template name="fundIncomeStyleE_commitment"/>
							<xsl:call-template name="parentInstrument_commitment"/>


							

						<xsl:choose>
									<xsl:when test="((b:commitmentTypeGroup[position()=last()]/b:commitStartDate != ../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate) or (not(../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup/b:commitStartDate) and ../../c:PreviousEvent/b:PEProductEvents/b:dateTimeList/b:dateTime ))">
										
							<redemption>
							
								<xsl:attribute name="mode">
									<xsl:value-of select="'delete'"/>
								</xsl:attribute>
							
							
								<xsl:call-template name="announcementDate_commitmentdeleteRedem"/>
								<xsl:call-template name="code_commitmentdeleteRedem"/>
								<xsl:call-template name="currency_commitmentdeleteRedem"/>
								<xsl:call-template name="endDate_commitmentdeleteRedem"/>
								<xsl:call-template name="effectiveMaturityDate_commitmentdeleteRedem"/>
								<xsl:call-template name="exchnageRate_commitmentdeleteRedem"/>
								<xsl:call-template name="exDate_commitmentdeleteRedem"/>
								<xsl:call-template name="nature_commitmentdeleteRedem"/>
								<xsl:call-template name="noticeDays_commitmentdeleteRedem"/>
								<xsl:call-template name="proportionAppliedOn_commitmentdeleteRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_commitmentdeleteRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_commitmentdeleteRedem"/>
								<xsl:call-template name="redemptionQuote_commitmentdeleteRedem"/>
								<xsl:call-template name="redemptionPercentage_commitmentdeleteRedem"/>
								<xsl:call-template name="validityDate_commitmentdeleteRedem"/>
								<xsl:call-template name="eventType_commitmentdeleteRedem"/>
								<xsl:call-template name="eventStatus_commitmentdeleteRedem"/>
								<xsl:call-template name="commitmentReference_commitmentdeleteRedem"/>
								<xsl:call-template name="eventAmount_commitmentdeleteRedem"/>
								<xsl:call-template name="mbFields_commitmentdeleteRedem"/>
							</redemption>
							</xsl:when>
							</xsl:choose>
							<redemption>
							
							
								<xsl:call-template name="announcementDate_commitmentRedem"/>
								<xsl:call-template name="code_commitmentRedem"/>
								<xsl:call-template name="currency_commitmentRedem"/>
								<xsl:call-template name="endDate_commitmentRedem"/>
								<xsl:call-template name="effectiveMaturityDate_commitmentRedem"/>
								<xsl:call-template name="exchnageRate_commitmentRedem"/>
								<xsl:call-template name="exDate_commitmentRedem"/>
								<xsl:call-template name="nature_commitmentRedem"/>
								<xsl:call-template name="noticeDays_commitmentRedem"/>
								<xsl:call-template name="proportionAppliedOn_commitmentRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_commitmentRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_commitmentRedem"/>
								<xsl:call-template name="redemptionQuote_commitmentRedem"/>
								<xsl:call-template name="redemptionPercentage_commitmentRedem"/>
								<xsl:call-template name="validityDate_commitmentRedem"/>
								<xsl:call-template name="eventType_commitmentRedem"/>
								<xsl:call-template name="eventStatus_commitmentRedem"/>
								<xsl:call-template name="commitmentReference_commitmentRedem"/>
								<xsl:call-template name="eventAmount_commitmentRedem"/>
								<xsl:call-template name="mbFields_commitmentRedem"/>
							</redemption>
							
							
							

							<xsl:call-template name="reinvestmentAllowedF_commitment"/>
							<xsl:call-template name="switchOrderAmt_commitment"/>
							<xsl:call-template name="switchOrderPerc_commitment"/>
							<xsl:call-template name="switchOrderUnit_commitment"/>
						</FundShare>
						
						
	
						<xsl:for-each select="b:saveRecallableRocAmtGroup">
						<xsl:if test="$PEWorkflowhandling = 'YES'">
						<FundShare>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PEProductEvents.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_recallable"/>
							<xsl:call-template name="infra:synonym_recallable"/>
							<xsl:call-template name="infra:shortName_recallable"/>
							<xsl:call-template name="infra:longName_recallable"/>
							<xsl:call-template name="infra:multilingualLongName_recallable"/>
							<xsl:call-template name="infra:notepad_recallable"/>
							<xsl:call-template name="infra:userDefinedField_recallable"/>
							<xsl:call-template name="infra:mbFields_recallable"/>
							<xsl:call-template name="active_recallable"/>
							<xsl:call-template name="euroConversionDate_recallable"/>
							<xsl:call-template name="euroConversionRule_recallable"/>
							<xsl:call-template name="euroNewInstrument_recallable"/>
							<xsl:call-template name="mainBusinessEntity_recallable"/>
							<xsl:call-template name="mainStockExchange_recallable"/>
							<xsl:call-template name="minimumQuantity_recallable"/>
							<xsl:call-template name="priceCalculationRule_recallable"/>
							<xsl:call-template name="provider_recallable"/>
							<xsl:call-template name="referenceCurrency_recallable"/>
							<xsl:call-template name="riskCountry_recallable"/>
							<xsl:call-template name="riskNature_recallable"/>
							<xsl:call-template name="roundLotQuantity_recallable"/>
							<xsl:call-template name="sector_recallable"/>
							<xsl:call-template name="stockExchange_recallable"/>
							<xsl:call-template name="subType_recallable"/>
							<xsl:call-template name="taxCountry_recallable"/>
							<xsl:call-template name="tickSize_recallable"/>
							<xsl:call-template name="tradable_recallable"/>
							<xsl:call-template name="type_recallable"/>
							<xsl:call-template name="valuationRule_recallable"/>
							<xsl:call-template name="beginDate_recallable"/>
							<xsl:call-template name="capitalGainTax_recallable"/>
							<xsl:call-template name="complexity_recallable"/>
							<xsl:call-template name="complexityLevel_recallable"/>
							<xsl:call-template name="cutOffTime_recallable"/>
							<xsl:call-template name="cutOffTimeZone_recallable"/>
							<xsl:call-template name="dividendFrequencyNumber_recallable"/>
							<xsl:call-template name="dividendFrequencyUnit_recallable"/>
							<xsl:call-template name="eligibleWrapFund_recallable"/>
							<xsl:call-template name="faceValue_recallable"/>
							<xsl:call-template name="islamicCompliance_recallable"/>
							<xsl:call-template name="issueQuantity_recallable"/>
							<xsl:call-template name="issueQuote_recallable"/>
							<xsl:call-template name="issuer_recallable"/>
							<xsl:call-template name="marketDirectiveCategory_recallable"/>
							<xsl:call-template name="minimumTradingAmount_recallable"/>
							<xsl:call-template name="referenceIndex_recallable"/>
							<xsl:call-template name="riskCurrency_recallable"/>
							<xsl:call-template name="riskLevel_recallable"/>
							<xsl:call-template name="roundLotAmount_recallable"/>
							<xsl:call-template name="stpOrder_recallable"/>
							<xsl:call-template name="subNature_recallable"/>
							<xsl:call-template name="tradeNature_recallable"/>
							<xsl:call-template name="votingRights_recallable"/>
							<xsl:call-template name="witholdingTax_recallable"/>
							<xsl:call-template name="dividend_recallable"/>
							<xsl:call-template name="composition_recallable"/>
							<xsl:call-template name="commonReference_recallable"/>
							<xsl:call-template name="coolCancelF_recallable"/>
							<xsl:call-template name="coolPeriod_recallable"/>
							<xsl:call-template name="coolPeriodUnit_recallable"/>
							<xsl:call-template name="fundIncomeStyleE_recallable"/>
							<xsl:call-template name="parentInstrument_recallable"/>
							<redemption>
								<xsl:call-template name="announcementDate_recallableRedem"/>
								<xsl:call-template name="code_recallableRedem"/>
								<xsl:call-template name="currency_recallableRedem"/>
								<xsl:call-template name="endDate_recallableRedem"/>
								<xsl:call-template name="effectiveMaturityDate_recallableRedem"/>
								<xsl:call-template name="exchnageRate_recallableRedem"/>
								<xsl:call-template name="exDate_recallableRedem"/>
								<xsl:call-template name="nature_recallableRedem"/>
								<xsl:call-template name="noticeDays_recallableRedem"/>
								<xsl:call-template name="proportionAppliedOn_recallableRedem"/>
								<xsl:call-template name="redemptionFrequenceyNumber_recallableRedem"/>
								<xsl:call-template name="redemptionFrequenceyUnit_recallableRedem"/>
								<xsl:call-template name="redemptionQuote_recallableRedem"/>
								<xsl:call-template name="redemptionPercentage_recallableRedem"/>
								<xsl:call-template name="validityDate_recallableRedem"/>

								<xsl:call-template name="eventType_recallableRedem"/>
								<xsl:call-template name="eventStatus_recallableRedem"/>
								<xsl:call-template name="commitmentReference_recallableRedem"/>
								<xsl:call-template name="eventAmount_recallableRedem"/>
								<xsl:call-template name="mbFields_recallableRedem"/>
							</redemption>
							<xsl:call-template name="reinvestmentAllowedF_recallable"/>
							<xsl:call-template name="switchOrderAmt_recallable"/>
							<xsl:call-template name="switchOrderPerc_recallable"/>
							<xsl:call-template name="switchOrderUnit_recallable"/>
						</FundShare>
						
					</xsl:if>
					</xsl:for-each>
					
					
			</DataGroup>
		</FiPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\..\..\Users\shobiya.lakshmanan\IBM\wtx\workspace\fx swap\XML Schema\FiPMS.xsd" destSchemaRoot="FiPMS" destSchemaPathIsRelative="yes"
		            destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="c:MultiPEProductEvents"></template>
			<template match="b:PEProductEvents">
				<block path="FiPMS/xsl:attribute[1]/xsl:value-of" x="322" y="90"/>
				<block path="FiPMS/DataGroup/xsl:for-each" x="292" y="77"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/or[0]" x="276" y="105"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template" x="202" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[1]" x="162" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[2]" x="122" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[3]" x="82" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[4]" x="42" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[5]" x="362" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[6]" x="202" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[7]" x="162" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[8]" x="122" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[9]" x="82" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[10]" x="42" y="67"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[11]" x="362" y="27"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[12]" x="162" y="27"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[13]" x="122" y="27"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[14]" x="82" y="27"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[15]" x="42" y="27"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[16]" x="322" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[17]" x="362" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[18]" x="282" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[19]" x="242" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[20]" x="202" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[21]" x="162" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[22]" x="122" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[23]" x="82" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[24]" x="42" y="147"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/=[0]" x="276" y="105"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each/xsl:if/xsl:if/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]" x="292" y="77"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/contains[0]" x="276" y="105"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[1]/xsl:if/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]" x="232" y="18"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/or[0]" x="256" y="46"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if" x="302" y="48"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/!=[0]" x="206" y="76"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if" x="252" y="78"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:value-of" x="362" y="108"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when/FundShare/xsl:call-template[66]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[2]/xsl:if/xsl:if/xsl:choose/xsl:when[1]/FundShare/xsl:call-template[66]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]" x="292" y="77"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/or[0]" x="276" y="105"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[3]/xsl:if/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[4]/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]" x="292" y="77"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/=[0]" x="276" y="105"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[66]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[67]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[68]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[69]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare/xsl:call-template[70]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:attribute/xsl:value-of" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:attribute/xsl:value-of/name[1]" x="276" y="129"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:attribute[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[16]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[17]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[18]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[19]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[20]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[21]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[22]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[23]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[24]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[25]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[26]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[27]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[28]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[29]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[30]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[31]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[32]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[33]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[34]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[35]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[36]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[37]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[38]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[39]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[40]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[41]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[42]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[43]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[44]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[45]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[46]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[47]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[48]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[49]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[50]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[51]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[52]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[53]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[54]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[55]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[56]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[57]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[58]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[59]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[60]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[61]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[1]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[2]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[3]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[4]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[5]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[6]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[7]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[8]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[9]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[10]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[11]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[12]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[13]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[14]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/redemption/xsl:call-template[15]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[62]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[63]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[64]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[65]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[66]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[67]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[68]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[69]" x="322" y="107"/>
				<block path="FiPMS/DataGroup/xsl:for-each[5]/xsl:if/FundShare[1]/xsl:call-template[70]" x="322" y="107"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->