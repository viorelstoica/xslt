<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionSecuritySell" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionSecuritySell" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionSecuritySell" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionSecuritySell" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:tapSleevePtf != ''">
						<xsl:value-of select="../../b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:when test="../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory">
						<xsl:value-of select="substring(../b:custAccNo,1,8)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../b:custAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
    <xsl:template name="boAccount">
        <boAccount>
            <infra:code>
                <xsl:if test="../../b:tapSleevePtf != ''">
                    <xsl:choose>
                           <xsl:when test="../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory">
                               <xsl:value-of select="substring(../b:custAccNo,1,8)"/>
                           </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="../b:custAccNo"/>
                            </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>               
            </infra:code>
        </boAccount>
    </xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:param name="ccyAccXRate"/>
		<account1CcyTradeCcyExchangeRate>
		<xsl:choose>
			<xsl:when test="number(../b:cuAmountDue)='0' or number(../b:cuNetAmTrd)='0'">
				<xsl:value-of select="''"/>
			</xsl:when>
			<xsl:otherwise>
      			<xsl:value-of select="$ccyAccXRate"/>
			</xsl:otherwise>
		</xsl:choose>
    	</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount">
	<xsl:param name="acc1Amount"/>
	<xsl:choose>
		<xsl:when test="(../../b:FeeChgCumulative = '' or not(../../b:FeeChgCumulative)) and $PEWorkflowhandling ='YES' and starts-with(../../b:linkReference,'PECT')">
		<xsl:choose>
			<xsl:when test="../b:cuStampTax != 0">
				<account1NetAmount>
					<xsl:value-of select="../../b:cuChargeTaxTypePctGroup/b:CustAmountDue + ../b:cuStampTax"/>
				</account1NetAmount>
			</xsl:when>
			<xsl:otherwise>
				<account1NetAmount>
					<xsl:value-of select="../../b:cuChargeTaxTypePctGroup/b:CustAmountDue"/>
				</account1NetAmount>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
		<xsl:choose>
			<xsl:when test="../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory">
				<account1NetAmount>
					<xsl:value-of select="format-number(round(../b:cuGrossAmTrd * (../b:cuAmountDue div ../b:cuNetAmTrd) * 100) div 100, $decimalformat, 'nan2zero')"/>
				</account1NetAmount>
			</xsl:when>
			<xsl:otherwise>
				<account1NetAmount>
					<xsl:value-of select="$acc1Amount"/>
				</account1NetAmount>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="account2">
		<xsl:param name="ccyAccXRate"/>
		<xsl:param name="acc2Amount"/>
		<xsl:if test="../b:cuIncomeAcc != '' and not(../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory)">
			<account2>
				<infra:code>
					<xsl:value-of select="../b:cuIncomeAcc"/>
				</infra:code>
			</account2>
			<account2CcyTradeCcyExchangeRate>
				<xsl:value-of select="$ccyAccXRate"/>
			</account2CcyTradeCcyExchangeRate>
			<xsl:if test="../b:cuIncomeAmt != ''">
				<account2NetAmount>
					<xsl:value-of select="$acc2Amount"/>
				</account2NetAmount>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="commonReference">
		<xsl:choose>
			<xsl:when test="../../b:syDxReference != ''">
				<commonReference>
					<xsl:value-of select="../../b:syDxReference"/>
				</commonReference>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../../b:comOrderRef !=''">
					<commonReference>
						<xsl:value-of select="../../b:comOrderRef"/>
					</commonReference>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="notepad">
		<notepad>
			<infra:date>
				<xsl:value-of select="../../b:tradeDate"/>
			</infra:date>
			<infra:note>
				<xsl:for-each select="../b:custNoNomSubGroup/b:custNoNom">
					<xsl:value-of select="concat(.,' at ',../b:custPrice,'\n')"/>
				</xsl:for-each>
			</infra:note>
			<infra:title>
				<xsl:value-of select="'TRADE PRICE DETAILS'"/>
			</infra:title>
			<infra:type>
				<infra:code>
					<xsl:value-of select="'COMMENT'"/>
				</infra:code>
			</infra:type>
		</notepad>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:tapSleevePtf != ''">
						<xsl:value-of select="../../b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="boPortfolio">
    <boPortfolio>
      <infra:code>
	  	<xsl:if test="../../b:tapSleevePtf != ''">
			<xsl:value-of select="."/>
		</xsl:if>
      </infra:code>
    </boPortfolio>
  </xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:for-each select="../b:cuNarrativeList/b:cuNarrative">
				<xsl:value-of select="concat(.,' ')"/>
			</xsl:for-each>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../../b:id1"/>
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
		<xsl:if test="substring(../../b:linkReference,1,5) = 'DXTRA' and ../../b:customerNoGroup/b:custTransCode != '' and ../../b:closeoutTypeGroup/b:closeoutTypeSubGroup/b:closeoutType != '' and ../../b:linkOptionType != ''">
			<subType>
				<infra:code>
					<xsl:value-of select="concat('SC_',substring(../../b:customerNoGroup/b:custTransCode,1,3),'_',substring(../../b:closeoutTypeGroup/b:closeoutTypeSubGroup/b:closeoutType,1,3),'_',../../b:linkOptionType)"/>
				</infra:code>
			</subType>
		</xsl:if>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="starts-with(../../b:tapRefId,'X')">
					<xsl:value-of select="../../b:tapRefId"/>
				</xsl:when>
				<xsl:when test="substring(../../b:tapRefId,string-length(../../b:tapRefId)-3) = '-RHT'">
					<xsl:value-of select="substring-before(../../b:tapRefId,'-RHT')"/>
				</xsl:when>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id1,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
	      			<xsl:value-of select="concat(../../b:id1,'_',../b:customerNo,'_',.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printTradeFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionSecuritySell'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',../b:custTransCode)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="accruedInterests">
		<xsl:param name="intrAmount"/>
		<accruedInterests>
			<xsl:value-of select="$intrAmount"/>
		</accruedInterests>
	</xsl:template>
	<xsl:template name="depositaryAccount">
	<xsl:variable name="index" select="../@index"/>
	<xsl:choose>
		<xsl:when test="../../b:depository != '' and ../../b:depository">
  	<xsl:choose>
  		<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=$index]=$subAccountNature and ../../b:subAccountTypeList/b:subAccountType[@index=$index]">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="concat(../../b:depository,'_',../b:subAccount)"/>
					</infra:code>
				</depositaryAccount>
		</xsl:when>
		<xsl:otherwise>
			<depositaryAccount>
				<infra:code>
					<xsl:value-of select="../../b:depository"/>
				</infra:code>
			</depositaryAccount>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:when>
	</xsl:choose>
	</xsl:template>
	<xsl:template name="executionSetCriteria">
		<xsl:if test="not(substring(../../b:tapRefId,string-length(../../b:tapRefId)-3) = '-RHT')">
		<xsl:if test="../../b:tapRefId != '' and ../../b:tapRefId and not(starts-with(../../b:tapRefId,'X'))">
              <executionSetCriteria>
                   <xsl:choose>
                       <xsl:when test="starts-with(../../b:tapRefId, 'I') ">
                           <xsl:choose>
                                <xsl:when test="../../b:cuOrderNosExecNominalBalanceList/b:cuOrderNosExecNominalBalance and
                                          ../../b:cuOrderNosExecNominalBalanceList/b:cuOrderNosExecNominalBalance > 0 and
                                          not(../../b:cuOrderNosExecCancelRemainOrdList/b:cuOrderNosExecCancelRemainOrd = 'YES')">
                                       <xsl:value-of select="concat(../../b:tapRefId,'/',../../b:cuOrderNosExecCurrNoList/b:cuOrderNosExecCurrNo)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                       <xsl:value-of select="concat(../../b:tapRefId,'/F')"/>
                                </xsl:otherwise>
                            </xsl:choose>                          
                       </xsl:when>
                       <xsl:otherwise>
                            <xsl:value-of select="../../b:tapExSetCrit"/>
                       </xsl:otherwise>
                   </xsl:choose>
              </executionSetCriteria>
		</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="originalOrderCode">
		<xsl:if test="../../b:tapRefId != '' and ../../b:tapRefId">
			<originalOrderCode>
				<xsl:choose>
					<xsl:when test="contains(../../b:tapRefId,'/')">
						<xsl:value-of select="substring-before(../../b:tapRefId,'/')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../b:tapRefId"/>
					</xsl:otherwise>
				</xsl:choose>
			</originalOrderCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="paymentOptionE">
		<paymentOptionE>
			<xsl:choose>
				<xsl:when test="../../b:investOptionType = 'CASH'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="../../b:investOptionType = 'REINVEST'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentOptionE>
	</xsl:template>
	<xsl:template name="price">
		<price>
            <xsl:value-of select="../b:custNoNomSubGroup/b:custPrice"></xsl:value-of>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="../b:custTotNom"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:securityCode"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
		<xsl:param name="ccyAccXRate"/>
		<xsl:param name="ccyInstrXRate"/>
		<securityCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="number(../../b:grBkCostRefCcyJoin)='0' or number(../b:cuGrossAmSec)='0'">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:when test="../../b:securityCurrency = ../../b:tradeCcy and ../b:cuAccountCcy = ../b:cuRefCcy">
					<xsl:value-of select="$ccyAccXRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ccyInstrXRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</securityCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:if test="../../b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,../../b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount">
		<tradeCcyGrossAmount>
			<xsl:value-of select="../b:cuGrossAmTrd"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount">
	<xsl:choose>
		<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../b:linkReference,'PECT')">
		<xsl:choose>
			<xsl:when test="../b:cuStampTax != 0">
				<tradeCcyNetAmount>
					<xsl:value-of select="../../b:cuChargeTaxTypePctGroup/b:CustAmountDue + ../b:cuStampTax"/>
				</tradeCcyNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<tradeCcyNetAmount>
					<xsl:value-of select="../../b:cuChargeTaxTypePctGroup/b:CustAmountDue"/>
				</tradeCcyNetAmount>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
		<xsl:choose>
			<xsl:when test="../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory">
				<tradeCcyNetAmount>
					<xsl:value-of select="../b:cuGrossAmTrd"/>
				</tradeCcyNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<tradeCcyNetAmount>
					<xsl:value-of select="../b:cuNetAmTrd"/>
				</tradeCcyNetAmount>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate">
		<xsl:param name="ccyAccXRate"/>
		<xsl:param name="ccyOpXRate"/>
		<tradeCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="number(../../b:grBkCostRefCcyJoin)='0' or number(../b:cuGrossAmTrd)='0'">
					<xsl:value-of select="''"/>
				</xsl:when>
				<xsl:when test="../b:cuAccountCcy = ../b:cuRefCcy">
					<xsl:value-of select="$ccyAccXRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ccyOpXRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="contactMethod">
		<contactMethod>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:txnChannel = 'ELECTRONIC'">
						<xsl:value-of select="'PCK_GL_FAX'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'ONLINE'">
						<xsl:value-of select="'PCK_GL_INTERNET'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'RM'">
						<xsl:value-of select="'PCK_GL_MEETING'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'TELEPHONE'">
						<xsl:value-of select="'PCK_GL_PHONE'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</contactMethod>
	</xsl:template>
