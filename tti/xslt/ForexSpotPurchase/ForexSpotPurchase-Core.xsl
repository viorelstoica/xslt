<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="accountingCode">
      <accountingCode>
         <xsl:value-of select="''"/>
      </accountingCode>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:valueDateBuy"/>
         </xsl:call-template>
      </accountingDate>
   </xsl:template>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:choose>
				<xsl:when test="b:tapSleevePtf != ''">
                  <xsl:value-of select="b:tapSleevePtf"/>
               </xsl:when>
               <xsl:when test="b:portfolioNumber">
                  <xsl:value-of select="concat(b:counterparty , '-' , b:portfolioNumber)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]">
                        <xsl:value-of select="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]"/>
                     </xsl:when>
                     <xsl:when test="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]">
                        <xsl:value-of select="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]"/>
                     </xsl:when>
					 <xsl:when test="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]">
                        <xsl:value-of select="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]"/>
                     </xsl:when>
                     <xsl:when test="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]">
                        <xsl:value-of select="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="''"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
         <reversalIndicator>
            <xsl:value-of select="'1'"/>
         </reversalIndicator>
         <reversedTransactionCode>
            <xsl:choose>
               <xsl:when test="b:tapRefId"><!-- order created on TAP -->
                  <xsl:value-of select="b:tapRefId"/>
               </xsl:when>
               <xsl:otherwise><!-- order created on T24 -->
                  <xsl:value-of select="b:id"/>
                  <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
                  <xsl:value-of select="b:companyMnemonicJoin"/>
               </xsl:otherwise>
            </xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
         <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
         <xsl:value-of select="b:companyMnemonicJoin"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="subType">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="starts-with(b:linkReference,'DXTRA') and $opStatus != 'REVERSE-AUTHORISE'">
         <subType>
            <infra:code>
               <xsl:value-of select="concat('FX_',b:transactionType,'_',substring(b:closeoutTypeGroup[@index='1']/b:closeoutTypeSubGroup[@index='1']/b:closeoutType,1,3),'_',b:linkOptionType)"/>
            </infra:code>
         </subType>
      </xsl:if>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <xsl:if test="b:transactionType != ''">
            <infra:code>
               <xsl:value-of select="'FX_'"/>
               <xsl:value-of select="b:transactionType"/>
            </infra:code>
         </xsl:if>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="fxRateDirection">
      <fxRateDirection>
         <xsl:choose>
            <xsl:when test="b:tapFxRateDir = '0' or b:tapFxRateDir = '1'">
               <xsl:value-of select="b:tapFxRateDir"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </fxRateDirection>
   </xsl:template>
   <xsl:template name="fxClientRate">
      <fxClientRate>
         <xsl:value-of select="b:spotRate"/>
      </fxClientRate>
   </xsl:template>
   <xsl:template name="fxMarketRate">
      <fxMarketRate>
         <xsl:value-of select="b:treasuryRate"/>
      </fxMarketRate>
   </xsl:template>
   <xsl:template name="purchasedCcyCurrentAccount">
      <purchasedCcyCurrentAccount>
         <infra:code><!-- <xsl:value-of select="b:ourAccountPay1Group/b:ourAccountPay1"/> -->
			<xsl:choose>
            	<xsl:when test="b:ourAccountPayGroup/b:ourAccPaySlv != ''">
               		<xsl:value-of select="b:ourAccountPayGroup/b:ourAccPaySlv"/>
            	</xsl:when>
            	<xsl:otherwise>
               		<xsl:value-of select="b:ourAccountPayGroup/b:ourAccountPay"/>
            	</xsl:otherwise>
         	</xsl:choose>
         </infra:code>
      </purchasedCcyCurrentAccount>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:amountSold"/>
      </quantity>
   </xsl:template>
   <xsl:template name="soldCurrencyCurrentAccount">
      <soldCurrencyCurrentAccount>
         <infra:code><!-- <xsl:value-of select="b:ourAccountPay1Group/b:ourAccountRec1"/> -->
			<xsl:choose>
            	<xsl:when test="b:ourAccountPayGroup/b:ourAccRecSlv != ''">
               		<xsl:value-of select="b:ourAccountPayGroup/b:ourAccRecSlv"/>
            	</xsl:when>
            	<xsl:otherwise>
               		<xsl:value-of select="b:ourAccountPayGroup/b:ourAccountRec"/>
            	</xsl:otherwise>
         	</xsl:choose>
         </infra:code>
      </soldCurrencyCurrentAccount>
   </xsl:template>
   <xsl:template name="soldCurrencyNetAmount">
      <soldCurrencyNetAmount>
         <xsl:value-of select="b:amountBought"/>
      </soldCurrencyNetAmount>
   </xsl:template>
   <xsl:template name="spotExchangeRate">
      <spotExchangeRate>
         <xsl:choose>
            <xsl:when test="b:tapFxRateDir = '1'">
               <xsl:value-of select="format-number(1 div b:spotRate,$decimalformat,'nan2zero')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:spotRate"/>
            </xsl:otherwise>
         </xsl:choose>
      </spotExchangeRate>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose><!-- Reversal -->
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               <xsl:choose>
                  <xsl:when test="b:tapRefId"><!-- order created on TAP -->
                     <xsl:value-of select="b:tapRefId"/>
                     <xsl:value-of select="'-R'"/>
                  </xsl:when>
                  <xsl:otherwise><!-- order created on T24 -->
                     <xsl:value-of select="b:id"/>
                     <xsl:value-of select="'-R'"/>
                     <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
                     <xsl:value-of select="b:companyMnemonicJoin"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when><!-- not a reversal -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:tapRefId"><!-- order created on TAP -->
                     <xsl:value-of select="b:tapRefId"/>
                  </xsl:when>
                  <xsl:otherwise><!-- order created on T24 -->
                     <xsl:value-of select="b:id"/>
                     <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
                     <xsl:value-of select="b:companyMnemonicJoin"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:dealDate"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate><!-- T24 Value dates are equal and not later than x days after deal date -->
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:valueDateBuy"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="fxMarginN">
      <fxMarginN>
         <xsl:value-of select="b:marginPips"/>
      </fxMarginN>
   </xsl:template>
   <xsl:template name="fxMarginP">
      <fxMarginP>
         <xsl:value-of select="b:marginPerc"/>
      </fxMarginP>
   </xsl:template>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>

   <xsl:template name="account3">
   	<account3>
	<infra:code>
		<xsl:choose>
			<xsl:when test="b:ourAccountPayGroup/b:delChgAccount != ''">
				<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccount"/>
			</xsl:when>
			<xsl:when test="(b:ourAccountPayGroup/b:delChgAccount = '' or not(b:ourAccountPayGroup/b:delChgAccount)) and b:accountToCharge != ''">
				<xsl:value-of select="b:accountToCharge"/>
			</xsl:when>
		</xsl:choose>
		</infra:code>
	</account3>
	</xsl:template>

   <xsl:template name="account3CcyTradeCcyExchangeRate"/>

   <xsl:template name="account3NetAmount">
   <account3NetAmount>
   	<xsl:choose>
		<xsl:when test="(b:ourAccountPayGroup/b:delChgAccount != '') or b:accountToCharge != ''">
   			<xsl:choose>
				<xsl:when test="b:taxAmountGroup/b:taxAmount !='' or b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt !='' or b:ourAccountPayGroup/b:delAmountChg !='' or b:commissionTaken !=''">
					<xsl:value-of select="translate(number(b:taxAmountGroup/b:taxAmount),'aN',0)+translate(number(b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt),'aN',0)+translate(number(b:ourAccountPayGroup/b:delAmountChg),'aN',0)+translate(number(b:commissionTaken),'aN',0)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
	</xsl:choose>
   </account3NetAmount>
   </xsl:template>

   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="currentAccountCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="remark"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionFeesTaxesCounter">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="b:taxAmountGroup/b:taxAmount !='' or b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt != ''">
				<xsl:value-of select="translate(number(b:taxAmountGroup/b:taxAmount),'aN',0) + translate(number(b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt),'aN',0)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
							<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
						</xsl:when>
						<xsl:when test="(b:baseCcy = b:currencySold) and (b:ourAccountPayGroup/b:ourAccountPay = b:accountToCharge)">
							<xsl:value-of select="b:baseCcy"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:ourAccountPay != b:accountToCharge">
									<xsl:value-of select="b:accountRecJoin"/>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_TAXES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
			<xsl:choose>
			<xsl:when test="b:ourAccountPayGroup/b:delAmountChg != '' or b:commissionTaken != ''">
				<xsl:value-of select="translate(number(b:commissionTaken),'aN',0) + translate(number(b:ourAccountPayGroup/b:delAmountChg),'aN',0)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
			</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
							<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
						</xsl:when>
						<xsl:when test="(b:baseCcy = b:currencySold) and (b:ourAccountPayGroup/b:ourAccountPay = b:accountToCharge)">
							<xsl:value-of select="b:baseCcy"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:ourAccountPay != b:accountToCharge">
									<xsl:value-of select="b:accountRecJoin"/>
								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_CHARGES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
</xsl:stylesheet>