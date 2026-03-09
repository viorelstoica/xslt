<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts"
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c ns0"
                version="1.0">
   <xsl:template name="infra:code">
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
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:shortName">
        <xsl:if test="not(b:tapRefId)">
		      <infra:shortName>
		         <xsl:choose>
		            <xsl:when test="b:productType = 'ACCUMULATOR'">
		               <xsl:value-of select="concat('ACCU',$COMPANY_POSTFIX_SEPARATOR,b:CompanyNameList/b:CompanyName,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
		            </xsl:when>
		            <xsl:when test="b:productType = 'DECUMULATOR'">
		               <xsl:value-of select="concat('DECU',$COMPANY_POSTFIX_SEPARATOR,b:CompanyNameList/b:CompanyName,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
		            </xsl:when>
		         </xsl:choose>
		      </infra:shortName>
		 </xsl:if>
   </xsl:template>
   <xsl:template name="infra:longName">
         <xsl:if test="not(b:tapRefId)"> 
		      <infra:longName>
		         <xsl:choose>
		            <xsl:when test="b:productType = 'ACCUMULATOR'">
		               <xsl:value-of select=" concat('ACCU',$COMPANY_POSTFIX_SEPARATOR,b:CompanyNameList/b:CompanyName,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
		            </xsl:when>
		            <xsl:when test="b:productType = 'DECUMULATOR'">
		               <xsl:value-of select=" concat('DECU',$COMPANY_POSTFIX_SEPARATOR,b:CompanyNameList/b:CompanyName,$COMPANY_POSTFIX_SEPARATOR,b:maturityDate)"/>
		            </xsl:when>
		         </xsl:choose>
		      </infra:longName>
		  </xsl:if>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad-custo"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField-custo"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select="'1'"/>
      </active>
   </xsl:template>
   <xsl:template name="beginDate">
   <beginDate>
         <xsl:value-of select="b:tradeDate"/>
      </beginDate>
   </xsl:template>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="category"/>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="compoundingFrequency"/>
   <xsl:template name="compoundingFrequencyUnit"/>
   <xsl:template name="contractType">
      <contractType>
		<infra:code>
         <xsl:value-of select="b:variant"/>
		 </infra:code>
      </contractType>
   </xsl:template>
   <xsl:template name="desc">
      <desc>
         <xsl:value-of select="b:descriptionList/b:description"/>
      </desc>
   </xsl:template>
   <xsl:template name="endDate">
	<endDate>
         <xsl:value-of select="b:maturityDate"/>
      </endDate>
	</xsl:template>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="eventType">
   <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
            <xsl:with-param name="recordStatus" select="b:recordStatus"/>
         </xsl:call-template>
      </xsl:variable>
	<eventType>
		<xsl:choose>
			<xsl:when test= "b:contractStatus and b:contractStatus = 'MATURED'">
				<xsl:value-of select="'3'"/>
			</xsl:when>
			<xsl:when test= "b:contractStatus and b:contractStatus = 'UNWOUND'">
				<xsl:value-of select="'2'"/>
			</xsl:when>
			<xsl:when test= "b:contractStatus and b:contractStatus = 'KNOCKOUT'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test= "$opStatus = 'REVERSE-AUTHORISE'">
				<xsl:value-of select="'4'"/>
			</xsl:when>
		</xsl:choose>
	</eventType>
