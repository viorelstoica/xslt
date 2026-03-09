<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:fdFidOrder="http://www.temenos.com/T24/fdFidOrder" exclude-result-prefixes="b" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B_MM_FX/b:DataGroup/b:DepositLoan/b:Deposit/b:OrderLifeCycle/b:transfer">
				<T24 xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
					<serviceRequest xmlns="http://www.temenos.com/T24/OFSML/150">
						<securityContext>
							<xsl:if test="b:ownerBusinessEntity and b:ownerBusinessEntity != ''">
								<company>
									<xsl:value-of select="b:ownerBusinessEntity"/>
								</company>
							</xsl:if>
						</securityContext>
						<ofsTransactionInput application="FD.FID.ORDER" operation="PROCESS" version="{$FD_OPEN_CONTRACT_VERSION}">
							<xsl:call-template name="fdFidOrder:transactionId"/>
							<xsl:call-template name="FD.FID.ORDER"/>
						</ofsTransactionInput>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="FD.FID.ORDER">
		<xsl:call-template name="TAP.EVENT.ID"/>
		<xsl:call-template name="TAP.REF.ID"/>
		<xsl:call-template name="TRANSFER.TO.PORT"/>
		<xsl:call-template name="TRANSFER.EFF.DATE"/>
		<xsl:call-template name="TAP.FD.TRANSFER"/>
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