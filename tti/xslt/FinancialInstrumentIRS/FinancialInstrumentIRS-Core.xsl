<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/IRSswap" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
      </infra:code>
   </xsl:template>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:value-of select="concat(b:swapType,$COMPANY_POSTFIX_SEPARATOR,b:asCurrency,$COMPANY_POSTFIX_SEPARATOR,b:lbCurrency,$COMPANY_POSTFIX_SEPARATOR,b:asTypeGroup/b:asDateFreq)"/>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:value-of select="concat(b:swapType, $COMPANY_POSTFIX_SEPARATOR,b:asCurrency, $COMPANY_POSTFIX_SEPARATOR, b:lbCurrency,$COMPANY_POSTFIX_SEPARATOR,b:asTypeGroup/b:asDateFreq)"/>
      </infra:longName>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select="b:swapType"/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="subNature">
      <subNature>
         <xsl:choose>
            <xsl:when test="(b:asFixedRate !='') and (b:lbRateKey != '')">36</xsl:when>
            <xsl:when test="(b:asFixedRate !='') and (b:lbFixedRate != '')">37</xsl:when>
            <xsl:when test="(b:asRateKey !='') and (b:lbFixedRate != '')">38</xsl:when>
         </xsl:choose>
      </subNature>
   </xsl:template>
   <xsl:template name="receivedLegCurrency">
      <receivedLegCurrency>
         <infra:code>
            <xsl:value-of select="b:asCurrency"/>
         </infra:code>
      </receivedLegCurrency>
   </xsl:template>
   <xsl:template name="receivedLegFloatingRate">
      <xsl:if test=" b:asRateKey != ''">
         <receivedLegFloatingRate>
            <infra:code>
               <xsl:value-of select="concat(b:asRateKeyJoinMarketRateText,b:asCurrency)"/>
            </infra:code>
         </receivedLegFloatingRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="receivedLegInterestRate">
      <xsl:if test=" b:asFixedRate != ''">
         <receivedLegInterestRate>
            <xsl:value-of select="b:asFixedRate"/>
         </receivedLegInterestRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="receivedLegAccrualRule">
      <receivedLegAccrualRule>
         <xsl:choose>
            <xsl:when test="b:asBasis = 'A'">24</xsl:when>
            <xsl:when test="b:asBasis = 'A1'">24</xsl:when>
            <xsl:when test="b:asBasis = 'A2'">24</xsl:when>
            <xsl:when test="b:asBasis = 'A3'">24</xsl:when>
            <xsl:when test="b:asBasis = 'B'">31</xsl:when>
            <xsl:when test="b:asBasis = 'C'">19</xsl:when>
            <xsl:when test="b:asBasis = 'C1'">19</xsl:when>
            <xsl:when test="b:asBasis = 'C2'">20</xsl:when>
            <xsl:when test="b:asBasis = 'D'">13</xsl:when>
            <xsl:when test="b:asBasis = 'E'">29</xsl:when>
            <xsl:when test="b:asBasis = 'E1'">30</xsl:when>
            <xsl:when test="b:asBasis = 'F'">26</xsl:when>
            <xsl:when test="b:asBasis = 'F1'">26</xsl:when>
            <xsl:when test="b:asBasis = 'F2'">26</xsl:when>
            <xsl:when test="b:asBasis = 'G'">0</xsl:when>
            <xsl:when test="b:asBasis = 'S'">0</xsl:when>
            <xsl:when test="b:asBasis = 'W'">0</xsl:when>
            <xsl:when test="b:asBasis = 'W1'">0</xsl:when>
            <xsl:when test="b:asBasis = 'U'">19</xsl:when>
            <xsl:when test="b:asBasis = 'O'">19</xsl:when>
         </xsl:choose>
      </receivedLegAccrualRule>
   </xsl:template>
   <xsl:template name="receivedLegPaymentFrequencyNumber">
      <receivedLegPaymentFrequencyNumber>
         <xsl:choose>
            <xsl:when test="substring (b:asTypeGroup/b:asDateFreq,9,1) = 'M'">
               <xsl:value-of select="substring (b:asTypeGroup/b:asDateFreq,10,2)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="0"/>
            </xsl:otherwise>
         </xsl:choose>
      </receivedLegPaymentFrequencyNumber>
   </xsl:template>
   <xsl:template name="receivedLegPaymentFrequencyUnit">
      <receivedLegPaymentFrequencyUnit>
         <xsl:choose>
            <xsl:when test="substring (b:asTypeGroup/b:asDateFreq,9,1) = 'M'">
               <xsl:value-of select="4"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="0"/>
            </xsl:otherwise>
         </xsl:choose>
      </receivedLegPaymentFrequencyUnit>
   </xsl:template>
   <xsl:template name="receivedLegCalendar"/>
   <xsl:template name="paidCurrency">
      <paidCurrency>
         <infra:code>
            <xsl:value-of select="b:lbCurrency"/>
         </infra:code>
      </paidCurrency>
   </xsl:template>
   <xsl:template name="paidLegFloatingRate">
      <xsl:if test=" b:lbRateKey != ''">
         <paidLegFloatingRate>
            <infra:code>
               <xsl:value-of select="concat(b:lbRateKeyJoinMarketRateText,b:lbCurrency)"/>
            </infra:code>
         </paidLegFloatingRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="paidLegInterestRate">
      <xsl:if test=" b:lbFixedRate != ''">
         <paidLegInterestRate>
            <xsl:value-of select="b:lbFixedRate"/>
         </paidLegInterestRate>
      </xsl:if>
   </xsl:template>
   <xsl:template name="paidLegAcrrualRule">
      <paidLegAccrualRule>
         <xsl:choose>
            <xsl:when test="b:lbBasis = 'A'">24</xsl:when>
            <xsl:when test="b:lbBasis = 'A1'">24</xsl:when>
            <xsl:when test="b:lbBasis = 'A2'">24</xsl:when>
            <xsl:when test="b:lbBasis = 'A3'">24</xsl:when>
            <xsl:when test="b:lbBasis = 'B'">31</xsl:when>
            <xsl:when test="b:lbBasis = 'C'">19</xsl:when>
            <xsl:when test="b:lbBasis = 'C1'">19</xsl:when>
            <xsl:when test="b:lbBasis = 'C2'">20</xsl:when>
            <xsl:when test="b:lbBasis = 'D'">13</xsl:when>
            <xsl:when test="b:lbBasis = 'E'">29</xsl:when>
            <xsl:when test="b:lbBasis = 'E1'">30</xsl:when>
            <xsl:when test="b:lbBasis = 'F'">26</xsl:when>
            <xsl:when test="b:lbBasis = 'F1'">26</xsl:when>
            <xsl:when test="b:lbBasis = 'F2'">26</xsl:when>
            <xsl:when test="b:lbBasis = 'G'">0</xsl:when>
            <xsl:when test="b:lbBasis = 'S'">0</xsl:when>
            <xsl:when test="b:lbBasis = 'W'">0</xsl:when>
            <xsl:when test="b:lbBasis = 'W1'">0</xsl:when>
            <xsl:when test="b:lbBasis = 'U'">19</xsl:when>
            <xsl:when test="b:lbBasis = 'O'">19</xsl:when>
         </xsl:choose>
      </paidLegAccrualRule>
   </xsl:template>
   <xsl:template name="paidLegPaymentFrequencyNumber">
      <paidLegPaymentFrequencyNumber>
         <xsl:choose>
            <xsl:when test="substring (b:lbTypeGroup/b:lbDateFreq,9,1) = 'M'">
               <xsl:value-of select="substring (b:lbTypeGroup/b:lbDateFreq,10,2)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="0"/>
            </xsl:otherwise>
         </xsl:choose>
      </paidLegPaymentFrequencyNumber>
   </xsl:template>
   <xsl:template name="paidLegPaymentFrequencyUnit">
      <paidLegPaymentFrequencyUnit>
         <xsl:choose>
            <xsl:when test="substring (b:lbTypeGroup/b:lbDateFreq,9,1) = 'M'">
               <xsl:value-of select="4"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="0"/>
            </xsl:otherwise>
         </xsl:choose>
      </paidLegPaymentFrequencyUnit>
   </xsl:template>
	<xsl:template name="infra:userDefinedField">
			<xsl:if test="b:lbrfrConvention">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'market_conv_method_e'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:lbrfrConvention = 'PLAIN.ARREARS'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:lbrfrConvention = 'LOOK BACK'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:lbrfrConvention = 'LOCK OUT' or b:lbrfrConvention = 'RESET.CUTOFF'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
						<xsl:when test="b:lbrfrConvention = 'LOOKBACK WITH LOCKOUT'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'0'"/>
						</xsl:otherwise>
				</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:lbrfrCalcMethod">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'comp_freq_n'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:lbrfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:lbrfrCalcMethod">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'comp_freq_unit_e'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:lbrfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'Day'"/>
					</xsl:if>
				</infra:value>
			</infra:userDefinedField> 
			</xsl:if>
			<xsl:if test="b:lbrfrCalcMethod">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'comp_conv_e'"/>
				</infra:name>
				<infra:value>
					<xsl:if test="b:lbrfrCalcMethod = 'COMPOUND'">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:lbrfrSpreadTreatment">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'spread_inclusive_f'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="b:lbrfrSpreadTreatment = 'SPREAD.EXCLUSIVE'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:lbrfrSpreadTreatment = 'SPREAD.INCLUSIVE'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:lbrfrAdjSpread">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'add_margin_p'"/>
				</infra:name>
				<infra:value>
						<xsl:value-of select="b:lbrfrAdjSpread"/>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:rfrRounding">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'ai_round_unit_e'"/>
				</infra:name>
				<infra:value>
						<xsl:value-of select="b:rfrRounding"/>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>
			<xsl:if test="b:lbrfrPaymentDelay">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'payment_delay_n'"/>
				</infra:name>
				<infra:value>
						<xsl:value-of select="b:lbrfrPaymentDelay"/>
				</infra:value>
			</infra:userDefinedField>
			</xsl:if>		
	</xsl:template>
   <xsl:template name="paidLegCalendar"/>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="active"/>
   <xsl:template name="averagePeriodNumber"/>
   <xsl:template name="averagePeriodUnit"/>
   <xsl:template name="averaging"/>
   <xsl:template name="backset"/>
   <xsl:template name="backsetDelayPeriodNumber"/>
   <xsl:template name="backsetDelayPeriodUnit"/>
   <xsl:template name="businessDayConvention"/>
   <xsl:template name="capitalGainTax"/>
   <xsl:template name="compoundingConvention"/>
   <xsl:template name="compoundingFrequencyNumber"/>
   <xsl:template name="compoundingFrequencyUnit"/>
   <xsl:template name="decompoundingConvention"/>
   <xsl:template name="interestRateConvention"/>
   <xsl:template name="lengthSwapNumber"/>
   <xsl:template name="lengthSwapUnit"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="nominalExchangeRule"/>
   <xsl:template name="paidLegEomConvention"/>
   <xsl:template name="paidLegYieldCurve"/>
   <xsl:template name="paymentDayCalcConvention"/>
   <xsl:template name="priceCalculationRule"/>
   <xsl:template name="provider"/>
   <xsl:template name="receivedLegAdditiveMargin"/>
   <xsl:template name="receivedLegEomConvention"/>
   <xsl:template name="receivedLegYieldCurve"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskCurrency"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="valuationRule"/>
   <xsl:template name="valuedays"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\FinancialInstrumentIRS\TTI-FinancialInstrumentIRSfilter.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\FinancialInstrumentIRS\FinancialInstrumentIRSGWPACK1.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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