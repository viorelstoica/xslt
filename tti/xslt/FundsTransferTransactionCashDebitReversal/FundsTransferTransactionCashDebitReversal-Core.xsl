<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FundsTransferTransactionCashDebitReversal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFundsTransferTransactionCashDebitReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFundsTransferTransactionCashDebitReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFundsTransferTransactionCashDebitReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:portfolioNoJoinList/b:portfolioNoJoin">
						<xsl:value-of select="b:portfolioNoJoinList/b:portfolioNoJoin"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:samHistIdJoin"/>
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
		<xsl:variable name="status">
			<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and $status='FWD'"></xsl:when>
			<xsl:otherwise>
				<reversalIndicator>1</reversalIndicator>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and $status='FWD'"></xsl:when>
			<xsl:otherwise>
				<reversedTransactionCode>
					<xsl:value-of select="concat('FT_',b:id,'_D',$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</reversedTransactionCode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="status">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
		</xsl:variable>
		<status>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and $status='FWD'">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'CANCELLED'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$opStatus = 'INPUT-INPUT'">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'TOVALIDATE'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="status">
			<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and $status='FWD'">
				<transactionCode>
					<xsl:value-of select="concat('FT_',b:id,'_D',$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</transactionCode>
			</xsl:when>
			<xsl:otherwise>
				<transactionCode>
					<xsl:value-of select="concat('FT_',b:id,'_D',$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic,'_R')"/>
				</transactionCode>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:debitAcctNo"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:choose>
				<xsl:when test="substring(b:totalChargeAmt,4) &gt; 0 and b:commissionCode = 'DEBIT PLUS CHARGES' and not(b:chargesAcctNo)">
					<xsl:value-of select="format-number(substring(b:amountDebited,4) - substring(b:totalChargeAmt,4),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring(b:amountDebited,4)"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:debitValueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="status1">
				<xsl:value-of select="substring(b:status, string-length(b:status) - 2)"/>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE' and $status1 = 'FWD'"/>
				<xsl:otherwise>
					<xsl:value-of select="b:processingDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
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