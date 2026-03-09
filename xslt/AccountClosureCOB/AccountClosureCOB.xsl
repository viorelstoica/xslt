<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AccountClosureCOB"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAccountClosureCOB" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAccountClosureCOB" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAccountClosureCOB" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="c:MultiAccountClosureCOB">
		<xsl:apply-templates select="c:CurrentEvent/b:AccountClosureCOB"/>
	</xsl:template>
	<xsl:template match="batch:BatchAccountClosureCOB">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAccountClosureCOB" name="BatchAccountClosureCOB">
			<xsl:apply-templates select="b:AccountClosureCOB"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiAccountClosureCOB">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAccountClosureCOB" name="BatchMultiAccountClosureCOB">
			<xsl:apply-templates select="c:MultiAccountClosureCOB"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:AccountClosureCOB">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('AccountClosureCOB',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<CashAccount>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('AccountClosureCOB.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
					<xsl:call-template name="infra:synonym"/>
					<xsl:call-template name="infra:shortName"/>
					<xsl:call-template name="infra:longName"/>
					<xsl:call-template name="infra:multilingualLongName"/>
					<xsl:call-template name="infra:notepad"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="accrualRule"/>
					<xsl:call-template name="accruedInterestCalculation"/>
					<xsl:call-template name="accruedInterestRoundingRule"/>
					<xsl:call-template name="accruedInterestRoundingUnit"/>
					<xsl:call-template name="accruedInterestUnitaryRounding"/>
					<xsl:call-template name="active"/>
					<xsl:call-template name="euroConversionDate"/>
					<xsl:call-template name="euroConversionRule"/>
					<xsl:call-template name="euroNewInstrument"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="referenceCurrency"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="openingDate"/>
					<xsl:call-template name="interestAccrualDate"/>
					<xsl:call-template name="closingDate"/>
					<xsl:call-template name="eomConvention"/>
					<xsl:call-template name="client"/>
					<xsl:call-template name="parentCashAccount"/>
					<xsl:call-template name="portfolio"/>
					<xsl:call-template name="suspenseAccount"/>
					<xsl:call-template name="witholdingTax"/>
				</CashAccount>
			</DataGroup>
		</FiPMS>
	</xsl:template>
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