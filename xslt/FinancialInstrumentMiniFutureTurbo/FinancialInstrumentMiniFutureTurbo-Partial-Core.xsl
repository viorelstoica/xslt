<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/StructuredProducts" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">

   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="b:id"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="partialAttributes">
		<xsl:call-template name="riskLevel"/>
	</xsl:template>

   <xsl:template name="riskLevel">
		<xsl:param name="pcc" select="../../@partialCoCode"/>
		<riskLevel>
			<xsl:value-of select="b:compLevelAttribGroup[b:compLevelAttrib = $pcc]/b:riskLevel"/> 
      </riskLevel>
   </xsl:template>
</xsl:stylesheet>
