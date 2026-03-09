<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Customer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomer" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
  <xsl:template name="code">
    <code>
      <xsl:if test="b:id != ''">
        <xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
      </xsl:if>
    </code>
  </xsl:template>
  <xsl:template name="shortName">
    <shortName>
      <xsl:choose>
        <xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
          <xsl:value-of select="b:shortNameList/b:shortName[@language=$boDefaultLanguage]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="b:mnemonic"/>
        </xsl:otherwise>
      </xsl:choose>
    </shortName>
  </xsl:template>
  <xsl:template name="longName">
    <longName>
      <xsl:choose>
        <xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
          <xsl:value-of select="concat(b:name1List/b:name1[@language='GB'],b:name2List/b:name2[@language='GB'])"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="b:mnemonic"/>
        </xsl:otherwise>
      </xsl:choose>
    </longName>
  </xsl:template>
  <xsl:template name="multilingualLongName">
    <xsl:if test="$MAP_SENSITIVE_DATA = 'Y'">
      <xsl:for-each select="b:name1List/b:name1">
        <xsl:variable name="currentLanguage" select="@language"/>
        <multilingualLongName>
          <language>
            <xsl:call-template name="languageTranslation">
              <xsl:with-param name="boLanguage" select="@language"/>
            </xsl:call-template>
          </language>
          <longName>
            <xsl:value-of select="concat(.,../../b:name2List/b:name2[@language = $currentLanguage])"/>
          </longName>
        </multilingualLongName>
      </xsl:for-each>
      <xsl:variable name="currentEvent" select="."/>
      <xsl:for-each select="../../c:PreviousEvent/b:Customer/b:name1List/b:name1[not(./@language= $currentEvent/b:name1List/b:name1/@language)]">
        <xsl:variable name="previousLanguage" select="@language"/>
        <multilingualLongName mode="delete">
          <language>
            <xsl:call-template name="languageTranslation">
              <xsl:with-param name="boLanguage" select="$previousLanguage"/>
            </xsl:call-template>
          </language>
          <longName>
            <xsl:value-of select="concat(.,../../b:name2List/b:name2[@language = $previousLanguage])"/>
          </longName>
        </multilingualLongName>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="userDefinedField"/>
  <xsl:template name="mbFields"/>
  <xsl:template name="beginDate">
    <xsl:if test="b:customerSince != '' and b:customerSince">
      <beginDate>
        <xsl:value-of select="b:customerSince"/>
      </beginDate>
    </xsl:if>
  </xsl:template>
  <xsl:template name="active">
    <active>1</active>
  </xsl:template>
  <xsl:template name="businessEntityComposition">
    <xsl:if test="b:companyBook and b:companyBook!=''">
      <businessEntityComposition>
        <businessEntity>
          <code>
            <xsl:value-of select="b:companyBook"/>
          </code>
        </businessEntity>
        <mainBusinessEntity>1</mainBusinessEntity>
        <role>0</role>
        <type>
          <code>BOOKCOMPANY</code>
        </type>
      </businessEntityComposition>
    </xsl:if>
    <xsl:if test="b:coCode and b:coCode!=''">
      <businessEntityComposition>
        <businessEntity>
          <code>
            <xsl:value-of select="b:coCode"/>
          </code>
        </businessEntity>
        <mainBusinessEntity>0</mainBusinessEntity>
        <role>0</role>
        <type>
          <code>FILECOMPANY</code>
        </type>
      </businessEntityComposition>
    </xsl:if>
  </xsl:template>
  <xsl:template name="currency">
    <currency>
      <code>
        <xsl:value-of select="b:customerCurrencyList/b:customerCurrency"/>
      </code>
    </currency>
  </xsl:template>
  <xsl:template name="emailAddress">
    <xsl:if test="$MAP_SENSITIVE_DATA = 'Y'">
	<xsl:choose>
		<xsl:when test="b:phone1Group[@index='1']/b:email1 != '' and b:phone1Group[@index='1']/b:email1">
			<emailAddress>
          		<xsl:value-of select="b:phone1Group[@index='1']/b:email1"/>
      		</emailAddress>
		</xsl:when>
		<xsl:otherwise>
			<emailAddress>
          		<xsl:value-of select="'NULL'"/>
      		</emailAddress>
		</xsl:otherwise>
	</xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="faxNumber">
  	<xsl:if test="$MAP_SENSITIVE_DATA = 'Y'">
  	<xsl:choose>
		<xsl:when test="b:fax1List/b:fax1[@index='1'] != '' and b:fax1List/b:fax1[@index='1']">
			<faxNumber>
          		<xsl:value-of select="b:fax1List/b:fax1[@index='1']"/>
      		</faxNumber>
		</xsl:when>
		<xsl:otherwise>
			<faxNumber>
          		<xsl:value-of select="'NULL'"/>
      		</faxNumber>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:if>
  </xsl:template>
  <xsl:template name="language">
    <language>
      <xsl:call-template name="languageTranslation">
        <xsl:with-param name="boLanguage" select="b:languageMnemonic"/>
        <xsl:with-param name="defaultReturn" select="''"/>
      </xsl:call-template>
    </language>
  </xsl:template>
  <xsl:template name="phoneNumber">
  	<xsl:if test="$MAP_SENSITIVE_DATA = 'Y'">
  	<xsl:choose>
		<xsl:when test="b:phone1Group[@index='1']/b:phone1 != '' and b:phone1Group[@index='1']/b:phone1">
			<phoneNumber>
          		<xsl:value-of select="b:phone1Group[@index='1']/b:phone1"/>
      		</phoneNumber>
		</xsl:when>
		<xsl:otherwise>
			<phoneNumber>
          		<xsl:value-of select="'NULL'"/>
      		</phoneNumber>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:if>
  </xsl:template>
  <xsl:template name="rating">
  		<xsl:if test="b:ratingDescGroup/b:ratingDescList/b:ratingDesc">
			<xsl:call-template name="RatingManagment">
				<xsl:with-param name="structure" select="."/>
				<xsl:with-param name="application" select="'CUSTOMER'"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
  <xsl:template name="residenceCountry">
  	<xsl:choose>
		<xsl:when test="b:residence != '' and b:residence">
			<residenceCountry>
        		<code>
          		<xsl:value-of select="b:residence"/>
        		</code>
      		</residenceCountry>
		</xsl:when>
		<xsl:otherwise>
			<residenceCountry>
        		<code>
          		<xsl:value-of select="'NULL'"/>
        		</code>
      		</residenceCountry>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
  <xsl:template name="sector">
      <xsl:if test="$isCstShared = 'Y' or not(contains($nonCustomerFieldDefinitions, b:sector))">
		    <xsl:if test="not(../../c:PreviousEvent/b:Customer/b:target) or ../../c:PreviousEvent/b:Customer/b:target != b:target">
		      <sector>
		        <code>
		          <xsl:value-of select="b:target"/>
		        </code>
		        <codification>T24_TP_INDUSTRY</codification>
		      </sector>
		    </xsl:if>
	   </xsl:if>
  </xsl:template>
  <xsl:template name="taxationCountry">
  	<xsl:choose>
		<xsl:when test="b:domicile != '' and b:domicile">
			<taxationCountry>
        		<code>
          		<xsl:value-of select="b:domicile"/>
        		</code>
      		</taxationCountry>
		</xsl:when>
		<xsl:otherwise>
			<taxationCountry>
        		<code>
          		<xsl:value-of select="'NULL'"/>
        		</code>
      		</taxationCountry>
		</xsl:otherwise>
	</xsl:choose> 
  </xsl:template>
  <xsl:template name="type">
    <xsl:if test="not(contains($nonCustomerFieldDefinitions, b:sector))">
	    <type>
	    	<code>
				<xsl:value-of select="b:sector"/>
				<xsl:if test="not($isCstShared = 'Y')">
	        	<xsl:value-of select="concat($COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
				</xsl:if>
	      	</code>
        </type>
	</xsl:if>
  </xsl:template>
  <xsl:template name="clientRole"/>
  <xsl:template name="classification"/>
  <xsl:template name="custodianRole"/>
  <xsl:template name="dataSecuProf"/>
  <xsl:template name="externalBank"/>
  <xsl:template name="synonym"/>
	<xsl:template name="notepad-custo"/>
  <xsl:template name="notepad"/>
  <xsl:template name="userDefinedField-custo"/>
  <xsl:template name="intermediaryRole"/>
  <xsl:template name="islamicCompliance"/>
  <xsl:template name="issuerRole"/>
  <xsl:template name="riskCountry"/>
  <xsl:template name="thirdPartyGroup"/>
  <xsl:template name="manager">
    <manager>
      <code>
        <xsl:value-of select="b:accountOfficer"/>
      </code>
    </manager>
  </xsl:template>
  <xsl:template name="mappingChronologicalData"/>
</xsl:stylesheet>