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
	<xsl:template match="b:TransactionEntitlement">
		<CorporateActionPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaSpinOff',b:diaryId)"/>
			</xsl:attribute>
			<!-- Transaction status: opStatus -->
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Cash part, for entitlementAmt -->
			<xsl:if test="b:optionDescGroup/b:entitlementAmt and b:optionDescGroup/b:entitlementAmt != 0">
				<xsl:call-template name="cashPart"/>
			</xsl:if>
			<!--Security part -->
			<xsl:apply-templates select="b:optionDescGroup[b:optionNom]">
				<xsl:with-param name="opStatus" select="$opStatus"/>
			</xsl:apply-templates>
		</CorporateActionPMS>
	</xsl:template>
	<!-- Template to match cash part with total net amount -->
	<xsl:template name="cashPart">
		<xsl:param name="opStatus"/>
		<xsl:if test="b:netAmtAccCur != 0">
			<DataGroup>
				<SpinOff>
					<Cash>
						<Link>
							<xsl:attribute name="description">
								<xsl:value-of select="concat('TransactionSpinOff.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
							</xsl:attribute>
							<xsl:attribute name="sequenceNumber">
								<xsl:call-template name="calcSeqNum">
									<xsl:with-param name="creationTime">
										<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
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
							<xsl:call-template name="initiator"/>
							<xsl:call-template name="originalSecurityDepositaryAccount"/>
							<xsl:call-template name="originalSecurity"/>
							<xsl:call-template name="originalSecurityPositionCriteria1"/>
							<xsl:call-template name="originalSecurityPositionCriteria2"/>
							<xsl:call-template name="originalSecurityPositionCriteria3"/>
							<xsl:call-template name="originalSecurityPositionCurrency"/>
							<xsl:call-template name="positionCriteria1"/>
							<xsl:call-template name="positionCriteria2"/>
							<xsl:call-template name="positionCriteria3"/>
							<xsl:call-template name="positionCurrency"/>
							<xsl:call-template name="profitLossCounter"/>
							<xsl:call-template name="transactionDate"/>
							<xsl:call-template name="cashAmount"/>
							<xsl:call-template name="currentAccount"/>
							<xsl:call-template name="exDate"/>
							<xsl:call-template name="splitPortfolio"/>
						</Link>
					</Cash>
				</SpinOff>
			</DataGroup>
		</xsl:if>
		<!-- End of if net amount != 0 -->
	</xsl:template>
	<!-- End of cash part -->
	<!-- Template to match security part -->
	<xsl:template match="b:optionDescGroup[b:optionNom]">
		<xsl:param name="opStatus"/>
		<xsl:variable name="Index" select="@index"/>
		<!-- Call every security group -->
		<xsl:variable name="varBookCostPerc" select="b:bookCostPerc"/>
		<xsl:apply-templates select="b:newSecuritySubGroup">
			<xsl:with-param name="opStatus" select="$opStatus"/>
			<xsl:with-param name="newIndex" select="$Index"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- default for optionDescGroup -->
	<xsl:template match="b:newSecuritySubGroup">
		<xsl:param name="opStatus"/>
		<xsl:param name="newIndex"/>
		<xsl:param name="varBookCostPerc" select="../../b:bookCostPercGroup[$newIndex]/b:bookCostPerc"/>
		<xsl:choose>
			<xsl:when test="$varBookCostPerc and $varBookCostPerc != '' and $varBookCostPerc = 'YES'">
				<DataGroup>
					<SpinOff>
						<NewSecurity>
							<Link>
								<Proportional>
									<xsl:attribute name="description">
										<xsl:value-of select="concat('TransactionSpinOff.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
									</xsl:attribute>
									<xsl:attribute name="sequenceNumber">
										<xsl:call-template name="calcSeqNum">
											<xsl:with-param name="creationTime">
												<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:attribute>
									<xsl:call-template name="account1_NewSecurityProp"/>
									<xsl:call-template name="account1CcyPositionCcyExchangeRate_NewSecurityProp"/>
									<xsl:call-template name="account1NetAmount_NewSecurityProp"/>
									<xsl:call-template name="account2_NewSecurityProp"/>
									<xsl:call-template name="account2CcyPositionCcyExchangeRate_NewSecurityProp"/>
									<xsl:call-template name="account2NetAmount_NewSecurityProp"/>
									<xsl:call-template name="account3_NewSecurityProp"/>
									<xsl:call-template name="account3CcyPositionCcyExchangeRate_NewSecurityProp"/>
									<xsl:call-template name="account3NetAmount_NewSecurityProp"/>
									<xsl:call-template name="accountingCode_NewSecurityProp"/>
									<xsl:call-template name="accountingDate_NewSecurityProp"/>
									<xsl:call-template name="cashPortfolio_NewSecurityProp"/>
									<xsl:call-template name="commonReference_NewSecurityProp"/>
									<xsl:call-template name="contractNumber_NewSecurityProp"/>
									<xsl:call-template name="notepad_NewSecurityProp"/>
									<xsl:call-template name="portfolio_NewSecurityProp"/>
									<xsl:call-template name="portfolioManager_NewSecurityProp"/>
									<xsl:call-template name="remark_NewSecurityProp"/>
									<xsl:call-template name="reversalIndicator_NewSecurityProp"/>
									<xsl:call-template name="reversedTransactionCode_NewSecurityProp"/>
									<xsl:call-template name="sourceSystemCode_NewSecurityProp"/>
									<xsl:call-template name="status_NewSecurityProp"/>
									<xsl:call-template name="subType_NewSecurityProp"/>
									<xsl:call-template name="transactionCode_NewSecurityProp"/>
									<xsl:call-template name="transactionFeesTaxesCounter_NewSecurityProp"/>
									<xsl:call-template name="type_NewSecurityProp"/>
									<xsl:call-template name="typeInstrument_NewSecurityProp"/>
									<xsl:call-template name="valueDate_NewSecurityProp"/>
									<xsl:call-template name="userDefinedField_NewSecurityProp"/>
									<xsl:call-template name="mbFields_NewSecurityProp"/>
									<xsl:call-template name="coaReference_NewSecurityProp"/>
									<xsl:call-template name="initiator_NewSecurityProp"/>
									<xsl:call-template name="originalDepositaryAccount_NewSecurityProp"/>
									<xsl:call-template name="originalSecurity_NewSecurityProp"/>
									<xsl:call-template name="originalSecurityPositionCriteria1_NewSecurityProp"/>
									<xsl:call-template name="originalSecurityPositionCriteria2_NewSecurityProp"/>
									<xsl:call-template name="originalSecurityPositionCriteria3_NewSecurityProp"/>
									<xsl:call-template name="originalSecurityPositionCurrency_NewSecurityProp"/>
									<xsl:call-template name="positionCriteria1_NewSecurityProp"/>
									<xsl:call-template name="positionCriteria2_NewSecurityProp"/>
									<xsl:call-template name="positionCriteria3_NewSecurityProp"/>
									<xsl:call-template name="positionCurrency_NewSecurityProp"/>
									<xsl:call-template name="profitLossCounter_NewSecurityProp"/>
									<xsl:call-template name="transactionDate_NewSecurityProp"/>
									<xsl:call-template name="depositaryAccount_NewSecurityProp"/>
									<xsl:call-template name="exDate_NewSecurityProp"/>
									<xsl:call-template name="securityQuantity_NewSecurityProp"/>
									<xsl:call-template name="security_NewSecurityProp"/>
									<xsl:call-template name="splitPortfolio_NewSecurityProp"/>
									<xsl:call-template name="costProportion_NewSecurityProp"/>
								</Proportional>
							</Link>
						</NewSecurity>
					</SpinOff>
				</DataGroup>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="b:newSecurity != ../../b:securityNo">
					<DataGroup>
						<SpinOff>
							<NewSecurity>
								<Link>
									<Gross>
										<xsl:attribute name="description">
											<xsl:value-of select="concat('TransactionSpinOff.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
										</xsl:attribute>
										<xsl:attribute name="sequenceNumber">
											<xsl:call-template name="calcSeqNum">
												<xsl:with-param name="creationTime">
													<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:attribute>
										<xsl:call-template name="account1_NewSecurity"/>
										<xsl:call-template name="account1CcyPositionCcyExchangeRate_NewSecurity"/>
										<xsl:call-template name="account1NetAmount_NewSecurity"/>
										<xsl:call-template name="account2_NewSecurity"/>
										<xsl:call-template name="account2CcyPositionCcyExchangeRate_NewSecurity"/>
										<xsl:call-template name="account2NetAmount_NewSecurity"/>
										<xsl:call-template name="account3_NewSecurity"/>
										<xsl:call-template name="account3CcyPositionCcyExchangeRate_NewSecurity"/>
										<xsl:call-template name="account3NetAmount_NewSecurity"/>
										<xsl:call-template name="accountingCode_NewSecurity"/>
										<xsl:call-template name="accountingDate_NewSecurity"/>
										<xsl:call-template name="cashPortfolio_NewSecurity"/>
										<xsl:call-template name="commonReference_NewSecurity"/>
										<xsl:call-template name="contractNumber_NewSecurity"/>
										<xsl:call-template name="notepad_NewSecurity"/>
										<xsl:call-template name="portfolio_NewSecurity"/>
										<xsl:call-template name="portfolioManager_NewSecurity"/>
										<xsl:call-template name="remark_NewSecurity"/>
										<xsl:call-template name="reversalIndicator_NewSecurity"/>
										<xsl:call-template name="reversedTransactionCode_NewSecurity"/>
										<xsl:call-template name="sourceSystemCode_NewSecurity"/>
										<xsl:call-template name="status_NewSecurity"/>
										<xsl:call-template name="subType_NewSecurity"/>
										<xsl:call-template name="transactionCode_NewSecurity"/>
										<xsl:call-template name="transactionFeesTaxesCounter_NewSecurity"/>
										<xsl:call-template name="type_NewSecurity"/>
										<xsl:call-template name="typeInstrument_NewSecurity"/>
										<xsl:call-template name="valueDate_NewSecurity"/>
										<xsl:call-template name="userDefinedField_NewSecurity"/>
										<xsl:call-template name="mbFields_NewSecurity"/>
										<xsl:call-template name="coaReference_NewSecurity"/>
										<xsl:call-template name="initiator_NewSecurity"/>
										<xsl:call-template name="originalSecurityDepositaryAccount_NewSecurity"/>
										<xsl:call-template name="originalSecurity_NewSecurity"/>
										<xsl:call-template name="originalSecurityPositionCriteria1_NewSecurity"/>
										<xsl:call-template name="originalSecurityPositionCriteria2_NewSecurity"/>
										<xsl:call-template name="originalSecurityPositionCriteria3_NewSecurity"/>
										<xsl:call-template name="originalSecurityPositionCurrency_NewSecurity"/>
										<xsl:call-template name="positionCriteria1_NewSecurity"/>
										<xsl:call-template name="positionCriteria2_NewSecurity"/>
										<xsl:call-template name="positionCriteria3_NewSecurity"/>
										<xsl:call-template name="positionCurrency_NewSecurity"/>
										<xsl:call-template name="profitLossCounter_NewSecurity"/>
										<xsl:call-template name="transactionDate_NewSecurity"/>
										<xsl:call-template name="depositaryAccount_NewSecurity"/>
										<xsl:call-template name="exDate_NewSecurity"/>
										<xsl:call-template name="securityQuantity_NewSecurity"/>
										<xsl:call-template name="security_NewSecurity"/>
										<xsl:call-template name="securityUnitaryCostPrice_NewSecurity"/>
										<xsl:call-template name="splitPortfolio_NewSecurity"/>
									</Gross>
								</Link>
							</NewSecurity>
						</SpinOff>
					</DataGroup>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- End of template for Security part -->
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