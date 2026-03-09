<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDepositsOldNew" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDepositsOldNew" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew">
    <xsl:variable name="NewInterestRate">
      <xsl:choose>
        <xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:newIntRateList/b:newIntRate !=''">
          <xsl:value-of select="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:newIntRateList/b:newIntRate"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select=" '' "/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:newIntRateList/b:newIntRate != '' and b:newIntRateList/b:newIntRate != $NewInterestRate]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter1">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:intRateType = '1' or b:intRateType = '5']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter2">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:cusPortId != '']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter3">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:memoAccount = 'NO']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter4">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:dealerBook = '' or not(b:dealerBook)]" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter5">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter6">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:status = 'CUR']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter-custo">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="c:CurrentEvent/b:LdLoansAndDepositsOldNew" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Condition 1 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:intRateType = '1' or b:intRateType = '5']" mode="filter1p"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter1p">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:cusPortId != '']" mode="filter2p"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter2p">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:memoAccount = 'NO']" mode="filter3p"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter3p">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:dealerBook = '' or not(b:dealerBook)]" mode="filter4p"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter4p">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter5p"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter5p">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew[b:status = 'CUR']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter-custo">
    <xsl:apply-templates select="self::b:LdLoansAndDepositsOldNew" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="c:PreviousEvent/b:LdLoansAndDepositsOldNew" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Currency" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Currency\Currency.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Currency\CurrencyGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="CurrencyMarket" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CurrencyMarket\CurrencyMarket.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CurrencyMarket\CurrencyMarketGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="yes" name="FinancialInstrumentDiscountInstrument" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentDiscountInstrument\FinancialInstrumentDiscountInstrument.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentDiscountInstrument\FinancialInstrumentDiscountInstrumentCusto.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
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
		<scenario default="no" name="FinancialInstrumentSector" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentSector\FinancialInstrumentSector.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentSector\FinancialInstrumentSector_T24.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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
		<scenario default="no" name="Stock" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Stock\Stock.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Stock\StockGWP.xml" processortype="saxon8" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
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
