<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SecurityTransfer" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSecurityTransfer"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSecurityTransfer" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSecurityTransfer"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleeveAcc"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:cuAccountNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate">
		<xsl:variable name="ccyAccXRate">
			<xsl:choose>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:netAmtSecCcy  div b:custNetAmt,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:custNetAmt div b:netAmtSecCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="b:peFund != 'YES'">
			<account1CcyTradeCcyExchangeRate>
				<xsl:value-of select="$ccyAccXRate"/>
			</account1CcyTradeCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:value-of select="b:custNetAmt"/>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:tapSleevePtf != ''">
						<xsl:value-of select="b:tapSleevePtf"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcc"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:variable name="remark">
				<xsl:for-each select="b:custRemarksList/b:custRemarks">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="substring($remark,1,80)"/>
		</remark>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapRefId and b:tapRefId != ''">
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:value-of select="concat(b:tapOperCode,'_','ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_I_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:call-template name="printTransferFeesAndTaxes">
			<xsl:with-param name="caller" select="'TransferBuy'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('SC_',b:transactionType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accountCurrency">
		<xsl:if test="b:cuAccountCcy != '' or b:cuAccountCcy">
			<accountCurrency>
				<infra:code>
					<xsl:value-of select="b:cuAccountCcy"/>
				</infra:code>
			</accountCurrency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="commonReference"/>
	<xsl:template name="accruedInterests">
		<xsl:if test="b:interestAmt and b:interestAmt != ''">
			<accruedInterests>
				<xsl:value-of select="b:interestAmt"/>
			</accruedInterests>
		</xsl:if>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
			<xsl:when test="b:depository !='' and b:depository and b:subAccountTypeList/b:subAccountType[@index=1]=$subAccountNature">
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
					</infra:code>
				</depositaryAccount>
			</xsl:when>
			<xsl:otherwise>
				<depositaryAccount>
					<infra:code>
						<xsl:value-of select="b:depository"/>
					</infra:code>
				</depositaryAccount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="price">
		<xsl:if test="b:price !=''">
			<price>
				<xsl:value-of select="number(b:price)"/>
			</price>
		</xsl:if>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:noNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate">
		<xsl:variable name="ccyAccXRate">
			<xsl:choose>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:netAmtSecCcy  div b:custNetAmt,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:custNetAmt div b:netAmtSecCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ccyInstrXRate">
			<xsl:choose>
				<xsl:when test="b:securityCcy = b:referenceCurrencyJoin">
					<xsl:value-of select="$ccyAccXRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
							<xsl:value-of select="format-number(b:cost div b:grossAmtSecCcy ,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(b:grossAmtSecCcy div b:cost,$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ccyOpXRate">
			<!--  since op and instr ccy are the same, x-rates towards ptf ccy are the same -->
			<xsl:value-of select="$ccyInstrXRate"/>
		</xsl:variable>
		<xsl:if test="b:peFund != 'YES'">
			<securityCcyPortfolioCcyExchangeRate>
				<xsl:value-of select="$ccyInstrXRate"/>
			</securityCcyPortfolioCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:securityCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount">
		<tradeCcyGrossAmount>
			<xsl:value-of select="b:grossAmtSecCcy"/>
		</tradeCcyGrossAmount>
	</xsl:template>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate">
		<xsl:variable name="ccyAccXRate">
			<xsl:choose>
				<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
					<xsl:value-of select="format-number(b:netAmtSecCcy  div b:custNetAmt,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(b:custNetAmt div b:netAmtSecCcy,$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ccyInstrXRate">
			<xsl:choose>
				<xsl:when test="b:securityCcy = b:referenceCurrencyJoin">
					<xsl:value-of select="$ccyAccXRate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
							<xsl:value-of select="format-number(b:cost div b:grossAmtSecCcy ,$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(b:grossAmtSecCcy div b:cost,$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ccyOpXRate">
			<!--  since op and instr ccy are the same, x-rates towards ptf ccy are the same -->
			<xsl:value-of select="$ccyInstrXRate"/>
		</xsl:variable>
		<xsl:if test="b:peFund != 'YES'">
			<tradeCcyPortfolioCcyExchangeRate>
				<xsl:value-of select="$ccyOpXRate"/>
			</tradeCcyPortfolioCcyExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="compundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="stockExchange"/>
	<xsl:template name="stopPrice"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="trader"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="validityDate"/>
	<xsl:template name="coolCancelEndDate"/>
	<xsl:template name="referenceNature"/>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:value-of select="b:valueDate"/>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus"/>
	<xsl:template name="paymentDate">
		<paymentDate>
			<xsl:value-of select="b:valueDate"/>
		</paymentDate>
	</xsl:template>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="boAccount">
		<boAccount>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:cuAccountNo"/>
				</xsl:if>
			</infra:code>
		</boAccount>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="b:tapSleevePtf != ''">
					<xsl:value-of select="b:securityAcc"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:choose>
				<xsl:when test="b:tapSleevePtf != ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</splitPortfolio>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="" userelativepaths="yes" externalpreview="no" url="studio" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
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