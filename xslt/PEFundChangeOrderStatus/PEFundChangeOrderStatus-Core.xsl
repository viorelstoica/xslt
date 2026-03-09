<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/F2B"
                xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="omsOrderReference">
      <omsOrderReference>
         <xsl:value-of select="b:id"/>
      </omsOrderReference>
   </xsl:template>
   <xsl:template name="pmsOrderReference">
      <pmsOrderReference>
         <xsl:value-of select="b:tapRefId"/>
      </pmsOrderReference>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:portfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="userDefinedField">
      <userDefinedField>
         <infra:name>account</infra:name>
         <infra:value>
            <xsl:value-of select="b:account"/>
         </infra:value>
         <infra:type>string</infra:type>
      </userDefinedField>
   </xsl:template>
   <xsl:template name="orderStatus">
      <orderStatus>
	  		<xsl:choose>
            <xsl:when test="b:commitmentStatus = 'PROVISIONAL'">
               <xsl:value-of select=" '70' "/>
            </xsl:when>
            <xsl:when test="b:commitmentStatus = 'FINAL'">
               <xsl:value-of select=" '90' "/>
            </xsl:when>
         </xsl:choose>
      </orderStatus>
   </xsl:template>
   <xsl:template name="depositaryAccount">
		<depositaryAccount>
			<infra:code>
				<xsl:value-of select="b:depository"/>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
   <xsl:template name="mbFields"/>
   <xsl:template name="buySellIndicator"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="channel"/>
   <xsl:template name="contractNumber"/>
   <xsl:template name="limitPrice"/>
   <xsl:template name="notepad"/>
   <xsl:template name="orderMode"/>
   <xsl:template name="orderPriceType"/>
   <xsl:template name="orderType"/>
   <xsl:template name="orderValidityType"/>
   <xsl:template name="priceRule"/>
   <xsl:template name="quantity"/>
   <xsl:template name="remark"/>
   <xsl:template name="security"/>
   <xsl:template name="sourceSystemCode"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="stopPrice"/>
   <xsl:template name="subType"/>
   <xsl:template name="switchFrom"/>
   <xsl:template name="switchTo"/>
   <xsl:template name="tradeType"/>
   <xsl:template name="type"/>
   <xsl:template name="validityDate"/>
</xsl:stylesheet>