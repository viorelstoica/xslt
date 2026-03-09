<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransferUpdate"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransferUpdate" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransferUpdate" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransferUpdate" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="identifier">
		<identifier>
			<xsl:value-of select="b:tapEventId"/>
		</identifier>
	</xsl:template>
	<xsl:template name="requestStatus">
		<requestStatus>60</requestStatus>
	</xsl:template>
	<xsl:template name="errorReason"/>
	<xsl:template name="errorInfo"/>
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