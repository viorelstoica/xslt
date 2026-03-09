<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:forex="http://www.temenos.com/T24/forex" xmlns:nddeal="http://www.temenos.com/T24/nddeal" exclude-result-prefixes="b" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="/">
      <T24Batch>
         <xsl:for-each select="b:F2B_MM_FX/b:DataGroup/b:ForexForward/b:Forward/b:OrderLifeCycle/b:purchaseRequest">
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
                  <xsl:choose>
                     <xsl:when test="b:userDefinedField[infra:name='ud_instr_physical_f']/infra:value= '1' ">
                        <ofsTransactionInput application="FOREX" operation="PROCESS" version="{$ForexFXForwardPurchaseVersion}">
                           <xsl:call-template name="forex.FOREX"/>
                        </ofsTransactionInput>
                     </xsl:when>
                     <xsl:when test="b:userDefinedField[infra:name='ud_instr_physical_f']/infra:value= '0' ">
                        <ofsTransactionInput application="ND.DEAL" operation="PROCESS" version="{$NdDealNDForwardPurchaseVersion}">
                           <xsl:call-template name="nddeal.ND.DEAL"/>
                        </ofsTransactionInput>
                     </xsl:when>
                  </xsl:choose>
               </serviceRequest>
            </T24>
         </xsl:for-each>
      </T24Batch>
   </xsl:template>
   <xsl:template name="forex.FOREX">
      <xsl:call-template name="forex:TAP.REF.ID"/>
      <xsl:call-template name="forex:TAP.EVENT.ID"/>
      <xsl:call-template name="forex:TAP.OPER.NATURE"/>
      <xsl:call-template name="forex:TAP.FX.RATE.DIR"/>
      <xsl:call-template name="forex:TRANSACTION.REF.NO"/>
      <xsl:call-template name="forex:DEAL.TYPE"/>
      <xsl:call-template name="forex:DEAL.SUB.TYPE"/>
      <xsl:call-template name="forex:COUNTERPARTY"/>
      <xsl:call-template name="forex:DEALER.DESK"/>
      <xsl:call-template name="forex:CURRENCY.MARKET"/>
      <xsl:call-template name="forex:CURRENCY.BOUGHT"/>
      <xsl:call-template name="forex:AMOUNT.BOUGHT"/>
      <xsl:call-template name="forex:VALUE.DATE.BUY"/>
      <xsl:call-template name="forex:CURRENCY.SOLD"/>
      <xsl:call-template name="forex:AMOUNT.SOLD"/>
      <xsl:call-template name="forex:VALUE.DATE.SELL"/>
      <xsl:call-template name="forex:SPOT.RATE"/>
      <xsl:call-template name="forex:FORWARD.RATE"/>
      <xsl:call-template name="forex:SWAP.BASE.CCY"/>
      <xsl:call-template name="forex:BROKER"/>
      <xsl:call-template name="forex:BROKERAGE"/>
      <xsl:call-template name="forex:BROKERAGE.CCY"/>
      <xsl:call-template name="forex:BROKERAGE.AMOUNT"/>
      <xsl:call-template name="forex:CONFIRMD.BY.BROKER"/>
      <xsl:call-template name="forex:LIMIT.REFERENCE.NO"/>
      <xsl:call-template name="forex:POSITION.TYPE.BUY"/>
      <xsl:call-template name="forex:POSITION.TYPE.SELL"/>
      <xsl:call-template name="forex:NEGOTIATED.REF.NO"/>
      <xsl:call-template name="forex:DEAL.DATE"/>
      <xsl:call-template name="forex:REVALUATION.TYPE"/>
      <xsl:call-template name="forex:SPOT.DATE"/>
      <xsl:call-template name="forex:BASE.CCY"/>
      <xsl:call-template name="forex:SPOT.LCY.AMOUNT"/>
      <xsl:call-template name="forex:SWAP.REF.NO"/>
      <xsl:call-template name="forex:INT.RATE.BUY"/>
      <xsl:call-template name="forex:INT.RATE.SELL"/>
      <xsl:call-template name="forex:OPTION.DATE"/>
      <xsl:call-template name="forex:OUR.ACCOUNT.PAY"/>
      <xsl:call-template name="forex:OUR.ACCOUNT.REC"/>
      <xsl:call-template name="forex:DEL.DATE.BUY"/>
      <xsl:call-template name="forex:DEL.AMOUNT.BUY"/>
      <xsl:call-template name="forex:DEL.DATE.SELL"/>
      <xsl:call-template name="forex:DEL.AMOUNT.SELL"/>
      <xsl:call-template name="forex:BENEFICIARY.NO"/>
      <xsl:call-template name="forex:BENFCY.ADD"/>
      <xsl:call-template name="forex:CPARTY.CORR.NO"/>
      <xsl:call-template name="forex:CPY.CORR.ADD"/>
      <xsl:call-template name="forex:CPARTY.BANK.ACC"/>
      <xsl:call-template name="forex:INTERMED.BK.NO"/>
      <xsl:call-template name="forex:INTERMED.ADD"/>
      <xsl:call-template name="forex:CONF.NARR"/>
      <xsl:call-template name="forex:PAYMT.NARR"/>
      <xsl:call-template name="forex:REC.ADV.NARR"/>
      <xsl:call-template name="forex:PAY.ACC.POSTED"/>
      <xsl:call-template name="forex:REC.ACC.POSTED"/>
      <xsl:call-template name="forex:PAYMENT.SENT"/>
      <xsl:call-template name="forex:ADVICE.SENT"/>
      <xsl:call-template name="forex:CONFIRM.SENT"/>
      <xsl:call-template name="forex:CONF.BY.CPARTY"/>
      <xsl:call-template name="forex:BUY.LCY.EQUIV"/>
      <xsl:call-template name="forex:SEL.LCY.EQUIV"/>
      <xsl:call-template name="forex:BUY.DAILY.ACC.L"/>
      <xsl:call-template name="forex:BUY.ACC.TDATE.L"/>
      <xsl:call-template name="forex:BUY.DAILY.ACC.F"/>
      <xsl:call-template name="forex:BUY.ACC.TDATE.F"/>
      <xsl:call-template name="forex:SEL.DAILY.ACC.L"/>
      <xsl:call-template name="forex:SEL.ACC.TDATE.L"/>
      <xsl:call-template name="forex:SEL.DAILY.ACC.F"/>
      <xsl:call-template name="forex:SEL.ACC.TDATE.F"/>
      <xsl:call-template name="forex:SWIFT.COMMON.REF"/>
      <xsl:call-template name="forex:CATEGORY.CODE"/>
      <xsl:call-template name="forex:TREASURY.CUSTOMER"/>
      <xsl:call-template name="forex:ACCOUNT.TO.CHARGE"/>
      <xsl:call-template name="forex:MKTG.EXCH.PROFIT"/>
      <xsl:call-template name="forex:COMMISSION.TAKEN"/>
      <xsl:call-template name="forex:TREASURY.RATE"/>
      <xsl:call-template name="forex:CHARGE.CODE"/>
      <xsl:call-template name="forex:CHARGE.AMOUNT"/>
      <xsl:call-template name="forex:TAX.CODE"/>
      <xsl:call-template name="forex:TAX.AMOUNT"/>
      <xsl:call-template name="forex:ACCOUNT.OFFICER"/>
      <xsl:call-template name="forex:FED.FUNDS"/>
      <xsl:call-template name="forex:SEND.CONFIRMATION"/>
      <xsl:call-template name="forex:SEND.PAYMENT"/>
      <xsl:call-template name="forex:SEND.ADVICE"/>
      <xsl:call-template name="forex:CORR.AMEND.MKR"/>
      <xsl:call-template name="forex:REPLACING.DEAL.NO"/>
      <xsl:call-template name="forex:NOTES"/>
      <xsl:call-template name="forex:DEALER.NOTES"/>
      <xsl:call-template name="forex:ORIGINAL.FUNCTION"/>
      <xsl:call-template name="forex:EQV.CODE"/>
      <xsl:call-template name="forex:EQUIV.AMT"/>
      <xsl:call-template name="forex:BROKERAGE.EQUIV"/>
      <xsl:call-template name="forex:CHARGE.EQUIV"/>
      <xsl:call-template name="forex:TAX.EQUIV"/>
      <xsl:call-template name="forex:NOTIONAL.BUY.AMT"/>
      <xsl:call-template name="forex:NOTIONAL.SELL.AMT"/>
      <xsl:call-template name="forex:PORTFOLIO.NUMBER"/>
      <xsl:call-template name="forex:TOTAL.INT.BOUGHT"/>
      <xsl:call-template name="forex:TOTAL.INT.SOLD"/>
      <xsl:call-template name="forex:EQUIV.INT.BOUGHT"/>
      <xsl:call-template name="forex:EQUIV.INT.SOLD"/>
      <xsl:call-template name="forex:INT.BASIS.BOUGHT"/>
      <xsl:call-template name="forex:INT.BASIS.SOLD"/>
      <xsl:call-template name="forex:LOCAL.REF"/>
      <xsl:call-template name="forex:ORIGINATING.DEPT"/>
      <xsl:call-template name="forex:PHANTOM.IND"/>
      <xsl:call-template name="forex:CONSOL.IND"/>
      <xsl:call-template name="forex:STMT.NO"/>
      <xsl:call-template name="forex:OVERRIDE"/>
      <xsl:call-template name="forex:RECORD.STATUS"/>
      <xsl:call-template name="forex:CURR.NO"/>
      <xsl:call-template name="forex:INPUTTER"/>
      <xsl:call-template name="forex:DATE.TIME"/>
      <xsl:call-template name="forex:AUTHORISER"/>
      <xsl:call-template name="forex:CO.CODE"/>
      <xsl:call-template name="forex:DEPT.CODE"/>
      <xsl:call-template name="forex:AUDITOR.CODE"/>
      <xsl:call-template name="forex:AUDIT.DATE.TIME"/>
      <xsl:call-template name="forex:BK.TO.BK.INF"/>
      <xsl:call-template name="forex:BULK.DEAL"/>
      <xsl:call-template name="forex:BULK.REFERENCE"/>
      <xsl:call-template name="forex:AMT.BOUGHT.OS"/>
      <xsl:call-template name="forex:AMT.SOLD.OS"/>
      <xsl:call-template name="forex:DEAL.MARKET"/>
      <xsl:call-template name="forex:LINK.REFERENCE"/>
      <xsl:call-template name="forex:NETTING.STATUS"/>
      <xsl:call-template name="forex:STATUS"/>
      <xsl:call-template name="forex:MKTG.EXCH.ADJ"/>
      <xsl:call-template name="forex:AMORTISE.POSITION"/>
      <xsl:call-template name="forex:AMORTISE.FROM.DATE"/>
      <xsl:call-template name="forex:AMORTISE.CYCLE"/>
      <xsl:call-template name="forex:OPTION.CURRENCY"/>
      <xsl:call-template name="forex:OPTION.AMOUNT"/>
      <xsl:call-template name="forex:OPTION.OS.AMT"/>
      <xsl:call-template name="forex:OPTION.RATE"/>
      <xsl:call-template name="forex:DEL.CHG.ACCOUNT"/>
      <xsl:call-template name="forex:DEL.RATE"/>
      <xsl:call-template name="forex:DEL.AMOUNT.CHG"/>
      <xsl:call-template name="forex:DEL.TAX.TYPE"/>
      <xsl:call-template name="forex:DEL.TAX.AMT"/>
      <xsl:call-template name="forex:TRANSACTION.TYPE"/>
      <xsl:call-template name="forex:OPTION.TYPE"/>
      <xsl:call-template name="forex:ORG.VALBUY.DATE"/>
      <xsl:call-template name="forex:ORG.VALSEL.DATE"/>
      <xsl:call-template name="forex:OPTION.RATEDATE"/>
      <xsl:call-template name="forex:ACTIVITYCODE"/>
      <xsl:call-template name="forex:DEL.CHG.TYPE"/>
      <xsl:call-template name="forex:DEL.CHG.AMT"/>
      <xsl:call-template name="forex:DEL.CHG.LCY"/>
      <xsl:call-template name="forex:DEL.TAX.LCY"/>
      <xsl:call-template name="forex:DEL.CHG.ACC.CCY"/>
      <xsl:call-template name="forex:OS.DEL.BUY.AMT"/>
      <xsl:call-template name="forex:OS.DEL.SELL.AMT"/>
      <xsl:call-template name="forex:OS.LCY.EQUIV.AMT"/>
      <xsl:call-template name="forex:DEL.LCY.AMT"/>
      <xsl:call-template name="forex:OS.LST.LIM.BUY.EOP"/>
      <xsl:call-template name="forex:OS.LST.LIM.SEL.EOP"/>
      <xsl:call-template name="forex:OLD.INT.RATE.CALC"/>
      <xsl:call-template name="forex:SWAP.PL.FWD.POS"/>
      <xsl:call-template name="forex:REALISE.FIX.PL"/>
      <xsl:call-template name="forex:FIX.PL.REALISED"/>
      <xsl:call-template name="forex:SOD.MAT"/>
      <xsl:call-template name="forex:FX.ORDER.ID"/>
      <xsl:call-template name="forex:FX.BULK.ORDR.ID"/>
      <xsl:call-template name="forex:CLS.DEAL"/>
      <xsl:call-template name="forex:IDENTIFICATION"/>
      <xsl:call-template name="forex:DELIVERY.DETAILS"/>
      <xsl:call-template name="forex:ALLOCATION"/>
      <xsl:call-template name="forex:METAL.TYPE"/>
      <xsl:call-template name="forex:FURTHER.INDENT"/>
      <xsl:call-template name="forex:QUANTITY"/>
      <xsl:call-template name="forex:CLOSING.ID"/>
      <xsl:call-template name="forex:OPTION.RATE.ID"/>
      <xsl:call-template name="forex:LAST.DEL.ID"/>
      <xsl:call-template name="forex:TRADE.ORD.ID"/>
      <xsl:call-template name="forex:DEL.RATE.ID"/>
      <xsl:call-template name="forex:ROUNDING.RULE"/>
      <xsl:call-template name="forex:AGREEMENT.TYPE"/>
      <xsl:call-template name="forex:TERMS.AND.CONDS"/>
      <xsl:call-template name="forex:ADDL.INFO.METAL"/>
      <xsl:call-template name="forex:AVAILABILITY"/>
      <xsl:call-template name="forex:MARGIN.PIPS"/>
      <xsl:call-template name="forex:FX.GROUP.COND.ID"/>
      <xsl:call-template name="forex:MARGIN.PERC"/>
      <xsl:call-template name="forex:PVP.SETTLEMENT"/>
	  
	  <xsl:call-template name="forex:TAP.FX.COMP.ORD"/>
      <xsl:call-template name="forex:RESERVED10"/>
      <xsl:call-template name="forex:RESERVED9"/>
      <xsl:call-template name="forex:RESERVED8"/>
      <xsl:call-template name="forex:RESERVED7"/>
      <xsl:call-template name="forex:RESERVED6"/>
      <xsl:call-template name="forex:RESERVED5"/>
      <xsl:call-template name="forex:RESERVED4"/>
      <xsl:call-template name="forex:RESERVED3"/>
      <xsl:call-template name="forex:RESERVED2"/>
      <xsl:call-template name="forex:RESERVED1"/>
      <xsl:call-template name="forex:USERDEF.FIELDS"/>
	  <xsl:call-template name="forex:ModelBankSpecificFields"/>
	  <xsl:call-template name="forex:ModelBankSpecificFields-Custo"/>
   </xsl:template>
   <xsl:template name="nddeal.ND.DEAL">
      <xsl:call-template name="nddeal:TAP.REF.ID"/>
      <xsl:call-template name="nddeal:TAP.EVENT.ID"/>
      <xsl:call-template name="nddeal:TAP.OPER.NATURE"/>
      <xsl:call-template name="nddeal:TAP.FX.RATE.DIR"/>
      <xsl:call-template name="nddeal:AGREEMENT.TYPE"/>
      <xsl:call-template name="nddeal:BUY.SELL.IND"/>
      <xsl:call-template name="nddeal:COUNTERPARTY"/>
      <xsl:call-template name="nddeal:DEAL.AMOUNT"/>
      <xsl:call-template name="nddeal:DEAL.CURRENCY"/>
      <xsl:call-template name="nddeal:DEAL.DATE"/>
      <xsl:call-template name="nddeal:DEALER.DESK"/>
      <xsl:call-template name="nddeal:DEAL.NOTE"/>
      <xsl:call-template name="nddeal:FIXED.DATE"/>
      <xsl:call-template name="nddeal:NDF.TYPE"/>
      <xsl:call-template name="nddeal:NOTIONAL.SETTL.AMT"/>
      <xsl:call-template name="nddeal:PORTFOLIO.NUMBER"/>
      <xsl:call-template name="nddeal:SETTLEMENT.CCY"/>
      <xsl:call-template name="nddeal:SETTLEMENT.ACCT"/>
      <xsl:call-template name="nddeal:VALUE.DATE"/>
      <xsl:call-template name="nddeal:ACCOUNT.OFFICER"/>
      <xsl:call-template name="nddeal:ACTION.TYPE"/>
      <xsl:call-template name="nddeal:ADDL.REP.INFO"/>
      <xsl:call-template name="nddeal:ADDRESSEE"/>
      <xsl:call-template name="nddeal:AUDIT.DATE.TIME"/>
      <xsl:call-template name="nddeal:AUDITOR.CODE"/>
      <xsl:call-template name="nddeal:AUTHORISER"/>
      <xsl:call-template name="nddeal:BASE.CURRENCY"/>
      <xsl:call-template name="nddeal:BENEFICIARY.NO"/>
      <xsl:call-template name="nddeal:BENFICIARY.ADDR"/>
      <xsl:call-template name="nddeal:BILATERAL.REF"/>
      <xsl:call-template name="nddeal:BK.TO.BK"/>
      <xsl:call-template name="nddeal:BUS.DAY.SETTLEMNT"/>
      <xsl:call-template name="nddeal:BUS.DAY.VALUATION"/>
      <xsl:call-template name="nddeal:CATEGORY"/>
      <xsl:call-template name="nddeal:CENTRAL.CLG.PARTY"/>
      <xsl:call-template name="nddeal:CLG.MEMBER.ID"/>
      <xsl:call-template name="nddeal:CO.CODE"/>
      <xsl:call-template name="nddeal:COLLAT.PORT.CODE"/>
      <xsl:call-template name="nddeal:COLLAT.PORT.IND"/>
      <xsl:call-template name="nddeal:COLLATERALISATION"/>
      <xsl:call-template name="nddeal:CONF.NARR"/>
      <xsl:call-template name="nddeal:CONSOL.KEY"/>
      <xsl:call-template name="nddeal:CP.TRADE.PURPOSE"/>
      <xsl:call-template name="nddeal:CPARTY.BANK.ACC"/>
      <xsl:call-template name="nddeal:CPARTY.COR.ADD"/>
      <xsl:call-template name="nddeal:CPARTY.CORR.NO"/>
      <xsl:call-template name="nddeal:CURR.NO"/>
      <xsl:call-template name="nddeal:CURRENCY.MARKET"/>
      <xsl:call-template name="nddeal:DATE.TIME"/>
      <xsl:call-template name="nddeal:DEALER.NAME"/>
      <xsl:call-template name="nddeal:DEALER.NOTE"/>
      <xsl:call-template name="nddeal:DELIVERY.REF"/>
      <xsl:call-template name="nddeal:DEPT.CODE"/>
      <xsl:call-template name="nddeal:DISCOUNT.PERIOD"/>
      <xsl:call-template name="nddeal:DISCOUNT.PL"/>
      <xsl:call-template name="nddeal:EB.ACTIVITY"/>
      <xsl:call-template name="nddeal:EXEC.TIME.STAMP"/>
      <xsl:call-template name="nddeal:EXEC.VENUE"/>
      <xsl:call-template name="nddeal:FIXED.AMOUNT"/>
      <xsl:call-template name="nddeal:FIXED.RATE"/>
      <xsl:call-template name="nddeal:INPUTTER"/>
      <xsl:call-template name="nddeal:INTERMED.ADD"/>
      <xsl:call-template name="nddeal:INTERMED.BNK.NO"/>
      <xsl:call-template name="nddeal:LAST.UPD.DATE"/>
      <xsl:call-template name="nddeal:LIMIT.REFERENCE"/>
      <xsl:call-template name="nddeal:LINK.REFERENCE"/>
      <xsl:call-template name="nddeal:LOCAL.REF"/>
      <xsl:call-template name="nddeal:MESSAGE.CLASS"/>
      <xsl:call-template name="nddeal:MESSAGE.TYPE"/>
      <xsl:call-template name="nddeal:NDF.DEAL.NO"/>
      <xsl:call-template name="nddeal:NDF.LCY.EQUIV"/>
      <xsl:call-template name="nddeal:NDF.METHOD"/>
      <xsl:call-template name="nddeal:NET.SETTL.AMT"/>
      <xsl:call-template name="nddeal:NET.SETTL.LCY"/>
      <xsl:call-template name="nddeal:NETTING.STATUS"/>
      <xsl:call-template name="nddeal:NON.STND.FLAG"/>
      <xsl:call-template name="nddeal:NOTIONAL.RATE"/>
      <xsl:call-template name="nddeal:OC.CLG.STATUS"/>
      <xsl:call-template name="nddeal:OVERRIDE"/>
      <xsl:call-template name="nddeal:OVR.CARRIER"/>
      <xsl:call-template name="nddeal:OWN.BOOK.PORT"/>
      <xsl:call-template name="nddeal:PAYMNT.NARR"/>
      <xsl:call-template name="nddeal:PORT.COMPRESSION"/>
      <xsl:call-template name="nddeal:POSITION.TYPE"/>
      <xsl:call-template name="nddeal:PRE.UTI.ID.1"/>
      <xsl:call-template name="nddeal:PRE.UTI.ID.2"/>
      <xsl:call-template name="nddeal:PURPOSE.OF.TRAN"/>
      <xsl:call-template name="nddeal:REC.ADV.NARR"/>
      <xsl:call-template name="nddeal:RECEIVER.BNK.NO"/>
      <xsl:call-template name="nddeal:RECORD.STATUS"/>
      <xsl:call-template name="nddeal:SEND.DATE"/>
      <xsl:call-template name="nddeal:SEND.MESSAGE"/>
      <xsl:call-template name="nddeal:SETTL.INT.BASIS"/>
      <xsl:call-template name="nddeal:SETTL.INT.RATE"/>
      <xsl:call-template name="nddeal:SETTL.LCY.EQUIV"/>
      <xsl:call-template name="nddeal:SETTLEMENT.AMT"/>
      <xsl:call-template name="nddeal:SETTLEMENT.DATE"/>
      <xsl:call-template name="nddeal:STATUS"/>
      <xsl:call-template name="nddeal:STMT.NO"/>
      <xsl:call-template name="nddeal:SWIFT.COMMON.REF"/>
      <xsl:call-template name="nddeal:TRADE.REPOSITORY"/>
      <xsl:call-template name="nddeal:TT.REF.NO"/>
      <xsl:call-template name="nddeal:UNI.TRAN.ID"/>
      <xsl:call-template name="nddeal:UNIQUE.PROD.ID"/>
      <xsl:call-template name="nddeal:USERDEF.FIELDS"/>
	  <xsl:call-template name="nddeal:ModelBankSpecificFields"/>
	  <xsl:call-template name="nddeal:ModelBankSpecificFields-Custo"/>
	  <xsl:call-template name="nddeal:SETTL.RATE.SRC"/>
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