<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFinancialInstrumentSecurity">
      <xsl:apply-templates select="c:CurrentEvent/b:FinancialInstrumentSecurity"/>
   </xsl:template>
   <xsl:template match="batch:BatchFinancialInstrumentSecurity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" name="BatchFinancialInstrumentSecurity">
         <xsl:apply-templates select="b:FinancialInstrumentSecurity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFinancialInstrumentSecurity">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" name="BatchMultiFinancialInstrumentSecurity">
         <xsl:apply-templates select="c:MultiFinancialInstrumentSecurity"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FinancialInstrumentSecurity">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinancialInstrumentCommodity-PartialD',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Commodity>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('FinancialInstrumentCommodity-PartialD.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="infra:code"/>
               <xsl:call-template name="active"/>
               <xsl:call-template name="partialAttributes"/>
            </Commodity>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet>
