<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account2">
		<account2>
			<infra:code>
				<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountRec"/>
			</infra:code>
		</account2>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:portfolioNumber">
						<xsl:value-of select="concat(b:counterparty , '-' , b:portfolioNumber)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]">
								<xsl:value-of select="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]">
								<xsl:value-of select="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]">
								<xsl:value-of select="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]">
								<xsl:value-of select="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="b:tapRefId">
						<!-- order created on TAP -->
						<xsl:value-of select="b:tapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- order created on T24 -->
						<xsl:value-of select="b:id"/>
						<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
						<xsl:value-of select="b:companyMnemonicJoin"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
			<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
			<xsl:value-of select="b:companyMnemonicJoin"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('FX_',b:transactionType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>ud_spot_value_d</infra:name>
			<infra:value>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="b:spotDate"/>
				</xsl:call-template>
			</infra:value>
			<infra:type>date</infra:type>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="operationAmount"/>
	<xsl:template name="operationGrossAmount">
	<operationGrossAmount>
		<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
				<xsl:value-of select="b:amountSold"/>
			</xsl:when>
		</xsl:choose>
	</operationGrossAmount>
	</xsl:template>

	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="fxRateDirection">
		<fxRateDirection>
			<xsl:choose>
				<xsl:when test="b:tapFxRateDir = '0' or b:tapFxRateDir = '1'">
					<xsl:value-of select="b:tapFxRateDir"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fxRateDirection>
	</xsl:template>
	<xsl:template name="fxClientRate">
		<fxClientRate>
			<xsl:value-of select="b:forwardRate"/>
		</fxClientRate>
	</xsl:template>
	<xsl:template name="fxMarketRate">
		<xsl:if test="b:treasuryRate and b:treasuryRate != ''">
			<fxMarketRate>
				<xsl:value-of select="b:treasuryRate"/>
			</fxMarketRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMargin">
		<xsl:if test="b:marginPips and b:marginPips != ''">
			<fxMargin>
				<xsl:value-of select="b:marginPips"/>
			</fxMargin>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMarginP">
		<xsl:if test="b:marginPerc and b:marginPerc != ''">
			<fxMarginP>
				<xsl:value-of select="b:marginPerc"/>
			</fxMarginP>
		</xsl:if>
	</xsl:template>
	<xsl:template name="contractReferenceCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<contractReferenceCode>
			<xsl:choose>
				<!-- Reversal -->
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId">
							<!-- order created on TAP -->
							<xsl:value-of select="b:tapRefId"/>
							<xsl:value-of select="'-R'"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- order created on T24 -->
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="'-R'"/>
							<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
							<xsl:value-of select="b:companyMnemonicJoin"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- not a reversal -->
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId">
							<!-- order created on TAP -->
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<!-- order created on T24 -->
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
							<xsl:value-of select="b:companyMnemonicJoin"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="forwardContract">
		<forwardContract>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="b:tapRefId and b:tapRefId != ''">
								<xsl:value-of select="b:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:currencyBought"/>
						<xsl:value-of select="'-'"/>
						<xsl:value-of select="b:currencySold"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="b:tapFxRateDir = '1'">
					<xsl:value-of select="format-number(1 div b:forwardRate,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:forwardRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="initiationDate">
		<initiationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:dealDate"/>
			</xsl:call-template>
		</initiationDate>
	</xsl:template>
	<xsl:template name="purchasedCcyCurrentAccount">
		<purchasedCcyCurrentAccount>
			<!-- account_id -->
			<infra:code>
				<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountPay"/>
			</infra:code>
		</purchasedCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="soldQuantity">
		<soldQuantity>
			<!-- quantity_n -->
			<xsl:value-of select="b:amountBought"/>
		</soldQuantity>
	</xsl:template>
	<xsl:template name="spotExchangeRate">
		<spotExchangeRate>
			<xsl:choose>
				<xsl:when test="b:tapFxRateDir = '1'">
					<xsl:value-of select="format-number(substring(1 div b:spotRate,1,11),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:spotRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</spotExchangeRate>
	</xsl:template>
	<xsl:template name="startingDate">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:dealDate"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>
	<xsl:template name="account2CcyTradeCcyExchangeRate">
	<account2CcyTradeCcyExchangeRate>
		<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
			<xsl:choose>
				<xsl:when test="b:tapFxRateDir = '1'">
					<xsl:value-of select="b:forwardRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div b:forwardRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</account2CcyTradeCcyExchangeRate>
	</xsl:template>

	<xsl:template name="account2NetAmount"/>

	<xsl:template name="account3">
   	<account3>
	<infra:code>
		<xsl:choose>
			<xsl:when test="b:ourAccountPayGroup/b:delChgAccount != ''">
				<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccount"/>
			</xsl:when>
			<xsl:when test="(b:ourAccountPayGroup/b:delChgAccount = '' or not(b:ourAccountPayGroup/b:delChgAccount)) and b:accountToCharge != ''">
				<xsl:value-of select="b:accountToCharge"/>
			</xsl:when>
		</xsl:choose>
		</infra:code>
	</account3>
	</xsl:template>

	<xsl:template name="account3CcyTradeCcyExchangeRate"/>

	<xsl:template name="account3NetAmount">
  	 <account3NetAmount>
	 <xsl:choose>
		<xsl:when test="(b:ourAccountPayGroup/b:delChgAccount != '') or b:accountToCharge != ''">
   			<xsl:choose>
				<xsl:when test="b:taxAmountGroup/b:taxAmount !='' or b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt !='' or b:ourAccountPayGroup/b:delAmountChg !='' or b:commissionTaken !=''">
					<xsl:value-of select="-1*(translate(number(b:taxAmountGroup/b:taxAmount),'aN',0)+translate(number(b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt),'aN',0)+translate(number(b:ourAccountPayGroup/b:delAmountChg),'aN',0)+translate(number(b:commissionTaken),'aN',0))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	 </xsl:choose>
   </account3NetAmount>
   </xsl:template>

	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>

	<xsl:template name="transactionFeesTaxesCounter">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="b:taxAmountGroup/b:taxAmount !='' or b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt != ''">
				<xsl:value-of select="translate(number(b:taxAmountGroup/b:taxAmount),'aN',0) + translate(number(b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt),'aN',0)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
							<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
						</xsl:when>
						<xsl:when test="(b:baseCcy = b:currencyBought) and (b:ourAccountPayGroup/b:ourAccountRec = b:accountToCharge)">
							<xsl:value-of select="b:baseCcy"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:ourAccountRec != b:accountToCharge">
									<xsl:value-of select="b:accountRecJoin"/>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_TAXES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
			<xsl:choose>
			<xsl:when test="b:ourAccountPayGroup/b:delAmountChg != '' or b:commissionTaken != ''">
				<xsl:value-of select="translate(number(b:commissionTaken),'aN',0) + translate(number(b:ourAccountPayGroup/b:delAmountChg),'aN',0)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
			</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
							<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
						</xsl:when>
						<xsl:when test="(b:baseCcy = b:currencySold) and (b:ourAccountPayGroup/b:ourAccountRec = b:accountToCharge)">
							<xsl:value-of select="b:baseCcy"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:ourAccountRec != b:accountToCharge">
									<xsl:value-of select="b:accountRecJoin"/>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_CHARGES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>

	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="autoClosing"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="purchasedCcyNetAmount"/>
	<xsl:template name="fixingDate"/>
</xsl:stylesheet>