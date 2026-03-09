<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">

    <xsl:template name="ID">
        <transactionId>
            <xsl:value-of select="substring(b:pmsReferenceCode, 1, string-length(b:pmsReferenceCode) - 4)"/>
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

	<xsl:template name="CUSTOMER">
		<field name="CUSTOMER">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_client']/infra:value"/>
		</field>
	</xsl:template>
	<xsl:template name="FID.TYPE">
		<field name="FID.TYPE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '117'">
					<xsl:value-of select="'FIXED'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '116'">
					<xsl:value-of select="'NOTICE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="CATEGORY"/>
	<xsl:template name="CURRENCY">
		<field name="CURRENCY">
			<xsl:value-of select="b:depositCurrency/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="AMOUNT">
		<field name="AMOUNT">
			<xsl:value-of select="b:depositAmount"/>
		</field>
	</xsl:template>
	<xsl:template name="CCY.MARKET"/>
	<xsl:template name="ORDER.DATE">
		<field name="ORDER.DATE">
			<xsl:value-of select="translate(b:transactionDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="VALUE.DATE">
		<field name="VALUE.DATE">
			<xsl:value-of select="translate(b:valueDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="MATURITY.DATE">
		<field name="MATURITY.DATE">
			<xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '116'">
				<xsl:value-of select="b:userDefinedField[infra:name='ud_instr_notice_day_n']/infra:value"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="TERM">
        <field name="TERM">
               <xsl:if test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '117'">
	               <xsl:value-of select="b:contractLength"/>                 
                   <xsl:choose>
		                <xsl:when test="b:contractLengthUnit = 1"> <!-- Days, business days are not supported and not expected -->
	                           <xsl:value-of select="'D'"/>
		                </xsl:when>
                       <xsl:when test="b:contractLengthUnit = 2">
                           <xsl:value-of select="'W'"/>
                       </xsl:when>
                       <xsl:when test="b:contractLengthUnit = 3">
                           <xsl:value-of select="'M'"/>
                       </xsl:when>                                                                   
	            	</xsl:choose>                      
               </xsl:if>
        </field>		
	</xsl:template>
	<xsl:template name="LIMIT.REF"/>
	<xsl:template name="MARGIN.RATE"/>
	<xsl:template name="PORTFOLIO.NO">
		<field name="PORTFOLIO.NO">
			<xsl:value-of select="substring(b:portfolio/infra:code, string-length(b:portfolio/infra:code), 1)"/>
		</field>
	</xsl:template>
	<xsl:template name="DRAWDOWN.ACCT">
		<field name="DRAWDOWN.ACCT">
			<xsl:value-of select="b:account/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="PRIN.LIQ.ACCT">
		<field name="PRIN.LIQ.ACCT">
			<xsl:value-of select="b:account/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="INT.LIQ.ACCT">
		<field name="INT.LIQ.ACCT">
			<xsl:value-of select="b:account/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="COMM.CHG.ACCT">
		<field name="COMM.CHG.ACCT">
			<xsl:value-of select="b:account/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="ACCT.OFFICER"/>
	<xsl:template name="RENEWAL.TYPE">
		<field name="RENEWAL.TYPE">
			<xsl:choose>
				<xsl:when test="b:renewalMode = '0'">
					<xsl:value-of select="'NONE'"/>
				</xsl:when>
				<xsl:when test="b:renewalMode = '1'">
					<xsl:value-of select="$FD_T24_RENEWAL_MODE"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="RENEWAL.AMT">
		<xsl:choose>
			<xsl:when test="b:renewalTreatment = '0'">
			</xsl:when>
			<xsl:when test="b:renewalTreatment = '1'">
				<field name="RENEWAL.AMT">
					<xsl:value-of select="'PRINCIPAL'"/>
				</field>
			</xsl:when>
			<xsl:when test="b:renewalTreatment = '2'">
				<field name="RENEWAL.AMT">
					<xsl:value-of select="'INCOME'"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="ORDER.NO"/>
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
	<xsl:template name="INTEREST.RATE">
		<field name="INTEREST.RATE">
	   		<xsl:value-of select="b:depositInterestRate"/>
	   	</field>
	</xsl:template>
	<xsl:template name="INT.DAY.BASIS"/>
	<xsl:template name="INTEREST.PAY.DATE"/>
	<xsl:template name="WITHOLD.TAX.CODE"/>
	<xsl:template name="WITHOLD.TAX.AMT"/>
	<xsl:template name="CUSTOMER.REF"/>
	<xsl:template name="CUST.REMARKS"/>
	<xsl:template name="DEALER.INSTR"/>
	<xsl:template name="ACCT.OFF.NOTES"/>
	<xsl:template name="PRIN.CHANGE"/>
	<xsl:template name="CHANGE.DATE"/>
	<xsl:template name="CHANGE.STATUS"/>
	<xsl:template name="REIMBURSE.DATE"/>
	<xsl:template name="REIMBURSE.STATUS"/>
	<xsl:template name="REIMBURSE.REQ"/>
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
	<xsl:template name="FID.BANK">
	   <xsl:if test="$FD_F2B_SET_COUNTERPARTY = 'Y'">
	       <field name="FID.BANK">
                    <xsl:value-of select="b:counterparty/infra:code"/>
           </field>
	   </xsl:if>
	</xsl:template>
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
	<xsl:template name="EARLY.MAT.DATE"/>
	<xsl:template name="EARLY.ORIG.DATE"/>
	<xsl:template name="EARLY.INT.RATE"/>
	<xsl:template name="EARLY.ORIG.RATE"/>
	<xsl:template name="EARLY.STATUS"/>
	<xsl:template name="PEN.COMM.TYPE"/>
	<xsl:template name="DEF.PEN.COMM.AMT"/>
	<xsl:template name="DEF.PEN.COMM.RATE"/>
	<xsl:template name="PEN.COMM.AMT"/>
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
	<xsl:template name="USERDEF.FIELDS"/>
</xsl:stylesheet>