<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- Filter out this flow since this is only ESP(Spain) business entity specific -->
	<xsl:template match="/"/>
	<!--<T24Batch>
			<xsl:if test="b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction">
				<xsl:for-each select="b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction">
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
			</xsl:if>
		</T24Batch>
	</xsl:template>
	<xsl:template name="instruction.ESFUND.TRASPASO.REQUEST">
		<xsl:call-template name="PORTFOLIO.ID"/>
		<xsl:call-template name="SOURCE.FUND"/>
		<xsl:call-template name="BIC.IDEN.BANK"/>
		<xsl:call-template name="EXT.BANK.NAME"/>
		<xsl:call-template name="AC.HOLDER"/>
		<xsl:call-template name="EXT.SEC.NO"/>
		<xsl:call-template name="TARGET.FUND"/>
		<xsl:call-template name="DEPOSITORY"/>
		<xsl:call-template name="REQUEST.TYPE"/>
		<xsl:call-template name="VALUE.TYPE"/>
		<xsl:call-template name="SHARES.ORDERED"/>
		<xsl:call-template name="NET.AMOUNT"/>
		<xsl:call-template name="TRADE.DATE"/>
		<xsl:call-template name="VALUE.DATE"/>
		<xsl:call-template name="REQUEST.DATE"/>
		<xsl:call-template name="TRANS.IN.STATUS"/>
		<xsl:call-template name="TAP.REF.ID"/>
		<xsl:call-template name="TAP.EVENT.ID"/>
	</xsl:template>-->
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
</metaInformation>
-->