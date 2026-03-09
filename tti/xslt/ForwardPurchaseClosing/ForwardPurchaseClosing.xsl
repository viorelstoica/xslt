<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/ForwardPurchaseClosing"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchForwardPurchaseClosing" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiForwardPurchaseClosing" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiForwardPurchaseClosing" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiForwardPurchaseClosing">
		<xsl:apply-templates select="c:CurrentEvent/b:ForwardPurchaseClosing"/>
	</xsl:template>
	<xsl:template match="batch:BatchForwardPurchaseClosing">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchForwardPurchaseClosing" name="BatchForwardPurchaseClosing">
			<xsl:apply-templates select="b:ForwardPurchaseClosing"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiForwardPurchaseClosing">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiForwardPurchaseClosing" name="BatchMultiForwardPurchaseClosing">
			<xsl:apply-templates select="c:MultiForwardPurchaseClosing"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ForwardPurchaseClosing">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('ForwardPurchaseClosing',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<ForexForward>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('ForwardPurchaseClosing.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<forwardPurchaseClosing>
						<xsl:call-template name="account2"/>
						<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account2NetAmount"/>
						<xsl:call-template name="account3"/>
						<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account3NetAmount"/>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="commonReference"/>
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
						<xsl:call-template name="closingDate"/>
						<xsl:call-template name="contractReferenceCode"/>
						<xsl:call-template name="fixingDate"/>
						<xsl:call-template name="forwardContract"/>
						<xsl:call-template name="forwardExchangeRate"/>
						<xsl:call-template name="fxClientRate"/>
						<xsl:call-template name="fxRateDirection"/>
						<xsl:call-template name="operationAmount"/>
						<xsl:call-template name="operationDate"/>
						<xsl:call-template name="operationGrossAmount"/>
						<xsl:call-template name="purchasedCcyNetAmount"/>
						<xsl:call-template name="purchasedCcyCurrentAccount"/>
						<xsl:call-template name="soldQuantity"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="valueDate"/>
					</forwardPurchaseClosing>
				</ForexForward>
			</DataGroup>
		</TransactionPMS>
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