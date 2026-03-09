<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionsForex">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionsForex"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionsForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionsForex" name="BatchTransactionsForex">
			<xsl:apply-templates select="b:TransactionsForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionsForex">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionsForex" name="BatchMultiTransactionsForex">
			<xsl:apply-templates select="c:MultiTransactionsForex"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionsForex">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('ForwardPurchaseOpening',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<ForexForward>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('ForwardPurchaseOpening.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<forwardPurchaseOpening>
						<xsl:call-template name="account2"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account2NetAmount"/>
						<xsl:call-template name="account3"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account3NetAmount"/>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="commonRefernce"/>
						<xsl:call-template name="contractNumber"/>
						<xsl:call-template name="initiatedBy"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="currentAccountCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="trader"/>
						<xsl:call-template name="transactionFeesTaxesCounter"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="autoClosing"/>
						<xsl:call-template name="contractReferenceCode"/>
						<xsl:call-template name="expirationDate"/>
						<xsl:call-template name="fixingDate"/>
						<xsl:call-template name="forwardContract"/>
						<xsl:call-template name="forwardExchangeRate"/>
						<xsl:call-template name="fxClientRate"/>
						<xsl:call-template name="fxMarketRate"/>
						<xsl:call-template name="fxMargin"/>
						<xsl:call-template name="fxMarginP"/>
						<xsl:call-template name="fxRateDirection"/>
						<xsl:call-template name="initiationDate"/>
						<xsl:call-template name="operationGrossAmount"/>
						<xsl:call-template name="purchasedQuantity"/>
						<xsl:call-template name="soldCcyCurrentAccount"/>
						<xsl:call-template name="soldCcyNetAmount"/>
						<xsl:call-template name="spotExchangeRate"/>
						<xsl:call-template name="startingDate"/>
					</forwardPurchaseOpening>
				</ForexForward>
			</DataGroup>
		</TransactionPMS>
	</xsl:template>
	<!-- end of . -->
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