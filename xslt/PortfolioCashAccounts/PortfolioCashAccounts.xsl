<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioCashAccounts"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolioCashAccounts" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioCashAccounts" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioCashAccounts" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPortfolioCashAccounts">
		<xsl:apply-templates select="c:CurrentEvent/b:PortfolioCashAccounts"/>
	</xsl:template>
	<xsl:template match="batch:BatchPortfolioCashAccounts">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPortfolioCashAccounts" name="BatchPortfolioCashAccounts">
			<xsl:apply-templates select="b:PortfolioCashAccounts"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPortfolioCashAccounts">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioCashAccounts" name="BatchMultiPortfolioCashAccounts">
			<xsl:apply-templates select="c:MultiPortfolioCashAccounts"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PortfolioCashAccounts">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('portfolioCashAccounts',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<!-- BEG - For accountNosGroup -->
				<xsl:for-each select="b:accountNosGroup">
					<xsl:variable name="index" select="./@index"/>
					<xsl:variable name="currentAccountNo" select="b:accountNosGroup[@index=number($index)]/b:accountNos"/>
					<xsl:if test="not(../../../c:PreviousEvent/b:PortfolioCashAccounts/b:accountNosGroup[b:accountNos = $currentAccountNo])">
						<CashAccount>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PortfolioCashAccounts.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="t1-infra-code"/>
							<xsl:call-template name="t1-infra-synonym"/>
							<xsl:call-template name="t1-infra-shortName"/>
							<xsl:call-template name="t1-infra-longName"/>
							<xsl:call-template name="t1-infra-multilingualLongName"/>
							<xsl:call-template name="t1-infra-notepad"/>
							<xsl:call-template name="t1-infra-userDefinedField"/>
							<xsl:call-template name="t1-infra-mbFields"/>
							<xsl:call-template name="t1-accrualRule"/>
							<xsl:call-template name="t1-accruedInterestCalculation"/>
							<xsl:call-template name="t1-accruedInterestRoundingRule"/>
							<xsl:call-template name="t1-accruedInterestRoundingUnit"/>
							<xsl:call-template name="t1-accruedInterestUnitaryRounding"/>
							<xsl:call-template name="t1-active"/>
							<xsl:call-template name="t1-euroConversionDate"/>
							<xsl:call-template name="t1-euroConversionRule"/>
							<xsl:call-template name="t1-euroNewInstrument"/>
							<xsl:call-template name="t1-mainBusinessEntity"/>
							<xsl:call-template name="t1-priceCalculationRule"/>
							<xsl:call-template name="t1-referenceCurrency"/>
							<xsl:call-template name="t1-riskCountry"/>
							<xsl:call-template name="t1-riskNature"/>
							<xsl:call-template name="t1-subType"/>
							<xsl:call-template name="t1-taxCountry"/>
							<xsl:call-template name="t1-tradable"/>
							<xsl:call-template name="t1-type"/>
							<xsl:call-template name="t1-valuationRule"/>
							<xsl:call-template name="t1-openingDate"/>
							<xsl:call-template name="t1-interestAccrualDate"/>
							<xsl:call-template name="t1-closingDate"/>
							<xsl:call-template name="t1-eomConvention"/>
							<xsl:call-template name="t1-client"/>
							<xsl:call-template name="t1-parentCashAccount"/>
							<xsl:call-template name="t1-portfolio"/>
							<xsl:call-template name="t1-suspenseAccount"/>
							<xsl:call-template name="t1-witholdingTax"/>
						</CashAccount>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="../../c:PreviousEvent/b:PortfolioCashAccounts/b:accountNosGroup">
					<xsl:variable name="previousAccountNo" select="b:accountNos"/>
					<xsl:if test="not(../../../c:CurrentEvent/b:PortfolioCashAccounts/b:accountNosGroup[b:accountNos = $previousAccountNo])">
						<CashAccount>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PortfolioCashAccounts.xsl+', name(/*), '+', ../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:eventId, '+', ../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="t2-infra-code"/>
							<xsl:call-template name="t2-infra-synonym"/>
							<xsl:call-template name="t2-infra-shortName"/>
							<xsl:call-template name="t2-infra-longName"/>
							<xsl:call-template name="t2-infra-multilingualLongName"/>
							<xsl:call-template name="t2-infra-notepad"/>
							<xsl:call-template name="t2-infra-userDefinedField"/>
							<xsl:call-template name="t2-infra-mbFields"/>
							<xsl:call-template name="t2-accrualRule"/>
							<xsl:call-template name="t2-accruedInterestCalculation"/>
							<xsl:call-template name="t2-accruedInterestRoundingRule"/>
							<xsl:call-template name="t2-accruedInterestRoundingUnit"/>
							<xsl:call-template name="t2-accruedInterestUnitaryRounding"/>
							<xsl:call-template name="t2-active"/>
							<xsl:call-template name="t2-euroConversionDate"/>
							<xsl:call-template name="t2-euroConversionRule"/>
							<xsl:call-template name="t2-euroNewInstrument"/>
							<xsl:call-template name="t2-mainBusinessEntity"/>
							<xsl:call-template name="t2-priceCalculationRule"/>
							<xsl:call-template name="t2-referenceCurrency"/>
							<xsl:call-template name="t2-riskCountry"/>
							<xsl:call-template name="t2-riskNature"/>
							<xsl:call-template name="t2-subType"/>
							<xsl:call-template name="t2-taxCountry"/>
							<xsl:call-template name="t2-tradable"/>
							<xsl:call-template name="t2-type"/>
							<xsl:call-template name="t2-valuationRule"/>
							<xsl:call-template name="t2-openingDate"/>
							<xsl:call-template name="t2-interestAccrualDate"/>
							<xsl:call-template name="t2-closingDate"/>
							<xsl:call-template name="t2-eomConvention"/>
							<xsl:call-template name="t2-client"/>
							<xsl:call-template name="t2-parentCashAccount"/>
							<xsl:call-template name="t2-portfolio"/>
							<xsl:call-template name="t2-suspenseAccount"/>
							<xsl:call-template name="t2-witholdingTax"/>
						</CashAccount>
					</xsl:if>
				</xsl:for-each>
				<!-- END - For accountNosGroup -->
				<!-- BEG - For incAccountNoGroup -->
				<xsl:for-each select="b:incAccountNoGroup">
					<xsl:variable name="currentAccountNo" select="b:incAccountNo"/>
					<xsl:if test="not(../../../c:PreviousEvent/b:PortfolioCashAccounts/b:incAccountNoGroup[b:incAccountNo = $currentAccountNo])">
						<CashAccount>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PortfolioCashAccounts.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="t3-infra-code"/>
							<xsl:call-template name="t3-infra-synonym"/>
							<xsl:call-template name="t3-infra-shortName"/>
							<xsl:call-template name="t3-infra-longName"/>
							<xsl:call-template name="t3-infra-multilingualLongName"/>
							<xsl:call-template name="t3-infra-notepad"/>
							<xsl:call-template name="t3-infra-userDefinedField"/>
							<xsl:call-template name="t3-infra-mbFields"/>
							<xsl:call-template name="t3-accrualRule"/>
							<xsl:call-template name="t3-accruedInterestCalculation"/>
							<xsl:call-template name="t3-accruedInterestRoundingRule"/>
							<xsl:call-template name="t3-accruedInterestRoundingUnit"/>
							<xsl:call-template name="t3-accruedInterestUnitaryRounding"/>
							<xsl:call-template name="t3-active"/>
							<xsl:call-template name="t3-euroConversionDate"/>
							<xsl:call-template name="t3-euroConversionRule"/>
							<xsl:call-template name="t3-euroNewInstrument"/>
							<xsl:call-template name="t3-mainBusinessEntity"/>
							<xsl:call-template name="t3-priceCalculationRule"/>
							<xsl:call-template name="t3-referenceCurrency"/>
							<xsl:call-template name="t3-riskCountry"/>
							<xsl:call-template name="t3-riskNature"/>
							<xsl:call-template name="t3-subType"/>
							<xsl:call-template name="t3-taxCountry"/>
							<xsl:call-template name="t3-tradable"/>
							<xsl:call-template name="t3-type"/>
							<xsl:call-template name="t3-valuationRule"/>
							<xsl:call-template name="t3-openingDate"/>
							<xsl:call-template name="t3-interestAccrualDate"/>
							<xsl:call-template name="t3-closingDate"/>
							<xsl:call-template name="t3-eomConvention"/>
							<xsl:call-template name="t3-client"/>
							<xsl:call-template name="t3-parentCashAccount"/>
							<xsl:call-template name="t3-portfolio"/>
							<xsl:call-template name="t3-suspenseAccount"/>
							<xsl:call-template name="t3-witholdingTax"/>
						</CashAccount>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="../../c:PreviousEvent/b:PortfolioCashAccounts/b:incAccountNoGroup">
					<xsl:variable name="previousAccountNo" select="b:incAccountNo"/>
					<xsl:if test="not(../../../c:CurrentEvent/b:PortfolioCashAccounts/b:incAccountNoGroup[b:incAccountNo = $previousAccountNo])">
						<CashAccount>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('PortfolioCashAccounts.xsl+', name(/*), '+', ../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:eventId, '+', ../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../../../c:CurrentEvent/b:PortfolioCashAccounts/b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<xsl:call-template name="t4-infra-code"/>
							<xsl:call-template name="t4-infra-synonym"/>
							<xsl:call-template name="t4-infra-shortName"/>
							<xsl:call-template name="t4-infra-longName"/>
							<xsl:call-template name="t4-infra-multilingualLongName"/>
							<xsl:call-template name="t4-infra-notepad"/>
							<xsl:call-template name="t4-infra-userDefinedField"/>
							<xsl:call-template name="t4-infra-mbFields"/>
							<xsl:call-template name="t4-accrualRule"/>
							<xsl:call-template name="t4-accruedInterestCalculation"/>
							<xsl:call-template name="t4-accruedInterestRoundingRule"/>
							<xsl:call-template name="t4-accruedInterestRoundingUnit"/>
							<xsl:call-template name="t4-accruedInterestUnitaryRounding"/>
							<xsl:call-template name="t4-active"/>
							<xsl:call-template name="t4-euroConversionDate"/>
							<xsl:call-template name="t4-euroConversionRule"/>
							<xsl:call-template name="t4-euroNewInstrument"/>
							<xsl:call-template name="t4-mainBusinessEntity"/>
							<xsl:call-template name="t4-priceCalculationRule"/>
							<xsl:call-template name="t4-referenceCurrency"/>
							<xsl:call-template name="t4-riskCountry"/>
							<xsl:call-template name="t4-riskNature"/>
							<xsl:call-template name="t4-subType"/>
							<xsl:call-template name="t4-taxCountry"/>
							<xsl:call-template name="t4-tradable"/>
							<xsl:call-template name="t4-type"/>
							<xsl:call-template name="t4-valuationRule"/>
							<xsl:call-template name="t4-openingDate"/>
							<xsl:call-template name="t4-interestAccrualDate"/>
							<xsl:call-template name="t4-closingDate"/>
							<xsl:call-template name="t4-eomConvention"/>
							<xsl:call-template name="t4-client"/>
							<xsl:call-template name="t4-parentCashAccount"/>
							<xsl:call-template name="t4-portfolio"/>
							<xsl:call-template name="t4-suspenseAccount"/>
							<xsl:call-template name="t4-witholdingTax"/>
						</CashAccount>
					</xsl:if>
				</xsl:for-each>
				<!-- END - For incAccountNoGroup -->
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