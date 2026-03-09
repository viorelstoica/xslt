<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecOpenOrder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c batch multibatch" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:SecOpenOrder">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecOpenOrder[$opStatus = 'INPUT-INPUT' and b:currNo = '1']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:SecOpenOrder" mode="filter1">
		<xsl:apply-templates select="self::b:SecOpenOrder[($g_filterBySubAssetType='Y' and b:subAssetTypeSecurityMasterJoin and contains ($list_SubAssetType_TransactionSecOpenOrder,b:subAssetTypeSecurityMasterJoin)) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
									 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecOpenOrder" mode="filter2">
		<xsl:variable name="checkPortfolioConditionVar">
			<xsl:call-template name="checkPortfolioCondition">
				<xsl:with-param name="xsltName" select="'TransactionSecOpenOrder'"/>
				<xsl:with-param name="memoAccount" select="b:memoAccountSecAccMasterJoinList/b:memoAccountSecAccMasterJoin"/>
				<xsl:with-param name="dealerBook" select="b:dealerBookSecAccMasterJoinList/b:dealerBookSecAccMasterJoin"/>
				<xsl:with-param name="customerType" select="b:customerTypeCustomerSecurityJoinGroup/b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:SecOpenOrder[$checkPortfolioConditionVar = 'true']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:SecOpenOrder" mode="filter3">
		<xsl:apply-templates select="self::b:SecOpenOrder[b:custNumberGroup/b:cuEntlId !='' and (not(b:dealStatus)) and (not(b:orderStatus))]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:SecOpenOrder" mode="filter4">
		<xsl:apply-templates select="self::b:SecOpenOrder[../../c:PreviousEvent/b:SecOpenOrder/b:recordStatus='IHLD']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:SecOpenOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:SecOpenOrder" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:SecOpenOrder" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\secAcct.xml" htmlbaseurl="" outputurl="..\secAcctFilterOut.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength=""
		          urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->