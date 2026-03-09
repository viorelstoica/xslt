<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecTradeScSettlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecTradeScSettlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecTradeScSettlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecTradeScSettlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

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
					<xsl:value-of select="concat(../../b:tapOperCode, '_', ../../b:id,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicJoin)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../../b:id,'_',../b:customerNo,'_',.,$COMPANY_POSTFIX_SEPARATOR,../../b:companyMnemonicJoin)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:securityCode"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:tapSleevePtf and ../../b:tapSleevePtf != ''">
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
		<xsl:if test="../../b:tapSleevePtf and ../../b:tapSleevePtf != ''">
			<boPortfolio>
				<infra:code>
					<xsl:value-of select="."/>
				</infra:code>
			</boPortfolio>
		</xsl:if>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="../b:custTotNom"/>
		</quantity>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="paymentDate">
		<xsl:variable name="index" select="../@index"/>
		<xsl:if test="../../b:cashHoldSettle = 'YES'">
			<xsl:if test="../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand != ../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand)">
				<xsl:choose>
					<xsl:when test="number(../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) = '0'">
						<paymentDate>
							<xsl:value-of select="../../b:brNomOutstandGroup[@index = $index]/b:brAmtValDate"/>
						</paymentDate>
					</xsl:when>
					<xsl:when test="(number(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) = '0' or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand)) and number(../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) != '0'">
						<paymentDate>
							<xsl:value-of select="../../b:valueDate"/>
						</paymentDate>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="paymentStatus">
		<xsl:variable name="index" select="../@index"/>
		<xsl:if test="../../b:cashHoldSettle = 'YES'">
			<xsl:if test="../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand != ../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand)">
				<xsl:choose>
					<xsl:when test="number(../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) = '0'">
						<paymentStatus>
							<xsl:value-of select="'4'"/>
						</paymentStatus>
					</xsl:when>
					<xsl:when test="(number(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) = '0' or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand)) and number(../../b:brNomOutstandGroup[@index = $index]/b:brAmtOutstand) != '0'">
						<paymentStatus>
							<xsl:value-of select="'3'"/>
						</paymentStatus>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="settlementDate">
		<xsl:variable name="index" select="../@index"/>
		<xsl:if test="../../b:SecHoldSettle = 'YES'">
			<xsl:if test="../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand != ../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand)">
				<xsl:choose>
					<xsl:when test="number(../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) = '0'">
						<settlementDate>
							<xsl:value-of select="../../b:brNomOutstandGroup[@index = $index]/b:brNomValDate"/>
						</settlementDate>
					</xsl:when>
					<xsl:when test="(number(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) = '0' or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand)) and number(../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) != '0'">
						<settlementDate>
							<xsl:value-of select="../../b:valueDate"/>
						</settlementDate>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="settlementStatus">
		<xsl:variable name="index" select="../@index"/>
		<xsl:if test="../../b:SecHoldSettle = 'YES'">
			<xsl:if test="../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand != ../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand)">
				<xsl:choose>
					<xsl:when test="number(../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) = '0'">
						<settlementStatus>
							<xsl:value-of select="'4'"/>
						</settlementStatus>
					</xsl:when>
					<xsl:when test="(number(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) = '0' or not(../../../../c:PreviousEvent/b:SecTradeScSettlement/b:brNomOutstandGroup[@index = $index]/b:brNomOutstand)) and number(../../b:brNomOutstandGroup[@index = $index]/b:brNomOutstand) != '0'">
						<settlementStatus>
							<xsl:value-of select="'3'"/>
						</settlementStatus>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="boAccount"/>
	<xsl:template name="splitPortfolio"/>
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
	            <xsl:when test="../b:cuSubsAccount">
	                <xsl:value-of select="../b:cuSubsAccount"/>
	            </xsl:when>	
				<xsl:when test="../../b:customerNoGroup/b:custTransCode = 'UPS'">
	                <xsl:value-of select="../../b:custAccNoSecOpenOrderGroup/b:custAccNoSecOpenOrderSubGroup/b:custAccNoSecOpenOrder"/>
	            </xsl:when>		
				<xsl:otherwise>			
	        		<xsl:value-of select="../b:custAccNo"/>
				</xsl:otherwise>
			</xsl:choose>
	      </infra:code>
	    </account1>
   </xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
    <xsl:param name="ccyAccXRate"/>
    <account1CcyTradeCcyExchangeRate>
      <xsl:value-of select="$ccyAccXRate"/>
    </account1CcyTradeCcyExchangeRate>
  </xsl:template>
	<xsl:template name="account1NetAmount">
    <xsl:param name="acc1Amount"/>
	<xsl:choose>
		<xsl:when test="(../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory)">
			<account1NetAmount>
      			<xsl:value-of select="../b:cuGrossAmTrd"/>
    		</account1NetAmount>
		</xsl:when>
		<!--  IPO  -->
        <xsl:when test="../../b:securityCodeIpoStartDate != ''">
            <xsl:choose>
                <xsl:when test="../../b:scStdSecTradeChargeTime = 'ORDER'">
                    <account1NetAmount>
                        <xsl:value-of select="../b:cuGrossAmTrd"/>
                    </account1NetAmount>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="../../b:segregChargeJoinList/b:segregChargeJoin = 'YES'">
                            <account1NetAmount>
                                <xsl:value-of select="../b:cuGrossAmTrd"/>
                            </account1NetAmount>
                        </xsl:when>
                        <xsl:otherwise>
                            <account1NetAmount>
                                <xsl:value-of select="../b:cuNetAmTrd"/>
                            </account1NetAmount>
                        </xsl:otherwise>
                    </xsl:choose>   
                </xsl:otherwise>
            </xsl:choose>        
        </xsl:when>		
		<xsl:otherwise>
			<xsl:choose>
				<xsl:when test="../../b:originalSec and ../../b:originalSec != ''">
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
    <xsl:if test="../b:cuIncomeAcc != '' and not(../../b:originalSec) and not(../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory)">
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
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
    <accountingDate>
      <xsl:value-of select="../../b:tradeDate"/>
    </accountingDate>
  </xsl:template>
	<xsl:template name="cashPortfolio"/>
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
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
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
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark">
    <remark>
      <xsl:for-each select="../b:cuNarrativeList/b:cuNarrative">
        <xsl:value-of select="concat(.,' ')"/>
      </xsl:for-each>
    </remark>
  </xsl:template>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
    <sourceSystemCode>
      <xsl:value-of select="../../b:id"/>
    </sourceSystemCode>
  </xsl:template>
	<xsl:template name="subType">
    <xsl:if test="starts-with(../../b:linkReference,'DXTRA') and ../../b:customerNoGroup/b:custTransCode != '' and ../../b:closeoutTypeGroup/b:closeoutTypeSubGroup/b:closeoutType != '' and ../../b:linkOptionType != ''">
      <subType>
        <infra:code>
          <xsl:value-of select="concat('SC_',substring(../../b:customerNoGroup/b:custTransCode,1,3),'_',substring(../../b:closeoutTypeGroup/b:closeoutTypeSubGroup/b:closeoutType,1,3),'_',../../b:linkOptionType)"/>
        </infra:code>
      </subType>
    </xsl:if>
  </xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
	 <xsl:call-template name="printTradeFeesAndTaxes">
		 <xsl:with-param name="caller" select="'SecTradeBuyActualSettlement'"/>
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
	<xsl:template name="userDefinedField-custo"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterests">
    <xsl:param name="intrAmount"/>
    <accruedInterests>
      <xsl:value-of select="$intrAmount"/>
    </accruedInterests>
  </xsl:template>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="compundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
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
	<xsl:template name="depositaryAccount">
    <xsl:variable name="index" select="../@index"/>
	<xsl:choose>
  <xsl:when test="../../b:depository !='' and ../../b:depository ">
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
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria">
		<xsl:if test="not(substring(../../b:tapRefId,string-length(../../b:tapRefId)-3) = '-RHT')">
		    <xsl:if test="../../b:tapRefId != '' and ../../b:tapRefId and not(starts-with(../../b:tapRefId,'X'))">
		      <executionSetCriteria>
		           <xsl:choose>
		               <xsl:when test="starts-with(../../b:tapRefId, 'I') ">
		                   <xsl:value-of select="concat(../../b:tapRefId,'/',../../b:cuOrderNosExecCurrNoList/b:cuOrderNosExecCurrNo)"/>
		               </xsl:when>
		               <xsl:otherwise>
		                   <xsl:value-of select="../../b:tapExSetCrit"/>
		               </xsl:otherwise>
		           </xsl:choose>
		      </executionSetCriteria>
		    </xsl:if>
		</xsl:if>
  </xsl:template>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode">
    <xsl:if test="../../b:tapRefId != '' and ../../b:tapRefId">
      <originalOrderCode>
        <xsl:value-of select="../../b:tapRefId"/>
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
	<xsl:template name="price">
    <price>
        <xsl:value-of select="../b:custNoNomSubGroup/b:custPrice"></xsl:value-of>
    </price>
  </xsl:template>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
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
	<xsl:template name="stockExchange">
    <stockExchange>
      <infra:code>
        <xsl:if test="../../b:stockExchange != ''">
          <xsl:value-of select="concat($STOCKEXCH_PREFIX,../../b:stockExchange)"/>
        </xsl:if>
      </infra:code>
    </stockExchange>
  </xsl:template>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
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
		<xsl:when test="(../../b:switchSuspCatJoin = ../../b:custAccNoCategoryList/b:custAccNoCategory) or (../../b:originalSec and ../../b:originalSec != '')">
			<tradeCcyNetAmount>
      			<xsl:value-of select="../b:cuGrossAmTrd"/>
    		</tradeCcyNetAmount>
		</xsl:when>
		<!-- IPO -->
        <xsl:when test="../../b:securityCodeIpoStartDate != '' ">
            <xsl:choose>
                <xsl:when test="../../b:scStdSecTradeChargeTime = 'ORDER'">
                    <tradeCcyNetAmount>
                        <xsl:value-of select="../b:cuNetAmTrd - ../b:cuCommission"/>
                    </tradeCcyNetAmount>                        
                </xsl:when>
                <xsl:otherwise>
		            <tradeCcyNetAmount>
		                <xsl:value-of select="../b:cuNetAmTrd"/>
		            </tradeCcyNetAmount>
                </xsl:otherwise>
            </xsl:choose>          
        </xsl:when>		
		<xsl:otherwise>
			<tradeCcyNetAmount>
      			<xsl:value-of select="../b:cuNetAmTrd"/>
    		</tradeCcyNetAmount>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate">
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
	<xsl:template name="tradeDate">
    <tradeDate>
      <xsl:value-of select="../../b:tradeDate"/>
    </tradeDate>
  </xsl:template>
	<xsl:template name="validityDate"/>
	<xsl:template name="coolCancelEndDate">
  	<xsl:if test="../../b:cancelByDate and ../../b:cancelByDate!=''">
	  	<coolCancelEndDate>
			<xsl:value-of select="../../b:cancelByDate"/>
		</coolCancelEndDate>
	</xsl:if>
  </xsl:template>
	<xsl:template name="referenceNature"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="account1"></template>
			<template name="positionCriteria1"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->