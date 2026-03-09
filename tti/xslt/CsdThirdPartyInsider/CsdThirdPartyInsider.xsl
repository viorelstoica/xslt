<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
				xmlns:b="http://www.temenos.com/T24/event/TTI/CsdThirdPartyInsider" 
				
				xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCsdThirdPartyInsider"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdThirdPartyInsider" 
				xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCsdThirdPartyInsider" 
				
				exclude-result-prefixes="b ns0" version="1.0">

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>

	<xsl:template match="c:MultiCsdThirdPartyInsider">
		<xsl:apply-templates select="c:CurrentEvent/b:CsdThirdPartyInsider"/>
	</xsl:template>
	<xsl:template match="batch:BatchCsdThirdPartyInsider">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCsdThirdPartyInsider" name="BatchCsdThirdPartyInsider">
			<xsl:apply-templates select="b:CsdThirdPartyInsider"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCsdThirdPartyInsider">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCsdThirdPartyInsider" name="BatchMultiCsdThirdPartyInsider">
			<xsl:apply-templates select="c:MultiCsdThirdPartyInsider"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="b:CsdThirdPartyInsider">
		<generic>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CsdThirdPartyInsider',b:id)"/>
			</xsl:attribute>
			<entity>
				<xsl:attribute name="name"/>
				<xsl:attribute name="parent">ude_third_party_insider</xsl:attribute>
				<xsl:attribute name="mode">INSUPD</xsl:attribute>
				<records>
					<xsl:for-each select="b:csdInsidIsinGroup[1]/b:csdInsidIsinSubGroup[@index]">
						<record>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('CsdThirdPartyInsider.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<attributes>
								<xsl:call-template name="userDefinedField"/>
							</attributes>
						</record>
					</xsl:for-each>
				</records>
			</entity>
		</generic>
	</xsl:template>
</xsl:stylesheet>