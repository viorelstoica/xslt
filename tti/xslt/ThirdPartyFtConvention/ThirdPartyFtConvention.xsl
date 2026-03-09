<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Cginventory" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCginventory" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCginventory" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCginventory" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCginventory">
		<xsl:apply-templates select="c:CurrentEvent/b:Cginventory"/>
	</xsl:template>
	<xsl:template match="batch:BatchCginventory">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCginventory" name="BatchCginventory">
			<xsl:apply-templates select="b:Cginventory"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCginventory">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCginventory" name="BatchMultiCginventory">
			<xsl:apply-templates select="c:MultiCginventory"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:Cginventory">
			<ClientPMS>
				<xsl:attribute name="mode">INSUPD</xsl:attribute>
				<xsl:attribute name="output">
					<xsl:value-of select="concat('ThirdPartyFtConvention',b:id)"/>
				</xsl:attribute>
				<DataGroup>
					<ThirdPartyFtConvention>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('ThirdPartyFtConvention.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
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