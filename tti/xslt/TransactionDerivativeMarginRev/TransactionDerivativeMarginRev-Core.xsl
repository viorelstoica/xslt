<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionDerivativeMarginRev" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="account1">
      <account1>
         <infra:code>
            <xsl:value-of select="b:account"/>
         </infra:code>
      </account1>
   </xsl:template>
   <xsl:template name="account2">
      <account2>
         <infra:code>
            <xsl:value-of select="b:account"/>
         </infra:code>
      </account2>
   </xsl:template>
   <xsl:template name="account2NetAmount">
      <account2NetAmount>
         <xsl:value-of select="b:amount"/>
      </account2NetAmount>
   </xsl:template>
   <xsl:template name="accountingDate">
      <accountingDate>
         <xsl:value-of select="b:date"/>
      </accountingDate>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="../b:priSecAccGroup/b:priSecAcc"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="reversalIndicator">
      <reversalIndicator>
         <xsl:value-of select="'1'"/>
      </reversalIndicator>
   </xsl:template>
   <xsl:template name="reversedTransactionCode">
      <xsl:variable name="Id1" select="substring-before(../b:id,'.')"/>
      <xsl:variable name="Id2" select="substring-after(../b:id,'.')"/>
      <reversedTransactionCode>
         <xsl:value-of select="concat('VM_',$Id1,'__',$Id2,'.',b:date,'-',@index,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
      </reversedTransactionCode>
   </xsl:template>
   <xsl:template name="sourceSystemCode">
      <sourceSystemCode>
         <xsl:value-of select="concat(../b:id,'.',b:date,'-',@index,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
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
      <xsl:variable name="Id1" select="substring-before(../b:id,'.')"/>
      <xsl:variable name="Id2" select="substring-after(../b:id,'.')"/>
      <transactionCode>
         <xsl:value-of select="concat('VM_',$Id1,'__',$Id2,'.',b:date,'-',@index,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic,'-R')"/>
      </transactionCode>
   </xsl:template>
   <xsl:template name="referenceNature">
      <referenceNature>
			<xsl:choose>
				<xsl:when test="../b:exchangeTypeJoin = 'NORMAL' and ../b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoin = 'NORMAL' and ../b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoin = 'OTC' and ../b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoin = 'OTC' and ../b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
			</referenceNature>
   </xsl:template>
   <xsl:template name="referenceTransactionCode">
      <referenceTransactionCode>
			<xsl:if test="(../b:exchangeTypeJoin = 'NORMAL' and ../b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (../b:exchangeTypeJoin = 'NORMAL' and ../b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (../b:exchangeTypeJoin = 'OTC' and ../b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (../b:exchangeTypeJoin = 'OTC' and ../b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(../b:tradeReference,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
			</xsl:if>
		</referenceTransactionCode>
   </xsl:template>
   <xsl:template name="valueDate">
      <valueDate>
         <xsl:value-of select="b:date"/>
      </valueDate>
   </xsl:template>
   <xsl:template name="heldQuantity">
      <heldQuantity>
         <xsl:value-of select="../b:priSecAccGroup/b:priLots"/>
      </heldQuantity>
   </xsl:template>
   <xsl:template name="future">
      <xsl:variable name="OptionStyle">
         <xsl:choose>
            <xsl:when test="../b:optionStyle ='AMERICAN'">
               <xsl:value-of select="'A'"/>
            </xsl:when>
            <xsl:when test="../b:optionStyle ='EUROPEAN'">
               <xsl:value-of select="'E'"/>
            </xsl:when>
            <xsl:when test="../b:optionStyle ='CARRIBEAN'">
               <xsl:value-of select="'C'"/>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <future>
         <infra:code>
		 	<xsl:choose>
				<xsl:when test="../b:exchangeTypeJoin = 'OTC'">
					<xsl:choose>
						<xsl:when test="../b:tapRefId and ../b:tapRefId != ''">
							<xsl:value-of select="../b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:idDxTradeJoin,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:value-of select="concat(../b:contractCode,'/',../b:tradeCcy,'/',../b:maturityDate,'/',../b:optionType,'/',../b:strikePrice,'/',../b:dlvCcy,'/',$OptionStyle)"/>
				</xsl:otherwise>
			</xsl:choose>
         </infra:code>
      </future>
   </xsl:template>
   <xsl:template name="marginCallDate">
      <marginCallDate>
         <xsl:value-of select="b:date"/>
      </marginCallDate>
   </xsl:template>
   <xsl:template name="newPrice">
      <newPrice>
         <xsl:value-of select="'0'"/>
      </newPrice>
   </xsl:template>
   <xsl:template name="account1CcyTradeCcyExchangeRate"/>
   <xsl:template name="account1NetAmount"/>
   <xsl:template name="account2CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3"/>
   <xsl:template name="account3CcyTradeCcyExchangeRate"/>
   <xsl:template name="account3NetAmount"/>
   <xsl:template name="accountingCode"/>
   <xsl:template name="cashPortfolio"/>
   <xsl:template name="ContractNumber"/>
   <xsl:template name="notepad"/>
   <xsl:template name="portfolioManager"/>
   <xsl:template name="remark"/>
   <xsl:template name="subType"/>
   <xsl:template name="transactionFeesTaxesCounter"/>
   <xsl:template name="type"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="commonReference"/>
   <xsl:template name="intermediary"/>
   <xsl:template name="adjustedDeposit"/>
   <xsl:template name="depositaryAccount"/>
   <xsl:template name="initiatedBy"/>
   <xsl:template name="positionCriteria1"/>
   <xsl:template name="positionCriteria2"/>
   <xsl:template name="positionCriteria3"/>
   <xsl:template name="positionCurrency"/>
   <xsl:template name="trader"/>
   <xsl:template name="market"/>
</xsl:stylesheet>