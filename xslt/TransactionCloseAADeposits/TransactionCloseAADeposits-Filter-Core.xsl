<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="c:AAAFlow">
    <xsl:variable name="custoCondition">
      <xsl:call-template name="aaCustoAdditionalSelectionCriteria"/>
    </xsl:variable>
    <xsl:apply-templates select="self::node()[$custoCondition = '1']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:AAAFlow" mode="filter1">
    <xsl:variable name="list_aaMasterActivity" select="' DEPOSITS-MATURE-ARRANGEMENT DEPOSITS-REDEEM-ARRANGEMENT DEPOSITS-MAKEDUE-SCHEDULE DEPOSITS-WITHDRAW-PO.EARLY.WITHDRAWAL '"/>
    <xsl:variable name="var_aaArrActivityId" select="c:aatxncontext/b:aaArrActivityId"/>
    <xsl:variable name="cond01" select=" c:aaarecord/d:txnSystemId = 'AAAA'
                                         and (	(c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.WITHDRAWAL' 
                                         			and c:eventCommon/ns0:application = 'AA.ARR.CLOSURE'
                                         	     ) or 
                                         		c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.PRINCIPAL' or
                                         		c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.EARLY.WITHDRAWAL')
                                         and contains($list_aaMasterActivity,concat(' ',c:aatxncontext/b:aaMasterActivity,' '))
                                         and (c:billdetails/j:billProperyDetails[starts-with(j:repayRef,$var_aaArrActivityId)]/j:property = 'ACCOUNT'
                                              or (c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.EARLY.WITHDRAWAL'
                                              		and c:aaarecord/d:initiationType != 'TRANSACTION'
                                              	)
                                             )
                                         
                                         "/>
    <xsl:variable name="cond02" select="( c:aaarecord/d:txnSystemId = 'FT'
                                         and (c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.EARLY.WITHDRAWAL' or 
                                                    c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.WITHDRAWAL' or 
                                                    c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.PRINCIPAL')
                                         and (c:recarrangement/i:arrStatus = 'PENDING.CLOSURE' or c:recarrangement/i:arrStatus = 'CURRENT')                                 )"/>
    <xsl:variable name="cond03" select="(c:accountrecord/g:portfolioId and (not(c:aatxncontext/b:aaActivityStatus) or c:aatxncontext/b:aaActivityStatus != 'REV'))"/>
    <xsl:apply-templates select="self::node()[($cond01 or $cond02) and $cond03]" mode="filter-custo"/>
  </xsl:template>   
  <xsl:template match="c:AAAFlow" mode="filter-custo">
    <xsl:apply-templates select="self::node()" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="c:AAAFlow" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-small.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-smallFilter.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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