<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockingTransactionCOA"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockingTransactionCOA" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockingTransactionCOA" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransactionCOA" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test=" $opStatus = 'INPUT-INPUT' or $opStatus = 'INPUT-DELETE'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:when test=" $opStatus = 'INPUT-AUTHORISE'">
					<xsl:value-of select="b:PayDateJoin"/>
				</xsl:when>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:choose>
   		<xsl:when test="b:depository != ''">
		<depositaryAccount>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
					<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:depository"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
		</depositaryAccount>
		</xsl:when>
   </xsl:choose>
	</xsl:template>
	<xsl:template name="lockingDate">
		<lockingDate>
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test=" $opStatus = 'INPUT-INPUT' or $opStatus = 'INPUT-DELETE'">
					<xsl:value-of select="b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:when test=" $opStatus = 'INPUT-AUTHORISE'">
					<xsl:value-of select="b:PayDateJoin"/>
				</xsl:when>
			</xsl:choose>
		</lockingDate>
	</xsl:template>
	<xsl:template name="lockingUnlocking">
		<lockingUnlocking>
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test=" $opStatus = 'INPUT-INPUT'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test=" $opStatus = 'INPUT-AUTHORISE' or $opStatus = 'INPUT-DELETE'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
			</xsl:choose>
		</lockingUnlocking>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolioNo"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:qualifyHolding"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="concat(b:id,'LOCK')"/>
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
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="externalSequenceNo">
			<xsl:call-template name="calcSeqNum">
				<xsl:with-param name="creationTime">
					<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
					<xsl:choose>
						<xsl:when test=" $opStatus = 'INPUT-INPUT'">
							<xsl:value-of select=" concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'B1_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:when test=" $opStatus = 'INPUT-AUTHORISE'">
							<xsl:value-of select=" concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'B2_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:when test=" $opStatus = 'INPUT-DELETE'">
							<xsl:value-of select=" concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'B3_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test=" $opStatus = 'INPUT-INPUT'">
							<xsl:value-of select=" concat($externalSequenceNo,'_','B1_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:when test=" $opStatus = 'INPUT-AUTHORISE'">
							<xsl:value-of select=" concat($externalSequenceNo,'_','B2_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:when test=" $opStatus = 'INPUT-DELETE'">
							<xsl:value-of select=" concat($externalSequenceNo,'_','B3_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionCurrency"/>
	<xsl:template name="valueDate"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="LockingTransactionCOACode"/>
	<xsl:template name="lockingType"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="remark"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="type"/>
	<xsl:template name="validityDate">
		<xsl:variable name="opStatus">
			<xsl:call-template name="operationStatus">
				<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
				<xsl:with-param name="recordStatus" select="b:recordStatus"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test=" $opStatus = 'INPUT-INPUT'">
				<validityDate>
					<xsl:value-of select="b:PayDateJoin"/>
				</validityDate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="endDate"/>
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