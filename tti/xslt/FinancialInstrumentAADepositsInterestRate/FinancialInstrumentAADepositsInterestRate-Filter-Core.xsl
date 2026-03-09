<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
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
    <xsl:variable name="cond01" select="contains($list_idComp2_FinancialInstrumentAADepositsInterestRate,concat(' ',c:interestrecords/a:idComp2,' '))
                                        and c:interestrecords/a:rateTierType = 'SINGLE'
                                        and (not(c:interestrecords/a:intRateDetails/a:periodicIndex) or c:interestrecords/a:intRateDetails/a:periodicIndex = '')
                                        and c:accountrecord/g:portfolioId                                                    
                                        and (  
                                              (contains($list_Input_FinancialInstrumentAADepositsInterestRate,concat(' ',c:aatxncontext/b:aaArrStatus,' ')) and $AA_INTERFACE_INPUT_DEALS = 'Y' ) 
                                              or 
                                              (contains($list_Active_FinancialInstrumentAADepositsInterestRate,concat(' ',c:aatxncontext/b:aaArrStatus,' ')) and ($AA_INTERFACE_INPUT_DEALS = 'N' )) 
                                              )
                                        and ( not(c:aatxncontext/b:aaActivityStatus) or c:aatxncontext/b:aaActivityStatus != 'REV' ) "/>
    <xsl:apply-templates select="self::c:AAAFlow[$cond01]" mode="filter2"/>
  </xsl:template>
  <!-- Condition 3 -->
  <xsl:template match="c:AAAFlow" mode="filter2">
    <xsl:variable name="cond02" select="(c:aaarecord/d:activity= 'DEPOSITS-APPLYPAYMENT-PR.DEPOSIT' and $AA_INTERFACE_INPUT_DEALS = 'N') 
                                        or (c:aaarecord/d:activity = 'DEPOSITS-NEW-ARRANGEMENT' and $AA_INTERFACE_INPUT_DEALS = 'Y')                                                           
                                            and (c:aaarecord/d:txnSystemId ='AAAA' and c:aatxncontext/b:aaMasterActivity =  'DEPOSITS-NEW-ARRANGEMENT'                                      
                                                or c:aaarecord/d:txnSystemId ='FT'
                                                or (not(c:aaarecord/d:txnSystemId) and $AA_INTERFACE_INPUT_DEALS = 'Y'))                                                           
                                            or  contains( c:aaarecord/d:activityClass,'CHANGE-INTEREST')"/>
    <xsl:variable name="cond03" select="( (c:aaarecord/d:txnSystemId ='AAAA'                                      
                                        and c:aatxncontext/b:aaMasterActivity =  'LENDING-NEW-ARRANGEMENT'                                      
                                        and ((c:aaarecord/d:activity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL'  
                                               and $AA_INTERFACE_INPUT_DEALS = 'N') or (c:aaarecord/d:activity = 'LENDING-NEW-ARRANGEMENT' and $AA_INTERFACE_INPUT_DEALS = 'Y')))                                                 
                                        or  (c:aaarecord/d:txnSystemId ='FT' and c:aaarecord/d:activity = 'LENDING-DISBURSE-COMMITMENT')                                                 
                                        or  contains( c:aaarecord/d:activityClass,'CHANGE-INTEREST'))"/>
    <xsl:variable name="cond05" select="(c:aatxncontext/b:aaMasterActivity = 'LENDING-RENEW-ARRANGEMENT' or c:aatxncontext/b:aaMasterActivity = 'LENDING-CHANGE-PRINCIPALINT' or c:aatxncontext/b:aaMasterActivity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL' or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-RENEW-ARRANGEMENT'                           or c:aatxncontext/b:aaMasterActivity = 'LENDING-ISSUEBILL-SCHEDULE*DISBURSEMENT.%'                           or c:aatxncontext/b:aaMasterActivity = 'LENDING-MAKEDUE.DISBURSE-SCHEDULE'             or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-CHANGE-DEPOSITINT'             or c:aatxncontext/b:aaMasterActivity = 'DEPOSITS-ROLLOVER-ARRANGEMENT'               or c:aaarecord/d:activityClass = 'LENDING-NEW-ARRANGEMENT'               )"/>
    <xsl:apply-templates select="self::c:AAAFlow[$cond02 or $cond03 or $cond05]" mode="filter-custo"/>
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

  <xsl:template match="c:interestrecords">
		<xsl:apply-templates select="self::node()[contains($list_idComp2_FinancialInstrumentAADepositsInterestRate,concat(' ',./a:idComp2,' '))]" mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="c:interestrecords" mode="filter-custo">
		<xsl:apply-templates select="self::node()" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="c:interestrecords" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->