<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CashAccount"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCashAccount"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c ns0"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="b:id"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:synonym">
      <xsl:for-each select="b:altAcctTypeGroup">
         <xsl:if test="b:altAcctId and b:altAcctId != ''">
            <infra:synonym>
               <infra:code>
                  <xsl:value-of select="b:altAcctId"/>
               </infra:code>
               <infra:codification>
                  <xsl:value-of select="b:altAcctType"/>
               </infra:codification>
            </infra:synonym>
         </xsl:if>
      </xsl:for-each>
      <xsl:call-template name="OldNewAltAcctSynonymManagment">
         <xsl:with-param name="CurrentEvent" select="."/>
         <xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:CashAccount"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
               <xsl:choose>
                  <xsl:when test="not(b:accountTitle2List/b:accountTitle2[@language = 'GB']) or b:accountTitle2List/b:accountTitle2[@language = 'GB'] = ''">
                     <xsl:value-of select="b:accountTitle1List/b:accountTitle1[@language = 'GB']"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="substring(concat(b:accountTitle1List/b:accountTitle1[@language = 'GB'], '/', b:accountTitle2List/b:accountTitle2[@language = 'GB']),0,50)"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:mnemonic"/>
            </xsl:otherwise>
         </xsl:choose>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currency"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="b:category"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="openingDate">
      <xsl:if test="b:openingDate != ''">
         <openingDate>
            <xsl:value-of select="b:openingDate"/>
         </openingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="closingDate">
      <xsl:if test="b:closureDate != ''">
         <closingDate>
            <xsl:value-of select="b:closureDate"/>
         </closingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="client">
      <client>
         <infra:code>
            <xsl:value-of select="concat($CUSTOMER_PREFIX,b:customer)"/>
         </infra:code>
      </client>
   </xsl:template>
   <xsl:template name="infra:businessEntity">
      <infra:businessEntity>
         <infra:code>
            <xsl:value-of select="b:coCode"/>
         </infra:code>
      </infra:businessEntity>
   </xsl:template>
   <xsl:template name="infra:mainBusinessEntity">
      <infra:mainBusinessEntity>1</infra:mainBusinessEntity>
   </xsl:template>
   <xsl:template name="infra:role">
      <infra:role>0</infra:role>
   </xsl:template>
   <xsl:template name="infra:type">
      <infra:type>
         <infra:code>FILECOMPANY</infra:code>
      </infra:type>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:id"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="suspenseAccount">
	<xsl:param name="IsSuspenseAccountCategoryVar">
			<xsl:call-template name="IsSuspenseAccountCategory">
				<xsl:with-param name="category" select="b:category"/>
			</xsl:call-template>
	</xsl:param>
	<suspenseAccount>
		<xsl:choose>
			<xsl:when test="$IsSuspenseAccountCategoryVar = 'true'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	</suspenseAccount>
   </xsl:template>
   <xsl:template name="infra:longName"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="infra:mbFields_becompo"/>
   <xsl:template name="accrualRule"/>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="accruedInterestUnitaryRounding"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="interestAccrualDate"/>
   <xsl:template name="eomConvention"/>
   <xsl:template name="parentCashAccount"/>
   <xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="(b:portfolioNoList/b:portfolioNo[1] !='') and not(contains(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD'))">
						<xsl:value-of select="b:portfolioNoList/b:portfolioNo[1]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NULL'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>

   <xsl:template name="witholdingTax"/>
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