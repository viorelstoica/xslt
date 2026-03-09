<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FullPartialExecution"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFullPartialExecution" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFullPartialExecution" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFullPartialExecution" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:tapSleevePtf != ''">
						<xsl:value-of select="../../b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:when test="../../b:transactionCode = 'UPS'">
						<xsl:value-of select="../../b:secOpenOrderNoNominalGroup/b:CustAccNoSecOpenOrder"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../b:securityAcctGroup/b:custAccNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<account1CcyTradeCcyExchangeRate>
			<xsl:value-of select="../../b:securityAcctGroup/b:cuExRateAcc"/>
		</account1CcyTradeCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="broker">
		<broker>
			<infra:code>
				<xsl:value-of select="concat($CUSTOMER_PREFIX,.)"/>
			</infra:code>
		</broker>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="depositaryAccount">
	<xsl:variable name="index" select="../@index"/>
	<xsl:choose>
		<xsl:when test="../../b:depository !='' and ../../b:depository ">
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=$index]=$subAccountNature and ../../b:subAccountTypeList/b:subAccountType[@index=$index]">
					<depositaryAccount>
						<infra:code>
							<xsl:value-of select="concat(../../b:depository,'_',../../b:securityAcctGroup/b:subAccount)"/>
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
	<xsl:template name="executionSequenceNumber">
		<executionSequenceNumber>
			<xsl:value-of select="($SC_EXEC_MULTIPLIER * (../../b:currNo - 1)) + ../@index"/>
		</executionSequenceNumber>
	</xsl:template>
	<xsl:template name="executionDate">
		<executionDate>
			<xsl:value-of select="concat(substring-before(../b:utcDateTime,':'),':',substring-before(substring-after(../b:utcDateTime,':'),':'),':',substring-before(substring-after(substring-after(../b:utcDateTime,':'),':'),':'),'.')"/>
			<xsl:value-of select="substring-after(substring-after(substring-after(../b:utcDateTime,':'),':'),':')"/>
		</executionDate>
	</xsl:template>
	<xsl:template name="executionSetCriteria">
		<xsl:variable name="index" select="../@index"/>
		<executionSetCriteria>
             <xsl:choose>
                <xsl:when test="starts-with(../../b:TapRefSecOpenOrderJoin,'D')"> 
                    <xsl:value-of select="../../b:tapExSetCritList/b:tapExSetCrit[@index = $index]"/>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:choose>
                        <xsl:when test="../../b:cancelRemainOrd and ../../b:cancelRemainOrd = 'YES' or ../../b:nominalBalance = 0"> 
                            <xsl:value-of select="concat(../../b:TapRefSecOpenOrderJoin,'/F')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(../../b:TapRefSecOpenOrderJoin,'/',../../b:currNo)"/>
                        </xsl:otherwise>
                     </xsl:choose> 
                </xsl:otherwise>
             </xsl:choose> 		
		</executionSetCriteria>
	</xsl:template>
	<xsl:template name="executionStatus">
        <xsl:choose>
            <xsl:when test="../../b:nominalBalance = '0' or ../../b:cancelRemainOrd = 'YES'">
                <executionStatus>80</executionStatus>
            </xsl:when>
            <xsl:otherwise>
                <executionStatus>75</executionStatus>
            </xsl:otherwise>
         </xsl:choose>
	</xsl:template>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="notepad"/>
	<xsl:template name="omsOrderReference"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="partialFullIndicator">
		<xsl:param name="fullOrPartial"/>
		<partialFullIndicator>
            <xsl:choose>
                <xsl:when test="../../b:cancelRemainOrd = 'YES' or 
                         ($SC_CASH_ORDER_CHG_STATUS_IF_T24_EXEC = 'Y' and ../../b:orderType = 'CASH' and
                         ../../b:nominalBalance = 0)">
                     <xsl:value-of select="'0'"/>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:choose>
                      <xsl:when test="$fullOrPartial = 'full'">
                          <xsl:value-of select="'2'"/>
                       </xsl:when>
                      <xsl:when test="$fullOrPartial = 'partial'">
                          <xsl:value-of select="'1'"/>
                      </xsl:when>
                   </xsl:choose>        
                </xsl:otherwise>
            </xsl:choose>
		</partialFullIndicator>
	</xsl:template>
	<xsl:template name="pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="../../b:TapRefSecOpenOrderJoin"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:tapSleevePtf != ''">
						<xsl:value-of select="../../b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../../b:securityAcctGroup/b:securityAcct"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="price">
		<price>
			<xsl:value-of select="../b:price"/>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:choose>
				<xsl:when test="../../b:secOpenOrderUpfrontSec">
					<xsl:value-of select="../../b:secOpenOrderNoNominalGroup/b:secOpenOrderNoNominal"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:nominalRecd"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:value-of select="concat($STOCKEXCH_PREFIX,../../b:stockExchange)"/>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="../../b:tradeCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="../../b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="valueDate">
		<xsl:if test="../../b:valueDate and ../../b:valueDate != ''">
			<valueDate>
				<xsl:value-of select="../../b:valueDate"/>
			</valueDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="boAccount">
		<boAccount>
			<infra:code>
				<xsl:if test="../../b:tapSleevePtf != ''">
					<xsl:value-of select="../../b:securityAcctGroup/b:custAccNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="../../b:tapSleevePtf != ''">
					<xsl:value-of select="../../b:securityAcctGroup/b:securityAcct"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="ack_buySellIndicator"/>
	<xsl:template name="ack_cashPortfolio"/>
	<xsl:template name="ack_channel"/>
	<xsl:template name="ack_contractNumber"/>
	<xsl:template name="ack_limitPrice"/>
	<xsl:template name="ack_notepad"/>
	<xsl:template name="ack_omsOrderReference"/>
	<xsl:template name="ack_orderMode"/>
	<xsl:template name="ack_orderPriceType"/>
	<xsl:template name="ack_orderStatus">
        <orderStatus>
            <xsl:choose>
                <xsl:when test="b:orderStatus = 'REJECTED'">
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'REJECTED'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="b:cancelRemainOrd = 'YES' or 
                                     ($SC_CASH_ORDER_CHG_STATUS_IF_T24_EXEC = 'Y' and b:orderType = 'CASH' and
                                     b:nominalBalance = 0)">
                            <xsl:call-template name="statusTranslation">
                                <xsl:with-param name="boStatus" select="$SC_CANCEL_REMAIN_ORD_STATUS"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                                <xsl:call-template name="statusTranslation">
                                    <xsl:with-param name="boStatus" select="$IPO_ZERO_ALOTMENT_ORDER_STATUS"/>
                                </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </orderStatus>
	</xsl:template>
	<xsl:template name="ack_orderType"/>
	<xsl:template name="ack_orderValidityType"/>
	<xsl:template name="ack_pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="b:TapRefSecOpenOrderJoin"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="ack_portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAcctGroup/b:securityAcct"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="ack_priceRule"/>
	<xsl:template name="ack_quantity"/>
	<xsl:template name="ack_remark"/>
	<xsl:template name="ack_security"/>
	<xsl:template name="ack_sourceSystemCode"/>
	<xsl:template name="ack_stockExchange"/>
	<xsl:template name="ack_stopPrice"/>
	<xsl:template name="ack_subType"/>
	<xsl:template name="ack_switchFrom"/>
	<xsl:template name="ack_switchTo"/>
	<xsl:template name="ack_tradeType"/>
	<xsl:template name="ack_type"/>
	<xsl:template name="ack_validityDate"/>
	<xsl:template name="ack_userDefinedField"/>
	<xsl:template name="ack_mbFields"/>
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