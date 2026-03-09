<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="deposit">
      <xsl:choose>
   		<xsl:when test="b:depository != ''">
		<deposit>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</deposit>
		</xsl:when>
   </xsl:choose>
   </xsl:template>
   <xsl:template name="historicalExchangeRate">
      <xsl:if test="b:costInvstSecCcy != '' and b:costInvstSecCcy != number('0') and b:costInvstRefCcy != '' and b:costInvstRefCcy != number('0') and b:costInvstSecCcy and b:costInvstRefCcy">
         <historicalExchangeRate>
            <xsl:choose>
               <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                  <xsl:value-of select="format-number(b:costInvstRefCcy div b:costInvstSecCcy,$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(b:costInvstSecCcy div b:costInvstRefCcy ,$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </historicalExchangeRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="historicalInstrExchRate">
      <xsl:if test="b:costInvstSecCcy != '' and b:costInvstSecCcy != number('0') and b:costInvstRefCcy != '' and b:costInvstRefCcy != number('0') and b:costInvstSecCcy and b:costInvstRefCcy">
         <historicalInstrExchRate>
            <xsl:choose>
               <xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
                  <xsl:value-of select="format-number(b:costInvstRefCcy div b:costInvstSecCcy,$decimalformat,'nan2zero')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="format-number(b:costInvstSecCcy div b:costInvstRefCcy ,$decimalformat,'nan2zero')"/>
               </xsl:otherwise>
            </xsl:choose>
         </historicalInstrExchRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="historicalPrice">
        <xsl:variable name="today" select="number(concat(substring(b:eventCommon/ns0:today,1,4),substring(b:eventCommon/ns0:today,6,2),substring(b:eventCommon/ns0:today,9,2)))"/>
		<xsl:variable name="ind">
			<xsl:for-each select="b:cpnDateSecMasterJoinGroup">
				<xsl:variable name="current" select="number(concat(substring(b:cpnDateSecMasterJoin,1,4),substring(b:cpnDateSecMasterJoin,6,2),substring(b:cpnDateSecMasterJoin,9,2)))"/>
				<xsl:choose>
					<xsl:when test="$current &lt;= $today">
						<xsl:value-of select="@index"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="ind2" select="substring($ind,1,1)"/>		
		<historicalPrice>
			<xsl:choose>
				<xsl:when test="(b:priceTypeSecMasterJoin='BOND' or b:priceTypeSecMasterJoin='DBOND') and (b:cpnDateSecMasterJoinGroup[@index=$ind2]/b:factorSecMasterJoin !='NULL')">
					<xsl:value-of select="format-number(((b:costInvstSecCcy div b:closingBalNoNom) * 100) div (b:cpnDateSecMasterJoinGroup[@index=$ind2]/b:factorSecMasterJoin),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="(b:priceTypeSecMasterJoin='BOND' or b:priceTypeSecMasterJoin='DBOND') and $ind2 = '' ">
					<xsl:value-of select="format-number(((b:costInvstSecCcy div b:closingBalNoNom) * 100),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number((b:costInvstSecCcy div b:closingBalNoNom),$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</historicalPrice>
   </xsl:template>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
            <xsl:value-of select="b:securityNumber"/>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:securityAccount"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:value-of select="b:id"/>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="b:secCcy"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="positionValueDate">
      <positionValueDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </positionValueDate>
   </xsl:template>
   <xsl:template name="quantity">
      <quantity>
         <xsl:value-of select="b:closingBalNoNom"/>
      </quantity>
   </xsl:template>
   <xsl:template name="status">
      <status>
         <xsl:call-template name="statusTranslation">
            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
         </xsl:call-template>
      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>INITLOAD</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="accruedInterests"/>
   <xsl:template name="historicalNetAmount"/>
   <xsl:template name="initialLoadPrice"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="referenceNature">
	<referenceNature>0</referenceNature>
   </xsl:template>
   <xsl:template name="referenceOperationCode"/>
   <xsl:template name="sourceCode">
      <sourceCode>
         <xsl:value-of select="b:id"/>
      </sourceCode>
   </xsl:template>
   <xsl:template name="bookExchangeRate"/>
   <xsl:template name="bookPrice"/>
   <xsl:template name="bookNetAmount"/>
</xsl:stylesheet>