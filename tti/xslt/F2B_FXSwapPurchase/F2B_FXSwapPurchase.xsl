<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="/">
      <T24Batch>
         <xsl:for-each select="b:F2B_MM_FX/b:DataGroup/b:ForexForward/b:ForexSwap/b:OrderLifeCycle/b:purchaseRequest">
            <T24>
               <serviceRequest>
                  <securityContext>
                     <xsl:choose>
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
                  <ofsTransactionInput application="FOREX" operation="PROCESS" version="{$ForexFXSwapPurchaseVersion}">
                     <xsl:call-template name="FOREX"/>
                  </ofsTransactionInput>
               </serviceRequest>
            </T24>
         </xsl:for-each>
      </T24Batch>
   </xsl:template>
   <xsl:template name="FOREX">
      <xsl:call-template name="TAP.REF.ID"/>
      <xsl:call-template name="TAP.EVENT.ID"/>
      <xsl:call-template name="TAP.OPER.NATURE"/>
      <xsl:call-template name="TAP.FX.RATE.DIR"/>
      <xsl:call-template name="TRANSACTION.REF.NO"/>
      <xsl:call-template name="DEAL.TYPE"/>
      <xsl:call-template name="DEAL.SUB.TYPE"/>
      <xsl:call-template name="COUNTERPARTY"/>
      <xsl:call-template name="DEALER.DESK"/>
      <xsl:call-template name="CURRENCY.MARKET"/>
      <xsl:call-template name="CURRENCY.BOUGHT"/>
      <xsl:call-template name="AMOUNT.BOUGHT"/>
      <xsl:call-template name="VALUE.DATE.BUY"/>
      <xsl:call-template name="CURRENCY.SOLD"/>
      <xsl:call-template name="AMOUNT.SOLD"/>
      <xsl:call-template name="VALUE.DATE.SELL"/>
      <xsl:call-template name="SPOT.RATE"/>
      <xsl:call-template name="FORWARD.RATE"/>
      <xsl:call-template name="SWAP.BASE.CCY"/>
      <xsl:call-template name="BROKER"/>
      <xsl:call-template name="BROKERAGE"/>
      <xsl:call-template name="BROKERAGE.CCY"/>
      <xsl:call-template name="BROKERAGE.AMOUNT"/>
      <xsl:call-template name="CONFIRMD.BY.BROKER"/>
      <xsl:call-template name="LIMIT.REFERENCE.NO"/>
      <xsl:call-template name="POSITION.TYPE.BUY"/>
      <xsl:call-template name="POSITION.TYPE.SELL"/>
      <xsl:call-template name="NEGOTIATED.REF.NO"/>
      <xsl:call-template name="DEAL.DATE"/>
      <xsl:call-template name="REVALUATION.TYPE"/>
      <xsl:call-template name="SPOT.DATE"/>
      <xsl:call-template name="BASE.CCY"/>
      <xsl:call-template name="SPOT.LCY.AMOUNT"/>
      <xsl:call-template name="SWAP.REF.NO"/>
      <xsl:call-template name="INT.RATE.BUY"/>
      <xsl:call-template name="INT.RATE.SELL"/>
      <xsl:call-template name="OPTION.DATE"/>
      <xsl:call-template name="OUR.ACCOUNT.PAY"/>
      <xsl:call-template name="OUR.ACCOUNT.REC"/>
      <xsl:call-template name="DEL.DATE.BUY"/>
      <xsl:call-template name="DEL.AMOUNT.BUY"/>
      <xsl:call-template name="DEL.DATE.SELL"/>
      <xsl:call-template name="DEL.AMOUNT.SELL"/>
      <xsl:call-template name="BENEFICIARY.NO"/>
      <xsl:call-template name="BENFCY.ADD"/>
      <xsl:call-template name="CPARTY.CORR.NO"/>
      <xsl:call-template name="CPY.CORR.ADD"/>
      <xsl:call-template name="CPARTY.BANK.ACC"/>
      <xsl:call-template name="INTERMED.BK.NO"/>
      <xsl:call-template name="INTERMED.ADD"/>
      <xsl:call-template name="CONF.NARR"/>
      <xsl:call-template name="PAYMT.NARR"/>
      <xsl:call-template name="REC.ADV.NARR"/>
      <xsl:call-template name="PAY.ACC.POSTED"/>
      <xsl:call-template name="REC.ACC.POSTED"/>
      <xsl:call-template name="PAYMENT.SENT"/>
      <xsl:call-template name="ADVICE.SENT"/>
      <xsl:call-template name="CONFIRM.SENT"/>
      <xsl:call-template name="CONF.BY.CPARTY"/>
      <xsl:call-template name="BUY.LCY.EQUIV"/>
      <xsl:call-template name="SEL.LCY.EQUIV"/>
      <xsl:call-template name="BUY.DAILY.ACC.L"/>
      <xsl:call-template name="BUY.ACC.TDATE.L"/>
      <xsl:call-template name="BUY.DAILY.ACC.F"/>
      <xsl:call-template name="BUY.ACC.TDATE.F"/>
      <xsl:call-template name="SEL.DAILY.ACC.L"/>
      <xsl:call-template name="SEL.ACC.TDATE.L"/>
      <xsl:call-template name="SEL.DAILY.ACC.F"/>
      <xsl:call-template name="SEL.ACC.TDATE.F"/>
      <xsl:call-template name="SWIFT.COMMON.REF"/>
      <xsl:call-template name="CATEGORY.CODE"/>
      <xsl:call-template name="TREASURY.CUSTOMER"/>
      <xsl:call-template name="ACCOUNT.TO.CHARGE"/>
      <xsl:call-template name="MKTG.EXCH.PROFIT"/>
      <xsl:call-template name="COMMISSION.TAKEN"/>
      <xsl:call-template name="TREASURY.RATE"/>
      <xsl:call-template name="CHARGE.CODE"/>
      <xsl:call-template name="CHARGE.AMOUNT"/>
      <xsl:call-template name="TAX.CODE"/>
      <xsl:call-template name="TAX.AMOUNT"/>
      <xsl:call-template name="ACCOUNT.OFFICER"/>
      <xsl:call-template name="FED.FUNDS"/>
      <xsl:call-template name="SEND.CONFIRMATION"/>
      <xsl:call-template name="SEND.PAYMENT"/>
      <xsl:call-template name="SEND.ADVICE"/>
      <xsl:call-template name="CORR.AMEND.MKR"/>
      <xsl:call-template name="REPLACING.DEAL.NO"/>
      <xsl:call-template name="NOTES"/>
      <xsl:call-template name="DEALER.NOTES"/>
      <xsl:call-template name="ORIGINAL.FUNCTION"/>
      <xsl:call-template name="EQV.CODE"/>
      <xsl:call-template name="EQUIV.AMT"/>
      <xsl:call-template name="BROKERAGE.EQUIV"/>
      <xsl:call-template name="CHARGE.EQUIV"/>
      <xsl:call-template name="TAX.EQUIV"/>
      <xsl:call-template name="NOTIONAL.BUY.AMT"/>
      <xsl:call-template name="NOTIONAL.SELL.AMT"/>
      <xsl:call-template name="PORTFOLIO.NUMBER"/>
      <xsl:call-template name="TOTAL.INT.BOUGHT"/>
      <xsl:call-template name="TOTAL.INT.SOLD"/>
      <xsl:call-template name="EQUIV.INT.BOUGHT"/>
      <xsl:call-template name="EQUIV.INT.SOLD"/>
      <xsl:call-template name="INT.BASIS.BOUGHT"/>
      <xsl:call-template name="INT.BASIS.SOLD"/>
      <xsl:call-template name="LOCAL.REF"/>
      <xsl:call-template name="ORIGINATING.DEPT"/>
      <xsl:call-template name="PHANTOM.IND"/>
      <xsl:call-template name="CONSOL.IND"/>
      <xsl:call-template name="STMT.NO"/>
      <xsl:call-template name="OVERRIDE"/>
      <xsl:call-template name="RECORD.STATUS"/>
      <xsl:call-template name="CURR.NO"/>
      <xsl:call-template name="INPUTTER"/>
      <xsl:call-template name="DATE.TIME"/>
      <xsl:call-template name="AUTHORISER"/>
      <xsl:call-template name="CO.CODE"/>
      <xsl:call-template name="DEPT.CODE"/>
      <xsl:call-template name="AUDITOR.CODE"/>
      <xsl:call-template name="AUDIT.DATE.TIME"/>
      <xsl:call-template name="BK.TO.BK.INF"/>
      <xsl:call-template name="BULK.DEAL"/>
      <xsl:call-template name="BULK.REFERENCE"/>
      <xsl:call-template name="AMT.BOUGHT.OS"/>
      <xsl:call-template name="AMT.SOLD.OS"/>
      <xsl:call-template name="DEAL.MARKET"/>
      <xsl:call-template name="LINK.REFERENCE"/>
      <xsl:call-template name="NETTING.STATUS"/>
      <xsl:call-template name="STATUS"/>
      <xsl:call-template name="MKTG.EXCH.ADJ"/>
      <xsl:call-template name="AMORTISE.POSITION"/>
      <xsl:call-template name="AMORTISE.FROM.DATE"/>
      <xsl:call-template name="AMORTISE.CYCLE"/>
      <xsl:call-template name="OPTION.CURRENCY"/>
      <xsl:call-template name="OPTION.AMOUNT"/>
      <xsl:call-template name="OPTION.OS.AMT"/>
      <xsl:call-template name="OPTION.RATE"/>
      <xsl:call-template name="DEL.CHG.ACCOUNT"/>
      <xsl:call-template name="DEL.RATE"/>
      <xsl:call-template name="DEL.AMOUNT.CHG"/>
      <xsl:call-template name="DEL.TAX.TYPE"/>
      <xsl:call-template name="DEL.TAX.AMT"/>
      <xsl:call-template name="TRANSACTION.TYPE"/>
      <xsl:call-template name="OPTION.TYPE"/>
      <xsl:call-template name="ORG.VALBUY.DATE"/>
      <xsl:call-template name="ORG.VALSEL.DATE"/>
      <xsl:call-template name="OPTION.RATEDATE"/>
      <xsl:call-template name="ACTIVITYCODE"/>
      <xsl:call-template name="DEL.CHG.TYPE"/>
      <xsl:call-template name="DEL.CHG.AMT"/>
      <xsl:call-template name="DEL.CHG.LCY"/>
      <xsl:call-template name="DEL.TAX.LCY"/>
      <xsl:call-template name="DEL.CHG.ACC.CCY"/>
      <xsl:call-template name="OS.DEL.BUY.AMT"/>
      <xsl:call-template name="OS.DEL.SELL.AMT"/>
      <xsl:call-template name="OS.LCY.EQUIV.AMT"/>
      <xsl:call-template name="DEL.LCY.AMT"/>
      <xsl:call-template name="OS.LST.LIM.BUY.EOP"/>
      <xsl:call-template name="OS.LST.LIM.SEL.EOP"/>
      <xsl:call-template name="OLD.INT.RATE.CALC"/>
      <xsl:call-template name="SWAP.PL.FWD.POS"/>
      <xsl:call-template name="REALISE.FIX.PL"/>
      <xsl:call-template name="FIX.PL.REALISED"/>
      <xsl:call-template name="SOD.MAT"/>
      <xsl:call-template name="FX.ORDER.ID"/>
      <xsl:call-template name="FX.BULK.ORDR.ID"/>
      <xsl:call-template name="CLS.DEAL"/>
      <xsl:call-template name="IDENTIFICATION"/>
      <xsl:call-template name="DELIVERY.DETAILS"/>
      <xsl:call-template name="ALLOCATION"/>
      <xsl:call-template name="METAL.TYPE"/>
      <xsl:call-template name="FURTHER.INDENT"/>
      <xsl:call-template name="QUANTITY"/>
      <xsl:call-template name="CLOSING.ID"/>
      <xsl:call-template name="OPTION.RATE.ID"/>
      <xsl:call-template name="LAST.DEL.ID"/>
      <xsl:call-template name="TRADE.ORD.ID"/>
      <xsl:call-template name="DEL.RATE.ID"/>
      <xsl:call-template name="ROUNDING.RULE"/>
      <xsl:call-template name="AGREEMENT.TYPE"/>
      <xsl:call-template name="TERMS.AND.CONDS"/>
      <xsl:call-template name="ADDL.INFO.METAL"/>
      <xsl:call-template name="AVAILABILITY"/>
      <xsl:call-template name="MARGIN.PIPS"/>
      <xsl:call-template name="FX.GROUP.COND.ID"/>
      <xsl:call-template name="MARGIN.PERC"/>
      <xsl:call-template name="PVP.SETTLEMENT"/>
      <xsl:call-template name="RESERVED10"/>
      <xsl:call-template name="RESERVED9"/>
      <xsl:call-template name="RESERVED8"/>
      <xsl:call-template name="RESERVED7"/>
      <xsl:call-template name="RESERVED6"/>
      <xsl:call-template name="RESERVED5"/>
      <xsl:call-template name="RESERVED4"/>
      <xsl:call-template name="RESERVED3"/>
      <xsl:call-template name="RESERVED2"/>
      <xsl:call-template name="RESERVED1"/>
      <xsl:call-template name="USERDEF.FIELDS"/>
	  <xsl:call-template name="ModelBankSpecificFields"/>
	  <xsl:call-template name="ModelBankSpecificFields-Custo"/>
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