<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/SyFxForwards" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyFxForwards" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyFxForwards" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyFxForwards" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_CALL')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:bOptionType,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
            </xsl:otherwise>
         </xsl:choose>       
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_CALL')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(b:dxContractCode,'/',b:contractCcy,'/',b:maturityDate,'/',b:bOptionType,'/',b:bStrikePrice,'/',b:bPutCcy,'/',b:bOptionStyle)"/>
            </xsl:otherwise>
         </xsl:choose>        
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
          <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="concat(b:tapRefId, '_CALL')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat(b:dxContractCode,'/',b:contractCcy,'/',b:maturityDate,'/',b:bOptionType,'/',b:bStrikePrice,'/',b:bPutCcy,'/',b:bOptionStyle)"/>
            </xsl:otherwise>
         </xsl:choose>   
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="paymentFrequency">
        <paymentFrequency>
            <xsl:call-template name="sySetTapPaymentFrequency">
                <xsl:with-param name="t24FixingFrequency"><xsl:value-of select="b:bFixingFrequency"/></xsl:with-param>
            </xsl:call-template>  
        </paymentFrequency>             
   </xsl:template>
   <xsl:template name="paymentFrequencyUnit">
        <paymentFrequencyUnit>
             <xsl:call-template name="sySetTapPaymentFrequencyUnit">
                 <xsl:with-param name="t24FixingFrequency"><xsl:value-of select="b:bFixingFrequency"/></xsl:with-param>
             </xsl:call-template>
        </paymentFrequencyUnit>             
   </xsl:template>    
   <xsl:template name="parentInstrument"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="minimumQuantity"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select="'1'"/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:bPutCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="subType"/>
   <xsl:template name="tickSize"/>
   <xsl:template name="type">
      <xsl:if test="b:bOptionType != ''">
         <type>
            <infra:code>
               <xsl:value-of select="b:bOptionType"/>
            </infra:code>
         </type>
      </xsl:if>
   </xsl:template>
   <xsl:template name="callPutIndicator">
      <callPutIndicator>
         <xsl:value-of select=" '1' "/>
      </callPutIndicator>
   </xsl:template>
   <xsl:template name="cashSettlement"/>
   <xsl:template name="category">
      <category>13</category>
   </xsl:template>     
   <xsl:template name="commonReference">
      <xsl:if test="b:transactionRef != ''">
         <commonReference>
            <xsl:value-of select="b:transactionRef"/>
         </commonReference>
      </xsl:if>
   </xsl:template>
   <xsl:template name="contractMaster"/>
   <xsl:template name="contractSize"/>
   <xsl:template name="desc">
      <desc>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </desc>
   </xsl:template>
   <xsl:template name="eventType">
	<eventType>
		<xsl:choose>
			<xsl:when test= "b:bKnockOut and b:bKnockOut = 'YES'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test= "b:bTradeStatus and b:bTradeStatus = 'CLOSED'">
				<xsl:value-of select="'3'"/>
			</xsl:when>
		</xsl:choose>
	</eventType>
