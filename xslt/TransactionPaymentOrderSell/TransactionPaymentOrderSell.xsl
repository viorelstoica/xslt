<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPaymentOrder">
		<xsl:apply-templates select="c:CurrentEvent/b:PaymentOrder"/>
	</xsl:template>
	<xsl:template match="batch:BatchPaymentOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPaymentOrder" name="BatchPaymentOrder">
			<xsl:apply-templates select="b:PaymentOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPaymentOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrder" name="BatchMultiPaymentOrder">
			<xsl:apply-templates select="c:MultiPaymentOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PaymentOrder">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionPaymentOrderSell',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Cash>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionPaymentOrderSell.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<transferIntraPortfolio>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="commonReference"/>
						<xsl:call-template name="contractNumber"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="sourceCurrentAccount"/>
						<xsl:call-template name="sourceCurrentAccountCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="sourceCurrentAccountCcyTargetCurrentAccountCcyExchangeRate"/>
						<xsl:call-template name="sourceCurrentAccountNetAmount"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="targetCurrentAccount"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionCcyNetAmount"/>
						<xsl:call-template name="transactionCurrency"/>
						<xsl:call-template name="transactionDate"/>
						<xsl:call-template name="transactionFeesTaxesCounter"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
					</transferIntraPortfolio>
				</Cash>
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