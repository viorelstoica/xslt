<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow"
                xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec"
                xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec"
                xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec"
                xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a b c d e f g h i j k l"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:choose>
		  	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
		         <xsl:value-of select="c:aatxncontext/b:aaArrangementId"/>
		         <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
		         <xsl:value-of select="c:aatxncontext/b:aaCompanyMnemonic"/>
			</xsl:when>
			<xsl:otherwise>
				 <xsl:value-of select="c:aatxncontext/b:aaArrangementId"/>
			</xsl:otherwise>
		  </xsl:choose>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:synonym">
      <infra:synonym>
         <infra:code>
            <xsl:if test="c:recarrangement/i:linkedAppl/i:linkedAppl = 'ACCOUNT'">
               <xsl:value-of select="c:recarrangement/i:linkedAppl/i:linkedApplId"/>
            </xsl:if>
         </infra:code>
         <infra:codification>AA_CODIFICATION</infra:codification>
      </infra:synonym>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="concat(c:recproduct/e:description,'-',c:recarrangement/i:currency)"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="concat(c:recproduct/e:description,'-',c:recarrangement/i:currency)"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="c:accountrecord/g:portfolioId"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="c:interestrecords/a:dayBasis != ' ' and contains('A A1 A2 A3',c:interestrecords/a:dayBasis)">23</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'B'">31</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'C'">19</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'C2'">20</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'D'">13</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'E'">29</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'E1'">30</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis != ' ' and contains('F F1 F2',c:interestrecords/a:dayBasis)">26</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'G'">0</xsl:when>
            <xsl:when test="c:interestrecords/a:dayBasis = 'S'">0</xsl:when>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="accruedInterestUnitaryRounding"/>
   <xsl:template name="active">
         <active>
            <xsl:choose>
			   <xsl:when test="c:aatxncontext/b:aaActivityStatus = 'REV'">
				  <xsl:value-of select="'0'"/>
			   </xsl:when>		
               <xsl:when test="contains(concat(' ',$list_ArrStatus_Activ,' '),concat(' ',c:aatxncontext/b:aaArrStatus,' ')) or not(c:aatxncontext/b:aaArrStatus)">
                  <xsl:value-of select="'1'"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="'0'"/>
               </xsl:otherwise>
            </xsl:choose>
         </active>
   </xsl:template>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="referenceCurrency">
      <xsl:for-each select="c:recarrangement">
         <referenceCurrency>
            <infra:code>
               <xsl:value-of select="i:currency"/>
            </infra:code>
         </referenceCurrency>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subType">
      <xsl:for-each select="c:recarrangement">
         <subType>
            <infra:code>
               <xsl:value-of select="i:product/i:product"/>
            </infra:code>
         </subType>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
      <xsl:for-each select="c:recarrangement">
         <type>
            <infra:code>
               <xsl:value-of select="i:productGroup"/>
            </infra:code>
         </type>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="valuationRule"/>
   <xsl:template name="noticeDay"/>
   <xsl:template name="provider"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="closingDate">
      <closingDate>
	  	<xsl:choose>
         <xsl:when test="c:recaccountdetails/f:maturityDate and c:recaccountdetails/f:maturityDate != ''">
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="c:recaccountdetails/f:maturityDate"/>
            </xsl:call-template>
         </xsl:when>
		 <xsl:when test="c:recaccountdetails/f:renewalDate and c:recaccountdetails/f:renewalDate != ''">
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="c:recaccountdetails/f:renewalDate"/>
            </xsl:call-template>
         </xsl:when>
		</xsl:choose>
      </closingDate>
   </xsl:template>
   <xsl:template name="interestRate"/>
   <xsl:template name="issuer"/>
   <xsl:template name="nextPayDay"/>
   <xsl:template name="paymentFrequency"/>
   <xsl:template name="paymentFrequencyDay"/>
   <xsl:template name="paymentFrequencyUnit"/>
   <xsl:template name="subNature">
        <subNature>
            <xsl:if test="c:recarrangement/i:productLine = 'DEPOSITS'"> 
	            <xsl:choose>
	             <xsl:when test="c:recaccountdetails/f:reportEndDate and c:recaccountdetails/f:reportEndDate != ''">119</xsl:when>
	             <xsl:otherwise>118</xsl:otherwise>
	            </xsl:choose>                
            </xsl:if>
        </subNature>
   </xsl:template>
   <xsl:template name="tenorFrequency"/>
   <xsl:template name="tenorFrequencyUnit"/>
   <xsl:template name="usageNature"/>
   <xsl:template name="openingDate">
      <openingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="c:recarrangement/i:startDate"/>
         </xsl:call-template>
      </openingDate>
   </xsl:template>
   <xsl:template name="infra:businessEntity">
      <infra:businessEntity>
         <infra:code>
            <xsl:value-of select="c:recarrangement/i:coCode"/>
         </infra:code>
      </infra:businessEntity>
   </xsl:template>
   <xsl:template name="infra:mainBusinessEntity">
      <infra:mainBusinessEntity>
         <xsl:value-of select=" '1' "/>
      </infra:mainBusinessEntity>
   </xsl:template>
   <xsl:template name="infra:role">
      <infra:role>
         <xsl:value-of select=" '0' "/>
      </infra:role>
   </xsl:template>
   <xsl:template name="infra:type">
      <infra:type>
         <infra:code>FILECOMPANY</infra:code>
      </infra:type>
   </xsl:template>
   <xsl:template name="infra:mbFields_becompo"/>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="concat(c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,c:aatxncontext/b:aaCompanyMnemonic)"/>
         </infra:code>
      </instrument>
   </xsl:template>
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