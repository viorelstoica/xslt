<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LdLoansAndDepositsOldNew" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLdLoansAndDepositsOldNew" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLdLoansAndDepositsOldNew" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLdLoansAndDepositsOldNew" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:choose>
            <xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate)">
               <xsl:value-of select="b:interestRateList/b:interestRate"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="b:newIntRateList/b:newIntRate"/>
            </xsl:otherwise>
         </xsl:choose>
      </interestRate>
   </xsl:template>
   <xsl:template name="scheduledDate">
      <scheduledDate>
         <xsl:choose>
            <xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate)">
               <xsl:if test="string-length(b:valueDate) = '8'">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:valueDate"/>
                  </xsl:call-template>
               </xsl:if>
               <xsl:if test="string-length(b:valueDate) != '8'">
                  <xsl:value-of select="b:valueDate"/>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="string-length(b:intRateVDate) = '8'">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:intRateVDate"/>c</xsl:call-template>
               </xsl:if>
               <xsl:if test="string-length(b:intRateVDate) != '8'">
                  <xsl:value-of select="b:intRateVDate"/>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </scheduledDate>
   </xsl:template>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:choose>
            <xsl:when test="../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate = '' or not(../../c:PreviousEvent/b:LdLoansAndDepositsOldNew/b:interestRateList/b:interestRate)">
               <xsl:if test="string-length(b:valueDate) = 8">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:valueDate"/>
                  </xsl:call-template>
               </xsl:if>
               <xsl:if test="string-length(b:valueDate) != 8">
                  <xsl:value-of select="b:valueDate"/>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
               <xsl:if test="string-length(b:intRateVDate) = 8">
                  <xsl:call-template name="xsdate">
                     <xsl:with-param name="date" select="b:intRateVDate"/>
                  </xsl:call-template>
               </xsl:if>
               <xsl:if test="string-length(b:intRateVDate) != 8">
                  <xsl:value-of select="b:intRateVDate"/>
               </xsl:if>
            </xsl:otherwise>
         </xsl:choose>
      </validityDate>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="endDate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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