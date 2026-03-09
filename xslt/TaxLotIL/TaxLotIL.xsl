<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CgTxnBase"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCgTxnBase" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCgTxnBase" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCgTxnBase" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCgTxnBase">
		<xsl:apply-templates select="c:CurrentEvent/b:CgTxnBase"/>
	</xsl:template>
	<xsl:template match="batch:BatchCgTxnBase">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCgTxnBase" name="BatchCgTxnBase">
			<xsl:apply-templates select="b:CgTxnBase"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCgTxnBase">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCgTxnBase" name="BatchMultiCgTxnBase">
			<xsl:apply-templates select="c:MultiCgTxnBase"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CgTxnBase">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TaxLotIL',b:id)"/>
			</xsl:attribute>
			<xsl:for-each select="b:tradeDateTimeGroup/b:purTaxLotIdSubGroup/b:purTaxLotId[../b:taxLotStatus='OPEN']">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLotIL.xsl+',name(/*),'+', ../../../b:eventCommon/ns0:eventId, '+', ../../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount"/>
						<xsl:call-template name="beginDate"/>
						<xsl:call-template name="impact"/>
						<xsl:call-template name="inputNature"/>
						<xsl:call-template name="instrument"/>
						<xsl:call-template name="movementNature"/>
						<xsl:call-template name="taxLotSourceCode"/>
						<xsl:call-template name="opSourceCode"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="posFeesTaxesAmount"/>
						<xsl:call-template name="posGrossAmount"/>
						<xsl:call-template name="posIndexedAmount"/>
						<xsl:call-template name="posNetAmount"/>
						<xsl:call-template name="posPlDiscountedAmount"/>
						<xsl:call-template name="posPlIndexedAmount"/>
						<xsl:call-template name="posPlLtGrossAmount"/>
						<xsl:call-template name="posPlLtNetAmount"/>
						<xsl:call-template name="posPlNonDiscAmount"/>
						<xsl:call-template name="posPlStGrossAmount"/>
						<xsl:call-template name="posPlStNetAmount"/>
						<xsl:call-template name="posReducedAmount"/>
						<xsl:call-template name="price"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="quote"/>
						<xsl:call-template name="taxEffectiveDate"/>
					</TaxLot>
				</DataGroup>
			</xsl:for-each>
			<xsl:for-each select="b:tradeDateTimeGroup/b:taxLotId[../b:taxLotStatus='OPEN']">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLotIL.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_taxLotId"/>
						<xsl:call-template name="beginDate_taxLotId"/>
						<xsl:call-template name="impact_taxLotId"/>
						<xsl:call-template name="inputNature_taxLotId"/>
						<xsl:call-template name="instrument_taxLotId"/>
						<xsl:call-template name="movementNature_taxLotId"/>
						<xsl:call-template name="taxLotSourceCode_taxLotId"/>
						<xsl:call-template name="opSourceCode_taxLotId"/>
						<xsl:call-template name="portfolio_taxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_taxLotId"/>
						<xsl:call-template name="posGrossAmount_taxLotId"/>
						<xsl:call-template name="posIndexedAmount_taxLotId"/>
						<xsl:call-template name="posNetAmount_taxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_taxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_taxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_taxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_taxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlStNetAmount_taxLotId"/>
						<xsl:call-template name="posReducedAmount_taxLotId"/>
						<xsl:call-template name="price_taxLotId"/>
						<xsl:call-template name="quantity_taxLotId"/>
						<xsl:call-template name="quote_taxLotId"/>
						<xsl:call-template name="taxEffectiveDate_taxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:for-each>
		</TransactionPMS>
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