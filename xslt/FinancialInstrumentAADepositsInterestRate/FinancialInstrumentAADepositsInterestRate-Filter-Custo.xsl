<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext" xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec" xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec" xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord" version="1.0" exclude-result-prefixes="a b c d e f g h i j k l">
  
  
  <!-- Condition 2 -->
  <!-- BEG - JPP20241017 - adding rate LEVEL for interest cond (The setting for MRBD Deposit is ‘Level’)-->
  <xsl:template match="c:AAAFlow" mode="filter1">
    <xsl:variable name="cond01" select="contains($list_idComp2_FinancialInstrumentAADepositsInterestRate,concat(' ',c:interestrecords/a:idComp2,' '))
                                        and (c:interestrecords/a:rateTierType = 'SINGLE' or c:interestrecords/a:rateTierType = 'LEVEL')
                                        and (not(c:interestrecords/a:intRateDetails/a:periodicIndex) or c:interestrecords/a:intRateDetails/a:periodicIndex = '')
                                        and c:accountrecord/g:portfolioId                                                    
                                        and (  
                                              (contains($list_Input_FinancialInstrumentAADepositsInterestRate,concat(' ',c:aatxncontext/b:aaArrStatus,' ')) and $AA_INTERFACE_INPUT_DEALS = 'Y' ) 
                                              or 
                                              (contains($list_Active_FinancialInstrumentAADepositsInterestRate,concat(' ',c:aatxncontext/b:aaArrStatus,' ')) and ($AA_INTERFACE_INPUT_DEALS = 'N' )) 
                                              )
                                        and ( not(c:aatxncontext/b:aaActivityStatus) or c:aatxncontext/b:aaActivityStatus != 'REV' ) "/>
    <xsl:apply-templates select="self::c:AAAFlow[$cond01]" mode="filter2"/>
  </xsl:template>
  <!-- END - JPP20241017 - adding rate LEVEL for interest cond (The setting for MRBD Deposit is ‘Level’)-->
</xsl:stylesheet>
