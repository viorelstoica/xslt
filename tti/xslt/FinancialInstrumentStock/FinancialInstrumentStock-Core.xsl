<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="beginDate">
		<xsl:if test="b:issueDate != ''">
			<beginDate>
				<xsl:value-of select="b:issueDate"/>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="riskCurrency">
		<xsl:if test="b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueQuantity">
		<xsl:if test="b:totalIssued != ''">
			<issueQuantity>
				<xsl:value-of select="b:totalIssued"/>
			</issueQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="issueQuote">
		<xsl:if test="b:issuePrice != ''">
			<issueQuote>
				<xsl:value-of select="b:issuePrice"/>
			</issueQuote>
		</xsl:if>
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
				<xsl:when test="b:nominalFactor != ''">6</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceTypeJoinPercentage = 'Y'">5</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="1"/>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="faceValue">
		<xsl:choose>
			<xsl:when test="b:nominalFactor != ''">
				<faceValue>
					<xsl:choose>
						<xsl:when test="b:factorType = 'MULTIPLY'">
							<xsl:value-of select="format-number(1 div b:nominalFactor,'#.#########','nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:nominalFactor"/>
						</xsl:otherwise>
					</xsl:choose>
				</faceValue>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:priceTypeJoinPercentage = 'Y'">
					<faceValue>
						<xsl:value-of select="b:parValue"/>
					</faceValue>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="issuer">
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
	<xsl:template name="minimumTradingAmount">
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
	<xsl:template name="roundLotAmount">
		<xsl:if test="b:roundingAmount != '' ">
			<roundLotAmount>
				<xsl:value-of select="b:roundingAmount"/>
			</roundLotAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeNature">
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
	<xsl:template name="taxCountry"/>
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
	<xsl:template name="capitalGainTax"/>
	<xsl:template name="dividendFrequencyNumber"/>
	<xsl:template name="dividendFrequencyUnit"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="referenceIndex"/>
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
	<xsl:template name="cutOffTimeZone">
		<xsl:if test="b:cutOffTimeZone != '' ">
			<cutOffTimeZone>
				<xsl:value-of select="b:cutOffTimeZone"/>
			</cutOffTimeZone>
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
	<xsl:template name="cutOffTime"/>
	<xsl:template name="subNature"/>
	<xsl:template name="votingRights"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="dividend"/>
	<xsl:template name="composition"/>
	<xsl:template name="main"/>
	<xsl:template name="rank"/>
	<xsl:template name="paymentOptionE_InstrumentDeposit"/>
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
	<!--  IPO fields  -->
	<xsl:template name="ipo_currency">
		<currency>
			<infra:code>
				<xsl:value-of select="b:priceCurrency"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="ipo_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ipo_provider"/>
	<xsl:template name="ipo_quotationDate">
		<quotationDate>
			<xsl:call-template name="xsdatetime">
				<xsl:with-param name="date" select="b:ipoStartDate"/>
			</xsl:call-template>
		</quotationDate>
	</xsl:template>
	<xsl:template name="ipo_stockExchange"/>
	<xsl:template name="ipo_value">
		<value>
			<xsl:choose>
				<xsl:when test="b:minOfferPrice">
					<xsl:value-of select="format-number((b:maxOfferPrice + b:minOfferPrice) div 2,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:issueOfferPrice"/>
				</xsl:otherwise>
			</xsl:choose>
		</value>
	</xsl:template>
	<xsl:template name="ipo_valueType">
		<valueType>
			<infra:code>Close_Price</infra:code>
		</valueType>
	</xsl:template>
	<xsl:template name="ipo_valueTermType"/>
	<xsl:template name="ipo_priceCalculationRule"/>
	<xsl:template name="ipo_mbFields"/>
	<!--  Exchange Event -->
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

	<!-- Start RatingAttribution -->
	<xsl:template name="code_RatingAttribution">
		<code>
			<xsl:value-of select="substring-before(.,'.')"/>
		</code>
	</xsl:template>
	<xsl:template name="agency_RatingAttribution">
		<xsl:variable name="curPos" select="../../@index"/>
		<agency>
			<xsl:value-of select="../../../b:agencyIdList/b:agencyId[@index = $curPos]"/>
		</agency>
	</xsl:template>
	<xsl:template name="instrument_RatingAttribution">
	<instrument>
			<infra:code>
				<xsl:value-of select="../../../b:id"/>
			</infra:code>
	</instrument>
	</xsl:template>
	<xsl:template name="validityDate_RatingAttribution"/>
	<xsl:template name="mbFields_RatingAttribution"/>
	<!-- END RatingAttribution-->
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
	<xsl:template name="dataSecuProf_MultiEntity">
		<xsl:if test="d:grpDeptCodeList/d:grpDeptCode != '' and d:grpDeptCodeList/d:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="d:grpDeptCodeList/d:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
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
	<xsl:template name="taxCountry_MultiEntity"/>
	<xsl:template name="tickSize_MultiEntity"/>
	<xsl:template name="tradable_MultiEntity"/>
	<xsl:template name="type_MultiEntity"/>
	<xsl:template name="valuationRule_MultiEntity"/>
	<xsl:template name="beginDate_MultiEntity"/>
	<xsl:template name="capitalGainTax_MultiEntity"/>
	<xsl:template name="cutOffTime_MultiEntity"/>
	<xsl:template name="cutOffTimeZone_MultiEntity"/>
	<xsl:template name="dividendFrequencyNumber_MultiEntity"/>
	<xsl:template name="dividendFrequencyUnit_MultiEntity"/>
	<xsl:template name="eligibleWrapFund_MultiEntity"/>
	<xsl:template name="faceValue_MultiEntity"/>
	<xsl:template name="islamicCompliance_MultiEntity"/>
	<xsl:template name="issueQuantity_MultiEntity"/>
	<xsl:template name="issueQuote_MultiEntity"/>
	<xsl:template name="marketDirectiveCategory_MultiEntity"/>
	<xsl:template name="minimumTradingAmount_MultiEntity"/>
	<xsl:template name="referenceIndex_MultiEntity"/>
	<xsl:template name="riskCurrency_MultiEntity"/>
	<xsl:template name="roundLotAmount_MultiEntity"/>
	<xsl:template name="subNature_MultiEntity"/>
	<xsl:template name="tradeNature_MultiEntity"/>
	<xsl:template name="votingRights_MultiEntity"/>
	<xsl:template name="witholdingTax_MultiEntity"/>
	<xsl:template name="dividend_MultiEntity"/>
	<xsl:template name="composition_MultiEntity"/>


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
	<xsl:template name="mbFields_InstrumentDeposit_IE_MultiEntity"/>
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