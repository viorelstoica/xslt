<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- Condition 1 -->
  <xsl:template match="c:AAAFlow">
    <xsl:variable name="custoCondition">
      <xsl:call-template name="aaCustoAdditionalSelectionCriteria"/>
    </xsl:variable>
    <xsl:apply-templates select="self::c:AAAFlow[$custoCondition = '1']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:AAAFlow" mode="filter1">
    <xsl:apply-templates select="self::c:AAAFlow[                      (c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.WITHDRAWAL'
                        or c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.INTEREST' )]" mode="filter2"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter2">
    <xsl:variable name="MASTERAAA" select="c:aaarecord/d:masterAaa"/>
    <xsl:variable name="BILLID" select="c:recaccountdetails/f:actBillDetails[f:activityRef = $MASTERAAA 
                                                                                 and f:billId = ../../c:billdetails[j:billProperyDetails/j:property = 'DEPOSITINT']/j:aaBillId]/f:billId"/>
    <xsl:apply-templates select="self::c:AAAFlow[c:billdetails[j:aaBillId = $BILLID]/j:aaBillId = c:recaccountdetails/f:actBillDetails/f:billId]" mode="filter3"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter3">
    <xsl:variable name="MASTERAAA" select="c:aaarecord/d:masterAaa"/>
    <xsl:variable name="BILLID" select="c:recaccountdetails/f:actBillDetails[f:activityRef = $MASTERAAA 
                                                                                 and f:billId = ../../c:billdetails[j:billProperyDetails/j:property = 'DEPOSITINT']/j:aaBillId]/f:billId"/>
    <xsl:apply-templates select="self::c:AAAFlow[c:billdetails[j:aaBillId = $BILLID]/j:billProperyDetails/j:property = 'DEPOSITINT' ]" mode="filter4"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter4">
    <xsl:variable name="MASTERAAA" select="c:aaarecord/d:masterAaa"/>
    <xsl:variable name="BILLID" select="c:recaccountdetails/f:actBillDetails[f:activityRef = $MASTERAAA 
                                                                                 and f:billId = ../../c:billdetails[j:billProperyDetails/j:property = 'DEPOSITINT']/j:aaBillId]/f:billId"/>
    <xsl:variable name="arrangement" select="c:aaarecord/d:arrangement"/>
    <xsl:apply-templates select="self::c:AAAFlow[format-number(  (c:billdetails[j:aaBillId = $BILLID][j:arrangementId=$arrangement]/j:billProperyDetails[j:property = 'DEPOSITINT']/j:orPropAmount) - (c:billdetails[j:aaBillId = $BILLID][j:arrangementId=$arrangement]/j:billProperyDetails[j:property = 'DEPOSITINT']/j:osPropAmount) , $decimalformat,'nan2zero') != 0]" mode="filter5"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter5">
    <xsl:apply-templates select="self::c:AAAFlow[c:accountrecord/g:portfolioId != '']" mode="filter6"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter6">
    <xsl:apply-templates select="self::c:AAAFlow[contains($list_auth_TransactionAADepositInterestPayment,c:recarrangement/i:arrStatus) ]" mode="filter7"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter7">
    <xsl:apply-templates select="self::c:AAAFlow[not(c:aatxncontext/b:aaActivityStatus) or c:aatxncontext/b:aaActivityStatus != 'REV']" mode="filter8"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter8">
    <xsl:variable name="var_aaArrActivityId" select="c:aatxncontext/b:aaArrActivityId"/>
    <xsl:apply-templates select="self::c:AAAFlow[c:billdetails[j:billProperyDetails[starts-with(j:repayRef,$var_aaArrActivityId)]]]" mode="filter-custo"/>
  </xsl:template>
  <xsl:template match="c:AAAFlow" mode="filter-custo">
    <xsl:apply-templates select="self::c:AAAFlow" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="c:AAAFlow" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" htmlbaseurl="" outputurl="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter_Pavan.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\TestFiles\AAAFlowFilter\AAAFlowFilter.xml" srcSchemaRoot="AAAFlow" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/"></template>
			<template name="mappingFinancialInstrumentAADepositAndLoan"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
