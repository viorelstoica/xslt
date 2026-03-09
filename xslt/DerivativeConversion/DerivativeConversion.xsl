<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/DerivativeConversion" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchDerivativeConversion" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiDerivativeConversion" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiDerivativeConversion" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiDerivativeConversion">
      <xsl:apply-templates select="c:CurrentEvent/b:DerivativeConversion"/>
   </xsl:template>
   <xsl:template match="batch:BatchDerivativeConversion">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchDerivativeConversion" name="BatchDerivativeConversion">
         <xsl:apply-templates select="b:DerivativeConversion"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiDerivativeConversion">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiDerivativeConversion" name="BatchMultiDerivativeConversion">
         <xsl:apply-templates select="c:MultiDerivativeConversion"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:DerivativeConversion">
      <TransactionPMS>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('DerivativeConversion',b:id)"/>
         </xsl:attribute>
         <xsl:apply-templates select="b:MatDateDxEntitlementJoinGroup/b:MatDateDxEntitlementJoinSubGroup[b:TradesDxEntitlementJoinGroup/b:BuySellDxEntitlementJoin='BUY']">
            <xsl:with-param name="Trade" select="'transferOut'"/>
            <xsl:with-param name="transfer" select="'transferOut'"/>
            <xsl:with-param name="BuySell" select="'BUY'"/>
            <xsl:with-param name="legNumber" select="'-1'"/>
            <xsl:with-param name="currentCaller" select="'DerCoBuyOut'"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="b:MatDateDxEntitlementJoinGroup/b:MatDateDxEntitlementJoinSubGroup[b:TradesDxEntitlementJoinGroup/b:BuySellDxEntitlementJoin='BUY']">
            <xsl:with-param name="transfer" select="'transferIn'"/>
            <xsl:with-param name="BuySell" select="'BUY'"/>
            <xsl:with-param name="legNumber" select="'-2'"/>
            <xsl:with-param name="currentCaller" select="'DerCoBuyIn'"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="b:MatDateDxEntitlementJoinGroup/b:MatDateDxEntitlementJoinSubGroup[b:TradesDxEntitlementJoinGroup/b:BuySellDxEntitlementJoin='SELL']">
            <xsl:with-param name="transfer" select="'transferIn'"/>
            <xsl:with-param name="BuySell" select="'SELL'"/>
            <xsl:with-param name="legNumber" select="'-1'"/>
            <xsl:with-param name="currentCaller" select="'DerCoSelIn'"/>
         </xsl:apply-templates>
         <xsl:apply-templates select="b:MatDateDxEntitlementJoinGroup/b:MatDateDxEntitlementJoinSubGroup[b:TradesDxEntitlementJoinGroup/b:BuySellDxEntitlementJoin='SELL']">
            <xsl:with-param name="transfer" select="'transferOut'"/>
            <xsl:with-param name="BuySell" select="'SELL'"/>
            <xsl:with-param name="legNumber" select="'-2'"/>
            <xsl:with-param name="currentCaller" select="'DerCoSelOut'"/>
         </xsl:apply-templates>
      </TransactionPMS>
   </xsl:template>
   <xsl:template match="b:MatDateDxEntitlementJoinGroup/b:MatDateDxEntitlementJoinSubGroup">
      <xsl:param name="transfer"/>
      <xsl:param name="BuySell"/>
      <xsl:param name="legNumber"/>
      <xsl:param name="CurrentCaller"/>
      <xsl:variable name="Index" select="../@index"/>
      <xsl:variable name="SubIndex" select="@index"/>
      <xsl:variable name="TradeId" select="./b:TradesDxEntitlementJoinGroup/b:TradesDxEntitlementJoin"/>
      <xsl:variable name="TradeIndex" select="//b:TradeIdDxTradeJoinGroup/b:TradeIdDxTradeJoinSubGroup[b:TradeIdDxTradeJoin=$TradeId]/@index"/>
      <xsl:variable name="Portfolio" select="../../b:PortfolioDxEntitlementJoinList/b:PortfolioDxEntitlementJoin[@index=$Index]"/>
      <xsl:variable name="PrimaryPortfolio" select="../../b:PriSecAccDxTradeJoinGroup/b:PriSecAccDxTradeJoinSubGroup/b:PriSecAccDxTradeJoinGroup/b:PriSecAccDxTradeJoin"/>
      <xsl:if test="$Portfolio = $PrimaryPortfolio">
         <DataGroup>
            <Derivative>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('DerivativeConversion.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:element name="{$transfer}">
                  <xsl:call-template name="account1"/>
                  <xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account1NetAmount"/>
                  <xsl:call-template name="account2"/>
                  <xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account2NetAmount"/>
                  <xsl:call-template name="account3"/>
                  <xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
                  <xsl:call-template name="account3NetAmount"/>
                  <xsl:call-template name="accountingCode"/>
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="ContractNumber"/>
                  <xsl:call-template name="intermediary"/>
                  <xsl:call-template name="market"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolio">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                  </xsl:call-template>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="remark"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="transactionCode">
                     <xsl:with-param name="Index" select="$Index"/>
                     <xsl:with-param name="SubIndex" select="$SubIndex"/>
                     <xsl:with-param name="legNumber" select="$legNumber"/>
                  </xsl:call-template>
                  <xsl:call-template name="transactionFeesTaxesCounter">
                     <xsl:with-param name="caller" select="$CurrentCaller"/>
                  </xsl:call-template>
                  <xsl:call-template name="type">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                     <xsl:with-param name="BuySell" select="$BuySell"/>
                  </xsl:call-template>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                  </xsl:call-template>
                  <xsl:call-template name="mbFields"/>
                  <xsl:call-template name="accountCurrency"/>
                  <xsl:call-template name="accruedInterestCounter"/>
                  <xsl:call-template name="accruedInterests"/>
                  <xsl:call-template name="depositaryAccount">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                  </xsl:call-template>
				  <xsl:call-template name="histOpExchRate"/>
				  <xsl:call-template name="histOpNetAmount"/>
				  <xsl:call-template name="histQuote"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="quantity">
                     <xsl:with-param name="BuySell" select="$BuySell"/>
                     <xsl:with-param name="transfer" select="$transfer"/>
                  </xsl:call-template>
                  <xsl:call-template name="security">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                     <xsl:with-param name="Index" select="$Index"/>
                     <xsl:with-param name="BuySell" select="$BuySell"/>
                     <xsl:with-param name="transfer" select="$transfer"/>
                  </xsl:call-template>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="transactionCcyGrossAmount"/>
                  <xsl:call-template name="transactionCcyNetAmount"/>
                  <xsl:call-template name="transactionCcyPortfolioCcyExchangeRate"/>
                  <xsl:call-template name="transactionCurrency">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                  </xsl:call-template>
                  <xsl:call-template name="transactionDate"/>
                  <xsl:call-template name="transferPrice">
                     <xsl:with-param name="BuySell" select="$BuySell"/>
                     <xsl:with-param name="transfer" select="$transfer"/>
                  </xsl:call-template>
                  <xsl:call-template name="referenceNature">
                     <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                     <xsl:with-param name="TradeId" select="$TradeId"/>
                  </xsl:call-template>
                  <xsl:call-template name="referenceTransactionCode">
					 <xsl:with-param name="TradeIndex" select="$TradeIndex"/>
                     <xsl:with-param name="TradeId" select="$TradeId"/>
                  </xsl:call-template>
               </xsl:element>
            </Derivative>
         </DataGroup>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="DerivativeCoversion" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\DerivativeConversion\DerivativeConversion.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\DerivativeConversion\DerivativeConversionGWp.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->