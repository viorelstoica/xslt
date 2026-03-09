<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerDocument" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomerDocument" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomerDocument"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomerDocument" xmlns:infra="http://www.odcgroup.com/InfraPMS">

	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="title">
		<title>
			<xsl:value-of select="substring-after(b:id,'*')"/>
		</title>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="substring-after(b:id,'*')"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="documentOwner">
		<documentOwner>
			<infra:code>
				<xsl:value-of select="substring-before(b:id,'*')"/>
			</infra:code>
		</documentOwner>
	</xsl:template>
	<xsl:template name="expiryDate">
		<xsl:if test="b:endDate and b:endDate != ''">
			<expiryDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:endDate"/>
				</xsl:call-template>
			</expiryDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="receivedDate">
		<xsl:if test="b:statusDate and b:statusDate != ''">
			<receivedDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:statusDate"/>
				</xsl:call-template>
			</receivedDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="documentCopy">
		<documentCopy>
			<xsl:choose>
				<xsl:when test="b:documentNature = 'ORIGINAL'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:documentNature = 'DUPLICATE'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</documentCopy>
	</xsl:template>
	<xsl:template name="referenceId">
		<xsl:choose>
			<xsl:when test="b:referenceNo and b:referenceNo != ''">
				<referenceId>
					<xsl:value-of select="b:referenceNo"/>
				</referenceId>
			</xsl:when>
			<xsl:otherwise>
				<referenceId>
					<xsl:value-of select="'NULL'"/>
				</referenceId>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="language">
		<language>
			<xsl:value-of select="'en'"/>
		</language>
	</xsl:template>

	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>

	<xsl:template name="document">
		<document>
			<xsl:value-of select="b:id"/>
		</document>
	</xsl:template>
	<xsl:template name="client">
		<client>
			<infra:code>
				<xsl:value-of select="substring-before(b:id,'*')"/>
			</infra:code>
		</client>
	</xsl:template>

	<xsl:template name="userDefinedField_ClientDocumentLink"/>
	<xsl:template name="mbFields_ClientDocumentLink"/>
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