<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CorporateActionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- notes: F&T set on first new Security -->
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
		<CorporateActionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaOptionDividend',b:diaryId)"/>
			</xsl:attribute>
			<!-- Status -->
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Knowing if there is new security -->
			<xsl:variable name="nbOptionDescGroupWithNewSecurity" select="count(child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup])"/>
			<!-- Get nodes with a newSecuritySubGroup -->
			<xsl:variable name="nodesWithNewSecurity" select="child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup]"/>
			<!--Security part -->
			<xsl:apply-templates select="b:optionDescGroup">
				<xsl:with-param name="opStatus" select="$opStatus"/>
				<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
				<xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$nodesWithNewSecurity/@index"/>
			</xsl:apply-templates>
		</CorporateActionPMS>
	</xsl:template>
	<!-- Template optionDescGroup for all having an optionNom (option choosen) -->
	<xsl:template match="b:optionDescGroup">
		<xsl:param name="opStatus"/>
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<!-- indicates there are new securities -->
		<xsl:param name="idxFirstOptDescGroupWithNewSecu"/>
		<!-- index first optionDescGroup with newSecuritySubGroup -->
		<!-- Cash dividend if entitlementAmt -->
		<xsl:if test="b:entitlementAmt and b:entitlementAmt != 0 and (not(b:newSecuritySubGroup/b:newSecurity) or b:newSecuritySubGroup/b:newSecurity = '')">
			<DataGroup>
				<DividendOption>
					<cash>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionOptionDividend.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1"/>
						<xsl:call-template name="account1CcyDividendCcyExchangeRate"/>
						<xsl:call-template name="account1NetAmount"/>
						<xsl:call-template name="account2"/>
						<xsl:call-template name="account2CcyDividendCcyExchangeRate"/>
						<xsl:call-template name="account2NetAmount"/>
						<xsl:call-template name="account3"/>
						<xsl:call-template name="account3CcyDividendCcyExchangeRate"/>
						<xsl:call-template name="account3NetAmount"/>
						<xsl:call-template name="accountingCode"/>
						<xsl:call-template name="accountingDate"/>
						<xsl:call-template name="cashDividend"/>
						<xsl:call-template name="cashPortfolio"/>
						<xsl:call-template name="coaReference"/>
						<xsl:call-template name="commonReference"/>
						<xsl:call-template name="contractNumber"/>
						<xsl:call-template name="depositaryAccount"/>
						<xsl:call-template name="dividendCcyGrossAmount"/>
						<xsl:call-template name="dividendCcyNetAmount">
							<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
						</xsl:call-template>
						<xsl:call-template name="dividendCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="dividendCurrency"/>
						<xsl:call-template name="exDate"/>
						<xsl:call-template name="initiator"/>
						<xsl:call-template name="nominalOrUnit"/>
						<xsl:call-template name="notepad"/>
						<xsl:call-template name="remark"/>
						<xsl:call-template name="reversalIndicator"/>
						<xsl:call-template name="reversedTransactionCode"/>
						<xsl:call-template name="portfolio"/>
						<xsl:call-template name="portfolioManager"/>
						<xsl:call-template name="positionCriteria1"/>
						<xsl:call-template name="security"/>
						<xsl:call-template name="securityCcyNetAmount"/>
						<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
						<xsl:call-template name="sourceSystemCode"/>
						<xsl:call-template name="splitPortfolio"/>
						<xsl:call-template name="status"/>
						<xsl:call-template name="subType"/>
						<xsl:call-template name="transactionCode"/>
						<xsl:call-template name="transactionDate"/>
						<xsl:call-template name="transactionFeesTaxesCounter">
							<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
						</xsl:call-template>
						<xsl:call-template name="type"/>
						<xsl:call-template name="typeInstrument"/>
						<xsl:call-template name="valueDate"/>
						<xsl:call-template name="userDefinedField"/>
						<xsl:call-template name="mbFields"/>
					</cash>
				</DividendOption>
			</DataGroup>
		</xsl:if>
		<xsl:apply-templates select="b:newSecuritySubGroup">
			<xsl:with-param name="opStatus" select="$opStatus"/>
			<xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
			<xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$idxFirstOptDescGroupWithNewSecu"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- End of: b:optionDescGroup[b:optionNom] -->
	<xsl:template match="b:newSecuritySubGroup">
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<!-- indicates there are new securities -->
		<xsl:param name="idxFirstOptDescGroupWithNewSecu"/>
		<!-- index first optionDescGroup with newSecuritySubGroup -->
		<!-- Security part -->
		<xsl:if test="b:newSecurity and b:newSecurity!=''">
			<DataGroup>
				<DividendOption>
					<security>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionOptionDividend.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_Security"/>
						<xsl:call-template name="account1CcyPositionCcyExchangeRate_Security"/>
						<xsl:call-template name="account1NetAmount_Security"/>
						<xsl:call-template name="account2_Security"/>
						<xsl:call-template name="account2CcyPositionCcyExchangeRate_Security"/>
						<xsl:call-template name="account2NetAmount_Security"/>
						<xsl:call-template name="account3_Security"/>
						<xsl:call-template name="account3CcyPositionCcyExchangeRate_Security"/>
						<xsl:call-template name="account3NetAmount_Security"/>
						<xsl:call-template name="accountingCode_Security"/>
						<xsl:call-template name="accountingDate_Security"/>
						<xsl:call-template name="cashPortfolio_Security"/>
						<xsl:call-template name="commonReference_Security"/>
						<xsl:call-template name="contractNumber_Security"/>
						<xsl:call-template name="notepad_Security"/>
						<xsl:call-template name="portfolio_Security"/>
						<xsl:call-template name="portfolioManager_Security"/>
						<xsl:call-template name="remark_Security"/>
						<xsl:call-template name="reversalIndicator_Security"/>
						<xsl:call-template name="reversedTransactionCode_Security"/>
						<xsl:call-template name="sourceSystemCode_Security"/>
						<xsl:call-template name="status_Security"/>
						<xsl:call-template name="subType_Security"/>
						<xsl:call-template name="transactionCode_Security"/>
						<xsl:call-template name="transactionFeesTaxesCounter_Security">
							<xsl:with-param name="idxFirstOptDescGroupWithNewSecu" select="$idxFirstOptDescGroupWithNewSecu"/>
						</xsl:call-template>
						<xsl:call-template name="type_Security"/>
						<xsl:call-template name="typeInstrument_Security"/>
						<xsl:call-template name="valueDate_Security"/>
						<xsl:call-template name="userDefinedField_Security"/>
						<xsl:call-template name="mbFields_Security"/>
						<xsl:call-template name="coaReference_Security"/>
						<xsl:call-template name="initiator_Security"/>
						<xsl:call-template name="originalSecurityDepositaryAccount_Security"/>
						<xsl:call-template name="originalSecurity_Security"/>
						<xsl:call-template name="originalSecurityPositionCriteria1_Security"/>
						<xsl:call-template name="originalSecurityPositionCriteria2_Security"/>
						<xsl:call-template name="originalSecurityPositionCriteria3_Security"/>
						<xsl:call-template name="originalSecurityPositionCurrency_Security"/>
						<xsl:call-template name="positionCriteria1_Security"/>
						<xsl:call-template name="positionCriteria2_Security"/>
						<xsl:call-template name="positionCriteria3_Security"/>
						<xsl:call-template name="positionCurrency_Security"/>
						<xsl:call-template name="profitLossCounter_Security"/>
						<xsl:call-template name="transactionDate_Security"/>
						<xsl:call-template name="depositaryAccount_Security"/>
						<xsl:call-template name="exDate_Security"/>
						<xsl:call-template name="security_Security"/>
						<xsl:call-template name="splitPortfolio_Security"/>
						<xsl:call-template name="stockDividendQuantity_Security"/>
					</security>
				</DividendOption>
				<!-- if there is cash part due to a fraction, this is mapped again as an income to the original position/security -->
				<xsl:if test="b:cashFraction and b:fractionDisp ='PAY'">
	                <DividendOption>
	                    <cash>
	                        <xsl:attribute name="description">
	                            <xsl:value-of select="concat('TransactionOptionDividend.xsl+Cash Fraction+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
	                        </xsl:attribute>
	                        <xsl:attribute name="sequenceNumber">
	                            <xsl:call-template name="calcSeqNum">
	                                <xsl:with-param name="creationTime">
	                                    <xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
	                                </xsl:with-param>
	                            </xsl:call-template>
	                        </xsl:attribute>
	                        <xsl:call-template name="account1_securityCash"/>
	                        <xsl:call-template name="account1CcyDividendCcyExchangeRate_securityCash"/>
	                        <xsl:call-template name="account1NetAmount_securityCash"/>
	                        <xsl:call-template name="account2_securityCash"/>
	                        <xsl:call-template name="account2CcyDividendCcyExchangeRate_securityCash"/>
	                        <xsl:call-template name="account2NetAmount_securityCash"/>
	                        <xsl:call-template name="account3_securityCash"/>
	                        <xsl:call-template name="account3CcyDividendCcyExchangeRate_securityCash"/>
	                        <xsl:call-template name="account3NetAmount_securityCash"/>
	                        <xsl:call-template name="accountingCode_securityCash"/>
	                        <xsl:call-template name="accountingDate_securityCash"/>
	                        <xsl:call-template name="cashDividend_securityCash"/>
	                        <xsl:call-template name="cashPortfolio_securityCash"/>
	                        <xsl:call-template name="coaReference_securityCash"/>
	                        <xsl:call-template name="commonReference_securityCash"/>
	                        <xsl:call-template name="contractNumber_securityCash"/>
	                        <xsl:call-template name="depositaryAccount_securityCash"/>
	                        <xsl:call-template name="dividendCcyGrossAmount_securityCash"/>
	                        <xsl:call-template name="dividendCcyNetAmount_securityCash">
	                            <xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
	                        </xsl:call-template>
	                        <xsl:call-template name="dividendCcyPortfolioCcyExchangeRate_securityCash"/>
	                        <xsl:call-template name="dividendCurrency_securityCash"/>
	                        <xsl:call-template name="exDate_securityCash"/>
	                        <xsl:call-template name="initiator_securityCash"/>
	                        <xsl:call-template name="nominalOrUnit_securityCash"/>
	                        <xsl:call-template name="notepad_securityCash"/>
	                        <xsl:call-template name="remark_securityCash"/>
	                        <xsl:call-template name="reversalIndicator_securityCash"/>
	                        <xsl:call-template name="reversedTransactionCode_securityCash"/>
	                        <xsl:call-template name="portfolio_securityCash"/>
	                        <xsl:call-template name="portfolioManager_securityCash"/>
	                        <xsl:call-template name="positionCriteria1_securityCash"/>
	                        <xsl:call-template name="security_securityCash"/>
	                        <xsl:call-template name="securityCcyNetAmount_securityCash"/>
	                        <xsl:call-template name="securityCcyPortfolioCcyExchangeRate_securityCash"/>
	                        <xsl:call-template name="sourceSystemCode_securityCash"/>
	                        <xsl:call-template name="splitPortfolio_securityCash"/>
	                        <xsl:call-template name="status_securityCash"/>
	                        <xsl:call-template name="subType_securityCash"/>
	                        <xsl:call-template name="transactionCode_securityCash"/>
	                        <xsl:call-template name="transactionDate_securityCash"/>
	                        <xsl:call-template name="transactionFeesTaxesCounter_securityCash">
	                            <xsl:with-param name="nbOptionDescGroupWithNewSecurity" select="$nbOptionDescGroupWithNewSecurity"/>
	                        </xsl:call-template>
	                        <xsl:call-template name="type_securityCash"/>
	                        <xsl:call-template name="typeInstrument_securityCash"/>
	                        <xsl:call-template name="valueDate_securityCash"/>
	                        <xsl:call-template name="userDefinedField_securityCash"/>
	                        <xsl:call-template name="mbFields_securityCash"/>
	                    </cash>
	                </DividendOption>	
	            </xsl:if>			
			</DataGroup>
		</xsl:if>
	</xsl:template>
	<!-- End of: b:newSecuritySubGroup -->
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