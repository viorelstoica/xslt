<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150"
                xmlns:b="http://www.odcgroup.com/F2B"
                xmlns:dxorder="http://www.temenos.com/T24/dxorder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:scexesecorders="http://www.temenos.com/T24/scexesecorders"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0"><!-- SC.EXE.SEC.ORDERS section -->
   <xsl:template name="scexesecorders:transactionId">
      <transactionId>
         <xsl:value-of select="b:omsOrderReference"/>
      </transactionId>
   </xsl:template>
   <xsl:template name="scexesecorders:BROKER.NO">
      <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('BROKER.NO:','-1')"/>
         </xsl:attribute>
         <xsl:choose>
            <xsl:when test="$CUSTOMER_PREFIX != ''">
               <xsl:value-of select="substring-after(b:broker/infra:code,$CUSTOMER_PREFIX)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:broker/infra:code"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:BROKER.TYPE">
      <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('BROKER.TYPE:','-1')"/>
         </xsl:attribute>
         <xsl:value-of select="'BROKER'"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:DELIVERY.INSTR">
      <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('DELIVERY.INSTR:','-1')"/>
         </xsl:attribute>
         <xsl:value-of select="$SC_DEFAULT_DELIVERY_INSTR"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:NARRATIVE">
      <field name="NARRATIVE">
         <xsl:value-of select="b:userDefinedField[infra:name='remark_c']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="scexesecorders:NOMINAL.RECD">
      <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('NOMINAL.RECD:','-1')"/>
         </xsl:attribute>
         <xsl:value-of select="translate(b:quantity,',','')"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:PRICE">
      <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('PRICE:','-1')"/>
         </xsl:attribute>
         <xsl:value-of select="translate(b:price,',','')"/>
      </xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:STOCK.EXCHANGE">
      <field name="STOCK.EXCHANGE">
         <xsl:choose>
            <xsl:when test="$STOCKEXCH_PREFIX != ''">
               <xsl:value-of select="substring-after(b:stockExchange/infra:code,$STOCKEXCH_PREFIX)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:stockExchange/infra:code"/>
            </xsl:otherwise>
         </xsl:choose>
      </field>
   </xsl:template>
   <xsl:template name="scexesecorders:TAP.EVENT.ID">
      <field name="TAP.EVENT.ID">
         <xsl:value-of select="../../../@eventIdentifier"/>
      </field>
   </xsl:template>
   <xsl:template name="scexesecorders:TAP.REF.ID">
      <field name="TAP.REF.ID">
         <xsl:value-of select="b:pmsOrderReference"/>
      </field>
   </xsl:template>
   <xsl:template name="scexesecorders:KEY"/>
   <xsl:template name="scexesecorders:ORDER.NUMBER"/>
   <xsl:template name="scexesecorders:SECURITY.NO"/>
   <xsl:template name="scexesecorders:TRANSACTION.CODE"/>
   <xsl:template name="scexesecorders:ORDER.TYPE"/>
   <xsl:template name="scexesecorders:TRADE.CCY"/>
   <xsl:template name="scexesecorders:NOMINAL.BALANCE"/>
   <xsl:template name="scexesecorders:CUSTOMER.NO"/>
   <xsl:template name="scexesecorders:SECURITY.ACCT"/>
   <xsl:template name="scexesecorders:CUST.ACC.NO">
		<field name="CUST.ACC.NO">
			<xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="b:boAccount/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:currentAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		</xsl:template>
   <xsl:template name="scexesecorders:CUST.NOMINAL"/>
   <xsl:template name="scexesecorders:CUST.PRICE"/>
   <xsl:template name="scexesecorders:CU.CASH.AMOUNT"/>
   <xsl:template name="scexesecorders:CALC.CHRGS"/>
   <xsl:template name="scexesecorders:CASH.CHRGS"/>
   <xsl:template name="scexesecorders:SPLIT.CHRGS"/>
   <xsl:template name="scexesecorders:CASH.ROUNDING"/>
   <xsl:template name="scexesecorders:ADJUST.COMM"/>
   <xsl:template name="scexesecorders:CU.BRKR.COMM"/>
   <xsl:template name="scexesecorders:CU.FOREIGN.FEE"/>
   <xsl:template name="scexesecorders:CU.COMMISSION"/>
   <xsl:template name="scexesecorders:CU.COMM.TAX"/>
   <xsl:template name="scexesecorders:CU.STAMP.TAX"/>
   <xsl:template name="scexesecorders:CU.EBV.FEES"/>
   <xsl:template name="scexesecorders:CU.FEES.MISC"/>
   <xsl:template name="scexesecorders:CU.DISC.PCENT"/>
   <xsl:template name="scexesecorders:CU.DISC.AMT"/>
   <xsl:template name="scexesecorders:CU.WHT.PERC"/>
   <xsl:template name="scexesecorders:CU.WHT.TAX"/>
   <xsl:template name="scexesecorders:COMM.CODE"/>
   <xsl:template name="scexesecorders:COMM.PERCENT"/>
   <xsl:template name="scexesecorders:COM.TAX.CODE"/>
   <xsl:template name="scexesecorders:COM.TAX.BCUR"/>
   <xsl:template name="scexesecorders:COM.TAX.XRTE"/>
   <xsl:template name="scexesecorders:CU.EX.RATE.ACC"/>
   <xsl:template name="scexesecorders:CU.ACCOUNT.CCY"/>
   <xsl:template name="scexesecorders:CU.DEPOSITORY"/>
   <xsl:template name="scexesecorders:SUB.ACCOUNT"/>
   <xsl:template name="scexesecorders:CU.BROKER.NO"/>
   <xsl:template name="scexesecorders:CUST.AVG.PRICE"/>
   <xsl:template name="scexesecorders:CU.INT.CTR"/>
   <xsl:template name="scexesecorders:SEC.TRADE.ID"/>
   <xsl:template name="scexesecorders:CU.NOTES"/>
   <xsl:template name="scexesecorders:CU.INCOME.ACC"/>
   <xsl:template name="scexesecorders:CU.INCOME.CCY"/>
   <xsl:template name="scexesecorders:BR.ACC.NO"/>
   <xsl:template name="scexesecorders:BR.SEC.ACCT"/>
   <xsl:template name="scexesecorders:RESERVED5"/>
   <xsl:template name="scexesecorders:BR.BROKER.COMM"/>
   <xsl:template name="scexesecorders:BR.FOREIGN.FEE"/>
   <xsl:template name="scexesecorders:CL.COMMISSION"/>
   <xsl:template name="scexesecorders:BR.STAMP.TAX"/>
   <xsl:template name="scexesecorders:BR.EBV.FEES"/>
   <xsl:template name="scexesecorders:BR.FEES.MISC"/>
   <xsl:template name="scexesecorders:BR.EX.RATE.ACC"/>
   <xsl:template name="scexesecorders:BR.ACCOUNT.CCY"/>
   <xsl:template name="scexesecorders:BR.EXE.ADV.REF"/>
   <xsl:template name="scexesecorders:BR.TR.AL.REF"/>
   <xsl:template name="scexesecorders:BR.RESERVED.03"/>
   <xsl:template name="scexesecorders:BR.RESERVED.02"/>
   <xsl:template name="scexesecorders:BR.RESERVED.01"/>
   <xsl:template name="scexesecorders:VALUE.DATE"/>
   <xsl:template name="scexesecorders:DEPOSITORY"/>
   <xsl:template name="scexesecorders:MARKET.TYPE"/>
   <xsl:template name="scexesecorders:SETT.NARRATIVE"/>
   <xsl:template name="scexesecorders:ACCT.NARRATIVE"/>
   <xsl:template name="scexesecorders:ORDER.BROKER"/>
   <xsl:template name="scexesecorders:AMT.TO.BROKER"/>
   <xsl:template name="scexesecorders:EXE.BY.BROKER"/>
   <xsl:template name="scexesecorders:INT.CTR"/>
   <xsl:template name="scexesecorders:ORDER.STATUS"/>
   <xsl:template name="scexesecorders:ODD.LOT.ORDER"/>
   <xsl:template name="scexesecorders:TRADE.DEPT"/>
   <xsl:template name="scexesecorders:PRO.BR.CHGS"/>
   <xsl:template name="scexesecorders:CALC.AVG.PRICE"/>
   <xsl:template name="scexesecorders:TRADE.CREATION"/>
   <xsl:template name="scexesecorders:PRORATA.NOM"/>
   <xsl:template name="scexesecorders:CANCEL.REMAIN.ORD"/>
   <xsl:template name="scexesecorders:ROUT.COMPANY"/>
   <xsl:template name="scexesecorders:ROUT.SEC.ACC"/>
   <xsl:template name="scexesecorders:PRICE.SPREAD"/>
   <xsl:template name="scexesecorders:DEFAULT.CALC.CHG"/>
   <xsl:template name="scexesecorders:CUM.EX.IND"/>
   <xsl:template name="scexesecorders:WHT.TAX.CODE"/>
   <xsl:template name="scexesecorders:CHARGE.CALC.METHOD"/>
   <xsl:template name="scexesecorders:SEGMENT"/>
   <xsl:template name="scexesecorders:DEF.DEAL.DESK"/>
   <xsl:template name="scexesecorders:ACT.DEAL.DESK"/>
   <xsl:template name="scexesecorders:ADVICE.REQD"/>
   <xsl:template name="scexesecorders:MT502.REJ.REASON"/>
   <xsl:template name="scexesecorders:CONSOLIDATE.EXEC"/>
   <xsl:template name="scexesecorders:DAY.TRADE"/>
   <xsl:template name="scexesecorders:AUTHORISE.TRADE"/>
   <xsl:template name="scexesecorders:PARENT"/>
   <xsl:template name="scexesecorders:PARENT.REFERENCE"/>
   <xsl:template name="scexesecorders:RESERVED.5"/>
   <xsl:template name="scexesecorders:RESERVED.4"/>
   <xsl:template name="scexesecorders:RESERVED.3"/>
   <xsl:template name="scexesecorders:RESERVED.2"/>
   <xsl:template name="scexesecorders:RESERVED.1"/>
   <xsl:template name="scexesecorders:LOCAL.REF"/>
   <xsl:template name="scexesecorders:OVERRIDE"/>
   <xsl:template name="scexesecorders:RECORD.STATUS"/>
   <xsl:template name="scexesecorders:CURR.NO"/>
   <xsl:template name="scexesecorders:INPUTTER"/>
   <xsl:template name="scexesecorders:DATE.TIME"/>
   <xsl:template name="scexesecorders:AUTHORISER"/>
   <xsl:template name="scexesecorders:CO.CODE"/>
   <xsl:template name="scexesecorders:DEPT.CODE"/>
   <xsl:template name="scexesecorders:AUDITOR.CODE"/>
   <xsl:template name="scexesecorders:AUDIT.DATE.TIME"/>
   <xsl:template name="scexesecorders:EXE.HLT"/>
   <xsl:template name="scexesecorders:TRADE.HLT"/>
   <xsl:template name="scexesecorders:PARENT.CHILD.DEPO"/>
   <xsl:template name="scexesecorders:ROUNDING.FACTOR"/>
   <xsl:template name="scexesecorders:USERDEF.FIELDS"/>
   <xsl:template name="scexesecorders:ModelBankSpecificFields"/>
   <xsl:template name="scexesecorders:ModelBankSpecificFields-Custo"/>
   <xsl:template name="scexesecorders:TAP.SLEEVE.ACC">
		<field name="TAP.SLEEVE.ACC">
			<xsl:if test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:currentAccount/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="scexesecorders:TAP.SLEEVE.PTF">
		<field name="TAP.SLEEVE.PTF">
			<xsl:if test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:portfolio/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="scexesecorders:UTC.DATE.TIME">
		<xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('UTC.DATE.TIME:','-1')"/>
         </xsl:attribute>
		<xsl:variable name="utcDateTime" select="concat(substring-before(b:executionDate,'.'),':',substring-after(b:executionDate,'.'))"/>
		<xsl:value-of select="concat(substring-before($utcDateTime,'+'),'Z')"/>
		</xsl:element>
   </xsl:template>
   <xsl:template name="scexesecorders:TAP.EX.SET.CRIT">
        <xsl:element name="field">
         <xsl:attribute name="name">
            <xsl:value-of select="concat('TAP.EX.SET.CRIT:','-1')"/>
         </xsl:attribute>
        <xsl:value-of select="b:executionSetCriteria"/>
        </xsl:element>
   </xsl:template>   
   <!-- DX.ORDER section -->
   <xsl:template name="dxorder:transactionId">
      <transactionId>
         <xsl:value-of select="b:sourceSystemCode"/>
      </transactionId>
   </xsl:template>
   <xsl:template name="dxorder:BROKER.TIME">
      <field name="BROKER.TIME">
         <xsl:value-of select="substring(b:executionDate,12,'8')"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:SEC.PRICE">
      <field name="SEC.PRICE">
         <xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:NARRATIVE">
      <field name="NARRATIVE">
         <xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:EXTERNAL.REF">
      <field name="EXTERNAL.REF">
         <xsl:value-of select="b:omsOrderReference"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:TAP.REF.ID">
      <field name="TAP.REF.ID">
         <xsl:value-of select="b:pmsOrderReference"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:SEC.LOTS">
      <field name="SEC.LOTS">
         <xsl:value-of select="translate(b:quantity,',','')"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:TAP.EVENT.ID">
      <field name="TAP.EVENT.ID">
         <xsl:value-of select="../../../@eventIdentifier"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:EXECUTING.BROKER">
      <field name="EXECUTING.BROKER">
         <xsl:value-of select="substring-after(b:broker/infra:code,$CUSTOMER_PREFIX)"/>
      </field>
   </xsl:template>
   <xsl:template name="dxorder:transactionFeesTaxesCounter">
		<xsl:call-template name="printDxExecutionFeesAndTaxes">
			<xsl:with-param name="caller" select="'OrderExecution'"/>
		</xsl:call-template>
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
   <xsl:template name="dxorder:PRI.CACC.CCY"/>
   <xsl:template name="dxorder:PRI.COMM.EXC"/>
   <xsl:template name="dxorder:PRI.CACC.AMT"/>
   <xsl:template name="dxorder:PRI.COMM.TAX"/>
   <xsl:template name="dxorder:PRI.CHARGE.DATE"/>
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
   <xsl:template name="dxorder:SEC.ORIG.LOTS"/>
   <xsl:template name="dxorder:SEC.SETTNOS"/>
   <xsl:template name="dxorder:SEC.SETTLOTS"/>
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
   <xsl:template name="dxorder:ORDER.STATUS"/>
   <xsl:template name="dxorder:ORDER.LOTS"/>
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
   <xsl:template name="dxorder:ORDER.AMEND"/>
   <xsl:template name="dxorder:TAP.EX.SET.CRIT">
      <field name="TAP.EX.SET.CRIT">
         <xsl:value-of select="b:executionSetCriteria"/>
      </field>
   </xsl:template>     
   <xsl:template name="dxorder:SEC.TAX.AMT.ACY"/>
   <xsl:template name="dxorder:USERDEF.FIELDS"/>
   <xsl:template name="dxorder:ModelBankSpecificFields"/>
   <xsl:template name="dxorder:ModelBankSpecificFields-Custo"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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