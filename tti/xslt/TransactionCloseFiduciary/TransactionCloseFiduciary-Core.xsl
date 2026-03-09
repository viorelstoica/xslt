<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrder" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrder"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrder" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrder" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">

	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:drawdownAcct"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyDepositCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyDepositCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyDepositCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:choose>
				<xsl:when test="b:fidType = 'FIXED'">
				    <xsl:choose>
				        <xsl:when test="b:earlyMatDate and b:earlyMatDate != ''">
                             <xsl:value-of select="b:earlyMatDate"/>		        
				        </xsl:when>
				        <xsl:otherwise>
		                     <xsl:call-template name="xsdate">
		                          <xsl:with-param name="date" select="b:maturityDate"/>
		                     </xsl:call-template>				        
				        </xsl:otherwise>
				    </xsl:choose>
				</xsl:when>
				<xsl:otherwise>
                     <xsl:value-of select="b:prinChangeGroup[b:prinChange = - ../b:amount]/b:changeDate"/>
				</xsl:otherwise>
			</xsl:choose>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="contractNumber"/>
	<xsl:template name="counterparty"/>
	<xsl:template name="deposit">
		<deposit>
			<infra:code>
				<xsl:value-of select="concat(b:id, $COMPANY_POSTFIX_SEPARATOR, b:mnemonic)"/>
			</infra:code>
		</deposit>
	</xsl:template>
	<xsl:template name="depositCurrency">
		<depositCurrency>
			<infra:code>
				<xsl:value-of select="b:currencyCode"/>
			</infra:code>
		</depositCurrency>
	</xsl:template>
	<xsl:template name="depositCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="fusionRule"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:cusPortId"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="referenceTransactionCode"/>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="sourceSystemCode"/>
	<xsl:template name="status">
		<status>
			<xsl:choose>
				<xsl:when test="(b:earlyStatus = 'REQUESTED' or (b:prinChangeGroup[position()=last()]/b:changeStatus = 'REQUESTED' and b:reimburseReq = 'YES'))">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'RECEIVED'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="((../../c:PreviousEvent/b:FdFidOrder/b:earlyStatus != '' and (b:earlyStatus = '' or not(b:earlyStatus))) or     (../../c:PreviousEvent/b:FdFidOrder/b:reimburseReq != '' and (b:reimburseReq = '' or not(b:reimburseReq))))">
					<xsl:call-template name="statusTranslation">
						<xsl:with-param name="boStatus" select="'REJECTED'"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="trader"/>
	<xsl:template name="transactionCode">
		<transactionCode>
			<xsl:choose>
				<xsl:when test="(b:tapRefId = '' or not(b:tapRefId)) or
				                 ((b:earlyStatus = '' or not(b:earlyStatus)) and (b:reimburseReq = '' or not(b:reimburseReq)))
				                 and not(
					                 (../../c:PreviousEvent/b:FdFidOrder/b:earlyStatus != '' and (b:earlyStatus = '' or not(b:earlyStatus))) 
					                 or     
					                 (../../c:PreviousEvent/b:FdFidOrder/b:reimburseReq != '' and (b:reimburseReq = '' or not(b:reimburseReq)))
				                 )
				                 ">
					<xsl:value-of select="concat(b:id, $COMPANY_POSTFIX_SEPARATOR, b:mnemonic, '_BC')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="translate(b:tapRefId, '%', '_')"/>
				</xsl:otherwise>
			</xsl:choose>
		</transactionCode>
	</xsl:template>
	<xsl:template name="transactionDate">
		<transactionDate>
            <xsl:choose>
                <xsl:when test="b:fidType = 'FIXED'">
                    <xsl:choose>
                        <xsl:when test="b:earlyMatDate and b:earlyMatDate != ''">
                             <xsl:value-of select="b:earlyMatDate"/>                
                        </xsl:when>
                        <xsl:otherwise>
                             <xsl:call-template name="xsdate">
                                  <xsl:with-param name="date" select="b:maturityDate"/>
                             </xsl:call-template>                       
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select="b:prinChangeGroup[b:prinChange = - ../b:amount]/b:changeDate"/>
                </xsl:otherwise>
            </xsl:choose>
		</transactionDate>
	</xsl:template>
   <xsl:template name="transactionFeesTaxesCounter">
      <transactionFeesTaxesCounter>
         <amount>0</amount>
         <currency>
            <infra:code>
               <xsl:value-of select="b:currencyCode"/>
            </infra:code>
         </currency>
         <type>
            <infra:code>
               <xsl:call-template name="BPTranslation">
                   <xsl:with-param name="boBP" select="'BP4'"/>
               </xsl:call-template>
            </infra:code>
         </type>
      </transactionFeesTaxesCounter>
   </xsl:template>
   <xsl:template name="type">
       <type>
           <infra:code>FD_MATRE</infra:code>
       </type>      
    </xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
            <xsl:choose>
                <xsl:when test="b:fidType = 'FIXED'">
                    <xsl:choose>
                        <xsl:when test="b:earlyMatDate and b:earlyMatDate != ''">
                             <xsl:value-of select="b:earlyMatDate"/>                
                        </xsl:when>
                        <xsl:otherwise>
                             <xsl:call-template name="xsdate">
                                  <xsl:with-param name="date" select="b:maturityDate"/>
                             </xsl:call-template>                       
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select="b:prinChangeGroup[b:prinChange = - ../b:amount]/b:changeDate"/>
                </xsl:otherwise>
            </xsl:choose>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="accruedInterestAmount"/>
    <xsl:template name="referenceNature">
       <referenceNature>0</referenceNature>
    </xsl:template> 	
	<xsl:template name="commonReference"/>
    <xsl:template name="depositAmount">
		<depositAmount>
			<xsl:value-of select="b:amount"/>
		</depositAmount>
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
	<xsl:template name="interestAmount"/>
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