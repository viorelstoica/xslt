<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiPECustomerTxn">
		<xsl:apply-templates select="c:CurrentEvent/b:PECustomerTxn"/>
	</xsl:template>
	<xsl:template match="batch:BatchPECustomerTxn">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPECustomerTxn" name="BatchPECustomerTxn">
			<xsl:apply-templates select="b:PECustomerTxn"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiPECustomerTxn">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPECustomerTxn" name="BatchMultiPECustomerTxn">
			<xsl:apply-templates select="c:MultiPECustomerTxn"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:PECustomerTxn">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('PEInterestPayment',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Cash>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('PEInterestPayment.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<interest>
						<xsl:call-template name="account1"/>
						<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
						<xsl:call-template name="account1NetAmount"/>
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
						<xsl:call-template name="intermediary"/>
						<xsl:call-template name="market"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionFeesTaxesCounter"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
						<xsl:call-template name="balance"/>
						<xsl:call-template name="currentAccount"/>
						<xsl:call-template name="interestAmount"/>
						<xsl:call-template name="InterestCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="transactionCurrency"/>
						<xsl:call-template name="transactionDate"/>
					</interest>
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