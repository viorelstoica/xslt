<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPaymentOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPaymentOrder"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingCode">
		<accountingCode>
			<xsl:value-of select="b:id"/>
		</accountingCode>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:paymentExecutionDate,'-','')"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="b:tapRefId"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="targetCurrentAccount">
		<targetCurrentAccount>
			<infra:code>
				<xsl:choose>
            		<xsl:when test="b:tapDrSlvAcc != ''">
               			<xsl:value-of select="b:tapDrSlvAcc"/>
            		</xsl:when>
            		<xsl:otherwise>
               			<xsl:value-of select="b:debitAccount"/>
            		</xsl:otherwise>
         		</xsl:choose>
			</infra:code>
		</targetCurrentAccount>
	</xsl:template>
	<xsl:template name="transactionCurrency">
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="b:debitCcy"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="translate(b:paymentExecutionDate,'-','')"/>
			</xsl:call-template>
		</transactionDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
                  		<xsl:value-of select="b:tapSleevePtf"/>
               		</xsl:when>
					<xsl:when test="b:debitAccountPortfolioNoList/b:debitAccountPortfolioNo">
						<xsl:value-of select="b:debitAccountPortfolioNoList/b:debitAccountPortfolioNo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:debitAccountSamHistId"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:paymentAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<xsl:param name="boStatus">
			<xsl:choose>
				<xsl:when test="b:currentState = 'CancelOrder'">
					<xsl:value-of select="'REJECTED'"/>
				</xsl:when>
				<xsl:when test="b:currentState = 'OrderApproved'">
					<xsl:value-of select="'PLACED'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'PLACED'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="$boStatus"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('POR',$COMPANY_POSTFIX_SEPARATOR,b:paymentOrderProduct)"/>
				<xsl:if test="$POSTFIX_PORTYPE = 'Y'">
					<xsl:value-of select="concat($COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
				</xsl:if>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<xsl:if test="b:debitValueDate and b:debitValueDate!= ''">
			<valueDate>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="translate(b:debitValueDate,'-','')"/>
				</xsl:call-template>
			</valueDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceCurrentAccount">
		<sourceCurrentAccount>
			<infra:code>
				<xsl:choose>
            		<xsl:when test="b:tapCrSlvAcc != ''">
               			<xsl:value-of select="b:tapCrSlvAcc"/>
            		</xsl:when>
            		<xsl:otherwise>
               			<xsl:value-of select="b:creditAccount"/>
            		</xsl:otherwise>
         		</xsl:choose>
			</infra:code>
		</sourceCurrentAccount>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceCurrentAccountCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="sourceCurrentAccountCcyTargetCurrentAccountCcyExchangeRate"/>
	<xsl:template name="sourceCurrentAccountNetAmount"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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