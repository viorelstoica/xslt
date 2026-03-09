<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.odcgroup.com/Request" 
	xmlns:a="http://www.odcgroup.com/Request" 
	xmlns:b="http://www.temenos.com/T24/OFSML/150" 
	xmlns:infra="http://www.odcgroup.com/InfraPMS" 
	exclude-result-prefixes="b" 
	version="1.0">
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
    <!-- Condition 1 -->
    <xsl:template match="b:T24">
        <xsl:apply-templates select="self::b:T24[((b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@processingStatus = 'OK')
        and ((
            b:serviceResponse/b:ofsTransactionProcessed/@application = 'SEC.OPEN.ORDER'
            or
            (b:serviceResponse/b:ofsTransactionProcessed/@application = 'DX.ORDER' and  
                (
                 not(b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.AMEND'])
                 or
                 b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.AMEND'] != 'YES'
                 )
                 and contains(b:serviceResponse/b:ofsTransactionProcessed/b:transactionId, '-0')
            )
        )
		or
		(
            b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@application = 'SEC.OPEN.ORDER'
            or
            (b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@application = 'DX.ORDER'
              and
              (
                not(b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='ORDER.AMEND'])
                or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='ORDER.AMEND'] != 'YES'
              )
              and contains(b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:transactionId, '-0')
            )
          )
        )
        and (b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='CURR.NO'] = '1' or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='CURR.NO'] = '1')) 
		or (b:serviceResponse/b:ofsTransactionProcessed/@application = 'PE.CUSTOMER.TXN' 
		and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@application = 'PE.CUSTOMER.TXN' 
		and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU' 
		and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU' 
		and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='COMMITMENT.STATUS'] != 'CANCELLED' 
		and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='COMMITMENT.STATUS'] != 'CANCELLED')
        ]" mode="filter-custo"/>
    </xsl:template>
    <!-- Custo placeholder -->
    <xsl:template match="b:T24" mode="filter-custo">
        <xsl:apply-templates select="self::b:T24" mode="filter-final"/>
    </xsl:template>

    <!-- Copy block -->
    <xsl:template match="b:T24" mode="filter-final">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>    
</xsl:stylesheet>