<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPECustomerTxn">
		<xsl:apply-templates select="c:CurrentEvent/b:PECustomerTxn"/>
	</xsl:template>
	<xsl:template match="batch:BatchPECustomerTxn">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn" name="BatchPECustomerTxn">
			<xsl:apply-templates select="b:PECustomerTxn"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPECustomerTxn">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn" name="BatchMultiPECustomerTxn">
			<xsl:apply-templates select="c:MultiPECustomerTxn"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PECustomerTxn">
		<Event>
			<xsl:attribute name="mode">UPDATE</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('eventStatus',b:CashAccount/b:id)"/>
				<xsl:value-of select="b:serviceResponse/*/b:transactionId"/>
			</xsl:attribute>
			<DataGroup>
				<EventStatus>
					<xsl:call-template name="identifier"/>
					<xsl:call-template name="requestStatus"/>
					<xsl:call-template name="errorReason"/>
					<xsl:call-template name="errorInfo"/>
					<xsl:call-template name="userDefinedField"/>
					<xsl:call-template name="mbFields"/>
				</EventStatus>
			</DataGroup>
		</Event>
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