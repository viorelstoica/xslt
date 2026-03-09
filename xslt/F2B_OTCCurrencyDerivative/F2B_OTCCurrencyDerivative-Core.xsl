<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="transactionId">
				</xsl:template>
	<xsl:template name="CONTRACT.CODE">
		<field name="CONTRACT.CODE">
			<xsl:value-of select="b:attribute[@name = 'IN_CONTRACT_MASTER']"/>
		</field>
	</xsl:template>
	<xsl:template name="MATURITY.DATE">
		<field name="MATURITY.DATE">
		<xsl:call-template name="t24Date">
			<xsl:with-param name="tapDate" select = "b:attribute[@name = 'IN_END_DATE']"/>
			</xsl:call-template>
		</field>
	</xsl:template>
	<xsl:template name="OPTION.TYPE">
		<field name="OPTION.TYPE">
			<xsl:value-of select="b:attribute[@name = 'IN_OPTION_CLASS']"/>
		</field>
	</xsl:template>
	<xsl:template name="STRIKE.PRICE">
		
			<field name="STRIKE.PRICE">
				<xsl:value-of select="b:attribute[@name = 'IN_STRIKE_PRICE']"/>
			</field>
		
	</xsl:template>
	<xsl:template name="OPTION.STYLE">
		
		<field name="OPTION.STYLE">
			<xsl:value-of select="b:attribute[@name = 'IN_OPT_STYLE']"/>
		</field>
	</xsl:template>

	<xsl:template name="PRI.CUST.NO">
		<field name="PRI.CUST.NO">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:attribute[@name = 'OP_CUSTOMER'],$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:attribute[@name = 'OP_CUSTOMER']"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>

	<xsl:template name="PRI.SEC.ACC">
		<field name="PRI.SEC.ACC">
			<xsl:value-of select="b:attribute[@name = 'OP_PORTFOLIO']"/>
		</field>
	</xsl:template>
	<xsl:template name="PRI.ACCOUNT">
		<field name="PRI.ACCOUNT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="NARRATIVE">
		<field name="NARRATIVE">
			<xsl:value-of select="b:attribute[@name = 'OP_REMARK']"/>
		</field>
	</xsl:template>
	<xsl:template name="PRI.LOTS">
		
			<field name="PRI.LOTS">
				<xsl:value-of select="translate(b:attribute[@name = 'OP_QUANTITY'],',','')"/>
			</field>
		
	</xsl:template>
	<xsl:template name="PRI.PRICE">
		
	</xsl:template>

	<xsl:template name="PRI.BUY.SELL">
		<field name="PRI.BUY.SELL">
			<xsl:value-of select="b:attribute[@name = 'OP_NATURE']"/>
		</field>
	</xsl:template>
	<xsl:template name="PRI.OPEN.CLOSE">
		<field name="PRI.OPEN.CLOSE">
			<xsl:value-of select="b:attribute[@name = 'OP_DERIVATIVE_ORDER']"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:attribute[@name = 'OP_CODE']"/>
		</field>
	</xsl:template>
	<xsl:template name="CLOSEOUT.TRADE">
		<field name="CLOSEOUT.TRADE">
			<xsl:value-of select="b:attribute[@name = 'OP_REF_OPER_CODE']"/>
				
		</field>
	</xsl:template>

	<xsl:template name="CLOSEOUT.LOTS">
		<field name="CLOSEOUT.LOTS">
			<xsl:value-of select="b:attribute[@name = 'OP_CLOSE_QUANTITY']"/>
				
		</field>
	</xsl:template>

	<xsl:template name="TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../@eventIdentifier"/>
		</field>
	</xsl:template>

	<xsl:template name="SEC.CUST.NO">
		<field name="SEC.CUST.NO">
			<xsl:value-of select="b:attribute[@name = 'OP_COUNTERPARTY']"/>
		</field>
	</xsl:template>
	<xsl:template name="SEC.PRICE">
		<field name="SEC.PRICE">
			<xsl:value-of select="translate(b:attribute[@name = 'OP_QUOTE'],',','')"/>
		</field>
	</xsl:template>

	<xsl:template name="SEC.OPEN.CLOSE">
		<field name="SEC.OPEN.CLOSE">
			<xsl:value-of select="b:attribute[@name = 'OP_DERIVATIVE_ORDER']"/>
		</field>
	</xsl:template>

	<xsl:template name="TRADE.DATE">
		<field name="TRADE.DATE">
		<xsl:call-template name="t24Date">
			<xsl:with-param name="tapDate" select = "b:attribute[@name = 'OP_OPERATION_D']"/>
			</xsl:call-template>
			<!--<xsl:value-of select="translate(b:attribute[@name = 'OP_OPERATION_D'],'-','')"/>-->
		</field>
	</xsl:template>

	<xsl:template name="TRADE.CCY">
		
			<field name="TRADE.CCY">
				<xsl:value-of select="b:attribute[@name = 'IN_REF_CCY']"/>
			</field>
		
	</xsl:template>
	<xsl:template name="DLV.CCY">
		
			<field name="DLV.CCY">
				<xsl:value-of select="b:attribute[@name = 'IN_UNDERLY_CCY']"/>
				</field>
		
	</xsl:template>
	<xsl:template name="STRIKE.QUOTE.CCY">
		
			<field name="STRIKE.QUOTE.CCY">
				<xsl:value-of select="b:attribute[@name = 'IN_STRIKE_QUOTE_CCY']"/>
			</field>
		
	</xsl:template>
	<xsl:template name="STRIKE.QUOTE">
			<field name="STRIKE.QUOTE">
				<xsl:value-of select="b:attribute[@name = 'IN_STRIKE_QUOTE']"/>
			</field>
	</xsl:template>

	
	<xsl:template name="PRI.CHANNEL">
			<field name="PRI.CHANNEL">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_FAX'">
					<xsl:value-of select="'ELECTRONIC'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_INTERNET'">
					<xsl:value-of select="'ONLINE'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_MEETING' or b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_LETTER' or b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_OTHER' or b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_EMAIL'">
					<xsl:value-of select="'RM'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'OP_CONTACT_METHOD'] = 'PCK_GL_PHONE'">
					<xsl:value-of select="'TELEPHONE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="OPTION.VARIANT">
		<xsl:if test="b:attribute[@name = 'IN_PAYOFF_NATURE'] != ''">
		<field name="OPTION.VARIANT">
			<xsl:value-of select="b:attribute[@name = 'IN_PAYOFF_NATURE']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="BARRIER.TYPE">
		<xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] != ''">
		<field name="BARRIER.TYPE">
			<xsl:value-of select="b:attribute[@name = 'IN_SUB_NATURE']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="EXOTIC.TYPE.1">
		<xsl:if test="b:attribute[@name = 'IN_EXOTIC_TYPE_1'] != ''">
		<field name="EXOTIC.TYPE:1">
			<xsl:value-of select="b:attribute[@name = 'IN_EXOTIC_TYPE_1']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="EXOTIC.TYPE.2">
	 	<xsl:choose>
		<xsl:when test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'UIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'UOKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DOKO') 
		                and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
						and b:attribute[@name='IN_EXOTIC_TYPE_3'] !=''">
				<field name="EXOTIC.TYPE:2">
					<xsl:value-of select="b:attribute[@name = 'IN_EXOTIC_TYPE_3']"/>
				</field>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="b:attribute[@name = 'IN_EXOTIC_TYPE_2'] != ''">
				<field name="EXOTIC.TYPE:2">
					<xsl:value-of select="b:attribute[@name = 'IN_EXOTIC_TYPE_2']"/>
				</field>
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="EXOTIC.TYPE.3">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKIN' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKOT') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'IN_EXOTIC_TYPE_3'] != ''">
		<field name="EXOTIC.TYPE:3">
			<xsl:value-of select="b:attribute[@name = 'IN_EXOTIC_TYPE_3']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.1.1">
		<xsl:if test="b:attribute[@name = 'IN_BARRIER'] != ''">
		<field name="USR.FLD.VAL:1:1">
			<xsl:value-of select="b:attribute[@name = 'IN_BARRIER']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.NAME.1.2">
		<xsl:if test="b:attribute[@name = 'IN_EVENT_TIME'] != ''">
		<field name="USR.FLD.NAME:1:2">
			<xsl:value-of select="b:attribute[@name = 'IN_EVENT_TIME']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.1.2">
		<xsl:if test="b:attribute[@name = 'IN_EXEC_LOCATION_TIM'] != ''"> 
		<field name="USR.FLD.VAL:1:2">
			<xsl:value-of select="b:attribute[@name = 'IN_EXEC_LOCATION_TIM']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.2.1">
		<xsl:choose>
		<xsl:when test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'UIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'UOKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DOKO') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_NAME'] != ''">
			 <field name="USR.FLD.VAL:2:1">
				<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_NAME']"/>
			 </field>
		</xsl:when>
		<xsl:otherwise>
		<xsl:if test="b:attribute[@name = 'IN_UPPER_BARRIER'] != ''">
			<field name="USR.FLD.VAL:2:1">
				<xsl:value-of select="b:attribute[@name = 'IN_UPPER_BARRIER']"/>
			</field>
		</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.2.2">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'UIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'UOKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DOKO') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_CCY'] != ''">
			<field name="USR.FLD.VAL:2:2">
				<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_CCY']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.2.3">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'UIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'UOKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DIKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DOKO') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_AMT'] != ''">
			<field name="USR.FLD.VAL:2:3">
				<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_AMT']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.NAME.2.2">
		<xsl:if test="b:attribute[@name = 'IN_EVENT_TIME'] != '' and b:attribute[@name = 'IN_UPPER_BARRIER'] != ''">
		<field name="USR.FLD.NAME:2:2">
			<xsl:value-of select="b:attribute[@name = 'IN_EVENT_TIME']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.3.1">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKIN' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKOT') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_NAME'] != ''">
		<field name="USR.FLD.VAL:3:1">
			<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_NAME']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.3.2">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKIN' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKOT') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_CCY'] != ''">
		<field name="USR.FLD.VAL:3:2">
			<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_CCY']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="USR.FLD.VAL.3.3">
		<xsl:if test="(b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKI' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DUKO' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKIN' or b:attribute[@name = 'IN_SUB_NATURE'] = 'DKOT') 
					  and b:attribute[@name='IN_PAYOFF_NATURE']='BINA'
					  and b:attribute[@name = 'OP_CASH_PAYOUT_AMT'] != ''">
		<field name="USR.FLD.VAL:3:3">
			<xsl:value-of select="b:attribute[@name = 'OP_CASH_PAYOUT_AMT']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SUPPRESS.ALL.MSG">
		<field name="SUPPRESS.ALL.MSG">
			<xsl:value-of select="b:attribute[@name = 'OP_SUPPRESS_ALL_MSG']"/>
		</field>
	</xsl:template>
	<xsl:template name="SETTLEMENT.SOURCE">
	 	<xsl:if test="b:attribute[@name = 'IN_SETTLEMENT_SOURCE'] != ''">
		<field name="SETTLEMENT.SOURCE">
		 	<xsl:value-of select="b:attribute[@name='IN_SETTLEMENT_SOURCE']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ORDER.ID"/>
	<xsl:template name="EXCHANGE.CODE"/>
	<xsl:template name="SUB.ASSET.TYPE"/>
	<xsl:template name="TRADE.STATUS"/>
	<xsl:template name="INP.MAT.DATE"/>
	<xsl:template name="TRADE.TYPE"/>
	<xsl:template name="DEC.DATE"/>
	<xsl:template name="CONTRACT.CCY"/>
	<xsl:template name="TRANSFER.TYPE"/>
	<xsl:template name="ORDER.TYPE"/>
	<xsl:template name="INT.STRIKE.PRICE"/>
	<xsl:template name="PREMIUM.DUE"/>
	<xsl:template name="CURRENCY.MARKET"/>
	<xsl:template name="POSITION.TYPE"/>
	<xsl:template name="CONTRACT.TIME"/>
	<xsl:template name="DEALER.DESK"/>
	<xsl:template name="DEPT.ACCT.OFFICER"/>
	<xsl:template name="EXTERNAL.REF"/>
	<xsl:template name="REGION"/>
	<xsl:template name="VALUATION.PRICE"/>
	<xsl:template name="PRI.INT.PRICE"/>
	<xsl:template name="PRI.TRADE.COST"/>
	<xsl:template name="PRI.CUST.TYPE"/>
	<xsl:template name="PRI.CUST.STATUS"/>
	<xsl:template name="PRI.ORIG.LOTS"/>
	<xsl:template name="PRI.SETTNOS"/>
	<xsl:template name="PRI.SETTLOTS"/>
	<xsl:template name="PRI.HEDGE.TRADE">
		
	</xsl:template>
	<xsl:template name="PRI.LINK">
		
	</xsl:template>
	<xsl:template name="PRI.ALLOW.SETT"/>
	<xsl:template name="PRI.STRATEGY">
		
	</xsl:template>
	<xsl:template name="PRI.CACC.CCY"/>
	<xsl:template name="PRI.COMM.EXC"/>
	<xsl:template name="PRI.CACC.AMT"/>
	<xsl:template name="PRI.COMM.TAX"/>
	<xsl:template name="PRI.CHARGE.DATE"/>
	<xsl:template name="PRI.TAX.CODE"/>
	<xsl:template name="PRI.TAX.TYPE"/>
	<xsl:template name="TAX.AMT.ACY"/>
	<xsl:template name="TAX.AMT.TCY"/>
	<xsl:template name="PRI.REF.CCY"/>
	<xsl:template name="PRI.ACC.CCY"/>
	<xsl:template name="PRI.EX.RATE.REF"/>
	<xsl:template name="PRI.EX.RATE.ACC"/>
	<xsl:template name="PRI.DLV.AMT"/>
	<xsl:template name="PRI.NET.COST"/>
	<xsl:template name="PRI.PREM.EXC"/>
	<xsl:template name="PRI.DLV.KEY"/>
	<xsl:template name="PRI.TRANS.KEY"/>
	<xsl:template name="PRI.ORDER.NO"/>
	<xsl:template name="PRI.NARR"/>
	<xsl:template name="PRI.CONSTRAINT"/>
	<xsl:template name="PRI.CHG.OFFSET"/>
	<xsl:template name="PRI.CUST.REF"/>
	<xsl:template name="PRI.PND.SETT"/>
	<xsl:template name="PRI.PND.LOTS"/>
	<xsl:template name="PRI.LIMIT.REF"/>
	<xsl:template name="PRI.PREM.TXN"/>
	<xsl:template name="PRI.PREM.PST"/>
	<xsl:template name="PRI.IM.AMT"/>
	<xsl:template name="PRI.IM.ACC"/>
	<xsl:template name="PRI.RT.COMPANY"/>
	<xsl:template name="PRI.RT.PORT.ID"/>
	<xsl:template name="PRI.RT.WHEN"/>
	<xsl:template name="PRI.RT.LINK"/>
	<xsl:template name="PRI.ENTITLE"/>
	<xsl:template name="PRI.OVE.ADDR"/>
	<xsl:template name="PRI.MESS.CTL"/>
	<xsl:template name="PRI.PREM.OFFSET"/>
	<xsl:template name="PRI.BEN.NO"/>
	<xsl:template name="PRI.BEN.ADD"/>
	<xsl:template name="PRI.CPY.NO"/>
	<xsl:template name="PRI.CPY.ADD"/>
	<xsl:template name="PRI.CPY.BNK.ACC"/>
	<xsl:template name="PRI.INTR.BK.NO"/>
	<xsl:template name="PRI.INTR.ADD"/>
	<xsl:template name="PRI.CONF.NAR"/>
	<xsl:template name="PRI.PYMT.NAR"/>
	<xsl:template name="PRI.RCAD.NAR"/>
	<xsl:template name="PRI.BK2BK.IN"/>
	<xsl:template name="SEC.SEC.ACC"/>
	<xsl:template name="SEC.CUST.TYPE"/>
	<xsl:template name="SEC.CUST.STATUS"/>
	<xsl:template name="SEC.ACCOUNT"/>
	<xsl:template name="SEC.BUY.SELL"/>
	<xsl:template name="SEC.LOTS"/>
	<xsl:template name="SEC.ORIG.LOTS"/>
	<xsl:template name="SEC.SETTNOS"/>
	<xsl:template name="SEC.SETTLOTS"/>
	<xsl:template name="SEC.INT.PRICE"/>
	<xsl:template name="SEC.TRADE.COST"/>
	<xsl:template name="SEC.HEDGE.TRADE"/>
	<xsl:template name="SEC.LINK"/>
	<xsl:template name="SEC.ALLOW.SETT"/>
	<xsl:template name="SEC.STRATEGY"/>
	<xsl:template name="SEC.AUTO.MANUAL"/>
	<xsl:template name="SEC.COMM.TYP"/>
	<xsl:template name="SEC.COMM.CDE"/>
	<xsl:template name="SEC.COMM.CCY"/>
	<xsl:template name="SEC.COMM.AMT"/>
	<xsl:template name="SEC.COMM.ACC"/>
	<xsl:template name="SEC.CACC.CCY"/>
	<xsl:template name="SEC.COMM.EXC"/>
	<xsl:template name="SEC.CACC.AMT"/>
	<xsl:template name="SEC.COMM.TAX"/>
	<xsl:template name="SEC.CHARGE.DATE"/>
	<xsl:template name="SEC.TAX.CODE"/>
	<xsl:template name="SEC.TAX.TYPE"/>
	<xsl:template name="SEC.TAX.AMT.ACY"/>
	<xsl:template name="SEC.TAX.AMT.TCY"/>
	<xsl:template name="SEC.REF.CCY"/>
	<xsl:template name="SEC.ACC.CCY"/>
	<xsl:template name="SEC.EX.RATE.REF"/>
	<xsl:template name="SEC.EX.RATE.ACC"/>
	<xsl:template name="SEC.ORDER.NO"/>
	<xsl:template name="SEC.NARR"/>
	<xsl:template name="SEC.CONSTRAINT"/>
	<xsl:template name="SEC.DLV.AMT"/>
	<xsl:template name="SEC.NET.COST"/>
	<xsl:template name="SEC.PREM.EXC"/>
	<xsl:template name="SEC.DLV.KEY"/>
	<xsl:template name="SEC.TRANS.KEY"/>
	<xsl:template name="SEC.CHG.OFFSET"/>
	<xsl:template name="SEC.CUST.REF"/>
	<xsl:template name="SEC.PND.SETT"/>
	<xsl:template name="SEC.PND.LOTS"/>
	<xsl:template name="SEC.LIMIT.REF"/>
	<xsl:template name="SEC.PREM.TXN"/>
	<xsl:template name="SEC.PREM.PST"/>
	<xsl:template name="SEC.IM.AMT"/>
	<xsl:template name="SEC.IM.ACC"/>
	<xsl:template name="SEC.RT.COMPANY"/>
	<xsl:template name="SEC.RT.PORT.ID"/>
	<xsl:template name="SEC.RT.WHEN"/>
	<xsl:template name="SEC.RT.LINK"/>
	<xsl:template name="SEC.ENTITLE"/>
	<xsl:template name="SEC.OVE.ADDR"/>
	<xsl:template name="SEC.MESS.CTL"/>
	<xsl:template name="SEC.PREM.OFFSET"/>
	<xsl:template name="SEC.BEN.NO"/>
	<xsl:template name="SEC.BEN.ADD"/>
	<xsl:template name="SEC.CPY.NO"/>
	<xsl:template name="SEC.CPY.ADD"/>
	<xsl:template name="SEC.CPY.BNK.ACC"/>
	<xsl:template name="SEC.INTR.BK.NO"/>
	<xsl:template name="SEC.INTR.ADD"/>
	<xsl:template name="SEC.CONF.NAR"/>
	<xsl:template name="SEC.PYMT.NAR"/>
	<xsl:template name="SEC.RCAD.NAR"/>
	<xsl:template name="SEC.BK2BK.IN"/>
	<xsl:template name="TICK.SIZE"/>
	<xsl:template name="TICK.VALUE"/>
	<xsl:template name="CONTRACT.SIZE"/>
	<xsl:template name="ALT.IND.NAME"/>
	<xsl:template name="ALT.IND.ID"/>
	<xsl:template name="AI.RESERVED2"/>
	<xsl:template name="AI.RESERVED1"/>
	<xsl:template name="ORDER.DATE"/>
	<xsl:template name="ORDER.TIME"/>
	<xsl:template name="BROKER.DATE"/>
	<xsl:template name="BROKER.TIME"/>
	<xsl:template name="LOTS.FILLED"/>
	<xsl:template name="LOTS.OPEN"/>
	<xsl:template name="UNDERLYING"/>
	<xsl:template name="EXOTIC.EVENT"/>
	<xsl:template name="USR.FLD.NAME"/>
	<xsl:template name="USR.FLD.TEXT"/>
	<xsl:template name="USR.FLD.VAL"/>
	<xsl:template name="USR.FLD.PRICE"/>
	<xsl:template name="USR.RSVD.X3"/>
	<xsl:template name="USR.RSVD.X4"/>
	<xsl:template name="USR.RSVD.X5"/>
	<xsl:template name="FX.PIP.TYPE"/>
	<xsl:template name="FX.PIPS"/>
	<xsl:template name="FX.PREM.AMT"/>
	<xsl:template name="ORDER.ADVICE"/>
	<xsl:template name="PARENT.REF"/>
	<xsl:template name="CHILD.REF"/>
	<xsl:template name="PENDING.DIARY"/>
	<xsl:template name="IND.PRICE"/>
	<xsl:template name="ORIG.PRICE"/>
	<xsl:template name="DAYS.PER.YEAR"/>
	<xsl:template name="SPREAD.RATE"/>
	<xsl:template name="SWAP.REFERENCE"/>
	<xsl:template name="CAP.FLOOR"/>
	<xsl:template name="HEDGE.PL.CATEG"/>
	<xsl:template name="BUY.FLOATING.RATE"/>
	<xsl:template name="SELL.FLOATING.RATE"/>
	<xsl:template name="MASTER.AGREEMENT"/>
	<xsl:template name="PERIOD.FREQUENCY"/>
	<xsl:template name="PERIOD.START"/>
	<xsl:template name="PERIOD.END.DATE"/>
	<xsl:template name="PERIOD.FIX.DATE"/>
	<xsl:template name="PERIOD.PAY.DATE"/>
	<xsl:template name="PREM.PYMT.FREQ"/>
	<xsl:template name="PREM.PYMT.DATE"/>
	<xsl:template name="PREM.PYMT.AMT"/>
	<xsl:template name="LOTS.TRANSFER"/>
	<xsl:template name="DEST.CUST"/>
	<xsl:template name="DEST.PORTFOLIO"/>
	<xsl:template name="DEST.CUST.PORT"/>
	<xsl:template name="CUST.CPARTY"/>
	<xsl:template name="CUST.BNK.NME"/>
	<xsl:template name="CUST.BNK.ADD"/>
	<xsl:template name="CUST.BNK.SORT.CDE"/>
	<xsl:template name="FEE"/>
	<xsl:template name="ADVICE"/>
	<xsl:template name="CREATE.TRADES"/>
	<xsl:template name="FILLED.LOTS"/>
	<xsl:template name="FILLED.PRICE"/>
	<xsl:template name="FILLED.IPRICE"/>
	<xsl:template name="RESERVED.10"/>
	<xsl:template name="RESERVED.11"/>
	<xsl:template name="TREASURY.CUSTOMER"/>
	<xsl:template name="LINK.REFERENCE"/>
	<xsl:template name="RESERVED.X14"/>
	<xsl:template name="RESERVED.X15"/>
	<xsl:template name="LOCAL.REF"/>
	<xsl:template name="OVERRIDE"/>
	<xsl:template name="RECORD.STATUS"/>
	<xsl:template name="CURR.NO"/>
	<xsl:template name="INPUTTER"/>
	<xsl:template name="DATE.TIME"/>
	<xsl:template name="AUTHORISER"/>
	<xsl:template name="CO.CODE"/>
	<xsl:template name="DEPT.CODE"/>
	<xsl:template name="AUDITOR.CODE"/>
	<xsl:template name="AUDIT.DATE.TIME"/>
	<xsl:template name="SY.DEAL.REF"/>
	<xsl:template name="EXCLUDE.VALUATION"/>
	<xsl:template name="CARRIER.ALLOWED"/>
	<xsl:template name="PRI.PREMIUM.CCY">
	<field name="PRI.PREMIUM.CCY">
			<xsl:value-of select="b:attribute[@name = 'OP_PREMIUM_CCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="PRI.PREM.PRICE"/>
	<xsl:template name="PRI.PREM.EXCH.RATE"/>
	<xsl:template name="PRI.TOTAL.PREM.AMT">
	<field name="PRI.TOTAL.PREM.AMT">
			<xsl:value-of select="b:attribute[@name = 'OP_PREMIUM_AMT']"/>
		</field>
	</xsl:template>
	<xsl:template name="SEC.PREMIUM.CCY"/>
	<xsl:template name="SEC.PREM.PRICE"/>
	<xsl:template name="SEC.PREM.EXCH.RATE"/>
	<xsl:template name="SEC.TOTAL.PREM.AMT"/>
	<xsl:template name="PRI.EXCHANGE.TYPE"/>
	<xsl:template name="RESERVED.X10"/>
	<xsl:template name="RESERVED.X11"/>
	<xsl:template name="RESERVED.X12"/>
	<xsl:template name="RESERVED.X13"/>
	<xsl:template name="RESERVED.X16"/>
	<xsl:template name="RESERVED.X17"/>
	<xsl:template name="RESERVED.X18"/>
	<xsl:template name="RESERVED.X19"/>
	<xsl:template name="RESERVED.X20"/>
	<xsl:template name="RESERVED.X21"/>
	<xsl:template name="RESERVED.X22"/>
	<xsl:template name="RESERVED.X23"/>
	<xsl:template name="RESERVED.X24"/>
	<xsl:template name="RESERVED.X25"/>
	<xsl:template name="RESERVED.X26"/>
	<xsl:template name="RESERVED.X27"/>
	<xsl:template name="RESERVED.X28"/>
	<xsl:template name="RESERVED.X29"/>
	<xsl:template name="RESERVED.X30"/>
	<xsl:template name="RESERVED.X31"/>
	<xsl:template name="RESERVED.X32"/>
	<xsl:template name="RESERVED.X33"/>
	<xsl:template name="RESERVED.X34"/>
	<xsl:template name="RESERVED.X35"/>
	<xsl:template name="RESERVED.X43"/>
	<xsl:template name="CCY.BOUGHT"/>
	<xsl:template name="AMT.BOUGHT"/>
	<xsl:template name="CCY.SOLD"/>
	<xsl:template name="AMT.SOLD"/>
	<xsl:template name="RESERVED.X3"/>
	<xsl:template name="RESERVED.X4"/>
	<xsl:template name="RESERVED.X5"/>
	<xsl:template name="USERDEF.FIELDS"/>
	<xsl:template name="ModelBankSpecificFields"/>
	<xsl:template name="ModelBankSpecificFields-Custo"/>

	
		
	<xsl:template name="PRI.COMM.TYP">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION_TYPE'] != ''">
			<field name="PRI.COMM.TYP:1:1">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION_TYPE']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.CDE">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION_CODE'] != ''">
			<field name="PRI.COMM.CDE:1:1">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION_CODE']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.CCY">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION_CCY'] != ''">
			<field name="PRI.COMM.CCY:1:1">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION_CCY']"/>
			</field>
		</xsl:if>	
	</xsl:template>
	<xsl:template name="PRI.COMM.AMT">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION'] != ''">
			<field name="PRI.COMM.AMT:1:1">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.ACC">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION_ACCT'] != ''">
			<field name="PRI.COMM.ACC:1:1">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION_ACCT']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.AUTO.MANUAL">
		<xsl:if test="b:attribute[@name = 'OP_COMMISSION_FLAG'] != ''">
			<field name="PRI.AUTO.MANUAL">
				<xsl:value-of select="b:attribute[@name = 'OP_COMMISSION_FLAG']"/>
			</field>
		</xsl:if>
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