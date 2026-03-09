<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="transactionCode">
		<xsl:choose>
			<xsl:when test="b:traspasoTapRefId != ''">
				<transactionCode>
					<xsl:value-of select="b:traspasoTapRefId"/>
				</transactionCode>
			</xsl:when>
			<xsl:when test="b:tapRefId != ''">
				<transactionCode>
					<xsl:value-of select="b:tapRefId"/>
				</transactionCode>
			</xsl:when>
			<xsl:otherwise>
				<transactionCode>
					<xsl:choose>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select="concat(b:tapOperCode,'_','ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat('ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</transactionCode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="type">
		<xsl:choose>
			<xsl:when test="b:transactionType = $transferTraspasoInTransactionType"/>
			<xsl:otherwise>
				<type>
					<infra:code>
						<xsl:value-of select="concat('SC_',b:transactionType)"/>
					</infra:code>
				</type>
			</xsl:otherwise>
		</xsl:choose>
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