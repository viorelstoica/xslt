<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferPtfToPtfWithdrReversal" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferPtfToPtfWithdrReversal" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferPtfToPtfWithdrReversal" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferPtfToPtfWithdrReversal" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiPositionTransferPtfToPtfWithdrReversal">
      <xsl:apply-templates select="c:CurrentEvent/b:PositionTransferPtfToPtfWithdrReversal"/>
   </xsl:template>
   <xsl:template match="batch:BatchPositionTransferPtfToPtfWithdrReversal">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPositionTransferPtfToPtfWithdrReversal" name="BatchPositionTransferPtfToPtfWithdrReversal">
         <xsl:apply-templates select="b:PositionTransferPtfToPtfWithdrReversal"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiPositionTransferPtfToPtfWithdrReversal">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferPtfToPtfWithdrReversal" name="BatchMultiPositionTransferPtfToPtfWithdrReversal">
         <xsl:apply-templates select="c:MultiPositionTransferPtfToPtfWithdrReversal"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:PositionTransferPtfToPtfWithdrReversal">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('positionTransferPtfToPtfWithdrReversal',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:securityNoGroup">
               <Security>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('PositionTransferPtfToPtfWithdrReversal.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <transferOut>
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
                     <xsl:call-template name="accountCurrency"/>
                     <xsl:call-template name="accruedInterestCounter"/>
                     <xsl:call-template name="accruedInterests"/>
                     <xsl:call-template name="depositaryAccount"/>
					 <xsl:call-template name="histOpExchRate"/>
					 <xsl:call-template name="histOpNetAmount"/>
					 <xsl:call-template name="histQuote"/>
                     <xsl:call-template name="initiatedBy"/>
                     <xsl:call-template name="positionCriteria1"/>
                     <xsl:call-template name="positionCriteria2"/>
                     <xsl:call-template name="positionCriteria3"/>
                     <xsl:call-template name="quantity"/>
                     <xsl:call-template name="security"/>
                     <xsl:call-template name="trader"/>
                     <xsl:call-template name="transactionCcyGrossAmount"/>
                     <xsl:call-template name="transactionCcyNetAmount"/>
                     <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
                     <xsl:call-template name="transactionCurrency"/>
                     <xsl:call-template name="transactionDate"/>
                     <xsl:call-template name="transferPrice"/>
                  </transferOut>
               </Security>
            </xsl:for-each>
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