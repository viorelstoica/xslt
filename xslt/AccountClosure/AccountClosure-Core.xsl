<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AccountClosure"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAccountClosure" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAccountClosure" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAccountClosure" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="active">
		<active>0</active>
	</xsl:template>
	<xsl:template name="closingDate">
		<xsl:if test="b:acctCloseDateAccountClosedJoin != ''">
			<closingDate>
				<xsl:value-of select="b:acctCloseDateAccountClosedJoin"/>
			</closingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:shortName"/>
	<xsl:template name="infra:longName"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="accrualRule"/>
	<xsl:template name="accruedInterestCalculation"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="referenceCurrency"/>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="type"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="openingDate"/>
	<xsl:template name="interestAccrualDate"/>
	<xsl:template name="eomConvention"/>
	<xsl:template name="client"/>
	<xsl:template name="parentCashAccount"/>
	<xsl:template name="portfolio"/>
	<xsl:template name="suspenseAccount"/>
	<xsl:template name="witholdingTax"/>
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