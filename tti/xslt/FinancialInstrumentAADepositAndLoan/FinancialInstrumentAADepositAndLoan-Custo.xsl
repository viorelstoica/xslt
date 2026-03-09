<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">

	<!-- START of protected area  -->

	<!-- END of protected area  -->
	
	<!-- BEG - JPB/JPP20240829 - remove empty subNature to avoid gwpack severe error -->
	<xsl:template name="subNature">
		<xsl:if test="c:recarrangement/i:productLine = 'DEPOSITS'">
			<subNature>
				<xsl:choose>
					<xsl:when test="c:recaccountdetails/f:reportEndDate and c:recaccountdetails/f:reportEndDate != ''">119</xsl:when>
					<xsl:otherwise>118</xsl:otherwise>
				</xsl:choose>
			</subNature>
		</xsl:if>
	</xsl:template>
	<!-- END - JPB/JPP20240829 - remove empty subNature to avoid gwpack severe error -->

	<!-- BEG - JPB/JPP20241015 - adding interestRate -->
	<xsl:template name="interestRate">
		<xsl:if test="c:interestrecords/a:intRateDetails/a:fixedRate and c:interestrecords/a:intRateDetails/a:fixedRate != ''">
			<interestRate>
				<xsl:value-of select="c:interestrecords/a:intRateDetails/a:fixedRate"/>
			</interestRate>
		</xsl:if>
	</xsl:template>
	<!-- END - JPB/JPP20241015 - adding interestRate -->

</xsl:stylesheet>
