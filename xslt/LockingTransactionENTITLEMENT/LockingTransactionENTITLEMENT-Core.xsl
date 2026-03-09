<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockingTransactionCOA"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockingTransactionCOA" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockingTransactionCOA" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransactionCOA" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountingDate">
		<xsl:param name="isNewSecPres"/>
		<accountingDate>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="../../b:PayDateJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="transactionCode">
		<xsl:variable name="externalSequenceNo">
			<xsl:call-template name="calcSeqNum">
				<xsl:with-param name="creationTime">
					<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:param name="isNewSecPres"/>
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:choose>
						<xsl:when test="../../b:tapOperCode and ../../b:tapOperCode != ''">
							<xsl:value-of select=" concat(../../b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'LOCK_B1_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,b:newSecurity,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select=" concat($externalSequenceNo,'_','LOCK_B1_',../../b:id,$COMPANY_POSTFIX_SEPARATOR,b:newSecurity,$COMPANY_POSTFIX_SEPARATOR,../../b:CompanyMnemonicJoin) "/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="b:tapOperCode and b:tapOperCode != ''">
							<xsl:value-of select=" concat(b:tapOperCode,$COMPANY_POSTFIX_SEPARATOR,'B1_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select=" concat($externalSequenceNo,'_','B1_',b:id,$COMPANY_POSTFIX_SEPARATOR,b:CompanyMnemonicJoin) "/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="depositaryAccount">
		<xsl:param name="isNewSecPres"/>
		<depositaryAccount>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$isNewSecPres = 'Y'">
						<xsl:choose>
   							<xsl:when test="../../b:depository != ''">
								<xsl:choose>
									<xsl:when test="../../b:subAccountTypeList/b:subAccountType[@index=1] != '' and ../../b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and ../../b:subAccount != ''">
										<xsl:value-of select="concat(../../b:depository,'_',../../b:subAccount)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="../../b:depository"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
  						 </xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
   							<xsl:when test="b:depository != ''">
								<xsl:choose>
									<xsl:when test="b:subAccountTypeList/b:subAccountType[@index=1] != '' and b:subAccountTypeList/b:subAccountType[@index=1] = $subAccountNature and b:subAccount != ''">
										<xsl:value-of select="concat(b:depository,'_',b:subAccount)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="b:depository"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
   						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</depositaryAccount>
	</xsl:template>
	<xsl:template name="security">
		<xsl:param name="isNewSecPres"/>
		<security>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$isNewSecPres = 'Y'">
						<xsl:value-of select="b:newSecurity"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:securityNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="validityDate">
		<xsl:param name="isNewSecPres"/>
		<validityDate>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="../../b:PayDateJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</validityDate>
	</xsl:template>
	<xsl:template name="lockingUnlocking">
		<xsl:param name="isNewSecPres"/>
		<lockingUnlocking>
			<xsl:value-of select="'1'"/>
		</lockingUnlocking>
	</xsl:template>
	<xsl:template name="lockingDate">
		<xsl:param name="isNewSecPres"/>
		<lockingDate>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="../../b:PayDateJoin"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:PayDateJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</lockingDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<xsl:param name="isNewSecPres"/>
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$isNewSecPres = 'Y'">
						<xsl:value-of select="../../b:portfolioNo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:portfolioNo"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:param name="isNewSecPres"/>
		<quantity>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="b:nominal"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:blockNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="sourceSystemCode">
		<xsl:param name="isNewSecPres"/>
		<sourceSystemCode>
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="concat(../../b:id,'LOCK')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:id,'LOCK')"/>
				</xsl:otherwise>
			</xsl:choose>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<xsl:param name="isNewSecPres"/>
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
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
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="endDate"/>
	<xsl:template name="splitPortfolio">
		<splitPortfolio>
			<xsl:value-of select="'1'"/>
		</splitPortfolio>
	</xsl:template>
</xsl:stylesheet>