</xsl:template>
   <xsl:template name="exerciseCurrency">
     <exerciseCurrency>
        <infra:code>
            <xsl:value-of select="b:bPutCcy"/>        
        </infra:code>
     </exerciseCurrency>
   </xsl:template>   
   <xsl:template name="exerciseType">
      <exerciseType>
         <xsl:choose>
            <xsl:when test="b:bOptionStyle = '' or not(b:bOptionStyle)">
               <xsl:value-of select=" '0' "/>
            </xsl:when>
            <xsl:when test="b:bOptionStyle = 'AMERICAN' ">
               <xsl:value-of select=" '1' "/>
            </xsl:when>
            <xsl:when test="b:bOptionStyle = 'EUROPEAN' ">
               <xsl:value-of select=" '2' "/>
            </xsl:when>
            <xsl:when test="b:bOptionStyle = 'BERMUDAN' ">
               <xsl:value-of select=" '3' "/>
            </xsl:when>
         </xsl:choose>
      </exerciseType>
   </xsl:template>
   <xsl:template name="strikePrice">
      <strikePrice>
         <xsl:value-of select="b:bStrikePrice"/>
      </strikePrice>
   </xsl:template>
   <xsl:template name="underlying">
        <underlying>
            <infra:code>
                <xsl:value-of select="b:bCallCcy"/>
            </infra:code>
        </underlying>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="provider"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="roundLotQuantity"/>
   <xsl:template name="sector"/>
   <xsl:template name="stockExchange"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule">
      <valuationRule>
         <xsl:value-of select="'1'"/>
      </valuationRule>
   </xsl:template>
   <xsl:template name="beginDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="expirationDate">
      <expirationDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </expirationDate>
   </xsl:template>
   <xsl:template name="complexity"/> 
   <xsl:template name="complexityLevel"/>
   <xsl:template name="faceValue"/>
   <xsl:template name="fixingDate">
        <fixingDate>
             <xsl:call-template name="xsdate">
                <xsl:with-param name="date" select="translate(substring(b:bFixingFrequency,1,8),'-','')"/>
             </xsl:call-template>        
        </fixingDate>
   </xsl:template>   
   <xsl:template name="instrumentClass"/>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="issuer"/>
   <xsl:template name="lastTradeDate"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="riskLevel"/>
   <xsl:template name="subNature"/>
   <xsl:template name="underlyingQuantity">
      <underlyingQuantity>
        <xsl:value-of select="b:bCallAmt"/>
      </underlyingQuantity>
   </xsl:template>
   <xsl:template name="barrier_termEvent">
          <xsl:if test="b:bKnockinPrice">
			<barrier>
                <xsl:value-of select="b:bKnockinPrice"/>
			</barrier>
          </xsl:if>
   </xsl:template>
   <xsl:template name="barrierNature_termEvent">
            <xsl:if test="b:bKnockinPrice">            
              <barrierNature>
                    <xsl:value-of select="1"/>
              </barrierNature>
            </xsl:if>
   </xsl:template>
   <xsl:template name="beginDate_termEvent">
          <beginDate>
             <xsl:call-template name="xsdate">
                <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
             </xsl:call-template>          
          </beginDate>
   </xsl:template>
   <xsl:template name="callPutIndicator_termEvent"/>
   <xsl:template name="cashSettlement_termEvent"/>
   <xsl:template name="code_termEvent"/>
   <xsl:template name="currency_termEvent"/>
   <xsl:template name="endDate_termEvent"/>
   <xsl:template name="exercisePrice_termEvent"/>
   <xsl:template name="exerciseType_termEvent"/>
   <xsl:template name="lowerBarrierP_termEvent"/>
   <xsl:template name="payOffNature_termEvent">
          <payOffNature>9</payOffNature>
   </xsl:template>
   <xsl:template name="totalQuantity_termEvent">
		  <xsl:if test="b:bTotalCallAmt">
			<totalQuantity>
				<xsl:value-of select="b:bTotalCallAmt"/>
			</totalQuantity>
		  </xsl:if>
   </xsl:template>
   <xsl:template name="underlyingInstrument_termEvent"/>
   <xsl:template name="underlyingQuantity_termEvent"/>
   <xsl:template name="upperBarrier_termEvent">
          <xsl:if test="b:bKnockoutIntrinsic">  
              <upperBarrier>
                        <xsl:value-of select="b:bKnockoutIntrinsic"/>
              </upperBarrier>
          </xsl:if>
   </xsl:template>
   <xsl:template name="upperBarrierNature_termEvent">
          <xsl:if test="b:bKnockoutIntrinsic">  
              <upperBarrierNature>
                    <xsl:value-of select="2"/>
              </upperBarrierNature>
          </xsl:if>
   </xsl:template>
   <xsl:template name="upperBarrierP_termEvent"/>
   <xsl:template name="validityDate_termEvent">
          <validityDate>
             <xsl:call-template name="xsdate">
                <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
             </xsl:call-template>              
          </validityDate>
   </xsl:template>
   <xsl:template name="mbFields_termEvent"/>
   <xsl:template name="knockInDate">
	<xsl:if test="b:bKnockIn = 'YES'">
   		<knockInDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</knockInDate>
	</xsl:if>
   </xsl:template>
   <xsl:template name="knockOutDate">
	<xsl:if test="b:bKnockOut = 'YES'">
   		<knockOutDate>
			<xsl:value-of select="b:eventCommon/ns0:today"/>
		</knockOutDate>
	</xsl:if>
   </xsl:template>
   <xsl:template name="yieldCurve"/>
   <xsl:template name="barrier"/>
   <xsl:template name="barrierNature"/>
   <xsl:template name="lowerBarrierP"/>
   <xsl:template name="upperBarrier"/>
   <xsl:template name="upperBarrierNature"/>
   <xsl:template name="upperBarrierP"/>
   <xsl:template name="usageNature"/>
   
   <!--  Exchange Event -->        
   <xsl:template name="ExchangeEvent_endDate">
		<endDate>
			<xsl:value-of select="b:bSettlementDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_eventPriority">
		<eventPriority>
			<xsl:value-of select="'1'"/>
		</eventPriority>
	</xsl:template>
	<xsl:template name="ExchangeEvent_exchangeRate">
		<exchangeRate>
			<xsl:value-of select="b:bSpotExchangeRate"/>
		</exchangeRate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_exDate">
		<exDate>
			<xsl:value-of select="b:bFixingDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_instrument">
		<instrument>
			<infra:code>
			<xsl:choose>
            <xsl:when test="../b:tapRefId">
                <xsl:value-of select="concat(../b:tapRefId, '_CALL')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,../b:id,$COMPANY_POSTFIX_SEPARATOR,../b:bOptionType,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
            </xsl:otherwise>
         </xsl:choose>
			 </infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="ExchangeEvent_nature">
		<nature>
			<xsl:value-of select="'1'"/>
		</nature>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newInstrument">
		<newInstrument>
		<infra:code>
			<xsl:value-of select="../b:bCallCcy"/>
		</infra:code>
		</newInstrument>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newRatio">
		<newRatio>
			<xsl:value-of select="b:bSchedulePutAmt"/>
		</newRatio>
	</xsl:template>
	<xsl:template name="ExchangeEvent_oldRatio">
		<oldRatio>
			<xsl:value-of select="b:bScheduleCallAmt"/>
		</oldRatio>
		</xsl:template>
	<xsl:template name="ExchangeEvent_validityDate">
		<validityDate>
			<xsl:value-of select="b:bFixingDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_cashSettlement"/>
	<xsl:template name="ExchangeEvent_code"/>
	<xsl:template name="ExchangeEvent_currency"/>
	<xsl:template name="ExchangeEvent_endValidity"/>
	<xsl:template name="ExchangeEvent_oddLotCompensation"/>
	<xsl:template name="ExchangeEvent_price"/>
	<xsl:template name="ExchangeEvent_replaceOld"/>
	<xsl:template name="ExchangeEvent_mbFields"/>
	
	 <!--  Chrono -->       
   <xsl:template name="ChronologicalData_dataNature">
	<dataNature>
		<xsl:choose>
			<xsl:when test= "b:bFixing and b:bFixing = 'EXPIRE'">
				<xsl:value-of select="'59'"/>
			</xsl:when>
			<xsl:when test= "b:bFixing and b:bFixing = 'EXERCISE'">
				<xsl:value-of select="'60'"/>
			</xsl:when>
		</xsl:choose>
	</dataNature>
</xsl:template>
   <xsl:template name="ChronologicalData_instrument">
      <instrument>
			<infra:code>
			<xsl:choose>
            <xsl:when test="../b:tapRefId">
                <xsl:value-of select="concat(../b:tapRefId, '_CALL')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,../b:id,$COMPANY_POSTFIX_SEPARATOR,../b:bOptionType,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
            </xsl:otherwise>
         </xsl:choose>
			 </infra:code>
		</instrument>
   </xsl:template>
   <xsl:template name="ChronologicalData_validity">
         <validity>
            <xsl:value-of select="b:bFixingDate"/>
         </validity>
   </xsl:template>
   <xsl:template name="ChronologicalData_value">
      <value>
		<xsl:value-of select="'1'"/>
	</value>
   </xsl:template>
   <xsl:template name="ChronologicalData_currency"/>
   <xsl:template name="ChronologicalData_provider"/>
   <xsl:template name="ChronologicalData_valueType"/>
   <xsl:template name="ChronologicalData_mbFields"/>
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