<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
                exclude-result-prefixes="b ns0 ns1 batch" version="1.0">

	<xsl:template name="account2_purchase">
		<account2>
			<infra:code>
				<xsl:value-of select="./ns1:ourAccountPay1"/>
			</infra:code>
		</account2>
	</xsl:template>
	<xsl:template name="expirationDate_purchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account2NetAmount_purchase"/>
	<xsl:template name="account3_purchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="account3NetAmount_purchase"/>
	<xsl:template name="accountingCode_purchase"/>
	<xsl:template name="accountingDate_purchase"/>
	<xsl:template name="cashPortfolio_purchase"/>
	<xsl:template name="commonRefernce_purchase"/>
	<xsl:template name="contractNumber_purchase"/>
	<xsl:template name="initiatedBy_purchase"/>
	<xsl:template name="initiator_purchase"/>
	<xsl:template name="notepad_purchase"/>
	<xsl:template name="portfolio_purchase">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../ns1:portfolioId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_purchase"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate_purchase">
	<currentAccountCcyPortfolioCcyExchangeRate>
		<xsl:value-of select="ns1:costPrice"/>
	</currentAccountCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="remark_purchase"/>
	<xsl:template name="reversalIndicator_purchase"/>
	<xsl:template name="reversedTransactionCode_purchase"/>
	<xsl:template name="sourceSystemCode_purchase">
		<sourceSystemCode>
			<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_purchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_purchase"/>
	<xsl:template name="trader_purchase"/>
	<xsl:template name="transactionFeesTaxesCounter_purchase"/>
	<xsl:template name="type_purchase"/>
	<xsl:template name="userDefinedField_purchase"/>
	<xsl:template name="mbFields_purchase"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_purchase"/>
	<xsl:template name="autoClosing_purchase"/>
	<xsl:template name="contractReferenceCode_purchase">
		<contractReferenceCode>
			<xsl:choose>
				<xsl:when test="./ns1:tapRefId">
					<xsl:value-of select="./ns1:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="expirationDate_prchase"/>
	<xsl:template name="forwardContract_purchase">
		<forwardContract>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="ns1:tapRefId and ns1:tapRefId != ''">
								<xsl:value-of select="ns1:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="./ns1:currencySold"/>
						<xsl:value-of select="'-'"/>
						<xsl:value-of select="./ns1:currencyBought"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate_purchase">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="./ns1:tapFxRateDir = '1'">
					<xsl:value-of select="format-number(1 div ./ns1:forwardRate,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./ns1:forwardRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="fxClientRate_purchase"/>
	<xsl:template name="fxMarketRate_purchase"/>
	<xsl:template name="fxMargin_purchase"/>
	<xsl:template name="fxMarginP_purchase"/>
	<xsl:template name="fxRateDirection_purchase"/>
	<xsl:template name="initiationDate_purchase">
		<initiationDate>
			<xsl:choose>
				<xsl:when test="ns1:valueDateBuy &lt; ns1:valueDateSell">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="ns1:valueDateBuy"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="ns1:valueDateSell"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</initiationDate>
	</xsl:template>
	<xsl:template name="operationAmount_purchase"/>
	<xsl:template name="purchasedQuantity_purchase">
		<purchasedQuantity>
			<xsl:value-of select="./ns1:amountSold"/>
		</purchasedQuantity>
	</xsl:template>
	<xsl:template name="soldCcyCurrentAccount_purchase">
		<soldCcyCurrentAccount>
			<infra:code>
				<xsl:value-of select="./ns1:ourAccountRec1"/>
			</infra:code>
		</soldCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="soldCcyNetAmount_purchase"/>
	<xsl:template name="spotExchangeRate_purchase"/>
	<xsl:template name="startingDate_purchase">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="./ns1:dealDate"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>
	<xsl:template name="code_purchase"/>
	<xsl:template name="custoDefinitions_purchase"/>
	<xsl:template name="mbCustoDefinitions_purchase"/>


	<!--TransactionSaleOpening-->

	<xsl:template name="account2_sale">
		<account2>
			<infra:code>
				<xsl:value-of select="ns1:ourAccountRec1"/>
			</infra:code>
		</account2>
	</xsl:template>
	<xsl:template name="account2CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account2NetAmount_sale"/>
	<xsl:template name="account3_sale"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="account3NetAmount_sale"/>
	<xsl:template name="accountingCode_sale"/>
	<xsl:template name="accountingDate_sale"/>
	<xsl:template name="cashPortfolio_sale"/>
	<xsl:template name="commonReference_sale"/>
	<xsl:template name="contractNumber_sale"/>
	<xsl:template name="initiatedBy_sale"/>
	<xsl:template name="initiator_sale"/>
	<xsl:template name="notepad_sale"/>
	<xsl:template name="portfolio_sale">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../ns1:portfolioId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_sale"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate_sale">
	<currentAccountCcyPortfolioCcyExchangeRate>
		<xsl:value-of select="./ns1:costPrice"/>
	</currentAccountCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="remark_sale"/>
	<xsl:template name="reversalIndicator_sale"/>
	<xsl:template name="reversedTransactionCode_sale"/>
	<xsl:template name="sourceSystemCode_sale">
		<sourceSystemCode>
			<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_sale">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_sale"/>
	<xsl:template name="trader_sale"/>
	<xsl:template name="transactionFeesTaxesCounter_sale"/>
	<xsl:template name="type_sale">
		<type>
			<infra:code>
				<xsl:value-of select="concat('FX_',ns1:dealType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField_sale"/>
	<xsl:template name="mbFields_sale"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_sale"/>
	<xsl:template name="autoClosing_sale"/>
	<xsl:template name="contractReferenceCode_sale">
		<contractReferenceCode>
			<xsl:choose>
				<xsl:when test="./ns1:tapRefId">
					<xsl:value-of select="./ns1:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="expirationDate_sale"/>
	<xsl:template name="forwardContract_sale">
		<forwardContract>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="ns1:tapRefId and ns1:tapRefId != ''">
								<xsl:value-of select="ns1:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="./ns1:currencySold"/>
						<xsl:value-of select="'-'"/>
						<xsl:value-of select="./ns1:currencyBought"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate_sale">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="./ns1:tapFxRateDir = '1'">
					<xsl:value-of select="format-number(1 div ./ns1:forwardRate,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./ns1:forwardRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="fxClientRate_sale"/>
	<xsl:template name="fxMargin_sale"/>
	<xsl:template name="fxMarginP_sale"/>
	<xsl:template name="fxMarketRate_sale"/>
	<xsl:template name="fxRateDirection_sale"/>
	<xsl:template name="initiationDate_sale">
		<initiationDate>
			<xsl:choose>
				<xsl:when test="ns1:valueDateBuy &lt; ns1:valueDateSell">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="ns1:valueDateBuy"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="ns1:valueDateSell"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</initiationDate>
	</xsl:template>
	<xsl:template name="operationAmount_sale"/>
	<xsl:template name="operationGrossAmount_sale"/>
	<xsl:template name="priceCalculationRule_sale"/>
	<xsl:template name="purchasedCcyCurrentAccount_sale">
		<purchasedCcyCurrentAccount>
			<!-- account_id -->
			<infra:code>
				<xsl:value-of select="ns1:ourAccountPay1"/>
			</infra:code>
		</purchasedCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="purchasedCcyNetAmount_sale"/>
	<xsl:template name="soldQuantity_sale">
		<soldQuantity>
			<!-- quantity_n -->
			<xsl:value-of select="ns1:amountBought"/>
		</soldQuantity>
	</xsl:template>
	<xsl:template name="spotExchangeRate_sale">
		<spotExchangeRate>
			<xsl:choose>
				<xsl:when test="ns1:tapFxRateDir = '1'">
					<xsl:value-of select="format-number(substring(1 div ns1:spotRate,1,11),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ns1:spotRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</spotExchangeRate>
	</xsl:template>
	<xsl:template name="startingDate_sale">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="./ns1:dealDate"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>


	
	<xsl:template name="custoDefinitions_sale"/>
	<xsl:template name="mbCustoDefinitions_sale"/>

	<!--nd purchase opening-->
	<xsl:template name="account2_nd_purchase"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_nd_purchase"/>
	<xsl:template name="account2NetAmount_nd_purchase"/>
	<xsl:template name="account3_nd_purchase"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_nd_purchase"/>
	<xsl:template name="account3NetAmount_nd_purchase"/>
	<xsl:template name="accountingCode_nd_purchase"/>
	<xsl:template name="accountingDate_nd_purchase">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:dealDate,'-','')"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_nd_purchase"/>
	<xsl:template name="commonRefernce_nd_purchase"/>
	<xsl:template name="contractNumber_nd_purchase"/>
	<xsl:template name="initiatedBy_nd_purchase"/>
	<xsl:template name="initiator_nd_purchase"/>
	<xsl:template name="notepad_nd_purchase"/>
	<xsl:template name="portfolio_nd_purchase">
		<portfolio>
			<infra:code>
				<xsl:value-of select="ns1:cusPortId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_nd_purchase"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate_nd_purchase">
	<currentAccountCcyPortfolioCcyExchangeRate>
		<xsl:value-of select="./ns1:costPrice"/>
	</currentAccountCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="remark_nd_purchase"/>
	<xsl:template name="reversalIndicator_nd_purchase"/>
	<xsl:template name="reversedTransactionCode_nd_purchase"/>
	<xsl:template name="sourceSystemCode_nd_purchase">
		<sourceSystemCode>
			<xsl:value-of select="ns1:fxContractId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_nd_purchase">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_nd_purchase"/>
	<xsl:template name="trader_nd_purchase"/>
	<xsl:template name="transactionFeesTaxesCounter_nd_purchase"/>
	<xsl:template name="type_nd_purchase">
		<type>
			<infra:code>
				<xsl:value-of select="'NDF_OPEN'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField_nd_purchase"/>
	<xsl:template name="mbFields_nd_purchase"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_nd_purchase"/>
	<xsl:template name="autoClosing_nd_purchase"/>
	<xsl:template name="contractReferenceCode_nd_purchase">
		<contractReferenceCode>
			<xsl:choose>
				<xsl:when test="./ns1:tapRefId">
					<xsl:value-of select="./ns1:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="expirationDate_nd_purchase">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:settlementDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
	</xsl:template>
	<xsl:template name="forwardContract_nd_purchase">
		<forwardContract>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="ns1:tapRefId and ns1:tapRefId != ''">
								<xsl:value-of select="ns1:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'NDF'"/>
						<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
						<xsl:value-of select="ns1:dealCurrency"/>
						<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
						<xsl:value-of select="ns1:settlementCurrency"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate_nd_purchase">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCcy">
					<xsl:value-of select="ns1:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div ns1:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="fxClientRate_nd_purchase">
		<xsl:if test="ns1:notionalRate != ''">
			<fxClientRate>
				<xsl:value-of select="ns1:notionalRate"/>
			</fxClientRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMarketRate_nd_purchase"/>
	<xsl:template name="fxMargin_nd_purchase"/>
	<xsl:template name="fxMarginP_nd_purchase"/>
	<xsl:template name="fxRateDirection_nd_purchase">
		<fxRateDirection>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCcy">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fxRateDirection>
	</xsl:template>
	<xsl:template name="initiationDate_nd_purchase">
		<initiationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:valueDate,'-','')"/>
			</xsl:call-template>
		</initiationDate>
	</xsl:template>
	<xsl:template name="operationAmount_nd_purchase"/>
	<xsl:template name="purchasedQuantity_nd_purchase">
		<purchasedQuantity>
			<xsl:value-of select="ns1:dealAmount"/>
		</purchasedQuantity>
	</xsl:template>
	<xsl:template name="soldCcyCurrentAccount_nd_purchase">
		<soldCcyCurrentAccount>
			<infra:code>
				<xsl:value-of select="ns1:settlementAcct"/>
			</infra:code>
		</soldCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="soldCcyNetAmount_nd_purchase">
		<soldCcyNetAmount>
			<xsl:value-of select="ns1:notionalSettlAmt"/>
		</soldCcyNetAmount>
	</xsl:template>
	<xsl:template name="spotExchangeRate_nd_purchase">
		<spotExchangeRate>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCurrency">
					<xsl:value-of select="ns1:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div ns1:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</spotExchangeRate>
	</xsl:template>
	<xsl:template name="startingDate_nd_purchase">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:dealDate,'-','')"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>
	<xsl:template name="fixingDate_nd_purchase">
		<xsl:if test="ns1:fixedDate and ns1:fixedDate != ''">
			<fixingDate>
				<xsl:variable name="date" select="ns1:fixedDate"/>
				<xsl:variable name="year" select="substring($date,1,4)"/>
				<xsl:variable name="mo" select="substring($date,5,2)"/>
				<xsl:variable name="da" select="substring($date,7,2)"/>
				<xsl:variable name="formatted_date" select="concat($year,'-',$mo,'-',$da)"/>

				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="$formatted_date"/>
				</xsl:call-template>
			</fixingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="code_nd_purchase"/>
	<xsl:template name="custoDefinitions_nd_purchase"/>
	<xsl:template name="mbCustoDefinitions_nd_purchase"/>



	<!--nd sale opening-->
	<xsl:template name="account2_nd_sale"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_nd_sale"/>
	<xsl:template name="account2NetAmount_nd_sale"/>
	<xsl:template name="account3_nd_sale"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_nd_sale"/>
	<xsl:template name="account3NetAmount_nd_sale"/>
	<xsl:template name="accountingCode_nd_sale"/>
	<xsl:template name="accountingDate_nd_sale">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:dealDate,'-','')"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio_nd_sale"/>
	<xsl:template name="commonReference_nd_sale"/>
	<xsl:template name="contractNumber_nd_sale"/>
	<xsl:template name="initiatedBy_nd_sale"/>
	<xsl:template name="initiator_nd_sale"/>
	<xsl:template name="notepad_nd_sale"/>
	<xsl:template name="portfolio_nd_sale">
		<portfolio>
			<infra:code>
				<xsl:value-of select="ns1:cusPortId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager_nd_sale"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate_nd_sale">
	<currentAccountCcyPortfolioCcyExchangeRate>
		<xsl:value-of select="./ns1:costPrice"/>
	</currentAccountCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="remark_nd_sale"/>
	<xsl:template name="reversalIndicator_nd_sale"/>
	<xsl:template name="reversedTransactionCode_nd_sale"/>
	<xsl:template name="sourceSystemCode_nd_sale">
		<sourceSystemCode>
			<xsl:value-of select="ns1:fxContractId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_nd_sale">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType_nd_sale"/>
	<xsl:template name="trader_nd_sale"/>
	<xsl:template name="transactionFeesTaxesCounter_nd_sale"/>
	<xsl:template name="type_nd_sale">
		<type>
			<infra:code>
				<xsl:value-of select=" 'NDF_OPEN' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField_nd_sale"/>
	<xsl:template name="mbFields_nd_sale"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_nd_sale"/>
	<xsl:template name="autoClosing_nd_sale"/>
	<xsl:template name="contractReferenceCode_nd_sale">
		<contractReferenceCode>
			<xsl:choose>
				<xsl:when test="./ns1:tapRefId">
					<xsl:value-of select="./ns1:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(./ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="expirationDate_nd_sale">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:settlementDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
	</xsl:template>
	<xsl:template name="fixingDate_nd_sale">
		<xsl:if test="ns1:fixedDate and ns1:fixedDate != ''">
			<fixingDate>
				<xsl:variable name="date" select="ns1:fixedDate"/>
				<xsl:variable name="year" select="substring($date,1,4)"/>
				<xsl:variable name="mo" select="substring($date,5,2)"/>
				<xsl:variable name="da" select="substring($date,7,2)"/>
				<xsl:variable name="formatted_date" select="concat($year,'-',$mo,'-',$da)"/>

				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="$formatted_date"/>
				</xsl:call-template>
			</fixingDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="forwardContract_nd_sale">
		<forwardContract>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="ns1:tapRefId and ns1:tapRefId != ''">
								<xsl:value-of select="ns1:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(ns1:fxContractId,$COMPANY_POSTFIX_SEPARATOR,../ns1:companyMnenomic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select=" 'NDF' "/>
						<xsl:value-of select=" '-' "/>
						<xsl:value-of select="ns1:dealCurrency"/>
						<xsl:value-of select=" '-' "/>
						<xsl:value-of select="ns1:settlementCurrency"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate_nd_sale">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCcy">
					<xsl:value-of select="ns1:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div ns1:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="fxClientRate_nd_sale">
		<xsl:if test="ns1:notionalRate != ''">
			<fxClientRate>
				<xsl:value-of select="ns1:notionalRate"/>
			</fxClientRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMargin_nd_sale"/>
	<xsl:template name="fxMarginP_nd_sale"/>
	<xsl:template name="fxMarketRate_nd_sale"/>
	<xsl:template name="fxRateDirection_nd_sale">
		<fxRateDirection>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCcy">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fxRateDirection>
	</xsl:template>
	<xsl:template name="initiationDate_nd_sale">
		<initiationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:valueDate,'-','')"/>
			</xsl:call-template>
		</initiationDate>
	</xsl:template>
	<xsl:template name="operationAmount_nd_sale"/>
	<xsl:template name="operationGrossAmount_nd_sale">
		<operationGrossAmount>
			<xsl:value-of select="ns1:notionalSettlAmt"/>
		</operationGrossAmount>
	</xsl:template>
	<xsl:template name="priceCalculationRule_nd_sale">
		<priceCalculationRule>
			<xsl:value-of select=" '1' "/>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="purchasedCcyCurrentAccount_nd_sale">
		<purchasedCcyCurrentAccount>
			<!-- account_id -->
			<infra:code>
				<xsl:value-of select="ns1:settlementAcct"/>
			</infra:code>
		</purchasedCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="purchasedCcyNetAmount_nd_sale">
		<purchasedCcyNetAmount>
			<xsl:value-of select="ns1:notionalSettlAmt"/>
		</purchasedCcyNetAmount>
	</xsl:template>
	<xsl:template name="soldQuantity_nd_sale">
		<soldQuantity>
			<xsl:value-of select="ns1:dealAmount"/>
		</soldQuantity>
	</xsl:template>
	<xsl:template name="spotExchangeRate_nd_sale">
		<spotExchangeRate>
			<xsl:choose>
				<xsl:when test="ns1:dealCurrency = ns1:baseCcy">
					<xsl:value-of select="ns1:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div ns1:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</spotExchangeRate>
	</xsl:template>
	<xsl:template name="startingDate_nd_sale">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(ns1:dealDate,'-','')"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>
	<xsl:template name="code_nd_sale"/>
	<xsl:template name="custoDefinitions_nd_sale"/>
	<xsl:template name="mbCustoDefinitions_nd_sale"/>
</xsl:stylesheet>