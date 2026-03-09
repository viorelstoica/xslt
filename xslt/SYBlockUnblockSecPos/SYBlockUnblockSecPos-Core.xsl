<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:tradeDate"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="depositaryAccount">
      <depositaryAccount>
         <infra:code>
            <xsl:value-of select="b:secDepotList/b:secDepot[1]"/>
         </infra:code>
      </depositaryAccount>
   </xsl:template>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="lockingDate">
      <lockingDate>
         <xsl:value-of select="b:tradeDate"/>
      </lockingDate>
   </xsl:template>
   <xsl:template name="lockingTransactionCode"/>
   <xsl:template name="lockingType"/>
   <xsl:template name="lockingUnlocking">
      <lockingUnlocking>
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:choose>
            <xsl:when test="b:contractStatus = 'ACTIVE'">
               <xsl:value-of select=" '1' "/>
            </xsl:when>
            <xsl:when test="(b:contractStatus = 'UNWIND' or 'MATURED' or 'KNOCKEDOUT') or ($opStatus = 'REVERSE-AUTHORISE')">
               <xsl:value-of select=" '2' "/>
            </xsl:when>
         </xsl:choose>
      </lockingUnlocking>
   </xsl:template>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:blockNominalGroup[1]/b:blockNominal"/>
      </quantity>
   </xsl:template>
   <xsl:template name="remark"/>
   <xsl:template name="reversalIndicator"/>
   <xsl:template name="reversedTransactionCode"/>
   <xsl:template name="security">
      <security>
         <infra:code>
            <xsl:value-of select="b:securityCode"/>
         </infra:code>
      </security>
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
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCode">
      <transactionCode>
         <xsl:variable name="BlockRefSC" select="b:blockNominalGroup[1]/b:blockRefSc"/>
         <xsl:variable name="mnemonic" select="b:mnemonic"/>
         <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable>
         <xsl:choose>
            <xsl:when test="b:contractStatus = 'ACTIVE'">
               <xsl:value-of select="concat($BlockRefSC, $COMPANY_POSTFIX_SEPARATOR, $mnemonic, $COMPANY_POSTFIX_SEPARATOR, 'LOCK')"/>
            </xsl:when>
            <xsl:when test="(b:contractStatus = 'UNWIND' or 'MATURED' or 'KNOCKEDOUT') or ($opStatus = 'REVERSE-AUTHORISE')">
               <xsl:value-of select="concat($BlockRefSC, $COMPANY_POSTFIX_SEPARATOR, $mnemonic, $COMPANY_POSTFIX_SEPARATOR, 'UNLOCK')"/>
            </xsl:when>
         </xsl:choose>
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionCurrency">
      <transactionCurrency>
         <infra:code>
            <xsl:value-of select="b:contractCcy"/>
         </infra:code>
      </transactionCurrency>
   </xsl:template>
  <xsl:template name="type">
   		<xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
               <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
               <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
         </xsl:variable>
		<type>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:contractStatus = 'ACTIVE' and b:transactionTypeList/b:transactionType[1] and b:transactionTypeList/b:transactionType[1]='BLOCK'">
						<xsl:value-of select="'SC_BLOCK'"/>
					</xsl:when>
					 <xsl:when test="(b:contractStatus = 'UNWIND' or 'MATURED' or 'KNOCKEDOUT') or ($opStatus = 'REVERSE-AUTHORISE')">
						<xsl:value-of select="'SC_UNBLOCK'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</type>
	</xsl:template>
   <xsl:template name="validityDate">
   <validityDate>
      <xsl:if test="b:contractStatus = 'ACTIVE'">
         <xsl:value-of select="b:blockNominalGroup[1]/b:blockUntilSc"/>
      </xsl:if>          
   </validityDate>
   </xsl:template>
   <xsl:template name="valueDate"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="endDate"/>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
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