</xsl:template>
   <xsl:template name="islamicCompliance"/>
   <xsl:template name="issuer"/>
   <xsl:template name="knockInDate">
        <xsl:if test="b:knockIn and b:knockIn = 'YES'">
         <knockInDate>
            <xsl:value-of select="b:eventCommon/ns0:today"/>
         </knockInDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="knockOutDate">
        <xsl:if test="b:contractStatus and b:contractStatus = 'KNOCKOUT'">
         <knockOutDate>
            <xsl:value-of select="b:eventCommon/ns0:today"/>
         </knockOutDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select="'1'"/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:contractCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskLevel">
		<riskLevel>
			<xsl:value-of select="b:riskLevel"/>
		</riskLevel>
   </xsl:template>
   <xsl:template name="riskNature"/>
   <xsl:template name="settlementFrequency">        
        <settlementFrequency>
	        <xsl:call-template name="sySetTapPaymentFrequency">
	            <xsl:with-param name="t24FixingFrequency"><xsl:value-of select="b:fixingFrequency"/></xsl:with-param>
	        </xsl:call-template>
        </settlementFrequency>
   </xsl:template>
   <xsl:template name="settlementFrequencyUnit">
        <settlementFrequencyUnit>
	         <xsl:call-template name="sySetTapPaymentFrequencyUnit">
	             <xsl:with-param name="t24FixingFrequency"><xsl:value-of select="b:fixingFrequency"/></xsl:with-param>
	         </xsl:call-template>            
        </settlementFrequencyUnit>  
   </xsl:template>
   <xsl:template name="subNature">
      <subNature>
         <xsl:choose>
            <xsl:when test="b:productType='ACCUMULATOR'">
               <xsl:value-of select="'72'"/>
            </xsl:when>
            <xsl:when test="b:productType='DECUMULATOR'">
               <xsl:value-of select="'73'"/>
            </xsl:when>
         </xsl:choose>
      </subNature>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:if test="(b:productType ='ACCUMULATOR') or (b:productType ='DECUMULATOR')">
               <xsl:value-of select="b:productType"/>
            </xsl:if>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="fixingDate">
        <fixingDate>
            <xsl:call-template name="sySetTapFixingDate">
                <xsl:with-param name="t24FixingFrequency"><xsl:value-of select="b:fixingFrequency"/></xsl:with-param>
            </xsl:call-template>
        </fixingDate>
   </xsl:template>   
   <xsl:template name="genericFlag"/>
   <xsl:template name="underlying"/>
   <xsl:template name="usageNature"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="validityDate">
      <validityDate>
         <xsl:value-of select="b:tradeDate"/>
      </validityDate>
   </xsl:template>
   <xsl:template name="underlyingInstrument">
        <underlyingInstrument>
            <infra:code>
                <xsl:value-of select="b:securityCode"/>
            </infra:code>
        </underlyingInstrument>
   </xsl:template>
   <xsl:template name="underlyingQuantity">
        <underlyingQuantity>
            <xsl:value-of select="b:dailyUnits"/>
        </underlyingQuantity>
   </xsl:template>
   <xsl:template name="currency">
      <currency>
         <infra:code>
            <xsl:value-of select="b:contractCcy"/>
         </infra:code>
      </currency>
   </xsl:template>
   <xsl:template name="beginDate_TermEvent">
      <beginDate>
         <xsl:value-of select="b:tradeDate"/>
      </beginDate>
   </xsl:template>
   <xsl:template name="endDate_TermEvent">
      <endDate>
         <xsl:value-of select="b:maturityDate"/>
      </endDate>
   </xsl:template>
   <xsl:template name="callPutIndicator">
      <callPutIndicator>
         <xsl:choose>
            <xsl:when test="b:optionType ='CALL'">
               <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:when test="b:optionType ='PUT'">
               <xsl:value-of select="'2'"/>
            </xsl:when>
         </xsl:choose>
      </callPutIndicator>
   </xsl:template>
   <xsl:template name="exerciseType">
      <exerciseType>
         <xsl:value-of select=" '2' "/>
      </exerciseType>
   </xsl:template>
   <xsl:template name="cashSettlement">
      <cashSettlement>
	  	<xsl:choose>
			<xsl:when test="b:settlementMethod ='PHYSICAL'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test="b:settlementMethod ='CASH'">
				<xsl:value-of select="'0'"/>
			</xsl:when>
		</xsl:choose>
      </cashSettlement>
   </xsl:template>
   <xsl:template name="frequency"/>
   <xsl:template name="barrier">
       <barrier>
            <xsl:value-of select="b:knockinPrice"/>      
       </barrier>
   </xsl:template>
   <xsl:template name="barrierNature">
         <xsl:choose>
            <xsl:when test="b:productType='ACCUMULATOR'">
                <xsl:if test="b:knockinPrice">
                    <barrierNature>
                        <xsl:value-of select="'1'"/>
                    </barrierNature>
                </xsl:if>
            </xsl:when>
            <xsl:when test="b:productType='DECUMULATOR'">
                <xsl:if test="b:knockinPrice">
                    <barrierNature>
                        <xsl:value-of select="'3'"/>
                    </barrierNature>
                </xsl:if>
            </xsl:when>
         </xsl:choose>
   </xsl:template>
   <xsl:template name="payOffNature">
      <payOffNature>
         <xsl:choose>
            <xsl:when test="b:productType='ACCUMULATOR'">
               <xsl:value-of select="'5'"/>
            </xsl:when>
            <xsl:when test="b:productType='DECUMULATOR'">
               <xsl:value-of select="'6'"/>
            </xsl:when>
         </xsl:choose>
      </payOffNature>
   </xsl:template>
   <xsl:template name="exercisePrice">
      <exercisePrice>
         <xsl:value-of select="b:strikePrice1"/>
      </exercisePrice>
   </xsl:template>
   <xsl:template name="totalQuantity">
      <totalQuantity>
         <xsl:value-of select="b:totalUnits"/>
      </totalQuantity>
   </xsl:template>
   <xsl:template name="totalWorkDays">
      <totalworkdays>
         <xsl:value-of select="b:totWorkDays"/>
      </totalworkdays>
   </xsl:template>
   
   <xsl:template name="protectedDate">
      <xsl:if test="b:protectedDate">
         <protectedDate>
            <xsl:value-of select="b:protectedDate"/>
         </protectedDate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="gearing">
      <gearing>
         <xsl:choose>
            <xsl:when test="b:gearing">
               <xsl:value-of select="b:gearing"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select=" '1' "/>
            </xsl:otherwise>
         </xsl:choose>
      </gearing>
   </xsl:template>
   <xsl:template name="lowerBarrierP"/>   
   <xsl:template name="frequencyUnit"/>
   <xsl:template name="instrument">
      <instrument>
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
      </instrument>
   </xsl:template>
   <xsl:template name="averagingNumber"/>
   <xsl:template name="code"/>
   <xsl:template name="effectiveLeverage"/>
   <xsl:template name="endValidityDate"/>
   <xsl:template name="fixDate"/>
   <xsl:template name="gap"/>
   <xsl:template name="maximumValue"/>
   <xsl:template name="minimumValue"/>
   <xsl:template name="premiumPaymentRule"/>
   <xsl:template name="rebateAtHit"/>
   <xsl:template name="rebatePayoff"/>
   <xsl:template name="scaleFactor"/>
   <xsl:template name="season"/>
   <xsl:template name="upperBarrier">
         <upperBarrier>
                <xsl:value-of select="b:knockoutPrice"/>
         </upperBarrier>
   </xsl:template>
   <xsl:template name="upperBarrierNature">
         <xsl:choose>
            <xsl:when test="b:productType='ACCUMULATOR'">
                <xsl:if test="b:knockoutPrice">
                    <upperBarrierNature>
                        <xsl:value-of select="'2'"/>
                    </upperBarrierNature>
                </xsl:if>
            </xsl:when>
            <xsl:when test="b:productType='DECUMULATOR'">
                <xsl:if test="b:knockoutPrice">
                    <upperBarrierNature>
                        <xsl:value-of select="'4'"/>
                    </upperBarrierNature>
                </xsl:if>
            </xsl:when>
         </xsl:choose>
   </xsl:template>
   <xsl:template name="upperBarrierP"/>   
   <xsl:template name="upperRebate"/>
   <xsl:template name="upperRebateAtHit"/>
   <xsl:template name="mbFields"/>
   
   <!--  Exchange Event -->        
   <xsl:template name="ExchangeEvent_endDate">
		<endDate>
			<xsl:value-of select="b:settlementDate"/>
		</endDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_exDate">
		<exDate>
			<xsl:value-of select="b:fixingDate"/>
		</exDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_instrument">
		<instrument>
			<infra:code>
			<xsl:choose>
	            <xsl:when test="../b:tapRefId">
	               <xsl:value-of select="../b:tapRefId"/>
	            </xsl:when>
	            <xsl:otherwise>
				   <xsl:value-of select="concat(../b:id,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
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
	<xsl:template name="ExchangeEvent_validityDate">
		<validityDate>
			<xsl:value-of select="b:fixingDate"/>
		</validityDate>
	</xsl:template>
	<xsl:template name="ExchangeEvent_eventPriority">
		<eventPriority>
			<xsl:value-of select="'1'"/>
		</eventPriority>
	</xsl:template>
	<xsl:template name="ExchangeEvent_workingDays">
		<workingDays>
			<xsl:value-of select="b:workingDays"/>
		</workingDays>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newInstrument">
		<newInstrument>
		<infra:code>
			<xsl:value-of select="../b:securityCode"/>
		</infra:code>
		</newInstrument>
	</xsl:template>
	<xsl:template name="ExchangeEvent_newRatio"/>
	<xsl:template name="ExchangeEvent_oldRatio"/>
	<xsl:template name="ExchangeEvent_price"/>
	<xsl:template name="ExchangeEvent_cashSettlement"/>
	<xsl:template name="ExchangeEvent_code"/>
	<xsl:template name="ExchangeEvent_currency"/>
	<xsl:template name="ExchangeEvent_exchangeRate"/>
	<xsl:template name="ExchangeEvent_replaceOld"/>
	<xsl:template name="ExchangeEvent_mbFields"/>
	
	 <!--  Chrono -->       
   <xsl:template name="ChronologicalData_dataNature">
	<dataNature>
		<xsl:choose>
			<xsl:when test= "b:accruedUnits1 and b:accruedUnits1 != ''">
				<xsl:value-of select="'54'"/>
			</xsl:when>
			<xsl:when test= "../b:remainingUnits and ../b:remainingUnits != ''">
				<xsl:value-of select="'55'"/>
			</xsl:when>
			<xsl:when test= "../b:runNotionalAmt and ../b:runNotionalAmt != ''">
				<xsl:value-of select="'56'"/>
			</xsl:when>
			<xsl:when test= "../b:blockAmount and ../b:blockAmount != ''">
				<xsl:value-of select="'57'"/>
			</xsl:when>
			<xsl:when test= "../b:blockNominalGroup/b:blockNominal and ../b:blockNominalGroup/b:blockNominal != ''">
				<xsl:value-of select="'58'"/>
			</xsl:when>
		</xsl:choose>
	</dataNature>
