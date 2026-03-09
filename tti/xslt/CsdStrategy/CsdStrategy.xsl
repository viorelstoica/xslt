<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdStrategy" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCsdStrategy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdStrategy" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCsdStrategy" exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiCsdStrategy">
		<xsl:apply-templates select="c:CurrentEvent/b:CsdStrategy"/>
	</xsl:template>
	<xsl:template match="batch:BatchCsdStrategy">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCsdStrategy" name="BatchCsdStrategy">
			<xsl:apply-templates select="b:CsdStrategy"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCsdStrategy">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCsdStrategy" name="BatchMultiCsdStrategy">
			<xsl:apply-templates select="c:MultiCsdStrategy"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:CsdStrategy">
		<generic>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CsdStrategy',b:id)"/>
			</xsl:attribute>
			<xsl:if test="(../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf and not(../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf)) or (../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf != (../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf))">
				<entity>
					<xsl:attribute name="name">strategy_link portfolio</xsl:attribute>
					<xsl:attribute name="mode">INSUPD</xsl:attribute>
					<records>
						<record>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('CsdStrategy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<attributes>
								<xsl:call-template name="businessEntityComposition"/>
								<xsl:call-template name="userDefinedField"/>
							</attributes>
						</record>
					</records>
				</entity>
			</xsl:if>
			<xsl:if test="(../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf != (../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf)) or (not(../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf) and (../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf))">
				<entity>
					<xsl:attribute name="name">strategy_link portfolio</xsl:attribute>
					<xsl:attribute name="mode">INSUPD</xsl:attribute>
					<records>
						<record>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('CsdStrategy.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<attributes>
								<xsl:call-template name="businessEntityComposition"/>
								<xsl:call-template name="userDefinedField_Previous"/>
							</attributes>
						</record>
					</records>
				</entity>
			</xsl:if>
		</generic>
	</xsl:template>
</xsl:stylesheet>