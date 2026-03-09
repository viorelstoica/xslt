<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurityCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurityCob" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">

	<xsl:template name="interestSchedule_endDate"/>
	<xsl:template name="interestSchedule_interestRate">
		<interestRate>
			<xsl:value-of select="b:interestRate"/>
		</interestRate>
	</xsl:template>
	<xsl:template name="interestSchedule_scheduledDate">
		<xsl:variable name="index" select="./@index"/>
		<scheduledDate>
            <xsl:value-of select="../b:interestRateGroup[@index=number($index)]/b:rateChDate"/>
		</scheduledDate>
	</xsl:template>
	<xsl:template name="interestSchedule_validityDate">
		<xsl:variable name="index" select="./@index"/>
		<validityDate>
            <xsl:value-of select="../b:interestRateGroup[@index=number($index)]/b:rateChDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="interestSchedule_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="interestSchedule_mbFields"/>
	<xsl:template name="userdefined"/>
	<!-- Income Event Fields -->

	<xsl:template name="ie_beginDate">
		<beginDate>
			<xsl:value-of select="b:accrualStartDate"/>	
		</beginDate>
	</xsl:template>
	<xsl:template name="ie_endValidityDate">
		<endValidityDate>
			<xsl:value-of select="b:intPaymentDate"/>
		</endValidityDate>
	</xsl:template>
	<xsl:template name="ie_exDate"/>
	<xsl:template name="ie_firstCouponDate">
		<firstCouponDate>
			<xsl:value-of select="b:intPaymentDate"/>
		</firstCouponDate>
	</xsl:template>
	<xsl:template name="ie_validityDate">	
		<validityDate>
			<xsl:value-of select="b:issueDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="ie_instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ie_coupon"/>
	<xsl:template name="ie_code"/>
	<xsl:template name="ie_currency"/>
	<xsl:template name="ie_exchangeRate"/>
	<xsl:template name="ie_mbFields"/>

</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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