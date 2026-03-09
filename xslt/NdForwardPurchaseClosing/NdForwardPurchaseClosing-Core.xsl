<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/NdDeal"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchNdDeal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiNdDeal" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiNdDeal" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account2">
	<account2>
		<infra:code>
				<xsl:value-of select="b:settlementAcct"/>
			</infra:code>
	</account2>
	</xsl:template>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:valueDate,'-','')"/>
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
				<xsl:value-of select=" '1' "/>
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
						<xsl:value-of select="'-C'"/>
					</xsl:when>
					<xsl:otherwise>
						<!-- order created on T24 -->
						<xsl:value-of select="b:id"/>
						<xsl:value-of select="'-C'"/>
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
				<xsl:value-of select=" 'NDF_CLOSE' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="fxClientRate"/>
	<xsl:template name="fxRateDirection"/>
	<xsl:template name="operationAmount"/>
	<xsl:template name="operationDate">
		<operationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:valueDate,'-','')"/>
			</xsl:call-template>
		</operationDate>
	</xsl:template>
	<xsl:template name="operationGrossAmount">
		<operationGrossAmount>
			<xsl:value-of select="b:fixedAmount"/>
		</operationGrossAmount>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>

	<xsl:template name="closingDate">
		<closingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:settlementDate,'-','')"/>
			</xsl:call-template>
		</closingDate>
	</xsl:template>
	<xsl:template name="contractReferenceCode">
		<contractReferenceCode>
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
			<xsl:value-of select="(1 div b:fixedRate)"/>
		</forwardExchangeRate>
	</xsl:template>
	<xsl:template name="purchasedCcyNetAmount">
		<purchasedCcyNetAmount>
			<!-- acc_net_amount_m -->
			<xsl:value-of select="b:fixedAmount"/>
		</purchasedCcyNetAmount>
	</xsl:template>
	<xsl:template name="purchasedCcyCurrentAccount">
		<purchasedCcyCurrentAccount>
			<!-- account_id -->
			<infra:code>
				<xsl:value-of select="b:settlementAcct"/>
			</infra:code>
		</purchasedCcyCurrentAccount>
	</xsl:template>
	<xsl:template name="soldQuantity">
		<soldQuantity>
			<xsl:value-of select="b:dealAmount"/>
		</soldQuantity>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<!-- Reversal -->
				<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
					<xsl:choose>
						<xsl:when test="b:tapRefId">
							<xsl:value-of select="b:tapRefId"/>
							<xsl:value-of select="'-C_R'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="'-C_R'"/>
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
							<xsl:value-of select="'-C'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:id"/>
							<xsl:value-of select="'-C'"/>
							<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
							<xsl:value-of select="b:mnemonic"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:valueDate,'-','')"/>
			</xsl:call-template>
		</valueDate>
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