<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch" version="1.0" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/LockedSecurityPosition"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockedSecurityPosition" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockedSecurityPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockedSecurityPosition" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:LockedSecurityPosition">
		<xsl:apply-templates select="self::b:LockedSecurityPosition[b:portfolioMemoJoin = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter1">
		<xsl:apply-templates select="self::b:LockedSecurityPosition[not(b:dealerBookJoin)]" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter2">
		<xsl:apply-templates select="self::b:LockedSecurityPosition[b:customerTypeJoinList/b:customerTypeJoin = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter3">
		<xsl:apply-templates select="self::b:LockedSecurityPosition[($g_filterBySubAssetType='Y' and b:subAssetTypeJoin and contains($list_SubAssetType_LockedSecurityPosition,b:subAssetTypeJoin)) or
										($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or 
										 b:subAssetTypeTapInstrType='CONVBOND' or b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or
										 b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or 
										 b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or b:subAssetTypeTapInstrType='REVCONVEQLK' or 
										 b:subAssetTypeTapInstrType='REVCONVCREDLK'))]" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter4">
		<xsl:apply-templates select="self::b:LockedSecurityPosition[b:nomAmtBlocked  and b:nomAmtBlocked !='0']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter-custo">
		<xsl:apply-templates select="self::b:LockedSecurityPosition" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:LockedSecurityPosition" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="LockedSecurityPosition" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\LockedSecurityPosition\LockedSecurityPosition.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\LockedSecurityPosition\LockedSecurityPositionCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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