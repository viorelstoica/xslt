<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:a="http://www.temenos.com/T24/AaActivityExtractorService/AaArrInterestRec" xmlns:b="http://www.temenos.com/T24/AaActivityExtractorService/AaTransactionContext"
                xmlns:c="http://www.temenos.com/T24/event/AAAExtractor/AAAFlow" xmlns:d="http://www.temenos.com/T24/AaActivityExtractorService/AaArrActivityRec" xmlns:e="http://www.temenos.com/T24/AaActivityExtractorService/AaProductRec"
                xmlns:f="http://www.temenos.com/T24/AaActivityExtractorService/AaAccountDetailsRec" xmlns:g="http://www.temenos.com/T24/AaActivityExtractorService/AaArrAccountRec"
                xmlns:h="http://www.temenos.com/T24/AaActivityExtractorService/AaArrSettlementRec" xmlns:i="http://www.temenos.com/T24/AaActivityExtractorService/AaArrengementRec" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:j="http://www.temenos.com/T24/AaActivityExtractorService/AaBillRec" xmlns:k="http://www.temenos.com/T24/AaActivityExtractorService/AaIntAccrualRec" xmlns:l="http://www.temenos.com/T24/AaActivityExtractorService/AaFtRecord"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="a b c d e f g h i j k l" version="1.0">
	
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
                  <xsl:value-of select="../c:settlementrecord/h:settPayInDetails/h:payinAccount"/>
              </infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDepositLoanCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDepositLoanCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDepositLoanCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate"/>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="depositLoan">
		<depositLoan>
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
		</depositLoan>
	</xsl:template>
	<xsl:template name="depositLoanCurrency"/>
	<xsl:template name="depositLoanCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="incomeFeesTaxesCounter"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
    <!--  compute the sum of AA repayments -->
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
    <xsl:template name="interestAmount">
        <xsl:variable name="paidBackPrincipalInterest">
          <xsl:call-template name="paidBackInterest">
              <xsl:with-param name="interestType">PRINCIPALINT</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aaArrActivityId" select="../c:aatxncontext/b:aaArrActivityId"/>
        <interestAmount>
            <xsl:choose>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT'">
                    <xsl:variable name="repayAmount">
                        <xsl:call-template name="sumAAPayments">
                            <xsl:with-param name="nodeSet" select="../c:billdetails/j:billProperyDetails[j:property = 'PRINCIPALINT' and starts-with(j:repayRef, $aaArrActivityId) ]"/>
                        </xsl:call-template>
                    </xsl:variable>
                    <xsl:value-of select="format-number(-1 * $repayAmount,$decimalformat,'nan2zero') "/>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-SETTLE-PAYOFF'">
                    <xsl:value-of select="format-number(-1 * (../c:billdetails[j:aaBillId=../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId]/j:billProperyDetails[j:property = 'PRINCIPALINT']/j:orPropAmount),$decimalformat,'nan2zero')"/>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.CURRENT.BALANCES'">
                    <xsl:value-of select="-1 * $paidBackPrincipalInterest"/>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </interestAmount>
    </xsl:template>
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
				<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,$COMPANY_POSTFIX_SEPARATOR,../c:aatxncontext/b:aaCompanyMnemonic,'-I')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(../c:aatxncontext/b:aaArrActivityId,'-I')"/>
			</xsl:otherwise>
		</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
        <xsl:variable name="aaArrActivityId1" select="../c:aatxncontext/b:aaArrActivityId"/>
        <xsl:variable name="var_billId1">
            <xsl:value-of select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
        </xsl:variable>
        <transactionDate>
            <xsl:choose>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT' or d:activity = 'LENDING-APPLYPAYMENT-PR.INTEREST'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="../c:billdetails[j:billProperyDetails/j:property = 'PRINCIPALINT' and starts-with(j:billProperyDetails/j:repayRef,$aaArrActivityId1)]/j:actualPayDate"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-SETTLE-PAYOFF'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="../c:billdetails[j:aaBillId = $var_billId1]/j:actualPayDate"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.CURRENT.BALANCES'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="d:effectiveDate"/>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
        </transactionDate>
	</xsl:template>
	<xsl:template name="transactionFeesTaxesCounter"/>
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:value-of select="'AA_LendingInterest'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
        <xsl:variable name="aaArrActivityId1" select="../c:aatxncontext/b:aaArrActivityId"/>
        <xsl:variable name="var_billId1">
            <xsl:value-of select="../c:recaccountdetails/f:actBillDetails[f:billType = 'PAYOFF']/f:billId"/>
        </xsl:variable>
        <valueDate>
            <xsl:choose>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.REPAYMENT' or d:activity = 'LENDING-APPLYPAYMENT-PR.INTEREST'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="../c:billdetails[j:billProperyDetails/j:property = 'PRINCIPALINT' and starts-with(j:billProperyDetails/j:repayRef,$aaArrActivityId1)]/j:financialDate"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-SETTLE-PAYOFF'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="../c:billdetails[j:aaBillId = $var_billId1]/j:financialDate"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="d:activity = 'LENDING-APPLYPAYMENT-PR.CURRENT.BALANCES'">
                    <xsl:call-template name="xsdate">
                        <xsl:with-param name="date" select="../c:ftrecord/l:creditValueDate"/>
                    </xsl:call-template>
                </xsl:when>
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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