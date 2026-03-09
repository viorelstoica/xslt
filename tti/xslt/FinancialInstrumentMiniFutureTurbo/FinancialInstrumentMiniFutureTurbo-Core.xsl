<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0 d e f g" version="1.0" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:d="http://www.temenos.com/T24/event/TTI/FinancialInstrumentME" xmlns:e="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentME"
                xmlns:f="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentME" xmlns:g="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentME">

	<!-- BEG - For input flow FinancialInstrumentSecurity -->
	<xsl:template name="code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="synonym-custo"/>
	<xsl:template name="synonym">
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
	<xsl:template name="shortName">
		<infra:shortName>
			<xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="longName">
		<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
				</xsl:for-each>
			</infra:longName>
		</xsl:if>
	</xsl:template>
	<xsl:template name="multilingualLongName">
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
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentFixedIncome/b:descriptList/b:descript"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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
				<xsl:when test="not(b:blockingDate) or b:blockingDate = '' ">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="beginDate">
		<xsl:variable name="todayDate" select="translate(b:eventCommon/ns0:today,'-','')"/>
		<beginDate>
			<xsl:choose>
				<xsl:when test="b:issueDate = '' or not(b:issueDate)">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate($todayDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(b:issueDate,'-','')"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</beginDate>
	</xsl:template>
	<xsl:template name="commonReference"/>
	<xsl:template name="endDate">
		<xsl:if test="b:maturityDate and b:maturityDate != ''">
			<endDate>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="issuer"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:if test="b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="priceCalculationRule">
		<xsl:if test="b:priceType != ''">
			<priceCalculationRule>
				<xsl:choose>
					<xsl:when test="b:priceType = 'BOND'">2</xsl:when>
					<xsl:when test="b:priceType = '0'">1</xsl:when>
					<xsl:when test="b:priceType = 'DBOND'">2</xsl:when>
					<xsl:when test="b:priceType = 'DISCO'">8</xsl:when>
					<xsl:when test="b:priceType = 'UNIT'">1</xsl:when>
					<xsl:when test="b:priceType = 'YIELD'">21</xsl:when>
					<xsl:when test="b:priceType != ''">4</xsl:when>
				</xsl:choose>
			</priceCalculationRule>
		</xsl:if>
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
	<xsl:template name="riskNature"/>
	<xsl:template name="settlementFrequency"/>
	<xsl:template name="settlementFrequencyUnit"/>
	<xsl:template name="subNature">
		<subNature>
			<xsl:value-of select=" '74' "/>
		</subNature>
	</xsl:template>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry"/>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="knockOutDate">
		<xsl:if test="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType = 'KNOCK.OUT']/b:prTriggerDate and b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType = 'KNOCK.OUT']/b:prTriggerDate != ''">
			<knockOutDate>
				<xsl:value-of select="b:underlyingGroup/b:priceBarrierTypeSubGroup[b:priceBarrierType = 'KNOCK.OUT']/b:prTriggerDate"/>
			</knockOutDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlyingCategory">
		<underlyingCategory>
			<xsl:choose>
				<xsl:when test="b:worstOf = 'YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="b:underlyingGroup/b:weight = '100'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</underlyingCategory>
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
	<xsl:template name="minimumQuantity">
		<xsl:if test="b:minInvestmentQty != ''">
			<minimumQuantity>
				<xsl:value-of select="b:minInvestmentQty"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>

	<!-- BEG - termEvent -->
	<xsl:template name="averagingNumber_termEvent"/>
	<xsl:template name="barrier_termEvent">
		<xsl:for-each select="b:underlyingGroup/b:priceBarrierTypeSubGroup">
			<xsl:if test="b:priceBarrierType = 'STOP.LOSS.PRICE'">
				<barrier>
					<xsl:value-of select="b:notePriceBarrier"/>
				</barrier>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="barrierNature_termEvent">
		<barrierNature>
			<xsl:choose>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '166') or ($g_filterBySubAssetType='N' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='MINIFUTTURBO1')">
					<xsl:value-of select=" '4' "/>
				</xsl:when>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '167') or ($g_filterBySubAssetType='N' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='MINIFUTTURBO2')">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
			</xsl:choose>
		</barrierNature>
	</xsl:template>
	<xsl:template name="beginDate_termEvent">
		<xsl:if test="b:issueDate and b:issueDate != ''">
			<beginDate>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="translate(b:issueDate,'-','')"/>
				</xsl:call-template>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="callPutIndicator_termEvent">
		<callPutIndicator>
			<xsl:value-of select=" '1' "/>
		</callPutIndicator>
	</xsl:template>
	<xsl:template name="cashSettlement_termEvent">
		<cashSettlement>
			<xsl:value-of select=" '0' "/>
		</cashSettlement>
	</xsl:template>
	<xsl:template name="code_termEvent"/>
	<xsl:template name="currency_termEvent"/>
	<xsl:template name="effectiveLeverage_termEvent">
		<xsl:if test="b:effectiveLeverage and b:effectiveLeverage != ''">
			<effectiveLeverage>
				<xsl:value-of select="translate(b:effectiveLeverage,'X','')"/>
			</effectiveLeverage>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate_termEvent">
		<xsl:if test="b:maturityDate and b:maturityDate != ''">
			<endDate>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endValidityDate_termEvent"/>
	<xsl:template name="exercisePrice_termEvent">
		<xsl:for-each select="b:underlyingGroup/b:priceBarrierTypeSubGroup">
			<xsl:if test="b:priceBarrierType = 'STRIKE.PRICE'">
				<exercisePrice>
					<xsl:value-of select="b:notePriceBarrier"/>
				</exercisePrice>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="exerciseType_termEvent">
		<exerciseType>
			<xsl:value-of select=" '1' "/>
		</exerciseType>
	</xsl:template>
	<xsl:template name="fixDate_termEvent"/>
	<xsl:template name="frequency_termEvent"/>
	<xsl:template name="frequencyUnit_termEvent"/>
	<xsl:template name="gap_termEvent"/>
	<xsl:template name="gearing_termEvent">
		<xsl:if test="b:leverage and b:leverage != ''">
			<gearing>
				<xsl:value-of select="translate(b:leverage,'X','')"/>
			</gearing>
		</xsl:if>
	</xsl:template>
	<xsl:template name="maximumValue_termEvent"/>
	<xsl:template name="minimumValue_termEvent"/>
	<xsl:template name="payOffNature_termEvent">
		<payOffNature>
			<xsl:choose>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '166') or ($g_filterBySubAssetType='N' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='MINIFUTTURBO1')">
					<xsl:value-of select=" '9' "/>
				</xsl:when>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '167') or ($g_filterBySubAssetType='N' and b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='MINIFUTTURBO2')">
					<xsl:value-of select=" '8' "/>
				</xsl:when>
			</xsl:choose>
		</payOffNature>
	</xsl:template>
	<xsl:template name="premiumPaymentRule_termEvent"/>
	<xsl:template name="protectedDate_termEvent"/>
	<xsl:template name="rebateAtHit_termEvent">
		<rebateAtHit>
			<xsl:value-of select=" '1' "/>
		</rebateAtHit>
	</xsl:template>
	<xsl:template name="rebatePayoff_termEvent"/>
	<xsl:template name="scaleFactor_termEvent"/>
	<xsl:template name="season_termEvent"/>
	<xsl:template name="totalQuantity_termEvent"/>
	<xsl:template name="upperBarrier_termEvent"/>
	<xsl:template name="upperBarrierNature_termEvent"/>
	<xsl:template name="upperRebate_termEvent"/>
	<xsl:template name="upperRebateAtHit_termEvent"/>
	<xsl:template name="underlyingInstrument_termEvent">
		<underlyingInstrument>
			<infra:code>
				<xsl:choose>
				<xsl:when test="b:underlyingGroup/b:underlying and b:underlyingGroup/b:underlying != ''">
					<xsl:value-of select="b:underlyingGroup/b:underlying"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:underlyingGroup/b:otherUnderlying"/>
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</underlyingInstrument>
	</xsl:template>
	<xsl:template name="underlyingQuantity_termEvent"/>
	<xsl:template name="validityDate_termEvent">
		<xsl:variable name="todayDate" select="translate(b:eventCommon/ns0:today,'-','')"/>
		<validityDate>
			<xsl:choose>
				<xsl:when test="b:issueDate = '' or not(b:issueDate)">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate($todayDate,'-','')"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(b:issueDate,'-','')"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</validityDate>
	</xsl:template>
	<xsl:template name="instrument_termEvent">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="lowBarrierP_termEvent"/>
	<xsl:template name="upperBarrierP_termEvent"/>
	<xsl:template name="mbFields_termEvent"/>
	<xsl:template name="initialFixingPrice_termEvent">
		<xsl:if test="b:underlyingGroup/b:weight = '100' and not(b:worstOf = 'YES')">
			<initialFixingPrice>
				<xsl:value-of select="b:underlyingGroup/b:spotPrice"/>
			</initialFixingPrice>
		</xsl:if>
	</xsl:template>
	<!-- END - termEvent -->

	<!-- BEG - ChronologicalData -->
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
	<!-- END - ChronologicalData -->

	<!-- BEG - Composition -->
	<xsl:template name="basketBarrier_Composition">
		<xsl:if test="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:notePriceBarrier and ../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:notePriceBarrier != ''">
			<basketBarrier>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:notePriceBarrier"/>
			</basketBarrier>
		</xsl:if>
	</xsl:template>
	<xsl:template name="basketBarrierPercent_Composition">
		<xsl:if test="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:pricePercentage and ../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:pricePercentage != ''">
			<basketBarrierPercent>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'BARRIER']/b:pricePercentage"/>
			</basketBarrierPercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="basketExcercicePrice_Composition">
		<xsl:if test="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:notePriceBarrier and ../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:notePriceBarrier != ''">
			<basketExcercicePrice>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:notePriceBarrier"/>
			</basketExcercicePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="basketExcercicePricePercent_Composition">
		<xsl:if test="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:pricePercentage and ../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:pricePercentage != ''">
			<basketExcercicePricePercent>
				<xsl:value-of select="../b:priceBarrierTypeSubGroup[b:priceBarrierType = 'STRIKE.PRICE']/b:pricePercentage"/>
			</basketExcercicePricePercent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="basketInitialFixingPrice_Composition">
		<xsl:if test="../b:spotPrice and ../b:spotPrice != ''">
			<basketInitialFixingPrice>
				<xsl:value-of select="../b:spotPrice"/>
			</basketInitialFixingPrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="basketWeight_Composition">
		<basketWeight>
			<xsl:value-of select="."/>
		</basketWeight>
	</xsl:template>
	<xsl:template name="cheapest_Composition">
		<cheapest>
			<xsl:value-of select="'0'"/>
		</cheapest>
	</xsl:template>
	<xsl:template name="compositeInstrument_Composition">
		<compositeInstrument>
			<infra:code>
				<xsl:value-of select="../b:underlying"/>
			</infra:code>
		</compositeInstrument>
	</xsl:template>
	<xsl:template name="conversionFactor_Composition"/>
	<xsl:template name="conversionRatio_Composition"/>
	<xsl:template name="divisor_Composition"/>
	<xsl:template name="endDate_Composition"/>
	<xsl:template name="instrument_Composition">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="rank_Composition">
		<rank>
			<xsl:value-of select="'1'"/>
		</rank>
	</xsl:template>
	<xsl:template name="validityDate_Composition">
		<validityDate>
			<xsl:value-of select="../../b:eventCommon/ns0:today"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="value_Composition">
		<value>
			<xsl:value-of select="'1'"/>
		</value>
	</xsl:template>
	<xsl:template name="mbFields_Composition"/>
	<!-- END - Composition -->
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
	<xsl:template name="code_MultiEntity">
		<infra:code>
			<xsl:value-of select="d:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active_MultiEntity">
		<active>
			<xsl:choose>
				<xsl:when test="not(d:blockingDate) or d:blockingDate = '' ">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
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
	<xsl:template name="synonym-custo_MultiEntity"/>
	<xsl:template name="synonym_MultiEntity"/>
	<xsl:template name="shortName_MultiEntity"/>
	<xsl:template name="longName_MultiEntity"/>
	<xsl:template name="multilingualLongName_MultiEntity"/>
	<xsl:template name="notepad_MultiEntity"/>
	<xsl:template name="userDefinedField-custo_MultiEntity"/>
	<xsl:template name="userDefinedField_MultiEntity"/>
	<xsl:template name="mbFields_MultiEntity"/>
	<xsl:template name="beginDate_MultiEntity"/>
	<xsl:template name="commonReference_MultiEntity"/>
	<xsl:template name="endDate_MultiEntity"/>
	<xsl:template name="euroConversionDate_MultiEntity"/>
	<xsl:template name="euroConversionRule_MultiEntity"/>
	<xsl:template name="euroNewInstrument_MultiEntity"/>
	<xsl:template name="islamicCompliance_MultiEntity"/>
	<xsl:template name="issuer_MultiEntity"/>
	<xsl:template name="knockOutDate_MultiEntity"/>
	<xsl:template name="mainBusinessEntity_MultiEntity"/>
	<xsl:template name="mainStockExchange_MultiEntity"/>
	<xsl:template name="marketDirectiveCategory_MultiEntity"/>
	<xsl:template name="minimumQuantity_MultiEntity"/>
	<xsl:template name="priceCalculationRule_MultiEntity"/>
	<xsl:template name="referenceCurrency_MultiEntity"/>
	<xsl:template name="riskCountry_MultiEntity"/>
	<xsl:template name="riskNature_MultiEntity"/>
	<xsl:template name="settlementFrequency_MultiEntity"/>
	<xsl:template name="settlementFrequencyUnit_MultiEntity"/>
	<xsl:template name="subNature_MultiEntity"/>
	<xsl:template name="subType_MultiEntity"/>
	<xsl:template name="taxCountry_MultiEntity"/>
	<xsl:template name="tradable_MultiEntity"/>
	<xsl:template name="type_MultiEntity"/>
	<xsl:template name="underlyingCategory_MultiEntity"/>
	<xsl:template name="valuationRule_MultiEntity"/>
	<!-- END - For input flow FinancialInstrumentME -->
</xsl:stylesheet>