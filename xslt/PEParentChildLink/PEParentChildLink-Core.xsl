<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PEProductEvents" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPEProductEvents"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="infra:code_Drawdown">
		<infra:code>
			<xsl:value-of select="b:undrawnSecurity"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_Drawdown">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="parentInstrument_Drawdown">
		<parentInstrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</parentInstrument>
	</xsl:template>
	<xsl:template name="infra:synonym_Drawdown">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
		<xsl:for-each select="b:drawDownaltSecurityIdGroup">
			<xsl:if test="b:drawDownaltSecurityNo">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:drawDownaltSecurityNo"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:drawDownaltSecurityId"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="OldNewAltSecSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_Drawdown">
	<infra:shortName>
			<xsl:value-of select="b:drawDownshortNameList/b:drawDownshortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_Drawdown">
	<xsl:if test="b:drawDowndescriptList/b:drawDowndescript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:drawDowndescriptList/b:drawDowndescript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_Drawdown">
	<xsl:if test="b:drawDowndescriptList/b:drawDowndescript[@language='GB'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:drawDowndescriptList/b:drawDowndescript[@language='GB']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:drawDowndescriptList/b:drawDowndescript[@language='FR'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:drawDowndescriptList/b:drawDowndescript[@language='FR']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:drawDowndescriptList/b:drawDowndescript[@language='DE'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:drawDowndescriptList/b:drawDowndescript[@language='DE']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:call-template name="OldNewDenomConcatManagment">
			<xsl:with-param name="CurrentEvent" select="./b:drawDowndescriptList/b:drawDowndescript"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_Drawdown"/>
	<xsl:template name="infra:userDefinedField_Drawdown">
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
					<xsl:when test="b:drawDownpriceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:drawDownpriceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:drawDownpriceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:drawDownpriceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:drawDownpriceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:drawDownpriceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_Drawdown"/>
	<xsl:template name="euroConversionDate_Drawdown"/>
	<xsl:template name="euroConversionRule_Drawdown"/>
	<xsl:template name="euroNewInstrument_Drawdown"/>
	<xsl:template name="mainBusinessEntity_Drawdown"/>
	<xsl:template name="mainStockExchange_Drawdown">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:drawDownstockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:drawDownstockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_Drawdown">
	<xsl:if test="b:drawDownminInvestmentQty and b:drawDownminInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:drawDownminInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_Drawdown">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:drawDownnominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:drawDownpriceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:drawDownpriceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:drawDownpriceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:drawDownpriceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:drawDownpriceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:drawDownpriceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_Drawdown">
	<provider>
			<infra:code>
				<xsl:if test="b:drawDownpriceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:drawDownpriceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_Drawdown">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:drawDownsecurityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_Drawdown">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="drawDownriskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_Drawdown"/>
	<xsl:template name="roundLotQuantity_Drawdown">
	<roundLotQuantity>
			<xsl:value-of select="b:drawDowntradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_Drawdown">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:drawDownindustryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:drawDownindustryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:drawDowngicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_Drawdown"/>
	<xsl:template name="subType_Drawdown">
	<subType>
			<infra:code>
				<xsl:value-of select="b:drawDownsubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_Drawdown">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:drawDowncouponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_Drawdown"/>
	<xsl:template name="tradable_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDownsecStatus = 'DEF' or b:drawDownsecStatus = 'DEL' or b:drawDownsecStatus = 'SUS' or b:drawDownsecStatus ='NON.TRADABLE'">
				<tradable>
					<xsl:value-of select="'0'"/>
				</tradable>
			</xsl:when>
			<xsl:otherwise>
				<tradable>1</tradable>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="type_Drawdown">
	<type>
			<infra:code>
				<xsl:value-of select="b:drawDownassetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_Drawdown"/>
	<xsl:template name="beginDate_Drawdown"/>
	<xsl:template name="capitalGainTax_Drawdown"/>
	<xsl:template name="complexity_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDowncomplexity = 'Know'">
				<complexity>
					<xsl:value-of select="'1'"/>
				</complexity>
			</xsl:when>
			<xsl:when test="b:drawDowncomplexity = 'NotKnow'">
				<complexity>
					<xsl:value-of select="'0'"/>
				</complexity>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="complexityLevel_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDowncomplexity = 'HIGH'">
				<complexityLevel>
					<xsl:value-of select="'3'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:drawDowncomplexity = 'MEDIUM'">
				<complexityLevel>
					<xsl:value-of select="'2'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:drawDowncomplexity = 'SIMPLE'">
				<complexityLevel>
					<xsl:value-of select="'1'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:drawDowncomplexity = 'Undefined'">
				<complexityLevel>
					<xsl:value-of select="'0'"/>
				</complexityLevel>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_Drawdown">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:drawDownnoOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_Drawdown">
	<dividendFrequencyUnit>
			<xsl:choose>
				<xsl:when test="b:drawDownnoOfPayments = '0.2'">7</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '1'">7</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '2'">6</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '4'">5</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '6'">4</xsl:when>
				<xsl:when test="b:drawDownnoOfPayments = '12'">4</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_Drawdown">
	<xsl:if test="b:drawDownwrapEligible != ''">
			<eligibleWrapFund>
				<xsl:choose>
					<xsl:when test="b:drawDownwrapEligible = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:drawDownwrapEligible = 'NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</eligibleWrapFund>
		</xsl:if>
	</xsl:template>
	<xsl:template name="faceValue_Drawdown">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:drawDownnominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:drawDownfactorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:drawDownnominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_Drawdown">
	<xsl:if test="b:drawDownislamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:drawDownislamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:drawDownislamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:drawDownislamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueQuantity_Drawdown"/>
	<xsl:template name="issueQuote_Drawdown"/>
	<xsl:template name="issuer_Drawdown">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:drawDownovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:drawDownovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:drawDownovIssuer,'I-')">
						<xsl:value-of select="concat($ISSUER_PREFIX ,substring-after(b:drawDownovIssuer,'I-'))"/>
					</xsl:when>
					<xsl:when test="starts-with(b:drawDownovIssuer,'C-')">
						<xsl:value-of select="substring-after(b:drawDownovIssuer,'C-')"/>
					</xsl:when>
					<xsl:when test="starts-with(b:drawDownovIssuer,'I-')">
						<xsl:value-of select="substring-after(b:drawDownovIssuer,'I-')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:drawDownovIssuer"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="marketDirectiveCategory_Drawdown"/>
	<xsl:template name="minimumTradingAmount_Drawdown">
	<xsl:variable name="Var_SecurityCurrency" select="b:drawDownsecurityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:drawDownminInvtCcyGroup[b:drawDownminInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:drawDownminInvtCcyGroup[b:drawDownminInvtCcy = $Var_SecurityCurrency]/b:drawDownminInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_Drawdown"/>
	<xsl:template name="riskCurrency_Drawdown">
	<xsl:if test="b:drawDownriskCcy and b:drawDownriskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:drawDownriskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDowncompLevelAttribGroup/b:drawDowncompLevelAttrib = b:drawDowncoCode">
				<riskLevel>
					<xsl:value-of select="b:drawDowncompLevelAttribGroup[b:drawDowncompLevelAttrib = ../b:drawDowncoCode]/b:drawDownriskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:drawDowncompLevelAttribGroup[b:drawDowncompLevelAttrib = '' or not(b:drawDowncompLevelAttrib)]/b:drawDownriskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:drawDowncompLevelAttribGroup[b:drawDowncompLevelAttrib = '' or not(b:drawDowncompLevelAttrib)]/b:drawDownriskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="roundLotAmount_Drawdown">
	<xsl:if test="b:drawDownroundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:drawDownroundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_Drawdown">
	<stpOrder>
			<xsl:choose>
				<xsl:when test="b:drawDownstp='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</stpOrder>
	</xsl:template>
	<xsl:template name="tradeNature_Drawdown">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:drawDowntradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:drawDowntradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_Drawdown"/>
	<xsl:template name="witholdingTax_Drawdown"/>
	<xsl:template name="dividend_Drawdown"/>
	<xsl:template name="composition_Drawdown"/>
	<xsl:template name="cutOffTime_Drawdown">
	<xsl:if test="b:drawDowncutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:drawDowncutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_Drawdown">
	<xsl:if test="b:drawDowncutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:drawDowncutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference_Drawdown">
	<xsl:if test="b:drawDownpeFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:drawDowncommonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_Drawdown">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:drawDownfundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:drawDownfundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="redemption_Drawdown"/>
	<xsl:template name="reinvestmentAllowedF_Drawdown">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:drawDownreinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="subNature_Drawdown">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:drawDownpeFund = 'YES'">
					<xsl:if test="b:drawDownpeType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:drawDownpeType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:drawDownpeType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:drawDownpeType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:drawDownetfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:drawDownetfIndctr = 'NO' or not(b:drawDownetfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="switchOrderAmt_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'ALL' or b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'ALL' or b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'ALL' or b:drawDownswitchAllowedList/b:drawDownswitchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolCancelF_Drawdown">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:drawDowncoolCancelPeriod = '' or not(b:drawDowncoolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDowncoolCancelPeriod and b:drawDowncoolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 1, 3)"/>
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
	<xsl:template name="coolPeriodUnit_Drawdown">
	<xsl:choose>
			<xsl:when test="b:drawDowncoolCancelPeriod and b:drawDowncoolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:drawDowncoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:drawDowncoolCancelPeriod, 4)"/>
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

	<xsl:template name="infra:code_CapitalCalled">
		<infra:code>
			<xsl:value-of select="b:capitalSecurity"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_CapitalCalled">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="parentInstrument_CapitalCalled">
		<parentInstrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</parentInstrument>
	</xsl:template>
	<xsl:template name="infra:synonym_CapitalCalled">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
		<xsl:for-each select="b:capitalaltSecurityIdGroup">
			<xsl:if test="b:capitalaltSecurityNo">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:capitalaltSecurityNo"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:capitalaltSecurityId"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="OldNewAltSecSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_CapitalCalled">
	<infra:shortName>
			<xsl:value-of select="b:capitalshortNameList/b:capitalshortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_CapitalCalled">
	<xsl:if test="b:capitaldescriptList/b:capitaldescript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:capitaldescriptList/b:capitaldescript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_CapitalCalled">
	<xsl:if test="b:capitaldescriptList/b:capitaldescript[@language='GB'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:capitaldescriptList/b:capitaldescript[@language='GB']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:capitaldescriptList/b:capitaldescript[@language='FR'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:capitaldescriptList/b:capitaldescript[@language='FR']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:capitaldescriptList/b:capitaldescript[@language='DE'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:capitaldescriptList/b:capitaldescript[@language='DE']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:call-template name="OldNewDenomConcatManagment">
			<xsl:with-param name="CurrentEvent" select="./b:capitaldescriptList/b:capitaldescript"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:capitaldescriptList/b:capitaldescript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_CapitalCalled"/>
	<xsl:template name="infra:userDefinedField_CapitalCalled">
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
					<xsl:when test="b:capitalpriceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:capitalpriceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:capitalpriceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:capitalpriceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:capitalpriceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:capitalpriceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_CapitalCalled"/>
	<xsl:template name="euroConversionDate_CapitalCalled"/>
	<xsl:template name="euroConversionRule_CapitalCalled"/>
	<xsl:template name="euroNewInstrument_CapitalCalled"/>
	<xsl:template name="mainBusinessEntity_CapitalCalled"/>
	<xsl:template name="mainStockExchange_CapitalCalled">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:capitalstockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:capitalstockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_CapitalCalled">
	<xsl:if test="b:capitalminInvestmentQty and b:capitalminInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:capitalminInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_CapitalCalled">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:capitalnominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:capitalpriceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:capitalpriceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:capitalpriceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:capitalpriceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:capitalpriceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:capitalpriceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_CapitalCalled">
	<provider>
			<infra:code>
				<xsl:if test="b:capitalpriceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:capitalpriceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_CapitalCalled">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:capitalsecurityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_CapitalCalled">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:capitalriskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_CapitalCalled"/>
	<xsl:template name="roundLotQuantity_CapitalCalled">
	<roundLotQuantity>
			<xsl:value-of select="b:capitaltradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_CapitalCalled">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:capitalindustryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:capitalindustryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:capitalgicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_CapitalCalled"/>
	<xsl:template name="subType_CapitalCalled">
	<subType>
			<infra:code>
				<xsl:value-of select="b:capitalsubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_CapitalCalled">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:capitalcouponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_CapitalCalled"/>
	<xsl:template name="tradable_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalsecStatus = 'DEF' or b:capitalsecStatus = 'DEL' or b:capitalsecStatus = 'SUS' or b:capitalsecStatus ='NON.TRADABLE'">
				<tradable>
					<xsl:value-of select="'0'"/>
				</tradable>
			</xsl:when>
			<xsl:otherwise>
				<tradable>1</tradable>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="type_CapitalCalled">
	<type>
			<infra:code>
				<xsl:value-of select="b:capitalassetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_CapitalCalled"/>
	<xsl:template name="beginDate_CapitalCalled"/>
	<xsl:template name="capitalGainTax_CapitalCalled"/>
	<xsl:template name="complexity_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalcomplexity = 'Know'">
				<complexity>
					<xsl:value-of select="'1'"/>
				</complexity>
			</xsl:when>
			<xsl:when test="b:capitalcomplexity = 'NotKnow'">
				<complexity>
					<xsl:value-of select="'0'"/>
				</complexity>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="complexityLevel_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalcomplexity = 'HIGH'">
				<complexityLevel>
					<xsl:value-of select="'3'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:capitalcomplexity = 'MEDIUM'">
				<complexityLevel>
					<xsl:value-of select="'2'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:capitalcomplexity = 'SIMPLE'">
				<complexityLevel>
					<xsl:value-of select="'1'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:capitalcomplexity = 'Undefined'">
				<complexityLevel>
					<xsl:value-of select="'0'"/>
				</complexityLevel>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_CapitalCalled">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:capitalnoOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_CapitalCalled">
	<dividendFrequencyUnit>
			<xsl:choose>
				<xsl:when test="b:capitalnoOfPayments = '0.2'">7</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '1'">7</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '2'">6</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '4'">5</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '6'">4</xsl:when>
				<xsl:when test="b:capitalnoOfPayments = '12'">4</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_CapitalCalled">
	<xsl:if test="b:capitalwrapEligible != ''">
			<eligibleWrapFund>
				<xsl:choose>
					<xsl:when test="b:capitalwrapEligible = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:capitalwrapEligible = 'NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</eligibleWrapFund>
		</xsl:if>
	</xsl:template>
	<xsl:template name="faceValue_CapitalCalled">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:capitalnominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:capitalfactorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:capitalnominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:capitalnominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_CapitalCalled">
	<xsl:if test="b:capitalislamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:capitalislamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:capitalislamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:capitalislamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueQuantity_CapitalCalled"/>
	<xsl:template name="issueQuote_CapitalCalled"/>
	<xsl:template name="issuer_CapitalCalled">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:capitalovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:capitalovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:capitalovIssuer,'I-')">
						<xsl:value-of select="concat($ISSUER_PREFIX ,substring-after(b:capitalovIssuer,'I-'))"/>
					</xsl:when>
					<xsl:when test="starts-with(b:capitalovIssuer,'C-')">
						<xsl:value-of select="substring-after(b:capitalovIssuer,'C-')"/>
					</xsl:when>
					<xsl:when test="starts-with(b:capitalovIssuer,'I-')">
						<xsl:value-of select="substring-after(b:capitalovIssuer,'I-')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:capitalovIssuer"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="marketDirectiveCategory_CapitalCalled"/>
	<xsl:template name="minimumTradingAmount_CapitalCalled">
	<xsl:variable name="Var_SecurityCurrency" select="b:capitalsecurityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:capitalminInvtCcyGroup[b:capitalminInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:capitalminInvtCcyGroup[b:capitalminInvtCcy = $Var_SecurityCurrency]/b:capitalminInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_CapitalCalled"/>
	<xsl:template name="riskCurrency_CapitalCalled">
	<xsl:if test="b:capitalriskCcy and b:capitalriskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:capitalriskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalcompLevelAttribGroup/b:capitalcompLevelAttrib = b:capitalcoCode">
				<riskLevel>
					<xsl:value-of select="b:capitalcompLevelAttribGroup[b:capitalcompLevelAttrib = ../b:capitalcoCode]/b:capitalriskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:capitalcompLevelAttribGroup[b:capitalcompLevelAttrib = '' or not(b:capitalcompLevelAttrib)]/b:capitalriskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:capitalcompLevelAttribGroup[b:capitalcompLevelAttrib = '' or not(b:capitalcompLevelAttrib)]/b:capitalriskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="roundLotAmount_CapitalCalled">
	<xsl:if test="b:capitalroundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:capitalroundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_CapitalCalled">
	<stpOrder>
			<xsl:choose>
				<xsl:when test="b:capitalstp='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</stpOrder>
	</xsl:template>
	<xsl:template name="tradeNature_CapitalCalled">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:capitaltradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:capitaltradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_CapitalCalled"/>
	<xsl:template name="witholdingTax_CapitalCalled"/>
	<xsl:template name="dividend_CapitalCalled"/>
	<xsl:template name="composition_CapitalCalled"/>
	<xsl:template name="cutOffTime_CapitalCalled">
	<xsl:if test="b:capitalcutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:capitalcutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_CapitalCalled">
	<xsl:if test="b:capitalcutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:capitalcutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference_CapitalCalled">
	<xsl:if test="b:capitalpeFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:capitalcommonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_CapitalCalled">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:capitalfundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:capitalfundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="redemption_CapitalCalled"/>
	<xsl:template name="reinvestmentAllowedF_CapitalCalled">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:capitalreinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="subNature_CapitalCalled">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:capitalpeFund = 'YES'">
					<xsl:if test="b:capitalpeType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:capitalpeType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:capitalpeType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:capitalpeType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:capitaletfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:capitaletfIndctr = 'NO' or not(b:capitaletfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="switchOrderAmt_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalswitchAllowedList/b:capitalswitchAllowed = 'ALL' or b:capitalswitchAllowedList/b:capitalswitchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalswitchAllowedList/b:capitalswitchAllowed = 'ALL' or b:capitalswitchAllowedList/b:capitalswitchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalswitchAllowedList/b:capitalswitchAllowed = 'ALL' or b:capitalswitchAllowedList/b:capitalswitchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolCancelF_CapitalCalled">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:capitalcoolCancelPeriod = '' or not(b:capitalcoolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalcoolCancelPeriod and b:capitalcoolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:capitalcoolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:capitalcoolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:capitalcoolCancelPeriod, 1, 3)"/>
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
	<xsl:template name="coolPeriodUnit_CapitalCalled">
	<xsl:choose>
			<xsl:when test="b:capitalcoolCancelPeriod and b:capitalcoolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:capitalcoolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:capitalcoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:capitalcoolCancelPeriod, 4)"/>
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

	<xsl:template name="infra:code_ActualPeSecurity">
		<infra:code>
			<xsl:value-of select="b:actualPeSecurity"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_ActualPeSecurity">
		<active>
			<xsl:value-of select="1"/>
		</active>
	</xsl:template>
	<xsl:template name="parentInstrument_ActualPeSecurity">
		<parentInstrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</parentInstrument>
	</xsl:template>
	<xsl:template name="infra:synonym_ActualPeSecurity">
	<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
		<xsl:for-each select="b:actualaltSecurityIdGroup">
			<xsl:if test="b:actualaltSecurityNo">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:actualaltSecurityNo"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:actualaltSecurityId"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
		<xsl:call-template name="OldNewAltSecSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName_ActualPeSecurity">
	<infra:shortName>
			<xsl:value-of select="b:actualshortNameList/b:actualshortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName_ActualPeSecurity">
	<xsl:if test="b:actualdescriptList/b:actualdescript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:actualdescriptList/b:actualdescript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName_ActualPeSecurity">
	<xsl:if test="b:actualdescriptList/b:actualdescript[@language='GB'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:actualdescriptList/b:actualdescript[@language='GB']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:actualdescriptList/b:actualdescript[@language='FR'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:actualdescriptList/b:actualdescript[@language='FR']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="b:actualdescriptList/b:actualdescript[@language='DE'] != ''">
			<infra:multilingualLongName>
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="b:actualdescriptList/b:actualdescript[@language='DE']">
						<xsl:value-of select="."/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:call-template name="OldNewDenomConcatManagment">
			<xsl:with-param name="CurrentEvent" select="./b:actualdescriptList/b:actualdescript"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:actualdescriptList/b:actualdescript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:notepad_ActualPeSecurity"/>
	<xsl:template name="infra:userDefinedField_ActualPeSecurity">
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
					<xsl:when test="b:actualpriceFrequency = 'DAILY'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:actualpriceFrequency = 'WEEKLY'">
						<xsl:value-of select="'3'"/>
					</xsl:when>
					<xsl:when test="b:actualpriceFrequency = 'MONTHLY'">
						<xsl:value-of select="'4'"/>
					</xsl:when>
					<xsl:when test="b:actualpriceFrequency = 'QUARTERLY'">
						<xsl:value-of select="'5'"/>
					</xsl:when>
					<xsl:when test="b:actualpriceFrequency = 'SEMI-ANNUAL'">
						<xsl:value-of select="'6'"/>
					</xsl:when>
					<xsl:when test="b:actualpriceFrequency = 'ANNUAL'">
						<xsl:value-of select="'7'"/>
					</xsl:when>
				</xsl:choose>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:mbFields_ActualPeSecurity"/>
	<xsl:template name="euroConversionDate_ActualPeSecurity"/>
	<xsl:template name="euroConversionRule_ActualPeSecurity"/>
	<xsl:template name="euroNewInstrument_ActualPeSecurity"/>
	<xsl:template name="mainBusinessEntity_ActualPeSecurity"/>
	<xsl:template name="mainStockExchange_ActualPeSecurity">
	<mainStockExchange>
			<infra:code>
				<xsl:if test="b:actualstockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:actualstockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity_ActualPeSecurity">
	<xsl:if test="b:actualminInvestmentQty and b:actualminInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:actualminInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule_ActualPeSecurity">
	<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:actualnominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:actualpriceType = 'BOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:actualpriceType = 'DBOND'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:actualpriceType = 'DISCO'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:actualpriceType = 'UNIT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:actualpriceType = 'YIELD'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:actualpriceType = '0'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider_ActualPeSecurity">
	<provider>
			<infra:code>
				<xsl:if test="b:actualpriceUpdateCode != ''">
					<xsl:value-of select="concat($PRICEPROV_PREFIX,b:actualpriceUpdateCode)"/>
				</xsl:if>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="referenceCurrency_ActualPeSecurity">
	<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:actualsecurityCurrency"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry_ActualPeSecurity">
	<riskCountry>
			<infra:code>
				<xsl:value-of select="b:actualriskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature_ActualPeSecurity"/>
	<xsl:template name="roundLotQuantity_ActualPeSecurity">
	<roundLotQuantity>
			<xsl:value-of select="b:actualtradingUnits"/>
		</roundLotQuantity>
	</xsl:template>
	<xsl:template name="sector_ActualPeSecurity">
	<xsl:call-template name="SectorManagmentGICS">
			<xsl:with-param name="CurrentEvent" select="./b:actualindustryCode"/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:PEProductEvents/b:actualindustryCode"/>
			<xsl:with-param name="Codif" select="'T24_FI_INDUSTRY'"/>
			<xsl:with-param name="Today" select="b:eventCommon/ns0:today"/>
			<xsl:with-param name="GicsCode" select="b:gicsCode"/>
			<xsl:with-param name="CodifGics" select="'T24_FI_GICS_INDUSTRY'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="stockExchange_ActualPeSecurity"/>
	<xsl:template name="subType_ActualPeSecurity">
	<subType>
			<infra:code>
				<xsl:value-of select="b:actualsubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry_ActualPeSecurity">
	<taxCountry>
			<infra:code>
				<xsl:value-of select="b:actualcouponTaxCode"/>
			</infra:code>
		</taxCountry>
	</xsl:template>
	<xsl:template name="tickSize_ActualPeSecurity"/>
	<xsl:template name="tradable_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualsecStatus = 'DEF' or b:actualsecStatus = 'DEL' or b:actualsecStatus = 'SUS' or b:actualsecStatus ='NON.TRADABLE'">
				<tradable>
					<xsl:value-of select="'0'"/>
				</tradable>
			</xsl:when>
			<xsl:otherwise>
				<tradable>1</tradable>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="type_ActualPeSecurity">
	<type>
			<infra:code>
				<xsl:value-of select="b:actualassetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule_ActualPeSecurity"/>
	<xsl:template name="beginDate_ActualPeSecurity"/>
	<xsl:template name="capitalGainTax_ActualPeSecurity"/>
	<xsl:template name="complexity_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualcomplexity = 'Know'">
				<complexity>
					<xsl:value-of select="'1'"/>
				</complexity>
			</xsl:when>
			<xsl:when test="b:actualcomplexity = 'NotKnow'">
				<complexity>
					<xsl:value-of select="'0'"/>
				</complexity>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="complexityLevel_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualcomplexity = 'HIGH'">
				<complexityLevel>
					<xsl:value-of select="'3'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:actualcomplexity = 'MEDIUM'">
				<complexityLevel>
					<xsl:value-of select="'2'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:actualcomplexity = 'SIMPLE'">
				<complexityLevel>
					<xsl:value-of select="'1'"/>
				</complexityLevel>
			</xsl:when>
			<xsl:when test="b:actualcomplexity = 'Undefined'">
				<complexityLevel>
					<xsl:value-of select="'0'"/>
				</complexityLevel>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dividendFrequencyNumber_ActualPeSecurity">
	<dividendFrequencyNumber>
			<xsl:choose>
				<xsl:when test="b:actualnoOfPayments = '0.2'">5</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '1'">1</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '2'">1</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '4'">1</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '6'">2</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '12'">1</xsl:when>
			</xsl:choose>
		</dividendFrequencyNumber>
	</xsl:template>
	<xsl:template name="dividendFrequencyUnit_ActualPeSecurity">
	<dividendFrequencyUnit>
			<xsl:choose>
				<xsl:when test="b:actualnoOfPayments = '0.2'">7</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '1'">7</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '2'">6</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '3'">4</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '4'">5</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '6'">4</xsl:when>
				<xsl:when test="b:actualnoOfPayments = '12'">4</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</dividendFrequencyUnit>
	</xsl:template>
	<xsl:template name="eligibleWrapFund_ActualPeSecurity">
	<xsl:if test="b:actualwrapEligible != ''">
			<eligibleWrapFund>
				<xsl:choose>
					<xsl:when test="b:actualwrapEligible = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:when test="b:actualwrapEligible = 'NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
				</xsl:choose>
			</eligibleWrapFund>
		</xsl:if>
	</xsl:template>
	<xsl:template name="faceValue_ActualPeSecurity">
	<faceValue>
			<xsl:choose>
				<xsl:when test="b:actualnominalFactor != ''">
					<xsl:choose>
						<xsl:when test="b:actualfactorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:actualnominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:actualnominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</faceValue>
	</xsl:template>
	<xsl:template name="islamicCompliance_ActualPeSecurity">
	<xsl:if test="b:actualislamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:actualislamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:actualislamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:actualislamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueQuantity_ActualPeSecurity"/>
	<xsl:template name="issueQuote_ActualPeSecurity"/>
	<xsl:template name="issuer_ActualPeSecurity">
	<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !='' and starts-with(b:actualovIssuer,'C-')">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-after(b:actualovIssuer,'C-'))"/>
					</xsl:when>
					<xsl:when test="$ISSUER_PREFIX !='' and starts-with(b:actualovIssuer,'I-')">
						<xsl:value-of select="concat($ISSUER_PREFIX ,substring-after(b:actualovIssuer,'I-'))"/>
					</xsl:when>
					<xsl:when test="starts-with(b:actualovIssuer,'C-')">
						<xsl:value-of select="substring-after(b:actualovIssuer,'C-')"/>
					</xsl:when>
					<xsl:when test="starts-with(b:actualovIssuer,'I-')">
						<xsl:value-of select="substring-after(b:actualovIssuer,'I-')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:actualovIssuer"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="marketDirectiveCategory_ActualPeSecurity"/>
	<xsl:template name="minimumTradingAmount_ActualPeSecurity">
	<xsl:variable name="Var_SecurityCurrency" select="b:actualsecurityCurrency"/>
		<minimumTradingAmount>
			<xsl:choose>
				<xsl:when test="b:actualminInvtCcyGroup[b:actualminInvtCcy = $Var_SecurityCurrency]">
					<xsl:value-of select="b:actualminInvtCcyGroup[b:actualminInvtCcy = $Var_SecurityCurrency]/b:actualminInitInvt"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</minimumTradingAmount>
	</xsl:template>
	<xsl:template name="referenceIndex_ActualPeSecurity"/>
	<xsl:template name="riskCurrency_ActualPeSecurity">
	<xsl:if test="b:actualriskCcy and b:actualriskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:actualriskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskLevel_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualcompLevelAttribGroup/b:actualcompLevelAttrib = b:actualcoCode">
				<riskLevel>
					<xsl:value-of select="b:actualcompLevelAttribGroup[b:actualcompLevelAttrib = ../b:actualcoCode]/b:actualriskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:actualcompLevelAttribGroup[b:actualcompLevelAttrib = '' or not(b:actualcompLevelAttrib)]/b:actualriskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:actualcompLevelAttribGroup[b:actualcompLevelAttrib = '' or not(b:actualcompLevelAttrib)]/b:actualriskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="roundLotAmount_ActualPeSecurity">
	<xsl:if test="b:actualroundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:actualroundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="stpOrder_ActualPeSecurity">
	<stpOrder>
			<xsl:choose>
				<xsl:when test="b:actualstp='YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</stpOrder>
	</xsl:template>
	<xsl:template name="tradeNature_ActualPeSecurity">
	<tradeNature>
			<xsl:choose>
				<xsl:when test="b:actualtradeNature = 'QUANTITY'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:actualtradeNature = 'AMOUNT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeNature>
	</xsl:template>
	<xsl:template name="votingRights_ActualPeSecurity"/>
	<xsl:template name="witholdingTax_ActualPeSecurity"/>
	<xsl:template name="dividend_ActualPeSecurity"/>
	<xsl:template name="composition_ActualPeSecurity"/>
	<xsl:template name="cutOffTime_ActualPeSecurity">
	<xsl:if test="b:actualcutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:actualcutOffTime"/>
			</cutOffTime>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cutOffTimeZone_ActualPeSecurity">
	<xsl:if test="b:actualcutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:actualcutOffTimeZone"/>
			</cutOffTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference_ActualPeSecurity">
	<xsl:if test="b:actualpeFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:actualcommonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fundIncomeStyleE_ActualPeSecurity">
	<fundIncomeStyleE>
			<xsl:choose>
				<xsl:when test="b:actualfundType = 'GROWTH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:actualfundType = 'DIVIDEND'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fundIncomeStyleE>
	</xsl:template>
	<xsl:template name="redemption_ActualPeSecurity"/>
	<xsl:template name="reinvestmentAllowedF_ActualPeSecurity">
	<reinvestmentAllowedF>
			<xsl:choose>
				<xsl:when test="b:actualreinvestAllowed = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reinvestmentAllowedF>
	</xsl:template>
	<xsl:template name="subNature_ActualPeSecurity">
	<subNature>
			<xsl:choose>
				<xsl:when test="b:actualpeFund = 'YES'">
					<xsl:if test="b:actualpeType= 'INITIAL COMMITMENT'">
						<xsl:value-of select=" '109' "/>
					</xsl:if>
					<xsl:if test="b:actualpeType= 'DRAWDOWN'">
						<xsl:value-of select=" '110' "/>
					</xsl:if>
					<xsl:if test="b:actualpeType= 'CAPITAL CALL'">
						<xsl:value-of select=" '111' "/>
					</xsl:if>
					<xsl:if test="b:actualpeType= 'ACTUAL PE SECURITY'">
						<xsl:value-of select=" '112' "/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:actualetfIndctr = 'YES'">
						<xsl:value-of select=" '108' "/>
					</xsl:if>
					<xsl:if test="b:actualetfIndctr = 'NO' or not(b:actualetfIndctr)">
						<xsl:value-of select=" '0' "/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</subNature>
	</xsl:template>
	<xsl:template name="switchOrderAmt_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualswitchAllowedList/b:actualswitchAllowed = 'ALL' or b:actualswitchAllowedList/b:actualswitchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualswitchAllowedList/b:actualswitchAllowed = 'ALL' or b:actualswitchAllowedList/b:actualswitchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualswitchAllowedList/b:actualswitchAllowed = 'ALL' or b:actualswitchAllowedList/b:actualswitchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="coolCancelF_ActualPeSecurity">
	<coolCancelF>
			<xsl:choose>
				<xsl:when test="b:actualcoolCancelPeriod = '' or not(b:actualcoolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriod_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualcoolCancelPeriod and b:actualcoolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 1, 3)"/>
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
	<xsl:template name="coolPeriodUnit_ActualPeSecurity">
	<xsl:choose>
			<xsl:when test="b:actualcoolCancelPeriod and b:actualcoolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '2'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '3'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(b:actualcoolCancelPeriod) = '4'">
							<xsl:value-of select="substring(b:actualcoolCancelPeriod, 4)"/>
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