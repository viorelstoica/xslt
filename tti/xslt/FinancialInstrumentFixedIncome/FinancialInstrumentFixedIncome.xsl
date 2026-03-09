<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>

	<!-- BEG - For input flow FinancialInstrumentSecurity -->
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
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentFixedIncome',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Bond>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
					<xsl:call-template name="infra:synonym-custo"/>
					<xsl:call-template name="infra:synonym"/>
					<xsl:call-template name="infra:shortName"/>
					<xsl:call-template name="infra:longName"/>
					<xsl:call-template name="infra:multilingualLongName"/>
					<xsl:call-template name="infra:notepad-custo"/>
					<xsl:call-template name="infra:notepad"/>
					<xsl:call-template name="infra:userDefinedField-custo"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="active"/>
					<xsl:call-template name="euroConversionDate"/>
					<xsl:call-template name="euroConversionRule"/>
					<xsl:call-template name="euroNewInstrument"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="mainStockExchange"/>
					<xsl:call-template name="minimumQuantity"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="provider"/>
					<xsl:call-template name="referenceCurrency"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="roundLotQuantity"/>
					<xsl:call-template name="sector-custo"/>
					<xsl:call-template name="sector"/>
					<xsl:call-template name="stockExchange"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tickSize"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="accrualRule"/>
					<xsl:call-template name="accruedInterestRoundingRule"/>
					<xsl:call-template name="accruedInterestRoundingUnit"/>
					<xsl:call-template name="accruedInterestUnitaryRounding"/>
					<xsl:call-template name="accruedInterestCalculation"/>
					<xsl:call-template name="businessDayConvention"/>
					<xsl:call-template name="capitalGainTax"/>
					<xsl:call-template name="complexity"/>
					<xsl:call-template name="complexityLevel"/>
					<xsl:call-template name="couponFrequencyNumber"/>
					<xsl:call-template name="couponFrequencyUnit"/>
					<xsl:call-template name="cutOffTime"/>
					<xsl:call-template name="cutOffTimeZone"/>
					<xsl:call-template name="dataSecuProf"/>
					<xsl:call-template name="effectiveMaturityDate"/>
					<xsl:call-template name="eligibleWrapFund"/>
					<xsl:call-template name="eomConvention"/>
					<xsl:call-template name="faceValue"/>
					<xsl:call-template name="firstCouponDate"/>
					<xsl:call-template name="firstExDate"/>
					<xsl:call-template name="floatingRateInstrument"/>
					<xsl:call-template name="interestAccrualDate"/>
					<xsl:call-template name="interestRate"/>
					<xsl:call-template name="islamicCompliance"/>
					<xsl:call-template name="issuedAmount"/>
					<xsl:call-template name="issueDate"/>
					<xsl:call-template name="issuedPrice"/>
					<xsl:call-template name="issuer"/>
					<xsl:call-template name="lastCouponDate"/>
					<xsl:call-template name="marketDirectiveCategory"/>
					<xsl:call-template name="maturityDate"/>
					<xsl:call-template name="maturityPrice"/>
					<xsl:call-template name="stpOrder"/>
					<xsl:call-template name="subNature"/>
					<xsl:call-template name="witholdingTax"/>
					<xsl:call-template name="coupon"/>
					<xsl:call-template name="interestSchedule"/>
					<xsl:call-template name="floatingCondition"/>
					<xsl:call-template name="rating"/>
					<xsl:call-template name="redemption"/>
					<xsl:call-template name="riskCurrency"/>
					<xsl:call-template name="riskLevel"/>
					<xsl:call-template name="yieldCurve"/>
				</Bond>
				<xsl:if test="b:volatility != ''">
					<ChronologicalData>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="ChronologicalData_currency"/>
						<xsl:call-template name="ChronologicalData_dataNature"/>
						<xsl:call-template name="ChronologicalData_instrument"/>
						<xsl:call-template name="ChronologicalData_validity"/>
						<xsl:call-template name="ChronologicalData_value"/>
						<xsl:call-template name="ChronologicalData_provider"/>
						<xsl:call-template name="ChronologicalData_valueType"/>
						<xsl:call-template name="ChronologicalData_mbFields"/>
					</ChronologicalData>
				</xsl:if>
				<!-- Template mapping is defined in MB EUR xslt -->
				<xsl:call-template name="mappingRatingAttribution"/>
				<xsl:if test="b:defaultDepository and b:defaultDepository != ''">
					<InstrumentDeposit>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="deposit"/>
						<xsl:call-template name="instrument"/>
						<xsl:call-template name="main"/>
						<xsl:call-template name="paymentOptionE_InstrumentDeposit"/>
						<xsl:call-template name="rank"/>
						<xsl:call-template name="mbFields_InstrumentDeposit"/>
					</InstrumentDeposit>
				</xsl:if>
				<xsl:call-template name="OldNewDepositManagment">
					<xsl:with-param name="CurrentEvent" select="."/>
					<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
				</xsl:call-template>
				<!--  IPO dummy price only if there is an IPO start date and prices are available -->
				<xsl:if test="b:ipoStartDate and (b:issueOfferPrice or (b:minOfferPrice and b:maxOfferPrice))">
					<xsl:variable name="check_ipoListingDate">
						<xsl:call-template name="formatDateForMaturityComparison">
							<xsl:with-param name="dateToFormat" select="b:ipoListingDate"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="check_toDay">
						<xsl:call-template name="formatDateForMaturityComparison">
							<xsl:with-param name="dateToFormat" select="b:eventCommon/d:today"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="number($check_ipoListingDate) &gt; number($check_toDay)">
						<Price>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="ipo_currency"/>
							<xsl:call-template name="ipo_instrument"/>
							<xsl:call-template name="ipo_provider"/>
							<xsl:call-template name="ipo_quotationDate"/>
							<xsl:call-template name="ipo_stockExchange"/>
							<xsl:call-template name="ipo_value"/>
							<xsl:call-template name="ipo_valueType"/>
							<xsl:call-template name="ipo_valueTermType"/>
							<xsl:call-template name="ipo_priceCalculationRule"/>
							<xsl:call-template name="ipo_mbFields"/>
						</Price>
					</xsl:if>
				</xsl:if>
				<!--  START BusinessEntity Compo -->
				<xsl:if test="b:allowedCountryList/b:allowedCountry">
					<xsl:for-each select="b:allowedCountryList/b:allowedCountry">
						<xsl:variable name="beAllowedCountry">
							<xsl:call-template name="instrBusinessEntity">
								<xsl:with-param name="beAllowedCountry" select="."/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="not($beAllowedCountry = '')">
							<xsl:if test="not(. = ../../../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry)">
								<BusinessEntityComposition>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="infra:businessEntity"/>
									<xsl:call-template name="infra:mainBusinessEntity"/>
									<xsl:call-template name="infra:role"/>
									<xsl:call-template name="infra:type"/>
									<xsl:call-template name="infra:mbFields_becompo_inser"/>
									<xsl:call-template name="be_instrument"/>
								</BusinessEntityComposition>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry">
					<xsl:for-each select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry">
						<xsl:variable name="beAllowedCountry">
							<xsl:call-template name="instrBusinessEntity">
								<xsl:with-param name="beAllowedCountry" select="."/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:if test="not($beAllowedCountry = '')">
							<xsl:if test="not(. = ../../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry)">
								<BusinessEntityComposition>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="mode">delete</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="infra:businessEntity"/>
									<xsl:call-template name="infra:mainBusinessEntity"/>
									<xsl:call-template name="infra:role"/>
									<xsl:call-template name="infra:type"/>
									<xsl:call-template name="infra:mbFields_becompo_del"/>
									<xsl:call-template name="be_instrument"/>
								</BusinessEntityComposition>
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<!--  END BusinessEntity Compo -->
			</DataGroup>
			<!--  Coupon Schedule - Income Event -->
			<xsl:variable name="irregularCouponToBePaid">
                  <xsl:call-template name="irregularCoupon"/>
            </xsl:variable>
			<xsl:if test="($g_filterBySubAssetType ='Y' and contains($list_SubAssetType_IrregularCoupon,b:subAssetType)) or ($g_filterBySubAssetType ='N' and $irregularCouponToBePaid = 'Y')">
				<DataGroup>
					<Event>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<coupon>
							<xsl:call-template name="ie_beginDate"/>
							<xsl:call-template name="ie_coupon"/>
							<xsl:call-template name="ie_code"/>
							<xsl:call-template name="ie_currency"/>
							<xsl:call-template name="ie_endValidityDate"/>
							<xsl:call-template name="ie_exchangeRate"/>
							<xsl:call-template name="ie_exDate"/>
							<xsl:call-template name="ie_firstCouponDate"/>
							<xsl:call-template name="ie_validityDate"/>
							<xsl:call-template name="ie_mbFields"/>
							<xsl:call-template name="ie_instrument"/>
						</coupon>
					</Event>
				</DataGroup>
			</xsl:if>
		</FiPMS>
	</xsl:template>
	<!-- END - For input flow FinancialInstrumentSecurity -->





	<!-- BEG - For input flow FinancialInstrumentME -->
	<xsl:template match="f:MultiFinancialInstrumentME">
		<xsl:apply-templates select="f:CurrentEvent/d:FinancialInstrumentME"/>
	</xsl:template>
	<xsl:template match="e:BatchFinancialInstrumentME">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME" name="BatchFinancialInstrumentME">
			<xsl:apply-templates select="d:FinancialInstrumentME"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="g:BatchMultiFinancialInstrumentME">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME" name="BatchMultiFinancialInstrumentME">
			<xsl:apply-templates select="f:MultiFinancialInstrumentME"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="d:FinancialInstrumentME">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentFixedIncome',d:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Bond>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', d:eventCommon/ns0:eventId, '+', d:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="d:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code_MultiEntity"/>
					<xsl:call-template name="infra:synonym-custo_MultiEntity"/>
					<xsl:call-template name="infra:synonym_MultiEntity"/>
					<xsl:call-template name="infra:shortName_MultiEntity"/>
					<xsl:call-template name="infra:longName_MultiEntity"/>
					<xsl:call-template name="infra:multilingualLongName_MultiEntity"/>
					<xsl:call-template name="infra:notepad-custo_MultiEntity"/>
					<xsl:call-template name="infra:notepad_MultiEntity"/>
					<xsl:call-template name="infra:userDefinedField-custo_MultiEntity"/>
					<xsl:call-template name="infra:userDefinedField_MultiEntity"/>
					<xsl:call-template name="infra:mbFields_MultiEntity"/>
					<xsl:call-template name="active_MultiEntity"/>
					<xsl:call-template name="euroConversionDate_MultiEntity"/>
					<xsl:call-template name="euroConversionRule_MultiEntity"/>
					<xsl:call-template name="euroNewInstrument_MultiEntity"/>
					<xsl:call-template name="mainBusinessEntity_MultiEntity"/>
					<xsl:call-template name="mainStockExchange_MultiEntity"/>
					<xsl:call-template name="minimumQuantity_MultiEntity"/>
					<xsl:call-template name="priceCalculationRule_MultiEntity"/>
					<xsl:call-template name="provider_MultiEntity"/>
					<xsl:call-template name="referenceCurrency_MultiEntity"/>
					<xsl:call-template name="riskCountry_MultiEntity"/>
					<xsl:call-template name="riskNature_MultiEntity"/>
					<xsl:call-template name="roundLotQuantity_MultiEntity"/>
					<xsl:call-template name="sector-custo_MultiEntity"/>
					<xsl:call-template name="sector_MultiEntity"/>
					<xsl:call-template name="stockExchange_MultiEntity"/>
					<xsl:call-template name="subType_MultiEntity"/>
					<xsl:call-template name="taxCountry_MultiEntity"/>
					<xsl:call-template name="tickSize_MultiEntity"/>
					<xsl:call-template name="tradable_MultiEntity"/>
					<xsl:call-template name="type_MultiEntity"/>
					<xsl:call-template name="valuationRule_MultiEntity"/>
					<xsl:call-template name="accrualRule_MultiEntity"/>
					<xsl:call-template name="accruedInterestRoundingRule_MultiEntity"/>
					<xsl:call-template name="accruedInterestRoundingUnit_MultiEntity"/>
					<xsl:call-template name="accruedInterestUnitaryRounding_MultiEntity"/>
					<xsl:call-template name="accruedInterestCalculation_MultiEntity"/>
					<xsl:call-template name="businessDayConvention_MultiEntity"/>
					<xsl:call-template name="capitalGainTax_MultiEntity"/>
					<xsl:call-template name="complexity_MultiEntity"/>
					<xsl:call-template name="complexityLevel_MultiEntity"/>
					<xsl:call-template name="couponFrequencyNumber_MultiEntity"/>
					<xsl:call-template name="couponFrequencyUnit_MultiEntity"/>
					<xsl:call-template name="cutOffTime_MultiEntity"/>
					<xsl:call-template name="cutOffTimeZone_MultiEntity"/>
					<xsl:call-template name="dataSecuProf_MultiEntity"/>
					<xsl:call-template name="effectiveMaturityDate_MultiEntity"/>
					<xsl:call-template name="eligibleWrapFund_MultiEntity"/>
					<xsl:call-template name="eomConvention_MultiEntity"/>
					<xsl:call-template name="faceValue_MultiEntity"/>
					<xsl:call-template name="firstCouponDate_MultiEntity"/>
					<xsl:call-template name="firstExDate_MultiEntity"/>
					<xsl:call-template name="floatingRateInstrument_MultiEntity"/>
					<xsl:call-template name="interestAccrualDate_MultiEntity"/>
					<xsl:call-template name="interestRate_MultiEntity"/>
					<xsl:call-template name="islamicCompliance_MultiEntity"/>
					<xsl:call-template name="issuedAmount_MultiEntity"/>
					<xsl:call-template name="issueDate_MultiEntity"/>
					<xsl:call-template name="issuedPrice_MultiEntity"/>
					<xsl:call-template name="issuer_MultiEntity"/>
					<xsl:call-template name="lastCouponDate_MultiEntity"/>
					<xsl:call-template name="marketDirectiveCategory_MultiEntity"/>
					<xsl:call-template name="maturityDate_MultiEntity"/>
					<xsl:call-template name="maturityPrice_MultiEntity"/>
					<xsl:call-template name="stpOrder_MultiEntity"/>
					<xsl:call-template name="subNature_MultiEntity"/>
					<xsl:call-template name="witholdingTax_MultiEntity"/>
					<xsl:call-template name="coupon_MultiEntity"/>
					<xsl:call-template name="interestSchedule_MultiEntity"/>
					<xsl:call-template name="floatingCondition_MultiEntity"/>
					<xsl:call-template name="rating_MultiEntity"/>
					<xsl:call-template name="redemption_MultiEntity"/>
					<xsl:call-template name="riskCurrency_MultiEntity"/>
					<xsl:call-template name="riskLevel_MultiEntity"/>
					<xsl:call-template name="yieldCurve_MultiEntity"/>
				</Bond>
				<xsl:if test="d:defaultDepository and d:defaultDepository != ''">
					<InstrumentDeposit>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentFixedIncome.xsl+', name(/*), '+', d:eventCommon/ns0:eventId, '+', d:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="d:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="deposit_IE_MultiEntity"/>
						<xsl:call-template name="instrument_IE_MultiEntity"/>
						<xsl:call-template name="main_IE_MultiEntity"/>
						<xsl:call-template name="paymentOptionE_IE_MultiEntity"/>
						<xsl:call-template name="rank_IE_MultiEntity"/>
						<xsl:call-template name="mbFields_IE_MultiEntity"/>
					</InstrumentDeposit>
				</xsl:if>
			</DataGroup>
		</FiPMS>
	</xsl:template>
	<!-- END - For input flow FinancialInstrumentME -->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\FinancialInstrumentFixedIncome\FinancialInstrumentFixedIncome.xml" srcSchemaRoot="MultiFinancialInstrumentFixedIncome" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->