<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:t="http://www.odcgroup.com/F2B_FORMAT" xmlns:dxorder="http://www.temenos.com/T24/dxorder"
                xmlns:dxtrade="http://www.temenos.com/T24/dxtrade" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:adjustmentorder="http://www.temenos.com/T24/adjustmentorder" xmlns:secopenorder1="http://www.temenos.com/T24/secopenorder1"
                xmlns:secopenorder2="http://www.temenos.com/T24/secopenorder2" xmlns:secopenorder3="http://www.temenos.com/T24/secopenorder3" xmlns:sectrade="http://www.temenos.com/T24/sectrade"
                xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer"
                xmlns:securitytransfer2="http://www.temenos.com/T24/securitytransfer2" exclude-result-prefixes="b t" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:OrderInstruction">
		<xsl:variable name="F2BOrderInstructionFilterCheck">
			<xsl:choose>
				<!-- BEG - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->
				<xsl:when test="(b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '1' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '2' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '11' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '18' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '19') and (b:buySellIndicator = '4' or b:buySellIndicator = '5')">
					<xsl:choose>
						<xsl:when test="(not(b:mbFields/infra:mbField[infra:name = 'source_fund_instr']/infra:value) or (b:mbFields/infra:mbField[infra:name = 'source_fund_instr']/infra:value = 'NULL'))">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- END - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->

				<!-- BEG - Filter out if satisfying ESFUND.TRASPASO.REQUEST condition in TTI F2B-TransferInTraspasoOrder.xlsx -->
				<xsl:when test="not((b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13') and (b:userDefinedField[infra:name='ud_instr_traspasos_f']/infra:value = '1') and (b:buySellIndicator = '4'))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
				<!-- END - Filter out if satisfying ESFUND.TRASPASO.REQUEST condition in TTI F2B-TransferInTraspasoOrder.xlsx -->
			</xsl:choose>
		</xsl:variable>
		<xsl:apply-templates select="self::b:OrderInstruction[$F2BOrderInstructionFilterCheck = '1']" mode="filterMB-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:OrderInstruction" mode="filterMB-custo">
		<xsl:apply-templates select="self::b:OrderInstruction" mode="filterMB-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:OrderInstruction" mode="filterMB-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- Filter out whole input xml(i.e., root element F2B) if no orderInstruction passes the above filter -->
	<xsl:template match="b:F2B">
		<xsl:variable name="orderInstructionPresentCheck">
			<xsl:for-each select="b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction">
				<xsl:choose>
					<!-- BEG - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->
					<xsl:when test="(b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '1' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '2' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '11' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '18' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '19') and (b:buySellIndicator = '4' or b:buySellIndicator = '5')">
						<xsl:choose>
							<xsl:when test="(not(b:mbFields/infra:mbField[infra:name = 'source_fund_instr']/infra:value) or (b:mbFields/infra:mbField[infra:name = 'source_fund_instr']/infra:value = 'NULL'))">
								<xsl:value-of select="'Y'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'N'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<!-- END - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->

					<!-- BEG - Filter out if satisfying ESFUND.TRASPASO.REQUEST condition in TTI F2B-TransferInTraspasoOrder.xlsx -->
					<xsl:when test="not((b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13') and (b:userDefinedField[infra:name='ud_instr_traspasos_f']/infra:value = '1') and (b:buySellIndicator = '4'))">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
					<!-- END - Filter out if satisfying ESFUND.TRASPASO.REQUEST condition in TTI F2B-TransferInTraspasoOrder.xlsx -->
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:F2B[contains($orderInstructionPresentCheck,'Y')]" mode="filterMB-custo1"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:F2B" mode="filterMB-custo1">
		<xsl:apply-templates select="self::b:F2B" mode="filterMB-final1"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:F2B" mode="filterMB-final1">
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
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->