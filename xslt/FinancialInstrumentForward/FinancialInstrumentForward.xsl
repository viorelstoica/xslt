<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentForex"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentForex" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentForex">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentForex"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentForex" name="BatchFinancialInstrumentForex">
			<xsl:apply-templates select="b:FinancialInstrumentForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentForex" name="BatchMultiFinancialInstrumentForex">
			<xsl:apply-templates select="c:MultiFinancialInstrumentForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentForex">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentForward',b:id)"/>
			</xsl:attribute>
			<!-- Instrument valid for a Buy -->
			<xsl:if test="substring(b:dealType,1,2) = 'FW' and not($PCK_GL_FWD_TEMPLATE=1 and (not(b:baseCcy = b:currencySold)))">
				<DataGroup>
					<Forward>
						<GenericForward>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('FinancialInstrumentForward.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
							<xsl:call-template name="infra:userDefinedField-custo"/>
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
							
							<xsl:call-template name="physicalDelivery"/>
							<xsl:call-template name="provider"/>
							<xsl:call-template name="underlyingCurrency"/>
							<xsl:call-template name="yieldCurve"/>
							<xsl:call-template name="subNature"/>
						</GenericForward>
					</Forward>
				</DataGroup>
			</xsl:if>
			<!-- End of instrument valid for a Buy -->
			<!-- Instrument valid for a Sell -->
			<xsl:if test="substring(b:dealType,1,2) = 'FW' and not($PCK_GL_FWD_TEMPLATE=1 and (not(b:baseCcy = b:currencyBought)))">
				<DataGroup>
					<Forward>
						<GenericForward>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('FinancialInstrumentForward.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="infra:code_S"/>
							<xsl:call-template name="infra:synonym_S"/>
							<xsl:call-template name="infra:shortName_S"/>
							<xsl:call-template name="infra:longName_S"/>
							<xsl:call-template name="infra:multilingualLongName_S"/>
							<xsl:call-template name="infra:notepad_S"/>
							<xsl:call-template name="infra:userDefinedField_S"/>
							<xsl:call-template name="infra:userDefinedField-custo_S"/>
							<xsl:call-template name="infra:mbFields_S"/>
							<xsl:call-template name="accrualRule_S"/>
							<xsl:call-template name="accruedInterestCalculation_S"/>
							<xsl:call-template name="accruedInterestRoundingRule_S"/>
							<xsl:call-template name="accruedInterestRoundingUnit_S"/>
							<xsl:call-template name="accruedInterestUnitaryRounding_S"/>
							<xsl:call-template name="active_S"/>
							<xsl:call-template name="euroConversionDate_S"/>
							<xsl:call-template name="euroConversionRule_S"/>
							<xsl:call-template name="euroNewInstrument_S"/>
							<xsl:call-template name="mainBusinessEntity_S"/>
							<xsl:call-template name="priceCalculationRule_S"/>
							<xsl:call-template name="referenceCurrency_S"/>
							<xsl:call-template name="riskCountry_S"/>
							<xsl:call-template name="riskNature_S"/>
							<xsl:call-template name="subType_S"/>
							<xsl:call-template name="taxCountry_S"/>
							<xsl:call-template name="tradable_S"/>
							<xsl:call-template name="type_S"/>
							<xsl:call-template name="valuationRule_S"/>
							

							<xsl:call-template name="physicalDelivery_S"/>
							<xsl:call-template name="provider_S"/>
							<xsl:call-template name="underlyingCurrency_S"/>
							<xsl:call-template name="yieldCurve_S"/>
							<xsl:call-template name="subNature_S"/>
						</GenericForward>
					</Forward>
				</DataGroup>
			</xsl:if>
			<!-- End of instrument valid for a Sell -->
		</FiPMS>
	</xsl:template>
</xsl:stylesheet>