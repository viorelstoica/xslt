<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderAdjustStatus" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOrderAdjustStatus" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderAdjustStatus" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOrderAdjustStatus" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiOrderAdjustStatus">
      <xsl:apply-templates select="c:CurrentEvent/b:OrderAdjustStatus"/>
   </xsl:template>
   <xsl:template match="batch:BatchOrderAdjustStatus">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchOrderAdjustStatus" name="BatchOrderAdjustStatus">
         <xsl:apply-templates select="b:OrderAdjustStatus"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiOrderAdjustStatus">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiOrderAdjustStatus" name="BatchMultiOrderAdjustStatus">
         <xsl:apply-templates select="c:MultiOrderAdjustStatus"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:OrderAdjustStatus">
      <F2B mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('OrderAdjustStatus',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('OrderAdjustStatus.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <OrderLifeCycle>
                  <Acknowledgment>
                     <xsl:call-template name="buySellIndicator"/>
                     <xsl:call-template name="cashPortfolio"/>
                     <xsl:call-template name="channel"/>
                     <xsl:call-template name="contractNumber"/>
                     <xsl:call-template name="limitPrice"/>
                     <xsl:call-template name="notepad"/>
                     <xsl:call-template name="omsOrderReference"/>
                     <xsl:call-template name="orderMode"/>
                     <xsl:call-template name="orderPriceType"/>
                     <xsl:call-template name="orderStatus"/>
                     <xsl:call-template name="orderType"/>
                     <xsl:call-template name="orderValidityType"/>
                     <xsl:call-template name="pmsOrderReference"/>
                     <xsl:call-template name="portfolio"/>
                     <xsl:call-template name="priceRule"/>
                     <xsl:call-template name="quantity"/>
                     <xsl:call-template name="remark"/>
                     <xsl:call-template name="security"/>
                     <xsl:call-template name="sourceSystemCode"/>
                     <xsl:call-template name="stockExchange"/>
                     <xsl:call-template name="stopPrice"/>
                     <xsl:call-template name="subType"/>
                     <xsl:call-template name="switchFrom"/>
                     <xsl:call-template name="switchTo"/>
                     <xsl:call-template name="tradeType"/>
                     <xsl:call-template name="type"/>
                     <xsl:call-template name="validityDate"/>
					 <xsl:call-template name="boRoutingBusinessEntityId"/>
                     <xsl:call-template name="userDefinedField"/>
                     <xsl:call-template name="mbFields"/>
                  </Acknowledgment>
               </OrderLifeCycle>
            </Security>
         </DataGroup>
      </F2B>
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