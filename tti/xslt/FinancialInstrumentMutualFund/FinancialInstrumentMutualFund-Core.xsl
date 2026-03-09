<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">

	<!-- BEG - For input flow FinancialInstrumentSecurity -->
	<xsl:param name="list_SubAssetType" select="'500 501 502 503 505 506 507 508 509 510 511 512 599'"/>
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
	<xsl:template name="infra:userDefinedField">
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
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="riskCurrency">
		<xsl:if test="b:riskCcy and b:riskCcy != ''">
			<riskCurrency>
				<infra:code>
					<xsl:value-of select="b:riskCcy"/>
				</infra:code>
			</riskCurrency>
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
				<xsl:when test="b:statusDate and  b:secStatus = 'SUS' and translate(b:statusDate,'-','') &lt;= translate(b:eventCommon/ns0:today,'-','')">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:blockingDate != ''">
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
		<xsl:if test="b:minInvestmentQty and b:minInvestmentQty != ''">
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
	<xsl:template name="dividendFrequencyNumber">
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
	<xsl:template name="dividendFrequencyUnit">
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
	<xsl:template name="deposit_InstrumentDeposit">
		<deposit>
			<infra:code>
				<xsl:value-of select="b:defaultDepository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="instrument_InstrumentDeposit">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="paymentOptionE_InstrumentDeposit">
		<paymentOptionE>
			<xsl:value-of select="'0'"/>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="faceValue">
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
	<xsl:template name="beginDate"/>
	<xsl:template name="capitalGainTax"/>
	<xsl:template name="issueQuantity"/>
	<xsl:template name="issueQuote"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="referenceIndex"/>
	<xsl:template name="votingRights"/>
	<xsl:template name="witholdingTax"/>
	<xsl:template name="composition"/>
	<xsl:template name="dividend"/>
	<xsl:template name="parentInstrument"/>
	<xsl:template name="redemption"/>
	<xsl:template name="commonReference">
		<xsl:if test="b:peFund = 'YES'">
			<commonReference>
				<xsl:value-of select="b:commonRef"/>
			</commonReference>
		</xsl:if>
	</xsl:template>
	<xsl:template name="coolCancelF">
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
	<xsl:template name="coolPeriod">
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
	<xsl:template name="coolPeriodUnit">
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
	<xsl:template name="cutOffTime">
		<xsl:if test="b:cutOffTime != '' ">
			<cutOffTime>
				<xsl:value-of select="b:cutOffTime"/>
			</cutOffTime>
		</xsl:if>
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
	<xsl:template name="fundIncomeStyleE">
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
	<xsl:template name="reinvestmentAllowedF">
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
	<xsl:template name="subNature">
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
	<xsl:template name="main_InstrumentDeposit"/>
	<xsl:template name="rank_InstrumentDeposit"/>
	<xsl:template name="switchOrderAmt">
		<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'AMOUNT' ">
				<switchOrderAmt>
					<xsl:value-of select="'1'"/>
				</switchOrderAmt>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderPerc">
		<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'PERCENTAGE' ">
				<switchOrderPerc>
					<xsl:value-of select="'1'"/>
				</switchOrderPerc>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="switchOrderUnit">
		<xsl:choose>
			<xsl:when test="b:switchAllowedList/b:switchAllowed = 'ALL' or b:switchAllowedList/b:switchAllowed = 'UNIT' ">
				<switchOrderUnit>
					<xsl:value-of select="'1'"/>
				</switchOrderUnit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="upfrontPayment">
		<upfrontPayment>
			<xsl:choose>
				<xsl:when test="b:upfrontPayment = 'YES' and not(b:upfrontIntAcc)">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</upfrontPayment>
	</xsl:template>
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
	<xsl:template name="deposit_InstrumentDeposit1">
		<deposit>
			<infra:code>
				<xsl:value-of select="b:optionDepository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="instrument_InstrumentDeposit1">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="main_InstrumentDeposit1"/>
	<xsl:template name="paymentOptionE_InstrumentDeposit1">
		<paymentOptionE>
			<xsl:choose>
				<xsl:when test="b:investOptionType = 'CASH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:investOptionType = 'REINVEST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="rank_InstrumentDeposit1"/>
	<xsl:template name="mbFields_InstrumentDeposit1"/>
	<xsl:template name="deposit_InstrumentDeposit2">
		<deposit>
			<infra:code>
				<xsl:value-of select="../b:optionDepository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="instrument_InstrumentDeposit2">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="paymentOptionE_InstrumentDeposit2">
		<paymentOptionE>
			<xsl:choose>
				<xsl:when test="../b:investOptionType = 'CASH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="../b:investOptionType = 'REINVEST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="main_InstrumentDeposit2"/>
	<xsl:template name="rank_InstrumentDeposit2"/>
	<xsl:template name="mbFields_InstrumentDeposit2"/>
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
	<xsl:template name="coolPeriod_MultiEntity">
		<xsl:choose>
			<xsl:when test="d:coolCancelPeriod and d:coolCancelPeriod != ''">
				<coolPeriod>
					<xsl:choose>
						<xsl:when test="string-length(d:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 1, 1)"/>
						</xsl:when>
						<xsl:when test="string-length(d:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 1, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(d:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 1, 3)"/>
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
	<xsl:template name="coolCancelF_MultiEntity">
		<coolCancelF>
			<xsl:choose>
				<xsl:when test="d:coolCancelPeriod = '' or not(d:coolCancelPeriod)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</coolCancelF>
	</xsl:template>
	<xsl:template name="coolPeriodUnit_MultiEntity">
		<xsl:choose>
			<xsl:when test="d:coolCancelPeriod and d:coolCancelPeriod != ''">
				<xsl:variable name="lastCharCoolCancelPeriod">
					<xsl:choose>
						<xsl:when test="string-length(d:coolCancelPeriod) = '2'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 2)"/>
						</xsl:when>
						<xsl:when test="string-length(d:coolCancelPeriod) = '3'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 3)"/>
						</xsl:when>
						<xsl:when test="string-length(d:coolCancelPeriod) = '4'">
							<xsl:value-of select="substring(d:coolCancelPeriod, 4)"/>
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
	<xsl:template name="dataSecuProf_MultiEntity">
		<xsl:if test="d:grpDeptCodeList/d:grpDeptCode != '' and d:grpDeptCodeList/d:grpDeptCode">
			<dataSecuProf>
				<infra:code>
					<xsl:value-of select="d:grpDeptCodeList/d:grpDeptCode"/>
				</infra:code>
			</dataSecuProf>
		</xsl:if>
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
	<xsl:template name="commonReference_MultiEntity"/>
	<xsl:template name="fundIncomeStyleE_MultiEntity"/>
	<xsl:template name="parentInstrument_MultiEntity"/>
	<xsl:template name="redemption_MultiEntity"/>
	<xsl:template name="reinvestmentAllowedF_MultiEntity"/>
	<xsl:template name="switchOrderAmt_MultiEntity"/>
	<xsl:template name="switchOrderPerc_MultiEntity"/>
	<xsl:template name="switchOrderUnit_MultiEntity"/>
	<xsl:template name="upfrontPayment_MultiEntity"/>


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