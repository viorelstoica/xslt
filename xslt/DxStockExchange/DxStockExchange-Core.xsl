<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DxStockExchange"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <code>
	  	<xsl:choose>
			<xsl:when test="$DXSTOCKEXCH_PREFIX and $DXSTOCKEXCH_PREFIX != ''">
				<xsl:value-of select="concat($DXSTOCKEXCH_PREFIX, b:id)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:id"/>
			</xsl:otherwise>
		</xsl:choose>
      </code>
   </xsl:template>
   <xsl:template name="shortName">
      <shortName>
         <xsl:value-of select="b:shortNameList/b:shortName"/>
      </shortName>
   </xsl:template>
   <xsl:template name="longName">
      <longName>
         <xsl:value-of select="b:descriptList/b:descript"/>
      </longName>
   </xsl:template>
   <xsl:template name="active">
      <active>1</active>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="multilingualLongName"/>
    <xsl:template name="notepad-custo"/>
   <xsl:template name="notepad"/>
	<xsl:template name="userDefinedField-custo"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="calendar"/>
   <xsl:template name="closeTime">
   	<xsl:if test="b:cutOffTime and b:cutOffTime != ''">
   		<closeTime>
			<xsl:choose>
				<xsl:when test="string-length(b:cutOffTime) = '5'">
					<xsl:value-of select="concat(b:cutOffTime,':00')"/>
				</xsl:when>
				<xsl:when test="string-length(b:cutOffTime) = '8'">
					<xsl:value-of select="b:cutOffTime"/>
				</xsl:when>
			</xsl:choose>
		</closeTime>
   	</xsl:if>
   </xsl:template>
   <xsl:template name="currency"/>
   <xsl:template name="marketVenueType"/>
   <xsl:template name="referenceIndex"/>
   <xsl:template name="residGeo"/>
   <xsl:template name="type"/>
   <xsl:template name="dayTrade">
        <dayTrade>
            <xsl:choose>
                <xsl:when test="b:dayTrade = 'YES'">1</xsl:when>
                <xsl:otherwise>
		            <xsl:choose>
		                <xsl:when test="b:dayTrade = 'NO'">2</xsl:when>
		                <xsl:otherwise>3</xsl:otherwise>
		            </xsl:choose>                
                </xsl:otherwise>
            </xsl:choose>
        </dayTrade>
   </xsl:template>
   <xsl:template name="dataSecuProf"/>
</xsl:stylesheet>
