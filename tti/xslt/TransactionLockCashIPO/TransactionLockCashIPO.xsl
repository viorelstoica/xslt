<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiSecOpenOrder">
		<xsl:apply-templates select="c:CurrentEvent/b:SecOpenOrder"/>
	</xsl:template>
	<xsl:template match="batch:BatchSecOpenOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSecOpenOrder" name="BatchSecOpenOrder">
			<xsl:apply-templates select="b:SecOpenOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiSecOpenOrder">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSecOpenOrder" name="BatchMultiSecOpenOrder">
			<xsl:apply-templates select="c:MultiSecOpenOrder"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:SecOpenOrder">
		<TransactionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionLockCashIPO',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<Cash>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TransactionLockCashIPO.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<locking>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="commonReference"/>
						<xsl:call-template name="contractNumber"/>
						<xsl:call-template name="currentAccount"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="endDate"/>
						<xsl:call-template name="lockingDate"/>
						<xsl:call-template name="lockingTransactionCode"/>
						<xsl:call-template name="lockingType"/>
						<xsl:call-template name="lockingUnlocking"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="quantity"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionCurrency"/>
						<xsl:call-template name="type"/>
						<xsl:call-template name="validityDate"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
					</locking>
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