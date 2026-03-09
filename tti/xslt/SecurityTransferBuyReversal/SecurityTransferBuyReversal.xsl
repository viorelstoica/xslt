<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiSecurityTransfer">
      <xsl:apply-templates select="c:CurrentEvent/b:SecurityTransfer"/>
   </xsl:template>
   <xsl:template match="batch:BatchSecurityTransfer">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer" name="BatchSecurityTransfer">
         <xsl:apply-templates select="b:SecurityTransfer"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSecurityTransfer">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer" name="BatchMultiSecurityTransfer">
         <xsl:apply-templates select="c:MultiSecurityTransfer"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SecurityTransfer">
      <TransactionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('securityTransferBuyReversal',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('SecurityTransferBuyReversal.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <purchase>
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
                  <xsl:call-template name="accruedInterests"/>
                  <xsl:call-template name="accruedInterestCounter"/>
                  <xsl:call-template name="broker"/>
				  <xsl:call-template name="compundOrderCode"/>
				  <xsl:call-template name="compoundOrderMaster"/>
				  <xsl:call-template name="compoundOrderSlave"/>
				  <xsl:call-template name="contactMethod"/>
                  <xsl:call-template name="depositaryAccount"/>
                  <xsl:call-template name="exCoupon"/>
                  <xsl:call-template name="executionSetCriteria"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="initiator"/>
                  <xsl:call-template name="limitPrice"/>
                  <xsl:call-template name="orderType"/>
                  <xsl:call-template name="orderValidityType"/>
                  <xsl:call-template name="originalOrderCode"/>
				  <xsl:call-template name="paymentOptionE"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="price"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="security"/>
                  <xsl:call-template name="securityCcyNetAmount"/>
                  <xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="stockExchange"/>
                  <xsl:call-template name="stopPrice"/>
				  <xsl:call-template name="targetAmount"/>
				  <xsl:call-template name="targetNature"/>
				  <xsl:call-template name="targetObjective"/>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="tradeCurrency"/>
                  <xsl:call-template name="tradeCcyGrossAmount"/>
                  <xsl:call-template name="tradeCcyNetAmount"/>
                  <xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="tradeDate"/>
                  <xsl:call-template name="validityDate"/>
                  <xsl:call-template name="coolCancelEndDate"/>
                  <xsl:call-template name="referenceNature"/>
               </purchase>
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