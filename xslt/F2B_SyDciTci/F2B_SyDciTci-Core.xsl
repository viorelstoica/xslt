<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="ID"/>
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
	<xsl:template name="DESCRIPTION">
		<field name="DESCRIPTION">
			<xsl:value-of select="b:attribute[@name = 'IN_NAME']"/>
		</field>
	</xsl:template>
	<xsl:template name="VARIANT">
		<field name="VARIANT">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '85'">
					<xsl:if test="$SY_DCI_VARIANT != ''">
						<xsl:value-of select="$SY_DCI_VARIANT"/>
					</xsl:if>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '86'">
					<xsl:if test="$SY_TCI_VARIANT != ''">
						<xsl:value-of select="$SY_TCI_VARIANT"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="TRADE.DATE">
		<field name="TRADE.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'OP_OPERATION_DATE']"/>
            </xsl:call-template>		
		</field>
	</xsl:template>
	<xsl:template name="VALUE.DATE">
		<field name="VALUE.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'OP_VALUE_DATE']"/>
            </xsl:call-template>    		
		</field>
	</xsl:template>
	<xsl:template name="MATURITY.DATE">
		<field name="MATURITY.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_END_DATE']"/>
            </xsl:call-template>    		
		</field>
	</xsl:template>
	<xsl:template name="FIXING.DATE">
		<field name="FIXING.DATE">
            <xsl:call-template name="t24Date">
                  <xsl:with-param name="tapDate" select="b:attribute[@name = 'IN_FIX_D']"/>
            </xsl:call-template>  	
		</field>
	</xsl:template>
	<xsl:template name="TRADE.CCY">
		<field name="TRADE.CCY">
			<xsl:value-of select="b:attribute[@name = 'IN_FX_REF_CCY']"/>
		</field>
	</xsl:template>
	<xsl:template name="ALTERNATE.CCY.1">
		<field name="ALTERNATE.CCY.1">
			<xsl:value-of select="b:attribute[@name = 'IN_FX_TE_UND_INST']"/>
		</field>
	</xsl:template>
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
	<xsl:template name="CUST.DEPOSIT.ACC">
		<field name="CUST.DEPOSIT.ACC">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
		</field>
	</xsl:template>
	<xsl:template name="CUST.ALT.CCY.ACC.1">
		<field name="CUST.ALT.CCY.ACC.1">
			<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT2']"/>
		</field>
	</xsl:template>
	<xsl:template name="STRIKE.PRICE.1">
		<field name="STRIKE.PRICE.1">
			<xsl:value-of select="b:attribute[@name = 'IN_FX_TE_EXER_QUOTE']"/>
		</field>
	</xsl:template>
	<xsl:template name="INTEREST.RATE">
		<field name="INTEREST.RATE">
			<xsl:value-of select="b:attribute[@name = 'IN_INTEREST_RATE']"/>
		</field>
	</xsl:template>
	<xsl:template name="DAY.BASIS">
		<field name="DAY.BASIS">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '24'">
					<xsl:value-of select="'A'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '31'">
					<xsl:value-of select="'B'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '19'">
					<xsl:value-of select="'C'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '13'">
					<xsl:value-of select="'D'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '29'">
					<xsl:value-of select="'E'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '30'">
					<xsl:value-of select="'E1'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '26'">
					<xsl:value-of select="'F'"/>
				</xsl:when>
				<xsl:when test="b:attribute[@name = 'IN_DAY_BASIS'] = '0'">
					<xsl:value-of select="'G'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="DEPOSIT.AMOUNT">
		<field name="DEPOSIT.AMOUNT">
            <xsl:call-template name="t24Amount">
              <xsl:with-param name="tapAmount" select="b:attribute[@name = 'OP_QUANTITY']"/>
            </xsl:call-template>		
		</field>
	</xsl:template>
	<xsl:template name="ALTERNATE.CCY.2">
		<xsl:if test="b:attribute[@name = 'IN_FX_2_TE_UND_INST'] != ''">
			<field name="ALTERNATE.CCY.2">
				<xsl:value-of select="b:attribute[@name = 'IN_FX_2_TE_UND_INST']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SPOT.PRICE.2"/>
	<xsl:template name="CPARTY.ALTCCYACC.2"/>
	<xsl:template name="FEE.CCY">
		<xsl:if test="b:attribute[@name = 'OP_BP4_AMOUNT'] and b:attribute[@name = 'OP_BP4_AMOUNT'] != ''">
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
		<xsl:if test="b:attribute[@name = 'OP_BP4_AMOUNT'] and b:attribute[@name = 'OP_BP4_AMOUNT'] != ''">
			<field name="FEE.ACC">
				<xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="CONVERT.INTEREST">
		<field name="CONVERT.INTEREST">
			<xsl:choose>
				<xsl:when test="b:attribute[@name = 'IN_CONV_INTEREST'] = '2'">
					<xsl:value-of select="'Y'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'N'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="EXOTIC.TYPE.1">
	    <xsl:choose>
	       <xsl:when test="b:attribute[@name = 'IN_FX_BARR']">
            <field name="EXOTIC.TYPE:1">
                <xsl:value-of select="'KNOCKIN'"/>
            </field>	       
	       </xsl:when>
           <xsl:when test="b:attribute[@name = 'IN_FX_UP_BARR']">
            <field name="EXOTIC.TYPE:1">
                <xsl:value-of select="'KNOCKOUT'"/>
            </field>           
           </xsl:when>	       
	    </xsl:choose>
	</xsl:template>
	<xsl:template name="TRIGGER.EXOTIC.1"/>
	<xsl:template name="USR.FLD.TEXT.1"/>
	<xsl:template name="USR.FLD.VAL.1">
        <xsl:choose>
           <xsl:when test="b:attribute[@name = 'IN_FX_BARR']">
            <field name="USR.FLD.VAL:1">
                <xsl:value-of select="b:attribute[@name = 'IN_FX_BARR']"/>
            </field>           
           </xsl:when>
           <xsl:when test="b:attribute[@name = 'IN_FX_UP_BARR']">
            <field name="USR.FLD.VAL:1">
                <xsl:value-of select="b:attribute[@name = 'IN_FX_UP_BARR']"/>
            </field>           
           </xsl:when>         
        </xsl:choose>	
	</xsl:template>
	<xsl:template name="EXOTIC.TYPE.2">
		<xsl:if test="b:attribute[@name = 'IN_FX_UP_BARR']">
			<field name="EXOTIC.TYPE:2">
				<xsl:value-of select="'KNOCKOUT'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="TRIGGER.EXOTIC.2"/>
	<xsl:template name="USR.FLD.TEXT.2"/>
	<xsl:template name="USR.FLD.VAL.2">
		<xsl:if test="b:attribute[@name = 'IN_FX_UP_BARR']">
			<field name="USR.FLD.VAL:2">
				<xsl:value-of select="b:attribute[@name = 'IN_FX_UP_BARR']"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="DEALER.DESK">
		<xsl:if test="$SY_DEALER_DESK != ''">
			<field name="DEALER.DESK">
				<xsl:value-of select="$SY_DEALER_DESK"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="RISK.LEVEL">
		<field name="RISK.LEVEL">
			<xsl:value-of select="b:attribute[@name = 'IN_RISK_LEVEL']"/>
		</field>
	</xsl:template>
	<xsl:template name="DCI.REFERENCE"/>
	<xsl:template name="CONTRACT.STATUS"/>
	<xsl:template name="FIXING.TIME"/>
	<xsl:template name="COUNTERPARTY">
        <field name="COUNTERPARTY">
            <xsl:value-of select="b:attribute[@name = 'OP_COUNTERPARTY']"/>
        </field>	
	</xsl:template>
	<xsl:template name="CPARTY.PORTFOLIO"/>
	<xsl:template name="CPARTY.DEPOSIT.ACC"/>
	<xsl:template name="CPARTY.ALTCCYACC.1"/>
	<xsl:template name="BASE.CCY.1"/>
	<xsl:template name="SPOT.PRICE.1"/>
	<xsl:template name="STRIKE.PERCENT.1"/>
	<xsl:template name="CATEGORY"/>
	<xsl:template name="BASE.INTEREST.RATE"/>
	<xsl:template name="INTEREST.SPREAD"/>
	<xsl:template name="INTEREST.AMOUNT"/>
	<xsl:template name="DEP.AMT.ALT.CCY.1"/>
	<xsl:template name="INT.AMT.ALT.CCY.1"/>
	<xsl:template name="BASE.CCY.2"/>
	<xsl:template name="STRIKE.PERCENT.2"/>
	<xsl:template name="STRIKE.PRICE.2">
        <xsl:if test="b:attribute[@name = 'IN_FX_2_TE_UND_INST'] != ''">
            <field name="STRIKE.PRICE.2">
                <xsl:value-of select="b:attribute[@name = 'IN_FX_2_TE_EX_QUOTE']"/>
            </field>
        </xsl:if>
    </xsl:template>	
	<xsl:template name="CUST.ALT.CCY.ACC.2">
        <xsl:if test="b:attribute[@name = 'IN_FX_2_TE_UND_INST'] != ''">
            <field name="CPARTY.ALTCCYACC.2">
                <xsl:value-of select="b:attribute[@name = 'OP_ACCOUNT3']"/>
            </field>
        </xsl:if>
    </xsl:template>	
	<xsl:template name="DEP.AMT.ALT.CCY.2"/>
	<xsl:template name="INT.AMT.ALT.CCY.2"/>
	<xsl:template name="DX.CONTRACT.CODE">
        <xsl:choose>
            <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '85'">
                <xsl:if test="$SY_DCI_AGENCY_BOOKING != 'Y'">
                    <xsl:value-of select="$SY_OTC_FX_CONTRACT_CODE"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="b:attribute[@name = 'IN_SUB_NATURE'] = '86'">
                <xsl:if test="$SY_TCI_AGENCY_BOOKING != 'Y'">
                    <xsl:value-of select="$SY_OTC_FX_CONTRACT_CODE"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>	
	</xsl:template>
	<xsl:template name="PREMIUM.CCY"/>
	<xsl:template name="PREMIUM.PRICE"/>
	<xsl:template name="PREMIUM.PERCENT"/>
	<xsl:template name="PREMIUM.AMT"/>
	<xsl:template name="CPTY.PREM.AMT"/>
	<xsl:template name="PREMIUM.PAY.RECEIVE"/>
	<xsl:template name="PREM.RESERVED.5"/>
	<xsl:template name="PREM.RESERVED.4"/>
	<xsl:template name="PREM.RESERVED.3"/>
	<xsl:template name="PREM.RESERVED.2"/>
	<xsl:template name="PREM.RESERVED.1"/>
	<xsl:template name="NOTIONAL.DEP.CCY"/>
	<xsl:template name="NOTIONAL.ALT.CCY.1"/>
	<xsl:template name="SY.TRANSACTION.REF"/>
	<xsl:template name="EXTERNAL.REF"/>
	<xsl:template name="SY.DX.REFERENCE"/>
	<xsl:template name="COUNTERPARTY.DEAL"/>
	<xsl:template name="B2B.REFERENCE"/>
	<xsl:template name="MIS.INTEREST.RATE"/>
	<xsl:template name="CPTY.FEE.AMT">
        <field name="CPTY.FEE.AMT">0</field>    	
	</xsl:template>
	<xsl:template name="FEE.RESERVED.5"/>
	<xsl:template name="FEE.RESERVED.4"/>
	<xsl:template name="FEE.RESERVED.3"/>
	<xsl:template name="FEE.RESERVED.2"/>
	<xsl:template name="FEE.RESERVED.1"/>
	<xsl:template name="RM.SPREAD.CCY"/>
	<xsl:template name="RM.SPREAD.RATE"/>
	<xsl:template name="RM.SPREAD.AMT"/>
	<xsl:template name="CREATE.DEPOSIT"/>
	<xsl:template name="CREATE.OPTION"/>
	<xsl:template name="USR.RESERVED.05"/>
	<xsl:template name="USR.RESERVED.04"/>
	<xsl:template name="USR.RESERVED.03"/>
	<xsl:template name="USR.RESERVED.02"/>
	<xsl:template name="USR.RESERVED.01"/>
	<xsl:template name="EXERCISE.EXPIRE"/>
	<xsl:template name="EXERCISE.CCY"/>
	<xsl:template name="NEW.MATURITY.DATE"/>
	<xsl:template name="NEW.INTEREST.RATE"/>
	<xsl:template name="NEW.INTEREST.AMT"/>
	<xsl:template name="UNWIND.CHG.CCY"/>
	<xsl:template name="UNWIND.CHG.AMT"/>
	<xsl:template name="UNWIND.CHG.ACC"/>
	<xsl:template name="CPTY.UNWIND.CHG.AMT"/>
	<xsl:template name="UNWIND.RESERVED.5"/>
	<xsl:template name="UNWIND.RESERVED.4"/>
	<xsl:template name="UNWIND.RESERVED.3"/>
	<xsl:template name="UNWIND.RESERVED.2"/>
	<xsl:template name="UNWIND.RESERVED.1"/>
	<xsl:template name="FX.AUTH"/>
	<xsl:template name="UNWIND.POST.TIME"/>
	<xsl:template name="SY.MASTER"/>
	<xsl:template name="ACCRUED.INT"/>
	<xsl:template name="TAX.INTEREST.KEY"/>
	<xsl:template name="TAX.INTEREST.TYPE"/>
	<xsl:template name="LOCAL.OR.SOURCE"/>
	<xsl:template name="TOT.INT.TAX"/>
	<xsl:template name="TOT.TAX.INT.LCY"/>
	<xsl:template name="PYMT.MSG.REQD"/>
	<xsl:template name="DEP.CCY.BEN.BANK"/>
	<xsl:template name="DEP.CCY.BEN.ADD"/>
	<xsl:template name="DEP.CCY.BEN.ACCT"/>
	<xsl:template name="DEP.CCY.INTR.BANK"/>
	<xsl:template name="DEP.CCY.INTR.ADD"/>
	<xsl:template name="DEP.CCY.CPTY.NO"/>
	<xsl:template name="DEP.CCY.CPTY.ADD"/>
	<xsl:template name="DEP.CCY.CPTY.ACCT"/>
	<xsl:template name="TRADER.ID"/>
	<xsl:template name="FIXING.REF.RATE"/>
	<xsl:template name="RM.MARKUP"/>
	<xsl:template name="EXEC.CHANNEL"/>
	<xsl:template name="INT.CCY"/>
	<xsl:template name="INT.CCY.ACCOUNT"/>
	<xsl:template name="INT.SPOT.RATE"/>
	<xsl:template name="ALT.CCY.BEN.BANK"/>
	<xsl:template name="ALT.CCY.BEN.ADD"/>
	<xsl:template name="ALT.CCY.BEN.ACCT"/>
	<xsl:template name="ALT.CCY.INTR.BANK"/>
	<xsl:template name="ALT.CCY.INTR.ADD"/>
	<xsl:template name="ALT.CCY.CPTY.NO"/>
	<xsl:template name="ALT.CCY.CPTY.ADD"/>
	<xsl:template name="ALT.CCY.CPTY.ACCT"/>
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
	<xsl:template name="ModelBankSpecificFields"/>
	<xsl:template name="ModelBankSpecificFields-Custo"/>
	<xsl:template name="USERDEF.FIELDS"/>
</xsl:stylesheet>