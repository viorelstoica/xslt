<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrderNotification" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="transactionCode">
			<xsl:variable name="OperationReversed">
                <xsl:if test="starts-with(b:paymentStatusAddInfo, $PAYMENT_ORDER_STATUS_REVERSED)">
					<xsl:value-of select="'1'"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="OriginalOperationCode">
				<xsl:choose>
					<xsl:when test="b:paymentOrderTapRefId != '' and b:paymentOrderTapOperNature = 'WI'">
						<xsl:value-of select="b:paymentOrderTapRefId"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('PO_',b:paymentOrderId,'_D',$COMPANY_POSTFIX_SEPARATOR,b:paymentOrderCompanyMnemonic)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="$OperationReversed = '1'">
					<transactionCode>
						<xsl:value-of select="concat($OriginalOperationCode,'_R')"/>
					</transactionCode>
				</xsl:when>
				<xsl:otherwise>
					<transactionCode>
						<xsl:value-of select="$OriginalOperationCode"/>
					</transactionCode>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:paymentOrderDebitAccount"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="b:paymentSystemStatus"/>
		</remark>
	</xsl:template>
    <xsl:template name="status">
        <status>
			<xsl:choose>
				<xsl:when test="b:paymentStatusAddInfo and starts-with(b:paymentStatusAddInfo,$PAYMENT_ORDER_STATUS_CANCELLED)">
		            <xsl:call-template name="statusTranslation">
		                <xsl:with-param name="boStatus" select="'CANCELLED'"/>
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
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:paymentOrderDebitAccountPortfolioNoList/b:paymentOrderDebitAccountPortfolioNo and b:paymentOrderDebitAccountPortfolioNoList/b:paymentOrderDebitAccountPortfolioNo != ''">
						<xsl:value-of select="b:paymentOrderDebitAccountPortfolioNoList/b:paymentOrderDebitAccountPortfolioNo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:paymentOrderDebitAccountSamHistId"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:porTransactionDebitMainAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="account1">
	   <account1>
            <infra:code>
                <xsl:value-of select="b:paymentOrderDebitAccount"/>
            </infra:code>
	   </account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount">
	    <account1NetAmount>
	         <xsl:choose>
	           <xsl:when test="b:porTransactionDebitMainAmount != b:porTransactionPostingMainAmountDebit">
	              <xsl:value-of select="format-number(b:porTransactionPostingMainAmountDebit - b:porTransactionDebitMainAmount,'0.##','nan2zero')"/>
	           </xsl:when>
	           <xsl:otherwise>
	              <xsl:value-of select="0"/>
	           </xsl:otherwise>
	        </xsl:choose>	
        </account1NetAmount>
	</xsl:template>
    <xsl:template name="accountingDate">
            <accountingDate>        
               <xsl:value-of select="b:paymentOrderPaymentExecutionDate"/>
            </accountingDate>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
    <xsl:template name="sourceSystemCode">
        <sourceSystemCode>
            <xsl:value-of select="b:paymentOrderId" />
        </sourceSystemCode>
    </xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="reversalIndicator">
		<xsl:variable name="OperationReversed">
                <xsl:if test="starts-with(b:paymentStatusAddInfo, $PAYMENT_ORDER_STATUS_REVERSED)">
				<xsl:value-of select="'1'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:if test="$OperationReversed = '1'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:variable name="OperationReversed">
                <xsl:if test="starts-with(b:paymentStatusAddInfo, $PAYMENT_ORDER_STATUS_REVERSED)">
				<xsl:value-of select="'1'"/>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="OriginalOperationCode">
			<xsl:choose>
				<xsl:when test="b:paymentOrderTapRefId != '' and b:paymentOrderTapOperNature = 'WI'">
					<xsl:value-of select="b:paymentOrderTapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('PO_',b:paymentOrderId,'_D',$COMPANY_POSTFIX_SEPARATOR,b:paymentOrderCompanyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$OperationReversed = '1'">
			<reversedTransactionCode>
				<xsl:value-of select="$OriginalOperationCode"/>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
    <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
         <amount>
             <xsl:choose>
              <xsl:when test="b:porTransactionDebitMainAmount != b:porTransactionPostingMainAmountDebit">
                 <xsl:value-of select="format-number(b:porTransactionPostingMainAmountDebit - b:porTransactionDebitMainAmount,'0.##','nan2zero')"/>
              </xsl:when>
              <xsl:otherwise>
                 <xsl:value-of select="0"/>
              </xsl:otherwise>
           </xsl:choose>
         </amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:DebitMainAccountCurrencyCode"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>CASH_OP_TOT_CHARGES</infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>  
	<xsl:template name="type"/>
    <xsl:template name="valueDate">
       <valueDate>
            <xsl:choose>
                  <xsl:when test="b:debitValueDate and b:debitValueDate!= ''">
                       <xsl:value-of select="b:debitValueDate"/>                                     
                  </xsl:when>
                  <xsl:otherwise>
                       <xsl:value-of select="b:paymentOrderPaymentExecutionDate"/>                   
                  </xsl:otherwise>
            </xsl:choose>
       </valueDate>
    </xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount">
	   <transactionCcyNetAmount>
       <xsl:if test="b:porTransactionDebitMainAmount != b:porTransactionPostingMainAmountDebit">
           <xsl:value-of select="b:porTransactionPostingMainAmountDebit"/>
       </xsl:if>
       </transactionCcyNetAmount>
	</xsl:template>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="transactionDate">
        <transactionDate>
            <xsl:value-of select="b:paymentOrderPaymentExecutionDate"/>
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