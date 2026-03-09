<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentAADepositsandLoansIL"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
          <xsl:choose>
		  	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
	         	<xsl:value-of select="concat(b:arrangementId,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
		  	</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:arrangementId"/>
			</xsl:otherwise>
		 </xsl:choose>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:synonym">
      <infra:synonym>
         <infra:code>
            <xsl:if test="b:linkedApplGroup/b:linkedAppl = 'ACCOUNT'">
               <xsl:value-of select="b:linkedApplGroup/b:linkedApplId"/>
            </xsl:if>
         </infra:code>
         <infra:codification>AA_CODIFICATION</infra:codification>
      </infra:synonym>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="concat(b:productDescriptionGroup/b:productDescriptionList/b:productDescription,'-',b:currency)"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="concat(b:productDescriptionGroup/b:productDescriptionList/b:productDescription,'-',b:currency)"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="accrualRule">
      <xsl:if test="contains(b:intDayBasis,'PRINCIPALINT-') or contains(b:intDayBasis,'DEPOSITINT-')">
         <accrualRule>
            <xsl:choose>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'A1'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'A2'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'A3'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'A4'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'C2'">
                  <xsl:value-of select="20"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'E1'">
                  <xsl:value-of select="30"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'F1'">
                  <xsl:value-of select="26"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,2) = 'F2 '">
                  <xsl:value-of select="26"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'G'">
                  <xsl:value-of select="0"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'S'">
                  <xsl:value-of select="0"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'A'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'B'">
                  <xsl:value-of select="31"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'D'">
                  <xsl:value-of select="13"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'C'">
                  <xsl:value-of select="19"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'E'">
                  <xsl:value-of select="29"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'PRINCIPALINT-'),1,1) = 'F'">
                  <xsl:value-of select="26"/>
               </xsl:when>
            </xsl:choose>
            <xsl:choose>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'A1'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'A2'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'A3'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'A4'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'C2'">
                  <xsl:value-of select="20"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'E1'">
                  <xsl:value-of select="30"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'F1'">
                  <xsl:value-of select="26"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,2) = 'F2 '">
                  <xsl:value-of select="26"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'G'">
                  <xsl:value-of select="0"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'S'">
                  <xsl:value-of select="0"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'A'">
                  <xsl:value-of select="24"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'B'">
                  <xsl:value-of select="31"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'D'">
                  <xsl:value-of select="13"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'C'">
                  <xsl:value-of select="19"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'E'">
                  <xsl:value-of select="29"/>
               </xsl:when>
               <xsl:when test="substring(substring-after(b:intDayBasis,'DEPOSITINT-'),1,1) = 'F'">
                  <xsl:value-of select="26"/>
               </xsl:when>
            </xsl:choose>
         </accrualRule>
      </xsl:if>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation">
      <accruedInterestCalculation>1</accruedInterestCalculation>
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
   <xsl:template name="subType">
      <subType>
         <infra:code>
            <xsl:value-of select="b:aaProductList/b:aaProduct"/>
         </infra:code>
      </subType>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="b:productGroup"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="closingDate">
      <xsl:if test="b:aaRenewalDate != '' or b:aaMaturityDate != ''">
         <closingDate>
            <xsl:if test="b:aaRenewalDate != ''">
               <xsl:choose>
                  <xsl:when test="string-length(b:aaRenewalDate) = '8'">
                     <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="b:aaRenewalDate"/>
                     </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:aaRenewalDate"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:if test="(not(b:aaRenewalDate) or b:aaRenewalDate = '') and b:aaMaturityDate != ''">
               <xsl:choose>
                  <xsl:when test="string-length(b:aaMaturityDate) = '8'">
                     <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="b:aaMaturityDate"/>
                     </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="b:aaMaturityDate"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
         </closingDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="openingDate">
      <openingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:startDate) = '8'">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:startDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:startDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </openingDate>
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
            <xsl:value-of select="concat(b:arrangementId,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="infra:mbFields_becompo"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:acPortfolioNoGroup/b:acPortfolioNoList/b:acPortfolioNo"/>
         </infra:code>
      </portfolio>
   </xsl:template>
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
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="noticeDay"/>
   <xsl:template name="provider"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="interestRate"/>
   <xsl:template name="issuer"/>
   <xsl:template name="nextPayDay"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyDay"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="subNature">
        <subNature>
        	<xsl:if test="b:productLine = 'DEPOSITS'">
		        <xsl:choose>
		         <xsl:when test="b:aaReportEndDate and b:aaReportEndDate != ''">119</xsl:when>
		         <xsl:otherwise>118</xsl:otherwise>
		        </xsl:choose>           	
        	</xsl:if>
        </subNature>
   </xsl:template>
   <xsl:template name="tenorFrequency"/>
   <xsl:template name="tenorFrequencyUnit"/>
   <xsl:template name="usageNature"/>
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