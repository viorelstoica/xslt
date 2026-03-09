<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSyContractMaster"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSyContractMaster"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c ns0"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="b:id"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="b:mnemonic"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="b:mnemonic"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="subNature">
		<subNature>
			<xsl:choose>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '152') or (b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='PFWD')">
					<xsl:value-of select=" '94' "/>
				</xsl:when>
				<xsl:when test="($g_filterBySubAssetType='Y' and b:subAssetType = '153') or (b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType='TARKO')">
					<xsl:value-of select=" '95' "/>
				</xsl:when>
			</xsl:choose>
		</subNature>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="beginDate"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="compundingFrequency"/>
   <xsl:template name="compundingFrequencyUnit"/>
   <xsl:template name="endDate"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="genericFlag">
   		<genericFlag>
			<xsl:value-of select="'1'"/>
   		</genericFlag>
   </xsl:template>
   <xsl:template name="issuer"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="parentInstrument"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="referenceCurrency">
         <referenceCurrency>
            <infra:code>
               <xsl:value-of select="b:currency1"/>
            </infra:code>
         </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskLevel">
	<riskLevel>
		<xsl:choose>
			<xsl:when test="b:riskCompanyGroup/b:riskCompany = b:coCode">
				<xsl:value-of select="b:riskCompanyGroup[b:riskCompany=../b:coCode]/b:riskLevel"/>
			</xsl:when>
			<xsl:when test="b:riskCompanyGroup/b:riskCompany = 'ALL'">
				<xsl:value-of select="b:riskCompanyGroup[b:riskCompany='ALL']/b:riskLevel"/>
			</xsl:when>
			<xsl:when test="b:riskCompanyGroup/b:riskCompany = 'NULL' or b:riskCompanyGroup/b:riskCompany = '' or not(b:riskCompanyGroup/b:riskCompany)">
				<xsl:value-of select="b:riskCompanyGroup[b:riskCompany='NULL' or b:riskCompany='' or not(b:riskCompany)]/b:riskLevel"/>
			</xsl:when>
		</xsl:choose>
	</riskLevel>
  </xsl:template>
   <xsl:template name="riskNature"/>
   <xsl:template name="subType">
   		<subType>
			<infra:code>
				<xsl:value-of select="b:subAssetType"/>
			</infra:code>
   		</subType>
   </xsl:template>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="b:assetTypeCode"/>
			</infra:code>
		</type>
   </xsl:template>
   <xsl:template name="underlying">
	    <underlying>
			<infra:code>
				<xsl:value-of select="b:currency2"/>
			</infra:code>
	    </underlying>
  </xsl:template>
  <xsl:template name="usageNature">
        <usageNature>4</usageNature>
  </xsl:template>  
  <xsl:template name="dxContractCode"> 
  <xsl:if test="b:dxContractCode">
  <dxContractCode>
  	<xsl:value-of select="b:dxContractCode"/>
  </dxContractCode>
  </xsl:if>  
  </xsl:template>
   <xsl:template name="valuationRule"/>
   <xsl:template name="category"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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