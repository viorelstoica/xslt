<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_FORMAT" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="/">
		<T24Batch>
			<xsl:for-each select="b:F2B_FORMAT/b:entity/b:records/b:record/b:attributes">
				<T24>
					<serviceRequest xmlns="http://www.temenos.com/T24/OFSML/150">
						<securityContext>
							<xsl:if test="../@mainBusinessEntity and ../@mainBusinessEntity != ''">
								<company>
									<xsl:value-of select="../@mainBusinessEntity"/>
								</company>
							</xsl:if>
						</securityContext>
						<ofsTransactionInput application="SY.DCI" operation="PROCESS" version="{$SyDciVersion}">
							<xsl:call-template name="SY.DCI"/>
						</ofsTransactionInput>
					</serviceRequest>
				</T24>
			</xsl:for-each>
		</T24Batch>
	</xsl:template>
	<xsl:template name="SY.DCI">
		<xsl:call-template name="ID"/>
		<xsl:call-template name="TAP.REF.ID"/>
		<xsl:call-template name="TAP.EVENT.ID"/>
		<xsl:call-template name="DCI.REFERENCE"/>
		<xsl:call-template name="DESCRIPTION"/>
		<xsl:call-template name="CONTRACT.STATUS"/>
		<xsl:call-template name="VARIANT"/>
		<xsl:call-template name="TRADE.DATE"/>
		<xsl:call-template name="VALUE.DATE"/>
		<xsl:call-template name="MATURITY.DATE"/>
		<xsl:call-template name="FIXING.DATE"/>
		<xsl:call-template name="FIXING.TIME"/>
		<xsl:call-template name="TRADE.CCY"/>
		<xsl:call-template name="ALTERNATE.CCY.1"/>
		<xsl:call-template name="CUSTOMER"/>
		<xsl:call-template name="PORTFOLIO"/>
		<xsl:call-template name="CUST.DEPOSIT.ACC"/>
		<xsl:call-template name="CUST.ALT.CCY.ACC.1"/>
		<xsl:call-template name="COUNTERPARTY"/>
		<xsl:call-template name="CPARTY.PORTFOLIO"/>
		<xsl:call-template name="CPARTY.DEPOSIT.ACC"/>
		<xsl:call-template name="CPARTY.ALTCCYACC.1"/>
		<xsl:call-template name="BASE.CCY.1"/>
		<xsl:call-template name="SPOT.PRICE.1"/>
		<xsl:call-template name="STRIKE.PERCENT.1"/>
		<xsl:call-template name="STRIKE.PRICE.1"/>
		<xsl:call-template name="CATEGORY"/>
		<xsl:call-template name="BASE.INTEREST.RATE"/>
		<xsl:call-template name="INTEREST.SPREAD"/>
		<xsl:call-template name="INTEREST.RATE"/>
		<xsl:call-template name="DAY.BASIS"/>
		<xsl:call-template name="DEPOSIT.AMOUNT"/>
		<xsl:call-template name="INTEREST.AMOUNT"/>
		<xsl:call-template name="DEP.AMT.ALT.CCY.1"/>
		<xsl:call-template name="INT.AMT.ALT.CCY.1"/>
		<xsl:call-template name="ALTERNATE.CCY.2"/>
		<xsl:call-template name="BASE.CCY.2"/>
		<xsl:call-template name="SPOT.PRICE.2"/>
		<xsl:call-template name="STRIKE.PERCENT.2"/>
		<xsl:call-template name="STRIKE.PRICE.2"/>
		<xsl:call-template name="CUST.ALT.CCY.ACC.2"/>
		<xsl:call-template name="CPARTY.ALTCCYACC.2"/>
		<xsl:call-template name="DEP.AMT.ALT.CCY.2"/>
		<xsl:call-template name="INT.AMT.ALT.CCY.2"/>
		<xsl:call-template name="DX.CONTRACT.CODE"/>
		<xsl:call-template name="PREMIUM.CCY"/>
		<xsl:call-template name="PREMIUM.PRICE"/>
		<xsl:call-template name="PREMIUM.PERCENT"/>
		<xsl:call-template name="PREMIUM.AMT"/>
		<xsl:call-template name="CPTY.PREM.AMT"/>
		<xsl:call-template name="PREMIUM.PAY.RECEIVE"/>
		<xsl:call-template name="PREM.RESERVED.5"/>
		<xsl:call-template name="PREM.RESERVED.4"/>
		<xsl:call-template name="PREM.RESERVED.3"/>
		<xsl:call-template name="PREM.RESERVED.2"/>
		<xsl:call-template name="PREM.RESERVED.1"/>
		<xsl:call-template name="NOTIONAL.DEP.CCY"/>
		<xsl:call-template name="NOTIONAL.ALT.CCY.1"/>
		<xsl:call-template name="SY.TRANSACTION.REF"/>
		<xsl:call-template name="EXTERNAL.REF"/>
		<xsl:call-template name="SY.DX.REFERENCE"/>
		<xsl:call-template name="COUNTERPARTY.DEAL"/>
		<xsl:call-template name="B2B.REFERENCE"/>
		<xsl:call-template name="MIS.INTEREST.RATE"/>
		<xsl:call-template name="FEE.CCY"/>
		<xsl:call-template name="FEE.AMT"/>
		<xsl:call-template name="FEE.ACC"/>
		<xsl:call-template name="CPTY.FEE.AMT"/>
		<xsl:call-template name="FEE.RESERVED.5"/>
		<xsl:call-template name="FEE.RESERVED.4"/>
		<xsl:call-template name="FEE.RESERVED.3"/>
		<xsl:call-template name="FEE.RESERVED.2"/>
		<xsl:call-template name="FEE.RESERVED.1"/>
		<xsl:call-template name="RM.SPREAD.CCY"/>
		<xsl:call-template name="RM.SPREAD.RATE"/>
		<xsl:call-template name="RM.SPREAD.AMT"/>
		<xsl:call-template name="CONVERT.INTEREST"/>
		<xsl:call-template name="CREATE.DEPOSIT"/>
		<xsl:call-template name="CREATE.OPTION"/>
		<xsl:call-template name="EXOTIC.TYPE.1"/>
		<xsl:call-template name="TRIGGER.EXOTIC.1"/>
		<xsl:call-template name="USR.FLD.TEXT.1"/>
		<xsl:call-template name="USR.FLD.VAL.1"/>
		<xsl:call-template name="EXOTIC.TYPE.2"/>
		<xsl:call-template name="TRIGGER.EXOTIC.2"/>
		<xsl:call-template name="USR.FLD.TEXT.2"/>
		<xsl:call-template name="USR.FLD.VAL.2"/>
		<xsl:call-template name="USR.RESERVED.05"/>
		<xsl:call-template name="USR.RESERVED.04"/>
		<xsl:call-template name="USR.RESERVED.03"/>
		<xsl:call-template name="USR.RESERVED.02"/>
		<xsl:call-template name="USR.RESERVED.01"/>
		<xsl:call-template name="EXERCISE.EXPIRE"/>
		<xsl:call-template name="EXERCISE.CCY"/>
		<xsl:call-template name="NEW.MATURITY.DATE"/>
		<xsl:call-template name="NEW.INTEREST.RATE"/>
		<xsl:call-template name="NEW.INTEREST.AMT"/>
		<xsl:call-template name="UNWIND.CHG.CCY"/>
		<xsl:call-template name="UNWIND.CHG.AMT"/>
		<xsl:call-template name="UNWIND.CHG.ACC"/>
		<xsl:call-template name="CPTY.UNWIND.CHG.AMT"/>
		<xsl:call-template name="UNWIND.RESERVED.5"/>
		<xsl:call-template name="UNWIND.RESERVED.4"/>
		<xsl:call-template name="UNWIND.RESERVED.3"/>
		<xsl:call-template name="UNWIND.RESERVED.2"/>
		<xsl:call-template name="UNWIND.RESERVED.1"/>
		<xsl:call-template name="FX.AUTH"/>
		<xsl:call-template name="DEALER.DESK"/>
		<xsl:call-template name="UNWIND.POST.TIME"/>
		<xsl:call-template name="SY.MASTER"/>
		<xsl:call-template name="RISK.LEVEL"/>
		<xsl:call-template name="ACCRUED.INT"/>
		<xsl:call-template name="TAX.INTEREST.KEY"/>
		<xsl:call-template name="TAX.INTEREST.TYPE"/>
		<xsl:call-template name="LOCAL.OR.SOURCE"/>
		<xsl:call-template name="TOT.INT.TAX"/>
		<xsl:call-template name="TOT.TAX.INT.LCY"/>
		<xsl:call-template name="PYMT.MSG.REQD"/>
		<xsl:call-template name="DEP.CCY.BEN.BANK"/>
		<xsl:call-template name="DEP.CCY.BEN.ADD"/>
		<xsl:call-template name="DEP.CCY.BEN.ACCT"/>
		<xsl:call-template name="DEP.CCY.INTR.BANK"/>
		<xsl:call-template name="DEP.CCY.INTR.ADD"/>
		<xsl:call-template name="DEP.CCY.CPTY.NO"/>
		<xsl:call-template name="DEP.CCY.CPTY.ADD"/>
		<xsl:call-template name="DEP.CCY.CPTY.ACCT"/>
		<xsl:call-template name="TRADER.ID"/>
		<xsl:call-template name="FIXING.REF.RATE"/>
		<xsl:call-template name="RM.MARKUP"/>
		<xsl:call-template name="EXEC.CHANNEL"/>
		<xsl:call-template name="INT.CCY"/>
		<xsl:call-template name="INT.CCY.ACCOUNT"/>
		<xsl:call-template name="INT.SPOT.RATE"/>
		<xsl:call-template name="ALT.CCY.BEN.BANK"/>
		<xsl:call-template name="ALT.CCY.BEN.ADD"/>
		<xsl:call-template name="ALT.CCY.BEN.ACCT"/>
		<xsl:call-template name="ALT.CCY.INTR.BANK"/>
		<xsl:call-template name="ALT.CCY.INTR.ADD"/>
		<xsl:call-template name="ALT.CCY.CPTY.NO"/>
		<xsl:call-template name="ALT.CCY.CPTY.ADD"/>
		<xsl:call-template name="ALT.CCY.CPTY.ACCT"/>
		<xsl:call-template name="RESERVED.14"/>
		<xsl:call-template name="RESERVED.13"/>
		<xsl:call-template name="RESERVED.12"/>
		<xsl:call-template name="RESERVED.11"/>
		<xsl:call-template name="RESERVED.10"/>
		<xsl:call-template name="RESERVED.09"/>
		<xsl:call-template name="RESERVED.08"/>
		<xsl:call-template name="RESERVED.07"/>
		<xsl:call-template name="RESERVED.06"/>
		<xsl:call-template name="RESERVED.05"/>
		<xsl:call-template name="RESERVED.04"/>
		<xsl:call-template name="RESERVED.03"/>
		<xsl:call-template name="RESERVED.02"/>
		<xsl:call-template name="RESERVED.01"/>
	    <xsl:call-template name="ModelBankSpecificFields"/>
	    <xsl:call-template name="ModelBankSpecificFields-Custo"/> 
		<xsl:call-template name="USERDEF.FIELDS"/>
	</xsl:template>
</xsl:stylesheet>