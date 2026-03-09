<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/StockExchange"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiStockExchange"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c"
                version="1.0">
   <xsl:template name="code">
      <code>
         <xsl:if test="b:id != ''">
            <xsl:value-of select="concat($STOCKEXCH_PREFIX,b:id)"/>
         </xsl:if>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:shortDescrList/b:shortDescr"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </longName>
   </xsl:template>
   <xsl:template name="multilingualLongName">
      <xsl:for-each select="b:descriptionList/b:description">
         <multilingualLongName>
            <language>
               <xsl:call-template name="languageTranslation">
                  <xsl:with-param name="boLanguage" select="@language"/>
                  <xsl:with-param name="defaultReturn" select="'en'"/>
               </xsl:call-template>
            </language>
            <longName>
               <xsl:value-of select="."/>
            </longName>
         </multilingualLongName>
      </xsl:for-each>
      <xsl:call-template name="OldNewDenomManagment">
         <xsl:with-param name="CurrentEvent" select="./b:descriptionList/b:description"/>
         <xsl:with-param name="PreviousEvent"
                         select="../../c:PreviousEvent/b:StockExchange/b:descriptionList/b:description"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="residGeo">
      <xsl:if test="b:calcCountry != ''">
         <residGeo>
            <code>
               <xsl:value-of select="b:calcCountry"/>
            </code>
         </residGeo>
      </xsl:if>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="calendar">
      <xsl:if test="b:calcCountry != ''">
         <calendar>
            <xsl:value-of select="concat(b:calcCountry,'00')"/>
         </calendar>
      </xsl:if>
   </xsl:template>
   <xsl:template name="currency">
      <currency>
         <code>
            <xsl:value-of select="b:countryJoinCurrencyCodeList/b:countryJoinCurrencyCode"/>
         </code>
      </currency>
   </xsl:template>
   <xsl:template name="marketVenueType">
      <marketVenueType>
         <xsl:choose>
            <xsl:when test="b:mifidCompliant = 'Yes'">
               <xsl:value-of select=" '1' "/>
            </xsl:when>
            <xsl:when test="b:mifidCompliant = 'No'">
               <xsl:value-of select=" '2' "/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select=" '0' "/>
            </xsl:otherwise>
         </xsl:choose>
      </marketVenueType>
   </xsl:template>
   <xsl:template name="closeTime">
   	<xsl:if test="b:cutOffTime and b:cutOffTime != ''">
   		<closeTime>
			<xsl:choose>
				<xsl:when test="string-length(b:cutOffTime) = '5'">
					<xsl:value-of select="concat(b:cutOffTime,':00')"/>
				</xsl:when>
				<xsl:when test="string-length(b:cutOffTime) = '8'">
					<xsl:value-of select="b:cutOffTime"/>
				</xsl:when>
			</xsl:choose>
		</closeTime>
   	</xsl:if>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="notepad"/>
   <xsl:template name="referenceIndex"/>
   <xsl:template name="type"/>
   <xsl:template name="cashSettlementDays">
			<xsl:if test="b:settlementDaysGroup/b:settlementDays and b:settlementDaysGroup/b:settlementDays != ''">
				<cashSettlementDays>
					<xsl:value-of select="b:settlementDaysGroup/b:settlementDays"/>
				</cashSettlementDays>
			</xsl:if>
	</xsl:template>
	<xsl:template name="securitiesSettlementDays">
			<xsl:if test="b:settlementDaysGroup/b:settlementDays and b:settlementDaysGroup/b:settlementDays != ''">
				<securitiesSettlementDays>
					<xsl:value-of select="b:settlementDaysGroup/b:settlementDays"/>
				</securitiesSettlementDays>
			</xsl:if>
	</xsl:template>
	<xsl:template name="settlementDaysRule">
		<settlementDaysRule>
			<xsl:choose>
				<xsl:when test="b:settDaysBasis = 'FIXED'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:settDaysBasis = 'BUSINESS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:settDaysBasis = 'CALENDAR'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</settlementDaysRule>
	</xsl:template>
	<xsl:template name="dataSecuProf"/>
</xsl:stylesheet>