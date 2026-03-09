<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurityCob" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurityCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurityCob"  xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurityCob" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiFinancialInstrumentSecurityCob">
		<xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSecurityCob"/>
	</xsl:template>
	<xsl:template match="batch:BatchFinancialInstrumentSecurityCob">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurityCob" name="BatchFinancialInstrumentSecurityCob">
			<xsl:apply-templates select="b:FinancialInstrumentSecurityCob"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiFinancialInstrumentSecurityCob">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurityCob" name="BatchMultiFinancialInstrumentSecurityCob">
			<xsl:apply-templates select="c:MultiFinancialInstrumentSecurityCob"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:FinancialInstrumentSecurityCob">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('FinancialInstrumentSecurityCob',b:id)"/>
			</xsl:attribute>
			<xsl:if test="b:interestRateGroup/b:rateChDate and b:interestRateGroup/b:rateChDate != ''">
				<xsl:for-each select="b:interestRateGroup">
					<xsl:variable name="index" select="./@index"/>
					<DataGroup>
						<Event>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('FinancialInstrumentSecurityCob.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:attribute>
							<interestSchedule>
								<xsl:call-template name="interestSchedule_endDate"/>
								<xsl:call-template name="interestSchedule_interestRate"/>
								<xsl:call-template name="interestSchedule_scheduledDate"/>
								<xsl:call-template name="interestSchedule_validityDate"/>
								<xsl:call-template name="interestSchedule_instrument"/>
								<xsl:call-template name="interestSchedule_mbFields"/>
							</interestSchedule>
							<xsl:call-template name="userDefinedField"/>
						</Event>                 
					</DataGroup>
				</xsl:for-each>
			</xsl:if>
            <!--  Coupon Schedule - Income Event -->
            <xsl:variable name="irregularCouponToBePaid">
                  <xsl:call-template name="irregularCoupon"/>
            </xsl:variable>
            <xsl:if test="($g_filterBySubAssetType ='Y' and contains($list_SubAssetType_IrregularCoupon,b:subAssetType)) or ($g_filterBySubAssetType ='N' and $irregularCouponToBePaid = 'Y')">
                <DataGroup>
					<Event>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('FinancialInstrumentSecurityCob.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<coupon>
							<xsl:call-template name="ie_beginDate"/>
							<xsl:call-template name="ie_coupon"/>
							<xsl:call-template name="ie_code"/>
							<xsl:call-template name="ie_currency"/>
							<xsl:call-template name="ie_endValidityDate"/>
							<xsl:call-template name="ie_exchangeRate"/>
							<xsl:call-template name="ie_exDate"/>
							<xsl:call-template name="ie_firstCouponDate"/>
							<xsl:call-template name="ie_validityDate"/>
							<xsl:call-template name="ie_mbFields"/>
							<xsl:call-template name="ie_instrument"/>
						</coupon>
					</Event>
				</DataGroup>
			</xsl:if>
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