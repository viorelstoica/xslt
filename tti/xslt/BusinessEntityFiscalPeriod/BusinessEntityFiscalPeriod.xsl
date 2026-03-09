<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Company" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCompany" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCompany" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCompany" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCompany">
		<xsl:apply-templates select="c:CurrentEvent/b:Company"/>
	</xsl:template>
	<xsl:template match="batch:BatchCompany">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCompany" name="BatchCompany">
			<xsl:apply-templates select="b:Company"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCompany">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCompany" name="BatchMultiCompany">
			<xsl:apply-templates select="c:MultiCompany"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:Company">
		<InfraPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('BusinessEntityFiscalPeriod',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<BusinessEntity>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('BusinessEntityFiscalPeriod.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="code"/>
					<xsl:call-template name="fiscalPeriod"/>
				</BusinessEntity>
			</DataGroup>
		</InfraPMS>
	</xsl:template>
</xsl:stylesheet>