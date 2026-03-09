<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferScSettlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferScSettlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->

	<!-- BEG - Allow securityAcctGroup only if securityNo = scSettlementSecurityNo -->
	<!-- Condition 1 -->
	<xsl:template match="b:securityAcctGroup">
		<xsl:apply-templates select="self::b:securityAcctGroup[b:securityNo = ../b:scSettlementSecurityNo]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:securityAcctGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:securityAcctGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:securityAcctGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Allow securityAcctGroup only if securityNo = scSettlementSecurityNo -->

	<!-- BEG - Filter for whole record -->
	<!-- Condition 1 -->
	<xsl:template match="b:PositionTransferScSettlement">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter1">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[(b:secAcctFrom and b:secAcctFrom != '' and b:secAcctTo and b:secAcctTo != '' and b:secAcctTo = b:secAcctFrom) or ((not(b:secAcctFrom) or b:secAcctFrom = '') or (not(b:secAcctTo) or b:secAcctTo = ''))]"
		                     mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter2">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:depositoryFrom and b:depositoryFrom != '']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter3">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:depositoryTo and b:depositoryTo != '']" mode="filter4"/>
	</xsl:template>
	<!-- Condition 5 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter4">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[not(b:depositoryTo = b:depositoryFrom)]" mode="filter5"/>
	</xsl:template>
	<!-- Condition 6 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter5">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains(concat(' ',$sectPendTransNamesInSupportedTypes,' '),concat(' ',b:transTypeCr,' ')) or contains(concat(' ',$securityTransferInSupportedTypes,' '),concat(' ',b:transTypeCr,' '))]"
		                     mode="filter6"/>
	</xsl:template>
	<!-- Condition 7 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter6">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[b:application = 'POSITION.TRANSFER']" mode="filter7"/>
	</xsl:template>
	<!-- Condition 8 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter7">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains(concat(' ',$sectPendTransNamesOutSupportedTypes,' '),concat(' ',b:transCode,' ')) or contains(concat(' ',$securityTransferOutSupportedTypes,' '),concat(' ',b:transCode,' '))]"
		                     mode="filter8"/>
	</xsl:template>
	<!-- Condition 9 -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter8">
		<xsl:variable name="ifSecurityNoPresent">
			<xsl:for-each select="b:securityAcctGroup">
				<xsl:choose>
					<xsl:when test="b:securityNo = ../b:scSettlementSecurityNo">
						<xsl:value-of select="'Y'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:PositionTransferScSettlement[contains($ifSecurityNoPresent,'Y')]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter-custo">
		<xsl:apply-templates select="self::b:PositionTransferScSettlement" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:PositionTransferScSettlement" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter for whole record -->

	<!-- BEG - Delete the b:owncompId tag as we should make use of ownCompId from ownCompIdSecurityAcctJoinList -->
	<!-- Condition 1 -->
	<xsl:template match="b:ownCompId"/>
	<!-- BEG - Delete the b:owncompId tag as we should make use of ownCompId from ownCompIdSecurityAcctJoinList -->

	<!-- BEG - Print ownCompId values outside the ownCompIdSecurityAcctJoinList group for multi-entity checks(rename the tag as ownCompId)-->
	<!-- Condition 1 -->
	<xsl:template match="b:ownCompIdSecurityAcctJoinList">
		<xsl:variable name="ownCompIdList" select="name()"/>
		<xsl:variable name="ownCompIdList1" select="concat(substring-before($ownCompIdList,'SecurityAcctJoin'),'List')"/>
		<xsl:element name="{$ownCompIdList1}" namespace="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement">
			<xsl:for-each select="b:ownCompIdSecurityAcctJoin">
				<xsl:variable name="ownCompId" select="name()"/>
				<xsl:variable name="ownCompId1" select="substring-before($ownCompId,'SecurityAcctJoin')"/>
				<xsl:element name="{$ownCompId1}" namespace="http://www.temenos.com/T24/event/TTI/PositionTransferScSettlement" use-attribute-sets="index">
					<xsl:value-of select="."/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:attribute-set name="index">
		<xsl:attribute name="index">
			<xsl:value-of select="./@index"/>
		</xsl:attribute>
	</xsl:attribute-set>
	<!-- END - Print ownCompId values outside the ownCompIdSecurityAcctJoinList group for multi-entity checks(rename the tag as ownCompId)-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->