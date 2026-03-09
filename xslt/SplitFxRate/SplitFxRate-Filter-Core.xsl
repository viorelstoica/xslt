<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns="http://www.odcgroup.com/TransactionPMS" 
    xmlns:infra="http://www.odcgroup.com/InfraPMS" 
    xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
    xmlns:ns1="http://www.temenos.com/T24/SecuritiesEventsService/FxValuation" 
    xmlns:b="http://www.temenos.com/T24/event/TTI/generateFxPositions" 
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchgenerateFxPositions"
    exclude-result-prefixes="b ns0 ns1 batch" 
    version="1.0">

    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->

    <!-- BEG - Filter for Whole record -->
    <!-- Condition 1: Process all generateFxPositions records -->
    <xsl:template match="b:generateFxPositions">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
	<!-- Condition 2 --> 
    <xsl:template match="ns1:fxValuesList[ns1:oldContract='YES']" />
    <!-- Condition 3 -->
    <xsl:template match="b:generateFxPositions">
        <xsl:apply-templates select="self::b:generateFxPositions[$PCK_GL_FWD_TEMPLATE = '1']" mode="filter1"/>
    </xsl:template>

    <!-- Condition 4 -->
    <xsl:template match="b:generateFxPositions" mode="filter1">
        <xsl:apply-templates select="self::b:generateFxPositions[contains($Onlineval,b:eventCommon/ns0:application)]" mode="filter-custo"/>
    </xsl:template>

    <!-- Custo placeholder -->
    <xsl:template match="b:generateFxPositions" mode="filter-custo">
        <xsl:apply-templates select="self::b:generateFxPositions" mode="filter-final"/>
    </xsl:template>

    <!-- Copy block -->
    <xsl:template match="b:generateFxPositions" mode="filter-final">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

  

</xsl:stylesheet>