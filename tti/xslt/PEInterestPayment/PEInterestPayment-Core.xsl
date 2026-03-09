<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PECustomerTxn" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:account"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<account1NetAmount>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling ='YES'">
					<xsl:value-of select="b:eventGroup/b:interestAmount"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:saveEventGroup[b:saveEvent = 'RETURN OF CAPITAL']/b:saveInterestAmount"/>
				</xsl:otherwise>
			</xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:choose>
			<xsl:when test="$PEWorkflowhandling = 'YES'">
				<transactionCode>
					<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
				</transactionCode>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="b:saveEventGroup">
					<xsl:if test="b:saveEvent = 'RETURN OF CAPITAL'">
						<xsl:variable name="index" select="@index"/>
						<transactionCode>
							<xsl:value-of select="concat(../b:id,$COMPANY_POSTFIX_SEPARATOR,$index,'Int',$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
						</transactionCode>
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="currentAccount">
		<currentAccount>
			<infra:code>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling = 'YES'">
					<xsl:value-of select="b:actualPeSecurity"/>
				</xsl:when>
				<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="b:saveCapCallRefPeProductJoinGroup/b:saveUnitsIssuedPeProductJoin = 'YES'">
						<xsl:value-of select="b:actualPeSecurity"/>
					</xsl:when>
					<xsl:when test="b:saveCapCallRefPeProductJoinGroup/b:saveUnitsIssuedPeProductJoin = 'NO'">
						<xsl:value-of select="b:capitalSecurity"/>
					</xsl:when>
				</xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</currentAccount>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling ='YES'">
					<xsl:value-of select="b:eventGroup/b:eventDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:saveEventGroup[b:saveEvent = 'RETURN OF CAPITAL']/b:saveEventDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="balance">
		<balance>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling = 'YES'">
					<xsl:value-of select="b:eventGroup/b:interestAmount"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:saveEventGroup[b:saveEvent = 'RETURN OF CAPITAL']/b:saveInterestAmount"/>
				</xsl:otherwise>
			</xsl:choose>
		</balance>
	</xsl:template>
	<xsl:template name="interestAmount">
		<interestAmount>
			<xsl:value-of select="'1'"/>
		</interestAmount>
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
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:choose>
				<xsl:when test="$PEWorkflowhandling = 'YES'">
					<xsl:value-of select="b:eventGroup/b:valueDate"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:saveEventGroup[b:saveEvent = 'RETURN OF CAPITAL']/b:saveValueDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</valueDate>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="InterestCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="transactionCurrency"/>


	
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
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