<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdThirdPartyInsider" exclude-result-prefixes="b ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Condition 1 
	<xsl:template match="b:CsdThirdPartyInsider">
	<xsl:variable name="opStatus">
	<xsl:call-template name="operationStatus">
	<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
	<xsl:with-param name="recordStatus" select="b:recordStatus"/>
	</xsl:call-template>
	</xsl:variable>
	<xsl:apply-templates select="self::b:CsdThirdPartyInsider[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>-->
	
	<!-- BEG - JPP20241009 - add filter to avoid empty msgout record -->
	<xsl:template match="b:CsdThirdPartyInsider">
		<xsl:apply-templates select="self::b:CsdThirdPartyInsider[b:csdInsidIsinGroup]" mode="filter-final"/>
	</xsl:template>
	<!-- END - JPP20241009 - add filter to avoid empty msgout record -->

  <xsl:template match="b:CsdThirdPartyInsider" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

	<xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>