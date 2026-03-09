<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://www.odcgroup.com/F2B" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:secopenorder="http://www.temenos.com/T24/secopenorder" xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" exclude-result-prefixes="b" version="1.0">

	<!-- BEGIN securitytransfer -->
	<xsl:template name="securitytransfer:transactionId">
		<transactionId>
			<xsl:value-of select="b:omsOrderReference"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="securitytransfer:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:USERDEF.FIELDS"/>
	<xsl:template name="securitytransfer:ModelBankSpecificFields"/>
	<xsl:template name="securitytransfer:ModelBankSpecificFields-Custo"/>
	<xsl:template name="securitytransfer:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<!-- END securitytransfer -->
	<!-- BEGIN positiontransfer -->
	<xsl:template name="positiontransfer:transactionId">
		<transactionId>
			<xsl:value-of select="b:omsOrderReference"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="positiontransfer:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:USERDEF.FIELDS"/>
	<xsl:template name="positiontransfer:ModelBankSpecificFields"/>
	<xsl:template name="positiontransfer:ModelBankSpecificFields-Custo"/>
	<xsl:template name="positiontransfer:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<!-- END positiontransfer -->
	<xsl:template name="dxorder:transactionId">
		<transactionId>
			<xsl:value-of select="b:omsOrderReference"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="dxorder:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.ID"/>
	<xsl:template name="dxorder:CONTRACT.CODE"/>
	<xsl:template name="dxorder:EXCHANGE.CODE"/>
	<xsl:template name="dxorder:SUB.ASSET.TYPE"/>
	<xsl:template name="dxorder:TRADE.STATUS"/>
	<xsl:template name="dxorder:TRADE.DATE"/>
	<xsl:template name="dxorder:MATURITY.DATE"/>
	<xsl:template name="dxorder:INP.MAT.DATE"/>
	<xsl:template name="dxorder:TRADE.TYPE"/>
	<xsl:template name="dxorder:DEC.DATE"/>
	<xsl:template name="dxorder:CONTRACT.CCY"/>
	<xsl:template name="dxorder:TRADE.CCY"/>
	<xsl:template name="dxorder:TRANSFER.TYPE"/>
	<xsl:template name="dxorder:EXECUTING.BROKER"/>
	<xsl:template name="dxorder:OPTION.TYPE"/>
	<xsl:template name="dxorder:OPTION.STYLE"/>
	<xsl:template name="dxorder:STRIKE.PRICE"/>
	<xsl:template name="dxorder:INT.STRIKE.PRICE"/>
	<xsl:template name="dxorder:PREMIUM.DUE"/>
	<xsl:template name="dxorder:CURRENCY.MARKET"/>
	<xsl:template name="dxorder:POSITION.TYPE"/>
	<xsl:template name="dxorder:CONTRACT.TIME"/>
	<xsl:template name="dxorder:DEALER.DESK"/>
	<xsl:template name="dxorder:DEPT.ACCT.OFFICER"/>
	<xsl:template name="dxorder:NARRATIVE"/>
	<xsl:template name="dxorder:EXTERNAL.REF"/>
	<xsl:template name="dxorder:DLV.CCY"/>
	<xsl:template name="dxorder:REGION"/>
	<xsl:template name="dxorder:VALUATION.PRICE"/>
	<xsl:template name="dxorder:PRI.PRICE"/>
	<xsl:template name="dxorder:PRI.INT.PRICE"/>
	<xsl:template name="dxorder:PRI.TRADE.COST"/>
	<xsl:template name="dxorder:PRI.BUY.SELL"/>
	<xsl:template name="dxorder:PRI.CUST.NO"/>
	<xsl:template name="dxorder:PRI.SEC.ACC"/>
	<xsl:template name="dxorder:PRI.CUST.TYPE"/>
	<xsl:template name="dxorder:PRI.CUST.STATUS"/>
	<xsl:template name="dxorder:PRI.ACCOUNT"/>
	<xsl:template name="dxorder:PRI.LOTS"/>
	<xsl:template name="dxorder:PRI.ORIG.LOTS"/>
	<xsl:template name="dxorder:PRI.SETTNOS"/>
	<xsl:template name="dxorder:PRI.SETTLOTS"/>
	<xsl:template name="dxorder:PRI.OPEN.CLOSE"/>
	<xsl:template name="dxorder:PRI.HEDGE.TRADE"/>
	<xsl:template name="dxorder:PRI.LINK"/>
	<xsl:template name="dxorder:PRI.ALLOW.SETT"/>
	<xsl:template name="dxorder:PRI.STRATEGY"/>
	<xsl:template name="dxorder:PRI.AUTO.MANUAL"/>
	<xsl:template name="dxorder:PRI.COMM.TYP"/>
	<xsl:template name="dxorder:PRI.COMM.CDE"/>
	<xsl:template name="dxorder:PRI.COMM.CCY"/>
	<xsl:template name="dxorder:PRI.COMM.AMT"/>
	<xsl:template name="dxorder:PRI.COMM.ACC"/>
	<xsl:template name="dxorder:PRI.CACC.CCY"/>
	<xsl:template name="dxorder:PRI.COMM.EXC"/>
	<xsl:template name="dxorder:PRI.CACC.AMT"/>
	<xsl:template name="dxorder:PRI.COMM.TAX"/>
	<xsl:template name="dxorder:PRI.CHARGE.DATE"/>
	<xsl:template name="dxorder:PRI.TAX.CODE"/>
	<xsl:template name="dxorder:PRI.TAX.TYPE"/>
	<xsl:template name="dxorder:TAX.AMT.ACY"/>
	<xsl:template name="dxorder:TAX.AMT.TCY"/>
	<xsl:template name="dxorder:PRI.REF.CCY"/>
	<xsl:template name="dxorder:PRI.ACC.CCY"/>
	<xsl:template name="dxorder:PRI.EX.RATE.REF"/>
	<xsl:template name="dxorder:PRI.EX.RATE.ACC"/>
	<xsl:template name="dxorder:PRI.DLV.AMT"/>
	<xsl:template name="dxorder:PRI.NET.COST"/>
	<xsl:template name="dxorder:PRI.PREM.EXC"/>
	<xsl:template name="dxorder:PRI.DLV.KEY"/>
	<xsl:template name="dxorder:PRI.TRANS.KEY"/>
	<xsl:template name="dxorder:PRI.ORDER.NO"/>
	<xsl:template name="dxorder:PRI.NARR"/>
	<xsl:template name="dxorder:PRI.CONSTRAINT"/>
	<xsl:template name="dxorder:PRI.CHG.OFFSET"/>
	<xsl:template name="dxorder:PRI.CUST.REF"/>
	<xsl:template name="dxorder:PRI.PND.SETT"/>
	<xsl:template name="dxorder:PRI.PND.LOTS"/>
	<xsl:template name="dxorder:PRI.LIMIT.REF"/>
	<xsl:template name="dxorder:PRI.PREM.TXN"/>
	<xsl:template name="dxorder:PRI.PREM.PST"/>
	<xsl:template name="dxorder:PRI.IM.AMT"/>
	<xsl:template name="dxorder:PRI.IM.ACC"/>
	<xsl:template name="dxorder:PRI.RT.COMPANY"/>
	<xsl:template name="dxorder:PRI.RT.PORT.ID"/>
	<xsl:template name="dxorder:PRI.RT.WHEN"/>
	<xsl:template name="dxorder:PRI.RT.LINK"/>
	<xsl:template name="dxorder:PRI.ENTITLE"/>
	<xsl:template name="dxorder:PRI.OVE.ADDR"/>
	<xsl:template name="dxorder:PRI.MESS.CTL"/>
	<xsl:template name="dxorder:PRI.PREM.OFFSET"/>
	<xsl:template name="dxorder:PRI.BEN.NO"/>
	<xsl:template name="dxorder:PRI.BEN.ADD"/>
	<xsl:template name="dxorder:PRI.CPY.NO"/>
	<xsl:template name="dxorder:PRI.CPY.ADD"/>
	<xsl:template name="dxorder:PRI.CPY.BNK.ACC"/>
	<xsl:template name="dxorder:PRI.INTR.BK.NO"/>
	<xsl:template name="dxorder:PRI.INTR.ADD"/>
	<xsl:template name="dxorder:PRI.CONF.NAR"/>
	<xsl:template name="dxorder:PRI.PYMT.NAR"/>
	<xsl:template name="dxorder:PRI.RCAD.NAR"/>
	<xsl:template name="dxorder:PRI.BK2BK.IN"/>
	<xsl:template name="dxorder:SEC.CUST.NO"/>
	<xsl:template name="dxorder:SEC.SEC.ACC"/>
	<xsl:template name="dxorder:SEC.CUST.TYPE"/>
	<xsl:template name="dxorder:SEC.CUST.STATUS"/>
	<xsl:template name="dxorder:SEC.ACCOUNT"/>
	<xsl:template name="dxorder:SEC.BUY.SELL"/>
	<xsl:template name="dxorder:SEC.LOTS"/>
	<xsl:template name="dxorder:SEC.ORIG.LOTS"/>
	<xsl:template name="dxorder:SEC.SETTNOS"/>
	<xsl:template name="dxorder:SEC.SETTLOTS"/>
	<xsl:template name="dxorder:SEC.PRICE"/>
	<xsl:template name="dxorder:SEC.INT.PRICE"/>
	<xsl:template name="dxorder:SEC.TRADE.COST"/>
	<xsl:template name="dxorder:SEC.OPEN.CLOSE"/>
	<xsl:template name="dxorder:SEC.HEDGE.TRADE"/>
	<xsl:template name="dxorder:SEC.LINK"/>
	<xsl:template name="dxorder:SEC.ALLOW.SETT"/>
	<xsl:template name="dxorder:SEC.STRATEGY"/>
	<xsl:template name="dxorder:SEC.AUTO.MANUAL"/>
	<xsl:template name="dxorder:SEC.COMM.TYP"/>
	<xsl:template name="dxorder:SEC.COMM.CDE"/>
	<xsl:template name="dxorder:SEC.COMM.CCY"/>
	<xsl:template name="dxorder:SEC.COMM.AMT"/>
	<xsl:template name="dxorder:SEC.COMM.ACC"/>
	<xsl:template name="dxorder:SEC.CACC.CCY"/>
	<xsl:template name="dxorder:SEC.COMM.EXC"/>
	<xsl:template name="dxorder:SEC.CACC.AMT"/>
	<xsl:template name="dxorder:SEC.COMM.TAX"/>
	<xsl:template name="dxorder:SEC.CHARGE.DATE"/>
	<xsl:template name="dxorder:SEC.TAX.CODE"/>
	<xsl:template name="dxorder:SEC.TAX.TYPE"/>
	<xsl:template name="dxorder:SEC.TAX.AMT.ACY"/>
	<xsl:template name="dxorder:SEC.TAX.AMT.TCY"/>
	<xsl:template name="dxorder:SEC.REF.CCY"/>
	<xsl:template name="dxorder:SEC.ACC.CCY"/>
	<xsl:template name="dxorder:SEC.EX.RATE.REF"/>
	<xsl:template name="dxorder:SEC.EX.RATE.ACC"/>
	<xsl:template name="dxorder:SEC.ORDER.NO"/>
	<xsl:template name="dxorder:SEC.NARR"/>
	<xsl:template name="dxorder:SEC.CONSTRAINT"/>
	<xsl:template name="dxorder:SEC.DLV.AMT"/>
	<xsl:template name="dxorder:SEC.NET.COST"/>
	<xsl:template name="dxorder:SEC.PREM.EXC"/>
	<xsl:template name="dxorder:SEC.DLV.KEY"/>
	<xsl:template name="dxorder:SEC.TRANS.KEY"/>
	<xsl:template name="dxorder:SEC.CHG.OFFSET"/>
	<xsl:template name="dxorder:SEC.CUST.REF"/>
	<xsl:template name="dxorder:SEC.PND.SETT"/>
	<xsl:template name="dxorder:SEC.PND.LOTS"/>
	<xsl:template name="dxorder:SEC.LIMIT.REF"/>
	<xsl:template name="dxorder:SEC.PREM.TXN"/>
	<xsl:template name="dxorder:SEC.PREM.PST"/>
	<xsl:template name="dxorder:SEC.IM.AMT"/>
	<xsl:template name="dxorder:SEC.IM.ACC"/>
	<xsl:template name="dxorder:SEC.RT.COMPANY"/>
	<xsl:template name="dxorder:SEC.RT.PORT.ID"/>
	<xsl:template name="dxorder:SEC.RT.WHEN"/>
	<xsl:template name="dxorder:SEC.RT.LINK"/>
	<xsl:template name="dxorder:SEC.ENTITLE"/>
	<xsl:template name="dxorder:SEC.OVE.ADDR"/>
	<xsl:template name="dxorder:SEC.MESS.CTL"/>
	<xsl:template name="dxorder:SEC.PREM.OFFSET"/>
	<xsl:template name="dxorder:SEC.BEN.NO"/>
	<xsl:template name="dxorder:SEC.BEN.ADD"/>
	<xsl:template name="dxorder:SEC.CPY.NO"/>
	<xsl:template name="dxorder:SEC.CPY.ADD"/>
	<xsl:template name="dxorder:SEC.CPY.BNK.ACC"/>
	<xsl:template name="dxorder:SEC.INTR.BK.NO"/>
	<xsl:template name="dxorder:SEC.INTR.ADD"/>
	<xsl:template name="dxorder:SEC.CONF.NAR"/>
	<xsl:template name="dxorder:SEC.PYMT.NAR"/>
	<xsl:template name="dxorder:SEC.RCAD.NAR"/>
	<xsl:template name="dxorder:SEC.BK2BK.IN"/>
	<xsl:template name="dxorder:TICK.SIZE"/>
	<xsl:template name="dxorder:TICK.VALUE"/>
	<xsl:template name="dxorder:CONTRACT.SIZE"/>
	<xsl:template name="dxorder:ALT.IND.NAME"/>
	<xsl:template name="dxorder:ALT.IND.ID"/>
	<xsl:template name="dxorder:AI.RESERVED2"/>
	<xsl:template name="dxorder:AI.RESERVED1"/>
	<xsl:template name="dxorder:ORDER.DATE"/>
	<xsl:template name="dxorder:ORDER.TIME"/>
	<xsl:template name="dxorder:BROKER.DATE"/>
	<xsl:template name="dxorder:BROKER.TIME"/>
	<xsl:template name="dxorder:ORDER.STATUS">
		<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
			<field name="ORDER.STATUS">
				<xsl:value-of select=" 'CANCELLATION REQUEST' "/>
			</field>
		</xsl:if>
		<!--  new logic since channels does not post an order with status cancel, but the existing statuts and event_action_e = 7 = Cancel -->
        <xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
            <xsl:if test="b:orderStatus = '70'">
                <field name="ORDER.STATUS">
                    <xsl:value-of select=" 'CANCELLED' "/>
                </field>
            </xsl:if>
            <!--  expiration still comes from outside so its updating the status -->            
            <xsl:if test="b:orderStatus = '5' and b:userDefinedField[infra:name='ud_order_prev_status_e']/infra:value = '70'">
                <field name="ORDER.STATUS">
                    <xsl:value-of select=" 'EXPIRED' "/>
                </field>
            </xsl:if>
        </xsl:if>		
		<!--  end new logic  -->
	</xsl:template>
    <xsl:template name="dxorder:CANCEL.PEND.ORDERS">   
            <xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1' and 
                    (b:orderStatus = '75' or
                     (b:orderStatus = '5' and b:userDefinedField[infra:name='ud_order_prev_status_e']/infra:value = '75')
                    )">
                <field name="CANCEL.PEND.ORDERS">
                    <xsl:value-of select="'YES'"/>
                </field>
            </xsl:if>             
    </xsl:template>	
	<xsl:template name="dxorder:ORDER.LOTS">
		<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
			<xsl:if test="b:orderStatus = '0' and b:userDefinedField[infra:name='ud_order_prev_status_e']/infra:value = '75'">
				<field name="ORDER.LOTS">
					<xsl:value-of select="format-number(b:quantity,'#.#########','nan2zero') - format-number((b:userDefinedField[infra:name='ud_not_executed_order_qty_n']/infra:value),'#.#########','nan2zero')"/>
				</field>
			</xsl:if>
			<xsl:if test="b:orderStatus = '5' and b:userDefinedField[infra:name='ud_order_prev_status_e']/infra:value = '75'">
				<field name="ORDER.LOTS">
					<xsl:value-of select="format-number(b:quantity,'#.#########','nan2zero') - format-number((b:userDefinedField[infra:name='ud_not_executed_order_qty_n']/infra:value),'#.#########','nan2zero')"/>
				</field>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:LOTS.FILLED"/>
	<xsl:template name="dxorder:LOTS.OPEN"/>
	<xsl:template name="dxorder:UNDERLYING"/>
	<xsl:template name="dxorder:EXOTIC.TYPE"/>
	<xsl:template name="dxorder:EXOTIC.EVENT"/>
	<xsl:template name="dxorder:USR.FLD.NAME"/>
	<xsl:template name="dxorder:USR.FLD.VAL"/>
	<xsl:template name="dxorder:USR.FLD.TEXT"/>
	<xsl:template name="dxorder:USR.FLD.PRICE"/>
	<xsl:template name="dxorder:USR.RSVD.X3"/>
	<xsl:template name="dxorder:USR.RSVD.X4"/>
	<xsl:template name="dxorder:USR.RSVD.X5"/>
	<xsl:template name="dxorder:LIMIT.TYPE"/>
	<xsl:template name="dxorder:LIMIT.PRICE"/>
	<xsl:template name="dxorder:LIMIT.DATE"/>
	<xsl:template name="dxorder:ORDER.TYPE"/>
	<xsl:template name="dxorder:FX.PIP.TYPE"/>
	<xsl:template name="dxorder:FX.PIPS"/>
	<xsl:template name="dxorder:FX.PREM.AMT"/>
	<xsl:template name="dxorder:ORDER.ADVICE"/>
	<xsl:template name="dxorder:PARENT.REF"/>
	<xsl:template name="dxorder:CHILD.REF"/>
	<xsl:template name="dxorder:PENDING.DIARY"/>
	<xsl:template name="dxorder:SUPPRESS.ALL.MSG"/>
	<xsl:template name="dxorder:IND.PRICE"/>
	<xsl:template name="dxorder:ORIG.PRICE"/>
	<xsl:template name="dxorder:DAYS.PER.YEAR"/>
	<xsl:template name="dxorder:SPREAD.RATE"/>
	<xsl:template name="dxorder:SWAP.REFERENCE"/>
	<xsl:template name="dxorder:CAP.FLOOR"/>
	<xsl:template name="dxorder:HEDGE.PL.CATEG"/>
	<xsl:template name="dxorder:BUY.FLOATING.RATE"/>
	<xsl:template name="dxorder:SELL.FLOATING.RATE"/>
	<xsl:template name="dxorder:MASTER.AGREEMENT"/>
	<xsl:template name="dxorder:PERIOD.FREQUENCY"/>
	<xsl:template name="dxorder:PERIOD.START"/>
	<xsl:template name="dxorder:PERIOD.END.DATE"/>
	<xsl:template name="dxorder:PERIOD.FIX.DATE"/>
	<xsl:template name="dxorder:PERIOD.PAY.DATE"/>
	<xsl:template name="dxorder:PREM.PYMT.FREQ"/>
	<xsl:template name="dxorder:PREM.PYMT.DATE"/>
	<xsl:template name="dxorder:PREM.PYMT.AMT"/>
	<xsl:template name="dxorder:LOTS.TRANSFER"/>
	<xsl:template name="dxorder:DEST.CUST"/>
	<xsl:template name="dxorder:DEST.PORTFOLIO"/>
	<xsl:template name="dxorder:DEST.CUST.PORT"/>
	<xsl:template name="dxorder:CUST.CPARTY"/>
	<xsl:template name="dxorder:CUST.BNK.NME"/>
	<xsl:template name="dxorder:CUST.BNK.ADD"/>
	<xsl:template name="dxorder:CUST.BNK.SORT.CDE"/>
	<xsl:template name="dxorder:PRICE.TRADED"/>
	<xsl:template name="dxorder:FEE"/>
	<xsl:template name="dxorder:ADVICE"/>
	<xsl:template name="dxorder:CREATE.TRADES"/>
	<xsl:template name="dxorder:FILLED.LOTS"/>
	<xsl:template name="dxorder:FILLED.PRICE"/>
	<xsl:template name="dxorder:FILLED.IPRICE"/>
	<xsl:template name="dxorder:RESERVED.10"/>
	<xsl:template name="dxorder:RESERVED.11"/>
	<xsl:template name="dxorder:TREASURY.CUSTOMER"/>
	<xsl:template name="dxorder:LINK.REFERENCE"/>
	<xsl:template name="dxorder:RESERVED.X14"/>
	<xsl:template name="dxorder:RESERVED.X15"/>
	<xsl:template name="dxorder:LOCAL.REF"/>
	<xsl:template name="dxorder:OVERRIDE"/>
	<xsl:template name="dxorder:RECORD.STATUS"/>
	<xsl:template name="dxorder:CURR.NO"/>
	<xsl:template name="dxorder:INPUTTER"/>
	<xsl:template name="dxorder:DATE.TIME"/>
	<xsl:template name="dxorder:AUTHORISER"/>
	<xsl:template name="dxorder:CO.CODE"/>
	<xsl:template name="dxorder:DEPT.CODE"/>
	<xsl:template name="dxorder:AUDITOR.CODE"/>
	<xsl:template name="dxorder:AUDIT.DATE.TIME"/>
	<xsl:template name="dxorder:SY.DEAL.REF"/>
	<xsl:template name="dxorder:EXCLUDE.VALUATION"/>
	<xsl:template name="dxorder:CARRIER.ALLOWED"/>
	<xsl:template name="dxorder:PRI.PREMIUM.CCY"/>
	<xsl:template name="dxorder:PRI.PREM.PRICE"/>
	<xsl:template name="dxorder:PRI.PREM.EXCH.RATE"/>
	<xsl:template name="dxorder:PRI.TOTAL.PREM.AMT"/>
	<xsl:template name="dxorder:SEC.PREMIUM.CCY"/>
	<xsl:template name="dxorder:SEC.PREM.PRICE"/>
	<xsl:template name="dxorder:SEC.PREM.EXCH.RATE"/>
	<xsl:template name="dxorder:SEC.TOTAL.PREM.AMT"/>
	<xsl:template name="dxorder:PRI.EXCHANGE.TYPE"/>
	<xsl:template name="dxorder:PRI.CHANNEL"/>
	<xsl:template name="dxorder:RESERVED.X10"/>
	<xsl:template name="dxorder:RESERVED.X11"/>
	<xsl:template name="dxorder:RESERVED.X12"/>
	<xsl:template name="dxorder:RESERVED.X13"/>
	<xsl:template name="dxorder:RESERVED.X16"/>
	<xsl:template name="dxorder:RESERVED.X17"/>
	<xsl:template name="dxorder:RESERVED.X18"/>
	<xsl:template name="dxorder:RESERVED.X19"/>
	<xsl:template name="dxorder:RESERVED.X20"/>
	<xsl:template name="dxorder:RESERVED.X21"/>
	<xsl:template name="dxorder:RESERVED.X22"/>
	<xsl:template name="dxorder:RESERVED.X23"/>
	<xsl:template name="dxorder:RESERVED.X24"/>
	<xsl:template name="dxorder:RESERVED.X25"/>
	<xsl:template name="dxorder:RESERVED.X26"/>
	<xsl:template name="dxorder:RESERVED.X27"/>
	<xsl:template name="dxorder:RESERVED.X28"/>
	<xsl:template name="dxorder:RESERVED.X29"/>
	<xsl:template name="dxorder:RESERVED.X30"/>
	<xsl:template name="dxorder:RESERVED.X31"/>
	<xsl:template name="dxorder:RESERVED.X32"/>
	<xsl:template name="dxorder:RESERVED.X33"/>
	<xsl:template name="dxorder:RESERVED.X34"/>
	<xsl:template name="dxorder:RESERVED.X35"/>
	<xsl:template name="dxorder:RESERVED.X43"/>
	<xsl:template name="dxorder:STRIKE.QUOTE.CCY"/>
	<xsl:template name="dxorder:STRIKE.QUOTE"/>
	<xsl:template name="dxorder:CCY.BOUGHT"/>
	<xsl:template name="dxorder:AMT.BOUGHT"/>
	<xsl:template name="dxorder:CCY.SOLD"/>
	<xsl:template name="dxorder:AMT.SOLD"/>
	<xsl:template name="dxorder:AUTO.AUTHORISE"/>
	<xsl:template name="dxorder:ORDER.CLOSEOUT"/>
	<xsl:template name="dxorder:CLOSEOUT.TRADE"/>
	<xsl:template name="dxorder:RESERVED.X3"/>
	<xsl:template name="dxorder:RESERVED.X4"/>
	<xsl:template name="dxorder:RESERVED.X5"/>
	<xsl:template name="dxorder:CLOSEOUT.LOTS"/>
	<xsl:template name="dxorder:ORDER.AMEND">
		<field name="ORDER.AMEND">
			<xsl:value-of select="'YES'"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:USERDEF.FIELDS"/>
	<xsl:template name="secopenorder:transactionId">
		<transactionId>
			<xsl:value-of select="b:omsOrderReference"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="dxorder:ModelBankSpecificFields"/>
    <xsl:template name="dxorder:ModelBankSpecificFields-Custo"/>

	<xsl:template name="secopenorder:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder:ORDER.STATUS">
		<xsl:variable name="expiredNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'EXPIRED'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="cancelledNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'CANCELLED'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="placedNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'PLACED'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="partiallyexecutedNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'PARTIALLY EXECUTED'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="sentNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'SENT'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="receivedNumVar">
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'RECEIVED'"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="b:orderStatus = $expiredNumVar and b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
				<field name="ORDER.STATUS">
					<xsl:value-of select="'EXPIRED'"/>
				</field>
			</xsl:when>
			<xsl:when test="b:orderStatus = $cancelledNumVar and b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
				<field name="ORDER.STATUS">
					<xsl:value-of select="'CANCELLED'"/>
				</field>
			</xsl:when>
			<xsl:when test="((b:orderStatus = $placedNumVar) or (b:orderStatus = $sentNumVar) or (b:orderStatus = $receivedNumVar) or (b:orderStatus = $partiallyexecutedNumVar)) and b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
				<field name="ORDER.STATUS">
					<xsl:value-of select="'Cancellation Requested'"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder:ORDER.NUMBER"/>
	<xsl:template name="secopenorder:ORDER.DATE"/>
	<xsl:template name="secopenorder:ORDER.TIME"/>
	<xsl:template name="secopenorder:SECURITY.NO"/>
	<xsl:template name="secopenorder:VALUE.DATE"/>
	<xsl:template name="secopenorder:MATURITY.DATE"/>
	<xsl:template name="secopenorder:ORDER.TYPE"/>
	<xsl:template name="secopenorder:TYPE.OF.TRADE"/>
	<xsl:template name="secopenorder:TRANSACTION.CODE"/>
	<xsl:template name="secopenorder:TRADE.CCY"/>
	<xsl:template name="secopenorder:CUST.NUMBER"/>
	<xsl:template name="secopenorder:SECURITY.ACCNT"/>
	<xsl:template name="secopenorder:NO.NOMINAL"/>
	<xsl:template name="secopenorder:CU.CASH.AMOUNT"/>
	<xsl:template name="secopenorder:CURR.PRICE"/>
	<xsl:template name="secopenorder:CALC.CHRGS"/>
	<xsl:template name="secopenorder:CASH.CHRGS"/>
	<xsl:template name="secopenorder:SPLIT.CHRGS"/>
	<xsl:template name="secopenorder:CASH.ROUNDING"/>
	<xsl:template name="secopenorder:ADJUST.COMM"/>
	<xsl:template name="secopenorder:NARRATIVE"/>
	<xsl:template name="secopenorder:CUST.ACC.NO"/>
	<xsl:template name="secopenorder:CU.EX.RATE.ACC"/>
	<xsl:template name="secopenorder:SETTLEMENT.CCY"/>
	<xsl:template name="secopenorder:CU.BRKR.COMM"/>
	<xsl:template name="secopenorder:WAIVE.CU.BR.COM"/>
	<xsl:template name="secopenorder:RESERVED.9"/>
	<xsl:template name="secopenorder:RESERVED.8"/>
	<xsl:template name="secopenorder:CU.FOREIGN.FEE"/>
	<xsl:template name="secopenorder:CU.COMMISSION"/>
	<xsl:template name="secopenorder:CU.COMM.TAX"/>
	<xsl:template name="secopenorder:CU.STAMP.TAX"/>
	<xsl:template name="secopenorder:CU.EBV.FEES"/>
	<xsl:template name="secopenorder:CU.FEES.MISC"/>
	<xsl:template name="secopenorder:CU.DISC.PCENT"/>
	<xsl:template name="secopenorder:CU.DISC.AMT"/>
	<xsl:template name="secopenorder:CU.WHT.PERC"/>
	<xsl:template name="secopenorder:CU.WHT.TAX"/>
	<xsl:template name="secopenorder:COMM.CODE"/>
	<xsl:template name="secopenorder:COMM.PERCENT"/>
	<xsl:template name="secopenorder:COM.TAX.CODE"/>
	<xsl:template name="secopenorder:COM.TAX.BCUR"/>
	<xsl:template name="secopenorder:COM.TAX.XRTE"/>
	<xsl:template name="secopenorder:CU.DEPOSITORY"/>
	<xsl:template name="secopenorder:SUB.ACCOUNT"/>
	<xsl:template name="secopenorder:PORT.CONST.NO"/>
	<xsl:template name="secopenorder:CU.BROKER.NO"/>
	<xsl:template name="secopenorder:CU.NOTES"/>
	<xsl:template name="secopenorder:CU.ENTL.ID"/>
	<xsl:template name="secopenorder:CU.INT.CTR"/>
	<xsl:template name="secopenorder:BUYING.POWER"/>
	<xsl:template name="secopenorder:EXT.CUSTODIAN"/>
	<xsl:template name="secopenorder:CU.INCOME.ACC"/>
	<xsl:template name="secopenorder:CU.INCOME.CCY"/>
	<xsl:template name="secopenorder:LIMIT.PRICE"/>
	<xsl:template name="secopenorder:LIMIT.TYPE"/>
	<xsl:template name="secopenorder:LIMIT.EXP.DATE"/>
	<xsl:template name="secopenorder:LINK.ORDER.NO"/>
	<xsl:template name="secopenorder:DEPOSITORY"/>
	<xsl:template name="secopenorder:NOMINEE.CODE"/>
	<xsl:template name="secopenorder:ACCOUNT.MANAGER"/>
	<xsl:template name="secopenorder:ACCT.NARRATIVE"/>
	<xsl:template name="secopenorder:BROKER"/>
	<xsl:template name="secopenorder:DATE.TO.BROKER"/>
	<xsl:template name="secopenorder:TIME.TO.BROKER"/>
	<xsl:template name="secopenorder:AMT.TO.BROKER"/>
	<xsl:template name="secopenorder:BR.CASH.AMT"/>
	<xsl:template name="secopenorder:BR.PRICE"/>
	<xsl:template name="secopenorder:BROKER.TYPE"/>
	<xsl:template name="secopenorder:BR.SEC.ACCT"/>
	<xsl:template name="secopenorder:BR.ACC.NO"/>
	<xsl:template name="secopenorder:BR.ACCOUNT.CCY"/>
	<xsl:template name="secopenorder:BR.EX.RATE.ACC"/>
	<xsl:template name="secopenorder:BR.DELIV.INSTR"/>
	<xsl:template name="secopenorder:EXE.BY.BROKER"/>
	<xsl:template name="secopenorder:BANK.CORRES"/>
	<xsl:template name="secopenorder:BROK.CORRES"/>
	<xsl:template name="secopenorder:CONFIRMATION"/>
	<xsl:template name="secopenorder:DELIVERY.KEY"/>
	<xsl:template name="secopenorder:SECURITIES.CR.DR"/>
	<xsl:template name="secopenorder:REFERENCE.NO"/>
	<xsl:template name="secopenorder:CUSTOMER.NO"/>
	<xsl:template name="secopenorder:SEC.ACC.NO"/>
	<xsl:template name="secopenorder:BROKER.NO"/>
	<xsl:template name="secopenorder:EXE.DETAIL"/>
	<xsl:template name="secopenorder:NO.NOM.FILLED"/>
	<xsl:template name="secopenorder:TRADE.PRICE"/>
	<xsl:template name="secopenorder:TRADE.DATE"/>
	<xsl:template name="secopenorder:TRADE.TIME"/>
	<xsl:template name="secopenorder:ORDER.NOMINAL"/>
	<xsl:template name="secopenorder:LIQUIDATION.PERIOD"/>
	<xsl:template name="secopenorder:PREMIUM.PRICE"/>
	<xsl:template name="secopenorder:MARKET.TYPE"/>
	<xsl:template name="secopenorder:DEAL.STATUS">
		<xsl:choose>
			<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
				<xsl:choose>
					<xsl:when test="b:bulkChildIndicator = '2'">
						<field name="DEAL.STATUS">
							<xsl:value-of select="'CANCEL.CHILD'"/>
						</field>
					</xsl:when>
					<xsl:when test="b:bulkChildIndicator = '0'">
						<field name="DEAL.STATUS">
							<xsl:value-of select="'CANCEL'"/>
						</field>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder:DEAL.NARRATIVE"/>
	<xsl:template name="secopenorder:VAL.IN.SETT.CCY"/>
	<xsl:template name="secopenorder:VERIFY.BY.DEALER"/>
	<xsl:template name="secopenorder:LOCAL.REF"/>
	<xsl:template name="secopenorder:CUST.DEPO"/>
	<xsl:template name="secopenorder:CU.DEPO.NOM"/>
	<xsl:template name="secopenorder:CU.NOM.CODE"/>
	<xsl:template name="secopenorder:RESERVED07"/>
	<xsl:template name="secopenorder:STOCK.EXCHANGE"/>
	<xsl:template name="secopenorder:GROUP.ORDER"/>
	<xsl:template name="secopenorder:ODD.LOT.ORDER"/>
	<xsl:template name="secopenorder:ACTIVITY.CODE"/>
	<xsl:template name="secopenorder:MSG.BROKER"/>
	<xsl:template name="secopenorder:MSG.NO"/>
	<xsl:template name="secopenorder:MSG.CLASS"/>
	<xsl:template name="secopenorder:OVR.CARRIER"/>
	<xsl:template name="secopenorder:OVR.ADDRESS"/>
	<xsl:template name="secopenorder:SEND.ADVICE"/>
	<xsl:template name="secopenorder:SOFT.DLVRY.KEY"/>
	<xsl:template name="secopenorder:ROUT.COMPANY"/>
	<xsl:template name="secopenorder:CUM.EX.IND"/>
	<xsl:template name="secopenorder:WHT.TAX.CODE"/>
	<xsl:template name="secopenorder:SEGMENT"/>
	<xsl:template name="secopenorder:DEF.DEAL.DESK"/>
	<xsl:template name="secopenorder:ACT.DEAL.DESK"/>
	<xsl:template name="secopenorder:INT.CTR"/>
	<xsl:template name="secopenorder:SERVICE.REF"/>
	<xsl:template name="secopenorder:THREAD.KEY"/>
	<xsl:template name="secopenorder:TRADED.NOM"/>
	<xsl:template name="secopenorder:OUTSTAND.NOM"/>
	<xsl:template name="secopenorder:TRADER.CODE"/>
	<xsl:template name="secopenorder:TRADER.DESC"/>
	<xsl:template name="secopenorder:ROUT.SEC.ACC"/>
	<xsl:template name="secopenorder:ROUT.BROKER"/>
	<xsl:template name="secopenorder:ROUTED.ORDER.REF"/>
	<xsl:template name="secopenorder:IN.HOUSE.SEC.ACC"/>
	<xsl:template name="secopenorder:IN.HOUSE.CUSTODIAN"/>
	<xsl:template name="secopenorder:STP.ORDER"/>
	<xsl:template name="secopenorder:AUTHORISE.TRADE"/>
	<xsl:template name="secopenorder:PARENT"/>
	<xsl:template name="secopenorder:PARENT.REFERENCE"/>
	<xsl:template name="secopenorder:REVERSE.CHILD"/>
	<xsl:template name="secopenorder:EXE.HLT"/>
	<xsl:template name="secopenorder:TRADE.HLT"/>
	<xsl:template name="secopenorder:AUTHORISE.CHILD"/>
	<xsl:template name="secopenorder:DELETE.CHILD"/>
	<xsl:template name="secopenorder:ROUNDING.FACTOR"/>
	<xsl:template name="secopenorder:MKT.IDN.CODE"/>
	<xsl:template name="secopenorder:BULK.UPDATE"/>
	<xsl:template name="secopenorder:RESERVED9"/>
	<xsl:template name="secopenorder:RESERVED8"/>
	<xsl:template name="secopenorder:RESERVED7"/>
	<xsl:template name="secopenorder:RESERVED6"/>
	<xsl:template name="secopenorder:RESERVED5"/>
	<xsl:template name="secopenorder:RESERVED4"/>
	<xsl:template name="secopenorder:RESERVED3"/>
	<xsl:template name="secopenorder:RESERVED2"/>
	<xsl:template name="secopenorder:RESERVED1"/>
	<xsl:template name="secopenorder:OVERRIDE"/>
	<xsl:template name="secopenorder:RECORD.STATUS"/>
	<xsl:template name="secopenorder:CURR.NO"/>
	<xsl:template name="secopenorder:INPUTTER"/>
	<xsl:template name="secopenorder:DATE.TIME"/>
	<xsl:template name="secopenorder:AUTHORISER"/>
	<xsl:template name="secopenorder:CO.CODE"/>
	<xsl:template name="secopenorder:DEPT.CODE"/>
	<xsl:template name="secopenorder:AUDITOR.CODE"/>
	<xsl:template name="secopenorder:AUDIT.DATE.TIME"/>
	<xsl:template name="secopenorder:USERDEF.FIELDS"/>
	<xsl:template name="secopenorder:ModelBankSpecificFields"/>
	<xsl:template name="secopenorder:ModelBankSpecificFields-Custo"/>


	<xsl:template name="pecustomertxn:transactionId">
		<transactionId>
			<xsl:value-of select="b:userDefinedField[infra:name='source_code']/infra:value"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="pecustomertxn:ACCOUNT">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:PE.FUND"/>
	<xsl:template name="pecustomertxn:COMMITMENT.DATE">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMITMENT.AMOUNT">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMITMENT.STATUS">
		<field name="COMMITMENT.STATUS">
			<xsl:value-of select="'CANCELLED'"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:REFERENCE">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:CURRENCY"/>
	<xsl:template name="pecustomertxn:COMMISSION.AMOUNT">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMISSION.PERCENTAGE">
		
	</xsl:template>
	<xsl:template name="pecustomertxn:TAP.REF.ID">
		
	</xsl:template>
	
		<xsl:template name="pecustomertxn:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	
	<xsl:template name="pecustomertxn:ModelBankSpecificFields"/>
	<xsl:template name="pecustomertxn:ModelBankSpecificFields-Custo"/>
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