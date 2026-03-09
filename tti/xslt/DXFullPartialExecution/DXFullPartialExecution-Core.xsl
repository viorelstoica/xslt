<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/F2B"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DXFullPartialExecution"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:priSecAccGroup/b:priAccount"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="depositaryAccount">
      <depositaryAccount>
         <infra:code>
            <xsl:value-of select="b:secCustNo"/>
         </infra:code>
      </depositaryAccount>
   </xsl:template>
   <xsl:template name="executionSequenceNumber">
      <executionSequenceNumber>
         <xsl:value-of select="substring-after(b:parentRef,'-')"/>
      </executionSequenceNumber>
   </xsl:template>
   <xsl:template name="executionSetCriteria">
      <executionSetCriteria>
      	<xsl:choose>
      		<xsl:when test="starts-with(b:tapRefId, 'D')">
      			<xsl:value-of select="b:tapExSetCrit"/>
      		</xsl:when>
      		<xsl:otherwise>
      			<xsl:value-of select="concat(b:brokerDate,b:brokerTime,'/',b:tapRefId)"/>
      		</xsl:otherwise>
      	</xsl:choose>
      </executionSetCriteria>
   </xsl:template>
   <xsl:template name="executionDate">
      <executionDate>
         <xsl:value-of select="concat(b:brokerDate,'T',b:brokerTime)"/>
      </executionDate>
   </xsl:template>
   <xsl:template name="broker">
		<broker>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !=''">
						<xsl:choose>
							<xsl:when test="b:executingBroker!=''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:executingBroker)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:secCustNo)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:executingBroker!=''">
								<xsl:value-of select="b:executingBroker"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:secCustNo"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</broker>
	</xsl:template>
   <xsl:template name="stockExchange">
      <stockExchange>
         <infra:code>
            <xsl:choose>
               <xsl:when test="$DXSTOCKEXCH_PREFIX !=''">
                  <xsl:value-of select="concat($DXSTOCKEXCH_PREFIX,b:exchangeCode)"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="b:exchangeCode"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </stockExchange>
   </xsl:template>
   <xsl:template name="partialFullIndicator">
      <xsl:param name="fullOrPartial"/>
      <partialFullIndicator>
         <xsl:if test="$fullOrPartial = 'full'">
            <xsl:choose>
               <xsl:when test="b:priSecAccGroup/b:priLots = '0' or b:priSecAccGroup/b:priLots = '0.0'">
                  <xsl:value-of select="'2'"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="'1'"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:if>
         <xsl:if test="$fullOrPartial = 'partial'">
            <xsl:value-of select="'2'"/>
         </xsl:if>
      </partialFullIndicator>
   </xsl:template>
   <xsl:template name="tradeDate">
      <tradeDate>
         <xsl:value-of select="b:brokerDate"/>
      </tradeDate>
   </xsl:template>
   <xsl:template name="pmsOrderReference">
      <pmsOrderReference>
         <xsl:value-of select="b:tapRefId"/>
      </pmsOrderReference>
   </xsl:template>
   <xsl:template name="security"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:priSecAccGroup/b:priSecAcc"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:secLots"/>
      </quantity>
   </xsl:template>
   <xsl:template name="price">
      <price>
         <xsl:value-of select="b:priPrice"/>
      </price>
   </xsl:template>
   <xsl:template name="tradeCurrency">
      <tradeCurrency>
         <infra:code>
            <xsl:value-of select="b:tradeCcy"/>
         </infra:code>
      </tradeCurrency>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="executionStatus">
      <executionStatus>
         <xsl:value-of select="'80'"/>
      </executionStatus>
   </xsl:template>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="notepad"/>
   <xsl:template name="omsOrderReference"/>
   <xsl:template name="orderMode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="tradeCcyGrossAmount"/>
   <xsl:template name="tradeCcyNetAmount"/>
   <xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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