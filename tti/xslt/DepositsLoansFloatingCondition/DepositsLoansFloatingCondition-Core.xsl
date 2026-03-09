<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/DepositsLoansFloatingCondition"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="benchmark">
      <benchmark>
         <infra:code>
            <xsl:value-of select="concat(b:periodicIndexGroup/b:periodicIndex,b:currency,b:periodicIndexGroup/b:periodicPeriod)"/>
         </infra:code>
      </benchmark>
   </xsl:template>
   <xsl:template name="spreadRate">
      <spreadRate>
         <xsl:choose>
            <xsl:when test="b:periodicIndexGroup/b:marginOperSubGroup/b:marginOper = 'ADD'">
               <xsl:value-of select="b:periodicIndexGroup/b:marginOperSubGroup/b:marginRate"/>
            </xsl:when>
            <xsl:when test="b:periodicIndexGroup/b:marginOperSubGroup/b:marginOper = 'SUB'">
               <xsl:value-of select="- b:periodicIndexGroup/b:marginOperSubGroup/b:marginRate"/>
            </xsl:when>
         </xsl:choose>
      </spreadRate>
   </xsl:template>
   <xsl:template name="scheduledDate">
      <scheduledDate>
         <xsl:value-of select="b:aaArrangementJoinStartDate"/>
      </scheduledDate>
   </xsl:template>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:value-of select="b:aaArrangementJoinStartDate"/>
      </validityDate>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:choose>
			 	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
	            	<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					 <xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="endDate"/>
   <xsl:template name="firstBenchmarkDate"/>
   <xsl:template name="firstResetDate"/>
   <xsl:template name="interestRate"/>
   <xsl:template name="maximumRate"/>
   <xsl:template name="minimumRate"/>
   <xsl:template name="resetFrequencyNumber"/>
   <xsl:template name="resetFrequencyUnit"/>
   <xsl:template name="mbFields"/>
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