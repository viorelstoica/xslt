<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:scexesecorders="http://www.temenos.com/T24/scexesecorders" exclude-result-prefixes="b" version="1.0">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:GlobalExecution">
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
							<xsl:when test="b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '1' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '2' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '11' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '13' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '18' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '19' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '12'">
								<ofsTransactionInput application="SC.EXE.SEC.ORDERS" operation="PROCESS" version="{$ScExeSecOrdersTapAuthVersion}">
									<xsl:call-template name="scexesecorders:transactionId"/>
									<xsl:call-template name="SC.EXE.SEC.ORDERS"/>
								</ofsTransactionInput>
							</xsl:when>
						</xsl:choose>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="SC.EXE.SEC.ORDERS">
		<xsl:call-template name="scexesecorders:KEY"/>
		<xsl:call-template name="scexesecorders:ORDER.NUMBER"/>
		<xsl:call-template name="scexesecorders:SECURITY.NO"/>
		<xsl:call-template name="scexesecorders:TRANSACTION.CODE"/>
		<xsl:call-template name="scexesecorders:ORDER.TYPE"/>
		<xsl:call-template name="scexesecorders:TRADE.CCY"/>
		<xsl:call-template name="scexesecorders:NOMINAL.BALANCE"/>
		<xsl:call-template name="scexesecorders:CUSTOMER.NO"/>
		<xsl:call-template name="scexesecorders:SECURITY.ACCT"/>
		<xsl:call-template name="scexesecorders:CUST.ACC.NO"/>
		<xsl:call-template name="scexesecorders:CUST.NOMINAL"/>
		<xsl:call-template name="scexesecorders:CUST.PRICE"/>
		<xsl:call-template name="scexesecorders:CU.CASH.AMOUNT"/>
		<xsl:call-template name="scexesecorders:CALC.CHRGS"/>
		<xsl:call-template name="scexesecorders:CASH.CHRGS"/>
		<xsl:call-template name="scexesecorders:SPLIT.CHRGS"/>
		<xsl:call-template name="scexesecorders:CASH.ROUNDING"/>
		<xsl:call-template name="scexesecorders:ADJUST.COMM"/>
		<xsl:call-template name="scexesecorders:CU.BRKR.COMM"/>
		<xsl:call-template name="scexesecorders:CU.FOREIGN.FEE"/>
		<xsl:call-template name="scexesecorders:CU.COMMISSION"/>
		<xsl:call-template name="scexesecorders:CU.COMM.TAX"/>
		<xsl:call-template name="scexesecorders:CU.STAMP.TAX"/>
		<xsl:call-template name="scexesecorders:CU.EBV.FEES"/>
		<xsl:call-template name="scexesecorders:CU.FEES.MISC"/>
		<xsl:call-template name="scexesecorders:CU.DISC.PCENT"/>
		<xsl:call-template name="scexesecorders:CU.DISC.AMT"/>
		<xsl:call-template name="scexesecorders:CU.WHT.PERC"/>
		<xsl:call-template name="scexesecorders:CU.WHT.TAX"/>
		<xsl:call-template name="scexesecorders:COMM.CODE"/>
		<xsl:call-template name="scexesecorders:COMM.PERCENT"/>
		<xsl:call-template name="scexesecorders:COM.TAX.CODE"/>
		<xsl:call-template name="scexesecorders:COM.TAX.BCUR"/>
		<xsl:call-template name="scexesecorders:COM.TAX.XRTE"/>
		<xsl:call-template name="scexesecorders:CU.EX.RATE.ACC"/>
		<xsl:call-template name="scexesecorders:CU.ACCOUNT.CCY"/>
		<xsl:call-template name="scexesecorders:CU.DEPOSITORY"/>
		<xsl:call-template name="scexesecorders:SUB.ACCOUNT"/>
		<xsl:call-template name="scexesecorders:CU.BROKER.NO"/>
		<xsl:call-template name="scexesecorders:CUST.AVG.PRICE"/>
		<xsl:call-template name="scexesecorders:CU.INT.CTR"/>
		<xsl:call-template name="scexesecorders:SEC.TRADE.ID"/>
		<xsl:call-template name="scexesecorders:CU.NOTES"/>
		<xsl:call-template name="scexesecorders:NARRATIVE"/>
		<xsl:call-template name="scexesecorders:CU.INCOME.ACC"/>
		<xsl:call-template name="scexesecorders:CU.INCOME.CCY"/>
		<xsl:call-template name="scexesecorders:BROKER.NO"/>
		<xsl:call-template name="scexesecorders:BROKER.TYPE"/>
		<xsl:call-template name="scexesecorders:BR.ACC.NO"/>
		<xsl:call-template name="scexesecorders:BR.SEC.ACCT"/>
		<xsl:call-template name="scexesecorders:NOMINAL.RECD"/>
		<xsl:call-template name="scexesecorders:PRICE"/>
		<xsl:call-template name="scexesecorders:RESERVED5"/>
		<xsl:call-template name="scexesecorders:BR.BROKER.COMM"/>
		<xsl:call-template name="scexesecorders:BR.FOREIGN.FEE"/>
		<xsl:call-template name="scexesecorders:CL.COMMISSION"/>
		<xsl:call-template name="scexesecorders:BR.STAMP.TAX"/>
		<xsl:call-template name="scexesecorders:BR.EBV.FEES"/>
		<xsl:call-template name="scexesecorders:BR.FEES.MISC"/>
		<xsl:call-template name="scexesecorders:BR.EX.RATE.ACC"/>
		<xsl:call-template name="scexesecorders:BR.ACCOUNT.CCY"/>
		<xsl:call-template name="scexesecorders:DELIVERY.INSTR"/>
		<xsl:call-template name="scexesecorders:TRADE.TIME"/>
		<xsl:call-template name="scexesecorders:BR.EXE.ADV.REF"/>
		<xsl:call-template name="scexesecorders:BR.TR.AL.REF"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.03"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.02"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.01"/>
		<xsl:call-template name="scexesecorders:TRADE.DATE"/>
		<xsl:call-template name="scexesecorders:VALUE.DATE"/>
		<xsl:call-template name="scexesecorders:DEPOSITORY"/>
		<xsl:call-template name="scexesecorders:STOCK.EXCHANGE"/>
		<xsl:call-template name="scexesecorders:MARKET.TYPE"/>
		<xsl:call-template name="scexesecorders:SETT.NARRATIVE"/>
		<xsl:call-template name="scexesecorders:ACCT.NARRATIVE"/>
		<xsl:call-template name="scexesecorders:ORDER.BROKER"/>
		<xsl:call-template name="scexesecorders:AMT.TO.BROKER"/>
		<xsl:call-template name="scexesecorders:EXE.BY.BROKER"/>
		<xsl:call-template name="scexesecorders:INT.CTR"/>
		<xsl:call-template name="scexesecorders:ORDER.STATUS"/>
		<xsl:call-template name="scexesecorders:ODD.LOT.ORDER"/>
		<xsl:call-template name="scexesecorders:TRADE.DEPT"/>
		<xsl:call-template name="scexesecorders:PRO.BR.CHGS"/>
		<xsl:call-template name="scexesecorders:CALC.AVG.PRICE"/>
		<xsl:call-template name="scexesecorders:TRADE.CREATION"/>
		<xsl:call-template name="scexesecorders:PRORATA.NOM"/>
		<xsl:call-template name="scexesecorders:CANCEL.REMAIN.ORD"/>
		<xsl:call-template name="scexesecorders:ROUT.COMPANY"/>
		<xsl:call-template name="scexesecorders:ROUT.SEC.ACC"/>
		<xsl:call-template name="scexesecorders:PRICE.SPREAD"/>
		<xsl:call-template name="scexesecorders:DEFAULT.CALC.CHG"/>
		<xsl:call-template name="scexesecorders:CUM.EX.IND"/>
		<xsl:call-template name="scexesecorders:WHT.TAX.CODE"/>
		<xsl:call-template name="scexesecorders:CHARGE.CALC.METHOD"/>
		<xsl:call-template name="scexesecorders:SEGMENT"/>
		<xsl:call-template name="scexesecorders:DEF.DEAL.DESK"/>
		<xsl:call-template name="scexesecorders:ACT.DEAL.DESK"/>
		<xsl:call-template name="scexesecorders:ADVICE.REQD"/>
		<xsl:call-template name="scexesecorders:MT502.REJ.REASON"/>
		<xsl:call-template name="scexesecorders:CONSOLIDATE.EXEC"/>
		<xsl:call-template name="scexesecorders:DAY.TRADE"/>
		<xsl:call-template name="scexesecorders:AUTHORISE.TRADE"/>
		<xsl:call-template name="scexesecorders:PARENT"/>
		<xsl:call-template name="scexesecorders:PARENT.REFERENCE"/>
		<xsl:call-template name="scexesecorders:RESERVED.5"/>
		<xsl:call-template name="scexesecorders:RESERVED.4"/>
		<xsl:call-template name="scexesecorders:RESERVED.3"/>
		<xsl:call-template name="scexesecorders:RESERVED.2"/>
		<xsl:call-template name="scexesecorders:RESERVED.1"/>
		<xsl:call-template name="scexesecorders:LOCAL.REF"/>
		<xsl:call-template name="scexesecorders:OVERRIDE"/>
		<xsl:call-template name="scexesecorders:RECORD.STATUS"/>
		<xsl:call-template name="scexesecorders:CURR.NO"/>
		<xsl:call-template name="scexesecorders:INPUTTER"/>
		<xsl:call-template name="scexesecorders:DATE.TIME"/>
		<xsl:call-template name="scexesecorders:AUTHORISER"/>
		<xsl:call-template name="scexesecorders:CO.CODE"/>
		<xsl:call-template name="scexesecorders:DEPT.CODE"/>
		<xsl:call-template name="scexesecorders:AUDITOR.CODE"/>
		<xsl:call-template name="scexesecorders:AUDIT.DATE.TIME"/>
		<xsl:call-template name="scexesecorders:EXE.HLT"/>
		<xsl:call-template name="scexesecorders:TRADE.HLT"/>
		<xsl:call-template name="scexesecorders:PARENT.CHILD.DEPO"/>
		<xsl:call-template name="scexesecorders:ROUNDING.FACTOR"/>
		<xsl:call-template name="scexesecorders:USERDEF.FIELDS"/>
		<xsl:call-template name="scexesecorders:ModelBankSpecificFields"/>
		<xsl:call-template name="scexesecorders:ModelBankSpecificFields-Custo"/>
		<xsl:call-template name="scexesecorders:TAP.SLEEVE.ACC"/>
		<xsl:call-template name="scexesecorders:TAP.SLEEVE.PTF"/>
		<xsl:call-template name="scexesecorders:TAP.REF.ID"/>
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