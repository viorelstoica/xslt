<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/Request" xmlns:a="http://www.odcgroup.com/Request" xmlns:b="http://www.temenos.com/T24/OFSML/150" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                exclude-result-prefixes="b" version="1.0">

	<xsl:template name="omsOrderReference">
    <xsl:variable name="omsOrderReference" 
                  select="b:serviceResponse/b:ofsTransactionProcessed/b:transactionId"/>
    <xsl:variable name="omsOrderReference1" 
                  select="b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:transactionId"/>

    <xsl:choose>
        <!-- First check omsOrderReference -->
        <xsl:when test="string-length(normalize-space($omsOrderReference)) > 0">
            <xsl:choose>
                <xsl:when test="contains($omsOrderReference,'-')">
                    <omsOrderReference>
                        <xsl:value-of select="substring-before($omsOrderReference,'-')"/>
                    </omsOrderReference>
                </xsl:when>
                <xsl:otherwise>
                    <omsOrderReference>
                        <xsl:value-of select="$omsOrderReference"/>
                    </omsOrderReference>
				</xsl:otherwise>
            </xsl:choose>
        </xsl:when>

        <!-- Else check omsOrderReference1 -->
        <xsl:when test="string-length(normalize-space($omsOrderReference1)) > 0">
            <xsl:choose>
                <xsl:when test="contains($omsOrderReference1,'-')">
                    <omsOrderReference>
                        <xsl:value-of select="substring-before($omsOrderReference1,'-')"/>
                    </omsOrderReference>
                </xsl:when>
                <xsl:otherwise>
                    <omsOrderReference>
                        <xsl:value-of select="$omsOrderReference1"/>
                    </omsOrderReference>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
    </xsl:choose>
</xsl:template>
	<xsl:template name="pmsOrderReference">
		<pmsOrderReference>
			<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='TAP.REF.ID'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='TAP.REF.ID']"/>
		</pmsOrderReference>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.PTF'] !='' or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.PTF'] !=''">
						<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.PTF'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.PTF']"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='SECURITY.ACCNT'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='SECURITY.ACCNT']"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="boRoutingBusinessEntityId">
		<boRoutingBusinessEntityId>
			<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='CO.CODE'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='CO.CODE']"/>
		</boRoutingBusinessEntityId>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>account</infra:name>
			<infra:value>
				<xsl:choose>
					<xsl:when test="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.ACC'] !='' or b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.ACC'] !=''">
						<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.ACC'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='TAP.SLEEVE.ACC']"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:serviceResponse/b:ofsTransactionProcessed/b:field[@name='CUST.ACC.NO'] | b:serviceResponse/b:ofsTransactions/b:ofsTransactionProcessed/b:field[@name='CUST.ACC.NO']"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:value>
			<infra:type>string</infra:type>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="buySellIndicator"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="channel"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="notepad"/>
	<xsl:template name="orderMode"/>
	<xsl:template name="orderPriceType"/>
	<xsl:template name="orderStatus"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="priceRule"/>
	<xsl:template name="quantity"/>
	<xsl:template name="remark"/>
	<xsl:template name="security"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="subType"/>
	<xsl:template name="switchFrom"/>
	<xsl:template name="switchTo"/>
	<xsl:template name="tradeType"/>
	<xsl:template name="type"/>
	<xsl:template name="validityDate"/>
</xsl:stylesheet>