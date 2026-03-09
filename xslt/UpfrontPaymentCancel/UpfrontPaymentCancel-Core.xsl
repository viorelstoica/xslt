<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OpenUpfrontPaymentOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOpenUpfrontPaymentOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOpenUpfrontPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOpenUpfrontPaymentOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:custNumber,$COMPANY_POSTFIX_SEPARATOR,b:custNumberGroup/b:securityAccnt,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin)"/>
		</code>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:custNumberGroup/b:custAccNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="linkedInstrument">
		<linkedInstrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</linkedInstrument>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:custNumberGroup/b:securityAccnt"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:custNumberGroup/b:cuCashAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="exDate"/>
		<xsl:template name="endDate">
		<endDate>
			<xsl:variable name="string2date" select="b:eventCommon/ns0:today"/>
			<xsl:variable name="year" select="substring($string2date, 1, 4)"/>
			<xsl:variable name="month" select="substring($string2date, 6, 2)"/>
			<xsl:variable name="day" select="substring($string2date, 9, 2)"/>
			<xsl:variable name="prevDay" select="number($day) - 1"/>
			<xsl:variable name="adjustedDate">
				<xsl:choose>
					<xsl:when test="$prevDay &gt; 0">
						<xsl:value-of select="concat($year, '-', $month, '-', format-number($prevDay, '00'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="prevMonth" select="number($month) - 1"/>
						<xsl:choose>
							<xsl:when test="$prevMonth = 0">
								<xsl:value-of select="concat($year - 1, '-12-31')"/>
							</xsl:when>
							<xsl:when test="$prevMonth = 1 or $prevMonth = 3 or $prevMonth = 5 or $prevMonth = 7 or $prevMonth = 8 or $prevMonth = 10">
								<xsl:value-of select="concat($year, '-', format-number($prevMonth, '00'), '-31')"/>
							</xsl:when>
							<xsl:when test="$prevMonth = 4 or $prevMonth = 6 or $prevMonth = 9 or $prevMonth = 11">
								<xsl:value-of select="concat($year, '-', format-number($prevMonth, '00'), '-30')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($year, '-02-28')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="($adjustedDate)"/>
		</endDate>
	</xsl:template>
	<xsl:template name="nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
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