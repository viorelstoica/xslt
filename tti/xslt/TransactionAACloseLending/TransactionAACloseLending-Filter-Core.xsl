<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<xsl:template match="c:aaarecord">
		<xsl:if test="(         
						((d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT') or (d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL'))
						and (../c:recarrangement/i:arrStatus = 'EXPIRED' or ../c:recarrangement/i:arrStatus = 'PENDING.CLOSURE')
                         and (  d:txnSystemId = 'AAAA' and (../c:aatxncontext/b:aaMasterActivity =  'LENDING-MATURE-ARRANGEMENT' or
                              ../c:aatxncontext/b:aaMasterActivity = 'LENDING-MAKEDUE-SCHEDULE')
                         )
						 and ../c:billdetails/j:billProperyDetails[starts-with(j:repayRef,../../c:aatxncontext/b:aaArrActivityId)]/j:property = 'ACCOUNT'
					)       
					or       (        
						 d:txnSystemId = 'FT' 
						 and ((d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT') or (d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL')) 
                         and (../c:recarrangement/i:arrStatus = 'CURRENT' or 
                              ../c:recarrangement/i:arrStatus = 'PENDING.CLOSURE' or
                              ../c:recarrangement/i:arrStatus = 'EXPIRED' ) 
						 and ../c:aatxncontext/b:aaMasterActivity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT'
						 and ../c:billdetails/j:billProperyDetails[starts-with(j:repayRef,../../c:aatxncontext/b:aaArrActivityId)]/j:property = 'ACCOUNT'              
					)       
					or       (        
						../c:recarrangement/i:arrStatus = 'CLOSE'        
						and ((d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT') or (d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL'))       
						and d:txnSystemId = 'AAAA'        
						and ../c:billdetails/j:billProperyDetails[starts-with(j:repayRef,../../c:aatxncontext/b:aaArrActivityId)]/j:property = 'ACCOUNT'        
					)">
			<xsl:if test="../c:accountrecord/g:portfolioId != '' and (not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV')">
				<xsl:copy-of select="."/>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>