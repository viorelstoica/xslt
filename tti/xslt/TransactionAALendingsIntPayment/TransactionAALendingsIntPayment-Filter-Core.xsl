<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec"
                xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec"
                xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec"
                xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
    <!-- This is not a field template but a template used to fetch a certain type of interest, used to compute variables below -->
    <xsl:template name="paidBackInterest"> 
        <xsl:param name="interestType"/>
        <xsl:variable name = "repayAmount" 
         select="../c:intaccrualrecords[k:intAccrualId = concat(../c:aatxncontext/b:aaArrangementId, '-', $interestType)]/k:totalAccrual[k:periodStart &lt; ../../c:aaarecord/d:effectiveDate 
                            and (not(k:periodEnd) or k:periodEnd &gt;= ../../c:aaarecord/d:effectiveDate)]/k:totRpyAmt"/>
        <xsl:choose>
            <xsl:when test="$repayAmount">
                <xsl:value-of select="$repayAmount"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'0'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  end interest fetching template  -->       	
	<xsl:template match="c:aaarecord">
		<xsl:variable name="aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/>
		<xsl:variable name="var_billId">
			<xsl:value-of select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
		</xsl:variable>
		<xsl:variable name="list_auth" select="'PENDING.CLOSURE CURRENT'"/>
        <xsl:variable name="paidBackPrincipalInterest">
          <xsl:call-template name="paidBackInterest">
              <xsl:with-param name="interestType">PRINCIPALINT</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>         
        <xsl:choose>
            <xsl:when test="(d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT') or (d:activity = 'LENDING-APPLYPAYMENT-PR.INTEREST') and (../c:recaccountdetails/f:actRepayment[starts-with(f:repayReference,$aaArrActivityId)]/f:rpyBillId != '')">
                <xsl:if test="../c:billdetails/j:billProperyDetails[j:property = 'PRINCIPALINT' and starts-with(j:repayRef,$aaArrActivityId)]">
                    <xsl:if test="contains('AUTH CURRENT AUTH-FWD EXPIRED PENDING.CLOSURE',../c:recarrangement/i:arrStatus)">
                        <xsl:if test="not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV'">
                            <xsl:copy-of select="."/>
                        </xsl:if>
                    </xsl:if>
                </xsl:if>
            </xsl:when>
            <xsl:when test="d:activity = 'LENDING-SETTLE-PAYOFF'">
                <xsl:if test="(../c:aatxncontext/b:aaMasterActivity = 'LENDING-SETTLE-PAYOFF') and (../c:billdetails/j:aaBillId = $var_billId) and (../c:accountrecord/g:portfolioId != '')                                        and (contains($list_auth,../c:recarrangement/i:arrStatus))                                        and (not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV') ">
                    <xsl:copy-of select="."/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.CURRENT.BALANCES' and $paidBackPrincipalInterest > 0">
                <xsl:if test="not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV'">
                    <xsl:copy-of select="."/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\Users\sridharb\Downloads\DocumentedExample\20180907_155931_070_132_msgin_AAAFlow_435ebb2e-1223-43dc-9235-5f2bdc54f365.xml" htmlbaseurl=""
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