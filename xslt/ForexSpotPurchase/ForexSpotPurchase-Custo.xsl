<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="status">
		<status>
			<xsl:choose>
				<xsl:when test="b:csdOrdStatus ='ACKNOWLEDGED'">
					<xsl:value-of select="'40'"/>
				</xsl:when>
				<xsl:when test="b:csdOrdStatus ='CANCELLED'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:csdOrdStatus ='EXPIRED'">
					<xsl:value-of select="'5'"/>
				</xsl:when>
				<xsl:when test="b:csdOrdStatus ='UNACKNOWLEDGED'">
					<xsl:value-of select="'35'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'90'"/>
				</xsl:otherwise>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="currentAccountCcyPortfolioCcyExchangeRate">
		<currentAccountCcyPortfolioCcyExchangeRate>
			<xsl:if test="b:referenceCcy = b:ourAccountRecCcyList/b:ourAccountRecCcy[@index=1]">
				<xsl:value-of select="b:spotRate"/>
			</xsl:if>
		</currentAccountCcyPortfolioCcyExchangeRate>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
		<securityCcyPortfolioCcyExchangeRate>
			<xsl:if test="b:referenceCcy = b:ourAccountRecCcyList/b:ourAccountRecCcy[@index=1]">
				<xsl:value-of select="b:spotRate"/>
			</xsl:if>
		</securityCcyPortfolioCcyExchangeRate>
	</xsl:template> 
	<!-- END of protected area  -->
</xsl:stylesheet>
