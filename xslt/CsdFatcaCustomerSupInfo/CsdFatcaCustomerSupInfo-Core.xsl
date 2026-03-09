<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdFatcaCustomerSupInfo" exclude-result-prefixes="b  ns0" version="1.0">
  <xsl:template name="active">
    <active>1</active>
  </xsl:template>
  <xsl:template name="code">
    <code>
      <xsl:if test="b:id != ''">
        <xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
      </xsl:if>
    </code>
  </xsl:template>
  <xsl:template name="userDefinedField">
		<userDefinedField>
				<name>ud_fatca_cli_e</name>	
				<value>
					<xsl:choose>
						<xsl:when test="b:fatcaStatus ='-1'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='NON.PARTICIPATING'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='NON.US.ACCOUNT'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='OWNER.DOC.FFI.NON.US'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='OWNER.DOC.FFI.US'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='PASSIVE.NFFE.US'">
							<xsl:value-of select="'5'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='RECALCITRANT'">
							<xsl:value-of select="'6'"/>
						</xsl:when>
						<xsl:when test="b:fatcaStatus ='US.ACCOUNT'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
					</xsl:choose>
				</value>
				<type>string</type>
		</userDefinedField>
		<userDefinedField>
				<name>fatca_f</name>	
				<value>
					<xsl:choose>
						<xsl:when test="b:fatcaStatus ='-1'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'1'"/>
						</xsl:otherwise>
					</xsl:choose>
				</value>
		</userDefinedField>
  </xsl:template>
</xsl:stylesheet>