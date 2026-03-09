<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionAssignExpiryOptionBuyCloseOutRev"
                xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionAssignExpiryOptionBuyCloseOutRev" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate"/>
	<xsl:template name="adjustmentNat"/>
	<xsl:template name="adjustmentPortfolio"/>
	<xsl:template name="newQuantity"/>
	<xsl:template name="newSecurity"/>
	<xsl:template name="newSecurityDepositaryAccount"/>
	<xsl:template name="oldQuantity"/>
	<xsl:template name="oldSecurity">
		<oldSecurity>
			<infra:code>
			<xsl:choose>
				<xsl:when test="b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC'">
					<xsl:choose>
						<xsl:when test="b:tapRefIdList/b:tapRefId and b:tapRefIdList/b:tapRefId != ''">
							<xsl:value-of select="b:tapRefIdList/b:tapRefId"/>	
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(b:tradeIdGroup/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:contractCode"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="b:currency"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="b:maturityDate"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="b:optionType"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="b:strikePrice"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="b:deliveryCcy"/>
					<xsl:value-of select="'/'"/>
					<xsl:value-of select="substring(b:optionStyleJoinList/b:optionStyleJoin,1,1)"/>
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark"/>
	<xsl:template name="transactionCode">
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(b:id,';')">
					<xsl:value-of select="substring-before(b:id,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="b:tapOperCode"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
					<xsl:value-of select="'-R'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
					<xsl:value-of select="'-R'"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:choose>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'EXERCISE'">
				<xsl:choose>
					<xsl:when test="b:exManualValueDateGroup/b:exManualValueDate and b:exManualValueDateGroup/b:exManualValueDate !=''">
						<transactionDate>
							<xsl:value-of select="b:exManualValueDateGroup/b:exManualValueDate"/>
						</transactionDate>
					</xsl:when>
					<xsl:otherwise>
						<transactionDate>
							<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
						</transactionDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'ASSIGNMENT'">
				<xsl:choose>
					<xsl:when test="b:asManualValueDateGroup/b:asManualValueDate and b:asManualValueDateGroup/b:asManualValueDate !=''">
						<transactionDate>
							<xsl:value-of select="b:asManualValueDateGroup/b:asManualValueDate"/>
						</transactionDate>
					</xsl:when>
					<xsl:otherwise>
						<transactionDate>
							<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
						</transactionDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'EXPIRY'">
				<transactionDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</transactionDate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:choose>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'EXERCISE'">
				<xsl:choose>
					<xsl:when test="b:exManualValueDateGroup/b:exManualValueDate and b:exManualValueDateGroup/b:exManualValueDate !=''">
						<valueDate>
							<xsl:value-of select="b:exManualValueDateGroup/b:exManualValueDate"/>
						</valueDate>
					</xsl:when>
					<xsl:otherwise>
						<valueDate>
							<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
						</valueDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'ASSIGNMENT'">
				<xsl:choose>
					<xsl:when test="b:asManualValueDateGroup/b:asManualValueDate and b:asManualValueDateGroup/b:asManualValueDate !=''">
						<valueDate>
							<xsl:value-of select="b:asManualValueDateGroup/b:asManualValueDate"/>
						</valueDate>
					</xsl:when>
					<xsl:otherwise>
						<valueDate>
							<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
						</valueDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:creation = 'MANUAL' and b:type = 'EXPIRY'">
				<valueDate>
					<xsl:value-of select="b:coDateGroup/b:coDateSubGroup/b:coDate"/>
				</valueDate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="adjustmentCounter"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="communication"/>
	<xsl:template name="initiator"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate"/>
	<xsl:template name="newSecurityNetAmount"/>
	<xsl:template name="newSecurityPositionCriteria1"/>
	<xsl:template name="newSecurityPositionCriteria2"/>
	<xsl:template name="newSecurityPositionCriteria3"/>
	<xsl:template name="newSecurityPositionCurrency"/>
	<xsl:template name="notepad"/>
	<xsl:template name="oldCcyGrossAmount"/>
	<xsl:template name="oldCcyNetAmount"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="oldPrice"/>
	<xsl:template name="oldSecurityPositionCriteria1"/>
	<xsl:template name="oldSecurityPositionCriteria2"/>
	<xsl:template name="oldSecurityPositionCriteria3"/>
	<xsl:template name="oldSecurityPositionCurrency"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>
			<xsl:value-of select=" '1' "/>
		</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="contains(b:id,';')">
					<xsl:value-of select="substring-before(b:id,';')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<reversedTransactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="b:tapOperCode"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:mnemonicJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonicJoin)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status"/>
	<xsl:template name="subType"/>
	<xsl:template name="supplementaryAmount"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="typeInstrument"/>
</xsl:stylesheet>