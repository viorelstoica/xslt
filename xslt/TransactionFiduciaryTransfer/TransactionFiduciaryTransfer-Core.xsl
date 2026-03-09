<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrder" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b c ns0" version="1.0">
   <xsl:template name="account1"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="accountingDate">
   <xsl:if test="b:transferEffDate != ''">
      <accountingDate>
         <xsl:choose>
            <xsl:when test="string-length(b:transferEffDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:transferEffDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:transferEffDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </accountingDate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="deposit">
		<deposit>
			<infra:code>
				<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
			</infra:code>
		</deposit>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
		 <xsl:choose>
		 	<xsl:when test="b:eventCommon/ns0:today != b:transferEffDate">
            	<xsl:value-of select="b:cusPortId"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="../../c:PreviousEvent/b:FdFidOrder/b:cusPortId"/>
			</xsl:otherwise>
		</xsl:choose>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="status">
	  <status>
	  	<xsl:choose>
			<xsl:when test="(((b:transferToPort = '' or not(b:transferToPort)) and ../../c:PreviousEvent/b:FdFidOrder/b:transferToPort != '') and (b:eventCommon/ns0:today != ../../c:PreviousEvent/b:FdFidOrder/b:transferEffDate))">
				<xsl:value-of select="$FD_CANC_STATUS"/>
			</xsl:when>
            <xsl:when test="b:eventCommon/ns0:today = ../../c:PreviousEvent/b:FdFidOrder/b:transferEffDate">
         		<xsl:call-template name="statusTranslation">
            		<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         		</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$FD_POOLED_ORDER_STATUS"/>
			</xsl:otherwise>
		</xsl:choose>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <transactionCode>
         <xsl:choose>
		 	<xsl:when test="b:tapFdTransfer != ''">
				<xsl:value-of select="translate(b:tapFdTransfer, '%', '_')"/>
			</xsl:when>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,'_TRNSF','_R')"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,'_TRNSF')"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
   <xsl:if test="b:transferEffDate != ''">
      <transactionDate>
         <xsl:choose>
            <xsl:when test="string-length(b:transferEffDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:transferEffDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:transferEffDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </transactionDate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
	  <xsl:if test="b:tapFdTransfer = ''">
      <type>
         <infra:code>
               <xsl:value-of select="'FD_TRNSF'"/>
         </infra:code>
      </type>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="valueDate">
  	<xsl:if test="b:transferEffDate != ''">
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(b:transferEffDate) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="b:transferEffDate"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:transferEffDate"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
	  </xsl:if>
   </xsl:template>
   <xsl:template name="account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="account2"/>
   <xsl:template name="account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="counterparty"/>
   <xsl:template name="depositCurrency"/>
   <xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
   <xsl:template name="fusionRule"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="initiator"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="referenceTransactionCode"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="account"/>
   <xsl:template name="adjustedPortfolio">
	<xsl:if test="b:eventCommon/ns0:today != b:transferEffDate">
   		<adjustedPortfolio>
			<infra:code>
				<xsl:value-of select="concat(b:customer,'-',b:transferToPort)"/>
			</infra:code>
		</adjustedPortfolio>
	</xsl:if>
   </xsl:template>
   <xsl:template name="operationCurrency">
   	<operationCurrency>
		<infra:code>
			<xsl:value-of select="b:currencyCode"/>
		</infra:code>
	</operationCurrency>
   </xsl:template>
   <xsl:template name="operationDate"/>
   <xsl:template name="operationNature">
		<operationNature>
			<xsl:value-of select="'13'"/>
		</operationNature>
   </xsl:template>
   <xsl:template name="portfolioCurrency"/>
   <xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:amount"/>
		</quantity>
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