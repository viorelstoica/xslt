<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <xsl:if test="not(b:tapRefId)">
          <infra:shortName>
             <xsl:value-of select="concat('FD',$COMPANY_POSTFIX_SEPARATOR,b:fidType,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
          </infra:shortName>
      </xsl:if>     
   </xsl:template>
   <xsl:template name="infra:longName">
      <xsl:if test="not(b:tapRefId)">  
          <infra:longName>
             <xsl:value-of select="concat('FD',$COMPANY_POSTFIX_SEPARATOR,b:fidType,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
          </infra:longName>
      </xsl:if>      
   </xsl:template>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="b:intDayBasis = 'A'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'A1'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'A2'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'A3'">
               <xsl:value-of select="'24'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'B'">
               <xsl:value-of select="'31'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'C'">
               <xsl:value-of select="'19'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'C2'">
               <xsl:value-of select="'20'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'D'">
               <xsl:value-of select="'13'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'E'">
               <xsl:value-of select="'29'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'E1'">
               <xsl:value-of select="'30'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'F'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'F1'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'F2'">
               <xsl:value-of select="'26'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'G'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:when test="b:intDayBasis = 'S'">
               <xsl:value-of select="'0'"/>
            </xsl:when>
            <xsl:otherwise/>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation">
      <accruedInterestCalculation>
         <xsl:value-of select=" '1' "/>
      </accruedInterestCalculation>
   </xsl:template>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currencyCode"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature">
      <riskNature>
         <xsl:value-of select=" '2' "/>
      </riskNature>
   </xsl:template>
   <xsl:template name="valuationRule">
  	  <valuationRule>3</valuationRule>
   </xsl:template>
   <xsl:template name="noticeDay">
      <xsl:if test="string-length(b:maturityDate) &lt; 8">
         <noticeDay>
            <xsl:value-of select="b:maturityDate"/>
         </noticeDay>
      </xsl:if>
   </xsl:template>
   <xsl:template name="closingDate">
      <xsl:if test="string-length(b:maturityDate) &gt;= 8">
         <closingDate>
            <xsl:choose>
               <xsl:when test="string-length(b:maturityDate) = 8">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:maturityDate"/>
                  </xsl:call-template>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:maturityDate"/>
               </xsl:otherwise>
            </xsl:choose>
         </closingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:interestRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="openingDate">
      <openingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:valueDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:valueDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </openingDate>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="accruedInterestUnitaryRounding"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
       <type>
           <infra:code>
               <xsl:value-of select="b:category"/>
           </infra:code>
       </type>         
   </xsl:template>
   <xsl:template name="provider"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="portfolio"/>
   <xsl:template name="issuer">
	<issuer>
		<infra:code>
			<xsl:value-of select="b:fidBank"/>
		</infra:code>
	</issuer>
   </xsl:template>
   <xsl:template name="nextPayDay"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyDay"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="subNature">
	<subNature>
		<xsl:choose>
			<xsl:when test="b:fidType = 'NOTICE'">
				<xsl:value-of select="'116'"/>
			</xsl:when>
			<xsl:when test="b:fidType = 'FIXED'">
				<xsl:value-of select="'117'"/>
			</xsl:when>
		</xsl:choose>
	</subNature>
   </xsl:template>
   <xsl:template name="tenorFrequency"/>
   <xsl:template name="tenorFrequencyUnit"/>
   <xsl:template name="usageNature"/>
</xsl:stylesheet>