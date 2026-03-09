<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
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
	<!-- Transaction status: opStatus -->
	<xsl:param name="opStatus">
		<xsl:call-template name="operationStatus">
			<xsl:with-param name="transactionStage" select="b:TransactionEntitlement/b:eventCommon/ns0:transactionStage"/>
			<xsl:with-param name="recordStatus" select="b:TransactionEntitlement/b:recordStatus"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:template match="b:TransactionEntitlement">
		<CorporateActionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionSinkingRedemption',b:diaryId)"/>
			</xsl:attribute>
			<!-- Call optionDescGroup -->
			<xsl:apply-templates select="b:optionDescGroup"/>
		</CorporateActionPMS>
	</xsl:template>
	<!-- BEG of template OptionDescGroup -->
	<xsl:template match="b:optionDescGroup">
		<xsl:variable name="CheckSinkingRedemptionPartial">
			<xsl:call-template name="CheckSinkingRedemptionPartial"/>
		</xsl:variable>
		<xsl:variable name="CheckSinkingRedemptionFinal">
			<xsl:call-template name="CheckSinkingRedemptionFinal"/>
		</xsl:variable>

		<!-- Check If satisfying SinkingRedemption(Partial) Criteria -->
		<xsl:if test="$CheckSinkingRedemptionPartial = 'Y' ">
			<xsl:call-template name="mappingSinkingRedemptionPartial"/>
		</xsl:if>
		<!-- Check If satisfying SinkingRedemption(Final) Criteria -->
		<xsl:if test="$CheckSinkingRedemptionFinal = 'Y' ">
			<xsl:call-template name="mappingSinkingRedemptionFinal"/>
		</xsl:if>
	</xsl:template>
	<!-- End of template OptionDescGroup -->

	<!-- BEG - SinkingRedemption(Partial) -->
	<xsl:template name="mappingSinkingRedemptionPartial">
		<DataGroup>
			<SinkingFunds>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionSinkingRedemption.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1"/>
				<xsl:call-template name="account1CcyPositionCcyExchangeRate"/>
				<xsl:call-template name="account1NetAmount"/>
				<xsl:call-template name="account2"/>
				<xsl:call-template name="account2CcyPositionCcyExchangeRate"/>
				<xsl:call-template name="account2NetAmount"/>
				<xsl:call-template name="account3"/>
				<xsl:call-template name="account3CcyPositionCcyExchangeRate"/>
				<xsl:call-template name="account3NetAmount"/>
				<xsl:call-template name="accountingCode"/>
				<xsl:call-template name="accountingDate"/>
				<xsl:call-template name="cashPortfolio"/>
				<xsl:call-template name="commonReference"/>
				<xsl:call-template name="contractNumber"/>
				<xsl:call-template name="notepad"/>
				<xsl:call-template name="portfolio"/>
				<xsl:call-template name="portfolioManager"/>
				<xsl:call-template name="remark"/>
				<xsl:call-template name="reversalIndicator"/>
				<xsl:call-template name="reversedTransactionCode"/>
				<xsl:call-template name="sourceSystemCode"/>
				<xsl:call-template name="status"/>
				<xsl:call-template name="subType"/>
				<xsl:call-template name="transactionCode"/>
				<xsl:call-template name="transactionFeesTaxesCounter"/>
				<xsl:call-template name="type"/>
				<xsl:call-template name="typeInstrument"/>
				<xsl:call-template name="valueDate"/>
				<xsl:call-template name="userDefinedField"/>
				<xsl:call-template name="mbFields"/>
				<xsl:call-template name="coaReference"/>
				<xsl:call-template name="depositaryAccount"/>
				<xsl:call-template name="exDate"/>
				<xsl:call-template name="initiator"/>
				<xsl:call-template name="positionCriteria1"/>
				<xsl:call-template name="redemptionAmount"/>
				<xsl:call-template name="redemptionNetAmount"/>
				<xsl:call-template name="security"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="splitPortfolio"/>
				<xsl:call-template name="transactionDate"/>	
			</SinkingFunds>
		</DataGroup>
	</xsl:template>
	<!-- END - SinkingRedemption(Partial) -->

	<!-- BEG - SinkingRedemption(Final) -->
	<xsl:template name="mappingSinkingRedemptionFinal">
		<DataGroup>
			<FinalMaturity>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionSinkingRedemption.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Final"/>	
				<xsl:call-template name="account1CcyRedemptionCcyExchangeRate_Final"/>
				<xsl:call-template name="account1NetAmount_Final"/>
				<xsl:call-template name="account2_Final"/>
				<xsl:call-template name="account2CcyRedemptionCcyExchangeRate_Final"/>
				<xsl:call-template name="account2NetAmount_Final"/>
				<xsl:call-template name="account3_Final"/>
				<xsl:call-template name="account3CcyRedemptionCcyExchangeRate_Final"/>
				<xsl:call-template name="account3NetAmount_Final"/>
				<xsl:call-template name="accountingCode_Final"/>
				<xsl:call-template name="accountingDate_Final"/>
				<xsl:call-template name="accruedInterests_Final"/>
				<xsl:call-template name="cashPortfolio_Final"/>
				<xsl:call-template name="commonReference_Final"/>
				<xsl:call-template name="contractNumber_Final"/>
				<xsl:call-template name="depositaryAccount_Final"/>
				<xsl:call-template name="exDate_Final"/>
				<xsl:call-template name="initiator_Final"/>
				<xsl:call-template name="notepad_Final"/>
				<xsl:call-template name="portfolio_Final"/>
				<xsl:call-template name="portfolioManager_Final"/>
				<xsl:call-template name="positionCriteria1_Final"/>
				<xsl:call-template name="positionCriteria2_Final"/>
				<xsl:call-template name="positionCriteria3_Final"/>
				<xsl:call-template name="redemptionCcyGrossAmount_Final"/>
				<xsl:call-template name="redemptionCcyNetAmount_Final"/>
				<xsl:call-template name="redemptionCcyPortfolioCcyExchangeRate_Final"/>
				<xsl:call-template name="redemptionCurrency_Final"/>
				<xsl:call-template name="redemptionPrice_Final"/>
				<xsl:call-template name="redemptionQuantity_Final"/>
				<xsl:call-template name="remark_Final"/>
				<xsl:call-template name="reversalIndicator_Final"/>
				<xsl:call-template name="reversedTransactionCode_Final"/>
				<xsl:call-template name="security_Final"/>
				<xsl:call-template name="securityCcyNetAmount_Final"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Final"/>
				<xsl:call-template name="sourceSystemCode_Final"/>
				<xsl:call-template name="splitPortfolio_Final"/>
				<xsl:call-template name="status_Final"/>
				<xsl:call-template name="subType_Final"/>
				<xsl:call-template name="transactionCode_Final"/>
				<xsl:call-template name="transactionDate_Final"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Final"/>
				<xsl:call-template name="type_Final"/>
				<xsl:call-template name="typeInstrument_Final"/>
				<xsl:call-template name="valueDate_Final"/>
				<xsl:call-template name="userDefinedField_Final"/>
				<xsl:call-template name="mbFields_Final"/>
				<xsl:call-template name="coaReference_Final"/>
			</FinalMaturity>
		</DataGroup>
	</xsl:template>
	<!-- END - SinkingRedemption(Final) -->
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