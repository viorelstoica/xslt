<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdStrategy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdStrategy" exclude-result-prefixes="b c ns0" version="1.0">
	<!-- START of protected area  -->
	<!-- Condition 1 
	<xsl:template match="b:CsdStrategy">
	<xsl:variable name="opStatus">
	<xsl:call-template name="operationStatus">
	<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
	<xsl:with-param name="recordStatus" select="b:recordStatus"/>
	</xsl:call-template>
	</xsl:variable>
	<xsl:apply-templates select="self::b:CsdStrategy[$opStatus = 'INPUT-AUTHORISE']" mode="filter1"/>
	</xsl:template>-->
	<xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>