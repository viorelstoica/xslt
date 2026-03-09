<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:paymentorder="http://www.temenos.com/T24/paymentorder" exclude-result-prefixes="b"
                version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B_MM_FX/b:DataGroup/b:Cash/b:OrderLifeCycle/b:InvestmentRequest">
				<T24 xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
					<serviceRequest xmlns="http://www.temenos.com/T24/OFSML/150">
						<securityContext>
							<xsl:if test="b:ownerBusinessEntity and b:ownerBusinessEntity != ''">
								<company>
									<xsl:value-of select="b:ownerBusinessEntity"/>
								</company>
							</xsl:if>
						</securityContext>
						<ofsTransactionInput application="PAYMENT.ORDER" operation="PROCESS" version="{$PAYMENT_ORDER_VERSION}">
							<xsl:call-template name="PAYMENT.ORDER"/>
						</ofsTransactionInput>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="PAYMENT.ORDER">
		<xsl:call-template name="TAP.EVENT.ID"/>
		<xsl:call-template name="TAP.REF.ID"/>
		<xsl:call-template name="TAP.OPER.NATURE"/>
		<xsl:call-template name="ID"/>
		<xsl:call-template name="PAYMENT.ORDER.PRODUCT"/>
		<xsl:call-template name="ORDERING.COMPANY"/>
		<xsl:call-template name="ORDERING.CUSTOMER"/>
		<xsl:call-template name="ORDERING.CUSTOMER.BIC"/>
		<xsl:call-template name="ORDERING.CUST.NAME"/>
		<xsl:call-template name="ORDERING.PORTFOLIO"/>
		<xsl:call-template name="DEBIT.ACCOUNT"/>
		<xsl:call-template name="DEBIT.CCY"/>
		<xsl:call-template name="DEBIT.ACCOUNT.IBAN"/>
		<xsl:call-template name="DEBIT.PL"/>
		<xsl:call-template name="DEBIT.VALUE.DATE"/>
		<xsl:call-template name="ORDERING.REFERENCE"/>
		<xsl:call-template name="SIGNATORY"/>
		<xsl:call-template name="BENEFICIARY.ID"/>
		<xsl:call-template name="CREDIT.PORTFOLIO"/>
		<xsl:call-template name="CREDIT.PL"/>
		<xsl:call-template name="BENEFICIARY.IBAN"/>
		<xsl:call-template name="BENEFICIARY.NAME"/>
		<xsl:call-template name="BENEFICIARY.COUNTRY.CODE"/>
		<xsl:call-template name="INTERMED.BANK.IBAN"/>
		<xsl:call-template name="PAYMENT.CURRENCY"/>
		<xsl:call-template name="PAYMENT.AMOUNT"/>
		<xsl:call-template name="REQUESTED.CURRENCY"/>
		<xsl:call-template name="REQUESTED.AMOUNT"/>
		<xsl:call-template name="PAYMENT.EXECUTION.DATE"/>
		<xsl:call-template name="REQUIRED.CREDIT.VALUE.DATE"/>
		<xsl:call-template name="REGULATORY.REPORT"/>
		<xsl:call-template name="MESSAGE.PRIORITY"/>
		<xsl:call-template name="BANK.TO.BANK.INFO"/>
		<xsl:call-template name="PAYMENT.PURPOSE"/>
		<xsl:call-template name="INVOICE.REFERENCE"/>
		<xsl:call-template name="STRUCTURED.COMMUNICATION.CODE"/>
		<xsl:call-template name="STRUCTURED.ISSUER"/>
		<xsl:call-template name="STRUCTURED.CREDITOR.REFERENCE"/>
		<xsl:call-template name="END.TO.END.REFERENCE"/>
		<xsl:call-template name="CHARGE.BEARER"/>
		<xsl:call-template name="WAIVE.ALL.CHARGES"/>
		<xsl:call-template name="PAY.REQ.FX.CUST.RATE"/>
		<xsl:call-template name="PAY.REQ.FX.SPREAD"/>
		<xsl:call-template name="PAY.REQ.TREASURY.RATE"/>
		<xsl:call-template name="ORDERING.PAYMENT.FX.CUST.RATE"/>
		<xsl:call-template name="ORDERING.PAYMENT.FX.SPREAD"/>
		<xsl:call-template name="ORDERING.PAYMENT.TREASURY.RATE"/>
		<xsl:call-template name="CURRENCY.MARKET"/>
		<xsl:call-template name="INTERNAL.ORDER.DETAILS"/>
		<xsl:call-template name="INTERNAL.STATUS"/>
		<xsl:call-template name="ORDER.EXECUTION.DATE.TIME"/>
		<xsl:call-template name="PAYMENT.SYSTEM.STATUS"/>
		<xsl:call-template name="STATE.HIST"/>
		<xsl:call-template name="LOCAL.REF"/>
		<xsl:call-template name="RECORD.STATUS"/>
		<xsl:call-template name="CURR.NO"/>
		<xsl:call-template name="INPUTTER"/>
		<xsl:call-template name="DATE.TIME"/>
		<xsl:call-template name="AUTHORISER"/>
		<xsl:call-template name="CO.CODE"/>
		<xsl:call-template name="DEPT.CODE"/>
		<xsl:call-template name="AUDITOR.CODE"/>
		<xsl:call-template name="AUDIT.DATE.TIME"/>
		<xsl:call-template name="NARRATIVE"/>
		<xsl:call-template name="TERMS.AND.CONDITIONS"/>
		<xsl:call-template name="ADDITIONAL.INFO"/>
		<xsl:call-template name="OVERRIDE"/>
		<xsl:call-template name="BEN.BANK.CLEARING.CODE"/>
		<xsl:call-template name="INDICATIVE.RATE"/>
		<xsl:call-template name="ORDERING.POST.ADDRESS.TYPE"/>
		<xsl:call-template name="ORDERING.POST.SWIFT.ADDR"/>
		<xsl:call-template name="ORDERING.POST.ADDR.LINE"/>
		<xsl:call-template name="CREDIT.ACCOUNT"/>
		<xsl:call-template name="CREDIT.ACCOUNT.IBAN"/>
		<xsl:call-template name="BENEFICIARY.ACCOUNT.NO"/>
		<xsl:call-template name="BEN.POST.ADDRESS.TYPE"/>
		<xsl:call-template name="BEN.POST.SWIFT.ADDR"/>
		<xsl:call-template name="BEN.POST.ADDR.LINE"/>
		<xsl:call-template name="ACCT.WITH.BANK.IBAN"/>
		<xsl:call-template name="ACCT.WITH.BANK.BIC"/>
		<xsl:call-template name="ACCT.WITH.BANK.POST.ADDR.TYPE"/>
		<xsl:call-template name="ACCT.WITH.BANK.SWIFT.ADDR"/>
		<xsl:call-template name="ACCT.WITH.BANK.RESERVED.3"/>
		<xsl:call-template name="ACCT.WITH.BANK.RESERVED.2"/>
		<xsl:call-template name="ACCT.WITH.BANK.RESERVED.1"/>
		<xsl:call-template name="INTERMED.BIC"/>
		<xsl:call-template name="INTERMED.BANK.CUSTOMER"/>
		<xsl:call-template name="INTERMED.BANK.POSTAL.ADDR.TYPE"/>
		<xsl:call-template name="INTERMED.SWIFT.ADDR"/>
		<xsl:call-template name="INTERMED.POSTAL.ADDR.LINE"/>
		<xsl:call-template name="INSTRUCTION.ID.REF"/>
		<xsl:call-template name="CLEARING.CHANNEL"/>
		<xsl:call-template name="BENEFICIARY.BIC"/>
		<xsl:call-template name="BENEFICIARY.CUSTOMER"/>
		<xsl:call-template name="ACCT.WITH.BANK.CUSTOMER"/>
		<xsl:call-template name="ACCT.WITH.BANK.CLEARING.CODE"/>
		<xsl:call-template name="INTERMED.BANK.CLEARING.CODE"/>
		<xsl:call-template name="INTERMED.BANK.RESERVED.3"/>
		<xsl:call-template name="INTERMED.BANK.RESERVED.2"/>
		<xsl:call-template name="INTERMED.BANK.RESERVED.1"/>
		<xsl:call-template name="REMITTANCE.INFORMATION"/>
		<xsl:call-template name="PAYMENT.SYSTEM.ID"/>
		<xsl:call-template name="PAYMENT.STATUS.UPDATE.DATE"/>
		<xsl:call-template name="ORDER.INITIATION.TYPE"/>
		<xsl:call-template name="BEN.IDENTIFIER"/>
		<xsl:call-template name="ACCT.WITH.BANK.IDENTIFIER"/>
		<xsl:call-template name="INTERMED.BANK.IDENTIFIER"/>
		<xsl:call-template name="ACCT.WITH.BANK.COUNTRY"/>
		<xsl:call-template name="INTERMED.BANK.COUNTRY"/>
		<xsl:call-template name="PAYMENT.CATEGORY"/>
		<xsl:call-template name="PAYMENT.METHOD"/>
		<xsl:call-template name="ORDER.TYPE"/>
		<xsl:call-template name="INITIATOR.NAME"/>
		<xsl:call-template name="INITIATOR.BIC"/>
		<xsl:call-template name="INITIATOR.POST.ADDR.TYPE"/>
		<xsl:call-template name="INITIATOR.SWIFT.ADDRESS"/>
		<xsl:call-template name="INITIATOR.POST.ADDR.LINE"/>
		<xsl:call-template name="DEBTOR.AGENT.NAME"/>
		<xsl:call-template name="DEBTOR.AGENT.BIC"/>
		<xsl:call-template name="DEBTOR.AGENT.ADDR.TYPE"/>
		<xsl:call-template name="DEBTOR.AGENT.ADDR.LINE"/>
		<xsl:call-template name="DEBTOR.AGENT.CLEARING.CODE"/>
		<xsl:call-template name="DEBTOR.AGENT.IDENTIFIER"/>
		<xsl:call-template name="DEBTOR.AGENT.RESERVED.5"/>
		<xsl:call-template name="DEBTOR.AGENT.RESERVED.4"/>
		<xsl:call-template name="DEBTOR.AGENT.RESERVED.3"/>
		<xsl:call-template name="DEBTOR.AGENT.RESERVED.2"/>
		<xsl:call-template name="DEBTOR.AGENT.RESERVED.1"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.NAME"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.ADDR.TYPE"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.ADDR.LINE"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.BIC"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.COUNTRY"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.NAME"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.ADDR.TYPE"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.BIC"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.COUNTRY"/>
		<xsl:call-template name="INSTRUCTION.CODE"/>
		<xsl:call-template name="INSTRUCTION.CODE.TEXT"/>
		<xsl:call-template name="PYMT.INFO.SER.LEVEL.CODE"/>
		<xsl:call-template name="CURRENT.STATE"/>
		<xsl:call-template name="PAYMENT.SYSTEM"/>
		<xsl:call-template name="CHARGE.ACCOUNT"/>
		<xsl:call-template name="CHARGE.ACCOUNT.CCY"/>
		<xsl:call-template name="CHARGE.TYPE"/>
		<xsl:call-template name="CHARGE.DESCRIPTION"/>
		<xsl:call-template name="CHARGE.CURRENCY"/>
		<xsl:call-template name="CHARGE.AMOUNT"/>
		<xsl:call-template name="CHARGE.AC.CCY.AMOUNT"/>
		<xsl:call-template name="CREDIT.VALUE.DATE"/>
		<xsl:call-template name="CUT.OFF.TIME"/>
		<xsl:call-template name="PSD.COMPLIANT"/>
		<xsl:call-template name="LAST.TC.SIM.TIME"/>
		<xsl:call-template name="TC.SIM.CHECKED"/>
		<xsl:call-template name="CONTEXT.NAME"/>
		<xsl:call-template name="CONTEXT.VALUE"/>
		<xsl:call-template name="SUBMIT.ORDER"/>
		<xsl:call-template name="TOTAL.DEBIT.AMOUNT"/>
		<xsl:call-template name="STATUS.REASON.CODE"/>
		<xsl:call-template name="ACCT.WITH.BANK.POST.ADDR.LN"/>
		<xsl:call-template name="INT.OVERRIDE.ID"/>
		<xsl:call-template name="INT.OVERRIDE.VAL"/>
		<xsl:call-template name="ACTIVITY.CODE"/>
		<xsl:call-template name="MESSAGE.TYPE"/>
		<xsl:call-template name="DELIVERY.REF"/>
		<xsl:call-template name="ULTIMATE.CRED.ADDR.LN"/>
		<xsl:call-template name="ORDERING.CUSTOMER.SSI"/>
		<xsl:call-template name="PAYMENT.STATUS.ADD.INFO"/>
		<xsl:call-template name="PAYMENT.COMPLETE"/>
		<xsl:call-template name="MANUAL.PAYMENT.STATUS"/>
		<xsl:call-template name="MANUAL.PAY.STATUS.ADD.INFO"/>
		<xsl:call-template name="MANUAL.COMPLETE"/>
		<xsl:call-template name="MANUAL.STATUS.UPDATE.DATE"/>
		<xsl:call-template name="LOCAL.INSTR.CODE"/>
		<xsl:call-template name="INIT.OTHER.ID.TYPE"/>
		<xsl:call-template name="INIT.OTHER.ID"/>
		<xsl:call-template name="FRAUD.CHECK.INDICATOR"/>
		<xsl:call-template name="AC.FUNDS.AUTH.ID"/>
		<xsl:call-template name="LOCKED.EVENT.ID"/>
		<xsl:call-template name="LOCAL.INSTR.PROP"/>
		<xsl:call-template name="INITIAL.PRODUCT"/>
		<xsl:call-template name="ONUS.INDICATOR"/>
		<xsl:call-template name="ORD.ACCOUNT.LOCATION"/>
		<xsl:call-template name="ORD.ACCOUNT.VALIDATED"/>
		<xsl:call-template name="BEN.ACCOUNT.LOCATION"/>
		<xsl:call-template name="BEN.ACCOUNT.VALIDATED"/>
		<xsl:call-template name="CHEQUE.NUMBER"/>
		<xsl:call-template name="ISSUE.CHEQUE.TYPE"/>
		<xsl:call-template name="STOCK.REGISTER.ID"/>
		<xsl:call-template name="STOCK.SERIES.ID"/>
		<xsl:call-template name="BENEFICIARY.DOB"/>
		<xsl:call-template name="BENEFICIARY.BR.PRVNC"/>
		<xsl:call-template name="BENEFICIARY.BR.CITY"/>
		<xsl:call-template name="BENEFICIARY.BR.COUNTRY"/>
		<xsl:call-template name="BENEFICIARY.OT.ID.TYPE"/>
		<xsl:call-template name="ACCT.WITH.BANK.ACC"/>
		<xsl:call-template name="INTERMED.BANK.ACC"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.DOB"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.BR.PRVNC"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.BR.CITY"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.BR.COUNTRY"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.OT.ID.TYPE"/>
		<xsl:call-template name="BENEFICIARY.OT.ID"/>
		<xsl:call-template name="BENEFICIARY.SCHME.CDE"/>
		<xsl:call-template name="BENEFICIARY.SCH.PRTY"/>
		<xsl:call-template name="BENEFICIARY.SCH.ISSUR"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.OT.ID"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.SCHME.CDE"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.SCH.PRTY"/>
		<xsl:call-template name="ULTIMATE.CREDITOR.SCH.ISSUR"/>
		<xsl:call-template name="ORDERING.COUNTRY.RESIDENCE"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.DOB"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.BR.PRVNC"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.BR.CITY"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.BR.COUNTRY"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.OT.ID.TYPE"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.OT.ID"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.SCHME.CDE"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.SCH.PRTY"/>
		<xsl:call-template name="ULTIMATE.DEBTOR.SCH.ISSUR"/>
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