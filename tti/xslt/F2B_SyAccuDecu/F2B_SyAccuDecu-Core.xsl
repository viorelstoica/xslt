<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="ID"/>
	<xsl:template name="PRODUCT.TYPE">
		<field name="PRODUCT.TYPE">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '72'">
					<xsl:value-of select="'ACCUMULATOR'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '73'">
					<xsl:value-of select="'DECUMULATOR'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'NOT_SUPPORTED'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="VARIANT">
		<xsl:if test="$SY_ACCUDECU_VARIANT != ''">
			<field name="VARIANT">
				<xsl:value-of select="$SY_ACCUDECU_VARIANT"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="DESCRIPTION">
		<field name="DESCRIPTION">
			<xsl:value-of select="b:attribute[@name = 'IN_NAME']"/>
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
	<xsl:template name="MATURITY.DATE">
		<field name="MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_END_D']"/>
            </xsl:call-template>		
		</field>
	</xsl:template>
	<xsl:template name="SECURITY.CODE">
		<field name="SECURITY.CODE">
			<xsl:value-of select="b:attribute[@name = 'IN_TE_UNDERLY_INS']"/>
		</field>
	</xsl:template>
	<xsl:template name="CONTRACT.CCY">
		<field name="CONTRACT.CCY">
			<xsl:value-of select="b:attribute[@name = 'IN_REF_CURR']"/>
		</field>
	</xsl:template>
	<xsl:template name="STRIKE.PRICE1">
		<field name="STRIKE.PRICE1">
			<xsl:value-of select="b:attribute[@name = 'IN_TE_EXER_QUOTE']"/>
		</field>
	</xsl:template>
	<xsl:template name="KNOCKIN.PRICE">
		<field name="KNOCKIN.PRICE">
            <xsl:choose>
                <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '72'">
		            <xsl:if test="b:attribute[@name = 'IN_TE_BARR']">
		                  <xsl:value-of select="b:attribute[@name = 'IN_TE_BARR']"/>
		            </xsl:if>
                </xsl:when>
                <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '73'">
                    <xsl:if test="b:attribute[@name = 'IN_TE_UPPER_BARR']">
                          <xsl:value-of select="b:attribute[@name = 'IN_TE_UPPER_BARR']"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'NOT_SUPPORTED'"/>
                </xsl:otherwise>
            </xsl:choose>		

		</field>
	</xsl:template>
	<xsl:template name="KNOCKOUT.PRICE">
		<field name="KNOCKOUT.PRICE">
		     <xsl:choose>
	             <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '72'">
	                 <xsl:if test="b:attribute[@name = 'IN_TE_UPPER_BARR']">
	                       <xsl:value-of select="b:attribute[@name = 'IN_TE_UPPER_BARR']"/>
	                 </xsl:if>
	
	             </xsl:when>
	             <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '73'">
	                 <xsl:if test="b:attribute[@name = 'IN_TE_BARR']">
	                       <xsl:value-of select="b:attribute[@name = 'IN_TE_BARR']"/>
	                 </xsl:if>
	             </xsl:when>
             </xsl:choose>
        </field>		
	</xsl:template>
	<xsl:template name="DAILY.UNITS">
		<field name="DAILY.UNITS">
			<xsl:value-of select="b:attribute[@name = 'IN_TE_UNDERLY_QTY']"/>
		</field>
	</xsl:template>
	<xsl:template name="GEARING">
		<field name="GEARING">
			<xsl:value-of select="b:attribute[@name = 'IN_TE_LEVERAGE']"/>
		</field>
	</xsl:template>
	<xsl:template name="PROTECTED.DATE"/>
	<xsl:template name="CUSTOMER">
		<field name="CUSTOMER">
			<xsl:value-of select="b:attribute[@name = 'OP_CUSTOMER']"/>
		</field>
	</xsl:template>
	<xsl:template name="PORTFOLIO">
		<field name="PORTFOLIO">
			<xsl:value-of select="b:attribute[@name = 'OP_PORTFOLIO']"/>
		</field>
	</xsl:template>
	<xsl:template name="CUSTOMER.ACCOUNT">
		<field name="CUSTOMER.ACCOUNT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="FIXING.FREQUENCY">
		<field name="FIXING.FREQUENCY">
            <xsl:call-template name="sySetFixingFrequency">
                <xsl:with-param name="fixingDate"><xsl:value-of select="b:attribute[@name = 'IN_FIX_DATE']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequency"><xsl:value-of select="b:attribute[@name = 'IN_PAY_FREQ']"/></xsl:with-param>
                <xsl:with-param name="fixingFrequencyUnit"><xsl:value-of select="b:attribute[@name = 'IN_PAY_FREQ_UNIT']"/></xsl:with-param>             
            </xsl:call-template>		    
		</field>
	</xsl:template>
	<xsl:template name="FEE.CCY">
		<field name="FEE.CCY">
			<xsl:value-of select="b:attribute[@name = 'OP_BP4_CURRENCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="FEE.AMT">
		<field name="FEE.AMT">
			<xsl:value-of select="b:attribute[@name = 'OP_BP4_AMOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="FEE.ACCT">
		<field name="FEE.ACCT">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="RISK.LEVEL">
		<field name="RISK.LEVEL">
			<xsl:value-of select="b:attribute[@name = 'IN_RISK_LEVEL']"/>
		</field>
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
	
	<xsl:template name="CONTRACT.STATUS"/>
	<xsl:template name="CONTRACT.IDENTIFIER"/>
	<xsl:template name="PRINCIPAL.AGENT"/>
	<xsl:template name="COUNTERPARTY.TRADE"/>
	<xsl:template name="OPTION.TYPE"/>
	<xsl:template name="TERM"/>
	<xsl:template name="STOCK.EXCHANGE"/>
	<xsl:template name="DX.CONTRACT.CODE">
	   <xsl:if test="not($SY_ACCUDECU_AGENCY_BOOKING = 'Y')">
	        <field name="DX.CONTRACT.CODE">
	            <xsl:value-of select="b:attribute[@name = 'IN_CONTRACT_MASTER']"/>
	        </field>	       
	   </xsl:if>
	</xsl:template>
	<xsl:template name="REFERENCE.PRICE"/>
	<xsl:template name="STRIKE.PRICE2"/>
	<xsl:template name="SUPPRESS.UNDERLYING"/>
	<xsl:template name="MIN.ACCRUAL.PERIOD"/>
	<xsl:template name="MIN.PERIOD.KOUT"/>
	<xsl:template name="TOT.WORK.DAYS"/>
	<xsl:template name="TOTAL.UNITS"/>
	<xsl:template name="SECURITY.POS"/>
	<xsl:template name="BLOCK.NOMINAL"/>
	<xsl:template name="BLOCK.UNTIL.SC"/>
	<xsl:template name="BLOCK.REF.SC"/>
	<xsl:template name="UNBLK.NOM.PEND"/>
	<xsl:template name="RESERVED.44"/>
	<xsl:template name="BLOCK.FUNDS"/>
	<xsl:template name="BLOCK.AMOUNT"/>
	<xsl:template name="BLOCK.ACCOUNT"/>
	<xsl:template name="CREDIT.ACCOUNT"/>
	<xsl:template name="BLOCK.UNTIL.AC"/>
	<xsl:template name="BLOCKED.REF.AC"/>
	<xsl:template name="RESERVED.43"/>
	<xsl:template name="RESERVED.42"/>
	<xsl:template name="COUNTERPARTY">
       <field name="COUNTERPARTY">
          <xsl:value-of select="b:attribute[@name = 'OP_COUNTERPARTY']"/>
       </field>	   
	</xsl:template>
	<xsl:template name="CPARTY.PORTFOLIO"/>
	<xsl:template name="COUNTERPARTY.ACC"/>
	<xsl:template name="PREMIUM.CCY"/>
	<xsl:template name="PREMIUM.PER.LOT"/>
	<xsl:template name="PREMIUM.AMT"/>
	<xsl:template name="NOTIONAL.AMT"/>
	<xsl:template name="RUN.NOTIONAL.AMT"/>
	<xsl:template name="SETTLEMENT.METHOD">
       <field name="SETTLEMENT.METHOD">PHYSICAL</field> 	
	</xsl:template>
	<xsl:template name="ALTERNATE.REF"/>
	<xsl:template name="SY.DX.REFERENCE"/>
	<xsl:template name="B2B.REFERENCE"/>
	<xsl:template name="UNDERLYING.REF"/>
	<xsl:template name="SETTLE.INSTRUMENT"/>
	<xsl:template name="DELIVERY.CURRENCY"/>
	<xsl:template name="KNOCK.IN"/>
	<xsl:template name="PRICE.AT.KNOCK.IN"/>
	<xsl:template name="KNOCK.OUT"/>
	<xsl:template name="PRICE.AT.KNOCK.OUT"/>
	<xsl:template name="UNWIND"/>
	<xsl:template name="UNWIND.CHG.CCY"/>
	<xsl:template name="UNWIND.CHG.AMT"/>
	<xsl:template name="UNWIND.CHG.ACC"/>
	<xsl:template name="UNWIND.SPREAD"/>
	<xsl:template name="UNWIND.TOT.CHARGE"/>
	<xsl:template name="UNWIND.EFF.DATE"/>
	<xsl:template name="UNWIND.STATUS"/>
	<xsl:template name="NEW.DAILY.UNITS"/>
	<xsl:template name="NEW.TOTAL.UNITS"/>
	<xsl:template name="CPTY.UNWIND.CHG.AMT"/>
	<xsl:template name="UNWIND.RESERVED.3"/>
	<xsl:template name="UNWIND.RESERVED.2"/>
	<xsl:template name="UNWIND.RESERVED.1"/>
	<xsl:template name="SUSPEND.ACCRUAL"/>
	<xsl:template name="SUSPENSION.DATE"/>
	<xsl:template name="SUSP.RESET.DATE"/>
	<xsl:template name="FIX.SUSPENSION"/>
	<xsl:template name="FIXING.DATE"/>
	<xsl:template name="WORKING.DAYS"/>
	<xsl:template name="SETTLEMENT.DATE"/>
	<xsl:template name="ACCRUED.UNITS1"/>
	<xsl:template name="ACCRUED.UNITS2"/>
	<xsl:template name="FIXED.STATUS"/>
	<xsl:template name="SETT.INSTR.UNITS"/>
	<xsl:template name="SETT.INSTR.PRICE"/>
	<xsl:template name="MARKET.PRICE"/>
	<xsl:template name="DLV.EXCH.RATE"/>
	<xsl:template name="SETTLEMENT.AMOUNT"/>
	<xsl:template name="CPTY.SETT.AMOUNT"/>
	<xsl:template name="RESERVED.32"/>
	<xsl:template name="RESERVED.31"/>
	<xsl:template name="RESERVED.30"/>
	<xsl:template name="RESERVED.29"/>
	<xsl:template name="RESERVED.28"/>
	<xsl:template name="RESERVED.27"/>
	<xsl:template name="RESERVED.26"/>
	<xsl:template name="RESERVED.25"/>
	<xsl:template name="RESERVED.24"/>
	<xsl:template name="ACCRUED.UNTIL"/>
	<xsl:template name="TRANS.REFERENCE"/>
	<xsl:template name="CPTY.FEE.AMT"/>
	<xsl:template name="FEE.RESERVED.5"/>
	<xsl:template name="FEE.RESERVED.4"/>
	<xsl:template name="FEE.RESERVED.3"/>
	<xsl:template name="FEE.RESERVED.2"/>
	<xsl:template name="FEE.RESERVED.1"/>
	<xsl:template name="NOVATION"/>
	<xsl:template name="NOVATION.EFF.DATE"/>
	<xsl:template name="NOVATION.FEE.CCY"/>
	<xsl:template name="NOVATION.FEE.AMT"/>
	<xsl:template name="NOVATION.FEE.ACC"/>
	<xsl:template name="NOVATED.FROM"/>
	<xsl:template name="NOVATED.TO"/>
	<xsl:template name="NOVATION.REFERENCE"/>
	<xsl:template name="PREMIUM.ACC"/>
	<xsl:template name="PREM.PAYMENT.DATE"/>
	<xsl:template name="CPTY.PREM.AMT"/>
	<xsl:template name="PREMIUM.PAY.RECEIVE"/>
	<xsl:template name="PREM.RESERVED.5"/>
	<xsl:template name="PREM.RESERVED.4"/>
	<xsl:template name="PREM.RESERVED.3"/>
	<xsl:template name="PREM.RESERVED.2"/>
	<xsl:template name="PREM.RESERVED.1"/>
	<xsl:template name="CHGS.RESERVED.20"/>
	<xsl:template name="CHGS.RESERVED.19"/>
	<xsl:template name="CHGS.RESERVED.18"/>
	<xsl:template name="CHGS.RESERVED.17"/>
	<xsl:template name="CHGS.RESERVED.16"/>
	<xsl:template name="CHGS.RESERVED.15"/>
	<xsl:template name="CHGS.RESERVED.14"/>
	<xsl:template name="CHGS.RESERVED.13"/>
	<xsl:template name="CHGS.RESERVED.12"/>
	<xsl:template name="CHGS.RESERVED.11"/>
	<xsl:template name="CU.NET.AMT"/>
	<xsl:template name="CHGS.RESERVED.10"/>
	<xsl:template name="CHGS.RESERVED.9"/>
	<xsl:template name="CHGS.RESERVED.8"/>
	<xsl:template name="CHGS.RESERVED.7"/>
	<xsl:template name="CHGS.RESERVED.6"/>
	<xsl:template name="CHGS.RESERVED.5"/>
	<xsl:template name="CHGS.RESERVED.4"/>
	<xsl:template name="CHGS.RESERVED.3"/>
	<xsl:template name="CHGS.RESERVED.2"/>
	<xsl:template name="CHGS.RESERVED.1"/>
	<xsl:template name="CPTY.NET.AMT"/>
	<xsl:template name="SETTLEMENT.ROLE"/>
	<xsl:template name="DEALER.DESK"/>
	<xsl:template name="REMAINING.UNITS"/>
	<xsl:template name="SUSPEND.BY.SYS"/>
	<xsl:template name="CALC.SETTLE.AMT"/>
	<xsl:template name="SY.MASTER"/>
	<xsl:template name="CALENDAR"/>
	<xsl:template name="COVERED.CONTRACT"/>
	<xsl:template name="LIMIT.REF"/>
	<xsl:template name="LIMIT.DETS"/>
	<xsl:template name="PYMT.MSG.REQD"/>
	<xsl:template name="BEN.BANK"/>
	<xsl:template name="BEN.ADD"/>
	<xsl:template name="BEN.ACCT"/>
	<xsl:template name="INTR.BANK"/>
	<xsl:template name="INTR.ADD"/>
	<xsl:template name="CPTY.NO"/>
	<xsl:template name="CPTY.ADD"/>
	<xsl:template name="CPTY.ACCT"/>
	<xsl:template name="RESERVED.15"/>
	<xsl:template name="RESERVED.14"/>
	<xsl:template name="RESERVED.13"/>
	<xsl:template name="RESERVED.12"/>
	<xsl:template name="RESERVED.11"/>
	<xsl:template name="RESERVED.10"/>
	<xsl:template name="RESERVED.09"/>
	<xsl:template name="RESERVED.08"/>
	<xsl:template name="RESERVED.07"/>
	<xsl:template name="RESERVED.06"/>
	<xsl:template name="RESERVED.05"/>
	<xsl:template name="RESERVED.04"/>
	<xsl:template name="RESERVED.03"/>
	<xsl:template name="RESERVED.02"/>
	<xsl:template name="RESERVED.01"/>
	<xsl:template name="LOCAL.REF"/>
	<xsl:template name="ModelBankSpecificFields"/>
	<xsl:template name="ModelBankSpecificFields-Custo"/>
	<xsl:template name="USERDEF.FIELDS"/>
</xsl:stylesheet>