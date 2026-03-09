<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyFxForwardsCob" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:cuSellCcyAcct"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2">
      <account2>
         <infra:code>
            <xsl:value-of select="b:cuBuyCcyAcct"/>
         </infra:code>
      </account2>
   </xsl:template>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="accountingDate">
      <accountingDate>
        <xsl:choose>
				<xsl:when test="b:contractStatus='MATURED'">
					<xsl:value-of select="b:maturityDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='UNWOUND'">
					<xsl:value-of select="b:unwindEffDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='KNOCKEDOUT' or b:bUndoFixing = 'YES' or b:bUndoKnockout = 'YES' or b:bKnockOut = 'YES' or b:sUndoFixing = 'YES' or b:sUndoKnockout = 'YES' or b:sKnockOut = 'YES'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
			</xsl:choose>
      </accountingDate>
   </xsl:template>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_Close')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'Close')"/>
            </xsl:otherwise>
         </xsl:choose>        
      </transactionCode>
   </xsl:template>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
              <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>  
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="tradeCurrency">
      <tradeCurrency>
         <infra:code>
            <xsl:value-of select="b:contractCcy"/>
         </infra:code>
      </tradeCurrency>
   </xsl:template>
   <xsl:template name="tradeDate">
      <tradeDate>
         <xsl:choose>
				<xsl:when test="b:contractStatus='MATURED'">
					<xsl:value-of select="b:maturityDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='UNWOUND'">
					<xsl:value-of select="b:unwindEffDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='KNOCKEDOUT' or b:bUndoFixing = 'YES' or b:bUndoKnockout = 'YES' or b:bKnockOut = 'YES' or b:sUndoFixing = 'YES' or b:sUndoKnockout = 'YES' or b:sKnockOut = 'YES'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
			</xsl:choose>
      </tradeDate>
   </xsl:template>
   <xsl:template name="tradeCcyGrossAmount"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="'1'"/>
      </quantity>
   </xsl:template>
   <xsl:template name="price">
      <price>
         <xsl:value-of select="'0'"/>
      </price>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
      <type>
         <infra:code>
			<xsl:choose>
					<xsl:when test="b:contractStatus ='MATURED'">
						<xsl:value-of select="'SYTARKO_CLOSE'"/>
					</xsl:when>
					<xsl:when test="b:contractStatus ='KNOCKEDOUT'">
						<xsl:value-of select="'SYTARKO_CONTRACT_KNOCKOUT'"/>
					</xsl:when>
					<xsl:when test="b:contractStatus ='UNWOUND'">
						<xsl:value-of select="'SYTARKO_UNWIND'"/>
					</xsl:when>
					<xsl:when test="b:bUndoFixing ='YES'">
						<xsl:value-of select="'SYTARKO_CALL_UNDOFIXING'"/>
					</xsl:when>
					<xsl:when test="b:bUndoKnockout ='YES'">
						<xsl:value-of select="'SYTARKO_CALL_UNDOKNOCKOUT '"/>
					</xsl:when>
					<xsl:when test="b:bKnockOut ='YES'">
						<xsl:value-of select="'SYTARKO_CALL_KNOCKOUT'"/>
					</xsl:when>
					<xsl:when test="b:sUndoFixing ='YES'">
						<xsl:value-of select="'SYTARKO_PUT_UNDOFIXING'"/>
					</xsl:when>
					<xsl:when test="b:sUndoKnockout ='YES'">
						<xsl:value-of select="'SYTARKO_PUT_UNDOKNOCKOUT'"/>
					</xsl:when>
					<xsl:when test="b:sKnockOut ='YES'">
						<xsl:value-of select="'SYTARKO_PUT_KNOCKOUT'"/>
					</xsl:when>
				</xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="expirationDate">
		<expirationDate>
			<xsl:choose>
				<xsl:when test="b:contractStatus='MATURED'">
					<xsl:value-of select="b:maturityDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='UNWOUND'">
					<xsl:value-of select="b:unwindEffDate"/>
				</xsl:when>
				<xsl:when test="b:contractStatus='KNOCKEDOUT' or b:bUndoFixing = 'YES' or b:bUndoKnockout = 'YES' or b:bKnockOut = 'YES' or b:sUndoFixing = 'YES' or b:sUndoKnockout = 'YES' or b:sKnockOut = 'YES'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
			</xsl:choose>
		</expirationDate>
	</xsl:template>
   <xsl:template name="broker"/>
   <xsl:template name="depositaryAccount"/>
   <xsl:template name="executionSetCriteria"/>
   <xsl:template name="originalOrderCode"/>
   <xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="tradeCcyNetAmount"/>
   <xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="referenceNature"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode">
   	<sourceSystemCode>
        <xsl:value-of select="b:id"/>
	</sourceSystemCode>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accruedInterests"/>
   <xsl:template name="accruedInterestCounter"/>
   <xsl:template name="exCoupon"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="limitPrice"/>
   <xsl:template name="orderType"/>
   <xsl:template name="orderValidityType"/>
   <xsl:template name="intermediary"/>			  
   <xsl:template name="market"/>
   <xsl:template name="accountCurrency"/> 
   <xsl:template name="compoundOrderCode"/>
   <xsl:template name="compoundOrderMaster"/>		  
   <xsl:template name="compoundOrderSlave"/>				  
   <xsl:template name="contactMethod"/>
   <xsl:template name="paymentOptionE"/>
   <xsl:template name="targetAmount"/>				  
   <xsl:template name="targetNature"/>				  
   <xsl:template name="targetObjective"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="securityCcyNetAmount"/>
   <xsl:template name="stopPrice"/>
   <xsl:template name="trader"/>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:value-of select="b:maturityDate"/>
      </validityDate>
   </xsl:template>
   <xsl:template name="hedgeTrade"/>
   <xsl:template name="orderTypeD"/>
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