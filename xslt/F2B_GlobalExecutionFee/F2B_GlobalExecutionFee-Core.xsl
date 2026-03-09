<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:scexesecorders="http://www.temenos.com/T24/scexesecorders"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<!-- SC.EXE.SEC.ORDERS section -->
	<xsl:template name="scexesecorders:transactionId">
		<transactionId>
			<xsl:value-of select="b:sourceSystemCode"/>
		</transactionId>
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
	<xsl:template name="scexesecorders:CUST.ACC.NO"/>
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
	<xsl:template name="scexesecorders:NARRATIVE"/>
	<xsl:template name="scexesecorders:CU.INCOME.ACC"/>
	<xsl:template name="scexesecorders:CU.INCOME.CCY"/>
	<xsl:template name="scexesecorders:BROKER.NO"/>
	<xsl:template name="scexesecorders:BROKER.TYPE"/>
	<xsl:template name="scexesecorders:BR.ACC.NO"/>
	<xsl:template name="scexesecorders:BR.SEC.ACCT"/>
	<xsl:template name="scexesecorders:NOMINAL.RECD"/>
	<xsl:template name="scexesecorders:PRICE"/>
	<xsl:template name="scexesecorders:RESERVED5"/>
	<xsl:template name="scexesecorders:BR.BROKER.COMM"/>
	<xsl:template name="scexesecorders:BR.FOREIGN.FEE"/>
	<xsl:template name="scexesecorders:CL.COMMISSION"/>
	<xsl:template name="scexesecorders:BR.STAMP.TAX"/>
	<xsl:template name="scexesecorders:BR.EBV.FEES"/>
	<xsl:template name="scexesecorders:BR.FEES.MISC"/>
	<xsl:template name="scexesecorders:BR.EX.RATE.ACC"/>
	<xsl:template name="scexesecorders:BR.ACCOUNT.CCY"/>
	<xsl:template name="scexesecorders:DELIVERY.INSTR"/>
	<xsl:template name="scexesecorders:TRADE.TIME"/>
	<xsl:template name="scexesecorders:BR.EXE.ADV.REF"/>
	<xsl:template name="scexesecorders:BR.TR.AL.REF"/>
	<xsl:template name="scexesecorders:BR.RESERVED.03"/>
	<xsl:template name="scexesecorders:BR.RESERVED.02"/>
	<xsl:template name="scexesecorders:BR.RESERVED.01"/>
	<xsl:template name="scexesecorders:TRADE.DATE"/>
	<xsl:template name="scexesecorders:VALUE.DATE"/>
	<xsl:template name="scexesecorders:DEPOSITORY"/>
	<xsl:template name="scexesecorders:STOCK.EXCHANGE"/>
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
	<xsl:template name="scexesecorders:TAP.SLEEVE.ACC"/>
	<xsl:template name="scexesecorders:TAP.SLEEVE.PTF"/>
	<xsl:template name="scexesecorders:TAP.REF.ID">
		<field name="TAP.REF.ID">
        	<xsl:value-of select="b:pmsOrderReference"/>
        </field>
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