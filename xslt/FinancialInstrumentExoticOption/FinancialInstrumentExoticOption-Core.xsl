<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOption" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="code">
		<xsl:variable name="Var_Barrier" select="substring-after(substring-after(b:priceKey,':'),':')"/>
		<xsl:variable name="securityNo">
			<xsl:choose>
				<xsl:when test="$Var_Barrier">
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType,'/',$Var_Barrier)"/>
				</xsl:when>
				<xsl:when test="$Var_Barrier='' and b:optionTypeList/b:optionType">
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<infra:code>
			<xsl:value-of select="$securityNo"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="synonym-custo"/>
	<xsl:template name="synonym">
		<xsl:call-template name="SynonymManagment">
			<xsl:with-param name="structure" select="."/>
		</xsl:call-template>
		<xsl:call-template name="OldNewSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentExoticOption"/>
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
			<xsl:value-of select="b:dxContractMasterJoinShortNameList/b:dxContractMasterJoinShortName[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="longName">
      <xsl:if test="b:dxContractMasterJoinDescriptList/b:dxContractMasterJoinDescript[@language='GB'] != ''">
         <infra:longName>
		 	<xsl:for-each select="b:dxContractMasterJoinDescriptList/b:dxContractMasterJoinDescript[@language='GB']">
				<xsl:value-of select="."/>
			</xsl:for-each>
		 </infra:longName>
      </xsl:if>
    </xsl:template>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad-custo"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
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
			<xsl:choose>
				<xsl:when test="b:dxContractMasterJoinPriceSourceGroup/b:dxContractMasterJoinPriceSource='INTERFACE'">
					<xsl:value-of select="'27'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
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
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tickSize">
		<tickSize>
			<xsl:value-of select="b:dxContractMasterJoinTickSizeGroup/b:dxContractMasterJoinTickSize"/>
		</tickSize>
	</xsl:template>
	<xsl:template name="tradable"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="beginDate"/>
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
			<xsl:value-of select="format-number((b:dxContractMasterJoinTickSizeGroup/b:DxContractMasterJoinTickValue) div (b:dxContractMasterJoinTickSizeGroup/b:dxContractMasterJoinTickSize),$decimalformat,'nan2zero')"/>
		</contractSize>
	</xsl:template>
	<xsl:template name="exerciseCurrency"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="instrumentClass"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="expirationDate">
		<xsl:choose>
			<xsl:when test="string-length(translate(b:maturityDate,'-','')) = '8'">
				<expirationDate>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
					</xsl:call-template>
				</expirationDate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:decDate and b:decDate != ''">
					<expirationDate>
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="translate(b:decDate,'-','')"/>
						</xsl:call-template>
					</expirationDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="subNature">
		<xsl:if test="b:optionTypeList/b:optionType != ' ' and contains('KNOCKIN KNOCKOUT KOKO KIKI KIKO DIGITAL',b:optionTypeList/b:optionType)">
			<subNature>
				<xsl:choose>
					<xsl:when test="b:optionTypeList/b:optionType = 'KNOCKIN'">114</xsl:when>
					<xsl:when test="b:optionTypeList/b:optionType = 'KNOCKOUT'">115</xsl:when>
					<xsl:when test="b:optionTypeList/b:optionType = 'KOKO'">50</xsl:when>
					<xsl:when test="b:optionTypeList/b:optionType = 'KIKI'">92</xsl:when>
					<xsl:when test="b:optionTypeList/b:optionType = 'KIKO'">93</xsl:when>
					<xsl:when test="b:optionTypeList/b:optionType = 'DIGITAL'">88</xsl:when>
				</xsl:choose>
			</subNature>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlying"/>
	<xsl:template name="usageNature"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="averagingNumber"/>
	<xsl:template name="barrier">
		<xsl:variable name="Var_Barrier" select="substring-after(substring-after(b:priceKey,':'),':')"/>
		<barrier>
			<xsl:choose>
				<xsl:when test="contains($Var_Barrier,'/')">
					<xsl:value-of select="substring-before($Var_Barrier,'/')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Var_Barrier"/>
				</xsl:otherwise>
			</xsl:choose>
		</barrier>
	</xsl:template>
	<xsl:template name="barrierNature">
		<xsl:if test="contains( 'CALL PUT',b:callPut)">
			<xsl:if test="b:optionTypeList/b:optionType != ' ' and contains('KNOCKIN KIKO KIKI KOCKOUT KOKO',b:optionTypeList/b:optionType)">
				<barrierNature>
					<xsl:choose>
						<xsl:when test="b:callPut = 'CALL'">
							<xsl:choose>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KNOCKIN KIKO KIKI',b:optionTypeList/b:optionType)">1</xsl:when>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KOCKOUT KOKO',b:optionTypeList/b:optionType)">2</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="b:callPut = 'PUT'">
							<xsl:choose>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KNOCKIN KIKO KIKI',b:optionTypeList/b:optionType)">3</xsl:when>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KOCKOUT KOKO',b:optionTypeList/b:optionType)">4</xsl:when>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</barrierNature>
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
				<xsl:when test="b:callPut = 'CALL'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:when test="b:callPut = 'PUT'">
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
				<xsl:choose>
					<xsl:when test="b:deliveryCcy != ''">
						<xsl:value-of select=" b:deliveryCcy "/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select=" b:tradeCcy "/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="effectiveLeverage"/>
	<xsl:template name="endDate"/>
	<xsl:template name="endValidityDate"/>
	<xsl:template name="exercisePrice">
		<exercisePrice>
			<xsl:value-of select="b:strike"/>
		</exercisePrice>
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
				<xsl:when test="b:optionTypeList/b:optionType = 'DIGITAL'">
					<xsl:value-of select=" '7' "/>
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
		<xsl:variable name="Var_Barrier2" select="substring-after(substring-after(substring-after(b:priceKey,':'),':'),'/') "/>
		<xsl:if test="$Var_Barrier2 != ''">
			<upperBarrier>
				<xsl:value-of select="$Var_Barrier2"/>
			</upperBarrier>
		</xsl:if>
	</xsl:template>
	<xsl:template name="upperBarrierNature">
		<xsl:if test="contains( 'CALL PUT',b:callPut)">
			<xsl:if test="b:optionTypeList/b:optionType != ' ' and contains('KIKO KIKI KOKO',b:optionTypeList/b:optionType)">
				<upperBarrierNature>
					<xsl:choose>
						<xsl:when test="b:callPut = 'CALL'">
							<xsl:choose>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KIKI',b:optionTypeList/b:optionType)">1</xsl:when>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KOKO KIKO',b:optionTypeList/b:optionType)">2</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="b:callPut = 'PUT'">
							<xsl:choose>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KIKI',b:optionTypeList/b:optionType)">3</xsl:when>
								<xsl:when test="b:optionTypeList/b:optionType != ' ' and contains('KIKO KOKO',b:optionTypeList/b:optionType)">4</xsl:when>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</upperBarrierNature>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="upperBarrierP_termEvent"/>
	<xsl:template name="upperRebate"/>
	<xsl:template name="upperRebateAtHit"/>
	<xsl:template name="underlyingInstrument">
		<xsl:choose>
			<xsl:when test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'CASH' and b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'OTHER' ">
				<underlyingInstrument>
					<infra:code>
						<xsl:value-of select="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying"/>
					</infra:code>
				</underlyingInstrument>
			</xsl:when>
			<xsl:when test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying = 'CASH'">
				<xsl:choose>
					<xsl:when test="b:deliveryCcy !='' and b:tradeCcy !='' and b:deliveryCcy!=b:tradeCcy">
						<underlyingInstrument>
							<infra:code>
								<xsl:value-of select="b:deliveryCcy"/>
							</infra:code>
						</underlyingInstrument>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="underlyingQuantity"/>
	<xsl:template name="validityDate">
		<validityDate>
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
		</validityDate>
	</xsl:template>
	<xsl:template name="mbFields_termEvent"/>
	<xsl:template name="instrument">
		<xsl:variable name="Var_Barrier" select="substring-after(substring-after(b:priceKey,':'),':')"/>
		<xsl:variable name="securityNo">
			<xsl:choose>
				<xsl:when test="$Var_Barrier">
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType,'/',$Var_Barrier)"/>
				</xsl:when>
				<xsl:when test="$Var_Barrier='' and b:optionTypeList/b:optionType">
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeList/b:optionType)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<instrument>
			<infra:code>
				<xsl:value-of select="$securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="riskLevel">
		<xsl:choose>
			<xsl:when test="b:dxContractMasterJoincompLevelAttribGroup/b:dxContractMasterJoincompLevelAttrib = b:coCode">
				<riskLevel>
					<xsl:value-of select="b:dxContractMasterJoincompLevelAttribGroup[b:dxContractMasterJoincompLevelAttrib = ../b:coCode]/b:dxContractMasterJoinRiskLevel"/>
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->