<xsl:template name="paymentDate">
		<paymentDate>
			<xsl:choose>
			<xsl:when test="((../../b:cashHoldSettle = 'YES' or ../../b:secHoldSettle = 'YES') and (translate(../../b:valueDate,'-','') &lt;= translate(../../b:eventCommon/ns0:today,'-','')) and ../../b:autoBrokSettGroup/b:autoBrokSett = 'YES' and ../../b:customerNoGroup/b:autoCustSett = 'YES')">
					<xsl:value-of select="../../b:valueDate"/>
				</xsl:when>
				<xsl:when test="../../b:cashHoldSettle = 'YES'"/>
				<xsl:otherwise>
					<xsl:value-of select="../../b:valueDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentDate>
	</xsl:template>
	<xsl:template name="paymentStatus">
		<paymentStatus>
			<xsl:choose>
			<xsl:when test="((../../b:cashHoldSettle = 'YES' or ../../b:secHoldSettle = 'YES') and (translate(../../b:valueDate,'-','') &lt;= translate(../../b:eventCommon/ns0:today,'-','')) and ../../b:autoBrokSettGroup/b:autoBrokSett = 'YES' and ../../b:customerNoGroup/b:autoCustSett = 'YES')">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="../../b:cashHoldSettle = 'YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</paymentStatus>
	</xsl:template>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:choose>
			<xsl:when test="((../../b:cashHoldSettle = 'YES' or ../../b:secHoldSettle = 'YES') and (translate(../../b:valueDate,'-','') &lt;= translate(../../b:eventCommon/ns0:today,'-','')) and ../../b:autoBrokSettGroup/b:autoBrokSett = 'YES' and ../../b:customerNoGroup/b:autoCustSett = 'YES')">
					<xsl:value-of select="../../b:valueDate"/>
				</xsl:when>
				<xsl:when test="../../b:secHoldSettle = 'YES'"/>
				<xsl:otherwise>
					<xsl:value-of select="../../b:valueDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus">
		<settlementStatus>
			<xsl:choose>
			<xsl:when test="((../../b:cashHoldSettle = 'YES' or ../../b:secHoldSettle = 'YES') and (translate(../../b:valueDate,'-','') &lt;= translate(../../b:eventCommon/ns0:today,'-','')) and ../../b:autoBrokSettGroup/b:autoBrokSett = 'YES' and ../../b:customerNoGroup/b:autoCustSett = 'YES')">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="../../b:secHoldSettle = 'YES'">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</settlementStatus>
	</xsl:template>
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
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="compoundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="positionCriteria1">
  		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
    <xsl:template name="targetNature"/>
    <xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="hierOperNature">
	  	<xsl:if test="../../b:tapHierOrder and ../../b:tapHierOrder !=''">
			<hierOperNature>
				<xsl:value-of select="../../b:tapHierOrder"/>
			</hierOperNature>
		</xsl:if>
  	</xsl:template>

	<xsl:template name="accountingDate_transferIn">
		<accountingDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio_transferIn">
		<portfolio>
			<infra:code>
				<xsl:choose>
		 			<xsl:when test="../../b:portfolioNoJoinGroup/b:portfolioNoJoinList/b:portfolioNoJoin">
						<xsl:value-of select="../../b:portfolioNoJoinGroup/b:portfolioNoJoinList/b:portfolioNoJoin"/>
					</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="../../b:samHistIdJoinList/b:samHistIdJoin"/>
			</xsl:otherwise>
         </xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="sourceSystemCode_transferIn">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id1,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_transferIn">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_transferIn">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id1,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
	      			<xsl:value-of select="concat(../../b:id1,'_',../b:customerNo,'_',.,'CORRINCPTFINV',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type_transferIn">
		<type>
			<infra:code>
				<xsl:value-of select="$SC_SEGGREG"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_transferIn">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="currentAccount_transferIn">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="../b:cuIncomeAcc"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="quantity_transferIn">
		<xsl:param name="acc2Amount"/>
		<quantity>
			<xsl:value-of select="$acc2Amount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="account1_transferIn"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_transferIn"/>
	<xsl:template name="account1NetAmount_transferIn"/>
	<xsl:template name="account2_transferIn"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_transferIn"/>
	<xsl:template name="account2NetAmount_transferIn"/>
	<xsl:template name="account3_transferIn"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_transferIn"/>
	<xsl:template name="account3NetAmount_transferIn"/>
	<xsl:template name="accountingCode_transferIn"/>
	<xsl:template name="cashPortfolio_transferIn"/>
	<xsl:template name="commonReference_transferIn"/>
	<xsl:template name="ContractNumber_transferIn"/>
	<xsl:template name="intermediary_transferIn"/>
    <xsl:template name="market_transferIn"/>
	<xsl:template name="notepad_transferIn"/>
	<xsl:template name="portfolioManager_transferIn"/>
	<xsl:template name="remark_transferIn"/>
	<xsl:template name="reversalIndicator_transferIn"/>
	<xsl:template name="reversedTransactionCode_transferIn"/>
	<xsl:template name="subType_transferIn"/>
	<xsl:template name="transactionFeesTaxesCounter_transferIn"/>
	<xsl:template name="userDefinedField_transferIn"/>
	<xsl:template name="mbFields_transferIn"/>
	<xsl:template name="transactionCcyGrossAmount_transferIn"/>
	<xsl:template name="transactionCcyNetAmount_transferIn"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate_transferIn"/>
	<xsl:template name="transactionCurrency_transferIn"/>
	<xsl:template name="transactionDate_transferIn"/>
	<xsl:template name="accountingDate_transferOut">
		<accountingDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio_transferOut">
		<portfolio>
			<infra:code>
				<xsl:value-of select="."/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="sourceSystemCode_transferOut">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id1,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_transferOut">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode_transferOut">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id1,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
	      			<xsl:value-of select="concat(../../b:id1,'_',../b:customerNo,'_',.,'CORRCAPPTFWITH',$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="type_transferOut">
		<type>
			<infra:code>
				<xsl:value-of select="$SC_SEGGREG"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_transferOut">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="currentAccount_transferOut">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="../b:cuIncomeAcc"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="quantity_transferOut">
		<xsl:param name="acc2Amount"/>
		<quantity>
			<xsl:value-of select="$acc2Amount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="account1_transferOut"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate_transferOut"/>
	<xsl:template name="account1NetAmount_transferOut"/>
	<xsl:template name="account2_transferOut"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_transferOut"/>
	<xsl:template name="account2NetAmount_transferOut"/>
	<xsl:template name="account3_transferOut"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_transferOut"/>
	<xsl:template name="account3NetAmount_transferOut"/>
	<xsl:template name="accountingCode_transferOut"/>
	<xsl:template name="cashPortfolio_transferOut"/>
	<xsl:template name="commonReference_transferOut"/>
	<xsl:template name="ContractNumber_transferOut"/>
	<xsl:template name="intermediary_transferOut"/>
    <xsl:template name="market_transferOut"/>
	<xsl:template name="notepad_transferOut"/>
	<xsl:template name="portfolioManager_transferOut"/>
	<xsl:template name="remark_transferOut"/>
	<xsl:template name="reversalIndicator_transferOut"/>
	<xsl:template name="reversedTransactionCode_transferOut"/>
	<xsl:template name="subType_transferOut"/>
	<xsl:template name="transactionFeesTaxesCounter_transferOut"/>
	<xsl:template name="userDefinedField_transferOut"/>
	<xsl:template name="mbFields_transferOut"/>
	<xsl:template name="transactionCcyGrossAmount_transferOut"/>
	<xsl:template name="transactionCcyNetAmount_transferOut"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate_transferOut"/>
	<xsl:template name="transactionCurrency_transferOut"/>
	<xsl:template name="transactionDate_transferOut"/>
	<xsl:template name="account1_switchfee">
		<account1>
			<infra:code>
				<xsl:value-of select="../b:cuIncomeAcc"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate_switchfee">
		<xsl:param name="ccyAccXRate"/>
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="$ccyAccXRate"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount_switchfee">
		<xsl:param name="acc1Amount"/>
		<xsl:if test="../b:cuIncomeAmt != ''">
			<account1NetAmount>
				<xsl:value-of select="- ../b:cuIncomeAmt"/>
			</account1NetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account2_switchfee"/>
	<xsl:template name="accountingDate_switchfee">
		<accountingDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter_switchfee">
		<xsl:call-template name="printTradeFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransactionSecuritySell_SwitchFees'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="transactionCode_switchfee">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:value-of select="concat(../../b:tapOperCode,'_',../../b:id1,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F')"/>
				</xsl:when>
				<xsl:otherwise>
	      			<xsl:value-of select="concat(../../b:id1,'_',../b:customerNo,'_',.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonic,'_F')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="commonReference_switchfee">
		<xsl:choose>
			<xsl:when test="../../b:syDxReference != ''">
				<commonReference>
					<xsl:value-of select="../../b:syDxReference"/>
				</commonReference>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../../b:comOrderRef !=''">
					<commonReference>
						<xsl:value-of select="../../b:comOrderRef"/>
					</commonReference>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="contactMethod_switchfee">
		<contactMethod>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:txnChannel = 'ELECTRONIC'">
						<xsl:value-of select="'PCK_GL_FAX'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'ONLINE'">
						<xsl:value-of select="'PCK_GL_INTERNET'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'RM'">
						<xsl:value-of select="'PCK_GL_MEETING'"/>
					</xsl:when>
					<xsl:when test="../../b:txnChannel = 'TELEPHONE'">
						<xsl:value-of select="'PCK_GL_PHONE'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</contactMethod>
	</xsl:template>
	<xsl:template name="depositaryAccount_switchfee">
		<xsl:variable name="index" select="../@index"/>
	<xsl:choose>
		<xsl:when test="../../b:depository != '' and ../../b:depository">
  	<xsl:choose>
  		<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=$index]=$subAccountNature and ../../b:subAccountTypeList/b:subAccountType[@index=$index]">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="concat(../../b:depository,'_',../b:subAccount)"/>
					</infra:code>
				</depositaryAccount>
		</xsl:when>
		<xsl:otherwise>
			<depositaryAccount>
				<infra:code>
					<xsl:value-of select="../../b:depository"/>
				</infra:code>
			</depositaryAccount>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:when>
	</xsl:choose>
	</xsl:template>
	<xsl:template name="security_switchfee">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:securityCode"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate_switchfee">
		<xsl:param name="ccyAccXRate"/>
		<xsl:param name="ccyInstrXRate"/>
		<securityCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="../../b:securityCurrency = ../../b:tradeCcy and ../b:cuAccountCcy = ../b:cuRefCcy">
					<xsl:value-of select="$ccyAccXRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ccyInstrXRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</securityCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="stockExchange_switchfee">
		<stockExchange>
			<infra:code>
				<xsl:if test="../../b:stockExchange != ''">
					<xsl:value-of select="concat($STOCKEXCH_PREFIX,../../b:stockExchange)"/>
				</xsl:if>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="tradeCurrency_switchfee">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeDate_switchfee">
		<tradeDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate_switchfee">
		<xsl:param name="ccyAccXRate"/>
		<xsl:param name="ccyOpXRate"/>
		<tradeCcyPortfolioCcyExchangeRate>
			<xsl:choose>
				<xsl:when test="../b:cuAccountCcy = ../b:cuRefCcy">
					<xsl:value-of select="format-number($ccyAccXRate, $decimalformat, 'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ccyOpXRate"/>
				</xsl:otherwise>
			</xsl:choose>
		</tradeCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount_switchfee">
		<tradeCcyGrossAmount>
			<xsl:value-of select=" '0' "/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyNetAmount_switchfee">
		<xsl:if test="../b:cuIncomeAmt != ''">
			<tradeCcyNetAmount>
				<xsl:value-of select="- ../b:cuIncomeAmt"/>
			</tradeCcyNetAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="portfolio_switchfee">
		<portfolio>
			<infra:code>
				<xsl:value-of select="."/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity_switchfee">
		<quantity>
			<xsl:value-of select=" '0' "/>
		</quantity>
	</xsl:template>
	<xsl:template name="price_switchfee">
		<price>
			<xsl:value-of select=" '0' "/>
		</price>
	</xsl:template>
	<xsl:template name="remark_switchfee">
		<remark>
			<xsl:for-each select="../b:cuNarrativeList/b:cuNarrative">
				<xsl:value-of select="concat(.,' ')"/>
			</xsl:for-each>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode_switchfee">
		<sourceSystemCode>
			<xsl:value-of select="concat(../../b:id1,'_X')"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status_switchfee">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type_switchfee">
		<type>
			<infra:code>
				<xsl:value-of select=" 'SC_SWITCH_FEE' "/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate_switchfee">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="paymentOptionE_switchfee"/>
	<xsl:template name="notepad_switchfee"/>
	<xsl:template name="subType_switchfee"/>
	<xsl:template name="accruedInterests_switchfee"/>
	<xsl:template name="executionSetCriteria_switchfee"/>
	<xsl:template name="originalOrderCode_switchfee"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate_switchfee"/>
	<xsl:template name="account2NetAmount_switchfee"/>
	<xsl:template name="account3_switchfee"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate_switchfee"/>
	<xsl:template name="account3NetAmount_switchfee"/>
	<xsl:template name="accountingCode_switchfee"/>
	<xsl:template name="cashPortfolio_switchfee"/>
	<xsl:template name="ContractNumber_switchfee"/>
	<xsl:template name="intermediary_switchfee"/>
    <xsl:template name="market_switchfee"/>
	<xsl:template name="portfolioManager_switchfee"/>
	<xsl:template name="reversalIndicator_switchfee"/>
	<xsl:template name="reversedTransactionCode_switchfee"/>
	<xsl:template name="userDefinedField_switchfee"/>
	<xsl:template name="mbFields_switchfee"/>
	<xsl:template name="accountCurrency_switchfee"/>
	<xsl:template name="accruedInterestCounter_switchfee"/>
	<xsl:template name="broker_switchfee"/>
	<xsl:template name="compoundOrderCode_switchfee"/>
    <xsl:template name="compoundOrderMaster_switchfee"/>
    <xsl:template name="compoundOrderSlave_switchfee"/>
	<xsl:template name="exCoupon_switchfee"/>
	<xsl:template name="initiatedBy_switchfee"/>
	<xsl:template name="initiator_switchfee"/>
	<xsl:template name="limitPrice_switchfee"/>
	<xsl:template name="orderType_switchfee"/>
	<xsl:template name="orderValidityType_switchfee"/>
	<xsl:template name="positionCriteria1_switchfee"/>
	<xsl:template name="positionCriteria2_switchfee"/>
	<xsl:template name="positionCriteria3_switchfee"/>
	<xsl:template name="securityCcyNetAmount_switchfee"/>
	<xsl:template name="stopPrice_switchfee"/>
	<xsl:template name="targetAmount_switchfee"/>
    <xsl:template name="targetNature_switchfee"/>
    <xsl:template name="targetObjective_switchfee"/>
	<xsl:template name="trader_switchfee"/>
	<xsl:template name="validityDate_switchfee"/>
</xsl:stylesheet>