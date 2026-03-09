<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:choose>
               <xsl:when test="b:swapBaseCcy = b:currencyBought">
                  <xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountRec"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountPay"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount><!--ok-->
         <xsl:choose>
            <xsl:when test="b:swapBaseCcy = b:currencyBought">
               <xsl:value-of select="b:amountBought"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:amountSold"/>
            </xsl:otherwise>
         </xsl:choose>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="account2">
      <account2>
         <infra:code>
            <xsl:choose>
               <xsl:when test="b:swapBaseCcy = b:currencyBought">
                  <xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountPay"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountRec"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </account2>
   </xsl:template>
   <xsl:template name="account2CcyFTCcyExchangeRate">
      <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <account2CcyFTCcyExchangeRate><!-- is always: amountFloatCurr / amountSwapCurr on spot rate -->
         <xsl:choose>
            <xsl:when test="$buyOrSell = 'BUY'">
               <xsl:choose>
                  <xsl:when test="b:baseCcy = b:currencyBought">
                     <xsl:value-of select="format-number(substring(1 div b:spotRate,1,11),$decimalformat,'nan2zero')"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="substring(b:spotRate,1,11)"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:baseCcy = b:currencyBought">
                     <xsl:value-of select="substring(b:spotRate,1,11)"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="format-number(substring(1 div b:spotRate,1,11),$decimalformat,'nan2zero')"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </account2CcyFTCcyExchangeRate>
   </xsl:template>
   <xsl:template name="account2NetAmount">
      <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="QtyInSwapCurr">
         <xsl:choose>
            <xsl:when test="b:currencyBought = b:swapBaseCcy">
               <xsl:value-of select="b:amountBought"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:amountSold"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <account2NetAmount><!-- Need to compute as amount i spot are not available in FWD leg -->
         <xsl:choose>
            <xsl:when test="$buyOrSell = 'SELL' and b:baseCcy = b:currencyBought">
               <xsl:value-of select="format-number($QtyInSwapCurr * b:spotRate * (-1),'#.##','nan2zero')"/>
            </xsl:when>
            <xsl:when test="$buyOrSell = 'SELL' and b:baseCcy = b:currencySold">
               <xsl:value-of select="format-number($QtyInSwapCurr div b:spotRate * (-1),'#.##','nan2zero')"/>
            </xsl:when>
            <xsl:when test="$buyOrSell = 'BUY' and b:baseCcy = b:currencyBought">
               <xsl:value-of select="format-number($QtyInSwapCurr div b:spotRate * (-1),'#.##','nan2zero')"/>
            </xsl:when>
            <xsl:when test="$buyOrSell = 'BUY' and b:baseCcy = b:currencySold">
               <xsl:value-of select="format-number($QtyInSwapCurr * b:spotRate * (-1),'#.##','nan2zero')"/>
            </xsl:when>
            <xsl:otherwise/>
         </xsl:choose>
      </account2NetAmount>
   </xsl:template>
   <xsl:template name="baseCurrQuantity">
      <baseCurrQuantity>
         <xsl:choose>
            <xsl:when test="b:currencyBought = b:swapBaseCcy">
               <xsl:value-of select="b:amountBought"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:amountSold"/>
            </xsl:otherwise>
         </xsl:choose>
      </baseCurrQuantity>
   </xsl:template>
   <xsl:template name="direction">
      <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <direction>
         <xsl:choose>
            <xsl:when test="$buyOrSell = 'BUY'">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'2'"/>
            </xsl:otherwise>
         </xsl:choose>
      </direction>
   </xsl:template>
   <xsl:template name="expirationDate">
      <expirationDate><!-- only on the FWD part -->
         <xsl:choose>
            <xsl:when test="b:valueDateBuy &lt; b:valueDateSell">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDateBuy"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:valueDateSell"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </expirationDate>
   </xsl:template>
   <xsl:template name="fxSwapContract">
      <fxSwapContract><!-- ok -->
         <infra:code>
            <xsl:value-of select="concat('SW_',b:swapBaseCcy,'/')"/>
            <xsl:choose>
               <xsl:when test="b:swapBaseCcy = b:currencyBought">
                  <xsl:value-of select="b:currencySold"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:currencyBought"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </fxSwapContract>
   </xsl:template>
   <xsl:template name="operationGrossAmount">
      <operationGrossAmount>
         <xsl:value-of select="'0'"/>
      </operationGrossAmount>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:choose>
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
   <xsl:template name="referenceNature">
      <referenceNature>
         <xsl:value-of select="17"/>
      </referenceNature>
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
                  <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=1]"/>
                  <xsl:value-of select="'/' "/>
                  <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=2]"/>
                  <xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
                  <xsl:value-of select="b:companyMnemonicJoin"/>
               </xsl:otherwise>
            </xsl:choose>
         </reversedTransactionCode>
      </xsl:if>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=1]"/>
         <xsl:value-of select="'/' "/>
         <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=2]"/>
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
   <xsl:template name="tradeCurrency">
      <tradeCurrency>
         <infra:code>
            <xsl:value-of select="b:swapBaseCcy"/>
         </infra:code>
      </tradeCurrency>
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
                     <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=1] "/>
                     <xsl:value-of select="'/'"/>
                     <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=2] "/>
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
                     <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=1]"/>
                     <xsl:value-of select="'/' "/>
                     <xsl:value-of select="b:swapRefNoList/b:swapRefNo[@index=2]"/>
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
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat('FX_',b:dealType)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="b:spotDate"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="referenceOperationCode"/>
   <xsl:template name="userDefinedField">
      <userDefinedField>
         <infra:name>ud_spot_value_d</infra:name>
         <infra:value>
            <xsl:call-template name="xsdate">
               <xsl:with-param name="date" select="b:spotDate"/>
            </xsl:call-template>
         </infra:value>
         <infra:type>date</infra:type>
      </userDefinedField>
   </xsl:template>
   <xsl:template name="mbFields"/>
   <xsl:template name="fxRateDirection">
      <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <fxRateDirection>
         <xsl:choose>
            <xsl:when test="b:tapFxRateDir">
               <xsl:value-of select="b:tapFxRateDir"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="$buyOrSell = 'BUY'">
                     <xsl:choose>
                        <xsl:when test="b:baseCcy = b:currencyBought">
                           <xsl:value-of select="'1'"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="'0'"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:choose>
                        <xsl:when test="b:baseCcy = b:currencyBought">
                           <xsl:value-of select="'1'"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:value-of select="'0'"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </fxRateDirection>
   </xsl:template>
   <xsl:template name="fxClientRate">
      <fxClientRate>
         <xsl:value-of select="b:forwardRate"/>
      </fxClientRate>
   </xsl:template>
   <xsl:template name="fxMarketRate">
      <fxMarketRate>
         <xsl:value-of select="b:treasuryRate"/>
      </fxMarketRate>
   </xsl:template>
   <xsl:template name="fxSpotRate">
      <fxSpotRate>
         <xsl:value-of select="b:spotRate"/>
      </fxSpotRate>
   </xsl:template>
   <xsl:template name="sellForward">
      <sellForward>
         <xsl:choose>
            <xsl:when test="b:currencyBought = b:swapBaseCcy">
               <xsl:value-of select="b:amountSold"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:amountBought"/>
            </xsl:otherwise>
         </xsl:choose>
      </sellForward>
   </xsl:template>
   <xsl:template name="orderType">
      <xsl:if test="not(b:tapRefId)"><!-- Define a PCK order type if order is created on T24 -->
         <orderType>
            <infra:code>
               <xsl:value-of select="'PCK_DS_FXFWD_NEGO'"/>
            </infra:code>
         </orderType>
      </xsl:if>
   </xsl:template>
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
   <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
  	 <account3NetAmount>
	 <xsl:choose>
	   <xsl:when test="$buyOrSell = 'BUY'">
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
	 </xsl:when>
	 <xsl:otherwise>
			<xsl:choose>
				<xsl:when test="(b:ourAccountPayGroup/b:delChgAccount != '') or b:accountToCharge != ''">
   					<xsl:choose>
						<xsl:when test="b:taxAmountGroup/b:taxAmount !='' or b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt !='' or b:ourAccountPayGroup/b:delAmountChg !='' or b:commissionTaken !=''">
							<xsl:value-of select="-1*(translate(number(b:taxAmountGroup/b:taxAmount),'aN',0)+translate(number(b:ourAccountPayGroup/b:delTaxAmtSubGroup/b:delTaxAmt),'aN',0)+translate(number(b:ourAccountPayGroup/b:delAmountChg),'aN',0)+translate(number(b:commissionTaken),'aN',0))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
	 		</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
   </account3NetAmount>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
   <xsl:variable name="buyOrSell">
         <xsl:choose><!-- Created in TAP -->
            <xsl:when test="b:tapOperNature = '1' and b:tapRefId">
               <xsl:value-of select="'BUY'"/>
            </xsl:when>
            <xsl:when test="b:tapOperNature = '2'  and b:tapRefId">
               <xsl:value-of select="'SELL'"/>
            </xsl:when><!-- Created in T24 -->
            <xsl:otherwise>
               <xsl:choose>
                  <xsl:when test="b:swapBaseCcy = b:currencySold">
                     <xsl:value-of select="'BUY'"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="'SELL'"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
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
						<xsl:when test="$buyOrSell = 'BUY'">
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
									<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
								</xsl:when>
								<xsl:when test="(b:baseCcy = b:currencyBought) and (b:ourAccountPayGroup/b:ourAccountRec = b:accountToCharge)">
									<xsl:value-of select="b:baseCcy"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="b:ourAccountPayGroup/b:ourAccountRec != b:accountToCharge">
											<xsl:value-of select="b:accountRecJoin"/>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
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
						<xsl:when test="$buyOrSell = 'BUY'">
							<xsl:choose>
								<xsl:when test="b:ourAccountPayGroup/b:delChgAccCcy !=''">
									<xsl:value-of select="b:ourAccountPayGroup/b:delChgAccCcy"/>
								</xsl:when>
								<xsl:when test="(b:baseCcy = b:currencyBought) and (b:ourAccountPayGroup/b:ourAccountRec = b:accountToCharge)">
									<xsl:value-of select="b:baseCcy"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="b:ourAccountPayGroup/b:ourAccountRec != b:accountToCharge">
											<xsl:value-of select="b:accountRecJoin"/>
										</xsl:when>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
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
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_CHARGES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		</xsl:template>
   <xsl:template name="account1CcyFTCcyExchangeRate"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="notepad"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="swapRate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\..\..\Users\shobiya.lakshmanan\IBM\wtx\workspace\FeesForex\XML Schema\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes"
		            destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="account1">
				<block path="account1/infra:code/xsl:choose" x="372" y="66"/>
				<block path="account1/infra:code/xsl:choose/=[0]" x="326" y="60"/>
				<block path="account1/infra:code/xsl:choose/xsl:when/xsl:value-of" x="322" y="96"/>
				<block path="account1/infra:code/xsl:choose/xsl:otherwise/xsl:value-of" x="282" y="96"/>
			</template>
			<template name="account2CcyFTCcyExchangeRate">
				<block path="account2CcyFTCcyExchangeRate/xsl:choose" x="262" y="36"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/=[0]" x="216" y="30"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:when/xsl:choose" x="372" y="66"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:when/xsl:choose/=[0]" x="326" y="60"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:when/xsl:choose/xsl:when/xsl:value-of" x="322" y="96"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:when/xsl:choose/xsl:otherwise/xsl:value-of" x="282" y="96"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:otherwise/xsl:choose" x="172" y="66"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:otherwise/xsl:choose/=[0]" x="126" y="60"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:otherwise/xsl:choose/xsl:when/xsl:value-of" x="242" y="96"/>
				<block path="account2CcyFTCcyExchangeRate/xsl:choose/xsl:otherwise/xsl:choose/xsl:otherwise/xsl:value-of" x="122" y="96"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->