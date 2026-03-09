<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                 exclude-result-prefixes="b" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B/b:DataGroup/b:Security/b:Cancellation/b:Request">
				<T24>
					<serviceRequest>
						<securityContext>
							<xsl:choose>
								<xsl:when test="b:mainBusinessEntity/infra:code and b:mainBusinessEntity/infra:code != ''">
									<company>
										<xsl:value-of select="b:mainBusinessEntity/infra:code"/>
									</company>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="b:mainBusinessEntity/infra:synonym/infra:code and b:mainBusinessEntity/infra:synonym/infra:code !=''">
										<company>
											<xsl:value-of select="b:mainBusinessEntity/infra:synonym/infra:code"/>
										</company>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</securityContext>
						<xsl:choose>
							<xsl:when test="(b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13') and (b:userDefinedField[infra:name='ud_instr_traspasos_f']/infra:value = '1') and (b:buySellIndicator = '4')">
									<ofsTransactionInput application="ESFUND.TRASPASO.REQUEST" operation="PROCESS" version="{$TRASPASO_IN}">
										<xsl:call-template name="instruction.ESFUND.TRASPASO.REQUEST"/>
									</ofsTransactionInput>
								</xsl:when>
						</xsl:choose>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="instruction.ESFUND.TRASPASO.REQUEST">
		<xsl:call-template name="TAP.EVENT.ID"/>
		<xsl:call-template name="transactionId"/>
		<xsl:call-template name="ORDER.STATUS"/>
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