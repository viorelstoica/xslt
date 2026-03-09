<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">

    <xsl:template name="sumAAPayments">
          <xsl:param name="nodeSet" />
          <xsl:param name="tempSum" select="0" />
          <xsl:choose>
              <xsl:when test="not($nodeSet)">
                  <xsl:value-of select="$tempSum" />
              </xsl:when>
              <xsl:otherwise>
                  <xsl:variable name="currentNodeRepaymentValue">
                      <xsl:choose>
                          <xsl:when test="substring-before($nodeSet[1]/j:repayAmount,'!') = ''">
                              <xsl:value-of select="$nodeSet[1]/j:repayAmount"/>
                          </xsl:when>
                          <xsl:otherwise>
                              <xsl:value-of select="substring-before($nodeSet[1]/j:repayAmount,'!')" />
                          </xsl:otherwise>
                      </xsl:choose>
                  </xsl:variable>
                  <xsl:call-template name="sumAAPayments">
                      <xsl:with-param name="nodeSet" select="$nodeSet[position() > 1]" />
                      <xsl:with-param name="tempSum" select="$tempSum + $currentNodeRepaymentValue" />
                  </xsl:call-template>
              </xsl:otherwise>
          </xsl:choose>
      </xsl:template> 
      <!-- end template --> 
      
    <!-- This is not a field template but a template used to fetch a certain type of interest, used to compute variables below -->
    <xsl:template name="paidBackInterest"> 
        <xsl:param name="interestType"/>
        <xsl:variable name = "repayAmount" 
         select="../c:intaccrualrecords[k:intAccrualId = concat(../c:aatxncontext/b:aaArrangementId, '-', $interestType)]/k:totalAccrual[k:periodStart &lt; ../../c:aaarecord/d:effectiveDate 
                            and (not(k:periodEnd) or k:periodEnd &gt;= ../../c:aaarecord/d:effectiveDate)]/k:totRpyAmt"/>
        <xsl:choose>
            <xsl:when test="$repayAmount">
                <xsl:value-of select="$repayAmount"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'0'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  end interest fetching template  -->    
	<xsl:template name="account1">
        <account1>
            <infra:code>
                <xsl:choose>
                    <xsl:when test="d:txnSystemId = 'FT'">
                        <xsl:value-of select="../c:ftrecord/l:debitAcctNo"/>
                    </xsl:when>
                    <xsl:otherwise>
                    <xsl:value-of select="../c:settlementrecord/h:settPayInDetails/h:payinAccount"/>
                    </xsl:otherwise>
                </xsl:choose>
            </infra:code>
        </account1>
	</xsl:template>
	<xsl:template name="account1CcyLoanCcyExchangeRate">
		<account1CcyLoanCcyExchangeRate>
			<xsl:if test="d:txnSystemId = 'FT'">
				<xsl:value-of select="../c:ftrecord/l:customerRate"/>
			</xsl:if>
		</account1CcyLoanCcyExchangeRate>
	</xsl:template>
	<xsl:template name="account1NetAmount">
		<xsl:variable name="var_aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/>
		<account1NetAmount>
            <xsl:choose>
                <xsl:when test="d:txnSystemId = 'FT'">
                    <xsl:choose>
                        <xsl:when test="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]">
                            <xsl:call-template name="sumAAPayments">
                                <xsl:with-param name="nodeSet" select="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]/j:repayAmount"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL.DECREASE'">
                                    <xsl:value-of select="substring(../c:ftrecord/l:amountDebited,4)"/>                         
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:variable name="paidBackPrincipalInterest">
                                      <xsl:call-template name="paidBackInterest">
                                          <xsl:with-param name="interestType">PRINCIPALINT</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:variable>
                                    <xsl:variable name="paidBackPenaltyInterest">
                                      <xsl:call-template name="paidBackInterest">
                                          <xsl:with-param name="interestType">PENALTYINT</xsl:with-param>
                                      </xsl:call-template>
                                    </xsl:variable>                         
                                    <xsl:value-of select="substring(../c:ftrecord/l:amountDebited,4) - $paidBackPrincipalInterest - $paidBackPenaltyInterest"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="d:txnSystemId = 'AAAA'">
                    <xsl:value-of select="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]/j:repayAmount"/>
                </xsl:when>
            </xsl:choose>
		</account1NetAmount>
	</xsl:template>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyLoanCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyLoanCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="d:effectiveDate"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="loan">
		<loan>
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
		</loan>
	</xsl:template>
	<xsl:template name="loanCurrency">
		<loanCurrency>
			<infra:code>
				<xsl:value-of select="d:currency"/>
			</infra:code>
		</loanCurrency>
	</xsl:template>
	<xsl:template name="loanCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="loanInterestRate"/>
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
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode">
   	  <sourceSystemCode>
		 <xsl:value-of select="../c:aatxncontext/b:aaArrActivityId"/>
	  </sourceSystemCode>
    </xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
					<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-C')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-C')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="d:effectiveDate"/>
			</xsl:call-template>
		</transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'AA_PrincipalDecrease'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
        <xsl:variable name="var_aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/> 
        <valueDate>
             <xsl:choose>
                  <xsl:when test="d:txnSystemId = 'FT'">
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="../c:ftrecord/l:creditValueDate"/>
                        </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="../c:billdetails[j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId)]]/j:financialDate"/>
                        </xsl:call-template>         
                  </xsl:otherwise>
             </xsl:choose>
        </valueDate>
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
	<xsl:template name="expirationDate"/>
	<xsl:template name="loanAmount">
		<xsl:variable name="var_aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/>
		<loanAmount>
			<xsl:choose>
				<xsl:when test="d:txnSystemId = 'FT'">
					<xsl:choose>
						<xsl:when test="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]">
							<xsl:call-template name="sumAAPayments">
								<xsl:with-param name="nodeSet" select="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]/j:repayAmount"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
		                    <xsl:choose>
		                        <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.PRINCIPAL.DECREASE'">
		                            <xsl:value-of select="substring(../c:ftrecord/l:amountDebited,4)"/>                         
		                        </xsl:when>
		                        <xsl:otherwise>
		                            <xsl:variable name="paidBackPrincipalInterest">
		                              <xsl:call-template name="paidBackInterest">
		                                  <xsl:with-param name="interestType">PRINCIPALINT</xsl:with-param>
		                              </xsl:call-template>
		                            </xsl:variable>
		                            <xsl:variable name="paidBackPenaltyInterest">
		                              <xsl:call-template name="paidBackInterest">
		                                  <xsl:with-param name="interestType">PENALTYINT</xsl:with-param>
		                              </xsl:call-template>
		                            </xsl:variable>                         
		                            <xsl:value-of select="substring(../c:ftrecord/l:amountDebited,4) - $paidBackPrincipalInterest - $paidBackPenaltyInterest"/>
		                        </xsl:otherwise>
		                    </xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="d:txnSystemId = 'AAAA'">
					<xsl:value-of select="../c:billdetails/j:billProperyDetails[j:property = 'ACCOUNT' and starts-with(j:repayRef, $var_aaArrActivityId) ]/j:repayAmount"/>
				</xsl:when>
			</xsl:choose>
		</loanAmount>
	</xsl:template>
	<xsl:template name="interestAmount">
		<interestAmount>
			<xsl:value-of select="'0'"/>
		</interestAmount>
	</xsl:template>
	<xsl:template name="renewalAmount"/>
	<xsl:template name="renewalEndDate"/>
	<xsl:template name="renewalInterestRate"/>
	<xsl:template name="renewalMode"/>
	<xsl:template name="renewalPeriod"/>
	<xsl:template name="renewalPeriodNumber"/>
	<xsl:template name="renewalTreatment"/>
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