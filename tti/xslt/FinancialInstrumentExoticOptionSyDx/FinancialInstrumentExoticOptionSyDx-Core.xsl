<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionSyDx" xmlns:c="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionSyDx" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="code">
		<xsl:choose>
			<xsl:when test="b:tapRefId and b:tapRefId != ''">
			<infra:code>
				<xsl:value-of select="b:tapRefId"/>
			</infra:code>
			</xsl:when>
			<xsl:otherwise>
			<infra:code>
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
			</infra:code>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="synonym">
		<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentExoticOptionSyDx"/>
		</xsl:call-template>
		<xsl:for-each select="b:altIndNameGroup">
			<xsl:if test="b:altIndId and b:altIndId!=''">
				<infra:synonym>
					<infra:code>
						<xsl:value-of select="b:altIndId"/>
					</infra:code>
					<infra:codification>
						<xsl:value-of select="b:altIndName"/>
					</infra:codification>
				</infra:synonym>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="shortName">
		<infra:shortName>
			<xsl:choose>
					<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldNameSubGroup[@index = '1']/b:usrFldVal and b:exoticTypeGroup[@index= '2']/b:usrFldNameSubGroup[@index ='1']/b:usrFldVal) and not(contains(' UIKI UOKO DIKI DOKO ',b:barrierType))"> 
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType,'/',b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal,'/',b:exoticTypeGroup[@index='2']/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)"/>
					</xsl:when>
					<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)">
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType,'/',b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)"/>
					</xsl:when>
					<xsl:when test="b:exoticTypeGroup/b:exoticType">
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1))"/>
					</xsl:otherwise>
				</xsl:choose>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="longName">
      <infra:longName>
		 	<xsl:choose>
					<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal and b:exoticTypeGroup[@index='2']/b:usrFldNameSubGroup[@index='1']/b:usrFldVal) and not(contains(' UIKI UOKO DIKI DOKO ',b:barrierType))">
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType,'/',b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal,'/',b:exoticTypeGroup[@index='2']/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)"/>
					</xsl:when>
					<xsl:when test="(b:exoticTypeGroup/b:exoticType) and (b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)">
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType,'/',b:exoticTypeGroup/b:usrFldNameSubGroup[@index='1']/b:usrFldVal)"/>
					</xsl:when>
					<xsl:when test="b:exoticTypeGroup/b:exoticType">
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1),'/',b:barrierType)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',substring(b:optionStyle,1,1))"/>
					</xsl:otherwise>
				</xsl:choose>
		 </infra:longName>
    </xsl:template>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="mainStockExchange"/>
	<xsl:template name="minimumQuantity">
		<minimumQuantity>
			<xsl:value-of select="b:dxContractMasterJoinDps"/>
		</minimumQuantity>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:value-of select="'27'"/>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="riskCountry">
		<riskCountry>
			<infra:code>
				<xsl:value-of select="b:dxMasterContractJoinRiskCountry"/>
			</infra:code>
		</riskCountry>
	</xsl:template>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tickSize">
		<tickSize>
			<xsl:value-of select="b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize"/>
		</tickSize>
	</xsl:template>
	<xsl:template name="tradable"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetTypeJoinAssetType"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="beginDate">
		<beginDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</beginDate>
	</xsl:template>
	<xsl:template name="category"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="contractMaster">
		<contractMaster>
			<xsl:value-of select="b:contractCode"/>
		</contractMaster>
	</xsl:template>
	<xsl:template name="contractSize">
		<contractSize>
			<xsl:value-of select="format-number((b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickValue) div (b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize),$decimalformat,'nan2zero')"/>
		</contractSize>
	</xsl:template>
	<xsl:template name="exerciseCurrency"/>
	<xsl:template name="expirationDate">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
	</xsl:template>
	<xsl:template name="instrumentClass"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="subNature">
			<xsl:if test="b:barrierType != '' and contains(' DUKI DKIN UIKI DUKO DKOT UOKO DIKI DOKO ',concat(' ',b:barrierType,' '))">
			<subNature>
				<xsl:choose>
					<xsl:when test="b:barrierType = 'DUKI'">126</xsl:when>
					<xsl:when test="b:barrierType = 'DUKO'">127</xsl:when>
					<xsl:when test="b:barrierType = 'DKIN'">128</xsl:when>
					<xsl:when test="b:barrierType = 'DKOT'">129</xsl:when>
					<xsl:when test="b:barrierType = 'UIKI'">130</xsl:when>
					<xsl:when test="b:barrierType = 'UOKO'">131</xsl:when>
					<xsl:when test="b:barrierType = 'DIKI'">132</xsl:when>
					<xsl:when test="b:barrierType = 'DOKO'">133</xsl:when>
				</xsl:choose>
			</subNature>
		</xsl:if>
	</xsl:template>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="averagingNumber"/>
	<xsl:template name="barrier">
		<barrier>
			<xsl:if test="b:exoticTypeGroup/b:usrFldNameSubGroup[b:usrFldName = 'LOWER.RATE' or b:usrFldName = 'SINGLE.BARRIER' or b:usrFldName = 'BARRIER.LEVEL']">
				<xsl:value-of select="b:exoticTypeGroup/b:usrFldNameSubGroup[b:usrFldName = 'LOWER.RATE' or b:usrFldName = 'SINGLE.BARRIER' or b:usrFldName = 'BARRIER.LEVEL']/b:usrFldVal"/>
			</xsl:if>
		</barrier>
	</xsl:template>
	<xsl:template name="barrierNature">
	<xsl:if test="b:exoticTypeGroup/b:usrFldNameSubGroup[b:usrFldName = 'LOWER.RATE' or b:usrFldName = 'SINGLE.BARRIER' or b:usrFldName = 'BARRIER.LEVEL']">
			<xsl:if test="contains( 'CALL PUT',b:optionType)">
				<xsl:if test="b:barrierType != '' and contains(' DUKI DKIN UIKI DUKO DKOT UOKO DIKI DOKO ',concat(' ',b:barrierType,' '))">
					<barrierNature>
						<xsl:choose>
							<xsl:when test="b:barrierType!='' and b:barrierType='UIKI' ">1</xsl:when>
							<xsl:when test="b:barrierType!='' and b:barrierType='UOKO' ">2</xsl:when>
							<xsl:when test="b:barrierType!='' and b:barrierType='DIKI' ">3</xsl:when>
							<xsl:when test="b:barrierType!='' and b:barrierType='DOKO' ">4</xsl:when>
							<xsl:otherwise>
							    <xsl:choose>
								<xsl:when test="b:optionType = 'CALL'">
									<xsl:choose>
										<xsl:when test="b:barrierType != '' and contains(' DUKI DKIN ',concat(' ',b:barrierType,' '))">1</xsl:when>
										<xsl:when test="b:barrierType != '' and contains(' DUKO DKOT ',concat(' ',b:barrierType,' '))">2</xsl:when>
									</xsl:choose>
							    </xsl:when>
								<xsl:when test="b:optionType = 'PUT'">
									<xsl:choose>
										<xsl:when test="b:barrierType != '' and contains(' DUKI DKIN ',concat(' ',b:barrierType,' '))">3</xsl:when>
										<xsl:when test="b:barrierType != '' and contains(' DUKO DKOT ',concat(' ',b:barrierType,' '))">4</xsl:when>
									</xsl:choose>
								</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</barrierNature>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="beginDate1">
		<beginDate>
			<xsl:choose>
				<xsl:when test="string-length(b:eventCommon/ns0:today) ='8'">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="b:eventCommon/ns0:today"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:otherwise>
			</xsl:choose>
		</beginDate>
	</xsl:template>
	<xsl:template name="callPutIndicator">
		<callPutIndicator>
			<xsl:choose>
				<xsl:when test="b:optionType = 'CALL'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:optionType = 'PUT'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
			</xsl:choose>
		</callPutIndicator>
	</xsl:template>
	<xsl:template name="cashSettlement">
		<cashSettlement>
			<xsl:choose>
				<xsl:when test="b:dxContractMasterJoinDeliveryMethod = 'PHYSICAL'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</cashSettlement>
	</xsl:template>
	<xsl:template name="code1"/>
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select=" b:tradeCcy "/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="effectiveLeverage"/>
	<xsl:template name="endDate"/>
	<xsl:template name="endValidityDate"/>
	<xsl:template name="exercisePrice">
		<xsl:if test="b:strikePrice and b:strikePrice != ''">
			<exercisePrice>
				<xsl:value-of select=" b:strikePrice "/>
			</exercisePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="exerciseType">
		<exerciseType>
			<xsl:choose>
				<xsl:when test="b:optionStyle = 'AMERICAN'">1</xsl:when>
				<xsl:when test="b:optionStyle = 'EUROPEAN'">2</xsl:when>
				<xsl:when test="b:optionStyle = 'CARRIBEAN'">3</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</exerciseType>
	</xsl:template>
	<xsl:template name="fixDate"/>
	<xsl:template name="frequency"/>
	<xsl:template name="frequencyUnit"/>
	<xsl:template name="gap"/>
	<xsl:template name="gearing"/>
    <xsl:template name="lowBarrierP_termEvent"/>
	<xsl:template name="maximumValue"/>
	<xsl:template name="minimumValue"/>
	<xsl:template name="payOffNature">
		<payOffNature>
			<xsl:choose>
				<xsl:when test="b:optionVariant = 'BINA'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:optionVariant = 'VANI'">
					<xsl:value-of select=" '2' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</payOffNature>
	</xsl:template>
	<xsl:template name="premiumPaymentRule"/>
	<xsl:template name="protectedDate"/>
	<xsl:template name="rebateAtHit"/>
	<xsl:template name="rebatePayoff"/>
	<xsl:template name="scaleFactor"/>
	<xsl:template name="season"/>
	<xsl:template name="totalQuantity"/>
	<xsl:template name="upperBarrier">
		<xsl:for-each select="b:exoticTypeGroup[contains(b:exoticType, 'UPPER')]">
			<upperBarrier>
				<xsl:if test="b:usrFldNameSubGroup[b:usrFldName = 'HIGHER.RATE' or b:usrFldName = 'BARRIER.LEVEL']">
					<xsl:value-of select="b:usrFldNameSubGroup[b:usrFldName = 'HIGHER.RATE' or b:usrFldName = 'BARRIER.LEVEL']/b:usrFldVal"/>
				</xsl:if>
			</upperBarrier>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="upperBarrierNature">
	<xsl:for-each select="b:exoticTypeGroup[contains(b:exoticType, 'UPPER')]">
		<xsl:if test="b:usrFldNameSubGroup[b:usrFldName = 'HIGHER.RATE' or b:usrFldName = 'BARRIER.LEVEL']">
			<xsl:if test="contains(' CALL PUT ',../b:optionType)">
				<xsl:if test="../b:barrierType != '' and contains(' DUKI DKIN DUKO DKOT ',concat(' ', ../b:barrierType, ' '))">
					<upperBarrierNature>
						<xsl:choose>
							<xsl:when test="../b:optionType = 'CALL'">
								<xsl:choose>
									<xsl:when test="../b:barrierType != '' and contains(' DUKI DKIN ',concat(' ',../b:barrierType,' '))">1</xsl:when>
									<xsl:when test="../b:barrierType != '' and contains(' DUKO DKOT ',concat(' ',../b:barrierType,' '))">2</xsl:when>
								</xsl:choose>
							</xsl:when>
							<xsl:when test="../b:optionType = 'PUT'">
								<xsl:choose>
									<xsl:when test="../b:barrierType != '' and contains(' DUKI DKIN ',concat(' ',../b:barrierType,' '))">3</xsl:when>
									<xsl:when test="../b:barrierType != '' and contains(' DUKO DKOT ',concat(' ',../b:barrierType,' '))">4</xsl:when>
								</xsl:choose>
							</xsl:when>
						</xsl:choose>
					</upperBarrierNature>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="upperBarrierP_termEvent"/>
	<xsl:template name="upperRebate"/>
	<xsl:template name="upperRebateAtHit"/>
	<xsl:template name="underlyingInstrument">
		<xsl:if test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'OTHER'">
			<underlyingInstrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'CASH'">
							<xsl:value-of select="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying"/>
						</xsl:when>
						<xsl:when test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying = 'CASH'">
							<xsl:choose>
								<xsl:when test="b:dlvCcy">
									<xsl:value-of select="b:dlvCcy"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="b:tradeCcy"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</infra:code>
			</underlyingInstrument>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlyingQuantity"/>
	<xsl:template name="mbFields_termEvent"/>
	<xsl:template name="validityDate">
		<validityDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:eventCommon/ns0:today,'-','')"/>
			</xsl:call-template>
		</validityDate>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<xsl:choose>
				<xsl:when test="b:tapRefId and b:tapRefId != ''">
						<infra:code>
							<xsl:value-of select="b:tapRefId"/>
						</infra:code>
				</xsl:when>
				<xsl:otherwise>
						<infra:code>
							<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
						</infra:code>
				</xsl:otherwise>
			</xsl:choose>
		</instrument>
	</xsl:template>
	<xsl:template name="riskLevel">
		<xsl:choose>
			<xsl:when test="b:dxContractMasterJoincompLevelAttribGroup/b:dxContractMasterJoincompLevelAttrib = b:coCode">
				<riskLevel>
					<xsl:value-of select="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = ../b:coCode]/b:dxContractMasterJoinRiskLevelGroup/b:dxContractMasterJoinRiskLevel"/>
				</riskLevel>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = '' or not(b:dxContractMasterJoincompLevelAttrib)]/b:dxContractMasterJoinRiskLevel != ''">
					<riskLevel>
						<xsl:value-of select="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = '' or not(b:dxContractMasterJoincompLevelAttrib)]/b:dxContractMasterJoinRiskLevel"/>
					</riskLevel>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="islamicCompliance">
		<xsl:if test="b:dxContractMasterJoinIslamicCompliance != ''">
			<islamicCompliance>
				<xsl:choose>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'None'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'NO'">
						<xsl:value-of select="'2'"/>
					</xsl:when>
					<xsl:when test="b:dxContractMasterJoinIslamicCompliance = 'YES'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
				</xsl:choose>
			</islamicCompliance>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlying"/>
	<xsl:template name="usageNature">
		<usageNature>
			<xsl:value-of select="'1'"/>
		</usageNature>
	</xsl:template>
	<xsl:template name="barrierTimeZone">
		<xsl:if test="b:exoticTypeGroup/b:usrFldNameSubGroup/b:usrFldName ='DISC.TIME.SOURCE'">
			<barrierTimeZone>
				<xsl:value-of select="b:exoticTypeGroup/b:usrFldNameSubGroup[b:usrFldName ='DISC.TIME.SOURCE']/b:usrFldVal"/>
			</barrierTimeZone>
		</xsl:if>
	</xsl:template>
	<xsl:template name="eventTimeType">
		<xsl:choose>
		<xsl:when test="b:exoticTypeGroup/b:usrFldNameSubGroup/b:usrFldName ='DISC.TIME.SOURCE'">
			<eventTimeType>
				<xsl:value-of select="'2'"/>
			</eventTimeType>
		</xsl:when>
		<xsl:when test="b:exoticTypeGroup/b:usrFldNameSubGroup/b:usrFldName ='CONT.TIME.SOURCE'">
			<eventTimeType>
				<xsl:value-of select="'1'"/> 
			</eventTimeType>
		</xsl:when>
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