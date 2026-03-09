<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="b:portfolio"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="reversalIndicator"/>
	<xsl:template name="reversedTransactionCode"/>
	<xsl:template name="status">
		<status>
             <xsl:variable name="opStatus">
               <xsl:call-template name="operationStatus">
                 <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
                 <xsl:with-param name="recordStatus" select="b:recordStatus"/>
               </xsl:call-template>
             </xsl:variable>  		
		     <xsl:choose>  
		          <xsl:when test="$opStatus = 'INPUT-AUTHORISE'"> 
		            <xsl:call-template name="statusTranslation">
		                <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
		            </xsl:call-template>		          
		          </xsl:when>
                  <xsl:when test="$opStatus = 'INPUT-DELETE'"> 
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'REJECTED'"/>
                    </xsl:call-template>                      
                  </xsl:when>		
                  <xsl:when test="$opStatus = 'INPUT-INPUT'"> 
                    <xsl:call-template name="statusTranslation">
                        <xsl:with-param name="boStatus" select="'SENT'"/>
                    </xsl:call-template>                      
                  </xsl:when>                          
		     </xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="transactionCode">
		<transactionCode>
            <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'BUY')"/>
                </xsl:otherwise>
            </xsl:choose>   	
		</transactionCode>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="'1'"/>
		</quantity>
	</xsl:template>
	<xsl:template name="security">
		<security>
			<infra:code>
	            <xsl:choose>
	                <xsl:when test="b:tapRefId">
	                    <xsl:value-of select="b:tapRefId"/>
	                </xsl:when>
	                <xsl:otherwise>
	                    <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
	                </xsl:otherwise>
	            </xsl:choose>       			
			</infra:code>
		</security>
	</xsl:template>
	<xsl:template name="account1">
		<account1>
			<infra:code>
				<xsl:value-of select="b:customerAccount"/>
			</infra:code>
		</account1>
	</xsl:template>
	<xsl:template name="account1CcyTradeCcyExchangeRate"/>
	<xsl:template name="account1NetAmount"/>
	<xsl:template name="account2"/>
	<xsl:template name="account2CcyTradeCcyExchangeRate"/>
	<xsl:template name="account2NetAmount"/>
	<xsl:template name="account3"/>
	<xsl:template name="account3CcyTradeCcyExchangeRate"/>
	<xsl:template name="account3NetAmount"/>
	<xsl:template name="accountingCode"/>
	<xsl:template name="accountingDate">
		<accountingDate>
			<xsl:value-of select="b:tradeDate"/>
		</accountingDate>
	</xsl:template>
	<xsl:template name="cashPortfolio"/>
	<xsl:template name="ContractNumber"/>
	<xsl:template name="notepad"/>
	<xsl:template name="portfolioManager"/>
	<xsl:template name="remark"/>
	<xsl:template name="sourceSystemCode">
	   <sourceSystemCode>
	          <xsl:value-of select="b:id"/>
	   </sourceSystemCode>
	</xsl:template>
	<xsl:template name="subType"/>
	<xsl:template name="transactionFeesTaxesCounter">
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP1'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP2'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP3'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	           <xsl:choose>
	               <xsl:when test="b:feeAmt">
                      <xsl:value-of select="b:feeAmt"/>	               
	               </xsl:when>
	               <xsl:otherwise>
                        <xsl:value-of select="'0'"/>
	               </xsl:otherwise>
	           </xsl:choose>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:feeCcy"/>
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
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP5'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
            <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP6'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP7'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP8'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP9'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>
	    <transactionFeesTaxesCounter>
	      <amount>
	        <xsl:value-of select="'0'"/>
	      </amount>
	      <currency>
	        <infra:code>
	          <xsl:value-of select="b:contractCcy"/>
	        </infra:code>
	      </currency>
	      <type>
	        <infra:code>
	          <xsl:call-template name="BPTranslation">
	            <xsl:with-param name="boBP" select="'BP10'"/>
	          </xsl:call-template>
	        </infra:code>
	      </type>
	    </transactionFeesTaxesCounter>	
      </xsl:template>	
	<xsl:template name="type">
		<type>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:productType='ACCUMULATOR'">
						<xsl:value-of select="'SY_ACCU_OPEN'"/>
					</xsl:when>
					<xsl:when test="b:productType='DECUMULATOR'">
						<xsl:value-of select="'SY_DECU_OPEN'"/>
					</xsl:when>
				</xsl:choose>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:value-of select="b:valueDate"/>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="commonReference">
		<commonReference>
			<xsl:value-of select="b:syDxReference"/>
		</commonReference>
	</xsl:template>
	<xsl:template name="accountCurrency"/>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="accruedInterestCounter"/>
	<xsl:template name="broker"/>
	<xsl:template name="depositaryAccount"/>
	<xsl:template name="exCoupon"/>
	<xsl:template name="executionSetCriteria"/>
	<xsl:template name="initiatedBy"/>
	<xsl:template name="initiator"/>
	<xsl:template name="limitPrice"/>
	<xsl:template name="orderType"/>
	<xsl:template name="orderValidityType"/>
	<xsl:template name="originalOrderCode"/>
	<xsl:template name="intermediary"/>
	<xsl:template name="market"/>
	<xsl:template name="compoundOrderCode"/>
	<xsl:template name="compoundOrderMaster"/>
	<xsl:template name="compoundOrderSlave"/>
	<xsl:template name="contactMethod"/>
	<xsl:template name="paymentOptionE"/>
	<xsl:template name="targetAmount"/>
	<xsl:template name="targetNature"/>
	<xsl:template name="targetObjective"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="price">
		<price>
			<xsl:value-of select=" '0' "/>
		</price>
	</xsl:template>
	<xsl:template name="securityCcyNetAmount"/>
	<xsl:template name="securityCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="stockExchange">
		<stockExchange>
			<infra:code>
				<xsl:value-of select="concat($STOCKEXCH_PREFIX,b:stockExchange)"/>
			</infra:code>
		</stockExchange>
	</xsl:template>
	<xsl:template name="stopPrice"/>
	<xsl:template name="trader"/>
	<xsl:template name="tradeCurrency">
		<tradeCurrency>
			<infra:code>
				<xsl:value-of select="b:contractCcy"/>
			</infra:code>
		</tradeCurrency>
	</xsl:template>
	<xsl:template name="tradeCcyGrossAmount"/>
	<xsl:template name="tradeCcyNetAmount"/>
	<xsl:template name="tradeCcyPortfolioCcyExchangeRate"/>
	<xsl:template name="tradeDate">
		<tradeDate>
			<xsl:value-of select="b:tradeDate"/>
		</tradeDate>
	</xsl:template>
	<xsl:template name="validityDate"/>
    <xsl:template name="referenceNature">
        <referenceNature>
            <xsl:value-of select=" '0' "/>
        </referenceNature>
    </xsl:template>
	<xsl:template name="coolCancelEndDate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="portfolio">
				<block path="portfolio/infra:code/xsl:value-of" x="535" y="396"/>
			</template>
			<template name="status">
				<block path="status/xsl:call-template" x="535" y="224"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->