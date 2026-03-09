<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentAADepositsInterestRateIL"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:periodicIndexGroup/b:effectiveRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="scheduledDate">
      <scheduledDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="substring(b:idComp3,1,8)"/>
         </xsl:call-template>
      </scheduledDate>
   </xsl:template>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="substring(b:idComp3,1,8)"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:choose>
		 	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
           		<xsl:value-of select="concat(substring-before(b:arrangementKey,'-'),$COMPANY_POSTFIX_SEPARATOR,b:mnenmonic)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring-before(b:arrangementKey,'-')"/>
			</xsl:otherwise>
		 </xsl:choose>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="endDate"/>
   <xsl:template name="bond"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->