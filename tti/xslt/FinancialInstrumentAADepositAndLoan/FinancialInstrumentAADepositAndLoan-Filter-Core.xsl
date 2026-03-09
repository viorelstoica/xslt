<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
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
    <xsl:variable name="list_ArrStatus1" select="' CURRENT EXPIRED PENDING.CLOSURE '"/>
    <xsl:variable name="list_ArrStatus2" select="' AUTH CURRENT EXPIRED PENDING.CLOSURE '"/>
    <xsl:variable name="list_aaArrActivityId" select="' DEPOSITINT-ACCRUAL PRINCIPALINT-ACCRUAL PENALTYINT-ACCRUAL '"/>
    <xsl:variable name="cond1" select="( (c:recarrangement/i:productLine = 'DEPOSITS' and	
                                            (((c:aatxncontext/b:aaArrStatus = 'AUTH' or c:aatxncontext/b:aaArrStatus = 'AUTH-FWD') and $AA_INTERFACE_INPUT_DEALS = 'Y') or 
                                            (c:aatxncontext/b:aaArrStatus = 'CURRENT' and $AA_INTERFACE_INPUT_DEALS = 'N') or 
                                            (c:aatxncontext/b:aaArrStatus = 'EXPIRED' or c:aatxncontext/b:aaArrStatus = 'PENDING.CLOSURE')))
	                                         or  (c:recarrangement/i:productLine = 'LENDING' and 
	                                                (contains(concat(' ',$list_ArrStatus2,' '),concat(' ',c:aatxncontext/b:aaArrStatus,' ')) 
	                                                 or
	                                                  c:aatxncontext/b:aaArrStatus = 'AUTH-FWD' and $AA_INTERFACE_INPUT_DEALS = 'Y'
	                                                )                                         ))         
                                         and c:aatxncontext/b:aaPortfolioId and c:aatxncontext/b:aaPortfolioId != ''  
                                         and not(contains(concat(' ',$list_aaArrActivityId,' '),concat(' ',c:aatxncontext/b:aaArrActivityId,' ')))"/>
    <xsl:apply-templates select="self::node()[$cond1]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:AAAFlow" mode="filter2">
    <xsl:variable name="cond2" select="( ( (c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PR.DEPOSIT' and $AA_INTERFACE_INPUT_DEALS = 'N')  or (c:aaarecord/d:activity = 'DEPOSITS-NEW-ARRANGEMENT' and $AA_INTERFACE_INPUT_DEALS = 'Y') and  ((not(d:txnSystemId) and $AA_INTERFACE_INPUT_DEALS = 'Y') or (c:aaarecord/d:txnSystemId = 'FT') or (c:aaarecord/d:txnSystemId ='AAAA' and c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-NEW-ARRANGEMENT')) )  )"/>
    <xsl:variable name="cond3" select="(   c:aaarecord/d:txnSystemId = 'AAAA' and c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.WITHDRAWAL' and (c:aatxncontext/b:aaMasterActivity =  'DEPOSITS-MATURE-ARRANGEMENT' or c:aatxncontext/b:aaMasterActivity ='DEPOSITS-REDEEM-ARRANGEMENT' or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-MAKEDUE-SCHEDULE') and                                                     (c:billdetails/j:billProperyDetails[starts-with(j:repayRef,c:aatxncontext/b:aaArrActivityId)]/j:property = 'ACCOUNT')  and                                                     c:recarrangement/i:arrStatus = 'EXPIRED' and                                                     (( not(c:aaarecord/d:txnSystemId) or c:aaarecord/d:txnSystemId != 'FT' or ( c:aaarecord/d:txnSystemId = 'FT'                         and (c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.EARLY.WITHDRAWAL' or c:aaarecord/d:activity = 'DEPOSITS-APPLYPAYMENT-PO.WITHDRAWAL')))))"/>
    <xsl:variable name="cond4" select="( c:aatxncontext/b:aaMasterActivity = 'LENDING-NEW-ARRANGEMENT' and ((c:aaarecord/d:txnSystemId = 'AAAA' and c:aaarecord/d:activity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL') or ( not(c:aaarecord/d:txnSystemId) and c:aaarecord/d:activity = 'LENDING-NEW-ARRANGEMENT') ) or ( AaTransactionContext.txnSystemId = 'FT' and (c:aaarecord/d:activity = 'LENDING-DISBURSE-COMMITMENT' or c:aaarecord/d:activity = 'LENDING-AUTO.DISBURSE-COMMITMENT')))"/>
    <xsl:variable name="cond5" select="( c:aaarecord/d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT' and c:recarrangement/i:arrStatus = 'EXPIRED' and                                           ( (c:aaarecord/d:txnSystemId = 'AAAA' and c:aatxncontext/b:aaMasterActivity = 'LENDING-MATURE-ARRANGEMENT') or                                                  (c:aaarecord/d:txnSystemId = 'FT' and c:aaarecord/d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT' and                                                       (c:recarrangement/i:arrStatus = 'CURRENT' or c:recarrangement/i:arrStatus = 'PENDING.CLOSURE') and                                                       c:aatxncontext/b:aaMasterActivity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT')))"/>
    <xsl:variable name="cond6" select="( c:aatxncontext/b:aaMasterActivity = 'LENDING-SETTLE-PAYOFF' and                                                 c:aaarecord/d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL.DECREASE')"/>
    <xsl:variable name="cond7" select="( c:aatxncontext/b:aaMasterActivity = 'LENDING-ROLLOVER-ARRANGEMENT' or c:aatxncontext/b:aaMasterActivity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL' or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-ROLLOVER-ARRANGEMENT' or c:aatxncontext/b:aaMasterActivity = 'LENDING-RENEW-ARRANGEMENT'            or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-RENEW-ARRANGEMENT'           or c:aatxncontext/b:aaMasterActivity = 'LENDING-ISSUEBILL-SCHEDULE*DISBURSEMENT.%'           or c:aatxncontext/b:aaMasterActivity = 'LENDING-MAKEDUE-SCHEDULE'           or c:aatxncontext/b:aaMasterActivity = 'LENDING-MAKEDUE.DISBURSE-SCHEDULE'           or c:aatxncontext/b:aaMasterActivity = 'LENDING-NEW-ARRANGEMENT')"/>
    <xsl:variable name="cond8" select="(substring(c:aaarecord/d:activityClass,string-length(c:aaarecord/d:activityClass) - string-length('UPDATE-TERM.AMOUNT') + 1) = 'UPDATE-TERM.AMOUNT')"/>
    <xsl:apply-templates select="self::node()[$cond2 or $cond3 or $cond4 or $cond5 or $cond6 or $cond7 or $cond8]" mode="filter-custo"/>
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