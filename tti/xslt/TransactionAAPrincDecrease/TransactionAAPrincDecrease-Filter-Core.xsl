<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"  version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">

	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="c:aaarecord">
	<xsl:variable name="var_aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/>
		   <xsl:if test="(d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL.DECREASE' or d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT'  or d:activity = 'LENDING-APPLYPAYMENT-PR.CURRENT.BALANCES')
		   				and ../c:accountrecord/g:portfolioId != ''  and ../c:aatxncontext/b:aaArrStatus != 'PENDING.CLOSURE' and ../c:aatxncontext/b:aaArrStatus != 'EXPIRED'
		   				and  ../c:aatxncontext/b:aaMasterActivity != 'LENDING-SETTLE-PAYOFF' 
		   				and (not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV') 
						and ((../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId)]) 
						or (../c:ftrecord and ../c:ftrecord/l:amountDebited != '') or (../c:intaccrualrecords[k:intAccrualId = concat(../c:aatxncontext/b:aaArrangementId, '-', 'PRINCIPALINT')]/k:totalAccrual[k:periodStart &lt; ../../c:aaarecord/d:effectiveDate 
                            and (not(k:periodEnd) or k:periodEnd &gt;= ../../c:aaarecord/d:effectiveDate)]/k:totRpyAmt) or (../c:intaccrualrecords[k:intAccrualId = concat(../c:aatxncontext/b:aaArrangementId, '-', 'PRINCIPALINT')]/k:totalAccrual[k:periodStart &lt; ../../c:aaarecord/d:effectiveDate 
                            and (not(k:periodEnd) or k:periodEnd &gt;= ../../c:aaarecord/d:effectiveDate)]/k:totRpyAmt))">
         <xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-small.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-smallFilter.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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