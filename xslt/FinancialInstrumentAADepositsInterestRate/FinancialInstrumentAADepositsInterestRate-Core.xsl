<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS"
                xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow"
                xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec"
                xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec"
                xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec"
                xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="a b c d e f g h i j k l"
                version="1.0">
   <xsl:template name="setEffectiveDate"/>
   <xsl:template name="endDate"/>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="a:intRateDetails/a:effectiveRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="scheduledDate">
      <scheduledDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="substring(a:idComp3,1,8)"/>
         </xsl:call-template>
      </scheduledDate>
   </xsl:template>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="substring(a:idComp3,1,8)"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
             <xsl:choose>
		 	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
            	<xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="../c:aatxncontext/b:aaArrangementId"/>
			</xsl:otherwise>
		 </xsl:choose>
         </infra:code>
      </instrument>
   </xsl:template>
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