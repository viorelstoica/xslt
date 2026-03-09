<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.odcgroup.com/F2B" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:secopenorder="http://www.temenos.com/T24/secopenorder" xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" exclude-result-prefixes="b" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B/b:DataGroup/b:Security/b:Cancellation/b:Request">
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
							<xsl:when test="b:buySellIndicator = '4' or b:buySellIndicator = '5'">
								<ofsTransactionDelete application="SECURITY.TRANSFER" operation="PROCESS" version="{$SecurityTransferCancelSecurityVersion}">
									<xsl:call-template name="securitytransfer:transactionId"/>
									<xsl:call-template name="SECURITY.TRANSFER"/>
								</ofsTransactionDelete>
							</xsl:when>
							<xsl:when test="b:buySellIndicator = '13'">
								<ofsTransactionDelete application="POSITION.TRANSFER" operation="PROCESS" version="{$PositionTransferCancelPositionVersion}">
									<xsl:call-template name="positiontransfer:transactionId"/>
									<xsl:call-template name="POSITION.TRANSFER"/>
								</ofsTransactionDelete>
							</xsl:when>
							<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '109' and b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13'">
												<ofsTransactionInput application="PE.CUSTOMER.TXN" operation="PROCESS" version="{$PeCustomerTxnCancelInstructionVersion}">
													<xsl:call-template name="instruction.PE.CUSTOMER.TXN"/>
												</ofsTransactionInput>
											</xsl:when>
							<xsl:when test="b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '1' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '2' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '11' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '13' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '18' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '19' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '12'">
								<ofsTransactionInput application="SEC.OPEN.ORDER" operation="PROCESS" version="{$SecOpenOrderCancelledExpiredVersion}">
									<xsl:call-template name="secopenorder:transactionId"/>
									<xsl:call-template name="SEC.OPEN.ORDER"/>
								</ofsTransactionInput>
							</xsl:when>
							<xsl:when test="(b:bulkChildIndicator = '0' and (b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '3' or b:userDefinedField[infra:name='ud_instr_nature_e']/infra:value = '6')) or b:bulkChildIndicator = '2'">
								<ofsTransactionInput application="DX.ORDER" operation="PROCESS" version="{$DxOrderCancelledExpiredVersion}">
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
	<xsl:template name="SECURITY.TRANSFER">
		<xsl:call-template name="securitytransfer:TAP.EVENT.ID"/>
		<xsl:call-template name="securitytransfer:USERDEF.FIELDS"/>
		<xsl:call-template name="securitytransfer:ModelBankSpecificFields"/>
		<xsl:call-template name="securitytransfer:ModelBankSpecificFields-Custo"/>
		<xsl:call-template name="securitytransfer:TAP.REF.ID"/>
	</xsl:template>
	<xsl:template name="POSITION.TRANSFER">
		<xsl:call-template name="positiontransfer:TAP.EVENT.ID"/>
		<xsl:call-template name="positiontransfer:USERDEF.FIELDS"/>
		<xsl:call-template name="positiontransfer:ModelBankSpecificFields"/>
		<xsl:call-template name="positiontransfer:ModelBankSpecificFields-Custo"/>
		<xsl:call-template name="positiontransfer:TAP.REF.ID"/>
	</xsl:template>
	<xsl:template name="instruction.PE.CUSTOMER.TXN">
		<xsl:call-template name="pecustomertxn:transactionId"/>
		<xsl:call-template name="pecustomertxn:ACCOUNT"/>
		<xsl:call-template name="pecustomertxn:PE.FUND"/>
		<xsl:call-template name="pecustomertxn:COMMITMENT.DATE"/>
		<xsl:call-template name="pecustomertxn:COMMITMENT.AMOUNT"/>
		<xsl:call-template name="pecustomertxn:COMMITMENT.STATUS"/>
		<xsl:call-template name="pecustomertxn:REFERENCE"/>
		<xsl:call-template name="pecustomertxn:CURRENCY"/>
		<xsl:call-template name="pecustomertxn:COMMISSION.AMOUNT"/>
		<xsl:call-template name="pecustomertxn:COMMISSION.PERCENTAGE"/>
		<xsl:call-template name="pecustomertxn:TAP.REF.ID"/>
		<xsl:call-template name="pecustomertxn:TAP.EVENT.ID"/>
		<xsl:call-template name="pecustomertxn:ModelBankSpecificFields"/>
		<xsl:call-template name="pecustomertxn:ModelBankSpecificFields-Custo"/>
	</xsl:template>
	<xsl:template name="DX.ORDER">
		<xsl:call-template name="dxorder:TAP.EVENT.ID"/>
		<xsl:call-template name="dxorder:TAP.REF.ID"/>
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
		<xsl:call-template name="dxorder:PRI.COMM.TYP"/>
		<xsl:call-template name="dxorder:PRI.COMM.CDE"/>
		<xsl:call-template name="dxorder:PRI.COMM.CCY"/>
		<xsl:call-template name="dxorder:PRI.COMM.AMT"/>
		<xsl:call-template name="dxorder:PRI.COMM.ACC"/>
		<xsl:call-template name="dxorder:PRI.CACC.CCY"/>
		<xsl:call-template name="dxorder:PRI.COMM.EXC"/>
		<xsl:call-template name="dxorder:PRI.CACC.AMT"/>
		<xsl:call-template name="dxorder:PRI.COMM.TAX"/>
		<xsl:call-template name="dxorder:PRI.CHARGE.DATE"/>
		<xsl:call-template name="dxorder:PRI.TAX.CODE"/>
		<xsl:call-template name="dxorder:PRI.TAX.TYPE"/>
		<xsl:call-template name="dxorder:TAX.AMT.ACY"/>
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
        <xsl:call-template name="dxorder:CANCEL.PEND.ORDERS"/>		
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
		<xsl:call-template name="dxorder:USERDEF.FIELDS"/>
		<xsl:call-template name="dxorder:ModelBankSpecificFields"/>
		<xsl:call-template name="dxorder:ModelBankSpecificFields-Custo"/>
	</xsl:template>
	<xsl:template name="SEC.OPEN.ORDER">
		<xsl:call-template name="secopenorder:ORDER.STATUS"/>
		<xsl:call-template name="secopenorder:TAP.EVENT.ID"/>
		<xsl:call-template name="secopenorder:TAP.REF.ID"/>
		<xsl:call-template name="secopenorder:ORDER.NUMBER"/>
		<xsl:call-template name="secopenorder:ORDER.DATE"/>
		<xsl:call-template name="secopenorder:ORDER.TIME"/>
		<xsl:call-template name="secopenorder:SECURITY.NO"/>
		<xsl:call-template name="secopenorder:VALUE.DATE"/>
		<xsl:call-template name="secopenorder:MATURITY.DATE"/>
		<xsl:call-template name="secopenorder:ORDER.TYPE"/>
		<xsl:call-template name="secopenorder:TYPE.OF.TRADE"/>
		<xsl:call-template name="secopenorder:TRANSACTION.CODE"/>
		<xsl:call-template name="secopenorder:TRADE.CCY"/>
		<xsl:call-template name="secopenorder:CUST.NUMBER"/>
		<xsl:call-template name="secopenorder:SECURITY.ACCNT"/>
		<xsl:call-template name="secopenorder:NO.NOMINAL"/>
		<xsl:call-template name="secopenorder:CU.CASH.AMOUNT"/>
		<xsl:call-template name="secopenorder:CURR.PRICE"/>
		<xsl:call-template name="secopenorder:CALC.CHRGS"/>
		<xsl:call-template name="secopenorder:CASH.CHRGS"/>
		<xsl:call-template name="secopenorder:SPLIT.CHRGS"/>
		<xsl:call-template name="secopenorder:CASH.ROUNDING"/>
		<xsl:call-template name="secopenorder:ADJUST.COMM"/>
		<xsl:call-template name="secopenorder:NARRATIVE"/>
		<xsl:call-template name="secopenorder:CUST.ACC.NO"/>
		<xsl:call-template name="secopenorder:CU.EX.RATE.ACC"/>
		<xsl:call-template name="secopenorder:SETTLEMENT.CCY"/>
		<xsl:call-template name="secopenorder:CU.BRKR.COMM"/>
		<xsl:call-template name="secopenorder:WAIVE.CU.BR.COM"/>
		<xsl:call-template name="secopenorder:RESERVED.9"/>
		<xsl:call-template name="secopenorder:RESERVED.8"/>
		<xsl:call-template name="secopenorder:CU.FOREIGN.FEE"/>
		<xsl:call-template name="secopenorder:CU.COMMISSION"/>
		<xsl:call-template name="secopenorder:CU.COMM.TAX"/>
		<xsl:call-template name="secopenorder:CU.STAMP.TAX"/>
		<xsl:call-template name="secopenorder:CU.EBV.FEES"/>
		<xsl:call-template name="secopenorder:CU.FEES.MISC"/>
		<xsl:call-template name="secopenorder:CU.DISC.PCENT"/>
		<xsl:call-template name="secopenorder:CU.DISC.AMT"/>
		<xsl:call-template name="secopenorder:CU.WHT.PERC"/>
		<xsl:call-template name="secopenorder:CU.WHT.TAX"/>
		<xsl:call-template name="secopenorder:COMM.CODE"/>
		<xsl:call-template name="secopenorder:COMM.PERCENT"/>
		<xsl:call-template name="secopenorder:COM.TAX.CODE"/>
		<xsl:call-template name="secopenorder:COM.TAX.BCUR"/>
		<xsl:call-template name="secopenorder:COM.TAX.XRTE"/>
		<xsl:call-template name="secopenorder:CU.DEPOSITORY"/>
		<xsl:call-template name="secopenorder:SUB.ACCOUNT"/>
		<xsl:call-template name="secopenorder:PORT.CONST.NO"/>
		<xsl:call-template name="secopenorder:CU.BROKER.NO"/>
		<xsl:call-template name="secopenorder:CU.NOTES"/>
		<xsl:call-template name="secopenorder:CU.ENTL.ID"/>
		<xsl:call-template name="secopenorder:CU.INT.CTR"/>
		<xsl:call-template name="secopenorder:BUYING.POWER"/>
		<xsl:call-template name="secopenorder:EXT.CUSTODIAN"/>
		<xsl:call-template name="secopenorder:CU.INCOME.ACC"/>
		<xsl:call-template name="secopenorder:CU.INCOME.CCY"/>
		<xsl:call-template name="secopenorder:LIMIT.PRICE"/>
		<xsl:call-template name="secopenorder:LIMIT.TYPE"/>
		<xsl:call-template name="secopenorder:LIMIT.EXP.DATE"/>
		<xsl:call-template name="secopenorder:LINK.ORDER.NO"/>
		<xsl:call-template name="secopenorder:DEPOSITORY"/>
		<xsl:call-template name="secopenorder:NOMINEE.CODE"/>
		<xsl:call-template name="secopenorder:ACCOUNT.MANAGER"/>
		<xsl:call-template name="secopenorder:ACCT.NARRATIVE"/>
		<xsl:call-template name="secopenorder:BROKER"/>
		<xsl:call-template name="secopenorder:DATE.TO.BROKER"/>
		<xsl:call-template name="secopenorder:TIME.TO.BROKER"/>
		<xsl:call-template name="secopenorder:AMT.TO.BROKER"/>
		<xsl:call-template name="secopenorder:BR.CASH.AMT"/>
		<xsl:call-template name="secopenorder:BR.PRICE"/>
		<xsl:call-template name="secopenorder:BROKER.TYPE"/>
		<xsl:call-template name="secopenorder:BR.SEC.ACCT"/>
		<xsl:call-template name="secopenorder:BR.ACC.NO"/>
		<xsl:call-template name="secopenorder:BR.ACCOUNT.CCY"/>
		<xsl:call-template name="secopenorder:BR.EX.RATE.ACC"/>
		<xsl:call-template name="secopenorder:BR.DELIV.INSTR"/>
		<xsl:call-template name="secopenorder:EXE.BY.BROKER"/>
		<xsl:call-template name="secopenorder:BANK.CORRES"/>
		<xsl:call-template name="secopenorder:BROK.CORRES"/>
		<xsl:call-template name="secopenorder:CONFIRMATION"/>
		<xsl:call-template name="secopenorder:DELIVERY.KEY"/>
		<xsl:call-template name="secopenorder:SECURITIES.CR.DR"/>
		<xsl:call-template name="secopenorder:REFERENCE.NO"/>
		<xsl:call-template name="secopenorder:CUSTOMER.NO"/>
		<xsl:call-template name="secopenorder:SEC.ACC.NO"/>
		<xsl:call-template name="secopenorder:BROKER.NO"/>
		<xsl:call-template name="secopenorder:EXE.DETAIL"/>
		<xsl:call-template name="secopenorder:NO.NOM.FILLED"/>
		<xsl:call-template name="secopenorder:TRADE.PRICE"/>
		<xsl:call-template name="secopenorder:TRADE.DATE"/>
		<xsl:call-template name="secopenorder:TRADE.TIME"/>
		<xsl:call-template name="secopenorder:ORDER.NOMINAL"/>
		<xsl:call-template name="secopenorder:LIQUIDATION.PERIOD"/>
		<xsl:call-template name="secopenorder:PREMIUM.PRICE"/>
		<xsl:call-template name="secopenorder:MARKET.TYPE"/>
		<xsl:call-template name="secopenorder:DEAL.STATUS"/>
		<xsl:call-template name="secopenorder:DEAL.NARRATIVE"/>
		<xsl:call-template name="secopenorder:VAL.IN.SETT.CCY"/>
		<xsl:call-template name="secopenorder:VERIFY.BY.DEALER"/>
		<xsl:call-template name="secopenorder:LOCAL.REF"/>
		<xsl:call-template name="secopenorder:CUST.DEPO"/>
		<xsl:call-template name="secopenorder:CU.DEPO.NOM"/>
		<xsl:call-template name="secopenorder:CU.NOM.CODE"/>
		<xsl:call-template name="secopenorder:RESERVED07"/>
		<xsl:call-template name="secopenorder:STOCK.EXCHANGE"/>
		<xsl:call-template name="secopenorder:GROUP.ORDER"/>
		<xsl:call-template name="secopenorder:ODD.LOT.ORDER"/>
		<xsl:call-template name="secopenorder:ACTIVITY.CODE"/>
		<xsl:call-template name="secopenorder:MSG.BROKER"/>
		<xsl:call-template name="secopenorder:MSG.NO"/>
		<xsl:call-template name="secopenorder:MSG.CLASS"/>
		<xsl:call-template name="secopenorder:OVR.CARRIER"/>
		<xsl:call-template name="secopenorder:OVR.ADDRESS"/>
		<xsl:call-template name="secopenorder:SEND.ADVICE"/>
		<xsl:call-template name="secopenorder:SOFT.DLVRY.KEY"/>
		<xsl:call-template name="secopenorder:ROUT.COMPANY"/>
		<xsl:call-template name="secopenorder:CUM.EX.IND"/>
		<xsl:call-template name="secopenorder:WHT.TAX.CODE"/>
		<xsl:call-template name="secopenorder:SEGMENT"/>
		<xsl:call-template name="secopenorder:DEF.DEAL.DESK"/>
		<xsl:call-template name="secopenorder:ACT.DEAL.DESK"/>
		<xsl:call-template name="secopenorder:INT.CTR"/>
		<xsl:call-template name="secopenorder:SERVICE.REF"/>
		<xsl:call-template name="secopenorder:THREAD.KEY"/>
		<xsl:call-template name="secopenorder:TRADED.NOM"/>
		<xsl:call-template name="secopenorder:OUTSTAND.NOM"/>
		<xsl:call-template name="secopenorder:TRADER.CODE"/>
		<xsl:call-template name="secopenorder:TRADER.DESC"/>
		<xsl:call-template name="secopenorder:ROUT.SEC.ACC"/>
		<xsl:call-template name="secopenorder:ROUT.BROKER"/>
		<xsl:call-template name="secopenorder:ROUTED.ORDER.REF"/>
		<xsl:call-template name="secopenorder:IN.HOUSE.SEC.ACC"/>
		<xsl:call-template name="secopenorder:IN.HOUSE.CUSTODIAN"/>
		<xsl:call-template name="secopenorder:STP.ORDER"/>
		<xsl:call-template name="secopenorder:AUTHORISE.TRADE"/>
		<xsl:call-template name="secopenorder:PARENT"/>
		<xsl:call-template name="secopenorder:PARENT.REFERENCE"/>
		<xsl:call-template name="secopenorder:REVERSE.CHILD"/>
		<xsl:call-template name="secopenorder:EXE.HLT"/>
		<xsl:call-template name="secopenorder:TRADE.HLT"/>
		<xsl:call-template name="secopenorder:AUTHORISE.CHILD"/>
		<xsl:call-template name="secopenorder:DELETE.CHILD"/>
		<xsl:call-template name="secopenorder:ROUNDING.FACTOR"/>
		<xsl:call-template name="secopenorder:MKT.IDN.CODE"/>
		<xsl:call-template name="secopenorder:BULK.UPDATE"/>
		<xsl:call-template name="secopenorder:RESERVED9"/>
		<xsl:call-template name="secopenorder:RESERVED8"/>
		<xsl:call-template name="secopenorder:RESERVED7"/>
		<xsl:call-template name="secopenorder:RESERVED6"/>
		<xsl:call-template name="secopenorder:RESERVED5"/>
		<xsl:call-template name="secopenorder:RESERVED4"/>
		<xsl:call-template name="secopenorder:RESERVED3"/>
		<xsl:call-template name="secopenorder:RESERVED2"/>
		<xsl:call-template name="secopenorder:RESERVED1"/>
		<xsl:call-template name="secopenorder:OVERRIDE"/>
		<xsl:call-template name="secopenorder:RECORD.STATUS"/>
		<xsl:call-template name="secopenorder:CURR.NO"/>
		<xsl:call-template name="secopenorder:INPUTTER"/>
		<xsl:call-template name="secopenorder:DATE.TIME"/>
		<xsl:call-template name="secopenorder:AUTHORISER"/>
		<xsl:call-template name="secopenorder:CO.CODE"/>
		<xsl:call-template name="secopenorder:DEPT.CODE"/>
		<xsl:call-template name="secopenorder:AUDITOR.CODE"/>
		<xsl:call-template name="secopenorder:AUDIT.DATE.TIME"/>
		<xsl:call-template name="secopenorder:USERDEF.FIELDS"/>
		<xsl:call-template name="secopenorder:ModelBankSpecificFields"/>
		<xsl:call-template name="secopenorder:ModelBankSpecificFields-Custo"/>
	</xsl:template>
</xsl:stylesheet>