<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <xsl:variable name="index" select="@index"/>
      <account1>
         <infra:code>
            <xsl:value-of select="../b:fdFidOrderDrawDownAcctList/b:fdFidOrderDrawDownAcct[@index=$index]"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="accountingDate">
      <xsl:variable name="index" select="@index"/>
      <accountingDate>
         <xsl:value-of select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="deposit">
      <xsl:variable name="index" select="@index"/>
      <deposit>
         <infra:code>
            <xsl:value-of select="concat(../b:orderNosGroup[@index=$index]/b:orderNos,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
         </infra:code>
      </deposit>
   </xsl:template>
   <xsl:template name="portfolio">
      <xsl:variable name="index" select="@index"/>
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:fdFidOrderCusPortIdList/b:fdFidOrderCusPortId[@index=$index]"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="status">
      <xsl:variable name="index" select="@index"/>
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <status>
         <xsl:choose>
            <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
               <xsl:value-of select="$FD_UNPLACED_ORDER_STATUS"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:call-template name="statusTranslation">
                  <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
               </xsl:call-template>
            </xsl:otherwise>
         </xsl:choose>
      </status>
   </xsl:template>
   <xsl:template name="transactionCode">
      <xsl:variable name="index" select="@index"/>
      <transactionCode>
         <xsl:value-of select="concat(../b:orderNosGroup[@index=$index]/b:orderNos,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <xsl:variable name="index" select="@index"/>
      	<transactionDate>
      		<xsl:choose>
      			<xsl:when test="substring(../b:orderNosGroup[@index=$index]/b:orderNos, string-length(../b:orderNosGroup[@index=$index]/b:orderNos) - string-length('-1') +1) = '-1'">
      			   <xsl:variable name="valueToMap" select="../b:fdFidOrderOrderDateList/b:fdFidOrderOrderDate[@index=$index]"/>
				   <xsl:choose>
						<xsl:when test="string-length($valueToMap) = 8">
							<xsl:call-template name="xsdate">
								<xsl:with-param name="date" select="$valueToMap"/>
				   			</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
				   			<xsl:value-of select="$valueToMap"/>
						</xsl:otherwise>
        			</xsl:choose>
      			</xsl:when>
	            <xsl:otherwise>
      			 	<xsl:variable name="valueToMap" select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
				    <xsl:choose>
						<xsl:when test="string-length($valueToMap) = 8">
							<xsl:call-template name="xsdate">
								<xsl:with-param name="date" select="$valueToMap"/>
				   			</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
				   			<xsl:value-of select="$valueToMap"/>
						</xsl:otherwise>
        			</xsl:choose>      			 	
	            </xsl:otherwise>      			
      		</xsl:choose>		
      	</transactionDate>	      
   </xsl:template>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type">
      <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="../b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="../b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
      <type>
         <infra:code>
            <xsl:choose>
               <xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
                  <xsl:value-of select="'FD_PLACEMENT_REV'"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="'FD_PLACEMENT'"/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <xsl:variable name="index" select="@index"/>
      <valueDate>
         <xsl:choose>
            <xsl:when test="string-length(../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]) = 8">
               <xsl:call-template name="xsdate">
                  <xsl:with-param name="date" select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index=$index]"/>
            </xsl:otherwise>
         </xsl:choose>
      </valueDate>
   </xsl:template>
   <xsl:template name="depositAmount">
      <xsl:variable name="index" select="@index"/>
      <depositAmount>
         <xsl:value-of select="../b:fdFidOrderAmountList/b:fdFidOrderAmount[@index=$index]"/>
      </depositAmount>
   </xsl:template>
   <xsl:template name="account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="account1NetAmount">
      <xsl:variable name="index" select="@index"/>
      <account1NetAmount>
         <xsl:value-of select="../b:fdFidOrderAmountList/b:fdFidOrderAmount[@index=$index]"/>
      </account1NetAmount>
   </xsl:template>
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
   <xsl:template name="commonReference">
        <xsl:if test="count(../b:orderNosGroup) > 1">
            <commonReference>MULTIPOOL</commonReference>
        </xsl:if>
   </xsl:template>
   <xsl:template name="accruedInterestAmount"/>
   <xsl:template name="referenceNature">
        <referenceNature>0</referenceNature>
   </xsl:template>
   <xsl:template name="depositInterestRate"/>
   <xsl:template name="expirationDate"/>
   <xsl:template name="lockNature"/>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestrate"/>
   <xsl:template name="renewalMode"/>
   <xsl:template name="renewalPeriod"/>
   <xsl:template name="renewalPeriodNumber"/>
   <xsl:template name="renewalTreatment"/>
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