<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:forex="http://www.temenos.com/T24/forex" xmlns:nddeal="http://www.temenos.com/T24/nddeal" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  <xsl:template name="forex:TAP.REF.ID">
    <field name="TAP.REF.ID">
      <xsl:value-of select="b:pmsReferenceCode"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:TAP.EVENT.ID">
    <field name="TAP.EVENT.ID">
      <xsl:value-of select="../../../@eventIdentifier"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:TAP.OPER.NATURE">
    <field name="TAP.OPER.NATURE">
      <xsl:value-of select="'2'"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:TAP.FX.RATE.DIR">
    <field name="TAP.FX.RATE.DIR">
      <xsl:value-of select="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value"/>
    </field>
  </xsl:template>
  
  <xsl:template name="forex:TAP.FX.COMP.ORD">
  <xsl:if test="b:compoundOrderCode">
	<field name="TAP.FX.COMP.ORD">
		<xsl:value-of select="b:compoundOrderCode"/>
	</field>
  </xsl:if>
  </xsl:template>
  <xsl:template name="forex:DEAL.TYPE">
    <field name="DEAL.TYPE">
      <xsl:value-of select="'FW'"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:TRANSACTION.TYPE">
    <field name="TRANSACTION.TYPE">
      <xsl:value-of select="$FORWARD_TRANSACTION_TYPE"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:COUNTERPARTY">
    <field name="COUNTERPARTY">
      <xsl:choose>
        <xsl:when test="$CUSTOMER_PREFIX != ''">
          <xsl:value-of select="substring-after(b:userDefinedField[infra:name='ud_client']/infra:value,$CUSTOMER_PREFIX)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="b:userDefinedField[infra:name='ud_client']/infra:value"/>
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template name="forex:PORTFOLIO.NUMBER">
    <field name="PORTFOLIO.NUMBER">
      <xsl:value-of select="substring-after(b:portfolio/infra:code,'-')"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:TREASURY.CUSTOMER">
    <field name="TREASURY.CUSTOMER">
      <xsl:value-of select="'NO'"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:CURRENCY.SOLD">
    <field name="CURRENCY.SOLD">
      <xsl:value-of select="b:userDefinedField[infra:name='acc_currency']/infra:value"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:AMOUNT.SOLD">
    <field name="AMOUNT.SOLD">
      <xsl:value-of select="b:purchaseCcyNetAmount"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:OUR.ACCOUNT.PAY">
    <field name="OUR.ACCOUNT.PAY">
      <xsl:value-of select="b:purchaseCcyCurrentAccount/infra:code"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:CURRENCY.BOUGHT">
    <field name="CURRENCY.BOUGHT">
      <xsl:value-of select="b:userDefinedField[infra:name='ud_underly_instr']/infra:value"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:AMOUNT.BOUGHT">
    <field name="AMOUNT.BOUGHT">
      <xsl:value-of select="b:soldQuantity"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:OUR.ACCOUNT.REC">
    <field name="OUR.ACCOUNT.REC">
      <xsl:value-of select="b:userDefinedField[infra:name='account2']/infra:value"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:DEAL.DATE">
    <field name="DEAL.DATE">
      <xsl:value-of select="translate(b:transactionDate,'-','')"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:VALUE.DATE.SELL">
    <field name="VALUE.DATE.SELL">
      <xsl:value-of select="translate(b:settlementDate,'-','')"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:VALUE.DATE.BUY">
    <field name="VALUE.DATE.BUY">
      <xsl:value-of select="translate(b:settlementDate,'-','')"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:NOTES">
    <field name="NOTES">
      <xsl:value-of select="b:userDefinedField[infra:name='remark_1_c']/infra:value"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:DEALER.NOTES">
    <field name="DEALER.NOTES">
      <xsl:value-of select="b:userDefinedField[infra:name='remark_2_c']/infra:value"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:SOD.MAT">
    <field name="SOD.MAT">
      <xsl:value-of select="'NO'"/>
    </field>
  </xsl:template>
  <xsl:template name="forex:BASE.CCY">
    <field name="BASE.CCY">
      <xsl:choose>
        <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = 1">
          <xsl:value-of select="b:userDefinedField[infra:name='acc1_currency_id']/infra:value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="b:userDefinedField[infra:name='ud_underly_instr']/infra:value"/>
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template name="forex:FORWARD.RATE">
    <field name="FORWARD.RATE">
      <xsl:choose>
        <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = 1">
          <!-- fx_client_rate_n opposite to quote_n -->
          <xsl:choose>
            <xsl:when test="b:userDefinedField[infra:name='fx_client_rate_n']/infra:value != ''">
              <xsl:value-of select="b:userDefinedField[infra:name='fx_client_rate_n']/infra:value"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number(substring(1 div b:forwardExchangeRate,1,11),$decimalformat,'nan2zero')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="b:userDefinedField[infra:name='fx_client_rate_n']/infra:value != ''">
              <xsl:value-of select="b:userDefinedField[infra:name='fx_client_rate_n']/infra:value"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="b:forwardExchangeRate"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template name="forex:SPOT.RATE">
    <field name="SPOT.RATE">
      <xsl:choose>
        <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = 1">
          <xsl:choose>
            <xsl:when test="b:userDefinedField[infra:name='fx_spot_quote_n']/infra:value != ''">
              <xsl:value-of select="b:userDefinedField[infra:name='fx_spot_quote_n']/infra:value"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="format-number(substring(1 div b:spotExchangeRate,1,11),$decimalformat,'nan2zero')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="b:userDefinedField[infra:name='fx_spot_quote_n']/infra:value != ''">
              <xsl:value-of select="b:userDefinedField[infra:name='fx_spot_quote_n']/infra:value"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="b:spotExchangeRate"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template name="forex:TREASURY.RATE">
    <xsl:if test="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value != ''">
      <field name="TREASURY.RATE">
        <xsl:value-of select="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value"/>
      </field>
    </xsl:if>
  </xsl:template>
  <xsl:template name="forex:TRANSACTION.REF.NO"/>
  <xsl:template name="forex:DEAL.SUB.TYPE"/>
  <xsl:template name="forex:DEALER.DESK"/>
  <xsl:template name="forex:CURRENCY.MARKET"/>
  <xsl:template name="forex:SWAP.BASE.CCY"/>
  <xsl:template name="forex:BROKER"/>
  <xsl:template name="forex:BROKERAGE"/>
  <xsl:template name="forex:BROKERAGE.CCY"/>
  <xsl:template name="forex:BROKERAGE.AMOUNT"/>
  <xsl:template name="forex:CONFIRMD.BY.BROKER"/>
  <xsl:template name="forex:LIMIT.REFERENCE.NO"/>
  <xsl:template name="forex:POSITION.TYPE.BUY"/>
  <xsl:template name="forex:POSITION.TYPE.SELL"/>
  <xsl:template name="forex:NEGOTIATED.REF.NO"/>
  <xsl:template name="forex:REVALUATION.TYPE"/>
  <xsl:template name="forex:SPOT.DATE"/>
  <xsl:template name="forex:SPOT.LCY.AMOUNT"/>
  <xsl:template name="forex:SWAP.REF.NO"/>
  <xsl:template name="forex:INT.RATE.BUY"/>
  <xsl:template name="forex:INT.RATE.SELL"/>
  <xsl:template name="forex:OPTION.DATE"/>
  <xsl:template name="forex:DEL.DATE.BUY"/>
  <xsl:template name="forex:DEL.AMOUNT.BUY"/>
  <xsl:template name="forex:DEL.DATE.SELL"/>
  <xsl:template name="forex:DEL.AMOUNT.SELL"/>
  <xsl:template name="forex:BENEFICIARY.NO"/>
  <xsl:template name="forex:BENFCY.ADD"/>
  <xsl:template name="forex:CPARTY.CORR.NO"/>
  <xsl:template name="forex:CPY.CORR.ADD"/>
  <xsl:template name="forex:CPARTY.BANK.ACC"/>
  <xsl:template name="forex:INTERMED.BK.NO"/>
  <xsl:template name="forex:INTERMED.ADD"/>
  <xsl:template name="forex:CONF.NARR"/>
  <xsl:template name="forex:PAYMT.NARR"/>
  <xsl:template name="forex:REC.ADV.NARR"/>
  <xsl:template name="forex:PAY.ACC.POSTED"/>
  <xsl:template name="forex:REC.ACC.POSTED"/>
  <xsl:template name="forex:PAYMENT.SENT"/>
  <xsl:template name="forex:ADVICE.SENT"/>
  <xsl:template name="forex:CONFIRM.SENT"/>
  <xsl:template name="forex:CONF.BY.CPARTY"/>
  <xsl:template name="forex:BUY.LCY.EQUIV"/>
  <xsl:template name="forex:SEL.LCY.EQUIV"/>
  <xsl:template name="forex:BUY.DAILY.ACC.L"/>
  <xsl:template name="forex:BUY.ACC.TDATE.L"/>
  <xsl:template name="forex:BUY.DAILY.ACC.F"/>
  <xsl:template name="forex:BUY.ACC.TDATE.F"/>
  <xsl:template name="forex:SEL.DAILY.ACC.L"/>
  <xsl:template name="forex:SEL.ACC.TDATE.L"/>
  <xsl:template name="forex:SEL.DAILY.ACC.F"/>
  <xsl:template name="forex:SEL.ACC.TDATE.F"/>
  <xsl:template name="forex:SWIFT.COMMON.REF"/>
  <xsl:template name="forex:CATEGORY.CODE"/>
  <xsl:template name="forex:ACCOUNT.TO.CHARGE"/>
  <xsl:template name="forex:MKTG.EXCH.PROFIT"/>
  <xsl:template name="forex:COMMISSION.TAKEN"/>
  <xsl:template name="forex:CHARGE.CODE"/>
  <xsl:template name="forex:CHARGE.AMOUNT"/>
  <xsl:template name="forex:TAX.CODE"/>
  <xsl:template name="forex:TAX.AMOUNT"/>
  <xsl:template name="forex:ACCOUNT.OFFICER"/>
  <xsl:template name="forex:FED.FUNDS"/>
  <xsl:template name="forex:SEND.CONFIRMATION"/>
  <xsl:template name="forex:SEND.PAYMENT"/>
  <xsl:template name="forex:SEND.ADVICE"/>
  <xsl:template name="forex:CORR.AMEND.MKR"/>
  <xsl:template name="forex:REPLACING.DEAL.NO"/>
  <xsl:template name="forex:ORIGINAL.FUNCTION"/>
  <xsl:template name="forex:EQV.CODE"/>
  <xsl:template name="forex:EQUIV.AMT"/>
  <xsl:template name="forex:BROKERAGE.EQUIV"/>
  <xsl:template name="forex:CHARGE.EQUIV"/>
  <xsl:template name="forex:TAX.EQUIV"/>
  <xsl:template name="forex:NOTIONAL.BUY.AMT"/>
  <xsl:template name="forex:NOTIONAL.SELL.AMT"/>
  <xsl:template name="forex:TOTAL.INT.BOUGHT"/>
  <xsl:template name="forex:TOTAL.INT.SOLD"/>
  <xsl:template name="forex:EQUIV.INT.BOUGHT"/>
  <xsl:template name="forex:EQUIV.INT.SOLD"/>
  <xsl:template name="forex:INT.BASIS.BOUGHT"/>
  <xsl:template name="forex:INT.BASIS.SOLD"/>
  <xsl:template name="forex:LOCAL.REF"/>
  <xsl:template name="forex:ORIGINATING.DEPT"/>
  <xsl:template name="forex:PHANTOM.IND"/>
  <xsl:template name="forex:CONSOL.IND"/>
  <xsl:template name="forex:STMT.NO"/>
  <xsl:template name="forex:OVERRIDE"/>
  <xsl:template name="forex:RECORD.STATUS"/>
  <xsl:template name="forex:CURR.NO"/>
  <xsl:template name="forex:INPUTTER"/>
  <xsl:template name="forex:DATE.TIME"/>
  <xsl:template name="forex:AUTHORISER"/>
  <xsl:template name="forex:CO.CODE"/>
  <xsl:template name="forex:DEPT.CODE"/>
  <xsl:template name="forex:AUDITOR.CODE"/>
  <xsl:template name="forex:AUDIT.DATE.TIME"/>
  <xsl:template name="forex:BK.TO.BK.INF"/>
  <xsl:template name="forex:BULK.DEAL"/>
  <xsl:template name="forex:BULK.REFERENCE"/>
  <xsl:template name="forex:AMT.BOUGHT.OS"/>
  <xsl:template name="forex:AMT.SOLD.OS"/>
  <xsl:template name="forex:DEAL.MARKET"/>
  <xsl:template name="forex:LINK.REFERENCE"/>
  <xsl:template name="forex:NETTING.STATUS"/>
  <xsl:template name="forex:STATUS"/>
  <xsl:template name="forex:MKTG.EXCH.ADJ"/>
  <xsl:template name="forex:AMORTISE.POSITION"/>
  <xsl:template name="forex:AMORTISE.FROM.DATE"/>
  <xsl:template name="forex:AMORTISE.CYCLE"/>
  <xsl:template name="forex:OPTION.CURRENCY"/>
  <xsl:template name="forex:OPTION.AMOUNT"/>
  <xsl:template name="forex:OPTION.OS.AMT"/>
  <xsl:template name="forex:OPTION.RATE"/>
  <xsl:template name="forex:DEL.CHG.ACCOUNT"/>
  <xsl:template name="forex:DEL.RATE"/>
  <xsl:template name="forex:DEL.AMOUNT.CHG"/>
  <xsl:template name="forex:DEL.TAX.TYPE"/>
  <xsl:template name="forex:DEL.TAX.AMT"/>
  <xsl:template name="forex:OPTION.TYPE"/>
  <xsl:template name="forex:ORG.VALBUY.DATE"/>
  <xsl:template name="forex:ORG.VALSEL.DATE"/>
  <xsl:template name="forex:OPTION.RATEDATE"/>
  <xsl:template name="forex:ACTIVITYCODE"/>
  <xsl:template name="forex:DEL.CHG.TYPE"/>
  <xsl:template name="forex:DEL.CHG.AMT"/>
  <xsl:template name="forex:DEL.CHG.LCY"/>
  <xsl:template name="forex:DEL.TAX.LCY"/>
  <xsl:template name="forex:DEL.CHG.ACC.CCY"/>
  <xsl:template name="forex:OS.DEL.BUY.AMT"/>
  <xsl:template name="forex:OS.DEL.SELL.AMT"/>
  <xsl:template name="forex:OS.LCY.EQUIV.AMT"/>
  <xsl:template name="forex:DEL.LCY.AMT"/>
  <xsl:template name="forex:OS.LST.LIM.BUY.EOP"/>
  <xsl:template name="forex:OS.LST.LIM.SEL.EOP"/>
  <xsl:template name="forex:OLD.INT.RATE.CALC"/>
  <xsl:template name="forex:SWAP.PL.FWD.POS"/>
  <xsl:template name="forex:REALISE.FIX.PL"/>
  <xsl:template name="forex:FIX.PL.REALISED"/>
  <xsl:template name="forex:FX.ORDER.ID"/>
  <xsl:template name="forex:FX.BULK.ORDR.ID"/>
  <xsl:template name="forex:CLS.DEAL"/>
  <xsl:template name="forex:IDENTIFICATION"/>
  <xsl:template name="forex:DELIVERY.DETAILS"/>
  <xsl:template name="forex:ALLOCATION"/>
  <xsl:template name="forex:METAL.TYPE"/>
  <xsl:template name="forex:FURTHER.INDENT"/>
  <xsl:template name="forex:QUANTITY"/>
  <xsl:template name="forex:CLOSING.ID"/>
  <xsl:template name="forex:OPTION.RATE.ID"/>
  <xsl:template name="forex:LAST.DEL.ID"/>
  <xsl:template name="forex:TRADE.ORD.ID"/>
  <xsl:template name="forex:DEL.RATE.ID"/>
  <xsl:template name="forex:ROUNDING.RULE"/>
  <xsl:template name="forex:AGREEMENT.TYPE"/>
  <xsl:template name="forex:TERMS.AND.CONDS"/>
  <xsl:template name="forex:ADDL.INFO.METAL"/>
  <xsl:template name="forex:AVAILABILITY"/>
  <xsl:template name="forex:MARGIN.PIPS"/>
  <xsl:template name="forex:FX.GROUP.COND.ID"/>
  <xsl:template name="forex:MARGIN.PERC"/>
  <xsl:template name="forex:PVP.SETTLEMENT"/>
  <xsl:template name="forex:RESERVED10"/>
  <xsl:template name="forex:RESERVED9"/>
  <xsl:template name="forex:RESERVED8"/>
  <xsl:template name="forex:RESERVED7"/>
  <xsl:template name="forex:RESERVED6"/>
  <xsl:template name="forex:RESERVED5"/>
  <xsl:template name="forex:RESERVED4"/>
  <xsl:template name="forex:RESERVED3"/>
  <xsl:template name="forex:RESERVED2"/>
  <xsl:template name="forex:RESERVED1"/>
  <xsl:template name="forex:USERDEF.FIELDS"/>
  <xsl:template name="forex:ModelBankSpecificFields"/>
  <xsl:template name="forex:ModelBankSpecificFields-Custo"/>
  

  <xsl:template name="nddeal:TAP.REF.ID">
    <field name="TAP.REF.ID">
      <xsl:value-of select="b:pmsReferenceCode"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:TAP.EVENT.ID">
    <field name="TAP.EVENT.ID">
      <xsl:value-of select="../../../@eventIdentifier"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:TAP.OPER.NATURE">
    <field name="TAP.OPER.NATURE">
      <xsl:value-of select=" '1' "/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:NDF.TYPE">
    <field name="NDF.TYPE">
      <xsl:value-of select=" $NDF_TYPE "/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:AGREEMENT.TYPE">
    <field name="AGREEMENT.TYPE">
      <xsl:value-of select=" $NDF_AGREEMENT_TYPE "/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:DEALER.DESK">
    <field name="DEALER.DESK">
      <xsl:value-of select=" $NDF_DEALER_DESK "/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:COUNTERPARTY">
    <field name="COUNTERPARTY">
      <xsl:choose>
        <xsl:when test="$CUSTOMER_PREFIX != ''">
          <xsl:value-of select="substring-after(b:userDefinedField[infra:name='ud_client']/infra:value,$CUSTOMER_PREFIX)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="b:userDefinedField[infra:name='ud_client']/infra:value"/>
        </xsl:otherwise>
      </xsl:choose>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:PORTFOLIO.NUMBER">
    <field name="PORTFOLIO.NUMBER">
      <xsl:value-of select="substring-after(b:portfolio/infra:code,'-')"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:BUY.SELL.IND">
    <field name="BUY.SELL.IND">
      <xsl:value-of select="'BUY'"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:DEAL.DATE">
    <field name="DEAL.DATE">
      <xsl:value-of select="translate(b:transactionDate,'-','')"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:VALUE.DATE">
    <field name="VALUE.DATE">
      <xsl:value-of select="translate(b:settlementDate,'-','')"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:FIXED.DATE">
    <xsl:if test="b:fixingDate and b:fixingDate != ''">
    	<field name="FIXED.DATE">
	  		<xsl:value-of select="substring(translate(b:fixingDate,'-',''),1,8)"/>
    	</field>
	</xsl:if>
  </xsl:template>
  <xsl:template name="nddeal:DEAL.AMOUNT">
    <field name="DEAL.AMOUNT">
      <xsl:value-of select="b:soldQuantity"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:DEAL.CURRENCY">
    <field name="DEAL.CURRENCY">
      <xsl:value-of select="b:soldCurrency/infra:code"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:SETTLEMENT.CCY">
    <field name="SETTLEMENT.CCY">
      <xsl:value-of select="b:purchasedCurrency/infra:code"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:NOTIONAL.SETTL.AMT">
    <field name="NOTIONAL.SETTL.AMT">
      <xsl:value-of select="b:purchaseCcyNetAmount"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:SETTLEMENT.ACCT">
    <field name="SETTLEMENT.ACCT">
      <xsl:value-of select="b:purchaseCcyCurrentAccount/infra:code"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:DEAL.NOTE">
    <field name="DEAL.NOTE">
      <xsl:value-of select="b:remark"/>
    </field>
  </xsl:template>
  <xsl:template name="nddeal:SETTL.RATE.SRC">
  	<field name="SETTL.RATE.SRC">
		<xsl:value-of select="$ndSettlRateSource"/>
	</field>
  </xsl:template>
  <xsl:template name="nddeal:TAP.FX.RATE.DIR"/>
  <xsl:template name="nddeal:ACCOUNT.OFFICER"/>
  <xsl:template name="nddeal:ACTION.TYPE"/>
  <xsl:template name="nddeal:ADDL.REP.INFO"/>
  <xsl:template name="nddeal:ADDRESSEE"/>
  <xsl:template name="nddeal:AUDIT.DATE.TIME"/>
  <xsl:template name="nddeal:AUDITOR.CODE"/>
  <xsl:template name="nddeal:AUTHORISER"/>
  <xsl:template name="nddeal:BASE.CURRENCY"/>
  <xsl:template name="nddeal:BENEFICIARY.NO"/>
  <xsl:template name="nddeal:BENFICIARY.ADDR"/>
  <xsl:template name="nddeal:BILATERAL.REF"/>
  <xsl:template name="nddeal:BK.TO.BK"/>
  <xsl:template name="nddeal:BUS.DAY.SETTLEMNT"/>
  <xsl:template name="nddeal:BUS.DAY.VALUATION"/>
  <xsl:template name="nddeal:CATEGORY"/>
  <xsl:template name="nddeal:CENTRAL.CLG.PARTY"/>
  <xsl:template name="nddeal:CLG.MEMBER.ID"/>
  <xsl:template name="nddeal:CO.CODE"/>
  <xsl:template name="nddeal:COLLAT.PORT.CODE"/>
  <xsl:template name="nddeal:COLLAT.PORT.IND"/>
  <xsl:template name="nddeal:COLLATERALISATION"/>
  <xsl:template name="nddeal:CONF.NARR"/>
  <xsl:template name="nddeal:CONSOL.KEY"/>
  <xsl:template name="nddeal:CP.TRADE.PURPOSE"/>
  <xsl:template name="nddeal:CPARTY.BANK.ACC"/>
  <xsl:template name="nddeal:CPARTY.COR.ADD"/>
  <xsl:template name="nddeal:CPARTY.CORR.NO"/>
  <xsl:template name="nddeal:CURR.NO"/>
  <xsl:template name="nddeal:CURRENCY.MARKET"/>
  <xsl:template name="nddeal:DATE.TIME"/>
  <xsl:template name="nddeal:DEALER.NAME"/>
  <xsl:template name="nddeal:DEALER.NOTE"/>
  <xsl:template name="nddeal:DELIVERY.REF"/>
  <xsl:template name="nddeal:DEPT.CODE"/>
  <xsl:template name="nddeal:DISCOUNT.PERIOD"/>
  <xsl:template name="nddeal:DISCOUNT.PL"/>
  <xsl:template name="nddeal:EB.ACTIVITY"/>
  <xsl:template name="nddeal:EXEC.TIME.STAMP"/>
  <xsl:template name="nddeal:EXEC.VENUE"/>
  <xsl:template name="nddeal:FIXED.AMOUNT"/>
  <xsl:template name="nddeal:FIXED.RATE"/>
  <xsl:template name="nddeal:INPUTTER"/>
  <xsl:template name="nddeal:INTERMED.ADD"/>
  <xsl:template name="nddeal:INTERMED.BNK.NO"/>
  <xsl:template name="nddeal:LAST.UPD.DATE"/>
  <xsl:template name="nddeal:LIMIT.REFERENCE"/>
  <xsl:template name="nddeal:LINK.REFERENCE"/>
  <xsl:template name="nddeal:LOCAL.REF"/>
  <xsl:template name="nddeal:MESSAGE.CLASS"/>
  <xsl:template name="nddeal:MESSAGE.TYPE"/>
  <xsl:template name="nddeal:NDF.DEAL.NO"/>
  <xsl:template name="nddeal:NDF.LCY.EQUIV"/>
  <xsl:template name="nddeal:NDF.METHOD"/>
  <xsl:template name="nddeal:NET.SETTL.AMT"/>
  <xsl:template name="nddeal:NET.SETTL.LCY"/>
  <xsl:template name="nddeal:NETTING.STATUS"/>
  <xsl:template name="nddeal:NON.STND.FLAG"/>
  <xsl:template name="nddeal:NOTIONAL.RATE"/>
  <xsl:template name="nddeal:OC.CLG.STATUS"/>
  <xsl:template name="nddeal:OVERRIDE"/>
  <xsl:template name="nddeal:OVR.CARRIER"/>
  <xsl:template name="nddeal:OWN.BOOK.PORT"/>
  <xsl:template name="nddeal:PAYMNT.NARR"/>
  <xsl:template name="nddeal:PORT.COMPRESSION"/>
  <xsl:template name="nddeal:POSITION.TYPE"/>
  <xsl:template name="nddeal:PRE.UTI.ID.1"/>
  <xsl:template name="nddeal:PRE.UTI.ID.2"/>
  <xsl:template name="nddeal:PURPOSE.OF.TRAN"/>
  <xsl:template name="nddeal:REC.ADV.NARR"/>
  <xsl:template name="nddeal:RECEIVER.BNK.NO"/>
  <xsl:template name="nddeal:RECORD.STATUS"/>
  <xsl:template name="nddeal:SEND.DATE"/>
  <xsl:template name="nddeal:SEND.MESSAGE"/>
  <xsl:template name="nddeal:SETTL.INT.BASIS"/>
  <xsl:template name="nddeal:SETTL.INT.RATE"/>
  <xsl:template name="nddeal:SETTL.LCY.EQUIV"/>
  <xsl:template name="nddeal:SETTLEMENT.AMT"/>
  <xsl:template name="nddeal:SETTLEMENT.DATE"/>
  <xsl:template name="nddeal:STATUS"/>
  <xsl:template name="nddeal:STMT.NO"/>
  <xsl:template name="nddeal:SWIFT.COMMON.REF"/>
  <xsl:template name="nddeal:TRADE.REPOSITORY"/>
  <xsl:template name="nddeal:TT.REF.NO"/>
  <xsl:template name="nddeal:UNI.TRAN.ID"/>
  <xsl:template name="nddeal:UNIQUE.PROD.ID"/>
  <xsl:template name="nddeal:USERDEF.FIELDS"/>
  <xsl:template name="nddeal:ModelBankSpecificFields"/>
  <xsl:template name="nddeal:ModelBankSpecificFields-Custo"/>
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