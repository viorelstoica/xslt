<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="instrument">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:id"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="dataNature">
		<dataNature>
			<xsl:value-of select="'0'"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="validity">
		<xsl:choose>
			<xsl:when test="../b:beginDate and ../b:beginDate !=''">
				<validity>
					<xsl:value-of select="../b:beginDate"/>
				</validity>
			</xsl:when>
			<xsl:otherwise>
				<validity>
					<xsl:value-of select="../../b:eventCommon/ns0:today"/>
				</validity>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="calculationRule">
		<calculationRule>
			<xsl:choose>
				<xsl:when test="../b:calculationRule = 'PERCENTAGE.OF.AMOUNT'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="../b:calculationRule = 'AMOUNT.PER.UNIT'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="../b:calculationRule = 'MINIMUM.FEES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="../b:calculationRule = 'POSITIVE.PERFORMANCE.ONLY'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="../b:calculationRule = 'POSITIVE.AND.NEGATIVE.PERFORMANCE'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</calculationRule>
	</xsl:template>
	<xsl:template name="rank"/>
	<xsl:template name="currency">
		<currency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</currency>
	</xsl:template>
	<xsl:template name="value">
		<value>
			<xsl:value-of select="../b:amount"/>
		</value>
	</xsl:template>
	<xsl:template name="maximumRange">
		<maximumRange>
			<xsl:value-of select="../b:maxRange"/>
		</maximumRange>
	</xsl:template>
	<xsl:template name="minimumRange">
		<minimumRange>
			<xsl:value-of select="../b:minRange"/>
		</minimumRange>
	</xsl:template>
	<xsl:template name="feeType">
		<feeType>
			<xsl:value-of select="."/>
		</feeType>
	</xsl:template>
	<xsl:template name="quotationCode">
		<quotationCode>
			<xsl:value-of select="../b:quotationCode"/>
		</quotationCode>
	</xsl:template>
	<xsl:template name="exanteExpost">
		<exanteExpost>
			<xsl:choose>
				<xsl:when test="../b:exAnteExPost = 'EX.ANTE'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="../b:exAnteExPost = 'EX.POST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</exanteExpost>
	</xsl:template>
	<xsl:template name="category">
		<category>
			<xsl:value-of select="../b:category"/>
		</category>
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