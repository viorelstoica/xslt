<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts" 
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyDci"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b"
                version="1.0">
   <xsl:template name="code">
      <infra:code>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_FX2')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'FX',$COMPANY_POSTFIX_SEPARATOR,'2') "/>
            </xsl:otherwise>
          </xsl:choose>           
      </infra:code>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_FX')"/>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,'FX',$COMPANY_POSTFIX_SEPARATOR,'2')"/>
            </xsl:otherwise>
         </xsl:choose>             
      </infra:shortName>
   </xsl:template>
   <xsl:template name="longName">
      <infra:longName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_FX')"/>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,'FX',$COMPANY_POSTFIX_SEPARATOR,'2')"/>
            </xsl:otherwise>
         </xsl:choose>             
      </infra:longName>
   </xsl:template>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="minimumQuantity"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="provider"/>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:tradeCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature">
        <riskNature>4</riskNature>
   </xsl:template>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tickSize"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:if test="b:alternateCcy2!='' or b:alternateCcy2">
               <xsl:value-of select="'SY_TRIPLE_CURRENCY_INVESTMENT'"/>
            </xsl:if>
            <xsl:if test="b:alternateCcy2='' or not(b:alternateCcy2)">
               <xsl:value-of select="'SY_DUAL_CURRENCY_INVESTMENT'"/>
            </xsl:if>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valuationRule">
       <valuationRule>5</valuationRule>
   </xsl:template>
   <xsl:template name="beginDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="category">
      <category>12</category>
   </xsl:template>   
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="complexity"/>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="contractMaster"/>
   <xsl:template name="contractSize">
      <contractSize>
         <xsl:value-of select=" '1'"/>
      </contractSize>
   </xsl:template>
   <xsl:template name="exerciseCurrency">
        <exerciseCurrency>
            <infra:code>
               <xsl:value-of select="b:tradeCcy"/>
            </infra:code>
        </exerciseCurrency>
   </xsl:template>   
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>      
      </expirationDate>
   </xsl:template>
   <xsl:template name="instrumentClass"/>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="lastTradeDate"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="riskLevel"/>
   <xsl:template name="subNature"/>
   <xsl:template name="usageNature"/>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="underlying"/>
   <!-- 
   
   term event 
   
   -->
   <xsl:template name="averagingNumber"/>
   <xsl:template name="barrier"/>
   <xsl:template name="barrierNature"/>
   <xsl:template name="beginDate1">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="callPutIndicator1">
      <callPutIndicator>
         <xsl:value-of select=" '2' "/>
      </callPutIndicator>
   </xsl:template>
   <xsl:template name="cashSettlement1">
      <cashSettlement>1</cashSettlement>
   </xsl:template>
   <xsl:template name="code1"/>
   <xsl:template name="currency"/>
   <xsl:template name="effectiveLeverage"/>
   <xsl:template name="endDate">
      <endDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </endDate>
   </xsl:template>
   <xsl:template name="endValidityDate"/>
   <xsl:template name="exercisePrice">
      <exercisePrice>
         <xsl:value-of select="b:strikePrice2"/>
      </exercisePrice>
   </xsl:template>
   <xsl:template name="exerciseType1">
      <exerciseType>1</exerciseType>
   </xsl:template>
   <xsl:template name="fixDate"/>
   <xsl:template name="frequency"/>
   <xsl:template name="frequencyUnit"/>
   <xsl:template name="gap"/>
   <xsl:template name="gearing"/>
   <xsl:template name="maximumValue"/>
   <xsl:template name="minimumValue"/>
   <xsl:template name="payOffNature"/>
   <xsl:template name="premiumPaymentRule"/>
   <xsl:template name="protectedDate"/>
   <xsl:template name="rebateAtHit"/>
   <xsl:template name="rebatePayoff"/>
   <xsl:template name="scaleFactor"/>
   <xsl:template name="season"/>
   <xsl:template name="totalQuantity"/>
   <xsl:template name="upperBarrier"/> 
   <xsl:template name="upperBarrierNature"/>
   <xsl:template name="upperRebate"/>
   <xsl:template name="upperRebateAtHit"/>
   <xsl:template name="lowerBarrierP"/>
   <xsl:template name="upperBarrierP"/>
   <xsl:template name="underlyingInstrument">
      <underlyingInstrument>
         <infra:code>
            <xsl:value-of select="b:alternateCcy2"/>
         </infra:code>
      </underlyingInstrument>
   </xsl:template>
   <xsl:template name="underlyingQuantity1"/>
   <xsl:template name="validityDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>   
   </xsl:template>
   <xsl:template name="mbFields1"/>     
   <xsl:template name="instrument">
      <instrument>
         <infra:code>
             <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_FX2')"/>
                </xsl:when>
                <xsl:otherwise>
                     <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'FX', $COMPANY_POSTFIX_SEPARATOR, '2') "/>
                </xsl:otherwise>
              </xsl:choose>     
         </infra:code>
      </instrument>
   </xsl:template>
</xsl:stylesheet>
