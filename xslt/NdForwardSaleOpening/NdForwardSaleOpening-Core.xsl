<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/NdDeal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchNdDeal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiNdDeal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiNdDeal" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account2"/>
	
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:dealDate,'-','')"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:cusPortId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="remark"/>
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
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
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
						<xsl:value-of select="b:mnemonic"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select=" 'NDF_OPEN' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="operationAmount"/>
	<xsl:template name="operationGrossAmount">
		<operationGrossAmount>
		<xsl:choose>
			<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
			<xsl:value-of select="b:notionalSettlAmt"/>
			</xsl:when>
			</xsl:choose>
		</operationGrossAmount>
	</xsl:template>

	<xsl:template name="priceCalculationRule">
		<priceCalculationRule>
			<xsl:value-of select=" '1' "/>
		</priceCalculationRule>
	</xsl:template>
	<xsl:template name="fxClientRate">
		<fxClientRate>
			<xsl:value-of select="b:notionalRate"/>
		</fxClientRate>
	</xsl:template>
	<xsl:template name="fxMargin"/>
	<xsl:template name="fxMarginP"/>
	<xsl:template name="fxMarketRate"/>
	<xsl:template name="fxRateDirection">
		<fxRateDirection>
			<xsl:choose>
				<xsl:when test="b:dealCurrency = b:baseCurrency">
					<xsl:value-of select=" '0' "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select=" '1' "/>
				</xsl:otherwise>
			</xsl:choose>
		</fxRateDirection>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="autoClosing"/>
	<xsl:template name="contractReferenceCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<contractReferenceCode>
			<!-- code -->
			<xsl:choose>
				<!-- Reversal -->
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId">
							<xsl:value-of select="b:tapRefId"/>
							<xsl:value-of select="'_R'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="'_R'"/>
							<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
							<xsl:value-of select="b:mnemonic"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<!-- not a reversal -->
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapRefId">
							<xsl:value-of select="b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
							<xsl:value-of select="b:mnemonic"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</contractReferenceCode>
	</xsl:template>
	<xsl:template name="expirationDate">
		<expirationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:settlementDate,'-','')"/>
			</xsl:call-template>
		</expirationDate>
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
								<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select=" 'NDF' "/>
						<xsl:value-of select=" '-' "/>
						<xsl:value-of select="b:dealCurrency"/>
						<xsl:value-of select=" '-' "/>
						<xsl:value-of select="b:settlementCcy"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forwardContract>
	</xsl:template>
	<xsl:template name="forwardExchangeRate">
		<forwardExchangeRate>
			<xsl:choose>
				<xsl:when test="b:dealCurrency = b:baseCurrency">
					<xsl:value-of select="b:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div b:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="initiationDate">
		<initiationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:dealDate,'-','')"/>
			</xsl:call-template>
		</initiationDate>
	</xsl:template>
	<xsl:template name="purchasedCcyCurrentAccount">
		<purchasedCcyCurrentAccount>
			<!-- account_id -->
			<infra:code>
				<xsl:value-of select="b:settlementAcct"/>
			</infra:code>
		</purchasedCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="purchasedCcyNetAmount">
		<purchasedCcyNetAmount>
			<xsl:value-of select="b:notionalSettlAmt"/>
		</purchasedCcyNetAmount>
	</xsl:template>
	<xsl:template name="soldQuantity">
		<soldQuantity>
			<xsl:value-of select="b:dealAmount"/>
		</soldQuantity>
	</xsl:template>
	<xsl:template name="spotExchangeRate">
		<spotExchangeRate>
			<xsl:choose>
				<xsl:when test="b:dealCurrency = b:baseCurrency">
					<xsl:value-of select="b:notionalRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(1 div b:notionalRate,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</spotExchangeRate>
	</xsl:template>
	<xsl:template name="startingDate">
		<startingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:dealDate,'-','')"/>
			</xsl:call-template>
		</startingDate>
	</xsl:template>
	<xsl:template name="fixingDate">
		<xsl:if test="b:fixedDate and b:fixedDate != ''">
			<fixingDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:fixedDate"/>
				</xsl:call-template>
			</fixingDate>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>