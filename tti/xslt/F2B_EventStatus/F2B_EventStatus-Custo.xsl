<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/Request" xmlns:a="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/OFSML/150" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<!-- START of protected area  -->
	<!-- END of protected area  -->
	<xsl:template name="requestStatus">
		<requestStatus>
			<xsl:choose>
				<!-- BEG - JPP20240820- TTI T24 answer badly formatted when coming from unauthorized FOREX,  force 20 -->
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED'
						and b:serviceResponse/b:ofsTransactionProcessed/@application = 'FOREX'
						and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'20'"/>
				</xsl:when>
				<!-- END - JPP20240820- TTI T24 answer badly formatted when coming from unauthorized forex,  force 20 -->
				<!-- BEG - SMURUGAN20251215- TTI T24 answer badly formatted when coming from unauthorized DX.TRADE,  force 30 -->
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED'
						and b:serviceResponse/b:ofsTransactionProcessed/@application = 'DX.TRADE'
						and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@application = 'DX.TRADE' and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<!-- END - SMURUGAN20251215- TTI T24 answer badly formatted when coming from unauthorized DX.TRADE,  force 30 -->
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'SEC.OPEN.ORDER' 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'PE.CUSTOMER.TXN' 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'
				and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='COMMITMENT.STATUS'] = 'CANCELLED'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'PE.CUSTOMER.TXN' 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'ON-HOLD' 
                and (b:serviceResponse/b:ofsTransactionProcessed/@application = 'SECURITY.TRANSFER' or 
				b:serviceResponse/b:ofsTransactionProcessed/@application = 'POSITION.TRANSFER')
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'IHLD'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and starts-with(b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@application, 'SY.') 
                and b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' 
				and b:serviceResponse/b:ofsTransactionProcessed/@application = 'DX.ORDER' 
				and (b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.STATUS'] = 'MODIFICATION REQUEST' or               b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.STATUS'] = 'CANCELLATION REQUEST' )            ">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'SEC.OPEN.ORDER' 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.STATUS'] = 'Cancellation Requested'">
					<xsl:value-of select="'30'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/@processingStatus = 'OK'">
					<!--  no process management -> immediate update, request accepted -->
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<!--  Fiduciary FD.FID.ORDER reversal = succesful cancellation of an order -->
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'REVERSED' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'FD.FID.ORDER'">
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'FD.FID.ORDER'">
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<!-- DUPLICATE TRAP from T24-->
				<xsl:when test="b:serviceResponse/b:ofsTransactionFailed/b:error[@name='DUPLICATE.TRAP']">
					<xsl:value-of select="'50'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsTransactionFailed or b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed">
					<xsl:value-of select="'60'"/>
				</xsl:when>
				<xsl:when test="b:serviceResponse/b:ofsFault">
					<xsl:value-of select="'60'"/>
				</xsl:when>
				<xsl:when test="b:serviceRequest/b:ofsTransactionInput">
					<xsl:value-of select="'40'"/>
				</xsl:when>
			</xsl:choose>
		</requestStatus>
	</xsl:template>
</xsl:stylesheet>
