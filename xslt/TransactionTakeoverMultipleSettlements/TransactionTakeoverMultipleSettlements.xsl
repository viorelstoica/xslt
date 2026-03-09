<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
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
		<GenericCOA>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TransactionTakeoverMultipleSettlements',b:diaryId)"/>
			</xsl:attribute>
			<!-- Transaction status: opStatus -->
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>

			<!-- Loop through optionDescGroup -->
			<xsl:for-each select="b:optionDescGroup">
				<xsl:variable name="optionDescGroupIndex" select="@index"/>
				<xsl:variable name="intElectedDateSubGroupIndex">
					<xsl:for-each select="b:intElectedDateSubGroup/@index">
						<xsl:sort data-type="number" order="ascending" select="."/>
						<xsl:if test="position()=last()">
							<xsl:value-of select="."/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:if test="b:optionNom and b:optionNom != '0' and b:optionNom &gt; ../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:optionNom and not(../b:optStatus = 'COMPLETED'   and (b:optionNom = ../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:optionNom or not(../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:optionNom))) or not(../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:optionNom) or ../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:optionNom=''">
					<xsl:choose>
						<xsl:when test="b:entitlementAmt and number(b:entitlementAmt) != '0' and (b:entitlementAmt != ../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:entitlementAmt or not(b:entitlementAmt != ../../../c:PreviousEvent/b:TransactionEntitlement/b:optionDescGroup[@index = $optionDescGroupIndex]/b:entitlementAmt))">
							<!--SELL-->

							<xsl:for-each select="b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
								<xsl:call-template name="mappingSell">
									<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
									<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
									<xsl:with-param name="opStatus" select="$opStatus"/>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:when>
						<xsl:when test="not(b:entitlementAmt) or number(b:entitlementAmt) = '0'">
							<!--LAPSE-->

							<xsl:for-each select="b:intElectedDateSubGroup[@index = $intElectedDateSubGroupIndex]/b:intElectedDate">
								<xsl:call-template name="mappingLapse">
									<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
									<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
									<xsl:with-param name="opStatus" select="$opStatus"/>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
		</GenericCOA>
	</xsl:template>

	<xsl:template name="mappingSell">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<xsl:param name="opStatus"/>
		<DataGroup>
			<Sell>
				<xsl:call-template name="addAttributesDescriptionAndSequenceNumber"/>
				<xsl:call-template name="account1"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account1NetAmount"/>
				<xsl:call-template name="account2"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account2NetAmount"/>
				<xsl:call-template name="account3"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate"/>
				<xsl:call-template name="account3NetAmount"/>
				<xsl:call-template name="accountingCode"/>
				<xsl:call-template name="accountingDate">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
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
				<xsl:call-template name="reversalIndicator">
					<xsl:with-param name="opStatus" select="$opStatus"/>
				</xsl:call-template>
				<xsl:call-template name="reversedTransactionCode"/>
				<xsl:call-template name="security"/>
				<xsl:call-template name="securityCcyNetAmount"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="sourceSystemCode"/>
				<xsl:call-template name="splitPortfolio"/>
				<xsl:call-template name="status"/>
				<xsl:call-template name="subType"/>
				<xsl:call-template name="supplementaryAmount"/>
				<xsl:call-template name="tradeCcyGrossAmount"/>
				<xsl:call-template name="tradeCcyNetAmount"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="tradeCurrency"/>
				<xsl:call-template name="tradePrice"/>
				<xsl:call-template name="tradeQuantity">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionCode">
					<xsl:with-param name="opStatus" select="$opStatus"/>
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionDate">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionFeesTaxesCounter"/>
				<xsl:call-template name="type"/>
				<xsl:call-template name="typeInstrument"/>
				<xsl:call-template name="valueDate"/>
				<xsl:call-template name="userDefinedField"/>
				<xsl:call-template name="mbFields"/>
			</Sell>
		</DataGroup>
	</xsl:template>

	<xsl:template name="mappingLapse">
		<xsl:param name="intElectedDateSubGroupIndex"/>
		<xsl:param name="optionDescGroupIndex"/>
		<xsl:param name="opStatus"/>
		<DataGroup>
			<Sell>
				<xsl:call-template name="addAttributesDescriptionAndSequenceNumber"/>
				<xsl:call-template name="account1_Lapse"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Lapse"/>
				<xsl:call-template name="account1NetAmount_Lapse"/>
				<xsl:call-template name="account2_Lapse"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Lapse"/>
				<xsl:call-template name="account2NetAmount_Lapse"/>
				<xsl:call-template name="account3_Lapse"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Lapse"/>
				<xsl:call-template name="account3NetAmount_Lapse"/>
				<xsl:call-template name="accountingCode_Lapse"/>
				<xsl:call-template name="accountingDate_Lapse">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="accruedInterestAmount_Lapse"/>
				<xsl:call-template name="accruedInterestCounter_Lapse"/>
				<xsl:call-template name="cashPortfolio_Lapse"/>
				<xsl:call-template name="coaReference_Lapse"/>
				<xsl:call-template name="commonReference_Lapse"/>
				<xsl:call-template name="communication_Lapse"/>
				<xsl:call-template name="depositaryAccount_Lapse"/>
				<xsl:call-template name="exDate_Lapse"/>
				<xsl:call-template name="initiator_Lapse"/>
				<xsl:call-template name="notepad_Lapse"/>
				<xsl:call-template name="portfolio_Lapse"/>
				<xsl:call-template name="portfolioManager_Lapse"/>
				<xsl:call-template name="positionCriteria1_Lapse"/>
				<xsl:call-template name="positionCriteria2_Lapse"/>
				<xsl:call-template name="positionCriteria3_Lapse"/>
				<xsl:call-template name="remark_Lapse"/>
				<xsl:call-template name="reversalIndicator_Lapse">
					<xsl:with-param name="opStatus" select="$opStatus"/>
				</xsl:call-template>
				<xsl:call-template name="reversedTransactionCode_Lapse"/>
				<xsl:call-template name="security_Lapse"/>
				<xsl:call-template name="securityCcyNetAmount_Lapse"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Lapse"/>
				<xsl:call-template name="sourceSystemCode_Lapse"/>
				<xsl:call-template name="splitPortfolio_Lapse"/>
				<xsl:call-template name="status_Lapse"/>
				<xsl:call-template name="subType_Lapse"/>
				<xsl:call-template name="supplementaryAmount_Lapse"/>
				<xsl:call-template name="tradeCcyGrossAmount_Lapse"/>
				<xsl:call-template name="tradeCcyNetAmount_Lapse"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Lapse"/>
				<xsl:call-template name="tradeCurrency_Lapse"/>
				<xsl:call-template name="tradePrice_Lapse"/>
				<xsl:call-template name="tradeQuantity_Lapse">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionCode_Lapse">
					<xsl:with-param name="opStatus" select="$opStatus"/>
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionDate_Lapse">
					<xsl:with-param name="intElectedDateSubGroupIndex" select="$intElectedDateSubGroupIndex"/>
					<xsl:with-param name="optionDescGroupIndex" select="$optionDescGroupIndex"/>
				</xsl:call-template>
				<xsl:call-template name="transactionFeesTaxesCounter_Lapse"/>
				<xsl:call-template name="type_Lapse"/>
				<xsl:call-template name="typeInstrument_Lapse"/>
				<xsl:call-template name="valueDate_Lapse"/>
				<xsl:call-template name="userDefinedField_Lapse"/>
				<xsl:call-template name="mbFields_Lapse"/>
			</Sell>
		</DataGroup>
	</xsl:template>

	<!--Template to add description and sequence number attribute to Sell and Lapse tags-->
	<xsl:template name="addAttributesDescriptionAndSequenceNumber">
		<xsl:attribute name="description">
			<xsl:value-of select="concat('TransactionTakeoverMultipleSettlements.xsl+', name(/*), '+', ../../../b:eventCommon/ns0:eventId, '+', ../../../b:eventCommon/ns0:creationTime)"/>
		</xsl:attribute>
		<xsl:attribute name="sequenceNumber">
			<xsl:call-template name="calcSeqNum">
				<xsl:with-param name="creationTime">
					<xsl:value-of select="../../../b:eventCommon/ns0:creationTime"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\..\..\Users\bsfaizahamed\Documents\Mani\TransactionRights.xml" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0"
		          profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no"
		          validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
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