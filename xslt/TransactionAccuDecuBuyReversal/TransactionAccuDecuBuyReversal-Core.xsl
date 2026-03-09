<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
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
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
            <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                       <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,'_BUY')"/>
                </xsl:otherwise>
            </xsl:choose>			     
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
             <xsl:choose>
                 <xsl:when test="b:tapRefId">
                     <xsl:value-of select="concat(b:tapRefId,$COMPANY_POSTFIX_SEPARATOR,'R')"/>
                 </xsl:when>
                 <xsl:otherwise>
                     <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'R')"/>
                 </xsl:otherwise>
             </xsl:choose>   		
		</transactionCode>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="'1'"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
	             <xsl:choose>
	                 <xsl:when test="b:tapRefId">
	                     <xsl:value-of select="b:tapRefId"/>
	                 </xsl:when>
	                 <xsl:otherwise>
                        <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
	                 </xsl:otherwise>
	             </xsl:choose>   			
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:value-of select=" '0' "/>
		</referenceNature>
	</xsl:template>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
	<valueDate>
      <xsl:value-of select="b:valueDate"/>
    </valueDate>
   </xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="commonReference">
		<commonReference>
			<xsl:value-of select="b:syDxReference"/>
		</commonReference>
	</xsl:template>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="compundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="depositaryAccount"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="price"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="tradeCurrency"/>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
   </xsl:template>
	<xsl:template name="validityDate"/>
	<xsl:template name="coolCancelEndDate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="portfolio">
				<block path="portfolio/infra:code/xsl:value-of" x="535" y="396"/>
			</template>
			<template name="status">
				<block path="status/xsl:call-template" x="535" y="224"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->