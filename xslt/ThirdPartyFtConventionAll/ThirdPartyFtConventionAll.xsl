<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CginventoryAll" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCginventoryAll" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCginventoryAll" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCginventoryAll" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCginventoryAll">
		<xsl:apply-templates select="c:CurrentEvent/b:CginventoryAll"/>
	</xsl:template>
	<xsl:template match="batch:BatchCginventoryAll">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCginventoryAll" name="BatchCginventoryAll">
			<xsl:apply-templates select="b:CginventoryAll"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCginventoryAll">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCginventoryAll" name="BatchMultiCginventoryAll">
			<xsl:apply-templates select="c:MultiCginventoryAll"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CginventoryAll">
			<ClientPMS>
				<xsl:attribute name="mode">INSUPD</xsl:attribute>
				<xsl:attribute name="output">
					<xsl:value-of select="concat('ThirdPartyFtConventionAll',b:id)"/>
				</xsl:attribute>
				<DataGroup>
					<ThirdPartyFtConvention>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('ThirdPartyFtConventionAll.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="beginD"/>
						<xsl:call-template name="ftConvention"/>
						<xsl:call-template name="third"/>
					</ThirdPartyFtConvention>
				</DataGroup>
			</ClientPMS>
	</xsl:template>
</xsl:stylesheet>