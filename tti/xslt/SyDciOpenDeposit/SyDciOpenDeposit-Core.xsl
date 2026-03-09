<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:custDepositAcc"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account1CcyDepositCcyExchangeRate"/>
   <xsl:template name="account1NetAmount">
      <account1NetAmount>
        <xsl:choose>
                <xsl:when test="b:feeAmt">
                    <xsl:value-of select="format-number(b:depositAmount + b:feeAmt, $decimalformat, 'nan2zero')"/>
                </xsl:when>
		        <xsl:otherwise>
		            <xsl:value-of select="b:depositAmount"/>
		        </xsl:otherwise>                
        </xsl:choose>
      </account1NetAmount>
   </xsl:template>
   <xsl:template name="account2">
      <account2>
         <infra:code>
            <xsl:value-of select="b:custAltCcyAcc1"/>
         </infra:code>
      </account2>
   </xsl:template>
   <xsl:template name="account2CcyDepositCcyExchangeRate"/>
   <xsl:template name="account2NetAmount"/>
   <xsl:template name="account3">
      <account3>
         <infra:code>
            <xsl:value-of select="b:custAltCcyAcc2"/>
         </infra:code>
      </account3>
   </xsl:template>
   <xsl:template name="account3CcyDepositCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="accountingDate"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="counterParty"/>
   <xsl:template name="deposit">
      <deposit>
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
      </deposit>
   </xsl:template>
   <xsl:template name="depositCurrency">
      <depositCurrency>
         <infra:code>
            <xsl:value-of select="b:tradeCcy"/>
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
            <xsl:value-of select="b:portfolio"/>
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
            <xsl:value-of select="b:id"/>
        </sourceSystemCode>
   </xsl:template>
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
   <xsl:template name="subType"/>
   <xsl:template name="trader"/>
   <xsl:template name="transactionCode">
      <transactionCode>
            <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>                     
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'OPEN')"/>
                </xsl:otherwise>
            </xsl:choose>      
      </transactionCode>
   </xsl:template>
   <xsl:template name="transactionDate">
      <transactionDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </transactionDate>
   </xsl:template>
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
               <xsl:when test="b:alternateCcy2 = '' or not(b:alternateCcy2)">
                  <xsl:value-of select=" 'SY_DCI_OPEN' "/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select=" 'SY_TCI_OPEN' "/>
               </xsl:otherwise>
            </xsl:choose>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </valueDate>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="accruedInterestAmount">
      <accruedInterestAmount>0</accruedInterestAmount>
   </xsl:template>
   <xsl:template name="referenceNature"/>
   <xsl:template name="depositAmount">
      <depositAmount>
         <xsl:value-of select="b:depositAmount"/>
      </depositAmount>
   </xsl:template>
   <xsl:template name="depositInterestRate">
      <depositInterestRate>
         <xsl:value-of select="b:interestRate"/>
      </depositInterestRate>
   </xsl:template>
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="renewalAmount"/>
   <xsl:template name="renewalEndDate"/>
   <xsl:template name="renewalInterestRate"/>
   <xsl:template name="renewalMode"/>
   <xsl:template name="renewalPeriod"/>
   <xsl:template name="renewalPeriodNumber"/>
   <xsl:template name="renewalTreatment"/>
   <xsl:template name="lockNature"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\TransactionPMS.xsd" destSchemaRoot="TransactionPMS" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="..\..\IntegrationStudio\TTI\schemas\SyTci\TTI-SyTci.xsd" srcSchemaRoot="SyTci" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template name="account1"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->