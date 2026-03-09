<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsForex"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPositionsForex">
		<xsl:apply-templates select="c:CurrentEvent/b:PositionsForex"/>
	</xsl:template>
	<xsl:template match="batch:BatchPositionsForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" name="BatchPositionsForex">
			<xsl:apply-templates select="b:PositionsForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPositionsForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" name="BatchMultiPositionsForex">
			<xsl:apply-templates select="c:MultiPositionsForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PositionsForex">
		<PositionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('positionsFXForward',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<ForwardPosition>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('PositionsFXForward.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="accountNetAmount"/>
					<xsl:call-template name="account2"/>
					<xsl:call-template name="cashAccount"/>
					<xsl:call-template name="expirationDate"/>
					<xsl:call-template name="forward"/>
					<xsl:call-template name="forwardRate"/>
					<xsl:call-template name="fxClientRate"/>
					<xsl:call-template name="fxMargin"/>
					<xsl:call-template name="fxMarginP"/>
					<xsl:call-template name="fxMarketRate"/>
					<xsl:call-template name="fxRateDirection"/>
					<xsl:call-template name="initialLoadDate"/>
					<xsl:call-template name="nature"/>
					<xsl:call-template name="operationDate"/>
					<xsl:call-template name="portfolio"/>
					<xsl:call-template name="positionCode"/>
					<xsl:call-template name="positionCurrency"/>
					<xsl:call-template name="quantity"/>
					<xsl:call-template name="sourceCode"/>
					<xsl:call-template name="spotRate"/>
					<xsl:call-template name="status"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valueDate"/>
					<xsl:call-template name="operationGrossAmount"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</ForwardPosition>
			</DataGroup>
		</PositionPMS>
	</xsl:template>
	<!-- End of Template . -->
</xsl:stylesheet>