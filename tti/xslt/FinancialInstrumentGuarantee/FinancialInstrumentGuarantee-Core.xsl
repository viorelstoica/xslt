<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentGuarantee"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b "
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(b:dealNo,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:status = 'CUR'">
               <xsl:value-of select="concat(b:dealNo,' ', b:alternateId)"/>
            </xsl:when>
            <xsl:when test="b:status = 'EXP'">
               <xsl:value-of select="concat(b:dealNo,' ', b:alternateId,'(Exp)')"/>
            </xsl:when>
            <xsl:when test="b:status = 'LIQ'">
               <xsl:value-of select="concat(b:dealNo,' ', b:alternateId,'(Mat)')"/>
            </xsl:when>
         </xsl:choose>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:choose>
            <xsl:when test="b:contractType = 'CL'">
               <xsl:value-of select="concat(b:dealNo,' ', b:alternateId,' ', b:reference1)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(b:dealNo,' ', b:alternateId,' ', b:reference2)"/>
            </xsl:otherwise>
         </xsl:choose>
      </infra:longName>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:choose>
            <xsl:when test="b:status = 'CUR' or b:status = 'EXP'">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>
      </active>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currency"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="subType">
      <subType>
         <infra:code>
            <xsl:value-of select="concat(b:dealSubType,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
         </infra:code>
      </subType>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat(b:contractType,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="maturityDate">
      <maturityDate>
         <xsl:choose>
            <xsl:when test="substring(b:maturityDate,1,4) = '9999'">
               <xsl:call-template name="mdate">
                  <xsl:with-param name="date" select="b:maturityDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="b:maturityDate">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:maturityDate"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </maturityDate>
   </xsl:template>
   <xsl:template name="nature">
      <nature>17</nature>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="minimumQuantity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="provider"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="sector"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tickSize"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="accrualRule"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="accruedInterestUnitaryRounding"/>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="capitalGainTax"/>
   <xsl:template name="complexity"/>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="contractSize"/>
   <xsl:template name="couponFrequencyNumber"/>
   <xsl:template name="couponFrequencyUnit"/>
   <xsl:template name="effectiveMaturityDate"/>
   <xsl:template name="eomConvention"/>
   <xsl:template name="faceValue"/>
   <xsl:template name="firstCouponDate"/>
   <xsl:template name="firstExDate"/>
   <xsl:template name="interestAccrualDate"/>
   <xsl:template name="interestRate"/>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="issuedAmount"/>
   <xsl:template name="issueDate"/>
   <xsl:template name="issuedPrice"/>
   <xsl:template name="issuer"/>
   <xsl:template name="lastCouponDate"/>
   <xsl:template name="lastTradeDate"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="maturityPrice"/>
   <xsl:template name="subNature"/>
   <xsl:template name="witholdingTax"/>
   <xsl:template name="votingRights"/>
   <xsl:template name="composition"/>
   <xsl:template name="coupon"/>
   <xsl:template name="dividend"/>
   <xsl:template name="interestSchedule"/>
   <xsl:template name="rating"/>
   <xsl:template name="riskLevel"/>
   <xsl:template name="yieldCurve"/>
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