<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- notes: Fees and taxes set on the first new security buy -->
	<xsl:template match="c:MultiTransactionEntitlement">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionEntitlement"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" name="BatchTransactionEntitlement">
			<xsl:apply-templates select="b:TransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" name="BatchMultiTransactionEntitlement">
			<xsl:apply-templates select="c:MultiTransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionEntitlement">
		<GenericCOA>
			<!-- Header -->
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaPurchase',b:diaryId)"/>
			</xsl:attribute>
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Count the number of optionDescGroup with securities -->
			<xsl:variable name="nbOptionDescGroupWithNewSecurity" select="count(child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup])"/>
			<!-- Call optionDescGroup -->
			<xsl:apply-templates select="b:optionDescGroup">
				<xsl:with-param name="opStatus" select="$opStatus"/>
				<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
			</xsl:apply-templates>
			<!-- End of: if eventType -->
		</GenericCOA>
	</xsl:template>
	<!-- Template for selected optionDescGroup -->
	<xsl:template match="b:optionDescGroup">
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<!-- Count the number of securities -->
		<xsl:variable name="nbNewSecuritySubGroup" select="count(child::b:newSecuritySubGroup)"/>
		<!-- Call every selected newSecuritySubGroup -->
		<xsl:apply-templates select="b:newSecuritySubGroup">
			<xsl:with-param name="opStatus" select="$opStatus"/>
			<!-- transaction status -->
			<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
			<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- End of: optionDescGroup -->
	<!-- Template for selected newSecuritySubGroup -->
	<xsl:template match="b:newSecuritySubGroup">
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<xsl:param name="nbNewSecuritySubGroup"/>
		<!-- Print record -->
		<DataGroup>
			<Buy>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionCoaPurchase.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account1NetAmount">
					<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
					<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
				</xsl:call-template>
				<xsl:call-template name="account2"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account2NetAmount"/>
				<xsl:call-template name="account3"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account3NetAmount"/>
				<xsl:call-template name="accountingCode"/>
				<xsl:call-template name="accountingDate"/>
				<xsl:call-template name="accruedInterestAmount"/>
				<xsl:call-template name="accruedInterestCounter"/>
				<xsl:call-template name="cashPortfolio"/>
				<xsl:call-template name="coaReference"/>
				<xsl:call-template name="commonReference"/>
				<xsl:call-template name="communication"/>
				<xsl:call-template name="depositaryAccount"/>
				<xsl:call-template name="exDate"/>
				<xsl:call-template name="initiator"/>
				<xsl:call-template name="notepad"/>
				<xsl:call-template name="portfolio"/>
				<xsl:call-template name="portfolioManager"/>
				<xsl:call-template name="positionCriteria1"/>
				<xsl:call-template name="positionCriteria2"/>
				<xsl:call-template name="positionCriteria3"/>
				<xsl:call-template name="remark"/>
				<xsl:call-template name="reversalIndicator"/>
				<xsl:call-template name="reversedTransactionCode"/>
				<xsl:call-template name="security"/>
				<xsl:call-template name="securityCcyNetAmount"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="sourceSystemCode"/>
				<xsl:call-template name="splitPortfolio"/>
				<xsl:call-template name="status"/>
				<xsl:call-template name="subType"/>
				<xsl:call-template name="supplementaryAmount"/>
				<xsl:call-template name="tradeCcyGrossAmount">
					<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
					<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
				</xsl:call-template>
				<xsl:call-template name="tradeCcyNetAmount"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="tradeCurrency"/>
				<xsl:call-template name="tradePrice"/>
				<xsl:call-template name="tradeQuantity"/>
				<xsl:call-template name="transactionCode"/>
				<xsl:call-template name="transactionDate"/>
				<xsl:call-template name="transactionFeesTaxesCounter"/>
				<xsl:call-template name="type"/>
				<xsl:call-template name="typeInstrument"/>
				<xsl:call-template name="valueDate"/>
				<xsl:call-template name="userDefinedField"/>
				<xsl:call-template name="mbFields"/>
			</Buy>
		</DataGroup>
	</xsl:template>
	<!-- End of: newSecuritySubGroup template -->
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