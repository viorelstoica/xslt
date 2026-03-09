<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B_FORMAT/b:entity/b:records/b:record/b:attributes">
				<T24>
					<serviceRequest xmlns="http://www.temenos.com/T24/OFSML/150">
						<securityContext>
							<company>
								<xsl:value-of select="../@mainBusinessEntity"/>
							</company>
						</securityContext>
						<ofsTransactionInput application="CG.WASH.SALE.DETS" operation="PROCESS" version="{$CgWashSaleDetsVersion}">
							<xsl:call-template name="CG.WASH.SALE.DETS"/>
						</ofsTransactionInput>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="CG.WASH.SALE.DETS">
		<xsl:call-template name="ID"/>
		<xsl:call-template name="PORTFOLIO.ID"/>
		<xsl:call-template name="SECURITY.MASTER.ID"/>
		<xsl:call-template name="CG.TXN.BASE.ID"/>
		<xsl:call-template name="REPLACEMENT.TXN"/>
		<xsl:call-template name="SALE.TXN.1"/>
		<xsl:call-template name="ORIGINAL.TXN.ID-XX.XX"/>
		<xsl:call-template name="DISALLOWED.LOSS-XX-XX"/>
		<xsl:call-template name="DISALLOWED.LOTS-XX.XX"/>
		<xsl:call-template name="LOCAL.REF"/>
		<xsl:call-template name="USERDEF.FIELDS"/>
	    <xsl:call-template name="ModelBankSpecificFields"/>
	    <xsl:call-template name="ModelBankSpecificFields-Custo"/> 
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