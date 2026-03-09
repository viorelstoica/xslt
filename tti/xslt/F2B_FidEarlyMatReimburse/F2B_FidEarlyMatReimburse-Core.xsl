<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
    <xsl:template name="transactionId">
        <transactionId>
            <xsl:value-of select="substring-before(b:pmsReferenceCode,'_')"/>
        </transactionId>
    </xsl:template>
	<xsl:template name="TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="translate(b:pmsReferenceCode, '_', '%')"/>
		</field>
	</xsl:template>
	<xsl:template name="ORDER.NO"/>
	<xsl:template name="CUSTOMER"/>
	<xsl:template name="FID.TYPE"/>
	<xsl:template name="CATEGORY"/>
	<xsl:template name="CURRENCY"/>
	<xsl:template name="AMOUNT"/>
	<xsl:template name="CCY.MARKET"/>
	<xsl:template name="ORDER.DATE"/>
	<xsl:template name="VALUE.DATE"/>
	<xsl:template name="MATURITY.DATE"/>
	<xsl:template name="TERM"/>
	<xsl:template name="LIMIT.REF"/>
	<xsl:template name="MARGIN.RATE"/>
	<xsl:template name="PORTFOLIO.NO"/>
	<xsl:template name="DRAWDOWN.ACCT"/>
	<xsl:template name="PRIN.LIQ.ACCT"/>
	<xsl:template name="INT.LIQ.ACCT"/>
	<xsl:template name="COMM.CHG.ACCT"/>
	<xsl:template name="ACCT.OFFICER"/>
	<xsl:template name="RENEWAL.TYPE"/>
	<xsl:template name="RENEWAL.AMT"/>
	<xsl:template name="ROUND.RENEWAL"/>
	<xsl:template name="NEXT.DRAWDOWN"/>
	<xsl:template name="NEXT.DD.MIN.BAL"/>
	<xsl:template name="NEXT.PRIN.LIQ"/>
	<xsl:template name="NEXT.INT.LIQ"/>
	<xsl:template name="NEXT.COMM.CHG"/>
	<xsl:template name="RENEWED.ORDER.ID"/>
	<xsl:template name="POOLING"/>
	<xsl:template name="POOLED.GROUP"/>
	<xsl:template name="POOLING.STATUS"/>
	<xsl:template name="SPLIT.AMOUNT"/>
	<xsl:template name="SPLIT.ORDER.ID"/>
	<xsl:template name="COMM.TYPE"/>
	<xsl:template name="DEF.COMM.AMT"/>
	<xsl:template name="DEF.COMM.RATE"/>
	<xsl:template name="COMM.RATE"/>
	<xsl:template name="COMM.AMOUNT"/>
	<xsl:template name="COMM.TAKEN"/>
	<xsl:template name="COMM.BASIS"/>
	<xsl:template name="CHARGE.DATE"/>
	<xsl:template name="CHARGE.EVENT"/>
	<xsl:template name="CHARGE.TYPE"/>
	<xsl:template name="DEF.CHG.AMT"/>
	<xsl:template name="CHG.AMOUNT"/>
	<xsl:template name="TAX.CODE.COMM"/>
	<xsl:template name="TAX.AMT.COMM"/>
	<xsl:template name="TAX.AMT.COMM.LCY"/>
	<xsl:template name="TAX.COMM.XRATE"/>
	<xsl:template name="TAX.CHG.DATE"/>
	<xsl:template name="TAX.CODE.CHG"/>
	<xsl:template name="TAX.AMT.CHG"/>
	<xsl:template name="TAX.LAMT.CHG"/>
	<xsl:template name="TAX.CHG.XRTE"/>
	<xsl:template name="FIDUCIARY.NO"/>
	<xsl:template name="COMMITTED.INT"/>
	<xsl:template name="INTEREST.RATE"/>
	<xsl:template name="INT.DAY.BASIS"/>
	<xsl:template name="INTEREST.PAY.DATE"/>
	<xsl:template name="WITHOLD.TAX.CODE"/>
	<xsl:template name="WITHOLD.TAX.AMT"/>
	<xsl:template name="CUSTOMER.REF"/>
	<xsl:template name="CUST.REMARKS">
		<field name="CUST.REMARKS">
			<xsl:value-of select="b:remark"/>
		</field>
	</xsl:template>
	<xsl:template name="DEALER.INSTR"/>
	<xsl:template name="ACCT.OFF.NOTES"/>
	<xsl:template name="PRIN.CHANGE">
		<xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '116'">
			<field name="PRIN.CHANGE">
				<xsl:value-of select="format-number( -1* (b:depositAmount),$decimalformat,'nan2zero')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="CHANGE.DATE">
        <xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '116'">
	        <field name="CHANGE.DATE">
	            <xsl:value-of select="translate(b:valueDate,'-','')"/>
	        </field>
        </xsl:if>	
	</xsl:template>
	<xsl:template name="CHANGE.STATUS"/>
	<xsl:template name="REIMBURSE.DATE"/>
	<xsl:template name="REIMBURSE.STATUS"/>
	<xsl:template name="REIMBURSE.REQ">
		<xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '116'">
			<field name="REIMBURSE.REQ">
				<xsl:value-of select="'YES'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ORDER.STATUS"/>
	<xsl:template name="GROUP.COND.NO"/>
	<xsl:template name="REPLACE.ORDER"/>
	<xsl:template name="REPLACED.BY"/>
	<xsl:template name="FORWARD.BACKWARD"/>
	<xsl:template name="RATE.CATEG"/>
	<xsl:template name="RATE.MARGIN"/>
	<xsl:template name="RATE.DEV.CODE"/>
	<xsl:template name="BID.RATE"/>
	<xsl:template name="FID.SUBTYPE"/>
	<xsl:template name="FID.BANK"/>
	<xsl:template name="POOLING.NOTICE"/>
	<xsl:template name="RESERVED.4"/>
	<xsl:template name="RESERVED.3"/>
	<xsl:template name="RESERVED.2"/>
	<xsl:template name="RESERVED.1"/>
	<xsl:template name="CONSOL.KEY"/>
	<xsl:template name="LOCAL.REF"/>
	<xsl:template name="PRINT.DEAL.SLIP"/>
	<xsl:template name="SEND.CONFIRM"/>
	<xsl:template name="ACTIVITY.CODE"/>
	<xsl:template name="DELIVERY.REF"/>
	<xsl:template name="EARLY.MAT.DATE">
		<xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '117'">
			<field name="EARLY.MAT.DATE">
				<xsl:value-of select="translate(b:valueDate,'-','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="EARLY.ORIG.DATE"/>
	<xsl:template name="EARLY.INT.RATE"/>
	<xsl:template name="EARLY.ORIG.RATE"/>
	<xsl:template name="EARLY.STATUS"/>
	<xsl:template name="PEN.COMM.TYPE">
		<xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '117' and $FD_EARLY_MAT_PENALTY_TYPE !='' and $FD_EARLY_MAT_PENALTY_TYPE">
			<field name="PEN.COMM.TYPE">
				<xsl:value-of select="$FD_EARLY_MAT_PENALTY_TYPE"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="DEF.PEN.COMM.AMT"/>
	<xsl:template name="DEF.PEN.COMM.RATE"/>
	<xsl:template name="PEN.COMM.AMT">
        <xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '117' and $FD_EARLY_MAT_PENALTY_TYPE !='' and $FD_EARLY_MAT_PENALTY_TYPE">
            <field name="PEN.COMM.AMT">
                <xsl:value-of select="translate(b:userDefinedField[infra:name='bp_4_amount_m']/infra:value,',','')"/>
            </field>
        </xsl:if>   	
	</xsl:template>
	<xsl:template name="PEN.COMM.RATE"/>
	<xsl:template name="SETTLEMENT.MARKET"/>
	<xsl:template name="XRATE.TYPE"/>
	<xsl:template name="EXCG.RATE"/>
	<xsl:template name="RESERVED.7"/>
	<xsl:template name="RESERVED.6"/>
	<xsl:template name="STMT.NOS"/>
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
	<xsl:template name="CUS.PORT.ID"/>
	<xsl:template name="ModelBankSpecificFields"/>
	<xsl:template name="ModelBankSpecificFields-Custo"/>
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