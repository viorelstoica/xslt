<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentOptionSyDx" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentOptionSyDx"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c d" version="1.0">
	<xsl:template name="infra:code">
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
	<xsl:template name="infra:synonym">
		<xsl:for-each select="b:altIndNameGroup">
			<xsl:if test="b:altIndId">
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
		<xsl:call-template name="OldNewAltDerivativeSynonymManagment">
			<xsl:with-param name="CurrentEvent" select="."/>
			<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentOptionSyDx"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:variable name="Var_optionStyle" select="substring(b:optionStyle,1,1)"/>
			<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',$Var_optionStyle)"/>
		</infra:shortName>
	</xsl:template>
    <xsl:template name="infra:longName">
      <xsl:if test="b:dxContractMasterJoinDescriptList/b:dxContractMasterJoinDescript[@language='GB'] != ''">
         <infra:longName>
		 	<xsl:variable name="Var_optionStyle" select="substring(b:optionStyle,1,1)"/>
			<xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:optionType,'/',b:strikePrice,'/',b:dlvCcy,'/',$Var_optionStyle)"/>
		 </infra:longName>
      </xsl:if>
    </xsl:template>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="contractMaster">
		<contractMaster>
			<xsl:value-of select="b:contractCode"/>
		</contractMaster>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:value-of select="'1'"/>
		</active>
	</xsl:template>
	<xsl:template name="mainStockExchange">
		<mainStockExchange>
			<infra:code>
				<xsl:if test="b:dxContractMasterJoinExchange != ''">
					<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:dxContractMasterJoinExchange)"/>
				</xsl:if>
			</infra:code>
		</mainStockExchange>
	</xsl:template>
	<xsl:template name="minimumQuantity">
		<xsl:if test="b:DxContractMasterJoinDps and b:DxContractMasterJoinDps != ''">
			<minimumQuantity>
				<xsl:value-of select="b:DxContractMasterJoinDps"/>
			</minimumQuantity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:value-of select="'27'"/>
		</priceCalculationRule>
	</xsl:template>
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
	<xsl:template name="subType">
		<subType>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetType"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="tickSize">
		<tickSize>
			<xsl:value-of select="b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize"/>
		</tickSize>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:dxContractMasterJoinSubAssetTypeJoinAssetType"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="callPutIndicator">
		<xsl:if test="b:optionType and b:optionType != ''">
			<callPutIndicator>
				<xsl:choose>
					<xsl:when test="b:optionType = 'CALL'">
						<xsl:value-of select="1"/>
					</xsl:when>
					<xsl:when test="b:optionType = 'PUT'">
						<xsl:value-of select="2"/>
					</xsl:when>
				</xsl:choose>
			</callPutIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cashSettlement">
		<cashSettlement>
			<xsl:choose>
				<xsl:when test="b:dxContractMasterJoinDeliveryMethod = 'PHYSICAL'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="b:dxContractMasterJoinDeliveryMethod != 'PHYSICAL' and b:dxContractMasterJoinDeliveryMethod and b:dxContractMasterJoinDeliveryMethod != ''">
					<xsl:value-of select="0"/>
				</xsl:when>
			</xsl:choose>
		</cashSettlement>
	</xsl:template>
	<xsl:template name="contractSize">
		<contractSize>
			<xsl:value-of select="format-number(b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickValue div b:dxContractMasterJoinTickSizeGroup[position()=last()]/b:dxContractMasterJoinTickSize,'#.###','nan2zero')"/>
		</contractSize>
	</xsl:template>
	<xsl:template name="exerciseCurrency">
		<exerciseCurrency>
			<infra:code>
				<xsl:value-of select="''"/>
			</infra:code>
		</exerciseCurrency>
	</xsl:template>
	<xsl:template name="exerciseType">
		<exerciseType>
			<xsl:choose>
				<xsl:when test="b:optionStyle = 'AMERICAN'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="b:optionStyle = 'EUROPEAN'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="b:optionStyle = 'CARRIBEAN'">
					<xsl:value-of select="3"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</exerciseType>
	</xsl:template>
	<xsl:template name="strikePrice">
		<xsl:if test="b:strikePrice and b:strikePrice != ''">
			<strikePrice>
				<xsl:value-of select="b:strikePrice"/>
			</strikePrice>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underlying">
		<xsl:if test="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'CASH' and b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying != 'OTHER'">
			<underlying>
				<infra:code>
					<xsl:value-of select="b:dxContractMasterJoinUnderlyingGroup/b:dxContractMasterJoinUnderlying"/>
				</infra:code>
			</underlying>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="provider"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="roundLotQuantity"/>
	<xsl:template name="sector"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="beginDate"/>
	<xsl:template name="expirationDate">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
	</xsl:template>
	<xsl:template name="faceValue"/>
	<xsl:template name="instrumentClass"/>
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
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="commonRefernce"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="issuer"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="parentInstrument"/>
	<xsl:template name="subNature"/>
	<xsl:template name="underlyingQuantity"/>
	<xsl:template name="termEvent"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="category"/>
	<xsl:template name="fixingDate"/>
	<xsl:template name="barrier"/>
	<xsl:template name="barrierNature"/>
	<xsl:template name="lowBarrierP"/>
	<xsl:template name="paymentFrequency"/>
	<xsl:template name="paymentFrequencyUnit"/>
	<xsl:template name="upperBarrier"/>
	<xsl:template name="upperBarrierNature"/>
	<xsl:template name="upperBarrierP"/>
	<xsl:template name="usageNature">
		<usageNature>
			<xsl:value-of select="'1'"/>
		</usageNature>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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