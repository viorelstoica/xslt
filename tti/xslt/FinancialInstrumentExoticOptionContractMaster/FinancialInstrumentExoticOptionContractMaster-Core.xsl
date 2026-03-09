<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentExoticOptionContractMaster"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentExoticOptionContractMaster" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ex="http://exslt.org/dates-and-times" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c ex" version="1.0">
	<xsl:template name="code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="synonym"/>
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
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="active">
		<active>
			<xsl:choose>
				<xsl:when test="b:priceSetGroup/b:priceSet = 'INTERFACE'">
					<xsl:value-of select=" '1' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '0' "/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="mainStockExchange"/>
	<xsl:template name="minimumQuantity"/>
	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:choose>
				<xsl:when test="b:priceSourceGroup/b:priceSource = 'INTERFACE'">
					<xsl:value-of select=" '27' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:priceBasis = 'NORMAL'">
							<xsl:value-of select=" '1' "/>
						</xsl:when>
						<xsl:when test="b:priceBasis = 'INTEREST'">
							<xsl:value-of select=" '2' "/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="provider"/>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="b:currency"/>
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
			<xsl:value-of select="b:tickSizeGroup/b:tickSize"/>
		</tickSize>
	</xsl:template>
	<xsl:template name="tradable">
		<tradable>
			<xsl:choose>
				<xsl:when test="b:priceSetGroup/b:priceSet = 'INTERFACE'">
					<xsl:value-of select=" '0' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '1' "/>
				</xsl:otherwise>
			</xsl:choose>
		</tradable>
	</xsl:template>
	<xsl:template name="type">
	<xsl:if test="b:subAssetTypeJoinAssetTypeCode">
		<type>
			<infra:code>
				<xsl:value-of select="b:subAssetTypeJoinAssetTypeCode"/>
			</infra:code>
		</type>
	</xsl:if>
	</xsl:template>
	<xsl:template name="valuationRule"/>
	<xsl:template name="beginDate"/>
	<xsl:template name="category"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="complexity"/>
	<xsl:template name="complexityLevel"/>
	<xsl:template name="contractMaster"/>
	<xsl:template name="contractSize">
		<contractSize>
			<xsl:value-of select="b:contractSize"/>
		</contractSize>
	</xsl:template>
	<xsl:template name="exerciseCurrency"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="instrumentClass"/>
	<xsl:template name="lastTradeDate"/>
	<xsl:template name="marketDirectiveCategory"/>
	<xsl:template name="subNature"/>
	<xsl:template name="underlying">
	<xsl:if test="b:underlyingGroup/b:underlying != 'CASH' and b:underlyingGroup/b:underlying != 'OTHER' and b:underlyingGroup/b:underlying != 'BASKET'">
		<underlying>
			<infra:code>
				<xsl:value-of select="b:underlyingGroup/b:underlying"/>
			</infra:code>
		</underlying>
	</xsl:if>
	</xsl:template>
	<xsl:template name="yieldCurve"/>
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
	<xsl:template name="usageNature">
		<xsl:if test="b:priceSetGroup/b:priceSet = 'INTERFACE'">
			<xsl:choose>
				<xsl:when test="b:contractTypeJoin = 'FX-OPTION' and b:underlyingGroup/b:underlying = 'CASH'">
					<usageNature>
						<xsl:value-of select=" '5' "/>
					</usageNature>
				</xsl:when>
				<xsl:when test="b:contractTypeJoin = '' or not(b:contractTypeJoin) or b:contractTypeJoin != 'FX-OPTION' and b:underlyingGroup/b:underlying != 'CASH' and b:underlyingGroup/b:underlying != 'BASKET'">
					<usageNature>
						<xsl:value-of select=" '3' "/>
					</usageNature>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
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