<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFiduciary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFiduciary" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFiduciary" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- BEG - Filter out orderNosGroup -->
	<!-- Condition 1 -->
	<xsl:template match="b:orderNosGroup">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::b:orderNosGroup[../b:memoAccountList/b:memoAccount[@index=$index] = 'NO']" mode="filter1"/>
	</xsl:template>
	<!-- Condition 2 -->
	<xsl:template match="b:orderNosGroup" mode="filter1">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::b:orderNosGroup[not(../b:dealerBookList/b:dealerBook[@index=$index]) or ../b:dealerBookList/b:dealerBook[@index=$index] = '']" mode="filter2"/>
	</xsl:template>
	<!-- Condition 3 -->
	<xsl:template match="b:orderNosGroup" mode="filter2">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::b:orderNosGroup[../b:customerTypeGroup[@index=$index]/b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter3"/>
	</xsl:template>
	<!-- Condition 4 -->
	<xsl:template match="b:orderNosGroup" mode="filter3">
		<xsl:variable name="index" select="@index"/>
		<xsl:apply-templates select="self::b:orderNosGroup[not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup/b:orderNos = b:orderNos) or not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup/b:orderNos) or (../b:interestRate != ../../../c:PreviousEvent/b:FdFiduciary/b:interestRate)]"
		                     mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:orderNosGroup" mode="filter-custo">
		<xsl:apply-templates select="self::b:orderNosGroup" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:orderNosGroup" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - Filter out orderNosGroup -->

	<!-- BEG - For Filtering out Whole Record -->
	<!-- Condition 1 -->
	<xsl:template match="b:FdFiduciary">
		<xsl:variable name="ifFilterWholeRecord">
			<xsl:for-each select="b:orderNosGroup">
				<xsl:variable name="index" select="@index"/>
				<xsl:choose>
					<xsl:when test="../b:memoAccountList/b:memoAccount[@index=$index] = 'NO' and (not(../b:dealerBookList/b:dealerBook[@index=$index]) or ../b:dealerBookList/b:dealerBook[@index=$index] = '') and ../b:customerTypeGroup[@index=$index]/b:customerTypeList/b:customerType = 'CUSTOMER'">
						<xsl:choose>
							<xsl:when test="not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup/b:orderNos = b:orderNos) or not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup/b:orderNos)">
								<xsl:value-of select="'Y'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'N'"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'N'"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:apply-templates select="self::b:FdFiduciary[contains($ifFilterWholeRecord,'Y') or (b:interestRate != ../../c:PreviousEvent/b:FdFiduciary/b:interestRate)]" mode="filter-custo"/>
	</xsl:template>
	<!-- Custo placeholder -->
	<xsl:template match="b:FdFiduciary" mode="filter-custo">
		<xsl:apply-templates select="self::b:FdFiduciary" mode="filter-final"/>
	</xsl:template>
	<!-- Copy block -->
	<xsl:template match="b:FdFiduciary" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END - For Filtering out Whole Record -->
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