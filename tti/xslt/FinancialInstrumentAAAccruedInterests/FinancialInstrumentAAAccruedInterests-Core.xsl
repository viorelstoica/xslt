<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">
  <xsl:param name="list_auth" select="'AUTH CURRENT AUTH-FWD'"/>
  <xsl:template name="currency">
    <currency>
      <infra:code>
        <xsl:value-of select="c:recarrangement/i:currency"/>
      </infra:code>
    </currency>
  </xsl:template>
  <xsl:template name="dataNature">
    <dataNature>
      <xsl:value-of select="'18'"/>
    </dataNature>
  </xsl:template>
  <xsl:template name="instrument">
    <instrument>
      <infra:code>
       <xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
        		<xsl:value-of select="concat(c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,c:aatxncontext/b:aaCompanyMnemonic)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="c:aatxncontext/b:aaArrangementId"/>
			</xsl:otherwise>
		</xsl:choose>
      </infra:code>
    </instrument>
  </xsl:template>
  <xsl:template name="validity">
    <validity>
      <xsl:call-template name="xsdate">
        <xsl:with-param name="date" select="c:aaarecord/d:effectiveDate"/>
      </xsl:call-template>
    </validity>
  </xsl:template>
  <!--  Template to compute the interest for an accrual set  -->
  <xsl:template name="computeSingleAAInterest">
    <xsl:param name="accrualRecord" />

    
     <xsl:variable name="RecentPeriodEnd" select="$accrualRecord/k:totalAccrual[k:periodEnd and k:periodStart &lt;= $accrualRecord/../c:aaarecord/d:effectiveDate
                                                    and k:periodEnd &gt;= $accrualRecord/../c:aaarecord/d:effectiveDate]/k:periodEnd"/>
    <xsl:variable name="principalIntId" select="concat($accrualRecord/../c:aatxncontext/b:aaArrangementId, '-PRINCIPALINT')"/>
    <xsl:variable name="penaltyIntId" select="concat($accrualRecord/../c:aatxncontext/b:aaArrangementId, '-PENALTYINT')"/>
    <xsl:variable name="depositIntId" select="concat($accrualRecord/../c:aatxncontext/b:aaArrangementId, '-DEPOSITINT')"/>    

      <xsl:variable name="totAccrAmtNb">
        <xsl:value-of select="format-number($accrualRecord/k:totalAccrual[k:periodEnd = $RecentPeriodEnd or not(k:periodEnd)]/k:totAccrAmt,$decimalformat,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="totDueAmtNb">
        <xsl:value-of select="format-number($accrualRecord/k:totalAccrual[k:periodEnd = $RecentPeriodEnd or not(k:periodEnd)]/k:totDueAmt,$decimalformat,'nan2zero')"/>
      </xsl:variable>
      <xsl:variable name="totRpyAmtNb">
        <xsl:value-of select="format-number($accrualRecord/k:totalAccrual[k:periodEnd = $RecentPeriodEnd or not(k:periodEnd)]/k:totRpyAmt,$decimalformat,'nan2zero')"/>
      </xsl:variable>      
      <!--  the balance is always the principal since TAP only knows unitary interest per position balance  -->
      <xsl:variable name="balanceNb">
        <xsl:value-of select="format-number($accrualRecord/../c:intaccrualrecords[k:intAccrualId = $principalIntId 
                                or k:intAccrualId = $depositIntId]/k:currAccrual/k:balance,$decimalformat,'nan2zero')"/>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="($totAccrAmtNb - $totDueAmtNb - $totRpyAmtNb != 0) and ($balanceNb != 0)">
          <xsl:value-of select="format-number(($totAccrAmtNb - $totDueAmtNb -$totRpyAmtNb) div $balanceNb,'#.############','nan2zero')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'0'"/>
        </xsl:otherwise>
      </xsl:choose>     
  </xsl:template>
  
  <!--  Template to compute all accrued interests contained in an AAAFlow message -->
  <xsl:template name="computeAllAAInterest">
        <xsl:param name="aaMessage"/>
        
         <!--  The value is the sum of all the accrued interest values -->
	    <xsl:variable name="principalIntId" select="concat($aaMessage/c:aatxncontext/b:aaArrangementId, '-PRINCIPALINT')"/>
	    <xsl:variable name="penaltyIntId" select="concat($aaMessage/c:aatxncontext/b:aaArrangementId, '-PENALTYINT')"/>
	    <xsl:variable name="depositIntId" select="concat($aaMessage/c:aatxncontext/b:aaArrangementId, '-DEPOSITINT')"/>    

        <xsl:choose>
            <xsl:when test="$aaMessage/c:intaccrualrecords[contains(k:intAccrualId, 'DEPOSIT')]"> 
		         <xsl:variable name="depositInterest">
		            <xsl:choose>
		                <xsl:when test="$aaMessage/c:intaccrualrecords[k:intAccrualId = $depositIntId] and (
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $depositIntId]/k:totalAccrual[not(k:periodEnd)] or 
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $depositIntId]/k:totalAccrual/k:periodEnd &gt;= $aaMessage/c:aaarecord/d:effectiveDate
		                            )
		                    ">
		                    <xsl:call-template name="computeSingleAAInterest">
		                        <xsl:with-param name="accrualRecord" select="$aaMessage/c:intaccrualrecords[contains(k:intAccrualId, 'DEPOSIT')]" />
		                    </xsl:call-template>                
		                </xsl:when>
		                <xsl:otherwise>
		                    <xsl:value-of select="0"/>
		                </xsl:otherwise>
		            </xsl:choose>
		        </xsl:variable>
                <xsl:value-of select="format-number($depositInterest,'#.############','nan2zero')"/>   
            </xsl:when>                  
            <xsl:otherwise>
		        <xsl:variable name="principalInterest">
		            <xsl:choose>
		                <xsl:when test="$aaMessage/c:intaccrualrecords[k:intAccrualId = $principalIntId] and (
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $principalIntId]/k:totalAccrual[not(k:periodEnd)] or 
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $principalIntId]/k:totalAccrual/k:periodEnd &gt;= $aaMessage/c:aaarecord/d:effectiveDate
		                            )
		                    ">
		                    <xsl:call-template name="computeSingleAAInterest">
		                        <xsl:with-param name="accrualRecord" select="$aaMessage/c:intaccrualrecords[contains(k:intAccrualId, 'PRINCIPAL')]" />
		                    </xsl:call-template>                
		                </xsl:when>
		                <xsl:otherwise>
		                    <xsl:value-of select="0"/>
		                </xsl:otherwise>
		            </xsl:choose>
		        </xsl:variable>     
		        <xsl:variable name="penaltyInterest">
		            <xsl:choose>
		                <xsl:when test="$aaMessage/c:intaccrualrecords[k:intAccrualId = $penaltyIntId] and (
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $penaltyIntId]/k:totalAccrual[not(k:periodEnd)] or 
		                            $aaMessage/c:intaccrualrecords[k:intAccrualId = $penaltyIntId]/k:totalAccrual/k:periodEnd &gt;= $aaMessage/c:aaarecord/d:effectiveDate
		                            )
		                    ">
		                    <xsl:call-template name="computeSingleAAInterest">
		                        <xsl:with-param name="accrualRecord" select="$aaMessage/c:intaccrualrecords[contains(k:intAccrualId, 'PENALTY')]" />
		                    </xsl:call-template>                
		                </xsl:when>
		                <xsl:otherwise>
		                    <xsl:value-of select="0"/>
		                </xsl:otherwise>
		            </xsl:choose>
		        </xsl:variable> 
                    
                <xsl:value-of select="format-number($principalInterest + $penaltyInterest,'#.############','nan2zero')"/>                     
            </xsl:otherwise>
        </xsl:choose>
  </xsl:template>  
  
  <xsl:template name="value">
    <value>
            <xsl:call-template name="computeAllAAInterest">
                    <xsl:with-param name="aaMessage" select="." />
            </xsl:call-template>
    </value>
  </xsl:template>
  <xsl:template name="provider"/>
  <xsl:template name="valueType"/>
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