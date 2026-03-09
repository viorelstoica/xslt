<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:FdFidOrder">
		<xsl:apply-templates select="self::b:FdFidOrder[
									(../../c:CurrentEvent/b:FdFidOrder/b:orderStatus = 'CUR' and ../../c:CurrentEvent/b:FdFidOrder/b:tapRefId 
									and ../../c:CurrentEvent/b:FdFidOrder/b:tapRefId != '' 
									and contains(../../c:CurrentEvent/b:FdFidOrder/b:tapRefId, '%C-000') 
									and (../../c:CurrentEvent/b:FdFidOrder/b:earlyStatus = 'REQUESTED' 
											or (../../c:CurrentEvent/b:FdFidOrder/b:prinChangeGroup[position()=last()]/b:changeStatus = 'REQUESTED' 
												and ../../c:CurrentEvent/b:FdFidOrder/b:reimburseReq = 'YES'))
									) 
									or ../../c:CurrentEvent/b:FdFidOrder/b:orderStatus = 'CUR' 
										and ../../c:CurrentEvent/b:FdFidOrder/b:tapRefId 
										and ../../c:CurrentEvent/b:FdFidOrder/b:tapRefId != '' 
										and contains(../../c:CurrentEvent/b:FdFidOrder/b:tapRefId, '%C-000') 
										and ((../../c:PreviousEvent/b:FdFidOrder/b:earlyStatus != '' 
												and (../../c:CurrentEvent/b:FdFidOrder/b:earlyStatus = '' or 
												not(../../c:CurrentEvent/b:FdFidOrder/b:earlyStatus))) 
											  or
											 (../../c:PreviousEvent/b:FdFidOrder/b:reimburseReq != '' and 
												(../../c:CurrentEvent/b:FdFidOrder/b:reimburseReq = '' or not(../../c:CurrentEvent/b:FdFidOrder/b:reimburseReq)))
											)]"
		                     mode="filter-custo"/>
	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:FdFidOrder" mode="filter-custo">
		<xsl:apply-templates select="self::b:FdFidOrder" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:FdFidOrder" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionCloseFiduciary" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionCloseFiduciary\TransactionCloseFiduciary.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionCloseFiduciary\TransactionCloseFiduciaryCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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