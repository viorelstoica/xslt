<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/F2B" xmlns:b="http://www.temenos.com/T24/event/TTI/COBPurgeOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCOBPurgeOrder" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCOBPurgeOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCOBPurgeOrder" exclude-result-prefixes="b c batch multibatch" version="1.0">
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:COBPurgeOrder">
    <xsl:apply-templates select="self::b:COBPurgeOrder[not(b:securityNoIpoStartDate)]" mode="filter-custo"/>
  </xsl:template>
  <!-- Custo placeholder -->
  <xsl:template match="b:COBPurgeOrder" mode="filter-custo">
    <xsl:apply-templates select="self::b:COBPurgeOrder" mode="filter-final"/>
  </xsl:template>
  <!-- Copy block -->
  <xsl:template match="b:COBPurgeOrder" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
      
</xsl:stylesheet>