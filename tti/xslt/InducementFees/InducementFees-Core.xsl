<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/InducementFees"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchInducementFees" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiInducementFees" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiInducementFees" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="paymentDate">
		<paymentDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="substring-after(substring-after(substring-after(substring-after(b:id,'.'),'.'),'.'),'.')"/>
			</xsl:call-template>
		</paymentDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="deposit">
		<deposit>
			<infra:code>
				<xsl:value-of select="b:depository"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="paidAmount">
		<paidAmount>
			<xsl:variable name="totAccrAmtCalcCcy" select="format-number(b:totAccrAmtCalcCcy,$decimalformat,'nan2zero')"/>
			<xsl:variable name="diffAmt" select="format-number(b:diffAmt,$decimalformat,'nan2zero')"/>
			<xsl:value-of select="format-number(($totAccrAmtCalcCcy + $diffAmt),'#.##','nan2zero')"/>
		</paidAmount>
	</xsl:template>
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="b:calcCcy"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="reimbursement">
		<reimbursement>
			<xsl:choose>
				<xsl:when test="b:reimburseTrFee='YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</reimbursement>
	</xsl:template>
	<xsl:template name="receivedAmount">
		<xsl:param name="totAccrAmtCalcCcy" select="format-number(b:totAccrAmtCalcCcy,$decimalformat,'nan2zero')"/>
		<xsl:param name="diffAmt" select="format-number(b:diffAmt,$decimalformat,'nan2zero')"/>
		<xsl:param name="multiVar">
			<xsl:choose>
				<xsl:when test="(not(b:reimburseTrRateJoin) or b:reimburseTrRateJoin = '') or number(b:reimburseTrRateJoin) = '100'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:reimburseTrRateJoin div 100,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:if test="b:reimburseTrFeeJoin = 'YES'">
			<receivedAmount>
				<xsl:value-of select="format-number($multiVar * ($totAccrAmtCalcCcy + $diffAmt),'#.##','nan2zero')"/>
			</receivedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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