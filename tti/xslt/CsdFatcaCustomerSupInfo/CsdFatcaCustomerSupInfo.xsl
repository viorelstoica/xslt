<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 

				xmlns:b="http://www.temenos.com/T24/event/TTI/CsdFatcaCustomerSupInfo" 

				xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCsdFatcaCustomerSupInfo"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdFatcaCustomerSupInfo" 
				xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCsdFatcaCustomerSupInfo" 

				exclude-result-prefixes="b multibatch ns0" version="1.0">

   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   
   
	<xsl:template match="c:MultiCsdFatcaCustomerSupInfo">
		<xsl:apply-templates select="c:CurrentEvent/b:CsdFatcaCustomerSupInfo"/>
	</xsl:template>
	<xsl:template match="batch:BatchCsdFatcaCustomerSupInfo">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCsdFatcaCustomerSupInfo" name="BatchCsdFatcaCustomerSupInfo">
			<xsl:apply-templates select="b:CsdFatcaCustomerSupInfo"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCsdFatcaCustomerSupInfo">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCsdFatcaCustomerSupInfo" name="BatchMultiCsdFatcaCustomerSupInfo">
			<xsl:apply-templates select="c:MultiCsdFatcaCustomerSupInfo"/>
		</xsl:element>
	</xsl:template>
   
   <xsl:template match="b:CsdFatcaCustomerSupInfo">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('CsdFatcaCustomerSupInfo',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <ThirdParty>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('Customer.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
			   <xsl:call-template name="code"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="active"/>
            </ThirdParty>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet>