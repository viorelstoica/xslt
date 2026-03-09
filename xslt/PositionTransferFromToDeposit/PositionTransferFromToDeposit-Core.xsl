<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionTransferFromToDeposit"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionTransferFromToDeposit" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionTransferFromToDeposit" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionTransferFromToDeposit" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="../b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="adjustmentNat">
		<adjustmentNature>
			<xsl:call-template name="boAdjustmentNature">
				<xsl:with-param name="boAdjNature" select="'PandL'"/>
			</xsl:call-template>
		</adjustmentNature>
	</xsl:template>
	<xsl:template name="newQuantity">
		<newQuantity>
			<xsl:value-of select="b:noNominal"/>
		</newQuantity>
	</xsl:template>
	<xsl:template name="newSecurity">
		<newSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</newSecurity>
	</xsl:template>
	<xsl:template name="newSecurityDepositaryAccount">
	<xsl:variable name="index" select="@index"/>
				<xsl:choose>
					<xsl:when test="../b:depositoryTo !=''">
					<newSecurityDepositaryAccount>
						<infra:code>
						<xsl:choose>
							<xsl:when test="../b:subAccountToTypeList/b:subAccountToType[@index=$index] !='' and ../b:subAccountToTypeList/b:subAccountToType[@index=$index] = $subAccountNature and b:subAccTo">
								<xsl:value-of select="concat(../b:depositoryTo,'_',b:subAccTo)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../b:depositoryTo"/>
							</xsl:otherwise>
						</xsl:choose>
						</infra:code>
						</newSecurityDepositaryAccount>
					</xsl:when>
				</xsl:choose>
			
	</xsl:template>
	<xsl:template name="oldQuantity">
		<oldQuantity>
			<xsl:value-of select="format-number(b:noNominal  * (-1),$decimalformat,'nan2zero')"/>
		</oldQuantity>
	</xsl:template>
	<xsl:template name="oldSecurity">
		<oldSecurity>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</oldSecurity>
	</xsl:template>
	<xsl:template name="oldSecurityDepositaryAccount">
	<xsl:variable name="index" select="@index"/>
		<xsl:choose>
					<xsl:when test="b:depository !=''">
					<oldSecurityDepositaryAccount>
						<infra:code>
						<xsl:choose>
							<xsl:when test="../b:subAccountFromTypeList/b:subAccountFromType[@index=$index] !='' and ../b:subAccountFromTypeList/b:subAccountFromType[@index=$index] = $subAccountNature and b:subAccount">
								<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:depository"/>
							</xsl:otherwise>
						</xsl:choose>
						</infra:code>
						</oldSecurityDepositaryAccount>
					</xsl:when>
				</xsl:choose>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../b:tapSlvPtfFrm != ''">
						<xsl:value-of select="../b:tapSlvPtfFrm"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcct"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="remark">
		<remark>
			<xsl:variable name="remark">
				<xsl:for-each select="../b:custNarrativeList/b:custNarrative">
					<xsl:value-of select="concat(.,' ')"/>
				</xsl:for-each>
			</xsl:variable>
			<xsl:value-of select="substring($remark,1,80)"/>
		</remark>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="index" select="@index"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="../b:tapOperCode and ../b:tapOperCode != ''">
					<xsl:value-of select="concat(../b:tapOperCode,'_','ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('ST_O_',../b:id,'_',b:securityNo,'_',b:depository,'_',$index,$COMPANY_POSTFIX_SEPARATOR,../b:companyMnemonic)"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:value-of select="../b:tradeDate"/>
		</transactionDate>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="../b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="adjustmentPortfolio">
		<adjustmentPortfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../b:tapSlvPtfTo != ''">
						<xsl:value-of select="../b:tapSlvPtfTo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityAcct"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</adjustmentPortfolio>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'POS_TFR_DEPTODEP'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyoldSecCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accruedInterestAmount"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="adjustmentCounter"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="coaReference"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="communication"/>
	<xsl:template name="initiator"/>
	<xsl:template name="newSecurityCcyPositionCcyExchangeRate"/>
	<xsl:template name="newSecurityNetAmount"/>
	<xsl:template name="newSecurityPositionCriteria1"/>
	<xsl:template name="newSecurityPositionCriteria2"/>
	<xsl:template name="newSecurityPositionCriteria3"/>
	<xsl:template name="newSecurityPositionCurrency"/>
	<xsl:template name="notepad"/>
	<xsl:template name="oldCcyGrossAmount"/>
	<xsl:template name="oldCcyNetAmount"/>
	<xsl:template name="oldCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="oldPrice"/>
	<xsl:template name="oldSecurityPositionCriteria1"/>
	<xsl:template name="oldSecurityPositionCriteria2"/>
	<xsl:template name="oldSecurityPositionCriteria3"/>
	<xsl:template name="oldSecurityPositionCurrency"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="status"/>
	<xsl:template name="subType"/>
	<xsl:template name="supplementaryAmount"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="typeInstrument"/>
	<xsl:template name="adjBoPortfolio">
		<adjBoPortfolio>
			<infra:code>
				<xsl:if test="../b:tapSlvPtfTo != ''">
					<xsl:value-of select="../b:secAcctTo"/>
				</xsl:if>
			</infra:code>
		</adjBoPortfolio>
	</xsl:template>
	<xsl:template name="boPortfolio">
		<boPortfolio>
			<infra:code>
				<xsl:if test="../b:tapSlvPtfFrm != ''">
					<xsl:value-of select="../b:secAcctFrom"/>
				</xsl:if>
			</infra:code>
		</boPortfolio>
	</xsl:template>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:choose>
				<xsl:when test="../b:tapSlvPtfFrm != '' or ../b:tapSlvPtfTo != ''">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</splitPortfolio>
	</xsl:template>
	<xsl:template name="paymentDate"/>
	<xsl:template name="paymentStatus"/>
	<xsl:template name="settlementDate">
		<settlementDate>
			<xsl:value-of select="../b:valueDate"/>
		</settlementDate>
	</xsl:template>
	<xsl:template name="settlementStatus"/>
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