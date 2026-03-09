<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PaymentOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="account1">
	<xsl:if test="b:chargeAccount != '' and b:creditAccount != '' and b:chargeAccount = b:creditAccount">
		<account1>
		<infra:code>
			<xsl:value-of select="b:chargeAccount"/>
		</infra:code>
		</account1>
	</xsl:if>
	</xsl:template>
	<xsl:template name="account1NetAmount">
	<xsl:variable name="sum" select="sum(b:chargeAmountGroup/b:chargeAcCcyAmount)"/>
	<xsl:if test="b:chargeAccount != '' and b:creditAccount != '' and b:chargeAccount = b:creditAccount">
			<xsl:choose>
					<xsl:when test="$sum !='0'">
						<account1NetAmount>
							<xsl:value-of select="$sum"/>
						</account1NetAmount>
					</xsl:when>
					<xsl:otherwise>
						<account1NetAmount>
						<xsl:value-of select="'0'"/>
						</account1NetAmount>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
	</xsl:template>
	<xsl:template name="accountingCode">
		<accountingCode>
			<xsl:value-of select="b:id"/>
		</accountingCode>
	</xsl:template>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:paymentExecutionDate"/>
			</xsl:call-template>
		</accountingDate>
	</xsl:template>
   <xsl:template name="notepad">
       <xsl:if test="b:narrativeList/b:narrative">
            <notepad>
                <infra:date>
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="b:paymentExecutionDate"/>
                        </xsl:call-template> 
                </infra:date>
                <infra:note>
                    <xsl:value-of select="b:narrativeList/b:narrative"/>
                </infra:note>
                <infra:title>
                    <xsl:value-of select=" 'NARRATIVE' "/>
                </infra:title>
                <infra:type>
                    <infra:code>
                        <xsl:value-of select=" 'NARRATIVE' "/>
                    </infra:code>
                </infra:type>
            </notepad>
        </xsl:if>
        <xsl:if test="b:additionalInfoList/b:additionalInfo">
            <notepad>
                <infra:date>
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="b:paymentExecutionDate"/>
                        </xsl:call-template>           
                </infra:date>
                <infra:note>
                    <xsl:value-of select="b:additionalInfoList/b:additionalInfo"/>
                </infra:note>
                <infra:title>
                    <xsl:value-of select=" 'ADDITIONAL INFORMATION' "/>
                </infra:title>
                <infra:type>
                    <infra:code>
                        <xsl:value-of select=" 'ADDITIONAL_INFORMATION' "/>
                    </infra:code>
                </infra:type>
            </notepad>
        </xsl:if>
        <xsl:if test="b:debitAccountIban">
            <notepad>
                <infra:date>
                        <xsl:call-template name="xsdate">
                            <xsl:with-param name="date" select="b:paymentExecutionDate"/>
                        </xsl:call-template>             
                </infra:date>
                <infra:note>
                    <xsl:value-of select="b:debitAccountIban"/>
                </infra:note>
                <infra:title>
                    <xsl:value-of select=" 'DEBIT ACCOUNT IBAN' "/>
                </infra:title>
                <infra:type>
                    <infra:code>
                        <xsl:value-of select=" 'IBAN_CODE' "/>
                    </infra:code>
                </infra:type>
            </notepad>
        </xsl:if>
    </xsl:template>      
	<xsl:template name="portfolio">
        <portfolio>
            <infra:code>
				<xsl:choose>
					<xsl:when test="b:creditAccountPortfolioNoList/b:creditAccountPortfolioNo">
                		<xsl:value-of select="b:creditAccountPortfolioNoList/b:creditAccountPortfolioNo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="b:creditAccountSamHistId"/>
					</xsl:otherwise>
				</xsl:choose>
            </infra:code>
        </portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode">
		<sourceSystemCode>
			<xsl:value-of select="b:id"/>
		</sourceSystemCode>
	</xsl:template>
	<xsl:template name="status">
		<xsl:variable name="boStatus">
			<xsl:value-of select="b:currentState"/>
		</xsl:variable>
        <status>
            <xsl:choose>
                <xsl:when test="$boStatus = ''">
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'Placed'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="$boStatus = 'CancelOrder'">
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'REJECTED'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'Placed'"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </status>
	</xsl:template>
	<xsl:template name="transactionCode">
        <transactionCode>
                 <xsl:choose>
                     <xsl:when test="b:tapRefId and b:tapOperNature='IN'">
                         <xsl:value-of select="b:tapRefId"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="concat('PO_',b:id,'_C',$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                     </xsl:otherwise>
                 </xsl:choose>      
        </transactionCode>		
	</xsl:template>

	<xsl:template name="transactionFeesTaxesCounter">
	<xsl:variable name="sum" select="sum(b:chargeAmountGroup/b:chargeAcCcyAmount)"/>
	<xsl:if test="b:chargeAccount != '' and b:creditAccount != '' and b:chargeAccount = b:creditAccount">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$sum !='0'">
							<xsl:value-of select="$sum"/>
					</xsl:when>
					<xsl:otherwise>			
						<xsl:value-of select="'0'"/>	
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="b:chargeAccountCcy"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>CASH_OP_TOT_CHARGES</infra:code>
			</type>
		</transactionFeesTaxesCounter>
</xsl:if>
	</xsl:template>

	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$POSTFIX_TROPTYPE = 'Y'">
						<xsl:value-of select="concat('POR',$COMPANY_POSTFIX_SEPARATOR,b:paymentOrderProduct,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('POR',$COMPANY_POSTFIX_SEPARATOR,b:paymentOrderProduct)"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
	   <valueDate>
	        <xsl:choose>
	            <xsl:when test="b:creditValueDate">
	                <xsl:value-of select="b:creditValueDate"/>
	            </xsl:when>
	            <xsl:otherwise>
	                    <xsl:call-template name="xsdate">
                                 <xsl:with-param name="date" select="b:paymentExecutionDate"/>
                        </xsl:call-template>
	            </xsl:otherwise>
	        </xsl:choose>
        </valueDate>
	</xsl:template>
	<xsl:template name="currentAccount">
        <currentAccount>
            <infra:code>
                <xsl:value-of select="b:creditAccount"/>
            </infra:code>
        </currentAccount>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:creditAmount"/>
		</quantity>
	</xsl:template>
	<xsl:template name="transactionCurrency">
		<transactionCurrency>
			<infra:code>
				<xsl:value-of select="b:creditCurrency"/>
			</infra:code>
		</transactionCurrency>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:paymentExecutionDate"/>
			</xsl:call-template>
		</transactionDate>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	

	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	
			
	<xsl:template name="account3NetAmount"/>
	
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="commonReference"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="subType"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="transactionCcyGrossAmount"/>
	<xsl:template name="transactionCcyNetAmount"/>
	<xsl:template name="transactionCcyPortfolioCcyExchangeRate"/>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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