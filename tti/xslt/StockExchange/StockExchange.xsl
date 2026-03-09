<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/StockExchange" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchStockExchange" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiStockExchange" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiStockExchange" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiStockExchange">
      <xsl:apply-templates select="c:CurrentEvent/b:StockExchange"/>
   </xsl:template>
   <xsl:template match="batch:BatchStockExchange">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchStockExchange" name="BatchStockExchange">
         <xsl:apply-templates select="b:StockExchange"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiStockExchange">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiStockExchange" name="BatchMultiStockExchange">
         <xsl:apply-templates select="c:MultiStockExchange"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:StockExchange">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('stockExchange',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <StockExchange>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('StockExchange.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="code"/>
               <xsl:call-template name="synonym"/>
               <xsl:call-template name="shortName"/>
               <xsl:call-template name="longName"/>
               <xsl:call-template name="multilingualLongName"/>
               <xsl:call-template name="notepad"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="calendar"/>
			   <xsl:call-template name="cashSettlementDays"/>
               <xsl:call-template name="closeTime"/>
               <xsl:call-template name="currency"/>
			   <xsl:call-template name="dataSecuProf"/>
               <xsl:call-template name="marketVenueType"/>
               <xsl:call-template name="referenceIndex"/>
               <xsl:call-template name="residGeo"/>
			   <xsl:call-template name="securitiesSettlementDays"/>
			   <xsl:call-template name="settlementDaysRule"/>
               <xsl:call-template name="type"/>
            </StockExchange>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet>