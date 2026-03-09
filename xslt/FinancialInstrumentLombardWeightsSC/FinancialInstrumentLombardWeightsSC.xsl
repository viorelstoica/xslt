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
		<FiPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentLombardWeightsSC',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:if test="(b:subAssetTypeMarginRateJoin and b:subAssetTypeMarginRateJoin !='') or (b:assetTypeMarginRateJoin and b:assetTypeMarginRateJoin!='') or(b:marginRateMarginControlJoin and b:marginRateMarginControlJoin !='')">
					<!--   Pledge Credit rate    -->
					<ChronologicalData>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentLombardWeightsSC.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="currency_C"/>
						<xsl:call-template name="dataNature_C"/>
						<xsl:call-template name="instrument_C"/>
						<xsl:call-template name="validity_C"/>
						<xsl:call-template name="value_C"/>
						<xsl:call-template name="provider_C"/>
						<xsl:call-template name="valueType_C"/>
						<xsl:call-template name="mbFields_C"/>
					</ChronologicalData>
				</xsl:if>
				<xsl:if test="(b:subAssetTypeMarginRateJoin and b:subAssetTypeMarginRateJoin !='') or (b:assetTypeMarginRateJoin and b:assetTypeMarginRateJoin!='') or(b:marginRateMarginControlJoin and b:marginRateMarginControlLossJoin !='')">
					<!--   Pledge Debit rate    -->
					<ChronologicalData>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentLombardWeightsSC.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="currency_D"/>
						<xsl:call-template name="dataNature_D"/>
						<xsl:call-template name="instrument_D"/>
						<xsl:call-template name="validity_D"/>
						<xsl:call-template name="value_D"/>
						<xsl:call-template name="provider_D"/>
						<xsl:call-template name="valueType_D"/>
						<xsl:call-template name="mbFields_D"/>
					</ChronologicalData>
				</xsl:if>
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