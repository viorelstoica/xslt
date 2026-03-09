<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts"
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyImf"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <infra:code>
         <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'L') "/>
      </infra:code>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName">
      <infra:shortName>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'LOAN') "/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="longName">
      <infra:longName>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'LOAN') "/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="genericFlag">
      <genericFlag>
         <xsl:value-of select=" '0' "/>
      </genericFlag>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="b:loanDayBasis != ' ' and contains('A A1 A2 A3',b:dayBasis)">
               <xsl:value-of select=" '24' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis = 'B'">
               <xsl:value-of select=" '31' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis != ' ' and contains('C C1',b:dayBasis)">
               <xsl:value-of select=" '19' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis = 'C2'">
               <xsl:value-of select=" '20' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis = 'D'">
               <xsl:value-of select=" '13' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis = 'E'">
               <xsl:value-of select=" '29' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis = 'E1'">
               <xsl:value-of select=" '30' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis != ' ' and contains('F F1 F2',b:dayBasis)">
               <xsl:value-of select=" '26' "/>
            </xsl:when>
            <xsl:when test="b:loanDayBasis != ' ' and contains('G S W W1',b:dayBasis)">
               <xsl:value-of select=" '0' "/>
            </xsl:when>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="beginDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="endDate">
      <endDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </endDate>
   </xsl:template>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:loanInt"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select=" '1' "/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:depositCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subNature">
      <subNature>
         <xsl:value-of select=" '99' "/>
      </subNature>
   </xsl:template>
   <xsl:template name="riskLevel"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type"/>
   <xsl:template name="underlying"/>
   <xsl:template name="valuationRule">
      <valuationRule>
         <xsl:value-of select=" '1' "/>
      </valuationRule>
   </xsl:template>
   <xsl:template name="category"/>
   <xsl:template name="convertInterest"/>
   <xsl:template name="fixingCurrency"/>
   <xsl:template name="knockInDate"/>
   <xsl:template name="knockOutDate"/>
   <xsl:template name="usageNature"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
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