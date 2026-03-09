<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/T24StatusChangeCancelUpdate"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchT24StatusChangeCancelUpdate" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiT24StatusChangeCancelUpdate" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiT24StatusChangeCancelUpdate" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<!-- START of protected area  -->

	<!-- END of protected area  -->


	<xsl:template name="requestStatus">
		<xsl:variable name="operationStatusValue">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage">
					<xsl:value-of select="b:eventCommon/ns0:transactionStage"/>
				</xsl:with-param>
				<xsl:with-param name="recordStatus">
					<xsl:value-of select="b:recordStatus"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<requestStatus>
			<xsl:choose>
				<xsl:when test="$operationStatusValue = 'INPUT-AUTHORISE' and (b:orderStatus != 'Cancellation Rejected' or b:orderStatus = '' or not(b:orderStatus)) and(b:dealStatus = 'CANCELLED' or b:dealStatus = 'TRANSMITTED' or b:dealStatus = '' or not(b:dealStatus)) ">
					<xsl:value-of select="50"/>
				</xsl:when>
				<xsl:when test="b:orderStatus = 'Cancellation Rejected' or $operationStatusValue = 'INPUT-DELETE'">
					<xsl:value-of select="60"/>
				</xsl:when>
				<!-- BEG - JPP/JPP20240924 - for GWP issue add 50 for REVERSE-AUTHORISE -->
				<xsl:when test="$operationStatusValue = 'REVERSE-AUTHORISE' and b:orderStatus = 'Int Cancellation Accepted'">
					<xsl:value-of select="50"/>
				</xsl:when>
				<!-- END - JPP/JPP20240924 - for GWP issue add 50 REVERSE-AUTHORISE -->
			</xsl:choose>
		</requestStatus>
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