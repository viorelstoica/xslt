<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="account1"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:creditPortfolio = '' or not(b:creditPortfolio)">
							<xsl:choose>
							<xsl:when test="b:creditAccountPortfolioNoList/b:creditAccountPortfolioNo and b:creditAccountPortfolioNoList/b:creditAccountPortfolioNo != ''">
								<xsl:value-of select="b:creditAccountPortfolioNoList/b:creditAccountPortfolioNo"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:creditAccountSamHistId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:creditPortfolio"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="status">
		<status>
			<xsl:value-of select=" '90' "/>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:value-of select="concat('PO_',b:id,'_C',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,'_R')"/>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
	<valueDate>
      <xsl:value-of select="b:creditValueDate"/>
    </valueDate>
   </xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
				<xsl:value-of select="b:creditAccount"/>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:creditAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="transactionDate">
   		<transactionDate>
      		<xsl:value-of select="b:paymentExecutionDate"/>
    	</transactionDate>
   </xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>
			<xsl:value-of select=" '1' "/>
		</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
			<xsl:value-of select="concat('PO_',b:id,'_C',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="transactionCcyGrossAmount">
		<transactionCcyGrossAmount>
			<xsl:value-of select="b:paymentAmount"/>
		</transactionCcyGrossAmount>
	</xsl:template>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->