<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec"
                xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec"
                xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec"
                xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">


	<!-- BEG - JPP20240718 - adding activity = 'LENDING-AUTO.DISBURSE-COMMITMENT' -->
	<xsl:template match="c:aaarecord">
		<xsl:if test="(starts-with(d:txnSystemId,'AA') and
		 ( ../c:aatxncontext/b:aaMasterActivity = 'LENDING-NEW-ARRANGEMENT' or
		  ../c:aatxncontext/b:aaMasterActivity = 'LENDING-ISSUEBILL-SCHEDULE*DISBURSEMENT.%' or
		   ../c:aatxncontext/b:aaMasterActivity = 'LENDING-MAKEDUE.DISBURSE-SCHEDULE' ) and 
               (d:activity = 'LENDING-AUTO.DISBURSE-COMMITMENT' or d:activity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL' or d:activity = 'LENDING-NEW-ARRANGEMENT' and  $AA_INTERFACE_INPUT_DEALS = 'Y')
           )
           or
            d:txnSystemId = 'FT' and d:activity = 'LENDING-APPLYPAYMENT-PO.WITHDRAWAL' 
           or 
            not( d:txnSystemId) and d:activity = 'LENDING-NEW-ARRANGEMENT' and  $AA_INTERFACE_INPUT_DEALS = 'Y'">
			<xsl:if test="../c:accountrecord/g:portfolioId">
				<xsl:if test="not(../c:aatxncontext/b:aaActivityStatus) or ../c:aatxncontext/b:aaActivityStatus != 'REV'">
					<xsl:copy-of select="."/>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- END - JPP20240718 - adding activity = 'LENDING-AUTO.DISBURSE-COMMITMENT' -->

</xsl:stylesheet>
