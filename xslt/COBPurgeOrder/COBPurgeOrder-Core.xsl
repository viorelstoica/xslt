<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/F2B"
                xmlns:b="http://www.temenos.com/T24/event/TTI/COBPurgeOrder"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="buySellIndicator"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="omsOrderReference"/>
   <xsl:template name="orderMode"/>
   <xsl:template name="orderStatus">
      <orderStatus>5</orderStatus>
   </xsl:template>
   <xsl:template name="pmsOrderReference">
      <pmsOrderReference>
         <xsl:value-of select="b:tapRefId"/>
      </pmsOrderReference>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:securityAccntGroup/b:securityAccnt"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="remark"/>
   <xsl:template name="security"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="subType"/>
   <xsl:template name="type"/>
   <xsl:template name="userDefinedField">
      <userDefinedField>
         <infra:name>account</infra:name>
         <infra:value>
            <xsl:value-of select="b:custAccNoGroup/b:custAccNo"/>
         </infra:value>
      </userDefinedField>
   </xsl:template>
   <xsl:template name="mbFields"/>
</xsl:stylesheet>
