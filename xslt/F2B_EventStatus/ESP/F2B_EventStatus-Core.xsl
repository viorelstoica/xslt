<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/Request" xmlns:a="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/OFSML/150" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
  
  <xsl:template name="requestStatus">
    <requestStatus>
      <xsl:choose>
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
		<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and (b:serviceResponse/b:ofsTransactionProcessed/@application = 'SECURITY.TRANSFER' or 
				b:serviceResponse/b:ofsTransactionProcessed/@application = 'POSITION.TRANSFER')
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
          <xsl:value-of select="'30'"/>
        </xsl:when>
        <xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'NOT-AUTHORISED' 
                and starts-with(b:serviceResponse/b:ofsTransactionProcessed/@application, 'SY.') 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='RECORD.STATUS'] = 'INAU'">
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
		<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK' 
                and b:serviceResponse/b:ofsTransactionProcessed/@application = 'ESFUND.TRASPASO.REQUEST' 
                and b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='ORDER.STATUS'] = 'Cancellation.Requested'">
          <xsl:value-of select="'30'"/>
        </xsl:when>
        <xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/@processingStatus = 'OK'">
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
        <xsl:when test="b:serviceResponse/b:ofsTransactionFailed">
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
  <xsl:template name="errorReason">
    <xsl:if test="b:serviceResponse/b:ofsTransactionProcessed or b:serviceResponse/b:ofsTransactionFailed or b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed or b:serviceRequest/b:ofsTransactionInput or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed">
      <errorReason>
        <xsl:choose>
          <xsl:when test="b:serviceResponse/b:ofsTransactionFailed or b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed or b:serviceRequest/b:ofsTransactionInput">
            <xsl:value-of select="'4'"/>
          </xsl:when>
          <xsl:when test="b:serviceResponse/b:ofsTransactionProcessed or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed">
            <xsl:value-of select="'1'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'UNKNOWN_T24_RESPONSE'"/>
          </xsl:otherwise>          
        </xsl:choose>      
      </errorReason>
    </xsl:if>
  </xsl:template>
  <xsl:template name="errorInfo">
    <xsl:choose>
	  <!-- DUPLICATE TRAP from T24-->
	  <xsl:when test="b:serviceResponse/b:ofsTransactionFailed/b:error[@name='DUPLICATE.TRAP'] or b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed/b:error[@name='DUPLICATE.TRAP']">
         <errorInfo>
			<xsl:value-of select="'DUPLICATE.TRAP'"/>
		 </errorInfo>
      </xsl:when>      
      <xsl:when test="b:serviceResponse/b:ofsTransactionFailed or b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed or b:serviceResponse/b:ofsFault">
        <errorInfo>
          <xsl:choose>
            <xsl:when test="b:serviceResponse/b:ofsTransactionFailed">
              <xsl:for-each select="b:serviceResponse/b:ofsTransactionFailed/b:error">
                <xsl:value-of select="concat(@name,' -- ',.,'   ')"/>
              </xsl:for-each>
			  <xsl:for-each select="b:serviceResponse/b:ofsTransactionFailed/b:errorDescription">
                <xsl:value-of select="concat(.,'   ')"/>
              </xsl:for-each>
            </xsl:when>
			<xsl:when test="b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed">
			<xsl:for-each select="b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed/b:error">
                <xsl:value-of select="concat(@name,' -- ',.,'   ')"/>
              </xsl:for-each>
			  <xsl:for-each select="b:serviceResponse/b:ofsTransactions/b:ofsTransactionFailed/b:errorDescription">
                <xsl:value-of select="concat(.,'   ')"/>
              </xsl:for-each>
			</xsl:when>
            <xsl:when test="b:serviceResponse/b:ofsFault/b:ofsFaultMessage">
              <xsl:value-of select="b:serviceResponse/b:ofsFault/b:ofsFaultMessage"/>
            </xsl:when>
          </xsl:choose>
        </errorInfo>
      </xsl:when>
	  <xsl:when test="b:serviceRequest/b:ofsTransactionInput">
		<errorInfo>
			<xsl:value-of select="'Unable to process message even after multiple retry.Failed to connect to T24'"/>
		</errorInfo>
	  </xsl:when>	  
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->