<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150"
                xmlns:b="http://www.odcgroup.com/F2B_MM_FX"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="TAP.REF.ID">
      <field name="TAP.REF.ID">
         <xsl:value-of select="b:pmsReferenceCode"/>
      </field>
   </xsl:template>
   <xsl:template name="TAP.EVENT.ID">
      <field name="TAP.EVENT.ID">
         <xsl:value-of select="../../../@eventIdentifier"/>
      </field>
   </xsl:template>
   <xsl:template name="TAP.OPER.NATURE">
      <field name="TAP.OPER.NATURE">
         <xsl:value-of select="'2'"/>
      </field>
   </xsl:template>
   <xsl:template name="TAP.FX.RATE.DIR">
      <field name="TAP.FX.RATE.DIR">
         <xsl:value-of select="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="TAP.FX.COMP.ORD">
  <xsl:if test="b:compoundOrderCode">
	<field name="TAP.FX.COMP.ORD">
		<xsl:value-of select="b:compoundOrderCode"/>
	</field>
  </xsl:if>
  </xsl:template>
   <xsl:template name="DEAL.TYPE">
      <field name="DEAL.TYPE">
         <xsl:value-of select="'SP'"/>
      </field>
   </xsl:template>
   <xsl:template name="TRANSACTION.TYPE">
      <field name="TRANSACTION.TYPE">
         <xsl:value-of select="$SPOT_TRANSACTION_TYPE"/>
      </field>
   </xsl:template>
   <xsl:template name="COUNTERPARTY">
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
   <xsl:template name="PORTFOLIO.NUMBER">
      <field name="PORTFOLIO.NUMBER">
		 <xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="substring-after(b:boPortfolio/infra:code,'-')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-after(b:portfolio/infra:code,'-')"/>
				</xsl:otherwise>
			</xsl:choose>
      </field>
   </xsl:template>
   <xsl:template name="TREASURY.CUSTOMER">
      <field name="TREASURY.CUSTOMER">
         <xsl:value-of select="'NO'"/>
      </field>
   </xsl:template>
   <xsl:template name="CURRENCY.BOUGHT">
      <field name="CURRENCY.BOUGHT">
         <xsl:value-of select="b:userDefinedField[infra:name='fi_currency']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="AMOUNT.BOUGHT">
      <field name="AMOUNT.BOUGHT">
         <xsl:value-of select="b:quantity"/>
      </field>
   </xsl:template>
   <xsl:template name="OUR.ACCOUNT.REC">
      <field name="OUR.ACCOUNT.REC">
		 <xsl:choose>
				<xsl:when test="b:boCashAccount/infra:code != ''">
					<xsl:value-of select="b:boCashAccount/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:purchasedCcyCurrentAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
      </field>
   </xsl:template>
   <xsl:template name="CURRENCY.SOLD">
      <field name="CURRENCY.SOLD">
         <xsl:value-of select="b:userDefinedField[infra:name='acc_currency']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="AMOUNT.SOLD">
      <field name="AMOUNT.SOLD">
         <xsl:value-of select="b:purchaseCcyNetAmount"/>
      </field>
   </xsl:template>
   <xsl:template name="OUR.ACCOUNT.PAY">
      <field name="OUR.ACCOUNT.PAY">
		<xsl:choose>
			<xsl:when test="b:boAccount/infra:code != ''">
				<xsl:value-of select="b:boAccount/infra:code"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:soldCcyCurrentAccount/infra:code"/>
			</xsl:otherwise>
		</xsl:choose>
      </field>
   </xsl:template>
   <xsl:template name="BASE.CCY">
      <xsl:choose><!-- default fx_date_direction_f = 0 (multiply) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '0'">
            <field name="BASE.CCY">
               <xsl:value-of select="b:userDefinedField[infra:name='fi_currency']/infra:value"/>
            </field>
         </xsl:when>
         <!-- fx_date_direction_f = 1 (divide) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '1'">
            <field name="BASE.CCY">
               <xsl:value-of select="b:userDefinedField[infra:name='acc_currency']/infra:value"/>
            </field>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="SPOT.RATE">
      <xsl:choose><!-- default fx_date_direction_f = 0 (multiply) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '0'">
            <field name="SPOT.RATE">
               <xsl:value-of select="b:spotExchangeRate"/>
            </field>
         </xsl:when>
         <!-- fx_date_direction_f = 1 (divide) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '1'">
            <field name="SPOT.RATE">
               <xsl:value-of select="b:userDefinedField[infra:name='fx_client_rate_n']/infra:value"/>
            </field>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="TREASURY.RATE">
      <xsl:choose><!-- default fx_date_direction_f = 0 (multiply) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '0'">
            <xsl:if test="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value != '' ">
               <field name="TREASURY.RATE">
                  <xsl:value-of select="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value"/>
               </field>
            </xsl:if>
         </xsl:when>
         <!-- fx_date_direction_f = 1 (divide) -->
         <xsl:when test="b:userDefinedField[infra:name='fx_rate_direction_f']/infra:value = '1'">
            <xsl:if test="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value != '' ">
               <field name="TREASURY.RATE">
                  <xsl:value-of select="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value"/>
               </field>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="DEAL.DATE">
      <field name="DEAL.DATE">
         <xsl:value-of select="translate(b:transactionDate,'-','')"/>
      </field>
   </xsl:template>
   <xsl:template name="SPOT.DATE">
      <field name="SPOT.DATE">
         <xsl:value-of select="translate(b:valueDate,'-','')"/>
      </field>
   </xsl:template>
   <xsl:template name="VALUE.DATE.SELL">
      <field name="VALUE.DATE.SELL">
         <xsl:value-of select="translate(b:valueDate,'-','')"/>
      </field>
   </xsl:template>
   <xsl:template name="VALUE.DATE.BUY">
      <field name="VALUE.DATE.BUY">
         <xsl:value-of select="translate(b:valueDate,'-','')"/>
      </field>
   </xsl:template>
   <xsl:template name="NOTES">
      <field name="NOTES">
         <xsl:value-of select="b:userDefinedField[infra:name='remark_1_c']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="DEALER.NOTES">
      <field name="DEALER.NOTES">
         <xsl:value-of select="b:userDefinedField[infra:name='remark_2_c']/infra:value"/>
      </field>
   </xsl:template>
   <xsl:template name="TRANSACTION.REF.NO"/>
   <xsl:template name="DEAL.SUB.TYPE"/>
   <xsl:template name="DEALER.DESK"/>
   <xsl:template name="CURRENCY.MARKET"/>
   <xsl:template name="FORWARD.RATE"/>
   <xsl:template name="SWAP.BASE.CCY"/>
   <xsl:template name="BROKER"/>
   <xsl:template name="BROKERAGE"/>
   <xsl:template name="BROKERAGE.CCY"/>
   <xsl:template name="BROKERAGE.AMOUNT"/>
   <xsl:template name="CONFIRMD.BY.BROKER"/>
   <xsl:template name="LIMIT.REFERENCE.NO"/>
   <xsl:template name="POSITION.TYPE.BUY"/>
   <xsl:template name="POSITION.TYPE.SELL"/>
   <xsl:template name="NEGOTIATED.REF.NO"/>
   <xsl:template name="REVALUATION.TYPE"/>
   <xsl:template name="SPOT.LCY.AMOUNT"/>
   <xsl:template name="SWAP.REF.NO"/>
   <xsl:template name="INT.RATE.BUY"/>
   <xsl:template name="INT.RATE.SELL"/>
   <xsl:template name="OPTION.DATE"/>
   <xsl:template name="DEL.DATE.BUY"/>
   <xsl:template name="DEL.AMOUNT.BUY"/>
   <xsl:template name="DEL.DATE.SELL"/>
   <xsl:template name="DEL.AMOUNT.SELL"/>
   <xsl:template name="BENEFICIARY.NO"/>
   <xsl:template name="BENFCY.ADD"/>
   <xsl:template name="CPARTY.CORR.NO"/>
   <xsl:template name="CPY.CORR.ADD"/>
   <xsl:template name="CPARTY.BANK.ACC"/>
   <xsl:template name="INTERMED.BK.NO"/>
   <xsl:template name="INTERMED.ADD"/>
   <xsl:template name="CONF.NARR"/>
   <xsl:template name="PAYMT.NARR"/>
   <xsl:template name="REC.ADV.NARR"/>
   <xsl:template name="PAY.ACC.POSTED"/>
   <xsl:template name="REC.ACC.POSTED"/>
   <xsl:template name="PAYMENT.SENT"/>
   <xsl:template name="ADVICE.SENT"/>
   <xsl:template name="CONFIRM.SENT"/>
   <xsl:template name="CONF.BY.CPARTY"/>
   <xsl:template name="BUY.LCY.EQUIV"/>
   <xsl:template name="SEL.LCY.EQUIV"/>
   <xsl:template name="BUY.DAILY.ACC.L"/>
   <xsl:template name="BUY.ACC.TDATE.L"/>
   <xsl:template name="BUY.DAILY.ACC.F"/>
   <xsl:template name="BUY.ACC.TDATE.F"/>
   <xsl:template name="SEL.DAILY.ACC.L"/>
   <xsl:template name="SEL.ACC.TDATE.L"/>
   <xsl:template name="SEL.DAILY.ACC.F"/>
   <xsl:template name="SEL.ACC.TDATE.F"/>
   <xsl:template name="SWIFT.COMMON.REF"/>
   <xsl:template name="CATEGORY.CODE"/>
   <xsl:template name="ACCOUNT.TO.CHARGE"/>
   <xsl:template name="MKTG.EXCH.PROFIT"/>
   <xsl:template name="COMMISSION.TAKEN"/>
   <xsl:template name="CHARGE.CODE"/>
   <xsl:template name="CHARGE.AMOUNT"/>
   <xsl:template name="TAX.CODE"/>
   <xsl:template name="TAX.AMOUNT"/>
   <xsl:template name="ACCOUNT.OFFICER"/>
   <xsl:template name="FED.FUNDS"/>
   <xsl:template name="SEND.CONFIRMATION"/>
   <xsl:template name="SEND.PAYMENT"/>
   <xsl:template name="SEND.ADVICE"/>
   <xsl:template name="CORR.AMEND.MKR"/>
   <xsl:template name="REPLACING.DEAL.NO"/>
   <xsl:template name="ORIGINAL.FUNCTION"/>
   <xsl:template name="EQV.CODE"/>
   <xsl:template name="EQUIV.AMT"/>
   <xsl:template name="BROKERAGE.EQUIV"/>
   <xsl:template name="CHARGE.EQUIV"/>
   <xsl:template name="TAX.EQUIV"/>
   <xsl:template name="NOTIONAL.BUY.AMT"/>
   <xsl:template name="NOTIONAL.SELL.AMT"/>
   <xsl:template name="TOTAL.INT.BOUGHT"/>
   <xsl:template name="TOTAL.INT.SOLD"/>
   <xsl:template name="EQUIV.INT.BOUGHT"/>
   <xsl:template name="EQUIV.INT.SOLD"/>
   <xsl:template name="INT.BASIS.BOUGHT"/>
   <xsl:template name="INT.BASIS.SOLD"/>
   <xsl:template name="LOCAL.REF"/>
   <xsl:template name="ORIGINATING.DEPT"/>
   <xsl:template name="PHANTOM.IND"/>
   <xsl:template name="CONSOL.IND"/>
   <xsl:template name="STMT.NO"/>
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
   <xsl:template name="BK.TO.BK.INF"/>
   <xsl:template name="BULK.DEAL"/>
   <xsl:template name="BULK.REFERENCE"/>
   <xsl:template name="AMT.BOUGHT.OS"/>
   <xsl:template name="AMT.SOLD.OS"/>
   <xsl:template name="DEAL.MARKET"/>
   <xsl:template name="LINK.REFERENCE"/>
   <xsl:template name="NETTING.STATUS"/>
   <xsl:template name="STATUS"/>
   <xsl:template name="MKTG.EXCH.ADJ"/>
   <xsl:template name="AMORTISE.POSITION"/>
   <xsl:template name="AMORTISE.FROM.DATE"/>
   <xsl:template name="AMORTISE.CYCLE"/>
   <xsl:template name="OPTION.CURRENCY"/>
   <xsl:template name="OPTION.AMOUNT"/>
   <xsl:template name="OPTION.OS.AMT"/>
   <xsl:template name="OPTION.RATE"/>
   <xsl:template name="DEL.CHG.ACCOUNT"/>
   <xsl:template name="DEL.RATE"/>
   <xsl:template name="DEL.AMOUNT.CHG"/>
   <xsl:template name="DEL.TAX.TYPE"/>
   <xsl:template name="DEL.TAX.AMT"/>
   <xsl:template name="OPTION.TYPE"/>
   <xsl:template name="ORG.VALBUY.DATE"/>
   <xsl:template name="ORG.VALSEL.DATE"/>
   <xsl:template name="OPTION.RATEDATE"/>
   <xsl:template name="ACTIVITYCODE"/>
   <xsl:template name="DEL.CHG.TYPE"/>
   <xsl:template name="DEL.CHG.AMT"/>
   <xsl:template name="DEL.CHG.LCY"/>
   <xsl:template name="DEL.TAX.LCY"/>
   <xsl:template name="DEL.CHG.ACC.CCY"/>
   <xsl:template name="OS.DEL.BUY.AMT"/>
   <xsl:template name="OS.DEL.SELL.AMT"/>
   <xsl:template name="OS.LCY.EQUIV.AMT"/>
   <xsl:template name="DEL.LCY.AMT"/>
   <xsl:template name="OS.LST.LIM.BUY.EOP"/>
   <xsl:template name="OS.LST.LIM.SEL.EOP"/>
   <xsl:template name="OLD.INT.RATE.CALC"/>
   <xsl:template name="SWAP.PL.FWD.POS"/>
   <xsl:template name="REALISE.FIX.PL"/>
   <xsl:template name="FIX.PL.REALISED"/>
   <xsl:template name="SOD.MAT"/>
   <xsl:template name="FX.ORDER.ID"/>
   <xsl:template name="FX.BULK.ORDR.ID"/>
   <xsl:template name="CLS.DEAL"/>
   <xsl:template name="IDENTIFICATION"/>
   <xsl:template name="DELIVERY.DETAILS"/>
   <xsl:template name="ALLOCATION"/>
   <xsl:template name="METAL.TYPE"/>
   <xsl:template name="FURTHER.INDENT"/>
   <xsl:template name="QUANTITY"/>
   <xsl:template name="CLOSING.ID"/>
   <xsl:template name="OPTION.RATE.ID"/>
   <xsl:template name="LAST.DEL.ID"/>
   <xsl:template name="TRADE.ORD.ID"/>
   <xsl:template name="DEL.RATE.ID"/>
   <xsl:template name="ROUNDING.RULE"/>
   <xsl:template name="AGREEMENT.TYPE"/>
   <xsl:template name="TERMS.AND.CONDS"/>
   <xsl:template name="ADDL.INFO.METAL"/>
   <xsl:template name="AVAILABILITY"/>
   <xsl:template name="MARGIN.PIPS"/>
   <xsl:template name="FX.GROUP.COND.ID"/>
   <xsl:template name="MARGIN.PERC"/>
   <xsl:template name="PVP.SETTLEMENT"/>
   <xsl:template name="RESERVED10"/>
   <xsl:template name="RESERVED9"/>
   <xsl:template name="RESERVED8"/>
   <xsl:template name="RESERVED7"/>
   <xsl:template name="RESERVED6"/>
   <xsl:template name="RESERVED5"/>
   <xsl:template name="RESERVED4"/>
   <xsl:template name="RESERVED3"/>
   <xsl:template name="RESERVED2"/>
   <xsl:template name="RESERVED1"/>
   <xsl:template name="USERDEF.FIELDS"/>
   <xsl:template name="ModelBankSpecificFields"/>
   <xsl:template name="ModelBankSpecificFields-Custo"/>
   <xsl:template name="TAP.SLEEVE.PTF">
		<field name="TAP.SLEEVE.PTF">
		<xsl:if test="b:boPortfolio/infra:code != ''">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</xsl:if>
      </field>
   </xsl:template>
   <xsl:template name="OUR.ACC.REC.SLV">
   <field name="OUR.ACC.REC.SLV">
		<xsl:if test="b:boCashAccount/infra:code != ''">
			<xsl:value-of select="b:purchasedCcyCurrentAccount/infra:code"/>
		</xsl:if>
      </field>
   </xsl:template>
   <xsl:template name="OUR.ACC.PAY.SLV">
		<field name="OUR.ACC.PAY.SLV">
			<xsl:if test="b:boAccount/infra:code != ''">
				<xsl:value-of select="b:soldCcyCurrentAccount/infra:code"/>
			</xsl:if>
      </field>
   </xsl:template>
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