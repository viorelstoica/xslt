<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecurityBookValueAdjust"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBookValueAdjust" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecurityBookValueAdjust" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBookValueAdjust" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionSecurityBookValueAdjust">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionSecurityBookValueAdjust"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionSecurityBookValueAdjust">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionSecurityBookValueAdjust" name="BatchTransactionSecurityBookValueAdjust">
			<xsl:apply-templates select="b:TransactionSecurityBookValueAdjust"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionSecurityBookValueAdjust">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecurityBookValueAdjust" name="BatchMultiTransactionSecurityBookValueAdjust">
			<xsl:apply-templates select="c:MultiTransactionSecurityBookValueAdjust"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionSecurityBookValueAdjust">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionSecurityBookValueAdjust',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Security>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionSecurityBookValueAdjust.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<bookValueAdjust>
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
						<xsl:call-template name="ContractNumber"/>
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
						<xsl:call-template name="adjustmentNature"/>
						<xsl:call-template name="coaReference"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="initiatedBy"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="newInstrumentQuantity"/>
						<xsl:call-template name="originalDepositaryAccount"/>
						<xsl:call-template name="originalInstrumentQuantity"/>
						<xsl:call-template name="originalPositionCriteria1"/>
						<xsl:call-template name="originalPositionCriteria2"/>
						<xsl:call-template name="originalPositionCriteria3"/>
						<xsl:call-template name="originalSecurity"/>
						<xsl:call-template name="originalSecurityPositionCurrency"/>
						<xsl:call-template name="PositionCriteria1"/>
						<xsl:call-template name="positionCriteria2"/>
						<xsl:call-template name="positionCriteria3"/>
						<xsl:call-template name="positionCurrency"/>
						<xsl:call-template name="profitLossCounter"/>
						<xsl:call-template name="quote"/>
						<xsl:call-template name="referenceOperationCode"/>
						<xsl:call-template name="security"/>
						<xsl:call-template name="splitPortfolio"/>
						<xsl:call-template name="supplementAmount"/>
						<xsl:call-template name="trader"/>
						<xsl:call-template name="transactionDate"/>
					</bookValueAdjust>
				</Security>
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