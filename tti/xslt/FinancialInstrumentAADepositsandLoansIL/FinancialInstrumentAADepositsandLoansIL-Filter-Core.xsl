<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentAADepositsandLoansIL" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentAADepositsandLoansIL" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentAADepositsandLoansIL" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentAADepositsandLoansIL" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[
                            (contains(concat(' ',$list_ArrStatus_Input_FinancialInstrumentAADepositsandLoansIL,' '),concat(' ',b:arrStatus,' ')) and $AA_INTERFACE_INPUT_DEALS = 'Y') or
                            contains(concat(' ',$list_ArrStatus_Activ_FinancialInstrumentAADepositsandLoansIL,' '),concat(' ',b:arrStatus,' '))  ]" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter1">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[b:productLine = 'DEPOSITS' or b:productLine = 'LENDING']" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter2">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[b:acPortfolioNoGroup/b:acPortfolioNoList/b:acPortfolioNo and b:acPortfolioNoGroup/b:acPortfolioNoList/b:acPortfolioNo != '']" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter3">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[not(b:dealerBookList/b:dealerBook)]" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter4">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[b:memoAccountFlagList/b:memoAccountFlag = 'NO']" mode="filter5"/>
  </xsl:template>
  <!-- Condition 6 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter5">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL[b:customerTypeGroup/b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter6"/>
  </xsl:template>
  <!-- Condition 7 -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter6">
    <xsl:variable name="custoCondition">
      <xsl:call-template name="aaCustoAdditionalSelectionCriteria"/>
    </xsl:variable>
    <xsl:apply-templates select="self::node()[$custoCondition = '1']" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter-custo">
    <xsl:apply-templates select="self::b:FinancialInstrumentAADepositsandLoansIL" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:FinancialInstrumentAADepositsandLoansIL" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="FinancialInstrumentAADepositsandLoansIL" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentAADepositsandLoansIL\FinancialInstrumentAADepositsandLoansIL.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentAADepositsandLoansIL\FinancialInstrumentAADepositsandLoansILCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
