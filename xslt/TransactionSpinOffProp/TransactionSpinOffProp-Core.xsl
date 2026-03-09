<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- BEG Templates for checking if optionNom is null or not -->
	<xsl:template name="CheckOptionNomCriteria">
		<xsl:choose>
			<xsl:when test="b:optionNom and b:optionNom != ''">
				<xsl:value-of select="'Y'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'N'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END Templates for checking if optionNom is null or not -->

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="../../b:accountNo"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyPositionCcyExchangeRate">
		<account1CcyPositionCcyExchangeRate>
			<xsl:value-of select="../../b:accExchRate"/>
		</account1CcyPositionCcyExchangeRate>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="originalDepositaryAccount">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<originalDepositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</originalDepositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="originalSecurity">
		<originalSecurity>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</originalSecurity>
	</xsl:template>
	<xsl:template name="transactionCode">
	<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$opStatus = 'REVERSE-AUTHORISE'">
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,'_R',$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
   		<xsl:when test="../../b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
					<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="coaReference">
		<coaReference>
			<xsl:value-of select="../../b:diaryId"/>
		</coaReference>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:newSecurity"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../../b:PayDateJoin"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../../b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="securityQuantity">
		<securityQuantity>
			<xsl:value-of select="b:nominal"/>
		</securityQuantity>
	</xsl:template>
	<!-- BEG - Template for adding the sum of nominal and lastprice groups till current new security -->
	<xsl:template name="sumOfNominalLastPriceProduct">
		<xsl:param name="StartIndex"/>
		<xsl:param name="MainIndex"/>
		<xsl:param name="TotSubIndex"/>
		<xsl:param name="TotalSum"/>
		<xsl:choose>
			<xsl:when test="$StartIndex &lt;= $TotSubIndex">
				<xsl:variable name="curgroupNomLastPriceProduct">
					<xsl:value-of select="format-number(../b:newSecuritySubGroup[@index = $StartIndex]/b:nominal * ../../b:newSecurityLastPriceJoinGroup[@index = $MainIndex]/b:newSecurityLastPriceJoinSubGroup[@index = $StartIndex]/b:newSecurityLastPriceJoin,$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:call-template name="sumOfNominalLastPriceProduct">
					<xsl:with-param name="StartIndex" select="$StartIndex+1"/>
					<xsl:with-param name="MainIndex" select="$MainIndex"/>
					<xsl:with-param name="TotSubIndex" select="$TotSubIndex"/>
					<xsl:with-param name="TotalSum" select="$TotalSum+$curgroupNomLastPriceProduct"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$TotalSum"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- END - Template for adding the sum of nominal and lastprice groups till current new security -->
	<xsl:template name="costProportion">
		<xsl:param name="SubIndex" select="./@index"/>
		<xsl:param name="TotSubIndex" select="../b:newSecuritySubGroup[position()=last()]/@index"/>
		<xsl:param name="MainIndex" select="../@index"/>
		<xsl:param name="curNewSecLastPrice" select="format-number(../../b:newSecurityLastPriceJoinGroup[@index = $MainIndex]/b:newSecurityLastPriceJoinSubGroup[@index = $SubIndex]/b:newSecurityLastPriceJoin,$decimalformat,'nan2zero')"/>
		<xsl:param name="curNewSecNominal" select="format-number(b:nominal,$decimalformat,'nan2zero')"/>
		<xsl:param name="curNewSecQualifyHolding" select="format-number(../../b:qualifyHolding,$decimalformat,'nan2zero')"/>
		<xsl:param name="securityNoLastPriceJoin" select="format-number(../../b:securityNoLastPriceJoin,$decimalformat,'nan2zero')"/>
		<xsl:param name="sumOfNominalLastPriceProduct">
			<xsl:call-template name="sumOfNominalLastPriceProduct">
				<xsl:with-param name="StartIndex" select="'1'"/>
				<xsl:with-param name="MainIndex" select="$MainIndex"/>
				<xsl:with-param name="TotSubIndex" select="$TotSubIndex"/>
				<xsl:with-param name="TotalSum" select="'0'"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:param name="curBookCost" select="format-number(b:bookCost,$decimalformat,'nan2zero')"/>
		<xsl:param name="sumOfPrevBookCost" select="format-number(sum(../b:newSecuritySubGroup[@index &lt; $SubIndex]/b:bookCost),$decimalformat,'nan2zero')"/>
		<costProportion>
			<xsl:choose>
				<xsl:when test="b:bookCost and b:bookCost != ''">
					<xsl:value-of select="format-number($curBookCost div (1 - ($sumOfPrevBookCost div 100)),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(($curNewSecNominal * $curNewSecLastPrice) div (($curNewSecQualifyHolding * $securityNoLastPriceJoin) + $sumOfNominalLastPriceProduct),$decimalformat,'nan2zero') * 100"/>
				</xsl:otherwise>
			</xsl:choose>
		</costProportion>
	</xsl:template>
	<xsl:template name="reversalIndicator">
	<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversalIndicator>
				<xsl:value-of select="'1'"/>
			</reversalIndicator>
		</xsl:if>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
	<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="../../b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="../../b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$opStatus = 'REVERSE-AUTHORISE'">
			<reversedTransactionCode>
				<xsl:choose>
					<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
						<xsl:value-of select="concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../../b:entitlementId,'_',../@index,'/',@index,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin)"/>
					</xsl:otherwise>
				</xsl:choose>
			</reversedTransactionCode>
		</xsl:if>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../../b:entitlementId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="positionCriteria1">
		<positionCriteria1>
			<xsl:call-template name="extCustodianTranslation">
				<xsl:with-param name="boExtCustodian">
					<xsl:value-of select="../../b:extCustodian"/>
				</xsl:with-param>
			</xsl:call-template>
		</positionCriteria1>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="concat('ENT_',../../b:eventType)"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyPositionCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyPositionCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="subType"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="initiator"/>
	<xsl:template name="originalPositionCriteria1"/>
	<xsl:template name="originalPositionCriteria2"/>
	<xsl:template name="originalPositionCriteria3"/>
	<xsl:template name="originalPositionCurrency"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="positionCurrency"/>
	<xsl:template name="transactionFeesTaxesCounter">
		<xsl:param name="fgnChargesAmt">
			<xsl:value-of select="format-number(../../b:fgnChargesAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="foreignChgesTax">
			<xsl:value-of select="format-number(../../b:foreignChgesTax,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="sourceTaxAmt">
			<xsl:value-of select="format-number(../../b:sourceTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="localTaxAmtSum">
			<xsl:value-of select="format-number(sum(../../b:localTaxAmtList/b:localTaxAmt),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commissionAmt">
			<xsl:value-of select="format-number(../../b:commissionAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="commTaxAmt">
			<xsl:value-of select="format-number(../../b:commTaxAmt,$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="manTaxAcySum">
			<xsl:value-of select="format-number(sum(../../b:scTaxCodeGroup/b:manTaxAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<xsl:param name="scAmtAcySum">
			<xsl:value-of select="format-number(sum(../../b:scTaxCodeGroup/b:scAmtAcy),$decimalformat,'nan2zero')"/>
		</xsl:param>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$fgnChargesAmt + $foreignChgesTax"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP1'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP10'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$sourceTaxAmt + $localTaxAmtSum"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP2'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP3'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="./@index = '1'">
						<xsl:value-of select="$commissionAmt + $commTaxAmt"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP4'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$manTaxAcySum + $scAmtAcySum"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP5'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP6'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP8'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../b:currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP9'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="exDate">
		<exDate>
			<xsl:value-of select="../../b:diaryExDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
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