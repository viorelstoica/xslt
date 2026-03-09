<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:m="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="a b c d e f g h i j k l m" version="1.0">
	<xsl:template name="account1"/>
	<xsl:template name="account1CcyDepositCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDepositCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDepositCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="deposit">
		<deposit>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
						<xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../c:aatxncontext/b:aaArrangementId"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="depositCurrency"/>
	<xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../c:accountrecord/g:portfolioId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="referenceTransactionCode"/>
	<xsl:template name="reversalIndicator">
		<reversalIndicator>1</reversalIndicator>
	</xsl:template>
	<xsl:template name="reversedTransactionCode">
		<reversedTransactionCode>
			<xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
	            <xsl:choose>
	                <xsl:when test="d:activity = 'DEPOSITS-CAPITALISE-SCHEDULE'">
	                    <xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-2')"/>
	                </xsl:when>
	                <xsl:otherwise>
	                    <xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic)"/>
	                </xsl:otherwise>
	            </xsl:choose>
			</xsl:when>
			<xsl:otherwise>
			 	<xsl:choose>
	                <xsl:when test="d:activity = 'DEPOSITS-CAPITALISE-SCHEDULE'">
	                    <xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-2')"/>
	                </xsl:when>
	                <xsl:otherwise>
	                    <xsl:value-of select="../c:aatxncontext/b:aaArrangementId"/>
	                </xsl:otherwise>
	            </xsl:choose>
			</xsl:otherwise>
	 	</xsl:choose>
		</reversedTransactionCode>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="../c:aatxncontext/b:aaArrActivityId"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
		    <xsl:choose>
		      <xsl:when test="../c:aatxncontext/b:aaArrStatus = 'AUTH-FWD'"> 
	                <xsl:call-template name="statusTranslation">
	                    <xsl:with-param name="boStatus" select="'PLACED'"/>
	                </xsl:call-template>		      
		      </xsl:when>
		      <xsl:otherwise>
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
                    </xsl:call-template>    		      
		      </xsl:otherwise>
		    </xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
				<xsl:choose>
					<xsl:when test="d:activity = 'DEPOSITS-CAPITALISE-SCHEDULE'">
						<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-2','_R')"/>
					</xsl:when>
					<xsl:otherwise>
					    <xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'_R')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="d:activity = 'DEPOSITS-CAPITALISE-SCHEDULE'">
						<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-2','_R')"/>
					</xsl:when>
					<xsl:otherwise>
					    <xsl:value-of select="concat(../c:aatxncontext/b:aaArrangementId,'_R')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<xsl:choose>
			<xsl:when test="d:effectiveDate != d:tradeDate">
				<xsl:if test="d:tradeDate and d:tradeDate != ''">
					<transactionDate>
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="d:tradeDate"/>
						</xsl:call-template>
					</transactionDate>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="d:effectiveDate and d:effectiveDate != ''">
					<transactionDate>
						<xsl:call-template name="xsdate">
							<xsl:with-param name="date" select="d:effectiveDate"/>
						</xsl:call-template>
					</transactionDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type"/>
	<xsl:template name="valueDate">
		<xsl:choose>
			<xsl:when test="d:activity = 'DEPOSITS-NEW-ARRANGEMENT'">
				<valueDate>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="../c:aatxncontext/b:aaEffectiveDate"/>
					</xsl:call-template>
				</valueDate>
			</xsl:when>
			<xsl:when test="d:txnSystemId = 'FT' and ../c:ftrecord/l:creditValueDate and ../c:ftrecord/l:creditValueDate != ''">
				<valueDate>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="../c:ftrecord/l:creditValueDate"/>
					</xsl:call-template>
				</valueDate>
			</xsl:when>
			<xsl:when test="d:txnSystemId = 'AAAA' and d:effectiveDate and d:effectiveDate != ''">
				<valueDate>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="d:effectiveDate"/>
					</xsl:call-template>
				</valueDate>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:value-of select="'0'"/>
		</referenceNature>
	</xsl:template>
	<xsl:template name="commonReference"/>
	<xsl:template name="accruedInterestAmount">
		<accruedInterestAmount>
			<xsl:value-of select="'0'"/>
		</accruedInterestAmount>
	</xsl:template>
	<xsl:template name="depositAmount">
		<depositAmount>0</depositAmount>
	</xsl:template>
	<xsl:template name="depositInterestRate"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="renewalAmount"/>
	<xsl:template name="renewalEndDate"/>
	<xsl:template name="renewalInterestrate"/>
	<xsl:template name="renewalMode"/>
	<xsl:template name="renewalPeriod"/>
	<xsl:template name="renewalPeriodNumber"/>
	<xsl:template name="renewalTreatment"/>
	<xsl:template name="lockNature"/>
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