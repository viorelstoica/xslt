<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="identifier">
		<identifier>
			<xsl:value-of select="b:tapEventId"/>
		</identifier>
	</xsl:template>
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
				<xsl:when test="$operationStatusValue = 'INPUT-AUTHORISE' and b:commitmentStatus = 'CANCELLED'">
					<xsl:value-of select="50"/>
				</xsl:when>
				<xsl:when test="b:commitmentStatus = 'CANCELLED' or $operationStatusValue = 'INPUT-DELETE'">
					<xsl:value-of select="60"/>
				</xsl:when>
			</xsl:choose>
		</requestStatus>
	</xsl:template>
	<xsl:template name="errorReason">
		
	</xsl:template>
	<xsl:template name="errorInfo">
		
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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