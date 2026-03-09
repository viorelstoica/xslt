<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/COBPurgeOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCOBPurgeOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCOBPurgeOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCOBPurgeOrder" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiCOBPurgeOrder">
      <xsl:apply-templates select="c:CurrentEvent/b:COBPurgeOrder"/>
   </xsl:template>
   <xsl:template match="batch:BatchCOBPurgeOrder">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCOBPurgeOrder" name="BatchCOBPurgeOrder">
         <xsl:apply-templates select="b:COBPurgeOrder"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiCOBPurgeOrder">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCOBPurgeOrder" name="BatchMultiCOBPurgeOrder">
         <xsl:apply-templates select="c:MultiCOBPurgeOrder"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:COBPurgeOrder">
      <F2B mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('COBPurgeOrder',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('COBPurgeOrder.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <Cancellation>
                  <OrderCancellation>
                     <xsl:call-template name="buySellIndicator"/>
                     <xsl:call-template name="cashPortfolio"/>
                     <xsl:call-template name="contractNumber"/>
                     <xsl:call-template name="notepad"/>
                     <xsl:call-template name="omsOrderReference"/>
                     <xsl:call-template name="orderMode"/>
                     <xsl:call-template name="orderStatus"/>
                     <xsl:call-template name="pmsOrderReference"/>
                     <xsl:call-template name="portfolio"/>
                     <xsl:call-template name="remark"/>
                     <xsl:call-template name="security"/>
                     <xsl:call-template name="sourceSystemCode"/>
                     <xsl:call-template name="subType"/>
                     <xsl:call-template name="type"/>
                     <xsl:call-template name="userDefinedField"/>
                     <xsl:call-template name="mbFields"/>
                  </OrderCancellation>
               </Cancellation>
            </Security>
         </DataGroup>
      </F2B>
   </xsl:template>
</xsl:stylesheet>