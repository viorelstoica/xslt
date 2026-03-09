<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScPosAsset"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchScPosAsset" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScPosAsset" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiScPosAsset"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiScPosAsset">
		<xsl:apply-templates select="c:CurrentEvent/b:ScPosAsset"/>
	</xsl:template>
	<xsl:template match="batch:BatchScPosAsset">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchScPosAsset" name="BatchScPosAsset">
			<xsl:apply-templates select="b:ScPosAsset"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiScPosAsset">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiScPosAsset" name="BatchMultiScPosAsset">
			<xsl:apply-templates select="c:MultiScPosAsset"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ScPosAsset">
		<generic>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('ScPosAsset',b:id)"/>
			</xsl:attribute>
			<entity>
				<xsl:attribute name="name"/>
				<xsl:attribute name="parent">ext_operation</xsl:attribute>

				<xsl:attribute name="mode">INSUPD</xsl:attribute>
				<records>
					<xsl:for-each select="b:securityNoGroup">
						<xsl:variable name="securityNo" select="b:securityNo"/>
						<xsl:variable name="index" select="@index"/>
						<xsl:variable name="varQuotationCode1" select="../b:QuotationCode1List/b:QuotationCode1[@index=$index]"/>
						<xsl:variable name="varQuotationCode2" select="../b:QuotationCode2List/b:QuotationCode2[@index=$index]"/>
						<xsl:if test="not(../b:securityNoGroup[@index &gt; $index]/b:securityNo = $securityNo)">
							<xsl:call-template name="mappingRecord">
								<xsl:with-param name="parQuotationCode1">
										<xsl:choose>
											<xsl:when test="$varQuotationCode1">
												<xsl:value-of select="$varQuotationCode1"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="'0'"/>
											</xsl:otherwise>
										</xsl:choose>
								</xsl:with-param>
								<xsl:with-param name="parQuotationCode2">
										<xsl:choose>
											<xsl:when test="$varQuotationCode2 and $varQuotationCode2 !='0'">
												<xsl:value-of select="$varQuotationCode2"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="'0'"/>
											</xsl:otherwise>
										</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</records>
			</entity>
		</generic>
	</xsl:template>


	<!-- BEG - Mapping for node record -->
	<xsl:template name="mappingRecord">
		<xsl:param name="parQuotationCode1"/>
		<xsl:param name="parQuotationCode2"/>

		<record>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('ScPosAssetIL.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<attributes>
				<xsl:call-template name="code"/>
				<xsl:call-template name="splitFxRateAndCurrency">
					<xsl:with-param name="quotationCode1">
						<xsl:value-of select="$parQuotationCode1"/>
					</xsl:with-param>
					<xsl:with-param name="quotationCode2">					
						<xsl:value-of select="$parQuotationCode2"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="splitFxRate1AndCurrency1">
					<xsl:with-param name="quotationCode1">			
						<xsl:value-of select="$parQuotationCode1"/>		
					</xsl:with-param>
					<xsl:with-param name="quotationCode2">			
						<xsl:value-of select="$parQuotationCode2"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="custoDefinitions"/>
				<xsl:call-template name="mbCustoDefinitions"/>
			</attributes>
		</record>
	</xsl:template>
	<!-- END - Mapping for node record -->
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