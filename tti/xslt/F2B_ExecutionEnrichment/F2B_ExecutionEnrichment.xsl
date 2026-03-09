<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:scexesecorders="http://www.temenos.com/T24/scexesecorders" exclude-result-prefixes="b" version="1.0">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:Execution/child::*">
				<T24>
					<serviceRequest>
						<securityContext>
							<xsl:choose>
								<xsl:when test="b:boRoutingBusinessEntityId and b:boRoutingBusinessEntityId != ''">
									<company>
										<xsl:value-of select="b:boRoutingBusinessEntityId"/>
									</company>
								</xsl:when>
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
							<xsl:when test="b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '1' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '2' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '11' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '13' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '18' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '19' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '12' or
							(b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '22' and contains($SP_SC_ORDERLIST,concat('',b:subType/infra:code,'')))">
								<xsl:variable name="ScExeSecOrdersVersionToUse">
									<xsl:choose>
										<xsl:when test="string-length(substring-before(b:executionSetCriteria, '-')) = 4">
											<xsl:value-of select="$ScExeSecOrdersExecEnrichmentVersion"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="$ScExeSecOrdersTapAuthVersion"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<ofsTransactionInput application="SC.EXE.SEC.ORDERS" operation="PROCESS" version="{$ScExeSecOrdersVersionToUse}">
									<xsl:call-template name="scexesecorders:transactionId"/>
									<xsl:call-template name="SC.EXE.SEC.ORDERS"/>
								</ofsTransactionInput>
							</xsl:when>
							<xsl:when test="b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '3' or b:userDefinedField[infra:name='ud_exec_instr_nature_e']/infra:value = '6'">
								<ofsTransactionInput application="DX.ORDER" operation="PROCESS" version="{$DxOrderEnrichmentVersion}">
									<xsl:call-template name="dxorder:transactionId"/>
									<xsl:call-template name="DX.ORDER"/>
								</ofsTransactionInput>
							</xsl:when>
						</xsl:choose>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="DX.ORDER">
		<xsl:call-template name="dxorder:ORDER.ID"/>
		<xsl:call-template name="dxorder:CONTRACT.CODE"/>
		<xsl:call-template name="dxorder:EXCHANGE.CODE"/>
		<xsl:call-template name="dxorder:SUB.ASSET.TYPE"/>
		<xsl:call-template name="dxorder:TRADE.STATUS"/>
		<xsl:call-template name="dxorder:TRADE.DATE"/>
		<xsl:call-template name="dxorder:MATURITY.DATE"/>
		<xsl:call-template name="dxorder:INP.MAT.DATE"/>
		<xsl:call-template name="dxorder:TRADE.TYPE"/>
		<xsl:call-template name="dxorder:DEC.DATE"/>
		<xsl:call-template name="dxorder:CONTRACT.CCY"/>
		<xsl:call-template name="dxorder:TRADE.CCY"/>
		<xsl:call-template name="dxorder:TRANSFER.TYPE"/>
		<xsl:call-template name="dxorder:EXECUTING.BROKER"/>
		<xsl:call-template name="dxorder:OPTION.TYPE"/>
		<xsl:call-template name="dxorder:OPTION.STYLE"/>
		<xsl:call-template name="dxorder:STRIKE.PRICE"/>
		<xsl:call-template name="dxorder:INT.STRIKE.PRICE"/>
		<xsl:call-template name="dxorder:PREMIUM.DUE"/>
		<xsl:call-template name="dxorder:CURRENCY.MARKET"/>
		<xsl:call-template name="dxorder:POSITION.TYPE"/>
		<xsl:call-template name="dxorder:CONTRACT.TIME"/>
		<xsl:call-template name="dxorder:DEALER.DESK"/>
		<xsl:call-template name="dxorder:DEPT.ACCT.OFFICER"/>
		<xsl:call-template name="dxorder:NARRATIVE"/>
		<xsl:call-template name="dxorder:EXTERNAL.REF"/>
		<xsl:call-template name="dxorder:TAP.REF.ID"/>
		<xsl:call-template name="dxorder:DLV.CCY"/>
		<xsl:call-template name="dxorder:REGION"/>
		<xsl:call-template name="dxorder:VALUATION.PRICE"/>
		<xsl:call-template name="dxorder:PRI.PRICE"/>
		<xsl:call-template name="dxorder:PRI.INT.PRICE"/>
		<xsl:call-template name="dxorder:PRI.TRADE.COST"/>
		<xsl:call-template name="dxorder:PRI.BUY.SELL"/>
		<xsl:call-template name="dxorder:PRI.CUST.NO"/>
		<xsl:call-template name="dxorder:PRI.SEC.ACC"/>
		<xsl:call-template name="dxorder:PRI.CUST.TYPE"/>
		<xsl:call-template name="dxorder:PRI.CUST.STATUS"/>
		<xsl:call-template name="dxorder:PRI.ACCOUNT"/>
		<xsl:call-template name="dxorder:PRI.LOTS"/>
		<xsl:call-template name="dxorder:PRI.ORIG.LOTS"/>
		<xsl:call-template name="dxorder:PRI.SETTNOS"/>
		<xsl:call-template name="dxorder:PRI.SETTLOTS"/>
		<xsl:call-template name="dxorder:PRI.OPEN.CLOSE"/>
		<xsl:call-template name="dxorder:PRI.HEDGE.TRADE"/>
		<xsl:call-template name="dxorder:PRI.LINK"/>
		<xsl:call-template name="dxorder:PRI.ALLOW.SETT"/>
		<xsl:call-template name="dxorder:PRI.STRATEGY"/>
		<xsl:call-template name="dxorder:PRI.AUTO.MANUAL"/>
		<xsl:call-template name="dxorder:PRI.CACC.CCY"/>
		<xsl:call-template name="dxorder:PRI.COMM.EXC"/>
		<xsl:call-template name="dxorder:PRI.CACC.AMT"/>
		<xsl:call-template name="dxorder:PRI.COMM.TAX"/>
		<xsl:call-template name="dxorder:PRI.CHARGE.DATE"/>
		<xsl:call-template name="dxorder:TAX.AMT.TCY"/>
		<xsl:call-template name="dxorder:PRI.REF.CCY"/>
		<xsl:call-template name="dxorder:PRI.ACC.CCY"/>
		<xsl:call-template name="dxorder:PRI.EX.RATE.REF"/>
		<xsl:call-template name="dxorder:PRI.EX.RATE.ACC"/>
		<xsl:call-template name="dxorder:PRI.DLV.AMT"/>
		<xsl:call-template name="dxorder:PRI.NET.COST"/>
		<xsl:call-template name="dxorder:PRI.PREM.EXC"/>
		<xsl:call-template name="dxorder:PRI.DLV.KEY"/>
		<xsl:call-template name="dxorder:PRI.TRANS.KEY"/>
		<xsl:call-template name="dxorder:PRI.ORDER.NO"/>
		<xsl:call-template name="dxorder:PRI.NARR"/>
		<xsl:call-template name="dxorder:PRI.CONSTRAINT"/>
		<xsl:call-template name="dxorder:PRI.CHG.OFFSET"/>
		<xsl:call-template name="dxorder:PRI.CUST.REF"/>
		<xsl:call-template name="dxorder:PRI.PND.SETT"/>
		<xsl:call-template name="dxorder:PRI.PND.LOTS"/>
		<xsl:call-template name="dxorder:PRI.LIMIT.REF"/>
		<xsl:call-template name="dxorder:PRI.PREM.TXN"/>
		<xsl:call-template name="dxorder:PRI.PREM.PST"/>
		<xsl:call-template name="dxorder:PRI.IM.AMT"/>
		<xsl:call-template name="dxorder:PRI.IM.ACC"/>
		<xsl:call-template name="dxorder:PRI.RT.COMPANY"/>
		<xsl:call-template name="dxorder:PRI.RT.PORT.ID"/>
		<xsl:call-template name="dxorder:PRI.RT.WHEN"/>
		<xsl:call-template name="dxorder:PRI.RT.LINK"/>
		<xsl:call-template name="dxorder:PRI.ENTITLE"/>
		<xsl:call-template name="dxorder:PRI.OVE.ADDR"/>
		<xsl:call-template name="dxorder:PRI.MESS.CTL"/>
		<xsl:call-template name="dxorder:PRI.PREM.OFFSET"/>
		<xsl:call-template name="dxorder:PRI.BEN.NO"/>
		<xsl:call-template name="dxorder:PRI.BEN.ADD"/>
		<xsl:call-template name="dxorder:PRI.CPY.NO"/>
		<xsl:call-template name="dxorder:PRI.CPY.ADD"/>
		<xsl:call-template name="dxorder:PRI.CPY.BNK.ACC"/>
		<xsl:call-template name="dxorder:PRI.INTR.BK.NO"/>
		<xsl:call-template name="dxorder:PRI.INTR.ADD"/>
		<xsl:call-template name="dxorder:PRI.CONF.NAR"/>
		<xsl:call-template name="dxorder:PRI.PYMT.NAR"/>
		<xsl:call-template name="dxorder:PRI.RCAD.NAR"/>
		<xsl:call-template name="dxorder:PRI.BK2BK.IN"/>
		<xsl:call-template name="dxorder:SEC.CUST.NO"/>
		<xsl:call-template name="dxorder:SEC.SEC.ACC"/>
		<xsl:call-template name="dxorder:SEC.CUST.TYPE"/>
		<xsl:call-template name="dxorder:SEC.CUST.STATUS"/>
		<xsl:call-template name="dxorder:SEC.ACCOUNT"/>
		<xsl:call-template name="dxorder:SEC.BUY.SELL"/>
		<xsl:call-template name="dxorder:SEC.LOTS"/>
		<xsl:call-template name="dxorder:SEC.ORIG.LOTS"/>
		<xsl:call-template name="dxorder:SEC.SETTNOS"/>
		<xsl:call-template name="dxorder:SEC.SETTLOTS"/>
		<xsl:call-template name="dxorder:SEC.PRICE"/>
		<xsl:call-template name="dxorder:SEC.INT.PRICE"/>
		<xsl:call-template name="dxorder:SEC.TRADE.COST"/>
		<xsl:call-template name="dxorder:SEC.OPEN.CLOSE"/>
		<xsl:call-template name="dxorder:SEC.HEDGE.TRADE"/>
		<xsl:call-template name="dxorder:SEC.LINK"/>
		<xsl:call-template name="dxorder:SEC.ALLOW.SETT"/>
		<xsl:call-template name="dxorder:SEC.STRATEGY"/>
		<xsl:call-template name="dxorder:SEC.AUTO.MANUAL"/>
		<xsl:call-template name="dxorder:SEC.COMM.TYP"/>
		<xsl:call-template name="dxorder:SEC.COMM.CDE"/>
		<xsl:call-template name="dxorder:SEC.COMM.CCY"/>
		<xsl:call-template name="dxorder:SEC.COMM.AMT"/>
		<xsl:call-template name="dxorder:SEC.COMM.ACC"/>
		<xsl:call-template name="dxorder:SEC.CACC.CCY"/>
		<xsl:call-template name="dxorder:SEC.COMM.EXC"/>
		<xsl:call-template name="dxorder:SEC.CACC.AMT"/>
		<xsl:call-template name="dxorder:SEC.COMM.TAX"/>
		<xsl:call-template name="dxorder:SEC.CHARGE.DATE"/>
		<xsl:call-template name="dxorder:SEC.TAX.CODE"/>
		<xsl:call-template name="dxorder:SEC.TAX.TYPE"/>
		<xsl:call-template name="dxorder:SEC.TAX.AMT.ACY"/>
		<xsl:call-template name="dxorder:SEC.TAX.AMT.TCY"/>
		<xsl:call-template name="dxorder:SEC.REF.CCY"/>
		<xsl:call-template name="dxorder:SEC.ACC.CCY"/>
		<xsl:call-template name="dxorder:SEC.EX.RATE.REF"/>
		<xsl:call-template name="dxorder:SEC.EX.RATE.ACC"/>
		<xsl:call-template name="dxorder:SEC.ORDER.NO"/>
		<xsl:call-template name="dxorder:SEC.NARR"/>
		<xsl:call-template name="dxorder:SEC.CONSTRAINT"/>
		<xsl:call-template name="dxorder:SEC.DLV.AMT"/>
		<xsl:call-template name="dxorder:SEC.NET.COST"/>
		<xsl:call-template name="dxorder:SEC.PREM.EXC"/>
		<xsl:call-template name="dxorder:SEC.DLV.KEY"/>
		<xsl:call-template name="dxorder:SEC.TRANS.KEY"/>
		<xsl:call-template name="dxorder:SEC.CHG.OFFSET"/>
		<xsl:call-template name="dxorder:SEC.CUST.REF"/>
		<xsl:call-template name="dxorder:SEC.PND.SETT"/>
		<xsl:call-template name="dxorder:SEC.PND.LOTS"/>
		<xsl:call-template name="dxorder:SEC.LIMIT.REF"/>
		<xsl:call-template name="dxorder:SEC.PREM.TXN"/>
		<xsl:call-template name="dxorder:SEC.PREM.PST"/>
		<xsl:call-template name="dxorder:SEC.IM.AMT"/>
		<xsl:call-template name="dxorder:SEC.IM.ACC"/>
		<xsl:call-template name="dxorder:SEC.RT.COMPANY"/>
		<xsl:call-template name="dxorder:SEC.RT.PORT.ID"/>
		<xsl:call-template name="dxorder:SEC.RT.WHEN"/>
		<xsl:call-template name="dxorder:SEC.RT.LINK"/>
		<xsl:call-template name="dxorder:SEC.ENTITLE"/>
		<xsl:call-template name="dxorder:SEC.OVE.ADDR"/>
		<xsl:call-template name="dxorder:SEC.MESS.CTL"/>
		<xsl:call-template name="dxorder:SEC.PREM.OFFSET"/>
		<xsl:call-template name="dxorder:SEC.BEN.NO"/>
		<xsl:call-template name="dxorder:SEC.BEN.ADD"/>
		<xsl:call-template name="dxorder:SEC.CPY.NO"/>
		<xsl:call-template name="dxorder:SEC.CPY.ADD"/>
		<xsl:call-template name="dxorder:SEC.CPY.BNK.ACC"/>
		<xsl:call-template name="dxorder:SEC.INTR.BK.NO"/>
		<xsl:call-template name="dxorder:SEC.INTR.ADD"/>
		<xsl:call-template name="dxorder:SEC.CONF.NAR"/>
		<xsl:call-template name="dxorder:SEC.PYMT.NAR"/>
		<xsl:call-template name="dxorder:SEC.RCAD.NAR"/>
		<xsl:call-template name="dxorder:SEC.BK2BK.IN"/>
		<xsl:call-template name="dxorder:TICK.SIZE"/>
		<xsl:call-template name="dxorder:TICK.VALUE"/>
		<xsl:call-template name="dxorder:CONTRACT.SIZE"/>
		<xsl:call-template name="dxorder:ALT.IND.NAME"/>
		<xsl:call-template name="dxorder:ALT.IND.ID"/>
		<xsl:call-template name="dxorder:AI.RESERVED2"/>
		<xsl:call-template name="dxorder:AI.RESERVED1"/>
		<xsl:call-template name="dxorder:ORDER.DATE"/>
		<xsl:call-template name="dxorder:ORDER.TIME"/>
		<xsl:call-template name="dxorder:BROKER.DATE"/>
		<xsl:call-template name="dxorder:BROKER.TIME"/>
		<xsl:call-template name="dxorder:ORDER.STATUS"/>
		<xsl:call-template name="dxorder:ORDER.LOTS"/>
		<xsl:call-template name="dxorder:LOTS.FILLED"/>
		<xsl:call-template name="dxorder:LOTS.OPEN"/>
		<xsl:call-template name="dxorder:UNDERLYING"/>
		<xsl:call-template name="dxorder:EXOTIC.TYPE"/>
		<xsl:call-template name="dxorder:EXOTIC.EVENT"/>
		<xsl:call-template name="dxorder:USR.FLD.NAME"/>
		<xsl:call-template name="dxorder:USR.FLD.VAL"/>
		<xsl:call-template name="dxorder:USR.FLD.TEXT"/>
		<xsl:call-template name="dxorder:USR.FLD.PRICE"/>
		<xsl:call-template name="dxorder:USR.RSVD.X3"/>
		<xsl:call-template name="dxorder:USR.RSVD.X4"/>
		<xsl:call-template name="dxorder:USR.RSVD.X5"/>
		<xsl:call-template name="dxorder:LIMIT.TYPE"/>
		<xsl:call-template name="dxorder:LIMIT.PRICE"/>
		<xsl:call-template name="dxorder:LIMIT.DATE"/>
		<xsl:call-template name="dxorder:ORDER.TYPE"/>
		<xsl:call-template name="dxorder:FX.PIP.TYPE"/>
		<xsl:call-template name="dxorder:FX.PIPS"/>
		<xsl:call-template name="dxorder:FX.PREM.AMT"/>
		<xsl:call-template name="dxorder:ORDER.ADVICE"/>
		<xsl:call-template name="dxorder:PARENT.REF"/>
		<xsl:call-template name="dxorder:CHILD.REF"/>
		<xsl:call-template name="dxorder:PENDING.DIARY"/>
		<xsl:call-template name="dxorder:SUPPRESS.ALL.MSG"/>
		<xsl:call-template name="dxorder:IND.PRICE"/>
		<xsl:call-template name="dxorder:ORIG.PRICE"/>
		<xsl:call-template name="dxorder:DAYS.PER.YEAR"/>
		<xsl:call-template name="dxorder:SPREAD.RATE"/>
		<xsl:call-template name="dxorder:SWAP.REFERENCE"/>
		<xsl:call-template name="dxorder:CAP.FLOOR"/>
		<xsl:call-template name="dxorder:HEDGE.PL.CATEG"/>
		<xsl:call-template name="dxorder:BUY.FLOATING.RATE"/>
		<xsl:call-template name="dxorder:SELL.FLOATING.RATE"/>
		<xsl:call-template name="dxorder:MASTER.AGREEMENT"/>
		<xsl:call-template name="dxorder:PERIOD.FREQUENCY"/>
		<xsl:call-template name="dxorder:PERIOD.START"/>
		<xsl:call-template name="dxorder:PERIOD.END.DATE"/>
		<xsl:call-template name="dxorder:PERIOD.FIX.DATE"/>
		<xsl:call-template name="dxorder:PERIOD.PAY.DATE"/>
		<xsl:call-template name="dxorder:PREM.PYMT.FREQ"/>
		<xsl:call-template name="dxorder:PREM.PYMT.DATE"/>
		<xsl:call-template name="dxorder:PREM.PYMT.AMT"/>
		<xsl:call-template name="dxorder:LOTS.TRANSFER"/>
		<xsl:call-template name="dxorder:DEST.CUST"/>
		<xsl:call-template name="dxorder:DEST.PORTFOLIO"/>
		<xsl:call-template name="dxorder:DEST.CUST.PORT"/>
		<xsl:call-template name="dxorder:CUST.CPARTY"/>
		<xsl:call-template name="dxorder:CUST.BNK.NME"/>
		<xsl:call-template name="dxorder:CUST.BNK.ADD"/>
		<xsl:call-template name="dxorder:CUST.BNK.SORT.CDE"/>
		<xsl:call-template name="dxorder:PRICE.TRADED"/>
		<xsl:call-template name="dxorder:FEE"/>
		<xsl:call-template name="dxorder:ADVICE"/>
		<xsl:call-template name="dxorder:CREATE.TRADES"/>
		<xsl:call-template name="dxorder:FILLED.LOTS"/>
		<xsl:call-template name="dxorder:FILLED.PRICE"/>
		<xsl:call-template name="dxorder:FILLED.IPRICE"/>
		<xsl:call-template name="dxorder:RESERVED.10"/>
		<xsl:call-template name="dxorder:RESERVED.11"/>
		<xsl:call-template name="dxorder:TREASURY.CUSTOMER"/>
		<xsl:call-template name="dxorder:LINK.REFERENCE"/>
		<xsl:call-template name="dxorder:RESERVED.X14"/>
		<xsl:call-template name="dxorder:RESERVED.X15"/>
		<xsl:call-template name="dxorder:LOCAL.REF"/>
		<xsl:call-template name="dxorder:OVERRIDE"/>
		<xsl:call-template name="dxorder:RECORD.STATUS"/>
		<xsl:call-template name="dxorder:CURR.NO"/>
		<xsl:call-template name="dxorder:INPUTTER"/>
		<xsl:call-template name="dxorder:DATE.TIME"/>
		<xsl:call-template name="dxorder:AUTHORISER"/>
		<xsl:call-template name="dxorder:CO.CODE"/>
		<xsl:call-template name="dxorder:DEPT.CODE"/>
		<xsl:call-template name="dxorder:AUDITOR.CODE"/>
		<xsl:call-template name="dxorder:AUDIT.DATE.TIME"/>
		<xsl:call-template name="dxorder:SY.DEAL.REF"/>
		<xsl:call-template name="dxorder:EXCLUDE.VALUATION"/>
		<xsl:call-template name="dxorder:CARRIER.ALLOWED"/>
		<xsl:call-template name="dxorder:PRI.PREMIUM.CCY"/>
		<xsl:call-template name="dxorder:PRI.PREM.PRICE"/>
		<xsl:call-template name="dxorder:PRI.PREM.EXCH.RATE"/>
		<xsl:call-template name="dxorder:PRI.TOTAL.PREM.AMT"/>
		<xsl:call-template name="dxorder:SEC.PREMIUM.CCY"/>
		<xsl:call-template name="dxorder:SEC.PREM.PRICE"/>
		<xsl:call-template name="dxorder:SEC.PREM.EXCH.RATE"/>
		<xsl:call-template name="dxorder:SEC.TOTAL.PREM.AMT"/>
		<xsl:call-template name="dxorder:PRI.EXCHANGE.TYPE"/>
		<xsl:call-template name="dxorder:PRI.CHANNEL"/>
		<xsl:call-template name="dxorder:RESERVED.X10"/>
		<xsl:call-template name="dxorder:RESERVED.X11"/>
		<xsl:call-template name="dxorder:RESERVED.X12"/>
		<xsl:call-template name="dxorder:RESERVED.X13"/>
		<xsl:call-template name="dxorder:RESERVED.X16"/>
		<xsl:call-template name="dxorder:RESERVED.X17"/>
		<xsl:call-template name="dxorder:RESERVED.X18"/>
		<xsl:call-template name="dxorder:RESERVED.X19"/>
		<xsl:call-template name="dxorder:RESERVED.X20"/>
		<xsl:call-template name="dxorder:RESERVED.X21"/>
		<xsl:call-template name="dxorder:RESERVED.X22"/>
		<xsl:call-template name="dxorder:RESERVED.X23"/>
		<xsl:call-template name="dxorder:RESERVED.X24"/>
		<xsl:call-template name="dxorder:RESERVED.X25"/>
		<xsl:call-template name="dxorder:RESERVED.X26"/>
		<xsl:call-template name="dxorder:RESERVED.X27"/>
		<xsl:call-template name="dxorder:RESERVED.X28"/>
		<xsl:call-template name="dxorder:RESERVED.X29"/>
		<xsl:call-template name="dxorder:RESERVED.X30"/>
		<xsl:call-template name="dxorder:RESERVED.X31"/>
		<xsl:call-template name="dxorder:RESERVED.X32"/>
		<xsl:call-template name="dxorder:RESERVED.X33"/>
		<xsl:call-template name="dxorder:RESERVED.X34"/>
		<xsl:call-template name="dxorder:RESERVED.X35"/>
		<xsl:call-template name="dxorder:RESERVED.X43"/>
		<xsl:call-template name="dxorder:STRIKE.QUOTE.CCY"/>
		<xsl:call-template name="dxorder:STRIKE.QUOTE"/>
		<xsl:call-template name="dxorder:CCY.BOUGHT"/>
		<xsl:call-template name="dxorder:AMT.BOUGHT"/>
		<xsl:call-template name="dxorder:CCY.SOLD"/>
		<xsl:call-template name="dxorder:AMT.SOLD"/>
		<xsl:call-template name="dxorder:AUTO.AUTHORISE"/>
		<xsl:call-template name="dxorder:ORDER.CLOSEOUT"/>
		<xsl:call-template name="dxorder:CLOSEOUT.TRADE"/>
		<xsl:call-template name="dxorder:RESERVED.X3"/>
		<xsl:call-template name="dxorder:RESERVED.X4"/>
		<xsl:call-template name="dxorder:RESERVED.X5"/>
		<xsl:call-template name="dxorder:CLOSEOUT.LOTS"/>
		<xsl:call-template name="dxorder:ORDER.AMEND"/>
        <xsl:call-template name="dxorder:TAP.EX.SET.CRIT"/>
		<xsl:call-template name="dxorder:USERDEF.FIELDS"/>
		<xsl:call-template name="dxorder:transactionFeesTaxesCounter"/>
		<xsl:call-template name="dxorder:ModelBankSpecificFields"/>
		<xsl:call-template name="dxorder:ModelBankSpecificFields-Custo"/>
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
		<xsl:call-template name="scexesecorders:TAP.REF.ID"/>
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
		<xsl:call-template name="scexesecorders:BR.EXE.ADV.REF"/>
		<xsl:call-template name="scexesecorders:BR.TR.AL.REF"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.03"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.02"/>
		<xsl:call-template name="scexesecorders:BR.RESERVED.01"/>
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
		<xsl:call-template name="scexesecorders:UTC.DATE.TIME"/>
        <xsl:call-template name="scexesecorders:TAP.EX.SET.CRIT"/>		
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