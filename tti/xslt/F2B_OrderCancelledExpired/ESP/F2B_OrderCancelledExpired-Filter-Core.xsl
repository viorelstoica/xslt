<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.odcgroup.com/F2B" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:secopenorder="http://www.temenos.com/T24/secopenorder" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" exclude-result-prefixes="b" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<!-- This condition is for filtering traspaso and passing all others(special filter for SECURITY.TRANSFER also) -->
	<xsl:template match="b:Request">
		<xsl:variable name="F2BOrderCancellationFilterCheck">
			<xsl:choose>
				<!-- BEG - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->
				<xsl:when test="(b:buySellIndicator = '4' or b:buySellIndicator = '5')">
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
		<xsl:apply-templates select="self::b:Request[$F2BOrderCancellationFilterCheck = '1']" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:Request" mode="filter-custo">
		<xsl:apply-templates select="self::b:Request" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:Request" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- Filter out whole input xml(i.e., root element F2B) if no orderInstruction passes the above filter -->
	<xsl:template match="b:F2B">
		<xsl:variable name="orderInstructionPresentCheck">
			<xsl:for-each select="b:DataGroup/b:Security/b:Cancellation/b:Request">
				<xsl:choose>
					<!-- BEG - Donot filter if satisfying SecurityTransfer Condition in TTI F2B-TransferManagementOrderInstruction.xlsx -->
					<xsl:when test="(b:buySellIndicator = '4' or b:buySellIndicator = '5')">
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\t24Schemas\OfsmlProxy.xsd" destSchemaRoot="T24Batch" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\gwpackSchemas\F2B.xsd" srcSchemaRoot="F2B" AssociatedInstance="file:///w:/TTI_TRUNK2/gwpackSchemas/F2B.xsd" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="T24Batch/xsl:for-each" x="205" y="54"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose" x="191" y="51"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]" x="145" y="45"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]" x="99" y="39"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]" x="53" y="33"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]" x="7" y="27"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]" x="0" y="21"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]" x="0" y="144"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]/=[0]" x="0" y="138"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="166"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="43"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/or[0]/=[1]" x="0" y="49"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/or[0]/=[1]" x="7" y="55"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/or[0]/=[1]" x="53" y="61"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/or[0]/=[1]" x="99" y="67"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose" x="121" y="21"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]" x="242" y="77"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]/=[0]" x="196" y="71"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/or[0]/=[1]" x="196" y="99"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/xsl:when/xsl:value-of" x="31" y="51"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/=[1]" x="242" y="105"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when/ofsTransactionInput/field/xsl:choose/xsl:when[1]/xsl:value-of" x="198" y="113"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]" x="123" y="202"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/=[0]" x="77" y="196"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]" x="77" y="224"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]/=[0]" x="31" y="218"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/and[1]/or[1]/=[1]" x="31" y="246"/>
				<block path="T24Batch/xsl:for-each/T24/serviceRequest/xsl:choose/xsl:when[1]/ofsTransactionInput/field[1]/xsl:value-of" x="158" y="113"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->