<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:t="http://www.odcgroup.com/F2B_FORMAT" xmlns:dxorder="http://www.temenos.com/T24/dxorder"
                xmlns:dxtrade="http://www.temenos.com/T24/dxtrade" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:adjustmentorder="http://www.temenos.com/T24/adjustmentorder" xmlns:secopenorder1="http://www.temenos.com/T24/secopenorder1"
                xmlns:secopenorder2="http://www.temenos.com/T24/secopenorder2" xmlns:secopenorder3="http://www.temenos.com/T24/secopenorder3" xmlns:secopenorder4="http://www.temenos.com/T24/secopenorder4"
                xmlns:sectrade="http://www.temenos.com/T24/sectrade" xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer"
                xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer" xmlns:securitytransfer2="http://www.temenos.com/T24/securitytransfer2" exclude-result-prefixes="b t" version="1.0">

	<xsl:template name="secopenorder1:transactionId">
		<transactionId>
			<xsl:value-of select="b:userDefinedField[infra:name='source_code']/infra:value"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="secopenorder1:ACCT.NARRATIVE">
		<field name="ACCT.NARRATIVE">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_2_c']/infra:value,1,40)"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:AUTHORISE.TRADE">
		<field name="AUTHORISE.TRADE">
			<xsl:value-of select="$SC_AUTHORISE_TRADE"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:CALC.CHRGS">
		<field name="CALC.CHRGS">
			<xsl:choose>
				<xsl:when test="b:targetNature = '1' or b:targetNature = '2' or b:targetNature = '3' or b:targetNature = '4' or b:targetNature = '6' or b:targetNature = '7' or b:targetNature = '9'">
					<xsl:choose>
						<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
							<xsl:value-of select="'NO'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$CALCCHRGSCASHORDER"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="b:targetNature = '5'">
					<xsl:value-of select="'YES'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:CASH.CHRGS">
		<xsl:if test="not(b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))))">
			<xsl:choose>
				<xsl:when test="b:targetNature = '2'">
					<field name="CASH.CHRGS">
						<xsl:value-of select="'GROSS'"/>
					</field>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:targetNature = '5'">
						<field name="CASH.CHRGS">
							<xsl:value-of select="'NET'"/>
						</field>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:CASH.ROUNDING">
		<xsl:choose>
			<xsl:when test="b:targetNature = '5'">
				<field name="CASH.ROUNDING">
					<xsl:value-of select="$CASHROUNDING_NET"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder1:CONFIRMATION">
		<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
			<field name="CONFIRMATION">
				<xsl:value-of select="'NO'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:CU.CASH.AMOUNT">
		<xsl:if test="b:targetNature = '2' or b:targetNature = '5'">
			<field name="CU.CASH.AMOUNT">
				<xsl:value-of select="translate(b:targetAmount,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:CURR.PRICE">
		<xsl:choose>
			<xsl:when test="b:targetNature = '2' and not(b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))))">
				<field name="CURR.PRICE">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
				</field>
			</xsl:when>
			<xsl:when test="b:orderType = '3' or b:orderType = '4'">
				<field name="CURR.PRICE">
					<xsl:value-of select="translate(b:stopPrice,',','')"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder1:CUST.ACC.NO">
	<xsl:if test="b:bulkChildIndicator != '2'">
		<field name="CUST.ACC.NO">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:CUST.NUMBER">
		<field name="CUST.NUMBER">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:client/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:DEAL.NARRATIVE">
		<field name="DEAL.NARRATIVE">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_3_c']/infra:value,1,40)"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:DEAL.STATUS">
		<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
			<field name="DEAL.STATUS">
				<xsl:value-of select="'TRANSMITTED'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:choose>
				<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:LIMIT.EXP.DATE">
		<field name="LIMIT.EXP.DATE">
			<xsl:choose>
				<xsl:when test="b:validityDate">
					<xsl:value-of select="translate(b:validityDate,'-','')"/>
				</xsl:when>
				<xsl:when test="b:orderValidityType = '2'">
					<xsl:value-of select="20991231"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:LIMIT.PRICE">
		<field name="LIMIT.PRICE">
			<xsl:if test="b:orderType = '2' or b:orderType = '4'">
				<xsl:value-of select="translate(b:limitPrice,',','')"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:LIMIT.TYPE">
		<field name="LIMIT.TYPE">
			<xsl:choose>
				<xsl:when test="b:validityDate">
					<xsl:value-of select="'GTD'"/>
				</xsl:when>
				<xsl:when test="b:orderValidityType = '2'">
					<xsl:value-of select="'GTC'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:NARRATIVE">
		<field name="NARRATIVE">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,40)"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:NO.NOMINAL">
		<xsl:if test="b:targetNature != '2' and b:targetNature != '5' and b:targetNature != '6' and b:targetNature != '7'">
			<field name="NO.NOMINAL">
				<xsl:value-of select="translate(b:userDefinedField[infra:name='ud_remaining_order_qty_n']/infra:value,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:ORDER.TYPE">
		<field name="ORDER.TYPE">
			<xsl:choose>
				<xsl:when test="(b:subType/infra:code != '') and ((contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,''))) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,''))))">
					<xsl:value-of select="'SWITCH'"/>
				</xsl:when>
				<xsl:when test="b:targetNature = '2' or b:targetNature = '5'">
					<xsl:value-of select="'CASH'"/>
				</xsl:when>
				<xsl:when test="b:targetNature = '1'">
					<xsl:choose>
						<xsl:when test="b:orderType = '1'">
							<xsl:value-of select="'MARKET'"/>
						</xsl:when>
						<xsl:when test="b:orderType = '2'">
							<xsl:value-of select="'PRICE'"/>
						</xsl:when>
						<xsl:when test="b:orderType = '3'">
							<xsl:value-of select="'STOP'"/>
						</xsl:when>
						<xsl:when test="b:orderType = '4'">
							<xsl:value-of select="'STOP.LIMIT'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'NOTSUPPORTED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:PARENT">
		<field name="PARENT">
			<xsl:choose>
				<xsl:when test="b:bulkChildIndicator = '2'">
					<xsl:value-of select="'YES'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'NULL'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:PARENT.REFERENCE">
		<xsl:choose>
			<xsl:when test="b:bulkChildIndicator = '2'">
				<field name="PARENT.REFERENCE">
					<xsl:value-of select="b:pmsOrderReference"/>
				</field>
			</xsl:when>
			<xsl:when test="b:bulkChildIndicator = '3'">
				<field name="PARENT.REFERENCE">
					<xsl:value-of select="b:pmsBulkOrderReference"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder1:SECURITY.ACCNT">
		<field name="SECURITY.ACCNT">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:SECURITY.NO">
		<field name="SECURITY.NO">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:STOCK.EXCHANGE">
		<field name="STOCK.EXCHANGE">
			<xsl:choose>
				<xsl:when test="$STOCKEXCH_PREFIX != ''">
					<xsl:value-of select="substring-after(b:stockExchange/infra:code,$STOCKEXCH_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:stockExchange/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:TRADE.CCY">
		<field name="TRADE.CCY">
			<xsl:value-of select="b:tradeCurrency/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:TYPE.OF.TRADE">
		<field name="TYPE.OF.TRADE">
			<xsl:value-of select="'S'"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:UTC.DATE.TIME"/>

	<xsl:template name="secopenorder1:COM.ORDER.COUNT">
		<field name="COM.ORDER.COUNT">
			<xsl:value-of select="b:compoundOrderLegs"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:COM.ORDER.MASTER"/>
	<xsl:template name="secopenorder1:COM.ORDER.REF"/>
	<xsl:template name="secopenorder1:PERCENTAGE">
		<xsl:if test="b:targetNature = '6' or b:targetNature = '7'">
			<field name="PERCENTAGE">
				<xsl:value-of select="b:targetObjective"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:SWITCH.ORDER"/>
	<xsl:template name="secopenorder1:SWITCH.QTY">
		<xsl:if test="b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))">
			<field name="SWITCH.QTY">
				<xsl:choose>
					<xsl:when test="b:targetNature = '1'">
						<xsl:value-of select="'UNIT'"/>
					</xsl:when>
					<xsl:when test="b:targetNature = '2'">
						<xsl:value-of select="'AMOUNT'"/>
					</xsl:when>
					<xsl:when test="b:targetNature = '6' or b:targetNature = '7'">
						<xsl:value-of select="'PERCENTAGE'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder1:transactionFeesTaxesCounter">
		<xsl:call-template name="printOrderFeesAndTaxes">
			<xsl:with-param name="caller" select="'OrderUpdateInstruction'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="secopenorder1:TAP.ORD.NATURE">
		<field name="TAP.ORD.NATURE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
					<xsl:value-of select="'DMA'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
					<xsl:value-of select="'NDMA'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:STP.ORDER">
		<field name="STP.ORDER">
			<xsl:value-of select="$stpOrderFix"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:INVEST.OPTION.TYPE"/>
	<xsl:template name="secopenorder1:ORDER.NUMBER"/>
	<xsl:template name="secopenorder1:ORDER.DATE"/>
	<xsl:template name="secopenorder1:ORDER.TIME">
		<xsl:variable name="utcDateTime" select="substring-after(b:initiationDateTime,'T')"/>
		<xsl:variable name="utcDate" select="concat(substring-before($utcDateTime,'.'),':',substring-after($utcDateTime,'.'))"/>
		<field name="ORDER.TIME">
			<xsl:value-of select="substring-before($utcDate,'+')"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:VALUE.DATE"/>
	<xsl:template name="secopenorder1:MATURITY.DATE"/>
	<xsl:template name="secopenorder1:TRANSACTION.CODE"/>
	<xsl:template name="secopenorder1:SPLIT.CHRGS"/>
	<xsl:template name="secopenorder1:ADJUST.COMM"/>
	<xsl:template name="secopenorder1:CU.EX.RATE.ACC"/>
	<xsl:template name="secopenorder1:SETTLEMENT.CCY"/>
	<xsl:template name="secopenorder1:WAIVE.CU.BR.COM"/>
	<xsl:template name="secopenorder1:RESERVED.9"/>
	<xsl:template name="secopenorder1:RESERVED.8"/>
	<xsl:template name="secopenorder1:CU.DISC.PCENT"/>
	<xsl:template name="secopenorder1:CU.WHT.PERC"/>
	<xsl:template name="secopenorder1:COMM.CODE"/>
	<xsl:template name="secopenorder1:COMM.PERCENT"/>
	<xsl:template name="secopenorder1:COM.TAX.CODE"/>
	<xsl:template name="secopenorder1:COM.TAX.BCUR"/>
	<xsl:template name="secopenorder1:COM.TAX.XRTE"/>
	<xsl:template name="secopenorder1:CU.DEPOSITORY"/>
	<xsl:template name="secopenorder1:SUB.ACCOUNT">
		<field name="SUB.ACCOUNT">
			<xsl:value-of select="substring-after(b:depositaryAccount/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:PORT.CONST.NO"/>
	<xsl:template name="secopenorder1:CU.BROKER.NO"/>
	<xsl:template name="secopenorder1:CU.NOTES"/>
	<xsl:template name="secopenorder1:CU.ENTL.ID"/>
	<xsl:template name="secopenorder1:CU.INT.CTR"/>
	<xsl:template name="secopenorder1:BUYING.POWER"/>
	<xsl:template name="secopenorder1:EXT.CUSTODIAN"/>
	<xsl:template name="secopenorder1:CU.INCOME.ACC"/>
	<xsl:template name="secopenorder1:CU.INCOME.CCY"/>
	<xsl:template name="secopenorder1:LINK.ORDER.NO"/>
	<xsl:template name="secopenorder1:NOMINEE.CODE"/>
	<xsl:template name="secopenorder1:ACCOUNT.MANAGER"/>
	<xsl:template name="secopenorder1:BROKER"/>
	<xsl:template name="secopenorder1:DATE.TO.BROKER"/>
	<xsl:template name="secopenorder1:TIME.TO.BROKER"/>
	<xsl:template name="secopenorder1:AMT.TO.BROKER"/>
	<xsl:template name="secopenorder1:BR.CASH.AMT"/>
	<xsl:template name="secopenorder1:BR.PRICE"/>
	<xsl:template name="secopenorder1:BROKER.TYPE"/>
	<xsl:template name="secopenorder1:BR.SEC.ACCT"/>
	<xsl:template name="secopenorder1:BR.ACC.NO"/>
	<xsl:template name="secopenorder1:BR.ACCOUNT.CCY"/>
	<xsl:template name="secopenorder1:BR.EX.RATE.ACC"/>
	<xsl:template name="secopenorder1:BR.DELIV.INSTR"/>
	<xsl:template name="secopenorder1:EXE.BY.BROKER"/>
	<xsl:template name="secopenorder1:BANK.CORRES"/>
	<xsl:template name="secopenorder1:BROK.CORRES"/>
	<xsl:template name="secopenorder1:DELIVERY.KEY"/>
	<xsl:template name="secopenorder1:SECURITIES.CR.DR"/>
	<xsl:template name="secopenorder1:REFERENCE.NO"/>
	<xsl:template name="secopenorder1:CUSTOMER.NO"/>
	<xsl:template name="secopenorder1:SEC.ACC.NO"/>
	<xsl:template name="secopenorder1:BROKER.NO"/>
	<xsl:template name="secopenorder1:EXE.DETAIL"/>
	<xsl:template name="secopenorder1:NO.NOM.FILLED"/>
	<xsl:template name="secopenorder1:TRADE.PRICE"/>
	<xsl:template name="secopenorder1:TRADE.DATE"/>
	<xsl:template name="secopenorder1:TRADE.TIME"/>
	<xsl:template name="secopenorder1:ORDER.NOMINAL"/>
	<xsl:template name="secopenorder1:LIQUIDATION.PERIOD"/>
	<xsl:template name="secopenorder1:PREMIUM.PRICE"/>
	<xsl:template name="secopenorder1:MARKET.TYPE"/>
	<xsl:template name="secopenorder1:VAL.IN.SETT.CCY"/>
	<xsl:template name="secopenorder1:VERIFY.BY.DEALER"/>
	<xsl:template name="secopenorder1:LOCAL.REF"/>
	<xsl:template name="secopenorder1:CUST.DEPO"/>
	<xsl:template name="secopenorder1:CU.DEPO.NOM"/>
	<xsl:template name="secopenorder1:CU.NOM.CODE"/>
	<xsl:template name="secopenorder1:RESERVED07"/>
	<xsl:template name="secopenorder1:GROUP.ORDER"/>
	<xsl:template name="secopenorder1:ODD.LOT.ORDER"/>
	<xsl:template name="secopenorder1:ACTIVITY.CODE"/>
	<xsl:template name="secopenorder1:MSG.BROKER"/>
	<xsl:template name="secopenorder1:MSG.NO"/>
	<xsl:template name="secopenorder1:MSG.CLASS"/>
	<xsl:template name="secopenorder1:OVR.CARRIER"/>
	<xsl:template name="secopenorder1:OVR.ADDRESS"/>
	<xsl:template name="secopenorder1:SEND.ADVICE"/>
	<xsl:template name="secopenorder1:SOFT.DLVRY.KEY"/>
	<xsl:template name="secopenorder1:ROUT.COMPANY"/>
	<xsl:template name="secopenorder1:CUM.EX.IND"/>
	<xsl:template name="secopenorder1:WHT.TAX.CODE"/>
	<xsl:template name="secopenorder1:SEGMENT"/>
	<xsl:template name="secopenorder1:DEF.DEAL.DESK"/>
	<xsl:template name="secopenorder1:ACT.DEAL.DESK"/>
	<xsl:template name="secopenorder1:INT.CTR"/>
	<xsl:template name="secopenorder1:SERVICE.REF"/>
	<xsl:template name="secopenorder1:THREAD.KEY"/>
	<xsl:template name="secopenorder1:TRADED.NOM"/>
	<xsl:template name="secopenorder1:OUTSTAND.NOM"/>
	<xsl:template name="secopenorder1:TRADER.CODE"/>
	<xsl:template name="secopenorder1:TRADER.DESC"/>
	<xsl:template name="secopenorder1:ROUT.SEC.ACC"/>
	<xsl:template name="secopenorder1:ROUT.BROKER"/>
	<xsl:template name="secopenorder1:ROUTED.ORDER.REF"/>
	<xsl:template name="secopenorder1:IN.HOUSE.SEC.ACC"/>
	<xsl:template name="secopenorder1:IN.HOUSE.CUSTODIAN"/>
	<xsl:template name="secopenorder1:REVERSE.CHILD"/>
	<xsl:template name="secopenorder1:EXE.HLT"/>
	<xsl:template name="secopenorder1:TRADE.HLT"/>
	<xsl:template name="secopenorder1:AUTHORISE.CHILD"/>
	<xsl:template name="secopenorder1:DELETE.CHILD"/>
	<xsl:template name="secopenorder1:ROUNDING.FACTOR"/>
	<xsl:template name="secopenorder1:MKT.IDN.CODE"/>
	<xsl:template name="secopenorder1:BULK.UPDATE"/>
	<xsl:template name="secopenorder1:RESERVED9"/>
	<xsl:template name="secopenorder1:RESERVED8"/>
	<xsl:template name="secopenorder1:RESERVED7"/>
	<xsl:template name="secopenorder1:RESERVED6"/>
	<xsl:template name="secopenorder1:RESERVED5"/>
	<xsl:template name="secopenorder1:RESERVED4"/>
	<xsl:template name="secopenorder1:RESERVED3"/>
	<xsl:template name="secopenorder1:RESERVED2"/>
	<xsl:template name="secopenorder1:RESERVED1"/>
	<xsl:template name="secopenorder1:OVERRIDE"/>
	<xsl:template name="secopenorder1:RECORD.STATUS"/>
	<xsl:template name="secopenorder1:CURR.NO"/>
	<xsl:template name="secopenorder1:INPUTTER"/>
	<xsl:template name="secopenorder1:DATE.TIME"/>
	<xsl:template name="secopenorder1:AUTHORISER"/>
	<xsl:template name="secopenorder1:CO.CODE"/>
	<xsl:template name="secopenorder1:DEPT.CODE"/>
	<xsl:template name="secopenorder1:AUDITOR.CODE"/>
	<xsl:template name="secopenorder1:AUDIT.DATE.TIME"/>
	<xsl:template name="secopenorder1:USERDEF.FIELDS"/>
	<xsl:template name="secopenorder1:ModelBankSpecificFields"/>
	<xsl:template name="secopenorder1:ModelBankSpecificFields-Custo"/>
	<!-- BEG - For Format Based input which follows F2B_Format Schema -->
	<!-- BEG - Template for printing the multivalue depending on order of Priority as obtained from TAP -->
	<xsl:template name="multivalue_ordertaxlots">
		<xsl:param name="i"/>
		<xsl:param name="fieldname"/>
		<xsl:param name="inputfieldname"/>
		<xsl:param name="j" select="concat($inputfieldname,$i)"/>
		<xsl:if test="t:attribute[@name = $j] != '' and t:attribute[@name = $j]">
			<field>
				<xsl:attribute name="name">
					<xsl:value-of select="concat($fieldname,$i)"/>
				</xsl:attribute>
				<xsl:value-of select="t:attribute[@name = $j]"/>
			</field>
			<xsl:call-template name="multivalue_ordertaxlots">
				<xsl:with-param name="i" select="$i+1"/>
				<xsl:with-param name="fieldname" select="$fieldname"/>
				<xsl:with-param name="inputfieldname" select="$inputfieldname"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template for printing the multivalue depending on order of Priority as obtained from TAP -->
	<xsl:template name="secopenorder2:QTY.ALLOTED">
		<xsl:if test="local-name()='attributes'">
			<xsl:call-template name="multivalue_ordertaxlots">
				<xsl:with-param name="i" select="'1'"/>
				<xsl:with-param name="fieldname" select="'QTY.ALLOTED:1:'"/>
				<xsl:with-param name="inputfieldname" select="'quantity_n_'"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder2:TAXLOT.ALLOCATE">
		<xsl:if test="local-name()='attributes'">
			<xsl:call-template name="multivalue_ordertaxlots">
				<xsl:with-param name="i" select="'1'"/>
				<xsl:with-param name="fieldname" select="'TAXLOT.ALLOCATE:1:'"/>
				<xsl:with-param name="inputfieldname" select="'tax_lot_id_'"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - For Format Based input which follows F2B_Format Schema -->
	<xsl:template name="secopenorder2:ACCT.NARRATIVE">
		<field name="ACCT.NARRATIVE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_2_c']/infra:value,1,40)"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="substring(t:attribute[@name = 'remark_2_c'],1,40)"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:ADJUST.COMM">
		<field name="ADJUST.COMM">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:if test="b:targetNature = '5' and $CALCCHRGSCASHORDER = 'YES' and $CASHROUNDING_NET = 'EXACT'">
						<xsl:value-of select="$ADJUSTCOMM_NET"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:if test="t:attribute[@name = 'target_nature_e'] = '5' and $CALCCHRGSCASHORDER = 'YES' and $CASHROUNDING_NET = 'EXACT'">
						<xsl:value-of select="$ADJUSTCOMM_NET"/>
					</xsl:if>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:AUTHORISE.TRADE">
		<field name="AUTHORISE.TRADE">
			<xsl:value-of select="$SC_AUTHORISE_TRADE"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:CALC.CHRGS">
		<field name="CALC.CHRGS">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:targetNature = '1' or b:targetNature = '2' or b:targetNature = '3' or b:targetNature = '4' or b:targetNature = '6' or b:targetNature = '7' or b:targetNature = '9'">
							<xsl:choose>
								<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
									<xsl:value-of select="'NO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$CALCCHRGSCASHORDER"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="b:targetNature = '5'">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '1' or t:attribute[@name = 'target_nature_e'] = '2' or t:attribute[@name = 'target_nature_e'] = '3' or t:attribute[@name = 'target_nature_e'] != '4' or t:attribute[@name = 'target_nature_e'] = '6' or t:attribute[@name = 'target_nature_e'] = '7' or t:attribute[@name = 'target_nature_e'] = '9'">
							<xsl:choose>
								<xsl:when test="t:attribute[@name = 'order_fee_e'] != '0'">
									<xsl:value-of select="'NO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$CALCCHRGSCASHORDER"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '5'">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:CANCEL.TRADE.REF">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value != 'NULL'">
					<field name="CANCEL.TRADE.REF">
						<xsl:value-of select="b:userDefinedField[infra:name='source_code']/infra:value"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'source_code'] != 'NULL'">
					<field name="CANCEL.TRADE.REF">
						<xsl:value-of select="t:attribute[@name = 'source_code']"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CASH.CHRGS">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="not(b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))))">
					<xsl:choose>
						<xsl:when test="b:targetNature = '2'">
							<field name="CASH.CHRGS">
								<xsl:value-of select="'GROSS'"/>
							</field>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="b:targetNature = '5'">
								<field name="CASH.CHRGS">
									<xsl:value-of select="'NET'"/>
								</field>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="not(t:attribute[@name = 'subTypeCode'] != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')))))">
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2'">
							<field name="CASH.CHRGS">
								<xsl:value-of select="'GROSS'"/>
							</field>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="t:attribute[@name = 'target_nature_e'] = '5'">
								<field name="CASH.CHRGS">
									<xsl:value-of select="'NET'"/>
								</field>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CONFIRMATION">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
					<field name="CONFIRMATION">
						<xsl:value-of select="'NO'"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'stp_order_e'] = '1'">
					<field name="CONFIRMATION">
						<xsl:value-of select="'NO'"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CU.CASH.AMOUNT">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:targetNature = '2' or b:targetNature = '5'">
					<field name="CU.CASH.AMOUNT">
						<xsl:value-of select="translate(b:targetAmount,',','')"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'target_nature_e'] = '2' or t:attribute[@name = 'target_nature_e'] = '5'">
					<field name="CU.CASH.AMOUNT">
						<xsl:value-of select="translate(t:attribute[@name = 'target_m'],',','')"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CURR.PRICE">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:choose>
					<xsl:when test="b:targetNature = '2' and not(b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))))">
						<field name="CURR.PRICE">
							<xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
						</field>
					</xsl:when>
					<xsl:when test="b:orderType = '3' or b:orderType = '4'">
						<field name="CURR.PRICE">
							<xsl:value-of select="translate(b:stopPrice,',','')"/>
						</field>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:choose>
					<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2' and not(t:attribute[@name = 'subTypeCode'] != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')))))">
						<field name="CURR.PRICE">
							<xsl:value-of select="translate(t:attribute[@name = 'quote_n'],',','')"/>
						</field>
					</xsl:when>
					<xsl:when test="t:attribute[@name = 'order_nat_e'] = '3' or t:attribute[@name = 'order_nat_e'] = '4'">
						<field name="CURR.PRICE">
							<xsl:value-of select="t:attribute[@name = 'stop_quote_n']"/>
						</field>
					</xsl:when>
				</xsl:choose>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CUST.ACC.NO">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:bulkChildIndicator != '2'">
					<field name="CUST.ACC.NO">
						<xsl:choose>
							<xsl:when test="b:boPortfolio/infra:code != ''">
								<xsl:value-of select="b:boAccount/infra:code"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:currentAccount/infra:code"/>
							</xsl:otherwise>
						</xsl:choose>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:choose>
					<xsl:when test="t:attribute[@name = 'boportfolioCode'] != ''">
						<field name="CUST.ACC.NO">
							<xsl:value-of select="t:attribute[@name = 'boAccountId']"/>
						</field>
					</xsl:when>
					<xsl:otherwise>
						<field name="CUST.ACC.NO">
							<xsl:value-of select="t:attribute[@name = 'accountCode']"/>
						</field>
					</xsl:otherwise>
				</xsl:choose>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:CUST.NUMBER">
		<field name="CUST.NUMBER">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="$CUSTOMER_PREFIX != ''">
							<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:client/infra:code"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="$CUSTOMER_PREFIX != ''">
							<xsl:value-of select="substring-after(t:attribute[@name = 'ud_client_id'],$CUSTOMER_PREFIX)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="t:attribute[@name = 'ud_client_id']"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:DEAL.NARRATIVE">
		<field name="DEAL.NARRATIVE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_3_c']/infra:value,1,40)"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="substring(t:attribute[@name = 'remark_3_c'],1,40)"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:DEAL.STATUS">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
					<field name="DEAL.STATUS">
						<xsl:value-of select="'TRANSMITTED'"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'stp_order_e'] = '1'">
					<field name="DEAL.STATUS">
						<xsl:value-of select="'TRANSMITTED'"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
							<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:depositaryAccount/infra:code"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="t:attribute[@name = 'depositCode']"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:LIMIT.EXP.DATE">
		<field name="LIMIT.EXP.DATE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:validityDate">
							<xsl:value-of select="translate(b:validityDate,'-','')"/>
						</xsl:when>
						<xsl:when test="b:orderValidityType = '2'">
							<xsl:value-of select="'NULL'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'order_limit_d']">
							<xsl:value-of select="translate(t:attribute[@name = 'order_limit_d'],'-','')"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'order_validity_nat_e'] = '2'">
							<xsl:value-of select="'NULL'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:LIMIT.PRICE">
		<field name="LIMIT.PRICE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:if test="b:orderType = '2' or b:orderType = '4'">
						<xsl:value-of select="translate(b:limitPrice,',','')"/>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:if test="t:attribute[@name = 'order_nat_e'] = '2' or t:attribute[@name = 'order_nat_e'] = '4'">
						<xsl:value-of select="translate(t:attribute[@name = 'limit_quote_n'],',','')"/>
					</xsl:if>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:LIMIT.TYPE">
		<field name="LIMIT.TYPE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:validityDate">
							<xsl:value-of select="'GTD'"/>
						</xsl:when>
						<xsl:when test="b:orderValidityType = '2'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'order_limit_d']">
							<xsl:value-of select="'GTD'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'order_validity_nat_e'] = '2'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:NARRATIVE">
		<field name="NARRATIVE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,40)"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="substring(t:attribute[@name = 'remark_1_c'],1,40)"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:NO.NOMINAL">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:targetNature != '2' and b:targetNature != '5' and b:targetNature != '6' and b:targetNature != '7'">
					<field name="NO.NOMINAL">
						<xsl:value-of select="translate(b:quantity,',','')"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'target_nature_e'] != '2' and t:attribute[@name = 'target_nature_e'] != '5' and t:attribute[@name = 'target_nature_e'] != '6' and t:attribute[@name = 'target_nature_e'] != '7'">
					<field name="NO.NOMINAL">
						<xsl:value-of select="translate(t:attribute[@name = 'quantity_n'],',','')"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:ORDER.TYPE">
		<field name="ORDER.TYPE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="(b:subType/infra:code != '') and ((contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,''))) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,''))))">
							<xsl:value-of select="'SWITCH'"/>
						</xsl:when>
						<xsl:when test="b:targetNature = '2' or b:targetNature = '5'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="b:targetNature = '1'">
							<xsl:choose>
								<xsl:when test="b:type/infra:code = $RevokeType">
									<xsl:value-of select="'CANC'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '1'">
									<xsl:value-of select="'MARKET'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '2'">
									<xsl:choose>
										<xsl:when test="$settlementOrderType = 'NO'">
											<xsl:value-of select="'PRICE'"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'LIMIT'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="b:orderType = '3'">
									<xsl:value-of select="'STOP'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '4'">
									<xsl:value-of select="'STOP.LIMIT'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NOTSUPPORTED'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="(t:attribute[@name = 'subTypeCode'] != '') and ((contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))))">
							<xsl:value-of select="'SWITCH'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2' or t:attribute[@name = 'target_nature_e'] = '5'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '1'">
							<xsl:choose>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '1'">
									<xsl:value-of select="'MARKET'"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '2'">
									<xsl:value-of select="'PRICE'"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '3'">
									<xsl:value-of select="'STOP'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NOTSUPPORTED'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:PARENT">
		<field name="PARENT">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:bulkChildIndicator = '2'">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'NULL'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'parent_oper_nat_e'] = '2'">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'NULL'"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:PARENT.REFERENCE">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:choose>
					<xsl:when test="b:bulkChildIndicator = '2'">
						<field name="PARENT.REFERENCE">
							<xsl:value-of select="b:pmsOrderReference"/>
						</field>
					</xsl:when>
					<xsl:when test="b:bulkChildIndicator = '3'">
						<field name="PARENT.REFERENCE">
							<xsl:value-of select="b:pmsBulkOrderReference"/>
						</field>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:choose>
					<xsl:when test="t:attribute[@name = 'parent_oper_nat_e'] = '2'">
						<field name="PARENT.REFERENCE">
							<xsl:value-of select="t:attribute[@name = 'code']"/>
						</field>
					</xsl:when>
					<xsl:when test="t:attribute[@name = 'parent_oper_nat_e'] = '3'">
						<field name="PARENT.REFERENCE">
							<xsl:value-of select="t:attribute[@name = 'parent_operation_cod']"/>
						</field>
					</xsl:when>
				</xsl:choose>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:SECURITY.ACCNT">
		<field name="SECURITY.ACCNT">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:boPortfolio/infra:code != ''">
							<xsl:value-of select="b:boPortfolio/infra:code"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:portfolio/infra:code"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'boportfolioCode'] != ''">
							<xsl:value-of select="t:attribute[@name = 'boportfolioCode']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="t:attribute[@name = 'portfolioCode']"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:SECURITY.NO">
		<field name="SECURITY.NO">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="b:security/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="t:attribute[@name = 'instrCode']"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:STOCK.EXCHANGE">
		<field name="STOCK.EXCHANGE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="$STOCKEXCH_PREFIX != ''">
							<xsl:value-of select="substring-after(b:stockExchange/infra:code,$STOCKEXCH_PREFIX)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:stockExchange/infra:code"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="$STOCKEXCH_PREFIX != ''">
							<xsl:value-of select="substring-after(t:attribute[@name = 'marketThirdCode'],$STOCKEXCH_PREFIX)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="t:attribute[@name = 'marketThirdCode']"/>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="b:pmsOrderReference"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="t:attribute[@name = 'code']"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TRADE.CCY">
		<field name="TRADE.CCY">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="b:tradeCurrency/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="t:attribute[@name = 'opCurrencyCode']"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TRANSACTION.CODE">
		<field name="TRANSACTION.CODE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:buySellIndicator = '1'">
							<xsl:choose>
								<xsl:when test="b:type/infra:code = 'PCK_TCIB_SWITCH_IN'">
									<xsl:value-of select="'SWI'"/>
								</xsl:when>
								<xsl:when test="b:userDefinedField[infra:name='ud_upfront_payment']/infra:value = '1'">
									<xsl:value-of select="'UPS'"/>
								</xsl:when>
								<xsl:when test="starts-with(b:type/infra:code, 'SC')">
									<xsl:value-of select="substring-after(b:type/infra:code,'SC_')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'BUY'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:orderPriceType = '6'">
									<xsl:value-of select="'RDM'"/>
								</xsl:when>
								<xsl:when test="starts-with(b:type/infra:code, 'SC')">
									<xsl:value-of select="substring-after(b:type/infra:code,'SC_')"/>
								</xsl:when>
								<xsl:when test="b:type/infra:code = 'PCK_TCIB_SWITCH_OUT'">
									<xsl:value-of select="'SWO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'SEL'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'nature_e'] = '1'">
							<xsl:choose>
								<xsl:when test="starts-with(t:attribute[@name = 'typeCode'], 'SC')">
									<xsl:value-of select="substring-after(t:attribute[@name = 'typeCode'],'SC_')"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'typeCode'] = 'PCK_TCIB_SWITCH_IN'">
									<xsl:value-of select="'SWI'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'BUY'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="t:attribute[@name = 'order_price_nat_e'] = '6'">
									<xsl:value-of select="'RDM'"/>
								</xsl:when>
								<xsl:when test="starts-with(t:attribute[@name = 'typeCode'], 'SC')">
									<xsl:value-of select="substring-after(t:attribute[@name = 'typeCode'],'SC_')"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'typeCode'] = 'PCK_TCIB_SWITCH_OUT'">
									<xsl:value-of select="'SWO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'SEL'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="../../@eventIdentifier"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="../@eventIdentifier"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TXN.CHANNEL">
		<field name="TXN.CHANNEL">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:contactMethod = 'PCK_GL_FAX'">
							<xsl:value-of select="'ELECTRONIC'"/>
						</xsl:when>
						<xsl:when test="b:contactMethod = 'PCK_GL_INTERNET'">
							<xsl:value-of select="'ONLINE'"/>
						</xsl:when>
						<xsl:when test="b:contactMethod = 'PCK_GL_MEETING' or b:contactMethod = 'PCK_GL_LETTER' or b:contactMethod = 'PCK_GL_OTHER' or b:contactMethod = 'PCK_GL_EMAIL'">
							<xsl:value-of select="'RM'"/>
						</xsl:when>
						<xsl:when test="b:contactMethod = 'PCK_GL_PHONE'">
							<xsl:value-of select="'TELEPHONE'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_FAX'">
							<xsl:value-of select="'ELECTRONIC'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_INTERNET'">
							<xsl:value-of select="'ONLINE'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_MEETING' or t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_LETTER' or t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_OTHER' or t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_EMAIL'">
							<xsl:value-of select="'RM'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'communicationTypeCod'] = 'PCK_GL_PHONE'">
							<xsl:value-of select="'TELEPHONE'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:COM.ORDER.COUNT">
		<field name="COM.ORDER.COUNT">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="b:compoundOrderLegs"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="t:attribute[@name = 'comp_order_count_n']"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:COM.ORDER.REF">
		<field name="COM.ORDER.REF">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:value-of select="b:compoundOrderCode"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:value-of select="t:attribute[@name = 'compound_order_code']"/>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:COM.ORDER.MASTER">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="((contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,''))) or (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')))) and (b:compoundOrderMaster != 'NULL' and b:compoundOrderMaster !='' and b:compoundOrderMaster) and (b:compoundOrderSlave = 'NULL' or b:compoundOrderSlave = '' or not(b:compoundOrderSlave))">
					<field name="COM.ORDER.MASTER">
						<xsl:value-of select="'YES'"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="(t:attribute[@name = 'compound_order_maste'] != 'NULL' and t:attribute[@name = 'compound_order_maste'] !='' and t:attribute[@name = 'compound_order_maste']) and (t:attribute[@name = 'compound_order_slave'] = 'NULL' or t:attribute[@name = 'compound_order_slave'] = '' or not(t:attribute[@name = 'compound_order_slave']))">
					<field name="COM.ORDER.MASTER">
						<xsl:value-of select="'YES'"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:PERCENTAGE">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:targetNature = '6' or b:targetNature = '7'">
					<field name="PERCENTAGE">
						<xsl:value-of select="b:targetObjective"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'target_nature_e'] = '6' or t:attribute[@name = 'target_nature_e'] = '7'">
					<field name="PERCENTAGE">
						<xsl:value-of select="t:attribute[@name = 'target_n']"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:SWITCH.ORDER">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:subType/infra:code != ''">
					<field name="SWITCH.ORDER">
						<xsl:choose>
							<xsl:when test="contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,''))">
								<xsl:value-of select="'INTERFUND'"/>
							</xsl:when>
							<xsl:when test="contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,''))">
								<xsl:value-of select="'INTRAFUND'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'subTypeCode'] != ''">
					<field name="SWITCH.ORDER">
						<xsl:choose>
							<xsl:when test="contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))">
								<xsl:value-of select="'INTERFUND'"/>
							</xsl:when>
							<xsl:when test="contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))">
								<xsl:value-of select="'INTRAFUND'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:SWITCH.QTY">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))">
					<field name="SWITCH.QTY">
						<xsl:choose>
							<xsl:when test="b:targetNature = '1'">
								<xsl:value-of select="'UNIT'"/>
							</xsl:when>
							<xsl:when test="b:targetNature = '2'">
								<xsl:value-of select="'AMOUNT'"/>
							</xsl:when>
							<xsl:when test="b:targetNature = '6' or b:targetNature = '7'">
								<xsl:value-of select="'PERCENTAGE'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'subTypeCode'] != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')) or contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')))">
					<field name="SWITCH.QTY">
						<xsl:choose>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '1'">
								<xsl:value-of select="'UNIT'"/>
							</xsl:when>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2'">
								<xsl:value-of select="'AMOUNT'"/>
							</xsl:when>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '6' or t:attribute[@name = 'target_nature_e'] = '7'">
								<xsl:value-of select="'PERCENTAGE'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:transactionFeesTaxesCounter">
		<xsl:choose>
			<xsl:when test="not(//t:F2B_FORMAT)">
				<xsl:call-template name="printOrderFeesAndTaxes">
					<xsl:with-param name="caller" select="'OrderInstruction'"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:call-template name="printOrderFeesAndTaxes">
					<xsl:with-param name="caller" select="'OrderTaxLots'"/>
				</xsl:call-template>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:INVEST.OPTION.TYPE">
		<field name="INVEST.OPTION.TYPE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:paymentOptionE = '1'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="b:paymentOptionE = '2'">
							<xsl:value-of select="'REINVEST'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'payment_option_e'] = '1'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'payment_option_e'] = '2'">
							<xsl:value-of select="'REINVEST'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:ORDER.NUMBER"/>
	<xsl:template name="secopenorder2:ORDER.DATE"/>
	<xsl:template name="secopenorder2:ORDER.TIME">
		<xsl:variable name="utcDateTime" select="substring-after(b:initiationDateTime,'T')"/>
		<xsl:variable name="utcDate" select="concat(substring-before($utcDateTime,'.'),':',substring-after($utcDateTime,'.'))"/>
		<field name="ORDER.TIME">
			<xsl:value-of select="substring-before($utcDate,'+')"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:VALUE.DATE"/>
	<xsl:template name="secopenorder2:MATURITY.DATE"/>
	<xsl:template name="secopenorder2:TYPE.OF.TRADE"/>
	<xsl:template name="secopenorder2:SPLIT.CHRGS"/>
	<xsl:template name="secopenorder2:CASH.ROUNDING">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:targetNature = '5'">
					<field name="CASH.ROUNDING">
						<xsl:value-of select="$CASHROUNDING_NET"/>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'target_nature_e'] = '5'">
					<field name="CASH.ROUNDING">
						<xsl:value-of select="$CASHROUNDING_NET"/>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.ORD.NATURE">
		<field name="TAP.ORD.NATURE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
							<xsl:value-of select="'DMA'"/>
						</xsl:when>
						<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
							<xsl:value-of select="'NDMA'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'stp_order_e'] = '1'">
							<xsl:value-of select="'DMA'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'stp_order_e'] = '0'">
							<xsl:value-of select="'NDMA'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:MARKET.PRICE">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:orderType = '1'">
					<field name="MARKET.PRICE">
						<xsl:value-of select="b:price"/>
					</field>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:STP.ORDER">
		<field name="STP.ORDER">
			<xsl:value-of select="$stpOrderFix"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:CU.EX.RATE.ACC"/>
	<xsl:template name="secopenorder2:SETTLEMENT.CCY"/>
	<xsl:template name="secopenorder2:CU.BRKR.COMM"/>
	<xsl:template name="secopenorder2:WAIVE.CU.BR.COM"/>
	<xsl:template name="secopenorder2:RESERVED.9"/>
	<xsl:template name="secopenorder2:RESERVED.8"/>
	<xsl:template name="secopenorder2:CU.FOREIGN.FEE"/>
	<xsl:template name="secopenorder2:CU.COMM.TAX"/>
	<xsl:template name="secopenorder2:CU.STAMP.TAX"/>
	<xsl:template name="secopenorder2:CU.EBV.FEES"/>
	<xsl:template name="secopenorder2:CU.FEES.MISC"/>
	<xsl:template name="secopenorder2:CU.DISC.PCENT"/>
	<xsl:template name="secopenorder2:CU.DISC.AMT"/>
	<xsl:template name="secopenorder2:CU.WHT.PERC"/>
	<xsl:template name="secopenorder2:CU.WHT.TAX"/>
	<xsl:template name="secopenorder2:COMM.CODE"/>
	<xsl:template name="secopenorder2:COMM.PERCENT"/>
	<xsl:template name="secopenorder2:COM.TAX.CODE"/>
	<xsl:template name="secopenorder2:COM.TAX.BCUR"/>
	<xsl:template name="secopenorder2:COM.TAX.XRTE"/>
	<xsl:template name="secopenorder2:CU.DEPOSITORY"/>
	<xsl:template name="secopenorder2:SUB.ACCOUNT">
	<field name="SUB.ACCOUNT">
			<xsl:value-of select="substring-after(b:depositaryAccount/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:PORT.CONST.NO"/>
	<xsl:template name="secopenorder2:CU.BROKER.NO"/>
	<xsl:template name="secopenorder2:CU.NOTES"/>
	<xsl:template name="secopenorder2:CU.ENTL.ID"/>
	<xsl:template name="secopenorder2:CU.INT.CTR"/>
	<xsl:template name="secopenorder2:BUYING.POWER"/>
	<xsl:template name="secopenorder2:EXT.CUSTODIAN"/>
	<xsl:template name="secopenorder2:CU.INCOME.ACC"/>
	<xsl:template name="secopenorder2:CU.INCOME.CCY"/>
	<xsl:template name="secopenorder2:LINK.ORDER.NO"/>
	<xsl:template name="secopenorder2:NOMINEE.CODE"/>
	<xsl:template name="secopenorder2:ACCOUNT.MANAGER"/>
	<xsl:template name="secopenorder2:BROKER"/>
	<xsl:template name="secopenorder2:DATE.TO.BROKER"/>
	<xsl:template name="secopenorder2:TIME.TO.BROKER"/>
	<xsl:template name="secopenorder2:AMT.TO.BROKER"/>
	<xsl:template name="secopenorder2:BR.CASH.AMT"/>
	<xsl:template name="secopenorder2:BR.PRICE"/>
	<xsl:template name="secopenorder2:BROKER.TYPE"/>
	<xsl:template name="secopenorder2:BR.SEC.ACCT"/>
	<xsl:template name="secopenorder2:BR.ACC.NO"/>
	<xsl:template name="secopenorder2:BR.ACCOUNT.CCY"/>
	<xsl:template name="secopenorder2:BR.EX.RATE.ACC"/>
	<xsl:template name="secopenorder2:BR.DELIV.INSTR"/>
	<xsl:template name="secopenorder2:EXE.BY.BROKER"/>
	<xsl:template name="secopenorder2:BANK.CORRES"/>
	<xsl:template name="secopenorder2:BROK.CORRES"/>
	<xsl:template name="secopenorder2:DELIVERY.KEY"/>
	<xsl:template name="secopenorder2:SECURITIES.CR.DR"/>
	<xsl:template name="secopenorder2:REFERENCE.NO"/>
	<xsl:template name="secopenorder2:CUSTOMER.NO"/>
	<xsl:template name="secopenorder2:SEC.ACC.NO"/>
	<xsl:template name="secopenorder2:BROKER.NO"/>
	<xsl:template name="secopenorder2:EXE.DETAIL"/>
	<xsl:template name="secopenorder2:NO.NOM.FILLED"/>
	<xsl:template name="secopenorder2:TRADE.PRICE"/>
	<xsl:template name="secopenorder2:TRADE.DATE"/>
	<xsl:template name="secopenorder2:TRADE.TIME"/>
	<xsl:template name="secopenorder2:ORDER.NOMINAL"/>
	<xsl:template name="secopenorder2:LIQUIDATION.PERIOD"/>
	<xsl:template name="secopenorder2:PREMIUM.PRICE"/>
	<xsl:template name="secopenorder2:MARKET.TYPE"/>
	<xsl:template name="secopenorder2:VAL.IN.SETT.CCY"/>
	<xsl:template name="secopenorder2:VERIFY.BY.DEALER"/>
	<xsl:template name="secopenorder2:LOCAL.REF"/>
	<xsl:template name="secopenorder2:CUST.DEPO"/>
	<xsl:template name="secopenorder2:CU.DEPO.NOM"/>
	<xsl:template name="secopenorder2:CU.NOM.CODE"/>
	<xsl:template name="secopenorder2:RESERVED07"/>
	<xsl:template name="secopenorder2:GROUP.ORDER"/>
	<xsl:template name="secopenorder2:ODD.LOT.ORDER"/>
	<xsl:template name="secopenorder2:ACTIVITY.CODE"/>
	<xsl:template name="secopenorder2:MSG.BROKER"/>
	<xsl:template name="secopenorder2:MSG.NO"/>
	<xsl:template name="secopenorder2:MSG.CLASS"/>
	<xsl:template name="secopenorder2:OVR.CARRIER"/>
	<xsl:template name="secopenorder2:OVR.ADDRESS"/>
	<xsl:template name="secopenorder2:SEND.ADVICE"/>
	<xsl:template name="secopenorder2:SOFT.DLVRY.KEY"/>
	<xsl:template name="secopenorder2:ROUT.COMPANY"/>
	<xsl:template name="secopenorder2:CUM.EX.IND"/>
	<xsl:template name="secopenorder2:WHT.TAX.CODE"/>
	<xsl:template name="secopenorder2:SEGMENT"/>
	<xsl:template name="secopenorder2:DEF.DEAL.DESK"/>
	<xsl:template name="secopenorder2:ACT.DEAL.DESK"/>
	<xsl:template name="secopenorder2:INT.CTR"/>
	<xsl:template name="secopenorder2:SERVICE.REF"/>
	<xsl:template name="secopenorder2:THREAD.KEY"/>
	<xsl:template name="secopenorder2:TRADED.NOM"/>
	<xsl:template name="secopenorder2:OUTSTAND.NOM"/>
	<xsl:template name="secopenorder2:TRADER.CODE"/>
	<xsl:template name="secopenorder2:TRADER.DESC"/>
	<xsl:template name="secopenorder2:ROUT.SEC.ACC"/>
	<xsl:template name="secopenorder2:ROUT.BROKER"/>
	<xsl:template name="secopenorder2:ROUTED.ORDER.REF"/>
	<xsl:template name="secopenorder2:IN.HOUSE.SEC.ACC"/>
	<xsl:template name="secopenorder2:IN.HOUSE.CUSTODIAN"/>
	<xsl:template name="secopenorder2:REVERSE.CHILD"/>
	<xsl:template name="secopenorder2:EXE.HLT"/>
	<xsl:template name="secopenorder2:TRADE.HLT"/>
	<xsl:template name="secopenorder2:AUTHORISE.CHILD"/>
	<xsl:template name="secopenorder2:DELETE.CHILD"/>
	<xsl:template name="secopenorder2:ROUNDING.FACTOR"/>
	<xsl:template name="secopenorder2:MKT.IDN.CODE"/>
	<xsl:template name="secopenorder2:BULK.UPDATE"/>
	<xsl:template name="secopenorder2:RESERVED9"/>
	<xsl:template name="secopenorder2:RESERVED8"/>
	<xsl:template name="secopenorder2:RESERVED7"/>
	<xsl:template name="secopenorder2:RESERVED6"/>
	<xsl:template name="secopenorder2:RESERVED5"/>
	<xsl:template name="secopenorder2:RESERVED4"/>
	<xsl:template name="secopenorder2:RESERVED3"/>
	<xsl:template name="secopenorder2:RESERVED2"/>
	<xsl:template name="secopenorder2:RESERVED1"/>
	<xsl:template name="secopenorder2:OVERRIDE"/>
	<xsl:template name="secopenorder2:RECORD.STATUS"/>
	<xsl:template name="secopenorder2:CURR.NO"/>
	<xsl:template name="secopenorder2:INPUTTER"/>
	<xsl:template name="secopenorder2:DATE.TIME"/>
	<xsl:template name="secopenorder2:AUTHORISER"/>
	<xsl:template name="secopenorder2:CO.CODE"/>
	<xsl:template name="secopenorder2:DEPT.CODE"/>
	<xsl:template name="secopenorder2:AUDITOR.CODE"/>
	<xsl:template name="secopenorder2:AUDIT.DATE.TIME"/>
	<xsl:template name="secopenorder2:USERDEF.FIELDS"/>
	<xsl:template name="secopenorder2:ModelBankSpecificFields"/>
	<xsl:template name="secopenorder2:ModelBankSpecificFields-Custo"/>
	<xsl:template name="secopenorder2:TAP.SLEEVE.ACC">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:boPortfolio/infra:code != ''">
					<field name="TAP.SLEEVE.ACC">
						<xsl:value-of select="b:currentAccount/infra:code"/>
					</field>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.SLEEVE.PTF">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:boPortfolio/infra:code != ''">
					<field name="TAP.SLEEVE.PTF">
						<xsl:value-of select="b:portfolio/infra:code"/>
					</field>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.HIER.ORDER">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<field name="TAP.HIER.ORDER">
					<xsl:value-of select="b:hierOperNature"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:UTC.DATE.TIME"/>


	<!--  start instruction.IPO.SEC.OPEN.ORDER -->
	<xsl:template name="secopenorder3:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.TYPE.1">
		<field name="CU.BID.TYPE:1">
			<xsl:choose>
				<xsl:when test="b:bidType = '1'">
					<xsl:value-of select="'COMPETITIVE'"/>
				</xsl:when>
				<xsl:when test="b:bidType = '2'">
					<xsl:value-of select="'NON-COMPETITIVE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CUST.ACC.NO.1">
		<field name="CUST.ACC.NO:1">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CUST.NUMBER.1">
		<field name="CUST.NUMBER:1">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:client/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.QUANTITY.1.1">
		<field name="CU.BID.QUANTITY:1:1">
			<xsl:choose>
				<xsl:when test="b:targetObjective">
					<xsl:value-of select="b:targetObjective"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:bid1Quantity"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.PRICE.1.1">
		<field name="CU.BID.PRICE:1:1">
			<xsl:choose>
				<xsl:when test="b:bid1Quote">
					<xsl:value-of select="b:bid1Quote"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='quote_n']/infra:value">
					<xsl:value-of select="b:userDefinedField[infra:name='quote_n']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.QUANTITY.1.2">
		<xsl:if test="b:bid2Quantity and b:bid2Quantity != '0'">
			<field name="CU.BID.QUANTITY:1:2">
				<xsl:value-of select="b:bid2Quantity"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.PRICE.1.2">
		<xsl:if test="b:bid2Quote">
			<field name="CU.BID.PRICE:1:2">
				<xsl:value-of select="b:bid2Quote"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.QUANTITY.1.3">
		<xsl:if test="b:bid3Quantity and b:bid3Quantity != '0'">
			<field name="CU.BID.QUANTITY:1:3">
				<xsl:value-of select="b:bid3Quantity"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder3:CU.BID.PRICE.1.3">
		<xsl:if test="b:bid3Quote">
			<field name="CU.BID.PRICE:1:3">
				<xsl:value-of select="b:bid3Quote"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder3:SECURITY.ACCNT.1">
		<field name="SECURITY.ACCNT:1">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:SECURITY.NO">
		<field name="SECURITY.NO">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:ORDER.NUMBER"/>
	<xsl:template name="secopenorder3:ORDER.DATE"/>
	<xsl:template name="secopenorder3:ORDER.TIME"/>
	<xsl:template name="secopenorder3:VALUE.DATE"/>
	<xsl:template name="secopenorder3:MATURITY.DATE"/>
	<xsl:template name="secopenorder3:ORDER.TYPE"/>
	<xsl:template name="secopenorder3:TYPE.OF.TRADE"/>
	<xsl:template name="secopenorder3:TRANSACTION.CODE"/>
	<xsl:template name="secopenorder3:TRADE.CCY"/>
	<xsl:template name="secopenorder3:CUST.NUMBER"/>
	<xsl:template name="secopenorder3:SECURITY.ACCNT"/>
	<xsl:template name="secopenorder3:NO.NOMINAL"/>
	<xsl:template name="secopenorder3:CU.CASH.AMOUNT"/>
	<xsl:template name="secopenorder3:CURR.PRICE"/>
	<xsl:template name="secopenorder3:CALC.CHRGS"/>
	<xsl:template name="secopenorder3:CASH.CHRGS"/>
	<xsl:template name="secopenorder3:SPLIT.CHRGS"/>
	<xsl:template name="secopenorder3:CASH.ROUNDING"/>
	<xsl:template name="secopenorder3:ADJUST.COMM"/>
	<xsl:template name="secopenorder3:NARRATIVE"/>
	<xsl:template name="secopenorder3:CUST.ACC.NO"/>
	<xsl:template name="secopenorder3:CU.EX.RATE.ACC"/>
	<xsl:template name="secopenorder3:SETTLEMENT.CCY"/>
	<xsl:template name="secopenorder3:WAIVE.CU.BR.COM"/>
	<xsl:template name="secopenorder3:RESERVED.9"/>
	<xsl:template name="secopenorder3:RESERVED.8"/>
	<xsl:template name="secopenorder3:CU.DISC.PCENT"/>
	<xsl:template name="secopenorder3:CU.WHT.PERC"/>
	<xsl:template name="secopenorder3:COMM.CODE"/>
	<xsl:template name="secopenorder3:COMM.PERCENT"/>
	<xsl:template name="secopenorder3:COM.TAX.CODE"/>
	<xsl:template name="secopenorder3:COM.TAX.BCUR"/>
	<xsl:template name="secopenorder3:COM.TAX.XRTE"/>
	<xsl:template name="secopenorder3:CU.DEPOSITORY"/>
	<xsl:template name="secopenorder3:SUB.ACCOUNT"/>
	<xsl:template name="secopenorder3:PORT.CONST.NO"/>
	<xsl:template name="secopenorder3:CU.BROKER.NO"/>
	<xsl:template name="secopenorder3:CU.NOTES"/>
	<xsl:template name="secopenorder3:CU.ENTL.ID"/>
	<xsl:template name="secopenorder3:CU.INT.CTR"/>
	<xsl:template name="secopenorder3:BUYING.POWER"/>
	<xsl:template name="secopenorder3:EXT.CUSTODIAN"/>
	<xsl:template name="secopenorder3:CU.INCOME.ACC"/>
	<xsl:template name="secopenorder3:CU.INCOME.CCY"/>
	<xsl:template name="secopenorder3:LIMIT.PRICE"/>
	<xsl:template name="secopenorder3:LIMIT.TYPE"/>
	<xsl:template name="secopenorder3:LIMIT.EXP.DATE"/>
	<xsl:template name="secopenorder3:LINK.ORDER.NO"/>
	<xsl:template name="secopenorder3:DEPOSITORY"/>
	<xsl:template name="secopenorder3:NOMINEE.CODE"/>
	<xsl:template name="secopenorder3:ACCOUNT.MANAGER"/>
	<xsl:template name="secopenorder3:ACCT.NARRATIVE"/>
	<xsl:template name="secopenorder3:BROKER"/>
	<xsl:template name="secopenorder3:DATE.TO.BROKER"/>
	<xsl:template name="secopenorder3:TIME.TO.BROKER"/>
	<xsl:template name="secopenorder3:AMT.TO.BROKER"/>
	<xsl:template name="secopenorder3:BR.CASH.AMT"/>
	<xsl:template name="secopenorder3:BR.PRICE"/>
	<xsl:template name="secopenorder3:BROKER.TYPE"/>
	<xsl:template name="secopenorder3:BR.SEC.ACCT"/>
	<xsl:template name="secopenorder3:BR.ACC.NO"/>
	<xsl:template name="secopenorder3:BR.ACCOUNT.CCY"/>
	<xsl:template name="secopenorder3:BR.EX.RATE.ACC"/>
	<xsl:template name="secopenorder3:BR.DELIV.INSTR"/>
	<xsl:template name="secopenorder3:EXE.BY.BROKER"/>
	<xsl:template name="secopenorder3:BANK.CORRES"/>
	<xsl:template name="secopenorder3:BROK.CORRES"/>
	<xsl:template name="secopenorder3:CONFIRMATION"/>
	<xsl:template name="secopenorder3:DELIVERY.KEY"/>
	<xsl:template name="secopenorder3:SECURITIES.CR.DR"/>
	<xsl:template name="secopenorder3:REFERENCE.NO"/>
	<xsl:template name="secopenorder3:CUSTOMER.NO"/>
	<xsl:template name="secopenorder3:SEC.ACC.NO"/>
	<xsl:template name="secopenorder3:BROKER.NO"/>
	<xsl:template name="secopenorder3:EXE.DETAIL"/>
	<xsl:template name="secopenorder3:NO.NOM.FILLED"/>
	<xsl:template name="secopenorder3:TRADE.PRICE"/>
	<xsl:template name="secopenorder3:TRADE.DATE"/>
	<xsl:template name="secopenorder3:TRADE.TIME"/>
	<xsl:template name="secopenorder3:ORDER.NOMINAL"/>
	<xsl:template name="secopenorder3:LIQUIDATION.PERIOD"/>
	<xsl:template name="secopenorder3:PREMIUM.PRICE"/>
	<xsl:template name="secopenorder3:MARKET.TYPE"/>
	<xsl:template name="secopenorder3:DEAL.STATUS"/>
	<xsl:template name="secopenorder3:DEAL.NARRATIVE"/>
	<xsl:template name="secopenorder3:VAL.IN.SETT.CCY"/>
	<xsl:template name="secopenorder3:VERIFY.BY.DEALER"/>
	<xsl:template name="secopenorder3:LOCAL.REF"/>
	<xsl:template name="secopenorder3:CUST.DEPO"/>
	<xsl:template name="secopenorder3:CU.DEPO.NOM"/>
	<xsl:template name="secopenorder3:CU.NOM.CODE"/>
	<xsl:template name="secopenorder3:RESERVED07"/>
	<xsl:template name="secopenorder3:STOCK.EXCHANGE">
		<xsl:if test="b:stockExchange/infra:code != ''">
			<field name="STOCK.EXCHANGE">
				<xsl:value-of select="b:stockExchange/infra:code"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="secopenorder3:GROUP.ORDER"/>
	<xsl:template name="secopenorder3:ODD.LOT.ORDER"/>
	<xsl:template name="secopenorder3:ACTIVITY.CODE"/>
	<xsl:template name="secopenorder3:MSG.BROKER"/>
	<xsl:template name="secopenorder3:MSG.NO"/>
	<xsl:template name="secopenorder3:MSG.CLASS"/>
	<xsl:template name="secopenorder3:OVR.CARRIER"/>
	<xsl:template name="secopenorder3:OVR.ADDRESS"/>
	<xsl:template name="secopenorder3:SEND.ADVICE"/>
	<xsl:template name="secopenorder3:SOFT.DLVRY.KEY"/>
	<xsl:template name="secopenorder3:ROUT.COMPANY"/>
	<xsl:template name="secopenorder3:CUM.EX.IND"/>
	<xsl:template name="secopenorder3:WHT.TAX.CODE"/>
	<xsl:template name="secopenorder3:SEGMENT"/>
	<xsl:template name="secopenorder3:DEF.DEAL.DESK"/>
	<xsl:template name="secopenorder3:ACT.DEAL.DESK"/>
	<xsl:template name="secopenorder3:INT.CTR"/>
	<xsl:template name="secopenorder3:SERVICE.REF"/>
	<xsl:template name="secopenorder3:THREAD.KEY"/>
	<xsl:template name="secopenorder3:TRADED.NOM"/>
	<xsl:template name="secopenorder3:OUTSTAND.NOM"/>
	<xsl:template name="secopenorder3:TRADER.CODE"/>
	<xsl:template name="secopenorder3:TRADER.DESC"/>
	<xsl:template name="secopenorder3:ROUT.SEC.ACC"/>
	<xsl:template name="secopenorder3:ROUT.BROKER"/>
	<xsl:template name="secopenorder3:ROUTED.ORDER.REF"/>
	<xsl:template name="secopenorder3:IN.HOUSE.SEC.ACC"/>
	<xsl:template name="secopenorder3:IN.HOUSE.CUSTODIAN"/>
	<xsl:template name="secopenorder3:STP.ORDER"/>
	<xsl:template name="secopenorder3:AUTHORISE.TRADE"/>
	<xsl:template name="secopenorder3:PARENT"/>
	<xsl:template name="secopenorder3:PARENT.REFERENCE"/>
	<xsl:template name="secopenorder3:REVERSE.CHILD"/>
	<xsl:template name="secopenorder3:EXE.HLT"/>
	<xsl:template name="secopenorder3:TRADE.HLT"/>
	<xsl:template name="secopenorder3:AUTHORISE.CHILD"/>
	<xsl:template name="secopenorder3:DELETE.CHILD"/>
	<xsl:template name="secopenorder3:ROUNDING.FACTOR"/>
	<xsl:template name="secopenorder3:MKT.IDN.CODE"/>
	<xsl:template name="secopenorder3:BULK.UPDATE"/>
	<xsl:template name="secopenorder3:RESERVED9"/>
	<xsl:template name="secopenorder3:RESERVED8"/>
	<xsl:template name="secopenorder3:RESERVED7"/>
	<xsl:template name="secopenorder3:RESERVED6"/>
	<xsl:template name="secopenorder3:RESERVED5"/>
	<xsl:template name="secopenorder3:RESERVED4"/>
	<xsl:template name="secopenorder3:RESERVED3"/>
	<xsl:template name="secopenorder3:RESERVED2"/>
	<xsl:template name="secopenorder3:RESERVED1"/>
	<xsl:template name="secopenorder3:OVERRIDE"/>
	<xsl:template name="secopenorder3:RECORD.STATUS"/>
	<xsl:template name="secopenorder3:CURR.NO"/>
	<xsl:template name="secopenorder3:INPUTTER"/>
	<xsl:template name="secopenorder3:DATE.TIME"/>
	<xsl:template name="secopenorder3:AUTHORISER"/>
	<xsl:template name="secopenorder3:CO.CODE"/>
	<xsl:template name="secopenorder3:DEPT.CODE"/>
	<xsl:template name="secopenorder3:AUDITOR.CODE"/>
	<xsl:template name="secopenorder3:AUDIT.DATE.TIME"/>
	<xsl:template name="secopenorder3:USERDEF.FIELDS"/>
	<xsl:template name="secopenorder3:TXN.CHANNEL"/>
	<xsl:template name="secopenorder3:COM.ORDER.COUNT"/>
	<xsl:template name="secopenorder3:COM.ORDER.MASTER"/>
	<xsl:template name="secopenorder3:COM.ORDER.REF"/>
	<xsl:template name="secopenorder3:PERCENTAGE"/>
	<xsl:template name="secopenorder3:SWITCH.ORDER"/>
	<xsl:template name="secopenorder3:SWITCH.QTY"/>
	<xsl:template name="secopenorder3:transactionFeesTaxesCounter"/>
	<xsl:template name="secopenorder3:INVEST.OPTION.TYPE"/>
	<xsl:template name="secopenorder3:ModelBankSpecificFields"/>
	<xsl:template name="secopenorder3:ModelBankSpecificFields-Custo"/>
	<!-- end instruction.IPO.SEC.OPEN.ORDER -->
	<xsl:template name="dxorder:transactionId">
			<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value != 'NULL'">
				<transactionId>
					<xsl:value-of select="b:userDefinedField[infra:name='source_code']/infra:value"/>
				</transactionId>
			</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:CONTRACT.CODE">
		<field name="CONTRACT.CODE">
			<xsl:value-of select="substring-before(b:security/infra:code,'/')"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:MATURITY.DATE">
		<field name="MATURITY.DATE">
			<xsl:value-of select="substring-before(substring-after(substring-after(b:security/infra:code,'/'),'/'),'/')"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:OPTION.TYPE">
		<field name="OPTION.TYPE">
			<xsl:value-of select="substring-before(substring-after(substring-after(substring-after(b:security/infra:code,'/'),'/'),'/'),'/')"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:STRIKE.PRICE">
		<field name="STRIKE.PRICE">
			<xsl:value-of select="substring-before(substring-after(substring-after(substring-after(substring-after(b:security/infra:code,'/'),'/'),'/'),'/'),'/')"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.CUST.NO">
		<field name="PRI.CUST.NO">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:client/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.SEC.ACC">
		<field name="PRI.SEC.ACC">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.ACCOUNT">
	<xsl:if test="b:bulkChildIndicator != '2'">
		<field name="PRI.ACCOUNT">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:NARRATIVE">
		<field name="NARRATIVE">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_3_c']/infra:value,1,35)"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.LOTS">
		<xsl:if test="b:targetNature != '2' and b:userDefinedField[infra:name='source_code']/infra:value = 'NULL'">
			<field name="PRI.LOTS">
				<xsl:value-of select="translate(b:quantity,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:PRI.BUY.SELL">
		<field name="PRI.BUY.SELL">
			<xsl:choose>
				<xsl:when test="b:buySellIndicator ='1'">
					<xsl:value-of select="'BUY'"/>
				</xsl:when>
				<xsl:when test="b:buySellIndicator ='2'">
					<xsl:value-of select="'SELL'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.OPEN.CLOSE">
		<field name="PRI.OPEN.CLOSE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '1'">
					<xsl:value-of select="'OPEN'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:value-of select="'CLOSE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:CLOSEOUT.TRADE">
		<field name="CLOSEOUT.TRADE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:choose>
						<xsl:when test="contains(b:userDefinedField[infra:name='ref_oper_code']/infra:value,$COMPANY_POSTFIX_SEPARATOR)">
							<xsl:value-of select="substring-before(b:userDefinedField[infra:name='ref_oper_code']/infra:value,$COMPANY_POSTFIX_SEPARATOR)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:userDefinedField[infra:name='ref_oper_code']/infra:value"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:CLOSEOUT.LOTS">
		<field name="CLOSEOUT.LOTS">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:value-of select="translate(b:quantity,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.CLOSEOUT">
		<field name="ORDER.CLOSEOUT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:value-of select="'CLOSE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:AUTO.AUTHORISE">
		<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value = 'NULL'">
			<field name="AUTO.AUTHORISE">
				<xsl:value-of select="$DX_AUTO_AUTHORISE"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:LIMIT.DATE">
		<field name="LIMIT.DATE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
					<xsl:value-of select="20991231"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(b:validityDate,'-','')"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:LIMIT.PRICE">
		<field name="LIMIT.PRICE">
			<xsl:choose>
				<xsl:when test="b:orderType = '3' and b:stopPrice != ''">
					<xsl:value-of select="b:stopPrice"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:limitPrice != ''">
						<xsl:value-of select="b:limitPrice"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.TYPE">
		<field name="ORDER.TYPE">
			<xsl:choose>
				<xsl:when test="b:orderValidityType = '1'">
					<xsl:value-of select="'GTD'"/>
				</xsl:when>
				<xsl:when test="b:orderValidityType = '2'">
					<xsl:value-of select="'GTC'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:LIMIT.TYPE">
		<field name="LIMIT.TYPE">
			<xsl:choose>
				<xsl:when test="b:orderType = '1'">
					<xsl:value-of select="'MARKET'"/>
				</xsl:when>
				<xsl:when test="b:orderType = '2'">
					<xsl:value-of select="'LIMIT'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:SEC.CUST.NO">
		<field name="SEC.CUST.NO">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:EXECUTING.BROKER">
		<field name="EXECUTING.BROKER">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2' ">
					<xsl:value-of select="substring-after(b:broker/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:SEC.OPEN.CLOSE">
		<field name="SEC.OPEN.CLOSE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '1'">
					<xsl:value-of select="'OPEN'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='derivative_ord_e']/infra:value = '2'">
					<xsl:value-of select="'CLOSE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.AMEND">
		<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value != 'NULL'">
			<field name="ORDER.AMEND">
				<xsl:value-of select="'YES'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.LOTS">
		<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value != 'NULL' and b:targetNature != '2'">
			<field name="ORDER.LOTS">
				<xsl:value-of select="b:quantity"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:ORDER.STATUS">
		<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value != 'NULL' and b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
			<field name="ORDER.STATUS">
				<xsl:value-of select="'MODIFICATION REQUEST'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:transactionFeesTaxesCounter">
		<xsl:call-template name="printDxOrderFeesAndTaxes">
			<xsl:with-param name="caller" select="'OrderInstructionUpdate'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="dxorder:PRI.CHANNEL">
		<field name="PRI.CHANNEL">
			<xsl:choose>
				<xsl:when test="b:contactMethod = 'PCK_GL_FAX'">
					<xsl:value-of select="'ELECTRONIC'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_INTERNET'">
					<xsl:value-of select="'ONLINE'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_MEETING' or b:contactMethod = 'PCK_GL_LETTER' or b:contactMethod = 'PCK_GL_OTHER' or b:contactMethod = 'PCK_GL_EMAIL'">
					<xsl:value-of select="'RM'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_PHONE'">
					<xsl:value-of select="'TELEPHONE'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:EXOTIC.TYPE">
		<field name="EXOTIC.TYPE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '114'">
					<xsl:value-of select="'KNOCKIN'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '115'">
					<xsl:value-of select="'KNOCKOUT'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '50'">
					<xsl:value-of select="'KOKO'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '92'">
					<xsl:value-of select="'KIKI'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '93'">
					<xsl:value-of select="'KIKO'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value = '88'">
					<xsl:value-of select="'DIGITAL'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:USR.FLD.VAL.1.1">
		<field name="USR.FLD.VAL:1:1">
			<xsl:variable name="Securitycodevar">
				<xsl:value-of select="substring-before(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(concat(b:security/infra:code,'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/')"/>
			</xsl:variable>
			<xsl:variable name="instsubnature">
				<xsl:value-of select="'114 115 50 92 93'"/>
			</xsl:variable>
			<xsl:if test="contains($instsubnature,b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value)">
				<xsl:value-of select="$Securitycodevar"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:USR.FLD.VAL.1.2">
		<field name="USR.FLD.VAL:1:2">
			<xsl:variable name="Securitycodevar">
				<xsl:value-of select="substring-before(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(concat(b:security/infra:code,'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/'),'/')"/>
			</xsl:variable>
			<xsl:variable name="instsubnature">
				<xsl:value-of select="'50 92 93'"/>
			</xsl:variable>
			<xsl:if test="contains($instsubnature,b:userDefinedField[infra:name='ud_instr_sub_nat_e']/infra:value)">
				<xsl:value-of select="$Securitycodevar"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:SEC.PRICE"/>
	<xsl:template name="dxorder:ORDER.ID"/>
	<xsl:template name="dxorder:EXCHANGE.CODE"/>
	<xsl:template name="dxorder:SUB.ASSET.TYPE"/>
	<xsl:template name="dxorder:TRADE.STATUS"/>
	<xsl:template name="dxorder:TRADE.DATE"/>
	<xsl:template name="dxorder:INP.MAT.DATE"/>
	<xsl:template name="dxorder:TRADE.TYPE"/>
	<xsl:template name="dxorder:DEC.DATE"/>
	<xsl:template name="dxorder:CONTRACT.CCY"/>
	<xsl:template name="dxorder:TRADE.CCY"/>
	<xsl:template name="dxorder:TRANSFER.TYPE"/>
	<xsl:template name="dxorder:OPTION.STYLE">
	<xsl:variable name="optStyle" select="substring-after(substring-after(substring-after(substring-after(substring-after(substring-after(b:security/infra:code,'/'),'/'),'/'),'/'),'/'),'/')"/>
		<xsl:variable name="dxorderOptionStyle">
			<xsl:choose>
				<xsl:when test="contains($optStyle,'/')">
					<xsl:value-of select="substring-before($optStyle,'/')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$optStyle"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="b:userDefinedField[infra:name='source_code']/infra:value = 'NULL'">
		<field name="OPTION.STYLE">
			<xsl:choose>
				<xsl:when test="$dxorderOptionStyle = 'A'">
					<xsl:value-of select="'AMERICAN'"/>
				</xsl:when>
				<xsl:when test="$dxorderOptionStyle = 'E'">
					<xsl:value-of select="'EUROPEAN'"/>
				</xsl:when>
				<xsl:when test="$dxorderOptionStyle = 'C'">
					<xsl:value-of select="'CARRIBEAN'"/>
				</xsl:when>
			</xsl:choose>
		</field>
		</xsl:if>
	</xsl:template>

	<xsl:template name="dxorder:INT.STRIKE.PRICE"/>
	<xsl:template name="dxorder:PREMIUM.DUE"/>
	<xsl:template name="dxorder:CURRENCY.MARKET"/>
	<xsl:template name="dxorder:POSITION.TYPE"/>
	<xsl:template name="dxorder:CONTRACT.TIME"/>
	<xsl:template name="dxorder:DEALER.DESK"/>
	<xsl:template name="dxorder:DEPT.ACCT.OFFICER"/>
	<xsl:template name="dxorder:EXTERNAL.REF"/>
	<xsl:template name="dxorder:DLV.CCY"/>
	<xsl:template name="dxorder:REGION"/>
	<xsl:template name="dxorder:VALUATION.PRICE"/>
	<xsl:template name="dxorder:PRI.PRICE"/>
	<xsl:template name="dxorder:PRI.INT.PRICE"/>
	<xsl:template name="dxorder:PRI.TRADE.COST"/>
	<xsl:template name="dxorder:PRI.CUST.TYPE"/>
	<xsl:template name="dxorder:PRI.CUST.STATUS"/>
	<xsl:template name="dxorder:PRI.ORIG.LOTS"/>
	<xsl:template name="dxorder:PRI.SETTNOS"/>
	<xsl:template name="dxorder:PRI.SETTLOTS"/>
	<xsl:template name="dxorder:PRI.HEDGE.TRADE">
		<xsl:if test="b:hedgeTrade = '1'">
			<field name="PRI.HEDGE.TRADE">
				<xsl:value-of select="'COVERED'"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="dxorder:PRI.LINK">
		<xsl:choose>

			<xsl:when test="b:hedgeTrade != '1'">
				<field name="PRI.LINK">
					<xsl:value-of select="b:compoundOrderCode"/>
				</field>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dxorder:PRI.STRATEGY">
		<xsl:choose>
			<xsl:when test="b:hedgeTrade = '0'"/>
			<xsl:when test="b:hedgeTrade != '1'">
				<xsl:if test="contains($dxStrategyTypes,concat(' ',b:orderTypeD/infra:code,' '))">
					<field name="PRI.STRATEGY">
						<xsl:call-template name="orderTypeTranslationF2b">
							<xsl:with-param name="orderType" select="b:orderTypeD/infra:code"/>
						</xsl:call-template>
					</field>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="dxorder:PARENT">
	
	<xsl:choose>
		<xsl:when test="b:bulkChildIndicator = '2' and b:userDefinedField[infra:name='source_code']/infra:value = 'NULL'">
			<field name="PARENT">
				<xsl:value-of select="'YES'"/>
			</field>
		</xsl:when>
	</xsl:choose>
	</xsl:template>


	<xsl:template name="dxorder:PARENT.CHILD.REF">
	<xsl:choose>
		<xsl:when test="b:bulkChildIndicator = '2' and b:userDefinedField[infra:name='source_code']/infra:value = 'NULL'">
			<field name="PARENT.CHILD.REF">
				<xsl:value-of select="b:pmsOrderReference"/>
			</field>
		</xsl:when>
		<xsl:when test="b:bulkChildIndicator = '3'">
			<field name="PARENT.CHILD.REF">
				<xsl:value-of select="b:pmsBulkOrderReference"/>
			</field>
		</xsl:when>
	</xsl:choose>
	</xsl:template>

	<xsl:template name="dxorder:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="dxorder:PRI.ALLOW.SETT"/>
	<xsl:template name="dxorder:PRI.CACC.CCY"/>
	<xsl:template name="dxorder:PRI.COMM.EXC"/>
	<xsl:template name="dxorder:PRI.CACC.AMT"/>
	<xsl:template name="dxorder:PRI.COMM.TAX"/>
	<xsl:template name="dxorder:PRI.CHARGE.DATE"/>
	<xsl:template name="dxorder:PRI.TAX.CODE"/>
	<xsl:template name="dxorder:PRI.TAX.TYPE"/>
	<xsl:template name="dxorder:TAX.AMT.ACY"/>
	<xsl:template name="dxorder:TAX.AMT.TCY"/>
	<xsl:template name="dxorder:PRI.REF.CCY"/>
	<xsl:template name="dxorder:PRI.ACC.CCY"/>
	<xsl:template name="dxorder:PRI.EX.RATE.REF"/>
	<xsl:template name="dxorder:PRI.EX.RATE.ACC"/>
	<xsl:template name="dxorder:PRI.DLV.AMT"/>
	<xsl:template name="dxorder:PRI.NET.COST"/>
	<xsl:template name="dxorder:PRI.PREM.EXC"/>
	<xsl:template name="dxorder:PRI.DLV.KEY"/>
	<xsl:template name="dxorder:PRI.TRANS.KEY"/>
	<xsl:template name="dxorder:PRI.ORDER.NO"/>
	<xsl:template name="dxorder:PRI.NARR"/>
	<xsl:template name="dxorder:PRI.CONSTRAINT"/>
	<xsl:template name="dxorder:PRI.CHG.OFFSET"/>
	<xsl:template name="dxorder:PRI.CUST.REF"/>
	<xsl:template name="dxorder:PRI.PND.SETT"/>
	<xsl:template name="dxorder:PRI.PND.LOTS"/>
	<xsl:template name="dxorder:PRI.LIMIT.REF"/>
	<xsl:template name="dxorder:PRI.PREM.TXN"/>
	<xsl:template name="dxorder:PRI.PREM.PST"/>
	<xsl:template name="dxorder:PRI.IM.AMT"/>
	<xsl:template name="dxorder:PRI.IM.ACC"/>
	<xsl:template name="dxorder:PRI.RT.COMPANY"/>
	<xsl:template name="dxorder:PRI.RT.PORT.ID"/>
	<xsl:template name="dxorder:PRI.RT.WHEN"/>
	<xsl:template name="dxorder:PRI.RT.LINK"/>
	<xsl:template name="dxorder:PRI.ENTITLE"/>
	<xsl:template name="dxorder:PRI.OVE.ADDR"/>
	<xsl:template name="dxorder:PRI.MESS.CTL"/>
	<xsl:template name="dxorder:PRI.PREM.OFFSET"/>
	<xsl:template name="dxorder:PRI.BEN.NO"/>
	<xsl:template name="dxorder:PRI.BEN.ADD"/>
	<xsl:template name="dxorder:PRI.CPY.NO"/>
	<xsl:template name="dxorder:PRI.CPY.ADD"/>
	<xsl:template name="dxorder:PRI.CPY.BNK.ACC"/>
	<xsl:template name="dxorder:PRI.INTR.BK.NO"/>
	<xsl:template name="dxorder:PRI.INTR.ADD"/>
	<xsl:template name="dxorder:PRI.CONF.NAR"/>
	<xsl:template name="dxorder:PRI.PYMT.NAR"/>
	<xsl:template name="dxorder:PRI.RCAD.NAR"/>
	<xsl:template name="dxorder:PRI.BK2BK.IN"/>
	<xsl:template name="dxorder:SEC.SEC.ACC"/>
	<xsl:template name="dxorder:SEC.CUST.TYPE"/>
	<xsl:template name="dxorder:SEC.CUST.STATUS"/>
	<xsl:template name="dxorder:SEC.ACCOUNT"/>
	<xsl:template name="dxorder:SEC.BUY.SELL"/>
	<xsl:template name="dxorder:SEC.LOTS"/>
	<xsl:template name="dxorder:SEC.ORIG.LOTS"/>
	<xsl:template name="dxorder:SEC.SETTNOS"/>
	<xsl:template name="dxorder:SEC.SETTLOTS"/>
	<xsl:template name="dxorder:SEC.INT.PRICE"/>
	<xsl:template name="dxorder:SEC.TRADE.COST"/>
	<xsl:template name="dxorder:SEC.HEDGE.TRADE"/>
	<xsl:template name="dxorder:SEC.LINK"/>
	<xsl:template name="dxorder:SEC.ALLOW.SETT"/>
	<xsl:template name="dxorder:SEC.STRATEGY"/>
	<xsl:template name="dxorder:SEC.AUTO.MANUAL"/>
	<xsl:template name="dxorder:SEC.COMM.TYP"/>
	<xsl:template name="dxorder:SEC.COMM.CDE"/>
	<xsl:template name="dxorder:SEC.COMM.CCY"/>
	<xsl:template name="dxorder:SEC.COMM.AMT"/>
	<xsl:template name="dxorder:SEC.COMM.ACC"/>
	<xsl:template name="dxorder:SEC.CACC.CCY"/>
	<xsl:template name="dxorder:SEC.COMM.EXC"/>
	<xsl:template name="dxorder:SEC.CACC.AMT"/>
	<xsl:template name="dxorder:SEC.COMM.TAX"/>
	<xsl:template name="dxorder:SEC.CHARGE.DATE"/>
	<xsl:template name="dxorder:SEC.TAX.CODE"/>
	<xsl:template name="dxorder:SEC.TAX.TYPE"/>

	<xsl:template name="dxorder:SEC.TAX.AMT.ACY"/>
	<xsl:template name="dxorder:SEC.TAX.AMT.TCY"/>
	<xsl:template name="dxorder:SEC.REF.CCY"/>
	<xsl:template name="dxorder:SEC.ACC.CCY"/>
	<xsl:template name="dxorder:SEC.EX.RATE.REF"/>
	<xsl:template name="dxorder:SEC.EX.RATE.ACC"/>
	<xsl:template name="dxorder:SEC.ORDER.NO"/>
	<xsl:template name="dxorder:SEC.NARR"/>
	<xsl:template name="dxorder:SEC.CONSTRAINT"/>
	<xsl:template name="dxorder:SEC.DLV.AMT"/>
	<xsl:template name="dxorder:SEC.NET.COST"/>
	<xsl:template name="dxorder:SEC.PREM.EXC"/>
	<xsl:template name="dxorder:SEC.DLV.KEY"/>
	<xsl:template name="dxorder:SEC.TRANS.KEY"/>
	<xsl:template name="dxorder:SEC.CHG.OFFSET"/>
	<xsl:template name="dxorder:SEC.CUST.REF"/>
	<xsl:template name="dxorder:SEC.PND.SETT"/>
	<xsl:template name="dxorder:SEC.PND.LOTS"/>
	<xsl:template name="dxorder:SEC.LIMIT.REF"/>
	<xsl:template name="dxorder:SEC.PREM.TXN"/>
	<xsl:template name="dxorder:SEC.PREM.PST"/>
	<xsl:template name="dxorder:SEC.IM.AMT"/>
	<xsl:template name="dxorder:SEC.IM.ACC"/>
	<xsl:template name="dxorder:SEC.RT.COMPANY"/>
	<xsl:template name="dxorder:SEC.RT.PORT.ID"/>
	<xsl:template name="dxorder:SEC.RT.WHEN"/>
	<xsl:template name="dxorder:SEC.RT.LINK"/>
	<xsl:template name="dxorder:SEC.ENTITLE"/>
	<xsl:template name="dxorder:SEC.OVE.ADDR"/>
	<xsl:template name="dxorder:SEC.MESS.CTL"/>
	<xsl:template name="dxorder:SEC.PREM.OFFSET"/>
	<xsl:template name="dxorder:SEC.BEN.NO"/>
	<xsl:template name="dxorder:SEC.BEN.ADD"/>
	<xsl:template name="dxorder:SEC.CPY.NO"/>
	<xsl:template name="dxorder:SEC.CPY.ADD"/>
	<xsl:template name="dxorder:SEC.CPY.BNK.ACC"/>
	<xsl:template name="dxorder:SEC.INTR.BK.NO"/>
	<xsl:template name="dxorder:SEC.INTR.ADD"/>
	<xsl:template name="dxorder:SEC.CONF.NAR"/>
	<xsl:template name="dxorder:SEC.PYMT.NAR"/>
	<xsl:template name="dxorder:SEC.RCAD.NAR"/>
	<xsl:template name="dxorder:SEC.BK2BK.IN"/>
	<xsl:template name="dxorder:TICK.SIZE"/>
	<xsl:template name="dxorder:TICK.VALUE"/>
	<xsl:template name="dxorder:CONTRACT.SIZE"/>
	<xsl:template name="dxorder:ALT.IND.NAME"/>

	<xsl:template name="dxorder:ALT.IND.ID"/>
	<xsl:template name="dxorder:AI.RESERVED2"/>
	<xsl:template name="dxorder:AI.RESERVED1"/>
	<xsl:template name="dxorder:ORDER.DATE"/>
	<xsl:template name="dxorder:ORDER.TIME"/>
	<xsl:template name="dxorder:BROKER.DATE"/>
	<xsl:template name="dxorder:BROKER.TIME"/>
	<xsl:template name="dxorder:LOTS.FILLED"/>
	<xsl:template name="dxorder:LOTS.OPEN"/>
	<xsl:template name="dxorder:UNDERLYING"/>
	<xsl:template name="dxorder:EXOTIC.EVENT"/>
	<xsl:template name="dxorder:USR.FLD.NAME"/>
	<xsl:template name="dxorder:USR.FLD.TEXT"/>
	<xsl:template name="dxorder:USR.FLD.VAL"/>
	<xsl:template name="dxorder:USR.FLD.PRICE"/>
	<xsl:template name="dxorder:USR.RSVD.X3"/>
	<xsl:template name="dxorder:USR.RSVD.X4"/>
	<xsl:template name="dxorder:USR.RSVD.X5"/>
	<xsl:template name="dxorder:FX.PIP.TYPE"/>
	<xsl:template name="dxorder:FX.PIPS"/>
	<xsl:template name="dxorder:FX.PREM.AMT"/>
	<xsl:template name="dxorder:ORDER.ADVICE"/>
	<xsl:template name="dxorder:PARENT.REF"/>
	<xsl:template name="dxorder:CHILD.REF"/>
	<xsl:template name="dxorder:PENDING.DIARY"/>
	<xsl:template name="dxorder:SUPPRESS.ALL.MSG"/>
	<xsl:template name="dxorder:IND.PRICE"/>
	<xsl:template name="dxorder:ORIG.PRICE"/>
	<xsl:template name="dxorder:DAYS.PER.YEAR"/>
	<xsl:template name="dxorder:SPREAD.RATE"/>
	<xsl:template name="dxorder:SWAP.REFERENCE"/>
	<xsl:template name="dxorder:CAP.FLOOR"/>
	<xsl:template name="dxorder:HEDGE.PL.CATEG"/>
	<xsl:template name="dxorder:BUY.FLOATING.RATE"/>
	<xsl:template name="dxorder:SELL.FLOATING.RATE"/>
	<xsl:template name="dxorder:MASTER.AGREEMENT"/>
	<xsl:template name="dxorder:PERIOD.FREQUENCY"/>
	<xsl:template name="dxorder:PERIOD.START"/>
	<xsl:template name="dxorder:PERIOD.END.DATE"/>
	<xsl:template name="dxorder:PERIOD.FIX.DATE"/>
	<xsl:template name="dxorder:PERIOD.PAY.DATE"/>
	<xsl:template name="dxorder:PREM.PYMT.FREQ"/>
	<xsl:template name="dxorder:PREM.PYMT.DATE"/>
	<xsl:template name="dxorder:PREM.PYMT.AMT"/>
	<xsl:template name="dxorder:LOTS.TRANSFER"/>
	<xsl:template name="dxorder:DEST.CUST"/>
	<xsl:template name="dxorder:DEST.PORTFOLIO"/>
	<xsl:template name="dxorder:DEST.CUST.PORT"/>
	<xsl:template name="dxorder:CUST.CPARTY"/>
	<xsl:template name="dxorder:CUST.BNK.NME"/>
	<xsl:template name="dxorder:CUST.BNK.ADD"/>
	<xsl:template name="dxorder:CUST.BNK.SORT.CDE"/>
	<xsl:template name="dxorder:FEE"/>
	<xsl:template name="dxorder:ADVICE"/>
	<xsl:template name="dxorder:CREATE.TRADES"/>
	<xsl:template name="dxorder:FILLED.LOTS"/>
	<xsl:template name="dxorder:FILLED.PRICE"/>
	<xsl:template name="dxorder:FILLED.IPRICE"/>
	<xsl:template name="dxorder:RESERVED.10"/>
	<xsl:template name="dxorder:RESERVED.11"/>
	<xsl:template name="dxorder:TREASURY.CUSTOMER"/>
	<xsl:template name="dxorder:LINK.REFERENCE"/>
	<xsl:template name="dxorder:RESERVED.X14"/>
	<xsl:template name="dxorder:RESERVED.X15"/>
	<xsl:template name="dxorder:LOCAL.REF"/>
	<xsl:template name="dxorder:OVERRIDE"/>
	<xsl:template name="dxorder:RECORD.STATUS"/>
	<xsl:template name="dxorder:CURR.NO"/>
	<xsl:template name="dxorder:INPUTTER"/>
	<xsl:template name="dxorder:DATE.TIME"/>
	<xsl:template name="dxorder:AUTHORISER"/>
	<xsl:template name="dxorder:CO.CODE"/>
	<xsl:template name="dxorder:DEPT.CODE"/>
	<xsl:template name="dxorder:AUDITOR.CODE"/>
	<xsl:template name="dxorder:AUDIT.DATE.TIME"/>
	<xsl:template name="dxorder:SY.DEAL.REF"/>
	<xsl:template name="dxorder:EXCLUDE.VALUATION"/>
	<xsl:template name="dxorder:CARRIER.ALLOWED"/>
	<xsl:template name="dxorder:PRI.PREMIUM.CCY"/>
	<xsl:template name="dxorder:PRI.PREM.PRICE"/>
	<xsl:template name="dxorder:PRI.PREM.EXCH.RATE"/>
	<xsl:template name="dxorder:PRI.TOTAL.PREM.AMT"/>
	<xsl:template name="dxorder:SEC.PREMIUM.CCY"/>
	<xsl:template name="dxorder:SEC.PREM.PRICE"/>
	<xsl:template name="dxorder:SEC.PREM.EXCH.RATE"/>
	<xsl:template name="dxorder:SEC.TOTAL.PREM.AMT"/>
	<xsl:template name="dxorder:PRI.EXCHANGE.TYPE"/>
	<xsl:template name="dxorder:RESERVED.X10"/>
	<xsl:template name="dxorder:RESERVED.X11"/>
	<xsl:template name="dxorder:RESERVED.X12"/>
	<xsl:template name="dxorder:RESERVED.X13"/>
	<xsl:template name="dxorder:RESERVED.X16"/>
	<xsl:template name="dxorder:RESERVED.X17"/>
	<xsl:template name="dxorder:RESERVED.X18"/>
	<xsl:template name="dxorder:RESERVED.X19"/>
	<xsl:template name="dxorder:RESERVED.X20"/>
	<xsl:template name="dxorder:RESERVED.X21"/>
	<xsl:template name="dxorder:RESERVED.X22"/>
	<xsl:template name="dxorder:RESERVED.X23"/>
	<xsl:template name="dxorder:RESERVED.X24"/>
	<xsl:template name="dxorder:RESERVED.X25"/>
	<xsl:template name="dxorder:RESERVED.X26"/>
	<xsl:template name="dxorder:RESERVED.X27"/>
	<xsl:template name="dxorder:RESERVED.X28"/>
	<xsl:template name="dxorder:RESERVED.X29"/>
	<xsl:template name="dxorder:RESERVED.X30"/>
	<xsl:template name="dxorder:RESERVED.X31"/>
	<xsl:template name="dxorder:RESERVED.X32"/>
	<xsl:template name="dxorder:RESERVED.X33"/>
	<xsl:template name="dxorder:RESERVED.X34"/>
	<xsl:template name="dxorder:RESERVED.X35"/>
	<xsl:template name="dxorder:RESERVED.X43"/>
	<xsl:template name="dxorder:STRIKE.QUOTE.CCY"/>
	<xsl:template name="dxorder:STRIKE.QUOTE"/>
	<xsl:template name="dxorder:CCY.BOUGHT"/>
	<xsl:template name="dxorder:AMT.BOUGHT"/>
	<xsl:template name="dxorder:CCY.SOLD"/>
	<xsl:template name="dxorder:AMT.SOLD"/>
	<xsl:template name="dxorder:RESERVED.X3"/>
	<xsl:template name="dxorder:RESERVED.X4"/>
	<xsl:template name="dxorder:RESERVED.X5"/>
	<xsl:template name="dxorder:USERDEF.FIELDS"/>
	<xsl:template name="dxorder:ModelBankSpecificFields"/>
	<xsl:template name="dxorder:ModelBankSpecificFields-Custo"/>
	<!-- end instruction.DX.ORDER-->
	<!-- Start DX.TRADE-->
	
	<!-- Start instruction.PE.CUSTOMER.TXN-->
	<xsl:template name="pecustomertxn:transactionId">
		<transactionId>
			<xsl:value-of select="concat(b:portfolio/infra:code,'.',b:security/infra:code)"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="pecustomertxn:ACCOUNT">
		<field name="ACCOUNT">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:PE.FUND"/>
	<xsl:template name="pecustomertxn:COMMITMENT.DATE">
		<field name="COMMITMENT.DATE">
			<xsl:value-of select="translate(b:tradeDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMITMENT.AMOUNT">
		<field name="COMMITMENT.AMOUNT">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMITMENT.STATUS">
		<field name="COMMITMENT.STATUS">
			<xsl:value-of select="'PROVISIONAL'"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:REFERENCE">
		<field name="REFERENCE">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,35)"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:CURRENCY"/>
	<xsl:template name="pecustomertxn:COMMISSION.AMOUNT">
		<xsl:if test="b:userDefinedField[infra:name='order_fee_e']/infra:value = '1' ">
			<field name="COMMISSION.AMOUNT">
				<xsl:value-of select="translate(b:userDefinedField[infra:name='bp_4_amount_m']/infra:value,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="pecustomertxn:COMMISSION.PERCENTAGE">
		<xsl:if test="b:userDefinedField[infra:name='order_fee_e']/infra:value = '2' ">
			<field name="COMMISSION.PERCENTAGE">
				<xsl:value-of select="translate(b:userDefinedField[infra:name='order_fee_p']/infra:value,'%','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="pecustomertxn:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:ModelBankSpecificFields"/>
	<xsl:template name="pecustomertxn:ModelBankSpecificFields-Custo"/>
	<xsl:template name="pecustomertxn:USERDEF.FIELDS"/>
	<!-- end instruction.PE.CUSTOMER.TXN-->
	<!-- Start of instruction.POSITION.TRANSFER-->
	<xsl:template name="positiontransfer:SECURITY.CODE">
		<field name="SECURITY.CODE">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:SEC.ACCT.FROM">
		<field name="SEC.ACCT.FROM">
			<xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="b:boPortfolio/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:portfolio/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:SEC.ACCT.TO">
		<field name="SEC.ACCT.TO">
			<xsl:choose>
				<xsl:when test="b:adjBoPortfolio/infra:code != ''">
					<xsl:value-of select="b:adjBoPortfolio/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:portfolioTo/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:CUST.NOMINAL">
		<field name="CUST.NOMINAL">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:DEPOSITORY.FROM">
		<field name="DEPOSITORY.FROM">
			<xsl:choose>
				<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:DEPOSITORY.TO">
		<field name="DEPOSITORY.TO">
			<xsl:choose>
				<xsl:when test="contains(b:depositTo/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositTo/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositTo/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:SUB.ACC.FROM">
		<field name="SUB.ACC.FROM">
			<xsl:value-of select="substring-after(b:depositaryAccount/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:SUB.ACCT.TO">
		<field name="SUB.ACCT.TO">
			<xsl:value-of select="substring-after(b:depositTo/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:CUST.REMARKS">
		<field name="CUST.REMARKS">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,35)"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:PRICE">
		<field name="PRICE">
			<xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:AUTO.SELECT">
		<field name="AUTO.SELECT">
			<xsl:value-of select="'NO'"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:ModelBankSpecificFields"/>
	<xsl:template name="positiontransfer:ModelBankSpecificFields-Custo"/>
	<xsl:template name="positiontransfer:TAP.SLV.PTF.FRM">
		<field name="TAP.SLV.PTF.FRM">
			<xsl:if test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:portfolio/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:TAP.SLV.PTF.TO">
		<field name="TAP.SLV.PTF.TO">
			<xsl:if test="b:adjBoPortfolio/infra:code != ''">
				<xsl:value-of select="b:portfolioTo/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="positiontransfer:USERDEF.FIELDS"/>
	<!-- End of instruction.POSITION.TRANSFER-->
	<!-- Start of instruction.SECURITY.TRANSFER-->
	<xsl:template name="securitytransfer:CU.ACCOUNT.NO">
		<xsl:choose>
			<xsl:when test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:boAccount/infra:code"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:currentAccount/infra:code"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="securitytransfer:INTEREST.AMT">
		<field name="INTEREST.AMT">
			<xsl:value-of select="translate(b:accrInterests,',','')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:choose>
				<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:SECURITY.NO">
		<field name="SECURITY.NO">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:SECURITY.ACC">
		<field name="SECURITY.ACC">
			<xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="b:boPortfolio/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:portfolio/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:NO.NOMINAL">
		<field name="NO.NOMINAL">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:PRICE">
		<field name="PRICE">
			<xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:CUST.REMARKS">
		<field name="CUST.REMARKS">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,35)"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:TRANSACTION.TYPE">
		<field name="TRANSACTION.TYPE">
			<xsl:choose>
				<xsl:when test="b:buySellIndicator ='4'">
					<xsl:value-of select="translate($f2bSecurityTransferInType,' ','')"/>
				</xsl:when>
				<xsl:when test="b:buySellIndicator ='5'">
					<xsl:value-of select="translate($f2bSecurityTransferOutType,' ','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:CUSTOMER.NO">
		<field name="CUSTOMER.NO">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:client/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:DELIVERY.INSTR">
		<field name="DELIVERY.INSTR">
			<xsl:value-of select="$f2bSecurityTransferFREDeliveryInstr"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:BROKER.ADDR.BIC">
		<field name="BROKER.ADDR.BIC">
			<xsl:choose>
				<xsl:when test="b:extBankBIC != ''">
					<xsl:value-of select="concat('B-',b:extBankBIC)"/>
				</xsl:when>
				<xsl:when test="b:counterparty/infra:code != ''">
					<xsl:value-of select="concat('C-',b:counterparty/infra:code)"/>
				</xsl:when>
				<xsl:when test="b:extBankName != ''">
					<xsl:value-of select="b:extBankName"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:SUB.ACCOUNT">
	<field name="SUB.ACCOUNT">
			<xsl:value-of select="substring-after(b:depositaryAccount/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:BUYR.SELLER.AC">
		<field name="BUYR.SELLER.AC">
			<xsl:value-of select="b:counterpartAccount"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:CU.COMMISSION">
		<xsl:if test="b:userDefinedField[infra:name='order_fee_e']/infra:value = '1' ">
			<field name="CU.COMMISSION">
				<xsl:value-of select="translate(b:userDefinedField[infra:name='bp_4_amount_m']/infra:value,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="securitytransfer:BROKER.NO">
		<field name="BROKER.NO">
			<xsl:value-of select="translate(b:broker/infra:code,$CUSTOMER_PREFIX,'')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:ModelBankSpecificFields"/>
	<xsl:template name="securitytransfer:ModelBankSpecificFields-Custo"/>
	<xsl:template name="securitytransfer:TAP.SLEEVE.ACC">
		<field name="TAP.SLEEVE.ACC">
			<xsl:if test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:currentAccount/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:TAP.SLEEVE.PTF">
		<field name="TAP.SLEEVE.PTF">
			<xsl:if test="b:boPortfolio/infra:code != ''">
				<xsl:value-of select="b:portfolio/infra:code"/>
			</xsl:if>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:USERDEF.FIELDS"/>
	<!-- End of instruction.SECURITY.TRANSFER-->
	<!-- Start of OrderNetting.SECURITY.TRANSFER-->
	<xsl:template name="securitytransfer2:CU.ACCOUNT.NO">
		<field name="CU.ACCOUNT.NO">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:INTEREST.AMT">
		<field name="INTEREST.AMT">
			<xsl:value-of select="translate(b:accrInterests,',','')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:choose>
				<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:SECURITY.NO">
		<field name="SECURITY.NO">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:SECURITY.ACC">
		<field name="SECURITY.ACC">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:NO.NOMINAL">
		<field name="NO.NOMINAL">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:PRICE">
		<field name="PRICE">
			<xsl:value-of select="translate(b:userDefinedField[infra:name='quote_n']/infra:value,',','')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:CUST.REMARKS">
		<field name="CUST.REMARKS">
			<xsl:value-of select="substring(b:userDefinedField[infra:name='remark_1_c']/infra:value,1,35)"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:TRANSACTION.TYPE">
		<field name="TRANSACTION.TYPE">
			<xsl:choose>
				<xsl:when test="b:buySellIndicator ='1'">
					<xsl:value-of select="translate($f2bSecurityTransferInType,' ','')"/>
				</xsl:when>
				<xsl:when test="b:buySellIndicator ='2'">
					<xsl:value-of select="translate($f2bSecurityTransferOutType,' ','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:CUSTOMER.NO">
		<field name="CUSTOMER.NO">
			<xsl:choose>
				<xsl:when test="$CUSTOMER_PREFIX != ''">
					<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:client/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:SUB.ACCOUNT">
		<field name="SUB.ACCOUNT">
			<xsl:value-of select="substring-after(b:depositaryAccount/infra:code,'_')"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:DELIVERY.INSTR">
		<field name="DELIVERY.INSTR">
			<xsl:value-of select="'DAP'"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:BROKER.ADDR.BIC">
		<field name="BROKER.ADDR.BIC">
			<xsl:value-of select="'DUMMY BIC'"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer2:BUYR.SELLER.AC"/>
	<xsl:template name="securitytransfer2:CU.COMMISSION"/>
	<xsl:template name="securitytransfer2:BROKER.NO"/>
	<xsl:template name="securitytransfer2:ModelBankSpecificFields"/>
	<xsl:template name="securitytransfer2:ModelBankSpecificFields-Custo"/>
	<!-- End of OrderNetting.SECURITY.TRANSFER-->
	<!-- Start instruction.SEC.TRADE-->
	<xsl:template name="sectrade:ID"/>
	<xsl:template name="sectrade:ACT.COMMISSION"/>
	<xsl:template name="sectrade:ACT.DEAL.DESK"/>
	<xsl:template name="sectrade:AGGREGATION.REF"/>
	<xsl:template name="sectrade:ALL.IN.COST"/>
	<xsl:template name="sectrade:ASSET.TYPE"/>
	<xsl:template name="sectrade:AUDIT.DATE.TIME"/>
	<xsl:template name="sectrade:AUDITOR.CODE"/>
	<xsl:template name="sectrade:AUTHORISE.CHILD"/>
	<xsl:template name="sectrade:AUTHORISER"/>
	<xsl:template name="sectrade:AUTO.BROK.SETT"/>
	<xsl:template name="sectrade:AUTO.CUST.SETT"/>
	<xsl:template name="sectrade:BENE.OWNER"/>
	<xsl:template name="sectrade:BND.RND.METH"/>
	<xsl:template name="sectrade:BOND.OR.SHARE"/>
	<xsl:template name="sectrade:BR.ACC.NO"/>
	<xsl:template name="sectrade:BR.ACCOUNT.CCY"/>
	<xsl:template name="sectrade:BR.AGENT"/>
	<xsl:template name="sectrade:BR.AGENT.AC"/>
	<xsl:template name="sectrade:BR.AMOUNT.DUE"/>
	<xsl:template name="sectrade:BR.BEN.ACCT"/>
	<xsl:template name="sectrade:BR.BEN.ADDR"/>
	<xsl:template name="sectrade:BR.BEN.BANK.1"/>
	<xsl:template name="sectrade:BR.BEN.BANK.2"/>
	<xsl:template name="sectrade:BR.BROKER.COMM"/>
	<xsl:template name="sectrade:BR.CAP.INT.AMT"/>
	<xsl:template name="sectrade:BR.CHARGE.TAX.AMT"/>
	<xsl:template name="sectrade:BR.CHARGE.TAX.CODE"/>
	<xsl:template name="sectrade:BR.CHARGE.TAX.TYPE"/>
	<xsl:template name="sectrade:BR.CHG.AMT.ACC.CCY"/>
	<xsl:template name="sectrade:BR.CHG.AMT.ACCOUNT"/>
	<xsl:template name="sectrade:BR.CHG.AMT.EX.RATE"/>
	<xsl:template name="sectrade:BR.CHG.AMT.TRD.CCY"/>
	<xsl:template name="sectrade:BR.CONF.REF"/>
	<xsl:template name="sectrade:BR.COUP.TAX.AMT"/>
	<xsl:template name="sectrade:BR.DELIV.INSTR"/>
	<xsl:template name="sectrade:BR.DELIV.KEY"/>
	<xsl:template name="sectrade:BR.EBV.FEES"/>
	<xsl:template name="sectrade:BR.EX.RATE.ACC"/>
	<xsl:template name="sectrade:BR.FEES.MISC"/>
	<xsl:template name="sectrade:BR.FOREIGN.FEE"/>
	<xsl:template name="sectrade:BR.FTT.AMT"/>
	<xsl:template name="sectrade:BR.FTT.AMT.CCY"/>
	<xsl:template name="sectrade:BR.FTT.AMT.LCY"/>
	<xsl:template name="sectrade:BR.FTT.AMT.TCY"/>
	<xsl:template name="sectrade:BR.FTT.BSE.AMT"/>
	<xsl:template name="sectrade:BR.FTT.EX.RATE"/>
	<xsl:template name="sectrade:BR.FTT.PERC"/>
	<xsl:template name="sectrade:BR.FTT.TYPE"/>
	<xsl:template name="sectrade:BR.GROSS.ACCR"/>
	<xsl:template name="sectrade:BR.GROSS.AM.SEC"/>
	<xsl:template name="sectrade:BR.GROSS.AM.TRD"/>
	<xsl:template name="sectrade:BR.INTR.AM.TRD"/>
	<xsl:template name="sectrade:BR.MESS.CONTROL"/>
	<xsl:template name="sectrade:BR.NARRATIVE"/>
	<xsl:template name="sectrade:BR.NET.AM.TRD"/>
	<xsl:template name="sectrade:BR.NO.NOM">
		<field name="BR.NO.NOM">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:BR.ORDER.NOS"/>
	<xsl:template name="sectrade:BR.OVE.ADDR"/>
	<xsl:template name="sectrade:BR.PRICE">
		<field name="BR.PRICE">
			<xsl:value-of select="b:price"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:BR.REALLOW.AMT"/>
	<xsl:template name="sectrade:BR.REALLOWANCE"/>
	<xsl:template name="sectrade:BR.RESERVED.5"/>
	<xsl:template name="sectrade:BR.RESERVED.6"/>
	<xsl:template name="sectrade:BR.SEC.DEPOT.AC"/>
	<xsl:template name="sectrade:BR.STAMP.TAX"/>
	<xsl:template name="sectrade:BR.SYS.CHARGE.TAX.AMT"/>
	<xsl:template name="sectrade:BR.TOT.NOM"/>
	<xsl:template name="sectrade:BR.TRANS.CODE">
		<field name="BR.TRANS.CODE">
			<xsl:choose>
				<xsl:when test="b:buySellIndicator = '1'">
					<xsl:value-of select="'SEL'"/>
				</xsl:when>
				<xsl:when test="b:buySellIndicator = '2'">
					<xsl:value-of select="'BUY'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:BR.TRD.TIME"/>
	<xsl:template name="sectrade:BR.UNF.GROSS"/>
	<xsl:template name="sectrade:BR.UNF.SEC.GROS"/>
	<xsl:template name="sectrade:BROK.ACT.SUSP.CAT"/>
	<xsl:template name="sectrade:BROKER.ADVICE.REQD"/>
	<xsl:template name="sectrade:BROKER.DEPO"/>
	<xsl:template name="sectrade:BROKER.NO">
		<field name="BROKER.NO">
			<xsl:value-of select="b:broker/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:BROKER.TYPE"/>
	<xsl:template name="sectrade:BULK.PROCESSING"/>
	<xsl:template name="sectrade:BULK.UPDATE"/>
	<xsl:template name="sectrade:BUYR.NATION"/>
	<xsl:template name="sectrade:BUYR.SELLER"/>
	<xsl:template name="sectrade:BUYR.SELLER.AC"/>
	<xsl:template name="sectrade:CANCEL.BY.DATE"/>
	<xsl:template name="sectrade:CANCEL.TRADE.REF"/>
	<xsl:template name="sectrade:CASH.HOLD.SETTLE"/>
	<xsl:template name="sectrade:CG.TRADE.TIME"/>
	<xsl:template name="sectrade:CGT.BAMT.CCY"/>
	<xsl:template name="sectrade:CGT.BASE.AMT"/>
	<xsl:template name="sectrade:CGT.CODE"/>
	<xsl:template name="sectrade:CGT.PARAM.COND"/>
	<xsl:template name="sectrade:CGT.SRC.LCL.TAX"/>
	<xsl:template name="sectrade:CGT.TAX.AMT"/>
	<xsl:template name="sectrade:CGT.TAX.LCL"/>
	<xsl:template name="sectrade:CGT.TAX.RATE"/>
	<xsl:template name="sectrade:CL.COMMISSION"/>
	<xsl:template name="sectrade:CO.CODE"/>
	<xsl:template name="sectrade:COM.ORDER.REF"/>
	<xsl:template name="sectrade:COM.TAX.BCUR"/>
	<xsl:template name="sectrade:COM.TAX.CODE"/>
	<xsl:template name="sectrade:COM.TAX.XRTE"/>
	<xsl:template name="sectrade:COMM.CODE"/>
	<xsl:template name="sectrade:COMM.PERCENT"/>
	<xsl:template name="sectrade:CON.VAL.DATE"/>
	<xsl:template name="sectrade:CONF.BY.BROKER"/>
	<xsl:template name="sectrade:CONSOL.AMT"/>
	<xsl:template name="sectrade:CONSOL.RATE"/>
	<xsl:template name="sectrade:CONTRA.BY.REF"/>
	<xsl:template name="sectrade:COST.INV.BASE.CCY"/>
	<xsl:template name="sectrade:COST.INV.REF.CCY"/>
	<xsl:template name="sectrade:COST.INV.SEC.CCY"/>
	<xsl:template name="sectrade:CPTY.LIMIT.REF"/>
	<xsl:template name="sectrade:CU.ACCOUNT.CCY"/>
	<xsl:template name="sectrade:CU.ADVICE.REQD"/>
	<xsl:template name="sectrade:CU.AMOUNT.DUE"/>
	<xsl:template name="sectrade:CU.BEN.ACCT"/>
	<xsl:template name="sectrade:CU.BEN.ADDR"/>
	<xsl:template name="sectrade:CU.BEN.BANK.1"/>
	<xsl:template name="sectrade:CU.BEN.BANK.2"/>
	<xsl:template name="sectrade:CU.BRKR.COMM"/>
	<xsl:template name="sectrade:CU.CAP.INT.AMT"/>
	<xsl:template name="sectrade:CU.CHARGE.TAX.AMT"/>
	<xsl:template name="sectrade:CU.CHARGE.TAX.CODE"/>
	<xsl:template name="sectrade:CU.CHARGE.TAX.TYPE"/>
	<xsl:template name="sectrade:CU.COMM.TAX"/>
	<xsl:template name="sectrade:CU.COMMISSION">
		<field name="CU.COMMISSION">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value = '2' and b:userDefinedField[infra:name='order_fee_p']/infra:value != 'NULL'">
					<xsl:value-of select="translate(concat(b:userDefinedField[infra:name='order_fee_p']/infra:value,'%'),',','')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="b:userDefinedField[infra:name='order_fee_e']/infra:value = '1' ">
						<xsl:value-of select="translate(b:userDefinedField[infra:name='bp_4_amount_m']/infra:value,',','')"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CU.COUP.TAX.AMT"/>
	<xsl:template name="sectrade:CU.DELIV.INSTR"/>
	<xsl:template name="sectrade:CU.DELIV.KEY"/>
	<xsl:template name="sectrade:CU.DISC.AMT"/>
	<xsl:template name="sectrade:CU.DISC.PCENT"/>
	<xsl:template name="sectrade:CU.EBV.FEES"/>
	<xsl:template name="sectrade:CU.ENTITL.ID"/>
	<xsl:template name="sectrade:CU.EX.RATE.ACC"/>
	<xsl:template name="sectrade:CU.EX.RATE.REF"/>
	<xsl:template name="sectrade:CU.FEES.MISC"/>
	<xsl:template name="sectrade:CU.FOREIGN.FEE"/>
	<xsl:template name="sectrade:CU.FTT.AMT"/>
	<xsl:template name="sectrade:CU.FTT.AMT.CCY"/>
	<xsl:template name="sectrade:CU.FTT.AMT.LCY"/>
	<xsl:template name="sectrade:CU.FTT.AMT.TCY"/>
	<xsl:template name="sectrade:CU.FTT.BSE.AMT"/>
	<xsl:template name="sectrade:CU.FTT.EX.RATE"/>
	<xsl:template name="sectrade:CU.FTT.PERC"/>
	<xsl:template name="sectrade:CU.FTT.TYPE"/>
	<xsl:template name="sectrade:CU.GROSS.ACCR"/>
	<xsl:template name="sectrade:CU.GROSS.AM.SEC"/>
	<xsl:template name="sectrade:CU.GROSS.AM.TRD"/>
	<xsl:template name="sectrade:CU.INCOME.ACC"/>
	<xsl:template name="sectrade:CU.INCOME.AMT"/>
	<xsl:template name="sectrade:CU.INCOME.CCY"/>
	<xsl:template name="sectrade:CU.INT.CTR"/>
	<xsl:template name="sectrade:CU.MANTAXLCY"/>
	<xsl:template name="sectrade:CU.MANTAXTCY"/>
	<xsl:template name="sectrade:CU.MESS.CONTROL"/>
	<xsl:template name="sectrade:CU.NARRATIVE">
		<field name="CU.NARRATIVE">
			<xsl:value-of select="b:remark"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CU.NAV.TYPE"/>
	<xsl:template name="sectrade:CU.NET.AM.TRD"/>
	<xsl:template name="sectrade:CU.NOTES"/>
	<xsl:template name="sectrade:CU.ORDER.NOS"/>
	<xsl:template name="sectrade:CU.OVE.ADDR"/>
	<xsl:template name="sectrade:CU.REALLOW.AMT"/>
	<xsl:template name="sectrade:CU.REALLOWANCE"/>
	<xsl:template name="sectrade:CU.REF.CCY"/>
	<xsl:template name="sectrade:CU.RESERVED.1"/>
	<xsl:template name="sectrade:CU.RESERVED.4"/>
	<xsl:template name="sectrade:CU.RESERVED.5"/>
	<xsl:template name="sectrade:CU.STAMP.TAX"/>
	<xsl:template name="sectrade:CU.SUBS.ACCOUNT"/>
	<xsl:template name="sectrade:CU.SYS.CHARGE.TAX.AMT"/>
	<xsl:template name="sectrade:CU.TAX.CODE"/>
	<xsl:template name="sectrade:CU.TAX.LCY"/>
	<xsl:template name="sectrade:CU.TAX.TCY"/>
	<xsl:template name="sectrade:CU.TAX.TYPE"/>
	<xsl:template name="sectrade:CU.UNF.GROSS"/>
	<xsl:template name="sectrade:CU.UNF.SEC.GROS"/>
	<xsl:template name="sectrade:CU.WHT.PERC"/>
	<xsl:template name="sectrade:CU.WHT.TAX"/>
	<xsl:template name="sectrade:CUM.EX.IND"/>
	<xsl:template name="sectrade:CURR.NO"/>
	<xsl:template name="sectrade:CUST.ACC.NO">
		<field name="CUST.ACC.NO">
			<xsl:value-of select="b:currentAccount/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CUST.ACT.SUSP.CAT"/>
	<xsl:template name="sectrade:CUST.INTR.AMT"/>
	<xsl:template name="sectrade:CUST.NO.NOM">
		<field name="CUST.NO.NOM">
			<xsl:value-of select="b:quantity"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CUST.NOMINEE"/>
	<xsl:template name="sectrade:CUST.PRICE">
		<field name="CUST.PRICE">
			<xsl:value-of select="b:price"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CUST.REMARKS"/>
	<xsl:template name="sectrade:CUST.SEC.ACC">
		<field name="CUST.SEC.ACC">
			<xsl:value-of select="b:portfolio/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CUST.TOT.NOM"/>
	<xsl:template name="sectrade:CUST.TRANS.CODE">
		<field name="CUST.TRANS.CODE">
			<xsl:choose>
				<xsl:when test="b:buySellIndicator = '1'">
					<xsl:value-of select="'BUY'"/>
				</xsl:when>
				<xsl:when test="b:buySellIndicator = '2'">
					<xsl:value-of select="'SEL'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:CUSTOMER.NO"/>
	<xsl:template name="sectrade:DATE.TIME"/>
	<xsl:template name="sectrade:DEAL.NOTES"/>
	<xsl:template name="sectrade:DEALER.BOOK"/>
	<xsl:template name="sectrade:DEALER.NAME"/>
	<xsl:template name="sectrade:DECISION.MKR.ID"/>
	<xsl:template name="sectrade:DEF.DEAL.DESK"/>
	<xsl:template name="sectrade:DELETE.CHILD"/>
	<xsl:template name="sectrade:DEP.DELIV.KEY"/>
	<xsl:template name="sectrade:DEP.DELIV.REF"/>
	<xsl:template name="sectrade:DEPO.DELIV.INSTR"/>
	<xsl:template name="sectrade:DEPOSITORY">
		<field name="DEPOSITORY">
			<xsl:choose>
				<xsl:when test="contains(b:depositaryAccount/infra:code,'_')">
					<xsl:value-of select="substring-before(b:depositaryAccount/infra:code,'_')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depositaryAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:DEPOT.ADVICE.REQD"/>
	<xsl:template name="sectrade:DEPT.CODE"/>
	<xsl:template name="sectrade:DISCOUNT.AMOUNT"/>
	<xsl:template name="sectrade:EAM.ID"/>
	<xsl:template name="sectrade:EXCH.RATE.SEC"/>
	<xsl:template name="sectrade:EXCH.RATE.TRD"/>
	<xsl:template name="sectrade:EXT.CUSTODIAN"/>
	<xsl:template name="sectrade:FACTOR"/>
	<xsl:template name="sectrade:FUND.ID"/>
	<xsl:template name="sectrade:IN.DELIVERY.REF"/>
	<xsl:template name="sectrade:INPUTTER"/>
	<xsl:template name="sectrade:INT.CTR"/>
	<xsl:template name="sectrade:INTEG.DATA.ITEM"/>
	<xsl:template name="sectrade:INTEG.DATA.VALUE"/>
	<xsl:template name="sectrade:INTEREST.DAYS"/>
	<xsl:template name="sectrade:INTEREST.RATE"/>
	<xsl:template name="sectrade:INVEST.OPTION.TYPE"/>
	<xsl:template name="sectrade:ISIN-ALT"/>
	<xsl:template name="sectrade:ISSUE.DATE"/>
	<xsl:template name="sectrade:LAST.PAYMNT.DATE"/>
	<xsl:template name="sectrade:LINK.REFERENCE"/>
	<xsl:template name="sectrade:MARGIN.FACTOR"/>
	<xsl:template name="sectrade:MARKET.TYPE"/>
	<xsl:template name="sectrade:MATURITY.DATE"/>
	<xsl:template name="sectrade:MISC.ACT.SUSP.CAT"/>
	<xsl:template name="sectrade:MV.RESERVED01"/>
	<xsl:template name="sectrade:NET.TRADE"/>
	<xsl:template name="sectrade:NEW.VALUE.DATE"/>
	<xsl:template name="sectrade:ODD.LOT.TRADE"/>
	<xsl:template name="sectrade:ODD.RTS.CGT"/>
	<xsl:template name="sectrade:ORIGINAL.SEC"/>
	<xsl:template name="sectrade:OVERRIDE"/>
	<xsl:template name="sectrade:PARENT"/>
	<xsl:template name="sectrade:PARENT.REFERENCE"/>
	<xsl:template name="sectrade:PAYMENT.REQD"/>
	<xsl:template name="sectrade:PL.CODE"/>
	<xsl:template name="sectrade:PL.SAFEKEEP"/>
	<xsl:template name="sectrade:PORT.CONST.NO"/>
	<xsl:template name="sectrade:PORT.DEALER.BOOK"/>
	<xsl:template name="sectrade:PRICE.TYPE"/>
	<xsl:template name="sectrade:PRINCIPAL.AGENT"/>
	<xsl:template name="sectrade:PSET"/>
	<xsl:template name="sectrade:PURPOSE.OF.TRAN"/>
	<xsl:template name="sectrade:QTY.ALLOTED"/>
	<xsl:template name="sectrade:RECORD.STATUS"/>
	<xsl:template name="sectrade:REFERENCE.NO"/>
	<xsl:template name="sectrade:REVERSE.CHILD"/>
	<xsl:template name="sectrade:RP.REFERENCE"/>
	<xsl:template name="sectrade:SEC.HOLD.SETTLE"/>
	<xsl:template name="sectrade:SECURITY.CODE">
		<field name="SECURITY.CODE">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:SECURITY.CURRENCY"/>
	<xsl:template name="sectrade:SEGMENT"/>
	<xsl:template name="sectrade:SERVICE.REF"/>
	<xsl:template name="sectrade:SETT.NARRATIVE"/>
	<xsl:template name="sectrade:SETTLE.AMT"/>
	<xsl:template name="sectrade:SETTLE.CURR"/>
	<xsl:template name="sectrade:SPRTY.NARR"/>
	<xsl:template name="sectrade:SPRTY.NARR.QUAL"/>
	<xsl:template name="sectrade:SSI.ID"/>
	<xsl:template name="sectrade:STAMP.INDICATOR"/>
	<xsl:template name="sectrade:STAMP.PRICE"/>
	<xsl:template name="sectrade:STATEMENT.NOS"/>
	<xsl:template name="sectrade:STOCK.EXCHANGE"/>
	<xsl:template name="sectrade:STP.FAIL.REASON"/>
	<xsl:template name="sectrade:SUB.ACCOUNT"/>
	<xsl:template name="sectrade:SUB.ASSET.TYPE"/>
	<xsl:template name="sectrade:SUP.MIS.SUSP"/>
	<xsl:template name="sectrade:SY.DX.REFERENCE"/>
	<xsl:template name="sectrade:SY.TRANS.ID"/>
	<xsl:template name="sectrade:SY.UNIT.ID"/>
	<xsl:template name="sectrade:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:TAXLOT.ALLOCATE"/>
	<xsl:template name="sectrade:THREAD.KEY"/>
	<xsl:template name="sectrade:TO.CONTRA.REF"/>
	<xsl:template name="sectrade:TRADE.CCY">
		<field name="TRADE.CCY">
			<xsl:value-of select="b:tradeCurrency/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:TRADE.CURR"/>
	<xsl:template name="sectrade:TRADE.DATE">
		<field name="TRADE.DATE">
			<xsl:value-of select="translate(b:tradeDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:TRADE.TIME"/>
	<xsl:template name="sectrade:TRANS.ID"/>
	<xsl:template name="sectrade:TREASURY.PRICE"/>
	<xsl:template name="sectrade:TT.REF.NO"/>
	<xsl:template name="sectrade:TXN.CHANNEL"/>
	<xsl:template name="sectrade:UPFRONT.SEC"/>
	<xsl:template name="sectrade:VALUE.DATE">
		<field name="VALUE.DATE">
			<xsl:value-of select="translate(b:valueDate,'-','')"/>
		</field>
	</xsl:template>
	<xsl:template name="sectrade:WAIVER.INDI"/>
	<xsl:template name="sectrade:WHT.TAX.CODE"/>
	<xsl:template name="sectrade:ModelBankSpecificFields"/>
	<xsl:template name="sectrade:ModelBankSpecificFields-Custo"/>
	<!-- For Adjustment Order -->
	<xsl:template name="adjustmentorder:CUSTOMER.NO">
		<field name="CUSTOMER.NO">
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
	<xsl:template name="adjustmentorder:PORTFOLIO">
		<field name="PORTFOLIO">
			<xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="b:boPortfolio/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:portfolio/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:TAP.SLEEVE.PTF">
		<field name="TAP.SLEEVE.PTF">
			<xsl:choose>
				<xsl:when test="b:boPortfolio/infra:code != ''">
					<xsl:value-of select="b:portfolio/infra:code"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:ACCOUNT">
		<field name="ACCOUNT">
			<xsl:choose>
				<xsl:when test="b:boAccount/infra:code != ''">
					<xsl:value-of select="b:boAccount/infra:code"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:currentAccount/infra:code"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:EVENT.SECURITY">
		<field name="EVENT.SECURITY">
			<xsl:choose>
				<xsl:when test="b:adjustmentNature = '15'">
					<xsl:value-of select="b:adjustedSecurity/infra:code"/>
				</xsl:when>
				<xsl:when test="b:adjustmentNature = '2'">
					<xsl:value-of select="b:security/infra:code"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:EVENT.TYPE"/>
	<xsl:template name="adjustmentorder:EVENT.NOM">
		<field name="EVENT.NOM">
			<xsl:choose>
				<xsl:when test="b:adjustmentNature = '15'">
					<xsl:value-of select="b:adjustedQuantity * (-1)"/>
				</xsl:when>
				<xsl:when test="b:adjustmentNature = '2'">
					<xsl:value-of select="b:quantity * (-1)"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:NEW.SEC.NO"/>
	<xsl:template name="adjustmentorder:NEW.SEC.NOM"/>
	<xsl:template name="adjustmentorder:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:TAP.ENTITY.ID">
		<field name="TAP.ENTITY.ID">
			<xsl:value-of select="b:ownerBusinessEntity"/>
		</field>
	</xsl:template>
	<xsl:template name="adjustmentorder:ModelBankSpecificFields"/>
	<xsl:template name="adjustmentorder:ModelBankSpecificFields-Custo"/>
	<!-- End of instruction.SEC.TRADE-->
	<!-- BEG of reinvestUpdate.SEC.OPEN.ORDER -->
	<xsl:template name="secopenorder4:transactionId">
		<transactionId>
			<xsl:value-of select="b:userDefinedField[infra:name='source_code']/infra:value"/>
		</transactionId>
	</xsl:template>
	<xsl:template name="secopenorder4:TAP.REF.ID">
		<field name="TAP.REF.ID">
			<xsl:value-of select="b:pmsOrderReference"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder4:TAP.EVENT.ID">
		<field name="TAP.EVENT.ID">
			<xsl:value-of select="../../@eventIdentifier"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder4:TAP.ORD.NATURE">
		<field name="TAP.ORD.NATURE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '1'">
					<xsl:value-of select="'DMA'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
					<xsl:value-of select="'NDMA'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder4:ORDER.TIME">
		<xsl:variable name="utcDateTime" select="substring-after(b:initiationDateTime,'T')"/>
		<xsl:variable name="utcDate" select="concat(substring-before($utcDateTime,'.'),':',substring-after($utcDateTime,'.'))"/>
		<field name="ORDER.TIME">
			<xsl:value-of select="substring-before($utcDate,'+')"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder4:ModelBankSpecificFields"/>
	<xsl:template name="secopenorder4:ModelBankSpecificFields-Custo"/>
	<!-- END of reinvestUpdate.SEC.OPEN.ORDER -->
</xsl:stylesheet>