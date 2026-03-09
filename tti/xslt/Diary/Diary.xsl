<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Diary"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDiary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDiary" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDiary"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiDiary">
		<xsl:apply-templates select="c:CurrentEvent/b:Diary"/>
	</xsl:template>
	<xsl:template match="batch:BatchDiary">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDiary" name="BatchDiary">
			<xsl:apply-templates select="b:Diary"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiDiary">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDiary" name="BatchMultiDiary">
			<xsl:apply-templates select="c:MultiDiary"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:Diary">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('Diary',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:for-each select="b:newSecNoGroup/b:newSecNoSubGroup">
					<xsl:variable name="positionVar" select="position()"/>
					<Event>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('Diary.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<corporateAction>
							<xsl:call-template name="cashSettlement"/>
							<xsl:call-template name="code"/>
							<xsl:call-template name="currency"/>
							<xsl:call-template name="endDate"/>
							<xsl:call-template name="endValidity"/>
							<xsl:call-template name="eventPriority">
								<xsl:with-param name="positionVar" select="$positionVar"/>
							</xsl:call-template>
							<xsl:call-template name="exchangeRate"/>
							<xsl:call-template name="exDate"/>
							<xsl:call-template name="instrument"/>
							<xsl:call-template name="nature"/>
							<xsl:call-template name="newInstrument"/>
							<xsl:call-template name="newRatio"/>
							<xsl:call-template name="oddLotCompensation"/>
							<xsl:call-template name="oldRatio"/>
							<xsl:call-template name="price"/>
							<xsl:call-template name="replaceOld"/>
							<xsl:call-template name="validityDate"/>
							<xsl:call-template name="mbFields"/>
						</corporateAction>
					</Event>
				</xsl:for-each>
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