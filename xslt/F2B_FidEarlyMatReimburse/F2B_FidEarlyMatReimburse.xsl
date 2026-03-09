<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B_MM_FX/b:DataGroup/b:DepositLoan/b:Deposit/b:OrderLifeCycle/b:closingRequest">
				<T24 xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
					<serviceRequest xmlns="http://www.temenos.com/T24/OFSML/150">
						<securityContext>
							<xsl:if test="b:ownerBusinessEntity and b:ownerBusinessEntity != ''">
								<company>
									<xsl:value-of select="b:ownerBusinessEntity"/>
								</company>
							</xsl:if>
						</securityContext>
						<ofsTransactionInput application="FD.FID.ORDER" operation="PROCESS" version="{$FD_OPEN_CONTRACT_VERSION}">
							<xsl:call-template name="FD.FID.ORDER"/>
						</ofsTransactionInput>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="FD.FID.ORDER">
        <xsl:call-template name="transactionId"/>	
		<xsl:call-template name="TAP.EVENT.ID"/>
		<xsl:call-template name="TAP.REF.ID"/>
		<xsl:call-template name="ORDER.NO"/>
		<xsl:call-template name="CUSTOMER"/>
		<xsl:call-template name="FID.TYPE"/>
		<xsl:call-template name="CATEGORY"/>
		<xsl:call-template name="CURRENCY"/>
		<xsl:call-template name="AMOUNT"/>
		<xsl:call-template name="CCY.MARKET"/>
		<xsl:call-template name="ORDER.DATE"/>
		<xsl:call-template name="VALUE.DATE"/>
		<xsl:call-template name="MATURITY.DATE"/>
		<xsl:call-template name="TERM"/>
		<xsl:call-template name="LIMIT.REF"/>
		<xsl:call-template name="MARGIN.RATE"/>
		<xsl:call-template name="PORTFOLIO.NO"/>
		<xsl:call-template name="DRAWDOWN.ACCT"/>
		<xsl:call-template name="PRIN.LIQ.ACCT"/>
		<xsl:call-template name="INT.LIQ.ACCT"/>
		<xsl:call-template name="COMM.CHG.ACCT"/>
		<xsl:call-template name="ACCT.OFFICER"/>
		<xsl:call-template name="RENEWAL.TYPE"/>
		<xsl:call-template name="RENEWAL.AMT"/>
		<xsl:call-template name="ROUND.RENEWAL"/>
		<xsl:call-template name="NEXT.DRAWDOWN"/>
		<xsl:call-template name="NEXT.DD.MIN.BAL"/>
		<xsl:call-template name="NEXT.PRIN.LIQ"/>
		<xsl:call-template name="NEXT.INT.LIQ"/>
		<xsl:call-template name="NEXT.COMM.CHG"/>
		<xsl:call-template name="RENEWED.ORDER.ID"/>
		<xsl:call-template name="POOLING"/>
		<xsl:call-template name="POOLED.GROUP"/>
		<xsl:call-template name="POOLING.STATUS"/>
		<xsl:call-template name="SPLIT.AMOUNT"/>
		<xsl:call-template name="SPLIT.ORDER.ID"/>
		<xsl:call-template name="COMM.TYPE"/>
		<xsl:call-template name="DEF.COMM.AMT"/>
		<xsl:call-template name="DEF.COMM.RATE"/>
		<xsl:call-template name="COMM.RATE"/>
		<xsl:call-template name="COMM.AMOUNT"/>
		<xsl:call-template name="COMM.TAKEN"/>
		<xsl:call-template name="COMM.BASIS"/>
		<xsl:call-template name="CHARGE.DATE"/>
		<xsl:call-template name="CHARGE.EVENT"/>
		<xsl:call-template name="CHARGE.TYPE"/>
		<xsl:call-template name="DEF.CHG.AMT"/>
		<xsl:call-template name="CHG.AMOUNT"/>
		<xsl:call-template name="TAX.CODE.COMM"/>
		<xsl:call-template name="TAX.AMT.COMM"/>
		<xsl:call-template name="TAX.AMT.COMM.LCY"/>
		<xsl:call-template name="TAX.COMM.XRATE"/>
		<xsl:call-template name="TAX.CHG.DATE"/>
		<xsl:call-template name="TAX.CODE.CHG"/>
		<xsl:call-template name="TAX.AMT.CHG"/>
		<xsl:call-template name="TAX.LAMT.CHG"/>
		<xsl:call-template name="TAX.CHG.XRTE"/>
		<xsl:call-template name="FIDUCIARY.NO"/>
		<xsl:call-template name="COMMITTED.INT"/>
		<xsl:call-template name="INTEREST.RATE"/>
		<xsl:call-template name="INT.DAY.BASIS"/>
		<xsl:call-template name="INTEREST.PAY.DATE"/>
		<xsl:call-template name="WITHOLD.TAX.CODE"/>
		<xsl:call-template name="WITHOLD.TAX.AMT"/>
		<xsl:call-template name="CUSTOMER.REF"/>
		<xsl:call-template name="CUST.REMARKS"/>
		<xsl:call-template name="DEALER.INSTR"/>
		<xsl:call-template name="ACCT.OFF.NOTES"/>
		<xsl:call-template name="PRIN.CHANGE"/>
		<xsl:call-template name="CHANGE.DATE"/>
		<xsl:call-template name="CHANGE.STATUS"/>
		<xsl:call-template name="REIMBURSE.DATE"/>
		<xsl:call-template name="REIMBURSE.STATUS"/>
		<xsl:call-template name="REIMBURSE.REQ"/>
		<xsl:call-template name="ORDER.STATUS"/>
		<xsl:call-template name="GROUP.COND.NO"/>
		<xsl:call-template name="REPLACE.ORDER"/>
		<xsl:call-template name="REPLACED.BY"/>
		<xsl:call-template name="FORWARD.BACKWARD"/>
		<xsl:call-template name="RATE.CATEG"/>
		<xsl:call-template name="RATE.MARGIN"/>
		<xsl:call-template name="RATE.DEV.CODE"/>
		<xsl:call-template name="BID.RATE"/>
		<xsl:call-template name="FID.SUBTYPE"/>
		<xsl:call-template name="FID.BANK"/>
		<xsl:call-template name="POOLING.NOTICE"/>
		<xsl:call-template name="RESERVED.4"/>
		<xsl:call-template name="RESERVED.3"/>
		<xsl:call-template name="RESERVED.2"/>
		<xsl:call-template name="RESERVED.1"/>
		<xsl:call-template name="CONSOL.KEY"/>
		<xsl:call-template name="LOCAL.REF"/>
		<xsl:call-template name="PRINT.DEAL.SLIP"/>
		<xsl:call-template name="SEND.CONFIRM"/>
		<xsl:call-template name="ACTIVITY.CODE"/>
		<xsl:call-template name="DELIVERY.REF"/>
		<xsl:call-template name="EARLY.MAT.DATE"/>
		<xsl:call-template name="EARLY.ORIG.DATE"/>
		<xsl:call-template name="EARLY.INT.RATE"/>
		<xsl:call-template name="EARLY.ORIG.RATE"/>
		<xsl:call-template name="EARLY.STATUS"/>
		<xsl:call-template name="PEN.COMM.TYPE"/>
		<xsl:call-template name="DEF.PEN.COMM.AMT"/>
		<xsl:call-template name="DEF.PEN.COMM.RATE"/>
		<xsl:call-template name="PEN.COMM.AMT"/>
		<xsl:call-template name="PEN.COMM.RATE"/>
		<xsl:call-template name="SETTLEMENT.MARKET"/>
		<xsl:call-template name="XRATE.TYPE"/>
		<xsl:call-template name="EXCG.RATE"/>
		<xsl:call-template name="RESERVED.7"/>
		<xsl:call-template name="RESERVED.6"/>
		<xsl:call-template name="STMT.NOS"/>
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
		<xsl:call-template name="CUS.PORT.ID"/>
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