<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/STTransferInActualSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
	  <account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:cuAccountNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
   </xsl:template>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
         <xsl:value-of select="b:custNetAmt"/>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:settlementDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio">
	  <portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:cuPortfolioGroup/b:cuPortfolio"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
   </xsl:template>
   <xsl:template name="remark">
      <remark>
         <xsl:variable name="remark">
            <xsl:for-each select="b:custRemarksList/b:custRemarks">
               <xsl:value-of select="concat(.,' ')"/>
            </xsl:for-each>
         </xsl:variable>
         <xsl:value-of select="substring($remark,1,80)"/>
      </remark>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="b:id"/>
      </sourceSystemCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
    <xsl:choose>
   	 	<xsl:when test="b:tapRefId != ''">
		  <transactionCode>
	 		<xsl:value-of select="b:tapRefId"/>
		  </transactionCode>
	 	</xsl:when>
		<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
			<transactionCode>
				<xsl:value-of select="concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
			</transactionCode>
		</xsl:when>
		<xsl:otherwise>
			<transactionCode>
				<xsl:value-of select="concat('ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
			</transactionCode>
		</xsl:otherwise>
	  </xsl:choose>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <xsl:call-template name="printTransferFeesAndTaxes">
         <xsl:with-param name="caller" select="'STTransferIn'"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="concat('SC_',b:transCode)"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:valueDate"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accountCurrency">
      <xsl:if test="b:cuAccountCcy != '' or b:cuAccountCcy">
         <accountCurrency>
            <infra:code>
               <xsl:value-of select="b:cuAccountCcy"/>
            </infra:code>
         </accountCurrency>
      </xsl:if>
   </xsl:template>
   <xsl:template name="commonReference"/>
   <xsl:template name="accruedInterests">
      <accruedInterests>
         <xsl:value-of select="b:interestAmt"/>
      </accruedInterests>
   </xsl:template>
   <xsl:template name="depositaryAccount">
      <xsl:choose>
			<xsl:when test="b:depository !='' and b:depository and b:subAccountTypeList/b:subAccountType[@index=1]=$subAccountNature">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
			<xsl:otherwise>
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="b:depository"/>
					</infra:code>
				</depositaryAccount>
			</xsl:otherwise>
		</xsl:choose>
   </xsl:template>
   <xsl:template name="histOpExchRate">
   	 <xsl:if test="$TAKE_HIST_VALUES_INV = 'YES'">
	 	<xsl:if test="$boDefaultExch_Inverse_Flag = '1' and (b:grossAmtSecCcy and b:grossAmtSecCcy != '') and (b:cost and b:cost != '') and (b:cost and number(b:cost) != '0')">
			<histOpExchRate>
            	<xsl:value-of select="format-number(b:grossAmtSecCcy div b:cost,$decimalformat,'nan2zero')"/>
      		</histOpExchRate>
		</xsl:if>
		<xsl:if test="$boDefaultExch_Inverse_Flag = '0' and (b:cost and b:cost != '') and (b:grossAmtSecCcy and b:grossAmtSecCcy != '') and (b:grossAmtSecCcy and number(b:grossAmtSecCcy) != '0')">
      		<histOpExchRate>
            	<xsl:value-of select="format-number(b:cost div b:grossAmtSecCcy,$decimalformat,'nan2zero')"/>
      		</histOpExchRate>
	  	</xsl:if>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="histOpNetAmount"/>
   <xsl:template name="histQuote">
	  <xsl:if test="$TAKE_HIST_VALUES_INV = 'YES'">
		 <histQuote>
	  		<xsl:value-of select="b:price"/>
		 </histQuote>
	  </xsl:if>
   	</xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:noNominal"/>
      </quantity>
   </xsl:template>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="b:securityNumber"/>
         </infra:code>
      </security>
   </xsl:template>
   <xsl:template name="transactionCcyPortfolioCcyExchangeRate">
      <xsl:variable name="netAmtSecCcy">
         <xsl:choose>
            <xsl:when test="b:netAmtSecCcy and b:netAmtSecCcy != ''">
               <xsl:value-of select="b:netAmtSecCcy"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="interestAmt">
         <xsl:choose>
            <xsl:when test="b:interestAmt and b:interestAmt != ''">
               <xsl:value-of select="b:interestAmt"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="grossAmtSecCcy">
         <xsl:choose>
            <xsl:when test="b:grossAmtSecCcy and b:grossAmtSecCcy != ''">
               <xsl:value-of select="b:grossAmtSecCcy"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      <xsl:variable name="custNetAmt">
         <xsl:choose>
            <xsl:when test="b:custNetAmt and b:custNetAmt != ''">
               <xsl:value-of select="b:custNetAmt"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="'0'"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
	  <xsl:variable name="cost">
	  	<xsl:choose>
			<xsl:when test="b:cost and b:cost != ''">
				<xsl:value-of select="b:cost"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'0'"/>
			</xsl:otherwise>
		</xsl:choose>
	  </xsl:variable>
	  <xsl:choose>
	  	<xsl:when test="b:cuAccountCcy = b:referenceCurrencyJoin">
	  		<xsl:choose>
	  			<xsl:when test="(number($netAmtSecCcy - $interestAmt - $grossAmtSecCcy) = '0') or number($custNetAmt) = '0'"/>
				<xsl:otherwise>
      				<transactionCcyPortfolioCcyExchangeRate>
					<xsl:choose>
						<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
							<xsl:value-of select="format-number(($netAmtSecCcy - $interestAmt - $grossAmtSecCcy) div $custNetAmt,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number($custNetAmt div ($netAmtSecCcy - $interestAmt - $grossAmtSecCcy),$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
					</transactionCcyPortfolioCcyExchangeRate>
				</xsl:otherwise>
	  		</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="number($cost) = '0' or number($grossAmtSecCcy) = '0'"/>
				<xsl:otherwise>
					<transactionCcyPortfolioCcyExchangeRate>
						<xsl:choose>
							<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
								<xsl:value-of select="format-number($cost div $grossAmtSecCcy,$decimalformat,'nan2zero')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="format-number($grossAmtSecCcy div $cost,$decimalformat,'nan2zero')"/>
							</xsl:otherwise>
						</xsl:choose>
					</transactionCcyPortfolioCcyExchangeRate>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>
	  </xsl:choose>
   </xsl:template>
   <xsl:template name="transactionCurrency">
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:securityCcy"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:value-of select="b:tradeDate"/>
      </transactionDate>
   </xsl:template>
   <xsl:template name="paymentDate">
		<xsl:choose>
			<xsl:when test="b:cashHoldSettle = 'YES'">
				<xsl:choose>
					<xsl:when test="b:brNomOutstandGroup/b:brAmtValDate and b:brNomOutstandGroup/b:brAmtValDate !='' ">
						<paymentDate>
							<xsl:value-of select="b:brNomOutstandGroup/b:brAmtValDate"/>
						</paymentDate>
					</xsl:when>
					<xsl:otherwise>
						<paymentDate>
							<xsl:value-of select="b:valueDate"/>
						</paymentDate>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<paymentDate>
					<xsl:value-of select="b:valueDate"/>
				</paymentDate>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="paymentStatus">
		<xsl:choose>
			<xsl:when test="b:cashHoldSettle = 'YES'">
				<xsl:choose>
					<xsl:when test="number(b:brNomOutstandGroup/b:brAmtOutstand) = '0'">
						<paymentStatus>
							<xsl:value-of select="'4'"/>
						</paymentStatus>
					</xsl:when>
					<xsl:otherwise>
						<paymentStatus>
							<xsl:value-of select="'3'"/>
						</paymentStatus>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:cashHoldSettle = 'NO' and b:secHoldSettle = 'YES'">
				<paymentStatus>
					<xsl:value-of select="'4'"/>
				</paymentStatus>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:choose>
				<xsl:when test="b:secHoldSettle = 'YES'">
					<xsl:value-of select="b:brNomOutstandGroup/b:brNomValDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:valueDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus">
		<xsl:choose>
			<xsl:when test="b:secHoldSettle = 'YES'">
				<xsl:choose>
					<xsl:when test="number(b:brNomOutstandGroup/b:brNomOutstand) = '0'">
						<settlementStatus>
							<xsl:value-of select="'4'"/>
						</settlementStatus>
					</xsl:when>
					<xsl:otherwise>
						<settlementStatus>
							<xsl:value-of select="'3'"/>
						</settlementStatus>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="b:cashHoldSettle = 'YES' and b:secHoldSettle = 'NO'">
				<settlementStatus>
					<xsl:value-of select="'4'"/>
				</settlementStatus>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="market"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="accruedInterestCounter"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCcyGrossAmount"/>
   <xsl:template name="transactionCcyNetAmount"/>
   <xsl:template name="transferPrice"/>
   <xsl:template name="boAccount">
		<boAccount>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:cuAccountNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:cuPortfolioGroup/b:cuPortfolio"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'1'"/>
					</xsl:otherwise>
				</xsl:choose>
		</splitPortfolio>
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