<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">

	<!-- BEG - For input flow FinancialInstrumentSecurity -->
	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:synonym-custo"/>
	<xsl:template name="infra:synonym">
		<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
		</xsl:call-template>
		<xsl:for-each select="b:altSecurityIdGroup">
			<xsl:if test="b:altSecurityNo">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:altSecurityNo"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:altSecurityId"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="OldNewAltSecSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName">
		<xsl:if test="b:descriptList/b:descript[@language='GB']   != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:descriptList/b:descript[@language='FR']   != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='FR']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:descriptList/b:descript[@language='DE']   != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:descriptList/b:descript[@language='DE']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:call-template name="OldNewDenomConcatManagment">
			<xsl:with-param name="CurrentEvent" select="./b:descriptList/b:descript"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="floatingRateInstrument">
		<xsl:if test="b:buildCpnDate != '' and b:interestKey != '' and b:noOfPayments != '' and b:buildCpnDate and b:interestKey and b:noOfPayments">
			<floatingRateInstrument>
				<infra:code>
					<xsl:variable name="floatInstr">
						<xsl:choose>
							<xsl:when test="b:noOfPayments = '0.2'">60M</xsl:when>
							<xsl:when test="b:noOfPayments = '1'">12M</xsl:when>
							<xsl:when test="b:noOfPayments = '2'">06M</xsl:when>
							<xsl:when test="b:noOfPayments = '3'">04M</xsl:when>
							<xsl:when test="b:noOfPayments = '4'">03M</xsl:when>
							<xsl:when test="b:noOfPayments = '6'">02M</xsl:when>
							<xsl:when test="b:noOfPayments = '12'">30D</xsl:when>
							<xsl:when test="b:noOfPayments = '13'">30D</xsl:when>
							<xsl:when test="b:noOfPayments = '26'">15D</xsl:when>
							<xsl:when test="b:noOfPayments = '52'">15D</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="concat(substring(b:interestKey,'1','5'),$floatInstr)"/>
				</infra:code>
			</floatingRateInstrument>
		</xsl:if>
	</xsl:template>
	<xsl:template name="businessDayConvention">
		<businessDayConvention>
	   	<xsl:choose>
			<xsl:when test="b:dayConvention = 'FOLLOWING'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test="b:dayConvention = 'MODIFIED'">
				<xsl:value-of select="'2'"/>
			</xsl:when>
			<xsl:when test="b:dayConvention = 'PRECEDING'">
				<xsl:value-of select="'5'"/>
			</xsl:when>
			<xsl:otherwise>
	      		<xsl:if test="b:dayConvention = '' or not(b:dayConvention)">	
	            	<xsl:value-of select="'0'"/>
	      		</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</businessDayConvention>
	</xsl:template>
	<xsl:template name="riskCurrency">
		<riskCurrency>
			<infra:code>
				<xsl:value-of select="b:riskCcy"/>
			</infra:code>
		</riskCurrency>
	</xsl:template>
	<xsl:template name="stpOrder">
		<stpOrder>
			<xsl:choose>
				<xsl:when test="b:stp='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</stpOrder>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:choose>
				<xsl:when test="b:blockingDate != ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity">
		<xsl:if test="b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:cpnDateGroup[b:factor != '']/b:factor != ''">4</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">2</xsl:when>
						<xsl:when test="b:priceType = '0'">1</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">2</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">8</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">1</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">21</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider">
		<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry">
		<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="roundLotQuantity">
		<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry">
		<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="accrualRule">
		<xsl:variable name="list_InterestDayBasis0" select="'G S W W1'"/>
		<xsl:variable name="list_InterestDayBasis19" select="'C C1 U O'"/>
		<xsl:variable name="list_InterestDayBasis24" select="'A A1 A2 A3'"/>
		<xsl:variable name="list_InterestDayBasis26" select="'F F1 F2'"/>
		<xsl:variable name="list_InterestDayBasisTotal" select="'A A1 A2 A3 B C C1 C2 D E E1 F F1 F2 G S W W1 U O'"/>
		<xsl:if test="contains(concat(' ',$list_InterestDayBasisTotal,' '),concat(' ',substring-before(b:interestDayBasis,' '),' '))">
			<accrualRule>
				<xsl:choose>
					<xsl:when test="contains(concat(' ',$list_InterestDayBasis24,' '),concat(' ',substring-before(b:interestDayBasis,' '),' '))">
						<xsl:value-of select="'24'"/>
					</xsl:when>
					<xsl:when test="substring-before(b:interestDayBasis,' ') = 'B'">
						<xsl:value-of select="'31'"/>
					</xsl:when>
					<xsl:when test="contains(concat(' ',$list_InterestDayBasis19,' '),concat(' ',substring-before(b:interestDayBasis,' '),' '))">
						<xsl:value-of select="'19'"/>
					</xsl:when>
					<xsl:when test="substring-before(b:interestDayBasis,' ') = 'C2'">
						<xsl:value-of select="'20'"/>
					</xsl:when>
					<xsl:when test="substring-before(b:interestDayBasis,' ') = 'D'">
						<xsl:value-of select="'13'"/>
					</xsl:when>
					<xsl:when test="substring-before(b:interestDayBasis,' ') = 'E'">
						<xsl:value-of select="'29'"/>
					</xsl:when>
					<xsl:when test="substring-before(b:interestDayBasis,' ') = 'E1'">
						<xsl:value-of select="'30'"/>
					</xsl:when>
					<xsl:when test="contains(concat(' ',$list_InterestDayBasis26,' '),concat(' ',substring-before(b:interestDayBasis,' '),' '))">
						<xsl:value-of select="'26'"/>
					</xsl:when>
					<xsl:when test="contains(concat(' ',$list_InterestDayBasis0,' '),concat(' ',substring-before(b:interestDayBasis,' '),' '))">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</accrualRule>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accruedInterestRoundingRule">
		<xsl:if test="substring(b:interestDayBasis,1,1) = 'O'">
			<accruedInterestRoundingRule>
				<xsl:value-of select="'1'"/>
			</accruedInterestRoundingRule>
			<accruedInterestRoundingUnit>
				<xsl:value-of select="'11'"/>
			</accruedInterestRoundingUnit>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accruedInterestCalculation">
		<accruedInterestCalculation>
			<xsl:choose>
				<xsl:when test="b:interestRateGroup/b:interestRate = '0' or b:interestRateGroup/b:interestRate = '00'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</accruedInterestCalculation>
	</xsl:template>
    <xsl:template name="couponFrequencyNumber">
        <couponFrequencyNumber>
            <xsl:variable name="irregularCouponToBePaid">
                  <xsl:call-template name="irregularCoupon"/>
            </xsl:variable>
            <xsl:if test="($g_filterBySubAssetType ='Y' and not(contains($list_SubAssetType_IrregularCoupon,b:subAssetType))) or ($g_filterBySubAssetType ='N' and $irregularCouponToBePaid = 'N')">
                <xsl:choose>
                    <xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
                    <xsl:when test="b:noOfPayments = '1'">1</xsl:when>
                    <xsl:when test="b:noOfPayments = '2'">1</xsl:when>
                    <xsl:when test="b:noOfPayments = '3'">4</xsl:when>
                    <xsl:when test="b:noOfPayments = '4'">1</xsl:when>
                    <xsl:when test="b:noOfPayments = '6'">2</xsl:when>
                    <xsl:when test="b:noOfPayments = '12'">1</xsl:when>
                </xsl:choose>
            </xsl:if>
        </couponFrequencyNumber>
    </xsl:template>
    <xsl:template name="couponFrequencyUnit">
        <couponFrequencyUnit>
            <xsl:variable name="irregularCouponToBePaid">
                  <xsl:call-template name="irregularCoupon"/>
            </xsl:variable>     
            <xsl:choose>
                <xsl:when test="($g_filterBySubAssetType ='Y' and not(contains($list_SubAssetType_IrregularCoupon,b:subAssetType))) or ($g_filterBySubAssetType ='N' and $irregularCouponToBePaid = 'N')">
                    <xsl:choose>
                        <xsl:when test="b:noOfPayments = '0.2'">7</xsl:when>
                        <xsl:when test="b:noOfPayments = '1'">7</xsl:when>
                        <xsl:when test="b:noOfPayments = '2'">6</xsl:when>
                        <xsl:when test="b:noOfPayments = '3'">4</xsl:when>
                        <xsl:when test="b:noOfPayments = '4'">5</xsl:when>
                        <xsl:when test="b:noOfPayments = '6'">4</xsl:when>
                        <xsl:when test="b:noOfPayments = '12'">4</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="'0'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'0'"/>
                </xsl:otherwise>
            </xsl:choose>
        </couponFrequencyUnit>
    </xsl:template>
	<xsl:template name="firstCouponDate">
		<xsl:choose>
			<xsl:when test="b:id and (not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:firstCouponDate) and not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:intPaymentDate)) ">
		<xsl:choose>
			<xsl:when test="b:firstCouponDate and b:firstCouponDate !=''">
				<firstCouponDate>
					<xsl:value-of select="b:firstCouponDate"/>
				</firstCouponDate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:intPaymentDate and b:intPaymentDate != ''">
					<firstCouponDate>
						<xsl:value-of select="b:intPaymentDate"/>
					</firstCouponDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="firstExDate">
		<xsl:if test="(b:id and not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:coupDivCutDate)) and b:coupDivCutDate and b:coupDivCutDate != ''">
			<firstExDate>
				<xsl:value-of select="b:coupDivCutDate"/>
			</firstExDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="interestAccrualDate">
		<xsl:choose>
			<xsl:when test="b:id and (not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:accrualStartDate) and not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:firstAccrualStartDate)) ">
			<xsl:choose>
			<xsl:when test="b:firstAccrualStartDate and b:firstAccrualStartDate !=''">
				<interestAccrualDate>
					<xsl:value-of select="b:firstAccrualStartDate"/>
				</interestAccrualDate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:accrualStartDate and b:accrualStartDate != ''">
					<interestAccrualDate>
						<xsl:value-of select="b:accrualStartDate"/>
					</interestAccrualDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="interestRate">
		<xsl:if test="(b:interestRateGroup/b:rateChDate = '' or not(b:interestRateGroup/b:rateChDate)) and b:interestRateGroup/b:interestRate and b:interestRateGroup/b:interestRate != ''">
			<interestRate>
				<xsl:value-of select="b:interestRateGroup/b:interestRate"/>
			</interestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issuedAmount">
		<xsl:if test="b:totalIssued != '' and b:totalIssued">
			<issuedAmount>
				<xsl:value-of select="b:totalIssued"/>
			</issuedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueDate">
		<xsl:if test="b:issueDate and b:issueDate != ''">
			<issueDate>
				<xsl:value-of select="b:issueDate"/>
			</issueDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issuedPrice">
		<xsl:if test="b:issuePrice != '' and b:issuePrice">
			<issuedPrice>
				<xsl:value-of select="b:issuePrice"/>
			</issuedPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issuer">
		<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX != '' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX != '' and starts-with(b:ovIssuer,'I-')">
						<xsl:value-of select="concat($ISSUER_PREFIX ,substring-after(b:ovIssuer,'I-'))"/>
					</xsl:when>
					<xsl:when test="starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="substring-after(b:ovIssuer,'C-')"/>
					</xsl:when>
					<xsl:when test="starts-with(b:ovIssuer,'I-')">
						<xsl:value-of select="substring-after(b:ovIssuer,'I-')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:ovIssuer"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="lastCouponDate">
		<xsl:if test="b:lastCouponDate and b:lastCouponDate != ''">
			<lastCouponDate>
				<xsl:value-of select="b:lastCouponDate"/>
			</lastCouponDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="maturityDate">
		<xsl:if test="b:maturityDate and b:maturityDate != ''">
			<maturityDate>
				<xsl:value-of select="b:maturityDate"/>
			</maturityDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="maturityPrice">
		<xsl:if test="b:redemPrice != '' and b:redemPrice">
			<maturityPrice>
				<xsl:value-of select="b:redemPrice"/>
			</maturityPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="yieldCurve">
		<yieldCurve>
			<infra:code>
				<xsl:value-of select="substring(b:interestKey,1,5)"/>
			</infra:code>
		</yieldCurve>
	</xsl:template>
	<xsl:template name="deposit">
		<deposit>
			<infra:code>
				<xsl:value-of select="b:defaultDepository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="barrier">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='KNOCK.OUT']/b:notePriceBarrier and b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='KNOCK.OUT']/b:notePriceBarrier != ''">
			<barrier>
				<xsl:value-of select="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='KNOCK.OUT']/b:notePriceBarrier"/>
			</barrier>
		</xsl:if>
	</xsl:template>
	<xsl:template name="exerciseQuote">
		<xsl:if test="b:underlyingGroup/b:strikePrice and not(b:worstOf = 'YES' or b:worstOf or b:underlyingGroup/b:weight &lt; '100')">
			<exerciseQuote>
				<xsl:value-of select="b:underlyingGroup/b:strikePrice"/>
			</exerciseQuote>
		</xsl:if>
	</xsl:template>
	<xsl:template name="optionStyle">
		<optionStyle>
			<xsl:choose>
				<xsl:when test="b:priceTracker = 'MATURITY'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="b:priceTracker = 'CONTINUING'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</optionStyle>
	</xsl:template>
	<xsl:template name="interestSchedule_endDate"/>
	<xsl:template name="interestSchedule_interestRate">
		<interestRate>
			<xsl:value-of select="b:interestRate"/>
		</interestRate>
	</xsl:template>
	<xsl:template name="interestSchedule_scheduledDate">
		<xsl:variable name="index" select="./@index"/>
		<scheduledDate>
            <xsl:value-of select="../b:interestRateGroup[@index=$index]/b:rateChDate"/>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="interestSchedule_validityDate">
		<xsl:variable name="index" select="./@index"/>
		<validityDate>
            <xsl:value-of select="../b:interestRateGroup[@index=$index]/b:rateChDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="interestSchedule_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="interestSchedule_mbFields"/>
	<xsl:template name="floatingCondition_benchmark">
		<benchmark>
			<infra:code>
				<xsl:variable name="floatInstr">
					<xsl:choose>
						<xsl:when test="b:noOfPayments = '0.2'">60M</xsl:when>
						<xsl:when test="b:noOfPayments = '1'">12M</xsl:when>
						<xsl:when test="b:noOfPayments = '2'">06M</xsl:when>
						<xsl:when test="b:noOfPayments = '3'">04M</xsl:when>
						<xsl:when test="b:noOfPayments = '4'">03M</xsl:when>
						<xsl:when test="b:noOfPayments = '6'">02M</xsl:when>
						<xsl:when test="b:noOfPayments = '12'">30D</xsl:when>
						<xsl:when test="b:noOfPayments = '13'">30D</xsl:when>
						<xsl:when test="b:noOfPayments = '26'">15D</xsl:when>
						<xsl:when test="b:noOfPayments = '52'">15D</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat(substring(b:interestKey,'1','5'),$floatInstr)"/>
			</infra:code>
		</benchmark>
	</xsl:template>
	<xsl:template name="floatingCondition_endDate"/>
	<xsl:template name="floatingCondition_firstBenchmarkDate"/>
	<xsl:template name="floatingCondition_firstResetDate"/>
	<xsl:template name="floatingCondition_interestRate"/>
	<xsl:template name="floatingCondition_maximumRate"/>
	<xsl:template name="floatingCondition_minimumRate"/>
	<xsl:template name="floatingCondition_resetFrequencyNumber"/>
	<xsl:template name="floatingCondition_resetFrequencyUnit"/>
	<xsl:template name="floatingCondition_spreadRate">
		<xsl:if test="b:cpnRateSpread != '' and b:cpnRateSpread">
			<spreadRate>
				<xsl:value-of select="b:cpnRateSpread"/>
			</spreadRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="floatingCondition_scheduledDate">
		<scheduledDate>
			<xsl:value-of select="b:issueDate"/>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="floatingCondition_validityDate">
		<validityDate>
			<xsl:value-of select="b:issueDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="floatingCondition_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="underlying">
		<xsl:if test="b:underlyingGroup/b:weight = '100'and b:underlyingGroup/b:underlying">
			<underlying>
				<infra:code>
					<xsl:value-of select="b:underlyingGroup/b:underlying"/>
				</infra:code>
			</underlying>
		</xsl:if>
	</xsl:template>
	<xsl:template name="participationLevel">
		<xsl:if test="b:participationLevel and b:participationLevel != ''">
			<participationLevel>
				<xsl:value-of select="b:participationLevel"/>
			</participationLevel>
		</xsl:if>
	</xsl:template>
	<xsl:template name="complexity">
		<xsl:choose>
			<xsl:when test="b:complexity = 'Know'">
				<complexity>
					<xsl:value-of select="'1'"/>
				</complexity>
			</xsl:when>
			<xsl:when test="b:complexity = 'NotKnow'">
				<complexity>
					<xsl:value-of select="'0'"/>
				</complexity>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="riskLevel">
		<xsl:choose>
			<xsl:when test="b:compLevelAttribGroup/b:compLevelAttrib = b:coCode">
				<riskLevel>
					<xsl:value-of select="b:compLevelAttribGroup[b:compLevelAttrib = ../b:coCode]/b:riskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:compLevelAttribGroup[b:compLevelAttrib = '' or not(b:compLevelAttrib)]/b:riskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:compLevelAttribGroup[b:compLevelAttrib = '' or not(b:compLevelAttrib)]/b:riskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="complexityLevel">
		<xsl:choose>
			<xsl:when test="b:complexity = 'HIGH'">
				<complexityLevel>
					<xsl:value-of select="'3'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:complexity = 'MEDIUM'">
				<complexityLevel>
					<xsl:value-of select="'2'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:complexity = 'SIMPLE'">
				<complexityLevel>
					<xsl:value-of select="'1'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:complexity = 'Undefined'">
				<complexityLevel>
					<xsl:value-of select="'0'"/>
				</complexityLevel>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="initialFixingPrice">
		<xsl:if test="b:underlyingGroup/b:spotPrice and b:underlyingGroup/b:weight = '100' and (b:worstOf = 'NO' or not(b:worstOf))">
			<initialFixingPrice>
				<xsl:value-of select="b:underlyingGroup/b:spotPrice"/>
			</initialFixingPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="islamicCompliance">
		<xsl:if test="b:islamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:islamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:islamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:islamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="knockInDate">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup/b:priceBarrierType='KNOCK.IN'">
			<knockInDate>
				<xsl:value-of select="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='KNOCK.IN']/b:prTriggerDate"/>
			</knockInDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="knockOutDate">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup/b:priceBarrierType='KNOCK.OUT'">
			<knockOutDate>
				<xsl:value-of select="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='KNOCK.OUT']/b:prTriggerDate"/>
			</knockOutDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlyingCategory">
		<underlyingCategory>
			<xsl:choose>
				<xsl:when test="b:worstOf='YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:underlyingGroup/b:weight='100'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'2'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</underlyingCategory>
	</xsl:template>
	<xsl:template name="benchmark">
		<xsl:variable name="payments">
			<xsl:choose>
				<xsl:when test="b:noOfPayments='0.2'">
					<xsl:value-of select="'60M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='1'">
					<xsl:value-of select="'12M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='2'">
					<xsl:value-of select="'06M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='3'">
					<xsl:value-of select="'04M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='4'">
					<xsl:value-of select="'03M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='6'">
					<xsl:value-of select="'02M'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='12'">
					<xsl:value-of select="'30D'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='13'">
					<xsl:value-of select="'30D'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='26'">
					<xsl:value-of select="'15D'"/>
				</xsl:when>
				<xsl:when test="b:noOfPayments='52'">
					<xsl:value-of select="'15D'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="b:interestKey">
			<benchmark>
				<infra:code>
					<xsl:value-of select="concat(substring(b:interestKey,1,5),$payments)"/>
				</infra:code>
			</benchmark>
		</xsl:if>
	</xsl:template>
	<xsl:template name="interestCalculationRule">
		<xsl:choose>
			<xsl:when test="b:digital='YES'">
				<interestCalculationRule>
					<xsl:value-of select="'2'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="b:memory='YES'">
				<interestCalculationRule>
					<xsl:value-of select="'3'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(b:digital='NO' or not(b:digital)) and (b:memory='NO' or not(b:memory)) and (b:cpnRangeEnd = '' or not(b:cpnRangeEnd)) and b:cpnRangeStart and b:cpnRangeStart != '' ">
				<interestCalculationRule>
					<xsl:value-of select="'4'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(b:digital='NO' or not(b:digital))  and (b:memory='NO' or not(b:memory)) and b:cpnRangeStart != '' and b:cpnRangeEnd != '' and b:cpnObserveDt != ''">
				<interestCalculationRule>
					<xsl:value-of select="'5'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(b:digital='NO' or not(b:digital))  and (b:memory='NO' or not(b:memory)) and (b:cpnRangeStart = '' or not(b:cpnRangeStart)) and b:cpnRangeEnd and b:cpnRangeEnd != ''">
				<interestCalculationRule>
					<xsl:value-of select="'6'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="b:cpnRangeStart and b:cpnRangeStart != '' and b:cpnRangeEnd and b:cpnRangeEnd != '' and (b:cpnObserveDt = '' or not(b:cpnObserveDt))">
				<interestCalculationRule>
					<xsl:value-of select="'1'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:otherwise>
				<interestCalculationRule>
					<xsl:value-of select="'0'"/>
				</interestCalculationRule>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="maximumInterestRate">
		<xsl:if test="b:cpnRangeEnd">
			<maximumInterestRate>
				<xsl:value-of select="b:cpnRangeEnd"/>
			</maximumInterestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="minimumInterestRate">
		<xsl:if test="b:cpnRangeStart">
			<minimumInterestRate>
				<xsl:value-of select="b:cpnRangeStart"/>
			</minimumInterestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="firstObservationDate">
		<xsl:if test="b:cpnObserveDt">
			<firstObservationDate>
				<xsl:value-of select="b:cpnObserveDt"/>
			</firstObservationDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="couponStrikeLevel">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='COUPON.STRIKE.LEVEL'] and b:underlyingGroup/b:strikePrice and b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='COUPON.STRIKE.LEVEL']/b:pricePercentage ">
			<couponStrikeLevel>
				<xsl:value-of select="format-number((b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='COUPON.STRIKE.LEVEL']/b:pricePercentage * b:underlyingGroup/b:strikePrice) div 100,$decimalformat,'nan2zero') "/>
			</couponStrikeLevel>
		</xsl:if>
	</xsl:template>
	<xsl:template name="couponStrikeLevelPercent">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup/b:priceBarrierType='COUPON.STRIKE.LEVEL'">
			<couponStrikeLevelPercent>
				<xsl:value-of select="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType='COUPON.STRIKE.LEVEL']/b:pricePercentage"/>
			</couponStrikeLevelPercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dataSecuProf">
		<xsl:if test="b:grpDeptCodeList/b:grpDeptCode != '' and b:grpDeptCodeList/b:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="b:grpDeptCodeList/b:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="exerciseQuotePercent">
		<xsl:if test="not(b:worstOf = 'YES' or b:underlyingGroup/b:weight &lt; '100') and b:underlyingGroup/b:strikePrice and b:underlyingGroup/b:spotPrice ">
			<exerciseQuotePercent>
				<xsl:value-of select="format-number((b:underlyingGroup/b:strikePrice) div (b:underlyingGroup/b:spotPrice) * 100,$decimalformat,'nan2zero') "/>
			</exerciseQuotePercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Composition_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="Composition_compositeInstrument">
		<compositeInstrument>
			<infra:code>
				<xsl:value-of select="../b:underlying"/>
			</infra:code>
		</compositeInstrument>
	</xsl:template>
	<xsl:template name="Composition_validityDate">
		<validityDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="Composition_rank">
		<rank>
			<xsl:value-of select="'1'"/>
		</rank>
	</xsl:template>
	<xsl:template name="Composition_cheapest">
		<cheapest>
			<xsl:value-of select="'0'"/>
		</cheapest>
	</xsl:template>
	<xsl:template name="Composition_basketWeight">
		<basketWeight>
			<xsl:value-of select="."/>
		</basketWeight>
	</xsl:template>
	<xsl:template name="Composition_basketInitialFixingPrice">
		<basketInitialFixingPrice>
			<xsl:value-of select="../b:spotPrice"/>
		</basketInitialFixingPrice>
	</xsl:template>
	<xsl:template name="Composition_basketExcercicePrice">
		<xsl:if test="../b:priceBarrierTypeSubGroup/b:priceBarrierType='STRIKE.PRICE'">
			<basketExcercicePrice>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType='STRIKE.PRICE']/b:notePriceBarrier"/>
			</basketExcercicePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Composition_basketBarrier">
		<xsl:if test="../b:priceBarrierTypeSubGroup/b:priceBarrierType='BARRIER'">
			<basketBarrier>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType='BARRIER']/b:notePriceBarrier"/>
			</basketBarrier>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Composition_basketBarrierPercent">
		<xsl:if test="../b:priceBarrierTypeSubGroup/b:priceBarrierType='BARRIER'">
			<basketBarrierPercent>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType='BARRIER']/b:pricePercentage"/>
			</basketBarrierPercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Composition_basketExcercicePricePercent">
		<xsl:if test="../b:priceBarrierTypeSubGroup/b:priceBarrierType='STRIKE.PRICE'">
			<basketExcercicePricePercent>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType='STRIKE.PRICE']/b:pricePercentage"/>
			</basketExcercicePricePercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Composition_conversionFactor"/>
	<xsl:template name="Composition_conversionRatio"/>
	<xsl:template name="Composition_divisor"/>
	<xsl:template name="Composition_endDate"/>
	<xsl:template name="Composition_value">
		<value>
			<xsl:value-of select="'1'"/>
		</value>
	</xsl:template>
	<xsl:template name="Composition_mbFields"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="tickSize"/>
	<xsl:template name="tradable">
		<xsl:choose>
			<xsl:when test="b:secStatus = 'DEF' or b:secStatus = 'DEL'or b:secStatus = 'SUS'or b:secStatus ='NON.TRADABLE'">
				<tradable>
					<xsl:value-of select="'0'"/>
				</tradable>
			</xsl:when>
			<xsl:otherwise>
				<tradable>1</tradable>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="capitalGainTax"/>
	<xsl:template name="effectiveMaturityDate"/>
	<xsl:template name="eomConvention"/>
	<xsl:template name="faceValue"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="marketDirectiveStrategy"/>
	<xsl:template name="main"/>
	<xsl:template name="rank"/>
	<xsl:template name="floatingCondition_mbFields"/>
	<xsl:template name="ChronologicalData_currency"/>
	<xsl:template name="ChronologicalData_dataNature">
		<dataNature>
			<xsl:value-of select="'17'"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="ChronologicalData_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ChronologicalData_validity">
		<xsl:if test="b:eventCommon/ns0:today != ''">
			<validity>
				<xsl:value-of select="b:eventCommon/ns0:today"/>
			</validity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ChronologicalData_value">
		<value>
			<xsl:value-of select="b:volatility"/>
		</value>
	</xsl:template>
	<xsl:template name="ChronologicalData_provider"/>
	<xsl:template name="ChronologicalData_valueType"/>
	<xsl:template name="ChronologicalData_mbFields"/>

	<!-- Income Event Fields -->

	<xsl:template name="ie_beginDate">
		<beginDate>
			<xsl:choose>
				<xsl:when test="not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:issueDate)">
					<xsl:value-of select="b:issueDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:accrualStartDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</beginDate>
	</xsl:template>
	<xsl:template name="ie_endValidityDate">
		<endValidityDate>
			<xsl:value-of select="b:intPaymentDate"/>
		</endValidityDate>
	</xsl:template>
	<xsl:template name="ie_exDate"/>
	<xsl:template name="ie_firstCouponDate">
		<firstCouponDate>
			<xsl:value-of select="b:intPaymentDate"/>
		</firstCouponDate>
	</xsl:template>
	<xsl:template name="ie_validityDate">
		<validityDate>
			<xsl:value-of select="b:issueDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="ie_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ie_coupon"/>
	<xsl:template name="ie_code"/>
	<xsl:template name="ie_currency"/>
	<xsl:template name="ie_exchangeRate"/>
	<xsl:template name="ie_mbFields"/>

	<!-- structuredInterest- Interest Rate Condition Table -->
	<xsl:template name="structuredInterest_beginDate">
		<beginDate>
			<xsl:value-of select="b:issueDate"/>
		</beginDate>
	</xsl:template>
	<xsl:template name="structuredInterest_benchmark">
		<benchmark>
			<infra:code>
				<xsl:variable name="floatInstr">
					<xsl:choose>
						<xsl:when test="b:noOfPayments = '0.2'">60M</xsl:when>
						<xsl:when test="b:noOfPayments = '1'">12M</xsl:when>
						<xsl:when test="b:noOfPayments = '2'">06M</xsl:when>
						<xsl:when test="b:noOfPayments = '3'">04M</xsl:when>
						<xsl:when test="b:noOfPayments = '4'">03M</xsl:when>
						<xsl:when test="b:noOfPayments = '6'">02M</xsl:when>
						<xsl:when test="b:noOfPayments = '12'">30D</xsl:when>
						<xsl:when test="b:noOfPayments = '13'">30D</xsl:when>
						<xsl:when test="b:noOfPayments = '26'">15D</xsl:when>
						<xsl:when test="b:noOfPayments = '52'">15D</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat(substring(b:interestKey,'1','5'),$floatInstr)"/>
			</infra:code>
		</benchmark>
	</xsl:template>
	<xsl:template name="structuredInterest_firstBenchmarkDate">
		<firstBenchmarkDate>
			<xsl:value-of select="b:cpnObserveDt"/>
		</firstBenchmarkDate>
	</xsl:template>
	<xsl:template name="structuredInterest_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="structuredInterest_interestRate">
		<interestRate>
			<xsl:if test="((b:interestRateGroup/b:interestRate and b:interestRateGroup/b:interestRate != '') and    ((b:cpnRangeStart and b:cpnRangeStart != '' and b:cpnRangeEnd and b:cpnRangeEnd != '') and      (not(b:cpnObserveDt) or b:cpnObserveDt = '') or (b:digital and b:digital='YES') or        (b:memory and b:memory = 'YES')))">
				<xsl:value-of select="b:interestRateGroup/b:interestRate"/>
			</xsl:if>
		</interestRate>
	</xsl:template>
	<xsl:template name="structuredInterest_interestCalcRule">
		<xsl:choose>
			<xsl:when test="b:cpnRangeStart and b:cpnRangeStart != '' and b:cpnRangeEnd and b:cpnRangeEnd != '' and (not(b:cpnObserveDt) or b:cpnObserveDt = '')">
				<interestCalcRule>
					<xsl:value-of select="'5'"/>
				</interestCalcRule>
			</xsl:when>
			<xsl:when test="b:digital and b:digital='YES'">
				<interestCalcRule>
					<xsl:value-of select="'4'"/>
				</interestCalcRule>
			</xsl:when>
			<xsl:when test="b:memory and b:memory='YES'">
				<interestCalcRule>
					<xsl:value-of select="'6'"/>
				</interestCalcRule>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="structuredInterest_maximumInterestRate">
		<xsl:if test="b:cpnRangeEnd">
			<maximumInterestRate>
				<xsl:value-of select="b:cpnRangeEnd"/>
			</maximumInterestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="structuredInterest_minimumInterestRate">
		<xsl:if test="b:cpnRangeStart">
			<minimumInterestRate>
				<xsl:value-of select="b:cpnRangeStart"/>
			</minimumInterestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="structuredInterest_validityDate">
		<validityDate>
			<xsl:value-of select="b:issueDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="structuredInterest_mbFields"/>
	<!--  START BusinessEntity Compo -->
	<xsl:template name="infra:businessEntity">
		<infra:businessEntity>
			<infra:code>
				<xsl:call-template name="instrBusinessEntity">
					<xsl:with-param name="beAllowedCountry" select="."/>
				</xsl:call-template>
			</infra:code>
		</infra:businessEntity>
	</xsl:template>
	<xsl:template name="infra:mainBusinessEntity">
		<infra:mainBusinessEntity>0</infra:mainBusinessEntity>
	</xsl:template>
	<xsl:template name="infra:role"/>
	<xsl:template name="infra:type"/>
	<xsl:template name="be_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="infra:mbFields_becompo_inser"/>
	<xsl:template name="infra:mbFields_becompo_del"/>
	<!--  END BusinessEntity Compo -->
	<!-- END - For input flow FinancialInstrumentSecurity -->


	<!-- BEG - For input flow FinancialInstrumentME -->
	<xsl:template name="infra:code_MultiEntity">
		<infra:code>
			<xsl:value-of select="d:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="issuer_MultiEntity">
		<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX != '' and starts-with(d:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(d:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX != '' and starts-with(d:ovIssuer,'I-')">
						<xsl:value-of select="concat($ISSUER_PREFIX ,substring-after(d:ovIssuer,'I-'))"/>
					</xsl:when>
					<xsl:when test="starts-with(d:ovIssuer,'C-')">
						<xsl:value-of select="substring-after(d:ovIssuer,'C-')"/>
					</xsl:when>
					<xsl:when test="starts-with(d:ovIssuer,'I-')">
						<xsl:value-of select="substring-after(d:ovIssuer,'I-')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="d:ovIssuer"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="active_MultiEntity">
		<active>
			<xsl:choose>
				<xsl:when test="d:statusDate and  d:secStatus = 'SUS' and translate(d:statusDate,'-','') &lt;= translate(d:eventCommon/ns0:today,'-','')">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="d:blockingDate != ''">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'1'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="taxCountry_MultiEntity">
		<taxCountry>
			<infra:code>
				<xsl:value-of select="d:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="stpOrder_MultiEntity">
		<stpOrder>
			<xsl:choose>
				<xsl:when test="d:stp='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</stpOrder>
	</xsl:template>
	<xsl:template name="complexityLevel_MultiEntity">
		<xsl:choose>
			<xsl:when test="d:complexity = 'HIGH'">
				<complexityLevel>
					<xsl:value-of select="'3'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="d:complexity = 'MEDIUM'">
				<complexityLevel>
					<xsl:value-of select="'2'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="d:complexity = 'SIMPLE'">
				<complexityLevel>
					<xsl:value-of select="'1'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="d:complexity = 'Undefined'">
				<complexityLevel>
					<xsl:value-of select="'0'"/>
				</complexityLevel>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="riskLevel_MultiEntity">
		<xsl:if test="d:riskLevel and d:riskLevel != ''">
			<riskLevel>
				<xsl:value-of select="d:riskLevel"/>
			</riskLevel>
		</xsl:if>
	</xsl:template>
	<xsl:template name="complexity_MultiEntity">
		<xsl:choose>
			<xsl:when test="d:complexity = 'Know'">
				<complexity>
					<xsl:value-of select="'1'"/>
				</complexity>
			</xsl:when>
			<xsl:when test="d:complexity = 'NotKnow'">
				<complexity>
					<xsl:value-of select="'0'"/>
				</complexity>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dataSecuProf_MultiEntity">
		<xsl:if test="d:grpDeptCodeList/d:grpDeptCode != '' and d:grpDeptCodeList/d:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="d:grpDeptCodeList/d:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="interestCalculationRule_MultiEntity">
		<xsl:choose>
			<xsl:when test="d:digital='YES'">
				<interestCalculationRule>
					<xsl:value-of select="'2'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="d:memory='YES'">
				<interestCalculationRule>
					<xsl:value-of select="'3'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(d:digital='NO' or not(d:digital)) and (d:memory='NO' or not(d:memory)) and (d:cpnRangeEnd = '' or not(d:cpnRangeEnd)) and d:cpnRangeStart and d:cpnRangeStart != '' ">
				<interestCalculationRule>
					<xsl:value-of select="'4'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(d:digital='NO' or not(d:digital))  and (d:memory='NO' or not(d:memory)) and d:cpnRangeStart != '' and d:cpnRangeEnd != '' and d:cpnObserveDt != ''">
				<interestCalculationRule>
					<xsl:value-of select="'5'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="(d:digital='NO' or not(d:digital))  and (d:memory='NO' or not(d:memory)) and (d:cpnRangeStart = '' or not(d:cpnRangeStart)) and d:cpnRangeEnd and d:cpnRangeEnd != ''">
				<interestCalculationRule>
					<xsl:value-of select="'6'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:when test="d:cpnRangeStart and d:cpnRangeStart != '' and d:cpnRangeEnd and d:cpnRangeEnd != '' and (d:cpnObserveDt = '' or not(d:cpnObserveDt))">
				<interestCalculationRule>
					<xsl:value-of select="'1'"/>
				</interestCalculationRule>
			</xsl:when>
			<xsl:otherwise>
				<interestCalculationRule>
					<xsl:value-of select="'0'"/>
				</interestCalculationRule>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="underlyingCategory_MultiEntity">
		<underlyingCategory>
			<xsl:choose>
				<xsl:when test="d:worstOf='YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="d:underlyingGroup/d:weight='100'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'2'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</underlyingCategory>
	</xsl:template>
	<xsl:template name="infra:synonym-custo_MultiEntity"/>
	<xsl:template name="infra:synonym_MultiEntity"/>
	<xsl:template name="infra:shortName_MultiEntity"/>
	<xsl:template name="infra:longName_MultiEntity"/>
	<xsl:template name="infra:multilingualLongName_MultiEntity"/>
	<xsl:template name="infra:notepad_MultiEntity"/>
	<xsl:template name="infra:userDefinedField-custo_MultiEntity"/>
	<xsl:template name="infra:userDefinedField_MultiEntity"/>
	<xsl:template name="infra:mbFields_MultiEntity"/>
	<xsl:template name="euroConversionDate_MultiEntity"/>
	<xsl:template name="euroConversionRule_MultiEntity"/>
	<xsl:template name="euroNewInstrument_MultiEntity"/>
	<xsl:template name="mainBusinessEntity_MultiEntity"/>
	<xsl:template name="mainStockExchange_MultiEntity"/>
	<xsl:template name="minimumQuantity_MultiEntity"/>
	<xsl:template name="priceCalculationRule_MultiEntity"/>
	<xsl:template name="provider_MultiEntity"/>
	<xsl:template name="referenceCurrency_MultiEntity"/>
	<xsl:template name="riskCountry_MultiEntity"/>
	<xsl:template name="riskNature_MultiEntity"/>
	<xsl:template name="roundLotQuantity_MultiEntity"/>
	<xsl:template name="subType_MultiEntity"/>
	<xsl:template name="tickSize_MultiEntity"/>
	<xsl:template name="tradable_MultiEntity"/>
	<xsl:template name="type_MultiEntity"/>
	<xsl:template name="valuationRule_MultiEntity"/>
	<xsl:template name="accrualRule_MultiEntity"/>
	<xsl:template name="accruedInterestRoundingRule_MultiEntity"/>
	<xsl:template name="accruedInterestRoundingUnit_MultiEntity"/>
	<xsl:template name="accruedInterestUnitaryRounding_MultiEntity"/>
	<xsl:template name="accruedInterestCalculation_MultiEntity"/>
	<xsl:template name="capitalGainTax_MultiEntity"/>
	<xsl:template name="couponFrequencyNumber_MultiEntity"/>
	<xsl:template name="couponFrequencyUnit_MultiEntity"/>
	<xsl:template name="effectiveMaturityDate_MultiEntity"/>
	<xsl:template name="eomConvention_MultiEntity"/>
	<xsl:template name="faceValue_MultiEntity"/>
	<xsl:template name="firstCouponDate_MultiEntity"/>
	<xsl:template name="firstExDate_MultiEntity"/>
	<xsl:template name="interestAccrualDate_MultiEntity"/>
	<xsl:template name="interestRate_MultiEntity"/>
	<xsl:template name="issuedAmount_MultiEntity"/>
	<xsl:template name="issueDate_MultiEntity"/>
	<xsl:template name="issuedPrice_MultiEntity"/>
	<xsl:template name="lastCouponDate_MultiEntity"/>
	<xsl:template name="maturityDate_MultiEntity"/>
	<xsl:template name="maturityPrice_MultiEntity"/>
	<xsl:template name="witholdingTax_MultiEntity"/>
	<xsl:template name="yieldCurve_MultiEntity"/>
	<xsl:template name="barrier_MultiEntity"/>
	<xsl:template name="benchmark_MultiEntity"/>
	<xsl:template name="businessDayConvention_MultiEntity"/>
	<xsl:template name="couponStrikeLevel_MultiEntity"/>
	<xsl:template name="couponStrikeLevelPercent_MultiEntity"/>
	<xsl:template name="exerciseQuote_MultiEntity"/>
	<xsl:template name="exerciseQuotePercent_MultiEntity"/>
	<xsl:template name="firstObservationDate_MultiEntity"/>
	<xsl:template name="floatingRateInstrument_MultiEntity"/>
	<xsl:template name="initialFixingPrice_MultiEntity"/>
	<xsl:template name="islamicCompliance_MultiEntity"/>
	<xsl:template name="knockInDate_MultiEntity"/>
	<xsl:template name="knockOutDate_MultiEntity"/>
	<xsl:template name="maximumInterestRate_MultiEntity"/>
	<xsl:template name="minimumInterestRate_MultiEntity"/>
	<xsl:template name="marketDirectiveStrategy_MultiEntity"/>
	<xsl:template name="optionStyle_MultiEntity"/>
	<xsl:template name="participationLevel_MultiEntity"/>
	<xsl:template name="riskCurrency_MultiEntity"/>
	<xsl:template name="underlying_MultiEntity"/>
	<!-- END - For input flow FinancialInstrumentME -->
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