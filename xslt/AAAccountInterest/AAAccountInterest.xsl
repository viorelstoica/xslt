<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/AAAccountInterest"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchAAAccountInterest" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiAAAccountInterest" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiAAAccountInterest" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiAAAccountInterest">
		<xsl:apply-templates select="c:CurrentEvent/b:AAAccountInterest"/>
	</xsl:template>
	<xsl:template match="batch:BatchAAAccountInterest">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchAAAccountInterest" name="BatchAAAccountInterest">
			<xsl:apply-templates select="b:AAAccountInterest"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiAAAccountInterest">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiAAAccountInterest" name="BatchMultiAAAccountInterest">
			<xsl:apply-templates select="c:MultiAAAccountInterest"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:AAAccountInterest">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('AAAccountInterest',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Event>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('AAAccountInterest.xsl+', name(/*), '+', b:eventCommonDetails/b:eventCommon/ns0:eventId, '+', b:eventCommonDetails/b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommonDetails/b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<floatingCondition>
						<xsl:call-template name="benchmark"/>
						<xsl:call-template name="endDate"/>
						<xsl:call-template name="firstBenchmarkDate"/>
						<xsl:call-template name="firstResetDate"/>
						<xsl:call-template name="interestRate"/>
						<xsl:call-template name="maximumRate"/>
						<xsl:call-template name="minimumRate"/>
						<xsl:call-template name="resetFrequencyNumber"/>
						<xsl:call-template name="resetFrequencyUnit"/>
						<xsl:call-template name="scheduledDate"/>
						<xsl:call-template name="validityDate"/>
						<xsl:call-template name="spreadRate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="instrument"/>
					</floatingCondition>
				</Event>
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