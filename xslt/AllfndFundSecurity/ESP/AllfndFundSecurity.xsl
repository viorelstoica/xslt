<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AllfndFundSecurity"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAllfndFundSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAllfndFundSecurity" xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAllfndFundSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiAllfndFundSecurity">
		<xsl:apply-templates select="c:CurrentEvent/b:AllfndFundSecurity"/>
	</xsl:template>
	<xsl:template match="batch:BatchAllfndFundSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAllfndFundSecurity" name="BatchAllfndFundSecurity">
			<xsl:apply-templates select="b:AllfndFundSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiAllfndFundSecurity">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAllfndFundSecurity" name="BatchMultiAllfndFundSecurity">
			<xsl:apply-templates select="c:MultiAllfndFundSecurity"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:AllfndFundSecurity">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('AllfndFundSecurity',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<FundShare>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('AllfndFundSecurity.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
					<xsl:call-template name="infra:userDefinedField-custo"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="active"/>
				</FundShare>
				
				<FundsCatalogue>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('AllfndFundSecurity.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="FundsCatalogue_code"/>
					<xsl:call-template name="FundsCatalogue_synonym"/>
					<xsl:call-template name="FundsCatalogue_shortName"/>
					<xsl:call-template name="FundsCatalogue_longName"/>
					<xsl:call-template name="FundsCatalogue_multilingualLongName"/>
					<xsl:call-template name="FundsCatalogue_notepad"/>
					<xsl:call-template name="FundsCatalogue_userDefinedField"/>
					<xsl:call-template name="FundsCatalogue_mbFields"/>
					<xsl:call-template name="FundsCatalogue_instrument"/>
					<xsl:call-template name="FundsCatalogue_initialShares"/>
					<xsl:call-template name="FundsCatalogue_additionalShares"/>
					<xsl:call-template name="FundsCatalogue_maximumAmount"/>
					<xsl:call-template name="FundsCatalogue_maximumShares"/>
					<xsl:call-template name="FundsCatalogue_decimalsForShares"/>
					<xsl:call-template name="FundsCatalogue_decimalsForAmount"/>
					<xsl:call-template name="FundsCatalogue_decimalsForPrice"/>
					<xsl:call-template name="FundsCatalogue_RecomHoldingPeriod"/>
				</FundsCatalogue>
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