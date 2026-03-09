<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME" xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME"
                xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">

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
		<xsl:if test="b:descriptList/b:descript[@language='GB']  != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR']  != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE']  != ''">
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
	<xsl:template name="infra:userDefinedField">
		<xsl:if test="b:rfrRounding">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'ai_round_unit_e'"/>
				</infra:name>
				<infra:value>
					<xsl:value-of select="b:rfrRounding"/>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:mbFields"/>
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
						<xsl:when test="b:priceType = 'DBOND'">2</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">8</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">21</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'1'"/>
						</xsl:otherwise>
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
	<xsl:template name="sector-custo"/>
	<xsl:template name="sector">
		<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
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
                <firstCouponDate>       
                    <xsl:choose>        
                        <xsl:when test="b:firstCouponDate and b:firstCouponDate !=''">
                            <xsl:value-of select="b:firstCouponDate"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="b:intPaymentDate"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </firstCouponDate>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
	<xsl:template name="firstExDate">
		<xsl:if test="b:id and not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:coupDivCutDate)">
			<firstExDate>
				<xsl:value-of select="b:coupDivCutDate"/>
			</firstExDate>
		</xsl:if>
	</xsl:template>
    <xsl:template name="interestAccrualDate">
        <xsl:choose>
            <xsl:when test="b:id and (not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:accrualStartDate) and not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:firstAccrualStartDate)) ">
                <interestAccrualDate>
                    <xsl:choose>        
                        <xsl:when test="b:firstAccrualStartDate and b:firstAccrualStartDate !=''">
                            <xsl:value-of select="b:firstAccrualStartDate"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="b:accrualStartDate"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </interestAccrualDate>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
	<xsl:template name="interestRate">
		<xsl:if test="b:interestRateGroup/b:rateChDate = '' or not(b:interestRateGroup/b:rateChDate)">
			<interestRate>
				<xsl:value-of select="b:interestRateGroup/b:interestRate"/>
			</interestRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issuedAmount">
		<xsl:if test="b:totalIssued">
			<issuedAmount>
				<xsl:value-of select="b:totalIssued"/>
			</issuedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueDate">
		<issueDate>
			<xsl:value-of select="b:issueDate"/>
		</issueDate>
	</xsl:template>
	<xsl:template name="issuedPrice">
		<xsl:if test="b:issuePrice != ''">
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
		<xsl:if test="b:redemPrice != ''">
			<maturityPrice>
				<xsl:value-of select="b:redemPrice"/>
			</maturityPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="subNature">
		<xsl:if test="b:buildCpnDate != '' and b:interestKey != ''">
			<subNature>
				<xsl:value-of select="'31'"/>
			</subNature>
		</xsl:if>
	</xsl:template>
    <xsl:template name="interestSchedule">
        <xsl:if test="b:interestRateGroup/b:rateChDate and b:interestRateGroup/b:rateChDate != ''">
            <xsl:for-each select="b:interestRateGroup">
                <xsl:variable name="index" select="./@index"/>
                <xsl:if test="./b:rateChDate and ./b:rateChDate != '' and 
                    ./b:interestRate and ./b:interestRate != ''">
                    <interestSchedule>
                        <interestRate>
                            <xsl:value-of select="b:interestRate"/>
                        </interestRate>
                        <scheduledDate>
                            <xsl:value-of select="b:rateChDate"/>
                        </scheduledDate>
                        <validityDate>
                            <xsl:value-of select="b:rateChDate"/>
                        </validityDate>
                    </interestSchedule>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
        <xsl:call-template name="OldNewInterestRateConditionManagment">
            <xsl:with-param name="CurrentEvent" select="."/>
            <xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
        </xsl:call-template>
    </xsl:template>
	<xsl:template name="floatingCondition">
		<xsl:if test="b:interestKey != ''">
			<xsl:if test="not(../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:interestKey) or (b:interestKey != ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:interestKey) or (b:issueDate != ../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:issueDate)">
				<floatingCondition>
					<benchmark>
						<infra:code>
							<xsl:choose>
								<xsl:when test="b:couponMethod = 'RFR'">
									<xsl:value-of select="substring(b:interestKey,'1','5')"/>
								</xsl:when>
								<xsl:otherwise>
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
								</xsl:otherwise>
							</xsl:choose>
						</infra:code>
					</benchmark>
					<xsl:if test="b:cpnRateSpread != '' and b:cpnRateSpread">
						<spreadRate>
							<xsl:value-of select="b:cpnRateSpread"/>
						</spreadRate>
					</xsl:if>
					<scheduledDate>
						<xsl:value-of select="b:issueDate"/>
					</scheduledDate>
					<validityDate>
						<xsl:value-of select="b:issueDate"/>
					</validityDate>
					<xsl:if test="b:rfrAdjSpread">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'add_margin_p'"/>
							</infra:name>
							<infra:value>
								<xsl:choose>
									<xsl:when test="b:couponMethod = 'RFR'">
										<xsl:value-of select="b:rfrAdjSpread"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="b:cpnRateSpread"/>
									</xsl:otherwise>
								</xsl:choose>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrConvention">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'market_conv_method_e'"/>
							</infra:name>
							<infra:value>
								<xsl:choose>
									<xsl:when test="b:rfrConvention = 'PLAIN ARREARS'">
										<xsl:value-of select="'1'"/>
									</xsl:when>
									<xsl:when test="b:rfrConvention = 'LOOK BACK'">
										<xsl:value-of select="'2'"/>
									</xsl:when>
									<xsl:when test="b:rfrConvention = 'LOCK OUT' or b:rfrConvention = 'RESET CUT OFF'">
										<xsl:value-of select="'3'"/>
									</xsl:when>
									<xsl:when test="b:rfrConvention = 'LOOKBACK WITH LOCKOUT'">
										<xsl:value-of select="'4'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'0'"/>
									</xsl:otherwise>
								</xsl:choose>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrLookBackLagDays">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'lookback_days_n'"/>
							</infra:name>
							<infra:value>
								<xsl:value-of select="b:rfrLookBackLagDays"/>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrLookBackType">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'lookback_conv_e'"/>
							</infra:name>
							<infra:value>
								<xsl:choose>
									<xsl:when test="b:rfrLookBackType = 'NARROW'">
										<xsl:value-of select="'1'"/>
									</xsl:when>
									<xsl:when test="b:rfrLookBackType = 'OBSERVATION.SHIFT'">
										<xsl:value-of select="'2'"/>
									</xsl:when>
								</xsl:choose>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrLagDays">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'lockout_days_n'"/>
							</infra:name>
							<infra:value>
								<xsl:value-of select="b:rfrLagDays"/>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrCalcMethod">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'compound_freq_n'"/>
							</infra:name>
							<infra:value>
								<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
									<xsl:value-of select="'1'"/>
								</xsl:if>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrCalcMethod">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'compound_freq_unit_e'"/>
							</infra:name>
							<infra:value>
								<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
									<xsl:value-of select="'Day'"/>
								</xsl:if>
							</infra:value>
						</userDefinedField>
					</xsl:if>
					<xsl:if test="b:rfrCalcMethod">
						<userDefinedField>
							<infra:name>
								<xsl:value-of select="'comp_conv_e'"/>
							</infra:name>
							<infra:value>
								<xsl:if test="b:rfrCalcMethod = 'COMPOUND'">
									<xsl:value-of select="'1'"/>
								</xsl:if>
							</infra:value>
						</userDefinedField>
					</xsl:if>
				</floatingCondition>
			</xsl:if>
		</xsl:if>

			<xsl:call-template name="OldNewFloatingConditionManagment">
				<xsl:with-param name="CurrentEvent" select="."/>
				<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity"/>
			</xsl:call-template>
	</xsl:template>
	<xsl:template name="rating">
		<xsl:if test="b:ratingDescGroup/b:ratingDescList/b:ratingDesc">
			<xsl:call-template name="RatingManagment">
				<xsl:with-param name="structure" select="."/>
			</xsl:call-template>
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
	<xsl:template name="eligibleWrapFund">
		<xsl:if test="b:wrapEligible != ''">
			<eligibleWrapFund>
				<xsl:choose>
					<xsl:when test="b:wrapEligible = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:wrapEligible = 'NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</eligibleWrapFund>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:notepad-custo"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="stockExchange"/>
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
	<xsl:template name="cutOffTime"/>
	<xsl:template name="dataSecuProf">
		<xsl:if test="b:grpDeptCodeList/b:grpDeptCode != '' and b:grpDeptCodeList/b:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="b:grpDeptCodeList/b:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate"/>
	<xsl:template name="floatingRateInstrument"/>
	<xsl:template name="eomConvention"/>
	<xsl:template name="faceValue"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="coupon"/>
	<xsl:template name="redemption"/>
	<xsl:template name="riskCurrency"/>
	<xsl:template name="ConversionEvent"/>
	<xsl:template name="main"/>
	<xsl:template name="paymentOptionE_InstrumentDeposit"/>
	<xsl:template name="rank"/>
	<xsl:template name="mbFields_InstrumentDeposit"/>
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

	<xsl:template name="ExchangeEvent_endDate">
		<endDate>
			<xsl:value-of select="b:caEndDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_exDate">
		<exDate>
			<xsl:value-of select="b:caStartDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ExchangeEvent_nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newInstrument">
		<newInstrument>
			<infra:code>
				<xsl:value-of select="b:convExerSecNoGroup/b:convExerSecNo"/>
			</infra:code>
		</newInstrument>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newRatio">
		<newRatio>
			<xsl:value-of select="b:convExerSecNoGroup/b:newSecRatio"/>
		</newRatio>
	</xsl:template>
	<xsl:template name="ExchangeEvent_oldRatio">
		<oldRatio>
			<xsl:value-of select="b:convExerSecNoGroup/b:oldSecRatio"/>
		</oldRatio>
	</xsl:template>
	<xsl:template name="ExchangeEvent_price">
		<price>
			<xsl:value-of select="b:convExerSecNoGroup/b:convExerPrice"/>
		</price>
	</xsl:template>
	<xsl:template name="ExchangeEvent_validityDate">
		<validityDate>
			<xsl:value-of select="b:caStartDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_cashSettlement"/>
	<xsl:template name="ExchangeEvent_code"/>
	<xsl:template name="ExchangeEvent_currency"/>
	<xsl:template name="ExchangeEvent_endValidity"/>
	<xsl:template name="ExchangeEvent_eventPriority"/>
	<xsl:template name="ExchangeEvent_exchangeRate"/>
	<xsl:template name="ExchangeEvent_oddLotCompensation"/>
	<xsl:template name="ExchangeEvent_replaceOld"/>
	<xsl:template name="ExchangeEvent_mbFields"/>

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
	<xsl:template name="mappingRatingAttribution"/>
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
				<xsl:when test="d:blockingDate != ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
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
	<xsl:template name="dataSecuProf_MultiEntity">
		<xsl:if test="d:grpDeptCodeList/d:grpDeptCode != '' and d:grpDeptCodeList/d:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="d:grpDeptCodeList/d:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
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
	<xsl:template name="infra:synonym-custo_MultiEntity"/>
	<xsl:template name="infra:synonym_MultiEntity"/>
	<xsl:template name="infra:shortName_MultiEntity"/>
	<xsl:template name="infra:longName_MultiEntity"/>
	<xsl:template name="infra:multilingualLongName_MultiEntity"/>
	<xsl:template name="infra:notepad-custo_MultiEntity"/>
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
	<xsl:template name="sector-custo_MultiEntity"/>
	<xsl:template name="sector_MultiEntity"/>
	<xsl:template name="stockExchange_MultiEntity"/>
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
	<xsl:template name="businessDayConvention_MultiEntity"/>
	<xsl:template name="capitalGainTax_MultiEntity"/>
	<xsl:template name="couponFrequencyNumber_MultiEntity"/>
	<xsl:template name="couponFrequencyUnit_MultiEntity"/>
	<xsl:template name="cutOffTime_MultiEntity"/>
	<xsl:template name="effectiveMaturityDate_MultiEntity"/>
	<xsl:template name="eligibleWrapFund_MultiEntity"/>
	<xsl:template name="eomConvention_MultiEntity"/>
	<xsl:template name="faceValue_MultiEntity"/>
	<xsl:template name="firstCouponDate_MultiEntity"/>
	<xsl:template name="firstExDate_MultiEntity"/>
	<xsl:template name="floatingRateInstrument_MultiEntity"/>
	<xsl:template name="interestAccrualDate_MultiEntity"/>
	<xsl:template name="interestRate_MultiEntity"/>
	<xsl:template name="islamicCompliance_MultiEntity"/>
	<xsl:template name="issuedAmount_MultiEntity"/>
	<xsl:template name="issueDate_MultiEntity"/>
	<xsl:template name="issuedPrice_MultiEntity"/>
	<xsl:template name="lastCouponDate_MultiEntity"/>
	<xsl:template name="marketDirectiveCategory_MultiEntity"/>
	<xsl:template name="maturityDate_MultiEntity"/>
	<xsl:template name="maturityPrice_MultiEntity"/>
	<xsl:template name="subNature_MultiEntity"/>
	<xsl:template name="witholdingTax_MultiEntity"/>
	<xsl:template name="coupon_MultiEntity"/>
	<xsl:template name="interestSchedule_MultiEntity"/>
	<xsl:template name="floatingCondition_MultiEntity"/>
	<xsl:template name="rating_MultiEntity"/>
	<xsl:template name="redemption_MultiEntity"/>
	<xsl:template name="riskCurrency_MultiEntity"/>
	<xsl:template name="yieldCurve_MultiEntity"/>


	<xsl:template name="ConversionEvent_MultiEntity"/>


	<xsl:template name="instrument_IE_MultiEntity">
		<instrument>
			<infra:code>
				<xsl:value-of select="d:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="deposit_IE_MultiEntity">
		<deposit>
			<infra:code>
				<xsl:value-of select="d:defaultDepository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="main_IE_MultiEntity"/>
	<xsl:template name="paymentOptionE_IE_MultiEntity"/>
	<xsl:template name="rank_IE_MultiEntity"/>
	<xsl:template name="mbFields_IE_MultiEntity"/>
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