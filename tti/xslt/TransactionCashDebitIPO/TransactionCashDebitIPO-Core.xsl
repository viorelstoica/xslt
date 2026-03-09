<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecOpenOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:custAccNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:dealStatus = 'CANCELLED'">
					<xsl:value-of select="concat(b:id,'_IPO_DEBIT_R')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:id,'_IPO_DEBIT')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:custAccNo"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="transactionCurrency">
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="b:tradeCcy"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
		    <xsl:choose>
		      <xsl:when test="b:eventCommon/ns0:application = 'SC.IPO.ORDER.ACCTG'"> 
                      <xsl:value-of select="b:eventCommon/ns0:today"/>	          
		      </xsl:when>
		      <xsl:otherwise>
		              <xsl:value-of select="b:orderDate"/>
		      </xsl:otherwise>
		    </xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:securityAccntGroup/b:securityAccnt"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:securityAccntGroup/b:cuSubscriptionAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:value-of select="'Debit cash for IPO payment'"/>
		</remark>
	</xsl:template>
	<xsl:template name="reversalIndicator">
		<xsl:if test="b:dealStatus = 'CANCELLED'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<xsl:if test="b:dealStatus = 'CANCELLED'">
			<reversedTransactionCode>
				<xsl:value-of select="concat(b:id,'_IPO_DEBIT')"/>
			</reversedTransactionCode>
		</xsl:if>
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
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'IPO_DEBIT'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
	   <accountingDate>
           <xsl:value-of select="b:eventCommon/ns0:today"/>            
	   </accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="valueDate">
	   <valueDate>
            <xsl:value-of select="b:valueDate"/>
	   </valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
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