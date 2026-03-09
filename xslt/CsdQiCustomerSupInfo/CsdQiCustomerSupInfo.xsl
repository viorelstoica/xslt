<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
	xmlns:b="http://www.temenos.com/T24/event/TTI/CsdQiCustomerSupInfo" 

	xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCsdQiCustomerSupInfo"
	xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdQiCustomerSupInfo" 
	xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCsdQiCustomerSupInfo" 

	exclude-result-prefixes="b multibatch ns0" version="1.0">

	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>

	<xsl:template match="c:MultiCsdQiCustomerSupInfo">
		<xsl:apply-templates select="c:CurrentEvent/b:CsdQiCustomerSupInfo"/>
	</xsl:template>
	<xsl:template match="batch:BatchCsdQiCustomerSupInfo">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCsdQiCustomerSupInfo" name="BatchCsdQiCustomerSupInfo">
			<xsl:apply-templates select="b:CsdQiCustomerSupInfo"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiCsdQiCustomerSupInfo">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCsdQiCustomerSupInfo" name="BatchMultiCsdQiCustomerSupInfo">
			<xsl:apply-templates select="c:MultiCsdQiCustomerSupInfo"/>
		</xsl:element>
	</xsl:template>	

   
   <xsl:template match="b:CsdQiCustomerSupInfo">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('CsdQiCustomerSupInfo',b:id)"/>
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