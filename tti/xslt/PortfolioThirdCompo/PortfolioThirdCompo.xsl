<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioThirdCompo" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolioThirdCompo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioThirdCompo" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioThirdCompo" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiPortfolioThirdCompo">
      <xsl:apply-templates select="c:CurrentEvent/b:PortfolioThirdCompo"/>
   </xsl:template>
   <xsl:template match="batch:BatchPortfolioThirdCompo">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentStock" name="BatchPortfolioThirdCompo">
         <xsl:apply-templates select="b:PortfolioThirdCompo"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiPortfolioThirdCompo">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioThirdCompo" name="BatchMultiPortfolioThirdCompo">
         <xsl:apply-templates select="c:MultiPortfolioThirdCompo"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:PortfolioThirdCompo">
      <ClientPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('PortfolioThirdCompo',b:id)"/>
         </xsl:attribute>
            <xsl:apply-templates select="b:portfolioIdList/b:portfolioId"/>
      </ClientPMS>
   </xsl:template>
   <xsl:template match="b:portfolioIdList/b:portfolioId">
   <DataGroup>
      <Portfolio>
         <xsl:attribute name="description">
            <xsl:value-of select="concat('PortfolioThirdCompo.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
         </xsl:attribute>
         <xsl:attribute name="sequenceNumber">
            <xsl:call-template name="calcSeqNum">
               <xsl:with-param name="creationTime">
                  <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:attribute>
         <xsl:call-template name="infra:code"/>
         <xsl:call-template name="infra:synonym"/>
         <xsl:call-template name="infra:shortName"/>
         <xsl:call-template name="infra:longName"/>
         <xsl:call-template name="infra:multilingualLongName"/>
         <xsl:call-template name="infra:notepad"/>
         <xsl:call-template name="infra:userDefinedField"/>
         <xsl:call-template name="infra:mbFields"/>
         <xsl:call-template name="active"/>
         <xsl:call-template name="businessEntityComposition"/>
		 <xsl:call-template name="cashBookingModel"/>
         <xsl:call-template name="client"/>
		 <xsl:call-template name="creditStatus"/>
         <xsl:call-template name="mainBusinessEntity"/>
         <xsl:call-template name="managementBeginDate"/>
         <xsl:call-template name="managementEndDate"/>
         <xsl:call-template name="managementType"/>
		 <xsl:call-template name="marginLending"/>
         <xsl:call-template name="nature"/>
         <xsl:call-template name="ownership"/>
         <xsl:call-template name="parentChildIndicator"/>
         <xsl:call-template name="parentPortfolio"/>
         <xsl:call-template name="paymentInstruction"/>
         <xsl:call-template name="performanceCurrency"/>
         <xsl:call-template name="performanceDataStorageFrequency"/>
         <xsl:call-template name="performanceDataStorageUnit"/>
         <xsl:call-template name="performanceDetailLevel"/>
         <xsl:call-template name="portfolioManager"/>
         <xsl:call-template name="portfolioGroup"/>
         <xsl:call-template name="portfolioType"/>
         <xsl:call-template name="positionManagementDate"/>
         <xsl:call-template name="positionManagementLevel"/>
         <xsl:call-template name="positionManagementRule"/>
         <xsl:call-template name="relationshipManager"/>
         <xsl:call-template name="reportingLanguage"/>
		 <xsl:call-template name="sharia"/>
         <xsl:call-template name="status"/>
      </Portfolio>
	 </DataGroup>
   </xsl:template>
</xsl:stylesheet>