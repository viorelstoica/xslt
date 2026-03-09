<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="CURRENCY.BOUGHT">
		<field name="CURRENCY.BOUGHT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACC2_CURRENCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="CURRENCY.SOLD">
		<field name="CURRENCY.SOLD">
			<xsl:value-of select="b:attribute[@name = 'OP_ACC_CURRENCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="CONTRACT.CCY">
		<field name="CONTRACT.CCY">
			<xsl:value-of select="b:attribute[@name = 'OP_CURRENCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="TRADE.DATE">
		<field name="TRADE.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'OP_OPERATION_D']"/>
            </xsl:call-template>		
		</field>
	</xsl:template>
	<xsl:template name="VALUE.DATE">
		<field name="VALUE.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'OP_VALUE_D']"/>
            </xsl:call-template>        
		</field>
	</xsl:template>
	<xsl:template name="CUSTOMER">
		<field name="CUSTOMER">
			<xsl:value-of select="b:attribute[@name = 'OP_PORTFOLIO_THIRD']"/>
		</field>
	</xsl:template>
	<xsl:template name="PORTFOLIO">
		<field name="PORTFOLIO">
			<xsl:value-of select="b:attribute[@name = 'OP_PORTFOLIO']"/>
		</field>
	</xsl:template>
	<xsl:template name="COUNTERPARTY">
		<field name="COUNTERPARTY">
			<xsl:value-of select="b:attribute[@name = 'OP_COUNTERPARTY']"/>
		</field>
	</xsl:template>
	<xsl:template name="CU.BUY.CCY.ACCT">
		<field name="CU.BUY.CCY.ACCT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT2']"/>
		</field>
	</xsl:template>
	<xsl:template name="CU.SELL.CCY.ACCT">
		<field name="CU.SELL.CCY.ACCT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="FEE.CCY">
		<xsl:if test="b:attribute[@name = 'OP_BP4_CURRENCY'] and b:attribute[@name = 'OP_BP4_CURRENCY'] != ''">
			<field name="FEE.CCY">
				<xsl:value-of select="b:attribute[@name = 'OP_BP4_CURRENCY']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="FEE.AMT">
		<xsl:if test="b:attribute[@name = 'OP_BP4_AMOUNT'] and b:attribute[@name = 'OP_BP4_AMOUNT'] != ''">
			<field name="FEE.AMT">
		          <xsl:call-template name="t24Amount">
                    <xsl:with-param name="tapAmount" select="b:attribute[@name = 'OP_BP4_AMOUNT']"/>
                  </xsl:call-template>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="FEE.ACC">
		<xsl:if test="b:attribute[@name = 'OP_ACCOUNT'] and b:attribute[@name = 'OP_ACCOUNT'] != ''">
			<field name="FEE.ACC">
				<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="B.STRIKE.PRICE">
		<field name="B.STRIKE.PRICE">
			<xsl:value-of select="b:attribute[@name = 'IN_CALL_REDEMP_QUOTE']"/>
		</field>
	</xsl:template>
	<xsl:template name="B.CALL.CCY"/>
	<xsl:template name="B.CALL.AMT">
		<field name="B.CALL.AMT">
            <xsl:call-template name="t24Amount">
              <xsl:with-param name="tapAmount" select="b:attribute[@name = 'IN_CALL_UNDER_QTY']"/>
            </xsl:call-template>			
		</field>
	</xsl:template>
	<xsl:template name="B.PUT.CCY"/>
	<xsl:template name="B.FIXING.FREQUENCY">
		<field name="B.FIXING.FREQUENCY">
            <xsl:call-template name="sySetFixingFrequency">
                <xsl:with-param name="fixingDate"><xsl:value-of select="b:attribute[@name = 'IN_CALL_FIX_DATE']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequency"><xsl:value-of select="b:attribute[@name = 'IN_CALL_PAY_FRQ']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequencyUnit"><xsl:value-of select="b:attribute[@name = 'IN_CALL_PAY_FRQ_UNIT']"/></xsl:with-param>             
            </xsl:call-template>
        </field>
	</xsl:template>
	<xsl:template name="B.KNOCKIN.PRICE">
		<field name="B.KNOCKIN.PRICE">
			<xsl:value-of select="b:attribute[@name = 'IN_CALL_BARR']"/>
		</field>
	</xsl:template>
	<xsl:template name="B.KNOCKOUT.PRICE">
        <field name="B.KNOCKOUT.PRICE">	
	        <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 94 and b:attribute[@name = 'IN_CALL_UPPER_BARR']">
	              <xsl:value-of select="b:attribute[@name = 'IN_CALL_UPPER_BARR']"/>
	        </xsl:if>
        </field>    	
	</xsl:template>
	<xsl:template name="S.STRIKE.PRICE">
		<field name="S.STRIKE.PRICE">
			<xsl:value-of select="b:attribute[@name = 'IN_PUT_REDEMP_QUOTE']"/>
		</field>
	</xsl:template>
	<xsl:template name="S.CALL.CCY"/>
	<xsl:template name="S.PUT.CCY"/>
	<xsl:template name="S.PUT.AMT">
		<field name="S.PUT.AMT">
            <xsl:call-template name="t24Amount">
              <xsl:with-param name="tapAmount" select="b:attribute[@name = 'IN_PUT_UNDER_QTY']"/>
            </xsl:call-template>    			
		</field>
	</xsl:template>
	<xsl:template name="S.FIXING.FREQUENCY">
		<field name="S.FIXING.FREQUENCY">
            <xsl:call-template name="sySetFixingFrequency">
                <xsl:with-param name="fixingDate"><xsl:value-of select="b:attribute[@name = 'IN_PUT_FIX_DATE']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequency"><xsl:value-of select="b:attribute[@name = 'IN_PUT_PAY_FRQ']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequencyUnit"><xsl:value-of select="b:attribute[@name = 'IN_PUT_PAY_FRQ_UNIT']"/></xsl:with-param>             
            </xsl:call-template>
		</field>
	</xsl:template>
	<xsl:template name="S.KNOCKIN.PRICE">
		<field name="S.KNOCKIN.PRICE">
			<xsl:value-of select="b:attribute[@name = 'IN_PUT_BARR']"/>
		</field>
	</xsl:template>
	<xsl:template name="S.KNOCKOUT.PRICE">
		<field name="S.KNOCKOUT.PRICE">
            <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 94 and b:attribute[@name = 'IN_PUT_UPPER_BARR']">
                  <xsl:value-of select="b:attribute[@name = 'IN_PUT_UPPER_BARR']"/>
            </xsl:if>   
		</field>
	</xsl:template>
	<xsl:template name="VB.STRIKE.PRICE">
		<xsl:if test="b:attribute[@name = 'IN_VAN_UNDER_QTY']">
		<field name="VB.STRIKE.PRICE">
			<xsl:value-of select="b:attribute[@name = 'IN_VAN_REDEMP_QUOTE']"/>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="VB.CALL.CCY"/>
	<xsl:template name="VB.CALL.AMT">
		<xsl:if test="b:attribute[@name = 'IN_VAN_UNDER_QTY']">
		<field name="VB.CALL.AMT">
            <xsl:call-template name="t24Amount">
              <xsl:with-param name="tapAmount" select="b:attribute[@name = 'IN_VAN_UNDER_QTY']"/>
            </xsl:call-template>   			
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="VB.PUT.CCY"/>
	<xsl:template name="VB.FIXING.FREQUENCY">
		<xsl:if test="b:attribute[@name = 'IN_VAN_UNDER_QTY']">
		<field name="VB.FIXING.FREQUENCY">
            <xsl:call-template name="sySetFixingFrequency">
                <xsl:with-param name="fixingDate"><xsl:value-of select="b:attribute[@name = 'IN_VAN_FIX_DATE']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequency"><xsl:value-of select="b:attribute[@name = 'IN_VAN_PAY_FRQ']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequencyUnit"><xsl:value-of select="b:attribute[@name = 'IN_VAN_PAY_FRQ_UNIT']"/></xsl:with-param>             
            </xsl:call-template>
		</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:attribute[@name = 'OP_CODE']"/>
		</field>
	</xsl:template>
    <xsl:template name="TAP.EVENT.ID">
        <field name="TAP.EVENT.ID">
            <xsl:value-of select="../@eventIdentifier"/>
        </field>
    </xsl:template>	
	<xsl:template name="ID"/>
	<xsl:template name="VARIANT">
        <field name="VARIANT">
            <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 94 and $SY_PFWD_VARIANT">
                <xsl:value-of select="$SY_PFWD_VARIANT"/>
            </xsl:if>
            <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 95 and $SY_TARKO_VARIANT">
                <xsl:value-of select="$SY_PFWD_VARIANT"/>
            </xsl:if>            
        </field>	
	</xsl:template>
	<xsl:template name="DESCRIPTION">
        <field name="DESCRIPTION">
            <xsl:value-of select="b:attribute[@name = 'IN_NAME']"/>
         </field>	
	</xsl:template>
	<xsl:template name="CONTRACT.STATUS"/>
	<xsl:template name="BUY.CCY.CALENDAR"/>
	<xsl:template name="SEL.CCY.CALENDAR"/>
	<xsl:template name="DAY.CONVENTION"/>
	<xsl:template name="SUPPRESS.UNDERLYING"/>
	<xsl:template name="INCL.VANILLA.OPTION">
        <field name="INCL.VANILLA.OPTION">
            <xsl:if test="b:attribute[@name = 'IN_VAN_UNDER_QTY']">BUY</xsl:if>
        </field>    	   
	</xsl:template>
    <xsl:template name="DX.CONTRACT.CODE">
        <field name="DX.CONTRACT.CODE">        
	        <xsl:choose>
	            <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '94'">
	                <xsl:if test="$SY_PFWD_AGENCY_BOOKING != 'Y'">
	                    <xsl:value-of select="$SY_OTC_FX_CONTRACT_CODE"/>
	                </xsl:if>
	            </xsl:when>
	            <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '95'">
	                <xsl:if test="$SY_TARKO_AGENCY_BOOKING != 'Y'">
	                    <xsl:value-of select="$SY_OTC_FX_CONTRACT_CODE"/>
	                </xsl:if>
	            </xsl:when>
	        </xsl:choose>  
        </field>    	         
    </xsl:template>	
	<xsl:template name="SPOT.PRICE"/>
	<xsl:template name="BASE.CCY">
        <field name="BASE.CCY">
            <xsl:value-of select="b:attribute[@name = 'IN_CALL_UNDERL_CCY']"/>
        </field>	
	</xsl:template>
	<xsl:template name="TRADE.TIME"/>
	<xsl:template name="TERM"/>
	<xsl:template name="MATURITY.DATE">
	    <field name="MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_CALL_END_DATE']"/>
            </xsl:call-template>    	    
        </field>
	</xsl:template>
	<xsl:template name="FINAL.SETT.DATE"/>
	<xsl:template name="CPARTY.PORTFOLIO"/>
	<xsl:template name="CPARTY.BUY.CCY.ACCT"/>
	<xsl:template name="CPARTY.SELL.CCY.ACCT"/>
	<xsl:template name="COUNTERPARTY.TRADE"/>
	<xsl:template name="PREMIUM.PAY.RECEIVE"/>
	<xsl:template name="PREMIUM.CCY"/>
	<xsl:template name="PREMIUM.PRICE"/>
	<xsl:template name="PREMIUM.AMT"/>
	<xsl:template name="PREMIUM.ACC"/>
	<xsl:template name="CPTY.PREM.AMT"/>
	<xsl:template name="PREM.RESERVED.5"/>
	<xsl:template name="PREM.RESERVED.4"/>
	<xsl:template name="NOT.PER.FIXING">
	   
	</xsl:template>
	<xsl:template name="GEARING.FACTOR"/>
	<xsl:template name="LEV.NOT.PER.FIXING"/>
	<xsl:template name="TOT.NOTIONAL.SELL.CCY"/>
	<xsl:template name="TOT.NOTIONAL.BUY.CCY"/>
	<xsl:template name="RUN.NOTIONAL.SELL.CCY"/>
	<xsl:template name="RUN.NOTIONAL.BUY.CCY"/>
	<xsl:template name="EXTERNAL.REF"/>
	<xsl:template name="SY.DX.REFERENCE"/>
	<xsl:template name="B2B.REFERENCE"/>
	<xsl:template name="TRANSACTION.REF"/>
	<xsl:template name="DEALER.DESK"/>
	<xsl:template name="SETTLEMENT.METHOD">
        <field name="SETTLEMENT.METHOD">PHYSICAL</field>	   
	</xsl:template>
	<xsl:template name="FX.PAYOUT.CCY"/>
	<xsl:template name="CPTY.FEE.AMT"/>
	<xsl:template name="FEE.RESERVED.5"/>
	<xsl:template name="FEE.RESERVED.4"/>
	<xsl:template name="FEE.RESERVED.3"/>
	<xsl:template name="FEE.RESERVED.2"/>
	<xsl:template name="FEE.RESERVED.1"/>
	<xsl:template name="UNWIND"/>
	<xsl:template name="UNWIND.CHG.CCY"/>
	<xsl:template name="UNWIND.CHG.AMT"/>
	<xsl:template name="UNWIND.CHG.ACC"/>
	<xsl:template name="UNWIND.EFF.DATE"/>
	<xsl:template name="CPTY.UNWIND.CHG.AMT"/>
	<xsl:template name="ACCR.INTRINSIC.VAL"/>
	<xsl:template name="RESERVED.34"/>
	<xsl:template name="RESERVED.33"/>
	<xsl:template name="RESERVED.32"/>
	<xsl:template name="RESERVED.31"/>
	<xsl:template name="B.OPTION.STYLE"/>
	<xsl:template name="B.OPTION.TYPE"/>
	<xsl:template name="B.PUT.AMT"/>
	<xsl:template name="B.DIFFERENT.AMT"/>
	<xsl:template name="B.FIXING.PERIODS"/>
	<xsl:template name="B.MATURITY.DATE">
        <field name="B.MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_CALL_END_DATE']"/>
            </xsl:call-template>            
        </field>	
	</xsl:template>
	<xsl:template name="B.TOTAL.CALL.AMT"/>
	<xsl:template name="B.TOTAL.PUT.AMT"/>
	<xsl:template name="B.KNOCK.IN"/>
	<xsl:template name="B.KNOCK.OUT"/>
	<xsl:template name="B.KNOCKOUT.INTRINSIC">
        <field name="B.KNOCKOUT.INTRINSIC"> 
            <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 95 and b:attribute[@name = 'IN_CALL_UPPER_BARR']">
                  <xsl:value-of select="b:attribute[@name = 'IN_CALL_UPPER_BARR']"/>
            </xsl:if>
        </field>   	
	</xsl:template>
	<xsl:template name="B.RUN.CURRENT.FIXING"/>
	<xsl:template name="B.UNDO.FIXING"/>
	<xsl:template name="B.UNDO.KNOCKOUT"/>
	<xsl:template name="B.DX.REFERENCE"/>
	<xsl:template name="B.LEV.CALL.AMT"/>
	<xsl:template name="B.LEV.PUT.AMT"/>
	<xsl:template name="RESERVED.28"/>
	<xsl:template name="RESERVED.27"/>
	<xsl:template name="RESERVED.26"/>
	<xsl:template name="B.FIXING.DATE"/>
	<xsl:template name="B.SETTLEMENT.DATE"/>
	<xsl:template name="B.SCHEDULE.CALL.AMT"/>
	<xsl:template name="B.SCHEDULE.PUT.AMT"/>
	<xsl:template name="B.SPOT.EXCHANGE.RATE"/>
	<xsl:template name="B.SETTLEMENT.AMT"/>
	<xsl:template name="B.FIXING"/>
	<xsl:template name="B.FIXED.STATUS"/>
	<xsl:template name="B.LEV.SCHED.CALL.AMT"/>
	<xsl:template name="B.LEV.SCHED.PUT.AMT"/>
	<xsl:template name="B.CPTY.SETT.AMOUNT"/>
	<xsl:template name="B.FIX.PRD.START.DATE"/>
	<xsl:template name="B.APPLY.LEVERAGE"/>
	<xsl:template name="RESERVED.25"/>
	<xsl:template name="RESERVED.24"/>
	<xsl:template name="RESERVED.23"/>
	<xsl:template name="RESERVED.22"/>
	<xsl:template name="RESERVED.21"/>
	<xsl:template name="S.OPTION.STYLE"/>
	<xsl:template name="S.OPTION.TYPE"/>
	<xsl:template name="S.CALL.AMT"/>
	<xsl:template name="S.DIFFERENT.AMT"/>
	<xsl:template name="S.FIXING.PERIODS"/>
	<xsl:template name="S.MATURITY.DATE">
        <field name="S.MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_PUT_END_DATE']"/>
            </xsl:call-template>            
        </field>    	
	</xsl:template>
	<xsl:template name="S.TOTAL.CALL.AMT"/>
	<xsl:template name="S.TOTAL.PUT.AMT"/>
	<xsl:template name="S.KNOCK.IN"/>
	<xsl:template name="S.KNOCK.OUT"/>
	<xsl:template name="S.KNOCKOUT.INTRINSIC">
        <field name="S.KNOCKOUT.INTRINSIC">
            <xsl:if test="b:attribute[@name = 'IN_SUB_NATURE'] = 95 and b:attribute[@name = 'IN_PUT_UPPER_BARR']">
                  <xsl:value-of select="b:attribute[@name = 'IN_PUT_UPPER_BARR']"/>
            </xsl:if>   
        </field>	
	</xsl:template>
	<xsl:template name="S.RUN.CURRENT.FIXING"/>
	<xsl:template name="S.UNDO.FIXING"/>
	<xsl:template name="S.UNDO.KNOCKOUT"/>
	<xsl:template name="S.DX.REFERENCE"/>
	<xsl:template name="RESERVED.20"/>
	<xsl:template name="RESERVED.19"/>
	<xsl:template name="RESERVED.18"/>
	<xsl:template name="RESERVED.17"/>
	<xsl:template name="RESERVED.16"/>
	<xsl:template name="S.FIXING.DATE"/>
	<xsl:template name="S.SETTLEMENT.DATE"/>
	<xsl:template name="S.SCHEDULE.CALL.AMT"/>
	<xsl:template name="S.SCHEDULE.PUT.AMT"/>
	<xsl:template name="S.SPOT.EXCHANGE.RATE"/>
	<xsl:template name="S.SETTLEMENT.AMT"/>
	<xsl:template name="S.FIXING"/>
	<xsl:template name="S.FIXED.STATUS"/>
	<xsl:template name="S.CPTY.SETT.AMOUNT"/>
	<xsl:template name="S.FIX.PRD.START.DATE"/>
	<xsl:template name="RESERVED.13"/>
	<xsl:template name="RESERVED.12"/>
	<xsl:template name="RESERVED.11"/>
	<xsl:template name="VB.OPTION.STYLE"/>
	<xsl:template name="VB.OPTION.TYPE"/>
	<xsl:template name="VB.PUT.AMT"/>
	<xsl:template name="VB.DIFFERENT.AMT"/>
	<xsl:template name="VB.FIXING.PERIODS"/>
	<xsl:template name="VB.MATURITY.DATE">
		<xsl:if test="b:attribute[@name = 'IN_VAN_UNDER_QTY']">
        <field name="VB.MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_VAN_END_DATE']"/>
            </xsl:call-template>            
        </field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="VB.TOTAL.CALL.AMT"/>
	<xsl:template name="VB.TOTAL.PUT.AMT"/>
	<xsl:template name="VB.UNDO.FIXING"/>
	<xsl:template name="VB.DX.REFERENCE"/>
	<xsl:template name="RESERVED.10"/>
	<xsl:template name="RESERVED.09"/>
	<xsl:template name="RESERVED.08"/>
	<xsl:template name="RESERVED.07"/>
	<xsl:template name="RESERVED.06"/>
	<xsl:template name="VB.FIXING.DATE"/>
	<xsl:template name="VB.SETTLEMENT.DATE"/>
	<xsl:template name="VB.SCHEDULE.CALL.AMT"/>
	<xsl:template name="VB.SCHEDULE.PUT.AMT"/>
	<xsl:template name="VB.SPOT.EXCHANGE.RATE"/>
	<xsl:template name="VB.SETTLEMENT.AMT"/>
	<xsl:template name="VB.FIXING"/>
	<xsl:template name="VB.FIXED.STATUS"/>
	<xsl:template name="VB.CPTY.SETT.AMOUNT"/>
	<xsl:template name="VB.FIX.PRD.START.DATE"/>
	<xsl:template name="RESERVED.03"/>
	<xsl:template name="RESERVED.02"/>
	<xsl:template name="RESERVED.01"/>
	<xsl:template name="VS.RESERVED.14"/>
	<xsl:template name="VS.RESERVED.13"/>
	<xsl:template name="VS.RESERVED.12"/>
	<xsl:template name="SINGLE.SCHEDULE">
	    <field name="SINGLE.SCHEDULE">NO</field>
	</xsl:template>
	<xsl:template name="SY.MASTER"/>
	<xsl:template name="RISK.LEVEL"/>
	<xsl:template name="LIMIT.REF"/>
	<xsl:template name="LIMIT.DETS"/>
	<xsl:template name="PYMT.MSG.REQD"/>
	<xsl:template name="CPARTY.BUY.CCY"/>
	<xsl:template name="CP.BCCY.BEN.BANK"/>
	<xsl:template name="CP.BCCY.BEN.ADD"/>
	<xsl:template name="CP.BCCY.BEN.ACCT"/>
	<xsl:template name="CP.BCCY.INTR.BANK"/>
	<xsl:template name="CP.BCCY.INTR.ADD"/>
	<xsl:template name="CP.BCCY.CPTY.NO"/>
	<xsl:template name="CP.BCCY.CPTY.ADD"/>
	<xsl:template name="CP.BCCY.CPTY.ACCT"/>
	<xsl:template name="TRADER.ID"/>
	<xsl:template name="FIXING.REF.RATE"/>
	<xsl:template name="TARGET.ITM"/>
	<xsl:template name="ACCRUED.ITM"/>
	<xsl:template name="ACCRUED.TARGET.FCTR"/>
	<xsl:template name="TARGET.PROFIT"/>
	<xsl:template name="RM.MARKUP"/>
	<xsl:template name="EXEC.CHANNEL"/>
	<xsl:template name="NARRATIVE"/>
	<xsl:template name="FINAL.STRIKE"/>
	<xsl:template name="CPARTY.SELL.CCY"/>
	<xsl:template name="CP.SCCY.BEN.BANK"/>
	<xsl:template name="CP.SCCY.BEN.ADD"/>
	<xsl:template name="CP.SCCY.BEN.ACCT"/>
	<xsl:template name="CP.SCCY.INTR.BANK"/>
	<xsl:template name="CP.SCCY.INTR.ADD"/>
	<xsl:template name="CP.SCCY.CPTY.NO"/>
	<xsl:template name="CP.SCCY.CPTY.ADD"/>
	<xsl:template name="CP.SCCY.CPTY.ACCT"/>
	<xsl:template name="GUARANTEED.PERIOD"/>
	<xsl:template name="VS.RESERVED.10"/>
	<xsl:template name="VS.RESERVED.09"/>
	<xsl:template name="VS.RESERVED.08"/>
	<xsl:template name="VS.RESERVED.07"/>
	<xsl:template name="VS.RESERVED.06"/>
	<xsl:template name="VS.RESERVED.05"/>
	<xsl:template name="VS.RESERVED.04"/>
	<xsl:template name="VS.RESERVED.03"/>
	<xsl:template name="VS.RESERVED.02"/>
	<xsl:template name="VS.RESERVED.01"/>
	<xsl:template name="LOCAL.REF"/>
	<xsl:template name="ModelBankSpecificFields"/>
    <xsl:template name="ModelBankSpecificFields-Custo"/>
	<xsl:template name="USERDEF.FIELDS"/>
</xsl:stylesheet>