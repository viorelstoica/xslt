<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PEProductEvents" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPEProductEvents"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">

	<xsl:template name="infra:code_CapitalCall">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_CapitalCall">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>

	<xsl:template name="nature_CapitalCallRedem">
		<nature>
			<xsl:value-of select="'11'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_CapitalCallRedem">
		<validityDate>
			<xsl:value-of select="b:saveCapCallDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate_CapitalCallRedem">
		<effectiveMaturityDate>
			<xsl:value-of select="b:savePaymentDate"/>
		</effectiveMaturityDate>
	</xsl:template>
	<xsl:template name="redemptionPercentage_CapitalCallRedem">
		<redemptionPercentage>
			<xsl:value-of select="b:saveCapCallPerc"/>
		</redemptionPercentage>
	</xsl:template>
	<xsl:template name="exDate_CapitalCallRedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_CapitalCallRedem"/>
	<xsl:template name="code_CapitalCallRedem"/>
	<xsl:template name="currency_CapitalCallRedem"/>
	<xsl:template name="endDate_CapitalCallRedem"/>
	<xsl:template name="exchnageRate_CapitalCallRedem"/>
	<xsl:template name="noticeDays_CapitalCallRedem"/>
	<xsl:template name="proportionAppliedOn_CapitalCallRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_CapitalCallRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_CapitalCallRedem"/>
	<xsl:template name="redemptionQuote_CapitalCallRedem"/>
	<xsl:template name="mbFields_CapitalCallRedem"/>
	<xsl:template name="infra:synonym_CapitalCall">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_CapitalCall">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_CapitalCall">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_CapitalCall">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_CapitalCall"/>
	<xsl:template name="infra:userDefinedField_CapitalCall">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_CapitalCall"/>
	<xsl:template name="euroConversionDate_CapitalCall"/>
	<xsl:template name="euroConversionRule_CapitalCall"/>
	<xsl:template name="euroNewInstrument_CapitalCall"/>
	<xsl:template name="mainBusinessEntity_CapitalCall"/>
	<xsl:template name="mainStockExchange_CapitalCall">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_CapitalCall">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_CapitalCall">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_CapitalCall">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_CapitalCall">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_CapitalCall">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_CapitalCall"/>
	<xsl:template name="roundLotQuantity_CapitalCall">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_CapitalCall">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_CapitalCall"/>
	<xsl:template name="subType_CapitalCall">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_CapitalCall">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_CapitalCall"/>
	<xsl:template name="tradable_CapitalCall">
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
	<xsl:template name="type_CapitalCall">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_CapitalCall"/>
	<xsl:template name="beginDate_CapitalCall"/>
	<xsl:template name="capitalGainTax_CapitalCall"/>
	<xsl:template name="complexity_CapitalCall">
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
	<xsl:template name="complexityLevel_CapitalCall">
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
	<xsl:template name="cutOffTime_CapitalCall">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_CapitalCall">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_CapitalCall">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_CapitalCall">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_CapitalCall">
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
	<xsl:template name="faceValue_CapitalCall">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_CapitalCall">
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
	<xsl:template name="issueQuantity_CapitalCall"/>
	<xsl:template name="issueQuote_CapitalCall"/>
	<xsl:template name="issuer_CapitalCall">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_CapitalCall"/>
	<xsl:template name="minimumTradingAmount_CapitalCall">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_CapitalCall"/>
	<xsl:template name="riskCurrency_CapitalCall">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_CapitalCall">
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
	<xsl:template name="roundLotAmount_CapitalCall">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_CapitalCall">
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
	<xsl:template name="subNature_CapitalCall">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_CapitalCall">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_CapitalCall"/>
	<xsl:template name="witholdingTax_CapitalCall"/>
	<xsl:template name="dividend_CapitalCall"/>
	<xsl:template name="composition_CapitalCall"/>
	<xsl:template name="commonReference_CapitalCall">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_CapitalCall">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_CapitalCall">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_CapitalCall">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_CapitalCall">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_CapitalCall"/>
	<xsl:template name="reinvestmentAllowedF_CapitalCall">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_CapitalCall">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_CapitalCall">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_CapitalCall">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="infra:code_Allot">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_Allot">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="nature_AllotRedem">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_AllotRedem">
		<validityDate>
			<xsl:value-of select="b:saveCapCallDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate_AllotRedem">
		<effectiveMaturityDate>
			<xsl:value-of select="b:saveUnitsIssueDate"/>
		</effectiveMaturityDate>
	</xsl:template>
	<xsl:template name="redemptionQuote_AllotRedem">
		<redemptionQuote>
			<xsl:value-of select="'1'"/>
		</redemptionQuote>
	</xsl:template>
	<xsl:template name="exDate_AllotRedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_AllotRedem"/>
	<xsl:template name="code_AllotRedem"/>
	<xsl:template name="currency_AllotRedem"/>
	<xsl:template name="endDate_AllotRedem"/>
	<xsl:template name="exchnageRate_AllotRedem"/>
	<xsl:template name="noticeDays_AllotRedem"/>
	<xsl:template name="proportionAppliedOn_AllotRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_AllotRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_AllotRedem"/>
	<xsl:template name="redemptionPercentage_AllotRedem"/>
	<xsl:template name="mbFields_AllotRedem"/>
	<xsl:template name="infra:synonym_Allot">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_Allot">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_Allot">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_Allot">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_Allot"/>
	<xsl:template name="infra:userDefinedField_Allot">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_Allot"/>
	<xsl:template name="euroConversionDate_Allot"/>
	<xsl:template name="euroConversionRule_Allot"/>
	<xsl:template name="euroNewInstrument_Allot"/>
	<xsl:template name="mainBusinessEntity_Allot"/>
	<xsl:template name="mainStockExchange_Allot">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_Allot">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_Allot">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_Allot">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_Allot">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_Allot">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_Allot"/>
	<xsl:template name="roundLotQuantity_Allot">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_Allot">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_Allot"/>
	<xsl:template name="subType_Allot">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_Allot">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_Allot"/>
	<xsl:template name="tradable_Allot">
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
	<xsl:template name="type_Allot">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_Allot"/>
	<xsl:template name="beginDate_Allot"/>
	<xsl:template name="capitalGainTax_Allot"/>
	<xsl:template name="complexity_Allot">
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
	<xsl:template name="complexityLevel_Allot">
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
	<xsl:template name="cutOffTime_Allot">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_Allot">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_Allot">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_Allot">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_Allot">
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
	<xsl:template name="faceValue_Allot">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_Allot">
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
	<xsl:template name="issueQuantity_Allot"/>
	<xsl:template name="issueQuote_Allot"/>
	<xsl:template name="issuer_Allot">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_Allot"/>
	<xsl:template name="minimumTradingAmount_Allot">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_Allot"/>
	<xsl:template name="riskCurrency_Allot">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_Allot">
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
	<xsl:template name="roundLotAmount_Allot">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_Allot">
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
	<xsl:template name="subNature_Allot">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_Allot">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_Allot"/>
	<xsl:template name="witholdingTax_Allot"/>
	<xsl:template name="dividend_Allot"/>
	<xsl:template name="composition_Allot"/>
	<xsl:template name="commonReference_Allot">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_Allot">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_Allot">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_Allot">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_Allot">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_Allot"/>
	<xsl:template name="reinvestmentAllowedF_Allot">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_Allot">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_Allot">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_Allot">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="infra:code_CapReturnAfterAU">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_CapReturnAfterAU">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>

	<xsl:template name="nature_CapReturnAfterAURedem">
		<nature>
			<xsl:value-of select="'12'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_CapReturnAfterAURedem">
		<validityDate>
			<xsl:value-of select="b:saveReturnDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="proportionAppliedOn_CapReturnAfterAURedem">
		<proportionAppliedOn>
			<xsl:choose>
				<xsl:when test="b:savePercentageBasis = 'INITIAL COMMITMENT'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:savePercentageBasis = 'LAST CONTRIBUTION'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
			</xsl:choose>
		</proportionAppliedOn>
	</xsl:template>
	<xsl:template name="redemptionPercentage_CapReturnAfterAURedem">
		<redemptionPercentage>
			<xsl:value-of select="b:saveReturnOfCapPerc"/>
		</redemptionPercentage>
	</xsl:template>
	<xsl:template name="exDate_CapReturnAfterAURedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_CapReturnAfterAURedem"/>
	<xsl:template name="code_CapReturnAfterAURedem"/>
	<xsl:template name="currency_CapReturnAfterAURedem"/>
	<xsl:template name="endDate_CapReturnAfterAURedem"/>
	<xsl:template name="exchnageRate_CapReturnAfterAURedem"/>
	<xsl:template name="effectiveMaturityDate_CapReturnAfterAURedem"/>
	<xsl:template name="noticeDays_CapReturnAfterAURedem"/>
	<xsl:template name="redemptionFrequenceyNumber_CapReturnAfterAURedem"/>
	<xsl:template name="redemptionFrequenceyUnit_CapReturnAfterAURedem"/>
	<xsl:template name="redemptionQuote_CapReturnAfterAURedem"/>
	<xsl:template name="mbFields_CapReturnAfterAURedem"/>
	<xsl:template name="infra:synonym_CapReturnAfterAU">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_CapReturnAfterAU">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_CapReturnAfterAU">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_CapReturnAfterAU">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_CapReturnAfterAU"/>
	<xsl:template name="infra:userDefinedField_CapReturnAfterAU">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_CapReturnAfterAU"/>
	<xsl:template name="euroConversionDate_CapReturnAfterAU"/>
	<xsl:template name="euroConversionRule_CapReturnAfterAU"/>
	<xsl:template name="euroNewInstrument_CapReturnAfterAU"/>
	<xsl:template name="mainBusinessEntity_CapReturnAfterAU"/>
	<xsl:template name="mainStockExchange_CapReturnAfterAU">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_CapReturnAfterAU">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_CapReturnAfterAU">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_CapReturnAfterAU">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_CapReturnAfterAU">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_CapReturnAfterAU">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_CapReturnAfterAU"/>
	<xsl:template name="roundLotQuantity_CapReturnAfterAU">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_CapReturnAfterAU">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_CapReturnAfterAU"/>
	<xsl:template name="subType_CapReturnAfterAU">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_CapReturnAfterAU">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_CapReturnAfterAU"/>
	<xsl:template name="tradable_CapReturnAfterAU">
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
	<xsl:template name="type_CapReturnAfterAU">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_CapReturnAfterAU"/>
	<xsl:template name="beginDate_CapReturnAfterAU"/>
	<xsl:template name="capitalGainTax_CapReturnAfterAU"/>
	<xsl:template name="complexity_CapReturnAfterAU">
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
	<xsl:template name="complexityLevel_CapReturnAfterAU">
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
	<xsl:template name="cutOffTime_CapReturnAfterAU">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_CapReturnAfterAU">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_CapReturnAfterAU">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_CapReturnAfterAU">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_CapReturnAfterAU">
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
	<xsl:template name="faceValue_CapReturnAfterAU">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_CapReturnAfterAU">
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
	<xsl:template name="issueQuantity_CapReturnAfterAU"/>
	<xsl:template name="issueQuote_CapReturnAfterAU"/>
	<xsl:template name="issuer_CapReturnAfterAU">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_CapReturnAfterAU"/>
	<xsl:template name="minimumTradingAmount_CapReturnAfterAU">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_CapReturnAfterAU"/>
	<xsl:template name="riskCurrency_CapReturnAfterAU">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_CapReturnAfterAU">
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
	<xsl:template name="roundLotAmount_CapReturnAfterAU">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_CapReturnAfterAU">
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
	<xsl:template name="subNature_CapReturnAfterAU">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_CapReturnAfterAU">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_CapReturnAfterAU"/>
	<xsl:template name="witholdingTax_CapReturnAfterAU"/>
	<xsl:template name="dividend_CapReturnAfterAU"/>
	<xsl:template name="composition_CapReturnAfterAU"/>
	<xsl:template name="commonReference_CapReturnAfterAU">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_CapReturnAfterAU">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_CapReturnAfterAU">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_CapReturnAfterAU">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_CapReturnAfterAU">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_CapReturnAfterAU"/>
	<xsl:template name="reinvestmentAllowedF_CapReturnAfterAU">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_CapReturnAfterAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_CapReturnAfterAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_CapReturnAfterAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="eventAmount_CapReturnAfterAURedem">
		<eventAmount>
			<xsl:if test="$PEWorkflowhandling= 'YES'">
				<xsl:value-of select="b:saveReturnOfCapAmt"/>
			</xsl:if>
		</eventAmount>
	</xsl:template>
	<xsl:template name="infra:code_CapReturnBeforeAU">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_CapReturnBeforeAU">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="nature_CapReturnBeforeAURedem">
		<nature>
			<xsl:value-of select="'13'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_CapReturnBeforeAURedem">
		<validityDate>
			<xsl:value-of select="b:saveReturnDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="proportionAppliedOn_CapReturnBeforeAURedem">
		<proportionAppliedOn>
			<xsl:choose>
				<xsl:when test="b:savePercentageBasis = 'INITIAL COMMITMENT'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:savePercentageBasis = 'LAST CONTRIBUTION'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
			</xsl:choose>
		</proportionAppliedOn>
	</xsl:template>
	<xsl:template name="redemptionPercentage_CapReturnBeforeAURedem">
		<redemptionPercentage>
			<xsl:value-of select="b:saveReturnOfCapPerc"/>
		</redemptionPercentage>
	</xsl:template>
	<xsl:template name="exDate_CapReturnBeforeAURedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_CapReturnBeforeAURedem"/>
	<xsl:template name="code_CapReturnBeforeAURedem"/>
	<xsl:template name="currency_CapReturnBeforeAURedem"/>
	<xsl:template name="endDate_CapReturnBeforeAURedem"/>
	<xsl:template name="exchnageRate_CapReturnBeforeAURedem"/>
	<xsl:template name="effectiveMaturityDate_CapReturnBeforeAURedem"/>
	<xsl:template name="noticeDays_CapReturnBeforeAURedem"/>
	<xsl:template name="redemptionFrequenceyNumber_CapReturnBeforeAURedem"/>
	<xsl:template name="redemptionFrequenceyUnit_CapReturnBeforeAURedem"/>
	<xsl:template name="redemptionQuote_CapReturnBeforeAURedem"/>
	<xsl:template name="mbFields_CapReturnBeforeAURedem"/>
	<xsl:template name="infra:synonym_CapReturnBeforeAU">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_CapReturnBeforeAU">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_CapReturnBeforeAU">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_CapReturnBeforeAU">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_CapReturnBeforeAU"/>
	<xsl:template name="infra:userDefinedField_CapReturnBeforeAU">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_CapReturnBeforeAU"/>
	<xsl:template name="euroConversionDate_CapReturnBeforeAU"/>
	<xsl:template name="euroConversionRule_CapReturnBeforeAU"/>
	<xsl:template name="euroNewInstrument_CapReturnBeforeAU"/>
	<xsl:template name="mainBusinessEntity_CapReturnBeforeAU"/>
	<xsl:template name="mainStockExchange_CapReturnBeforeAU">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_CapReturnBeforeAU">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_CapReturnBeforeAU">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_CapReturnBeforeAU">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_CapReturnBeforeAU">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_CapReturnBeforeAU">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_CapReturnBeforeAU"/>
	<xsl:template name="roundLotQuantity_CapReturnBeforeAU">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_CapReturnBeforeAU">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_CapReturnBeforeAU"/>
	<xsl:template name="subType_CapReturnBeforeAU">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_CapReturnBeforeAU">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_CapReturnBeforeAU"/>
	<xsl:template name="tradable_CapReturnBeforeAU">
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
	<xsl:template name="type_CapReturnBeforeAU">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_CapReturnBeforeAU"/>
	<xsl:template name="beginDate_CapReturnBeforeAU"/>
	<xsl:template name="capitalGainTax_CapReturnBeforeAU"/>
	<xsl:template name="complexity_CapReturnBeforeAU">
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
	<xsl:template name="complexityLevel_CapReturnBeforeAU">
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
	<xsl:template name="cutOffTime_CapReturnBeforeAU">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_CapReturnBeforeAU">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_CapReturnBeforeAU">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_CapReturnBeforeAU">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_CapReturnBeforeAU">
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
	<xsl:template name="faceValue_CapReturnBeforeAU">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_CapReturnBeforeAU">
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
	<xsl:template name="issueQuantity_CapReturnBeforeAU"/>
	<xsl:template name="issueQuote_CapReturnBeforeAU"/>
	<xsl:template name="issuer_CapReturnBeforeAU">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_CapReturnBeforeAU"/>
	<xsl:template name="minimumTradingAmount_CapReturnBeforeAU">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_CapReturnBeforeAU"/>
	<xsl:template name="riskCurrency_CapReturnBeforeAU">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_CapReturnBeforeAU">
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
	<xsl:template name="roundLotAmount_CapReturnBeforeAU">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_CapReturnBeforeAU">
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
	<xsl:template name="subNature_CapReturnBeforeAU">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_CapReturnBeforeAU">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_CapReturnBeforeAU"/>
	<xsl:template name="witholdingTax_CapReturnBeforeAU"/>
	<xsl:template name="dividend_CapReturnBeforeAU"/>
	<xsl:template name="composition_CapReturnBeforeAU"/>
	<xsl:template name="commonReference_CapReturnBeforeAU">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_CapReturnBeforeAU">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_CapReturnBeforeAU">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_CapReturnBeforeAU">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_CapReturnBeforeAU">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_CapReturnBeforeAU"/>
	<xsl:template name="reinvestmentAllowedF_CapReturnBeforeAU">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_CapReturnBeforeAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_CapReturnBeforeAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_CapReturnBeforeAU">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="eventAmount_CapReturnBeforeAURedem">
		<eventAmount>
			<xsl:if test="$PEWorkflowhandling= 'YES'">
				<xsl:value-of select="b:saveReturnOfCapAmt"/>
			</xsl:if>
		</eventAmount>
	</xsl:template>

	<xsl:template name="infra:code_CommitRedn">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_CommitRedn">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>

	<xsl:template name="nature_CommitRednRedem">
		<nature>
			<xsl:value-of select="'7'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_CommitRednRedem">
		<validityDate>
			<xsl:value-of select="b:saveCommitRednDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="redemptionPercentage_CommitRednRedem">
		<redemptionPercentage>
			<xsl:value-of select="b:saveCommitRednPerc"/>
		</redemptionPercentage>
	</xsl:template>
	<xsl:template name="exDate_CommitRednRedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_CommitRednRedem"/>
	<xsl:template name="code_CommitRednRedem"/>
	<xsl:template name="currency_CommitRednRedem"/>
	<xsl:template name="endDate_CommitRednRedem"/>
	<xsl:template name="exchnageRate_CommitRednRedem"/>
	<xsl:template name="effectiveMaturityDate_CommitRednRedem"/>
	<xsl:template name="noticeDays_CommitRednRedem"/>
	<xsl:template name="proportionAppliedOn_CommitRednRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_CommitRednRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_CommitRednRedem"/>
	<xsl:template name="redemptionQuote_CommitRednRedem"/>
	<xsl:template name="mbFields_CommitRednRedem"/>
	<xsl:template name="instrument_CommitRednRedem"/>
	<xsl:template name="infra:synonym_CommitRedn">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_CommitRedn">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_CommitRedn">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_CommitRedn">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_CommitRedn"/>
	<xsl:template name="infra:userDefinedField_CommitRedn">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_CommitRedn"/>
	<xsl:template name="euroConversionDate_CommitRedn"/>
	<xsl:template name="euroConversionRule_CommitRedn"/>
	<xsl:template name="euroNewInstrument_CommitRedn"/>
	<xsl:template name="mainBusinessEntity_CommitRedn"/>
	<xsl:template name="mainStockExchange_CommitRedn">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_CommitRedn">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_CommitRedn">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_CommitRedn">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_CommitRedn">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_CommitRedn">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_CommitRedn"/>
	<xsl:template name="roundLotQuantity_CommitRedn">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_CommitRedn">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_CommitRedn"/>
	<xsl:template name="subType_CommitRedn">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_CommitRedn">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_CommitRedn"/>
	<xsl:template name="tradable_CommitRedn">
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
	<xsl:template name="type_CommitRedn">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_CommitRedn"/>
	<xsl:template name="beginDate_CommitRedn"/>
	<xsl:template name="capitalGainTax_CommitRedn"/>
	<xsl:template name="complexity_CommitRedn">
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
	<xsl:template name="complexityLevel_CommitRedn">
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
	<xsl:template name="cutOffTime_CommitRedn">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_CommitRedn">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_CommitRedn">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_CommitRedn">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_CommitRedn">
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
	<xsl:template name="faceValue_CommitRedn">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_CommitRedn">
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
	<xsl:template name="issueQuantity_CommitRedn"/>
	<xsl:template name="issueQuote_CommitRedn"/>
	<xsl:template name="issuer_CommitRedn">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_CommitRedn"/>
	<xsl:template name="minimumTradingAmount_CommitRedn">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_CommitRedn"/>
	<xsl:template name="riskCurrency_CommitRedn">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_CommitRedn">
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
	<xsl:template name="roundLotAmount_CommitRedn">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_CommitRedn">
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
	<xsl:template name="subNature_CommitRedn">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_CommitRedn">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_CommitRedn"/>
	<xsl:template name="witholdingTax_CommitRedn"/>
	<xsl:template name="dividend_CommitRedn"/>
	<xsl:template name="composition_CommitRedn"/>
	<xsl:template name="commonReference_CommitRedn">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_CommitRedn">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_CommitRedn">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_CommitRedn">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_CommitRedn">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_CommitRedn"/>
	<xsl:template name="reinvestmentAllowedF_CommitRedn">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_CommitRedn">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_CommitRedn">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_CommitRedn">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="infra:code_MaturityPrice">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_MaturityPrice">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>

	<xsl:template name="nature_MaturityPriceRedem">
		<nature>
			<xsl:value-of select="'3'"/>
		</nature>
	</xsl:template>
	<xsl:template name="validityDate_MaturityPriceRedem">
		<validityDate>
			<xsl:value-of select="b:saveMaturityDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="redemptionQuote_MaturityPriceRedem">
		<redemptionQuote>
			<xsl:value-of select="b:saveMaturityPrice"/>
		</redemptionQuote>
	</xsl:template>
	<xsl:template name="exDate_MaturityPriceRedem">
		<exDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</exDate>
	</xsl:template>
	<xsl:template name="announcementDate_MaturityPriceRedem"/>
	<xsl:template name="code_MaturityPriceRedem"/>
	<xsl:template name="currency_MaturityPriceRedem"/>
	<xsl:template name="endDate_MaturityPriceRedem"/>
	<xsl:template name="exchnageRate_MaturityPriceRedem"/>
	<xsl:template name="effectiveMaturityDate_MaturityPriceRedem"/>
	<xsl:template name="proportionAppliedOn_MaturityPriceRedem"/>
	<xsl:template name="redemptionPercentage_MaturityPriceRedem"/>
	<xsl:template name="noticeDays_MaturityPriceRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_MaturityPriceRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_MaturityPriceRedem"/>
	<xsl:template name="mbFields_MaturityPriceRedem"/>
	<xsl:template name="infra:synonym_MaturityPrice">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_MaturityPrice">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_MaturityPrice">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_MaturityPrice">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_MaturityPrice"/>
	<xsl:template name="infra:userDefinedField_MaturityPrice">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_MaturityPrice"/>
	<xsl:template name="euroConversionDate_MaturityPrice"/>
	<xsl:template name="euroConversionRule_MaturityPrice"/>
	<xsl:template name="euroNewInstrument_MaturityPrice"/>
	<xsl:template name="mainBusinessEntity_MaturityPrice"/>
	<xsl:template name="mainStockExchange_MaturityPrice">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_MaturityPrice">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_MaturityPrice">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_MaturityPrice">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_MaturityPrice">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_MaturityPrice">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_MaturityPrice"/>
	<xsl:template name="roundLotQuantity_MaturityPrice">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_MaturityPrice">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_MaturityPrice"/>
	<xsl:template name="subType_MaturityPrice">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_MaturityPrice">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_MaturityPrice"/>
	<xsl:template name="tradable_MaturityPrice">
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
	<xsl:template name="type_MaturityPrice">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_MaturityPrice"/>
	<xsl:template name="beginDate_MaturityPrice"/>
	<xsl:template name="capitalGainTax_MaturityPrice"/>
	<xsl:template name="complexity_MaturityPrice">
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
	<xsl:template name="complexityLevel_MaturityPrice">
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
	<xsl:template name="cutOffTime_MaturityPrice">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_MaturityPrice">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_MaturityPrice">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_MaturityPrice">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_MaturityPrice">
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
	<xsl:template name="faceValue_MaturityPrice">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_MaturityPrice">
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
	<xsl:template name="issueQuantity_MaturityPrice"/>
	<xsl:template name="issueQuote_MaturityPrice"/>
	<xsl:template name="issuer_MaturityPrice">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_MaturityPrice"/>
	<xsl:template name="minimumTradingAmount_MaturityPrice">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_MaturityPrice"/>
	<xsl:template name="riskCurrency_MaturityPrice">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_MaturityPrice">
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
	<xsl:template name="roundLotAmount_MaturityPrice">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_MaturityPrice">
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
	<xsl:template name="subNature_MaturityPrice">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_MaturityPrice">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_MaturityPrice"/>
	<xsl:template name="witholdingTax_MaturityPrice"/>
	<xsl:template name="dividend_MaturityPrice"/>
	<xsl:template name="composition_MaturityPrice"/>
	<xsl:template name="commonReference_MaturityPrice">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_MaturityPrice">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_MaturityPrice">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_MaturityPrice">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_MaturityPrice">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_MaturityPrice"/>
	<xsl:template name="reinvestmentAllowedF_MaturityPrice">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_MaturityPrice">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_MaturityPrice">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_MaturityPrice">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!-- commitment -->

	<xsl:template name="infra:code_commitment">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>

	<xsl:template name="infra:synonym_commitment">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_commitment">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_commitment">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_commitment">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_commitment"/>
	<xsl:template name="infra:userDefinedField_commitment">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_commitment"/>
	<xsl:template name="active_commitment">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>

	<xsl:template name="euroConversionDate_commitment"/>
	<xsl:template name="euroConversionRule_commitment"/>
	<xsl:template name="euroNewInstrument_commitment"/>
	<xsl:template name="mainBusinessEntity_commitment"/>
	<xsl:template name="mainStockExchange_commitment">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_commitment">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_commitment">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_commitment">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_commitment">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_commitment">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_commitment"/>
	<xsl:template name="roundLotQuantity_commitment">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_commitment">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_commitment"/>
	<xsl:template name="subType_commitment">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_commitment">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_commitment"/>
	<xsl:template name="tradable_commitment">
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
	<xsl:template name="type_commitment">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_commitment"/>
	<xsl:template name="beginDate_commitment"/>

	<xsl:template name="capitalGainTax_commitment"/>
	<xsl:template name="complexity_commitment">
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
	<xsl:template name="complexityLevel_commitment">
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
	<xsl:template name="cutOffTime_commitment">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_commitment">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_commitment">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_commitment">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_commitment">
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
	<xsl:template name="faceValue_commitment">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_commitment">
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
	<xsl:template name="issueQuantity_commitment"/>
	<xsl:template name="issueQuote_commitment"/>
	<xsl:template name="issuer_commitment">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_commitment"/>
	<xsl:template name="minimumTradingAmount_commitment">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_commitment"/>
	<xsl:template name="riskCurrency_commitment">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_commitment">
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
	<xsl:template name="roundLotAmount_commitment">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_commitment">
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
	<xsl:template name="subNature_commitment">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_commitment">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_commitment"/>
	<xsl:template name="witholdingTax_commitment"/>
	<xsl:template name="dividend_commitment"/>
	<xsl:template name="composition_commitment"/>
	<xsl:template name="commonReference_commitment">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_commitment">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_commitment">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_commitment">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_commitment">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_commitment"/>
	<xsl:template name="reinvestmentAllowedF_commitment">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_commitment">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_commitment">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_commitment">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>




	<xsl:template name="announcementDate_commitmentRedem"/>
	<xsl:template name="code_commitmentRedem"/>
	<xsl:template name="currency_commitmentRedem"/>
	<xsl:template name="endDate_commitmentRedem">
		<endDate>
			<xsl:value-of select="b:commitmentTypeGroup[position()=last()]/b:commitEndDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate_commitmentRedem"/>
	<xsl:template name="exchnageRate_commitmentRedem"/>
	<xsl:template name="exDate_commitmentRedem">
		<exDate>
			
			<xsl:choose>
				<xsl:when test="not(b:commitmentTypeGroup[position()=last()]/b:commitStartDate) or b:commitmentTypeGroup[position()=last()]/b:commitStartDate = ''">
					<xsl:variable name="check_diaryDateTime">
						<xsl:call-template name="t24DateTimeToDatePE">
							<xsl:with-param name="t24ProvidedDate" select="b:dateTimeList/b:dateTime"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$check_diaryDateTime"/>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:commitmentTypeGroup[position()=last()]/b:commitStartDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</exDate>
	</xsl:template>
	<xsl:template name="nature_commitmentRedem">
		<nature>
			<xsl:value-of select="'14'"/>
		</nature>
	</xsl:template>

	<xsl:template name="noticeDays_commitmentRedem"/>
	<xsl:template name="proportionAppliedOn_commitmentRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_commitmentRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_commitmentRedem"/>
	<xsl:template name="redemptionQuote_commitmentRedem"/>
	<xsl:template name="redemptionPercentage_commitmentRedem"/>
	<xsl:template name="validityDate_commitmentRedem">
	<validityDate>
		<xsl:choose>
				<xsl:when test="not(b:commitmentTypeGroup[position()=last()]/b:commitStartDate) or b:commitmentTypeGroup[position()=last()]/b:commitStartDate = ''">
					<xsl:variable name="check_diaryDateTime">
						<xsl:call-template name="t24DateTimeToDatePE">
							<xsl:with-param name="t24ProvidedDate" select="b:dateTimeList/b:dateTime"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$check_diaryDateTime"/>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:commitmentTypeGroup[position()=last()]/b:commitStartDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</validityDate>
		</xsl:template>
	<xsl:template name="eventType_commitmentRedem">
		<eventType>
			<xsl:value-of select="b:commitmentTypeGroup[position()=last()]/b:commitmentType"/>
		</eventType>
	</xsl:template>
	<xsl:template name="eventStatus_commitmentRedem">
		<eventStatus>
			<xsl:choose>
				<xsl:when test="b:commitmentTypeGroup[position()=last()]/b:commitmentStatus = 'PROVISIONAL'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</eventStatus>
	</xsl:template>
	<xsl:template name="commitmentReference_commitmentRedem">
		<commitmentReference>
			<xsl:value-of select="b:commitmentTypeGroup[position()=last()]/b:commitmentRef"/>
		</commitmentReference>
	</xsl:template>
	<xsl:template name="eventAmount_commitmentRedem"/>
	<xsl:template name="mbFields_commitmentRedem"/>

	<xsl:template name="announcementDate_commitmentdeleteRedem"/>
	<xsl:template name="code_commitmentdeleteRedem"/>
	<xsl:template name="currency_commitmentdeleteRedem"/>
	<xsl:template name="endDate_commitmentdeleteRedem">
	<endDate>
			<xsl:value-of select="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitEndDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="effectiveMaturityDate_commitmentdeleteRedem"/>
	<xsl:template name="exchnageRate_commitmentdeleteRedem"/>
	<xsl:template name="exDate_commitmentdeleteRedem">
	<exDate>
			<xsl:choose>
				<xsl:when test="not(../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate) or ../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup/b:commitStartDate = ''">
					<xsl:variable name="check_diaryDateTime">
						<xsl:call-template name="t24DateTimeToDatePE">
							<xsl:with-param name="t24ProvidedDate" select="../../c:PreviousEvent/b:PEProductEvents/b:dateTimeList/b:dateTime"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$check_diaryDateTime"/>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</exDate>

	</xsl:template>
	<xsl:template name="nature_commitmentdeleteRedem">
	<nature>
			<xsl:value-of select="'14'"/>
		</nature>
	</xsl:template>
	<xsl:template name="noticeDays_commitmentdeleteRedem"/>
	<xsl:template name="proportionAppliedOn_commitmentdeleteRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_commitmentdeleteRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_commitmentdeleteRedem"/>
	<xsl:template name="redemptionQuote_commitmentdeleteRedem"/>
	<xsl:template name="redemptionPercentage_commitmentdeleteRedem"/>
	<xsl:template name="validityDate_commitmentdeleteRedem">
	<validityDate>
		<xsl:choose>
				<xsl:when test="not(../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate) or ../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate = ''">
					<xsl:variable name="check_diaryDateTime">
						<xsl:call-template name="t24DateTimeToDatePE">
							<xsl:with-param name="t24ProvidedDate" select="../../c:PreviousEvent/b:PEProductEvents/b:dateTimeList/b:dateTime"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="$check_diaryDateTime"/>
					
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitStartDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</validityDate>
		</xsl:template>
	
	<xsl:template name="eventType_commitmentdeleteRedem">
	<eventType>
			<xsl:value-of select="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitmentType"/>
		</eventType>
	</xsl:template>
	<xsl:template name="eventStatus_commitmentdeleteRedem">
		<eventStatus>
			<xsl:choose>
				<xsl:when test="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitmentStatus = 'PROVISIONAL'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</eventStatus>
	</xsl:template>
	<xsl:template name="commitmentReference_commitmentdeleteRedem">
		<commitmentReference>
			<xsl:value-of select="../../c:PreviousEvent/b:PEProductEvents/b:commitmentTypeGroup[position()=last()]/b:commitmentRef"/>
		</commitmentReference>
	</xsl:template>
	
	<xsl:template name="eventAmount_commitmentdeleteRedem"/>
	<xsl:template name="mbFields_commitmentdeleteRedem"/>

	<!-- Recallable -->
	<xsl:template name="infra:code_recallable">
		<infra:code>
			<xsl:value-of select="../b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:synonym_recallable">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_recallable">
	<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_recallable">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_recallable">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
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
		<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_recallable"/>
	<xsl:template name="infra:userDefinedField_recallable">
	<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_n'"/>
			</infra:name>
			<infra:value>
				<xsl:value-of select="'1'"/>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'price_freq_unit_e'"/>
			</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:priceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:priceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_recallable"/>
	<xsl:template name="active_recallable">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="euroConversionDate_recallable"/>
	<xsl:template name="euroConversionRule_recallable"/>
	<xsl:template name="euroNewInstrument_recallable"/>
	<xsl:template name="mainBusinessEntity_recallable"/>
	<xsl:template name="mainStockExchange_recallable">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_recallable">
	<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_recallable">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:priceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:priceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_recallable">
	<provider>
			<infra:code>
				<xsl:if test="b:priceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:priceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_recallable">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_recallable">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:riskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_recallable"/>
	<xsl:template name="roundLotQuantity_recallable">
	<roundLotQuantity>
			<xsl:value-of select="b:tradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_recallable">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:industryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:industryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_recallable"/>
	<xsl:template name="subType_recallable">
	<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_recallable">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:couponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_recallable"/>
	<xsl:template name="tradable_recallable">
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
	<xsl:template name="type_recallable">
	<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_recallable"/>
	<xsl:template name="beginDate_recallable"/>

	<xsl:template name="capitalGainTax_recallable"/>
	<xsl:template name="complexity_recallable">
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
	<xsl:template name="complexityLevel_recallable">
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
	<xsl:template name="cutOffTime_recallable">
	<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_recallable">
	<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_recallable">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:noOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:noOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:noOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:noOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:noOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_recallable">
	<dividendFrequencyUnit>
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
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_recallable">
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
	<xsl:template name="faceValue_recallable">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:nominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_recallable">
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
	<xsl:template name="issueQuantity_recallable"/>
	<xsl:template name="issueQuote_recallable"/>
	<xsl:template name="issuer_recallable">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:ovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:ovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:ovIssuer,'I-')">
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
	<xsl:template name="marketDirectiveCategory_recallable"/>
	<xsl:template name="minimumTradingAmount_recallable">
	<xsl:variable name="Var_SecurityCurrency" select="b:securityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:minInvtCcyGroup[b:minInvtCcy = $Var_SecurityCurrency]/b:minInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_recallable"/>
	<xsl:template name="riskCurrency_recallable">
	<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_recallable">
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
	<xsl:template name="roundLotAmount_recallable">
	<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_recallable">
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
	<xsl:template name="subNature_recallable">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:peFund = 'YES'">
					<xsl:if test="b:peType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:peType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:etfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:etfIndctr = 'NO' or not(b:etfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="tradeNature_recallable">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:tradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:tradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_recallable"/>
	<xsl:template name="witholdingTax_recallable"/>
	<xsl:template name="dividend_recallable"/>
	<xsl:template name="composition_recallable"/>
	<xsl:template name="commonReference_recallable">
	<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF_recallable">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:coolCancelPeriod = '' or not(b:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_recallable">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 1, 3)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriod>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriod>
					<xsl:value-of select="'0'"/>
				</coolPeriod>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_recallable">
	<xsl:choose>
			<xsl:when test="b:coolCancelPeriod and b:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 4)"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<coolPeriodUnit>
					<xsl:choose>
						<xsl:when test="$lastCharCoolCancelPeriod = 'D'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'M'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="$lastCharCoolCancelPeriod = 'Y'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</coolPeriodUnit>
			</xsl:when>
			<xsl:otherwise>
				<coolPeriodUnit>
					<xsl:value-of select="'0'"/>
				</coolPeriodUnit>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_recallable">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:fundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:fundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="parentInstrument_recallable"/>
	<xsl:template name="reinvestmentAllowedF_recallable">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:reinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="switchOrderAmt_recallable">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_recallable">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_recallable">
	<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<xsl:template name="eventType_recallableRedem"/>
	<xsl:template name="eventStatus_recallableRedem"/>
	<xsl:template name="commitmentReference_recallableRedem"/>


	<xsl:template name="announcementDate_recallableRedem"/>
	<xsl:template name="code_recallableRedem"/>
	<xsl:template name="currency_recallableRedem"/>
	<xsl:template name="endDate_recallableRedem"/>

	<xsl:template name="effectiveMaturityDate_recallableRedem"/>
	<xsl:template name="exchnageRate_recallableRedem"/>
	<xsl:template name="exDate_recallableRedem">
		<exDate>
			<xsl:value-of select="b:saveRecallableRocDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="nature_recallableRedem">
		<nature>
			<xsl:value-of select="'15'"/>
		</nature>
	</xsl:template>
	<xsl:template name="noticeDays_recallableRedem"/>
	<xsl:template name="proportionAppliedOn_recallableRedem"/>
	<xsl:template name="redemptionFrequenceyNumber_recallableRedem"/>
	<xsl:template name="redemptionFrequenceyUnit_recallableRedem"/>
	<xsl:template name="redemptionQuote_recallableRedem"/>
	<xsl:template name="redemptionPercentage_recallableRedem"/>
	<xsl:template name="validityDate_recallableRedem"/>
	<xsl:template name="eventAmount_recallableRedem">
		<eventAmount>
			<xsl:value-of select="b:saveRecallableRocAmt"/>
		</eventAmount>
	</xsl:template>
	<xsl:template name="mbFields_recallableRedem"/>
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