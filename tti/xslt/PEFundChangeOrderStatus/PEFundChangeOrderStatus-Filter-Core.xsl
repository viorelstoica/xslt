<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/F2B"
    xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
	<xsl:template match="b:PECustomerTxn">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:tapRefId and ../../c:CurrentEvent/b:PECustomerTxn/b:tapRefId != '']" mode="filter1"/>
    </xsl:template> 
	<xsl:template match="b:PECustomerTxn" mode="filter1">
		<xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE']" mode="filter-custo"/>
    </xsl:template> 
    <xsl:template match="b:PECustomerTxn" mode="filter-custo">
        <xsl:apply-templates select="self::b:PECustomerTxn[../../c:CurrentEvent/b:PECustomerTxn/b:commitmentStatus = 'PROVISIONAL' and not(../../c:PreviousEvent/b:PECustomerTxn/b:commitmentStatus = 'PROVISIONAL') or (../../c:CurrentEvent/b:PECustomerTxn/b:commitmentStatus = 'FINAL') and (../../c:PreviousEvent/b:PECustomerTxn/b:commitmentStatus = 'PROVISIONAL')]" mode="filter-final"/>
    </xsl:template>
	<xsl:template match="b:PECustomerTxn" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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