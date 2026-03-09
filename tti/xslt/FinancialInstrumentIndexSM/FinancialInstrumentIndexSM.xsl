<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentSecurity">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSecurity"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" name="BatchFinancialInstrumentSecurity">
			<xsl:apply-templates select="b:FinancialInstrumentSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" name="BatchMultiFinancialInstrumentSecurity">
			<xsl:apply-templates select="c:MultiFinancialInstrumentSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentSecurity">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentIndexSM',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Index>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('FinancialInstrumentIndexSM.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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
					<xsl:call-template name="active"/>
					<xsl:call-template name="euroConversionDate"/>
					<xsl:call-template name="euroConversionRule"/>
					<xsl:call-template name="euroNewInstrument"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="mainStockExchange"/>
					<xsl:call-template name="minimumQuantity"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="provider"/>
					<xsl:call-template name="referenceCurrency"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="roundLotQuantity"/>
					<xsl:call-template name="sector"/>
					<xsl:call-template name="stockExchange"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tickSize"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="baseDate"/>
					<xsl:call-template name="baseValue"/>
					<xsl:call-template name="calculationRule"/>
					<xsl:call-template name="dataSecuProf"/>
					<xsl:call-template name="divisor"/>
					<xsl:call-template name="forex"/>
					<xsl:call-template name="returnRule"/>
					<xsl:call-template name="timeRule"/>
					<xsl:call-template name="composition"/>
				</Index>
				<!--  START BusinessEntity Compo -->
				<xsl:if test="b:allowedCountryList/b:allowedCountry">
					<xsl:for-each select="b:allowedCountryList/b:allowedCountry">
					<xsl:variable name="beAllowedCountry">
						<xsl:call-template name="instrBusinessEntity">
							<xsl:with-param name="beAllowedCountry" select="."/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="not($beAllowedCountry = '')">
						<xsl:if test="not(. = ../../../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry)">
							<BusinessEntityComposition>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('FinancialInstrumentIndexSM.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="mode">INSUPD</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="infra:businessEntity"/>
								<xsl:call-template name="infra:mainBusinessEntity"/>
								<xsl:call-template name="infra:role"/>
								<xsl:call-template name="infra:type"/>
								<xsl:call-template name="infra:mbFields_becompo_inser"/>
								<xsl:call-template name="be_instrument"/>
							</BusinessEntityComposition>
						</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry">
					<xsl:for-each select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry">
					<xsl:variable name="beAllowedCountry">
						<xsl:call-template name="instrBusinessEntity">
							<xsl:with-param name="beAllowedCountry" select="."/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:if test="not($beAllowedCountry = '')">
						<xsl:if test="not(. = ../../../../c:CurrentEvent/b:FinancialInstrumentSecurity/b:allowedCountryList/b:allowedCountry)">
							<BusinessEntityComposition>
								<xsl:attribute name="description">
									<xsl:value-of select="concat('FinancialInstrumentIndexSM.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
								</xsl:attribute>
								<xsl:attribute name="mode">delete</xsl:attribute>
								<xsl:attribute name="sequenceNumber">
									<xsl:call-template name="calcSeqNum">
										<xsl:with-param name="creationTime">
											<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
								<xsl:call-template name="infra:businessEntity"/>
								<xsl:call-template name="infra:mainBusinessEntity"/>
								<xsl:call-template name="infra:role"/>
								<xsl:call-template name="infra:type"/>
								<xsl:call-template name="infra:mbFields_becompo_del"/>
								<xsl:call-template name="be_instrument"/>
							</BusinessEntityComposition>
						</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
				<!--  END BusinessEntity Compo -->
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