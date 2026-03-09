<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
<!-- START of protected area  -->

   <xsl:template name="notepad">
       <xsl:if test="b:csdTapNarr">
            <notepad>
                <infra:date>
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="b:paymentExecutionDate"/>
                        </xsl:call-template> 
                </infra:date>
                <infra:note>
                    <xsl:value-of select="b:csdTapNarr"/>
                </infra:note>
                <infra:title>
                    <xsl:value-of select=" 'NARRATIVE' "/>
                </infra:title>
                <infra:type>
                    <infra:code>
                        <xsl:value-of select=" 'NARRATIVE' "/>
                    </infra:code>
                </infra:type>
            </notepad>
        </xsl:if>
	</xsl:template>
<!-- END of protected area  -->
</xsl:stylesheet>