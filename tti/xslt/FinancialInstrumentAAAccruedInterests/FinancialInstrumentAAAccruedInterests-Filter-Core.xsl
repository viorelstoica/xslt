<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns="http://www.odcgroup.com/FiPMS" 
                xmlns:infra="http://www.odcgroup.com/InfraPMS" 
                xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" 
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" 
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" 
                xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" 
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" 
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" 
                xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" 
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" 
                xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" 
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" 
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" 
                xmlns:ms="urn:schemas-microsoft-com:xslt" 
                xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" 
                version="1.0" exclude-result-prefixes="a b c d e f g h i j k l ns11">
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
    <xsl:apply-templates select="self::c:AAAFlow[$custoCondition = '1']" mode="filter1"/>
  </xsl:template>
  <!-- Condition 2 -->
  <xsl:template match="c:AAAFlow" mode="filter1">
    <xsl:apply-templates select="self::c:AAAFlow[c:intaccrualrecords/k:currAccrual/k:toDate]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:AAAFlow" mode="filter2">
    <xsl:variable name="principalIntId" select="concat(c:aatxncontext/b:aaArrangementId, '-PRINCIPALINT')"/>
    <xsl:variable name="penaltyIntId" select="concat(c:aatxncontext/b:aaArrangementId, '-PENALTYINT')"/>
    <xsl:variable name="depositIntId" select="concat(c:aatxncontext/b:aaArrangementId, '-DEPOSITINT')"/>
    
    <xsl:variable name="cond1" select="
            (c:aatxncontext/b:aaMasterActivity = 'LENDING-ACCRUE-PRINCIPALINT' 

            and (
                 not(c:intaccrualrecords[k:intAccrualId = $penaltyIntId ]) 
                 or 
                 c:intaccrualrecords[k:intAccrualId = $penaltyIntId ] and 
                    (
	                    c:intaccrualrecords[k:intAccrualId = $penaltyIntId ]/k:currAccrual/k:toDate = c:aaarecord/d:effectiveDate 
	                    or
	                    not (c:intaccrualrecords[k:intAccrualId = $penaltyIntId ]/k:totalAccrual/k:periodEnd > c:aaarecord/d:effectiveDate or
	                           not(c:intaccrualrecords[k:intAccrualId = $penaltyIntId ]/k:totalAccrual/k:periodEnd))
                    )
		        ) 
            )
            or
            (c:aatxncontext/b:aaMasterActivity = 'LENDING-ACCRUE-PENALTYINT'
            and (

                        c:intaccrualrecords[k:intAccrualId = $principalIntId ]/k:currAccrual/k:toDate = c:aaarecord/d:effectiveDate 
                        or
                        not (c:intaccrualrecords[k:intAccrualId = $principalIntId ]/k:totalAccrual/k:periodEnd > c:aaarecord/d:effectiveDate or
                                not(c:intaccrualrecords[k:intAccrualId = $principalIntId ]/k:totalAccrual/k:periodEnd))
                ) 
            )           

            or
            (
            c:aatxncontext/b:aaMasterActivity = 'LENDING-ACCRUE-PENALTYINT' and
            c:intaccrualrecords[k:intAccrualId = $principalIntId ] and
             c:intaccrualrecords[k:intAccrualId = $penaltyIntId ] and 
             c:recarrangement/i:arrStatus = 'EXPIRED'    
            )
            or
            c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-ACCRUE-DEPOSITINT'
          
       "/>
    <xsl:apply-templates select="self::c:AAAFlow[$cond1]" mode="filter3"/>
  </xsl:template>
  <!-- Condition 4 -->
  <xsl:template match="c:AAAFlow" mode="filter3">

    <xsl:apply-templates select="self::c:AAAFlow[c:accountrecord/g:portfolioId != '']" mode="filter4"/>
  </xsl:template>
  <!-- Condition 5 -->
  <xsl:template match="c:AAAFlow" mode="filter4">
    <xsl:variable name="list_auth" select="' AUTH CURRENT AUTH-FWD EXPIRED '"/>
    <xsl:variable name="cond4" select="contains($list_auth,concat('',c:recarrangement/i:arrStatus,''))                             "/>
    <xsl:apply-templates select="self::c:AAAFlow[$cond4]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-small.xml" htmlbaseurl=""
		          outputurl="..\..\AUTO_TEST\AA\AAFlow_msgAAInterest\BatchAAAFlow-smallFilter.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template match="/"></template>
			<template match="@* | node()"></template>
			<template match="c:intaccrualrecords"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