</xsl:template>
   <xsl:template name="ChronologicalData_instrument">
      <instrument>
         <infra:code>
			<xsl:choose>
	            <xsl:when test="../b:tapRefId">
	               <xsl:value-of select="../b:tapRefId"/>
	            </xsl:when>
	            <xsl:otherwise>
				   <xsl:value-of select="concat(../b:id,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonic)"/>
	            </xsl:otherwise>
             </xsl:choose>
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="ChronologicalData_validity">
         <validity>
            <xsl:value-of select="b:fixingDate"/>
         </validity>
   </xsl:template>
   <xsl:template name="ChronologicalData_value">
      <value>
		<xsl:choose>
			<xsl:when test= "b:accruedUnits1 and b:accruedUnits1 != ''">
				<xsl:value-of select="b:accruedUnits1"/>
			</xsl:when>
			<xsl:when test= "../b:remainingUnits and ../b:remainingUnits != ''">
				<xsl:value-of select="../b:remainingUnits"/>
			</xsl:when>
			<xsl:when test= "../b:runNotionalAmt and ../b:runNotionalAmt != ''">
				<xsl:value-of select="../b:runNotionalAmt"/>
			</xsl:when>
			<xsl:when test= "../b:blockAmount and ../b:blockAmount != ''">
				<xsl:value-of select="../b:blockAmount"/>
			</xsl:when>
			<xsl:when test= "../b:blockNominalGroup/b:blockNominal and ../b:blockNominalGroup/b:blockNominal != ''">
				<xsl:value-of select="../b:blockNominalGroup/b:blockNominal"/>
			</xsl:when>
		</xsl:choose>
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
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="..\..\gwpackSchemas\StructuredProducts.xsd" destSchemaRoot="StructuredProducts" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="infra:code"></template>
			<template name="infra:synonym"></template>
			<template name="yieldCurve"></template>
			<template name="infra:shortName">
				<block path="infra:shortName/xsl:choose" x="585" y="150"/>
				<block path="infra:shortName/xsl:choose/=[0]" x="539" y="144"/>
				<block path="infra:shortName/xsl:choose/xsl:when/xsl:value-of" x="535" y="180"/>
				<block path="infra:shortName/xsl:choose/=[1]" x="539" y="172"/>
				<block path="infra:shortName/xsl:choose/xsl:when[1]/xsl:value-of" x="495" y="180"/>
			</template>
			<template name="infra:userDefinedField"></template>
			<template name="barrier">
				<block path="barrier/xsl:value-of" x="535" y="140"/>
			</template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->