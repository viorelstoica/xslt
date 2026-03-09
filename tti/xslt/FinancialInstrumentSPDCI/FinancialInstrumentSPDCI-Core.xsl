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
                <xsl:value-of select="b:tapRefId"/>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>           
            </xsl:otherwise>
          </xsl:choose>     
      </infra:code>
   </xsl:template>
   <xsl:template name="synonym"/>
   <xsl:template name="shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="b:description"/>
            </xsl:when>
            <xsl:otherwise>
		         <xsl:if test="b:alternateCcy2='' or not(b:alternateCcy2)">
		            <xsl:value-of select="concat('DCI','/',b:tradeCcy,'/',b:alternateCcy1,'/',b:interestRate,'/',translate(b:maturityDate,'-',''))"/>
		         </xsl:if>
		         <xsl:if test="b:alternateCcy2!='' or b:alternateCcy2">
		            <xsl:value-of select="concat('TCI','/',b:tradeCcy,'/',b:alternateCcy1,'/',b:interestRate,'/',translate(b:maturityDate,'-',''))"/>
		         </xsl:if>            
            </xsl:otherwise>
         </xsl:choose>
      </infra:shortName>
   </xsl:template>
   <xsl:template name="longName">
      <infra:longName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="b:description"/>
            </xsl:when>
            <xsl:otherwise>
                 <xsl:if test="b:alternateCcy2='' or not(b:alternateCcy2)">
                    <xsl:value-of select="concat('DCI','/',b:tradeCcy,'/',b:alternateCcy1,'/',b:interestRate,'/',translate(b:maturityDate,'-',''))"/>
                 </xsl:if>
                 <xsl:if test="b:alternateCcy2!='' or b:alternateCcy2">
                    <xsl:value-of select="concat('TCI','/',b:tradeCcy,'/',b:alternateCcy1,'/',b:interestRate,'/',translate(b:maturityDate,'-',''))"/>
                 </xsl:if>            
            </xsl:otherwise>
         </xsl:choose>
      </infra:longName>
   </xsl:template>
   <xsl:template name="multilingualLongName"/>
   <xsl:template name="notepad"/>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="fixingCurrency">
        <xsl:if test="b:exerciseCcy">
            <fixingCurrency>
                <infra:code>
                    <xsl:value-of select="b:exerciseCcy"/>
                </infra:code>
            </fixingCurrency>
        </xsl:if>
   </xsl:template>   
   <xsl:template name="genericFlag">
      <genericFlag>
         <xsl:value-of select=" '0' "/>
      </genericFlag>
   </xsl:template>
   <xsl:template name="accrualRule">
      <accrualRule>
         <xsl:choose>
            <xsl:when test="b:dayBasis != ' ' and contains('A A1 A2 A3',b:dayBasis)">24</xsl:when>
            <xsl:when test="b:dayBasis = 'B'">31</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('C C1',b:dayBasis)">19</xsl:when>
            <xsl:when test="b:dayBasis = 'C2'">20</xsl:when>
            <xsl:when test="b:dayBasis = 'D'">13</xsl:when>
            <xsl:when test="b:dayBasis = 'E'">29</xsl:when>
            <xsl:when test="b:dayBasis = 'E1'">30</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('F F1 F2',b:dayBasis)">26</xsl:when>
            <xsl:when test="b:dayBasis != ' ' and contains('G S W W1',b:dayBasis)">0</xsl:when>
         </xsl:choose>
      </accrualRule>
   </xsl:template>
   <xsl:template name="accruedInterestCalculation"/>
   <xsl:template name="accruedInterestRoundingRule"/>
   <xsl:template name="accruedInterestRoundingUnit"/>
   <xsl:template name="active">
      <active>
         <xsl:value-of select=" '1' "/>
      </active>
   </xsl:template>
   <xsl:template name="beginDate">
      <beginDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </beginDate>
   </xsl:template>
   <xsl:template name="commonReference">
      <commonReference>
         <xsl:value-of select="b:syDxReference"/>
      </commonReference>
   </xsl:template>
   <xsl:template name="endDate">
      <endDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </endDate>
   </xsl:template>
   <xsl:template name="complexityLevel"/>
   <xsl:template name="convertInterest">
       <convertInterest>
            <xsl:choose>
	            <xsl:when test="b:convertInterest = 'Y'">
	               <xsl:value-of select='2'/>
	            </xsl:when>
	            <xsl:when test="b:convertInterest = 'N'">
	                <xsl:value-of select='1'/>
	            </xsl:when>
	            <xsl:otherwise>
	                <xsl:value-of select='0'/>
	            </xsl:otherwise>
            </xsl:choose>
        </convertInterest>       
   </xsl:template>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="interestRate">
      <interestRate>
         <xsl:value-of select="b:interestRate"/>
      </interestRate>
   </xsl:template>
   <xsl:template name="islamicCompliance"/> 
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="marketDirectiveCategory"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select=" '1' "/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:tradeCcy"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subNature">
      <subNature>
         <xsl:choose>
            <xsl:when test="b:alternateCcy2">
                 <xsl:value-of select=" '86' "/>        
            </xsl:when>
            <xsl:otherwise>
                 <xsl:value-of select=" '85' "/>                        
            </xsl:otherwise>
         </xsl:choose>
      </subNature>
   </xsl:template>
   <xsl:template name="subType"/>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
      <type>
         <infra:code>
            <xsl:value-of select=" 'SY_DCI' "/>
         </infra:code>
      </type>
   </xsl:template>
   <xsl:template name="valuationRule">
        <valuationRule>
		       <xsl:choose>
		            <xsl:when test="$DCI_VALUATION_RULE != ''">
		                <xsl:value-of select="$DCI_VALUATION_RULE"/>
		            </xsl:when>
		            <xsl:otherwise>
		                <xsl:value-of select=" '1' "/>            
		            </xsl:otherwise>
		       </xsl:choose>
       </valuationRule>
   </xsl:template>
   <xsl:template name="category"/>
   <xsl:template name="knockInDate"/>
   <xsl:template name="knockOutDate"/>
   <xsl:template name="underlying"/>
   <xsl:template name="usageNature"/>
   <!--  Dummy Price of 1 -->
   <xsl:template name="price">
        <Price>
		      <instrument>
			      <infra:code>
			         <xsl:choose>
			            <xsl:when test="b:tapRefId">
			                <xsl:value-of select="b:tapRefId"/>
			            </xsl:when>
			            <xsl:otherwise>
			                 <xsl:value-of select=" concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic) "/>           
			            </xsl:otherwise>
			          </xsl:choose>     
			      </infra:code>
		      </instrument>
                <quotationDate>
			         <xsl:call-template name="xsdate">
			            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
			         </xsl:call-template>
		         </quotationDate>		   
		      <value>1</value>
        </Price>
   </xsl:template>
   <!-- Composition 1 for SPDCIMM -->
   <xsl:template name="instrument_MM">
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
   <xsl:template name="compositeInstrument_MM">
      <compositeInstrument>
         <infra:code>
             <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_MM')"/>
                </xsl:when>
                <xsl:otherwise>
                 <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'MM')"/>
                </xsl:otherwise>
              </xsl:choose>           
         </infra:code>
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate_MM">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank_MM">
      <rank>
         <xsl:value-of select="'1'"/>
      </rank>
   </xsl:template>
   <xsl:template name="value_MM">
      <value>
         <xsl:value-of select="b:depositAmount"/>
      </value>
   </xsl:template>
   <xsl:template name="cheapest_MM"/>
   <xsl:template name="conversionFactor_MM"/>
   <xsl:template name="conversionRatio_MM"/>
   <xsl:template name="divisor_MM"/>
   <xsl:template name="endDate_MM"/>
   <xsl:template name="mbFields_MM"/>
   <xsl:template name="basketBarrier_MM"/>
   <xsl:template name="basketBarrierPercent_MM"/>
   <xsl:template name="basketExcercicePrice_MM"/>
   <xsl:template name="basketExcercicePricePercent_MM"/>
   <xsl:template name="basketInitialFixingPrice_MM"/>
   <xsl:template name="basketWeight_MM"/>

	<!-- Composition 2 for SPDCIFX -->
   <xsl:template name="instrument_FX">
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
   <xsl:template name="compositeInstrument_FX">
      <compositeInstrument>
         <infra:code>
             <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_FX')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'FX')"/>
                </xsl:otherwise>
              </xsl:choose>    
         </infra:code>
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate_FX">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank_FX">
      <rank>
         <xsl:value-of select="'1'"/>
      </rank>
   </xsl:template>
   <xsl:template name="value_FX">
      <value>
         <xsl:value-of select="b:depositAmount"/>
      </value>
   </xsl:template>
   <xsl:template name="cheapest_FX"/>
   <xsl:template name="conversionFactor_FX"/>
   <xsl:template name="conversionRatio_FX"/>
   <xsl:template name="divisor_FX"/>
   <xsl:template name="endDate_FX"/>
   <xsl:template name="mbFields_FX"/>
   <xsl:template name="basketBarrier_FX"/>
   <xsl:template name="basketBarrierPercent_FX"/>
   <xsl:template name="basketExcercicePrice_FX"/>
   <xsl:template name="basketExcercicePricePercent_FX"/>
   <xsl:template name="basketInitialFixingPrice_FX"/>
   <xsl:template name="basketWeight_FX"/>

	<!-- Composition 3 for SPDCFX_2 -->
   <xsl:template name="instrument_FX2">
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
   <xsl:template name="compositeInstrument_FX2">
      <compositeInstrument>
         <infra:code>
             <xsl:choose>
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_FX2')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic,$COMPANY_POSTFIX_SEPARATOR,'FX',$COMPANY_POSTFIX_SEPARATOR,'2')"/>
                </xsl:otherwise>
              </xsl:choose>             
         </infra:code>
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate_FX2">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank_FX2">
      <rank>
         <xsl:value-of select="'1'"/>
      </rank>
   </xsl:template>
   <xsl:template name="value_FX2">
      <value>
         <xsl:value-of select="b:depositAmount"/>
      </value>
   </xsl:template>
   <xsl:template name="cheapest_FX2"/>
   <xsl:template name="conversionFactor_FX2"/>
   <xsl:template name="conversionRatio_FX2"/>
   <xsl:template name="divisor_FX2"/>
   <xsl:template name="endDate_FX2"/>
   <xsl:template name="mbFields_FX2"/>
   <xsl:template name="basketBarrier_FX2"/>
   <xsl:template name="basketBarrierPercent_FX2"/>
   <xsl:template name="basketExcercicePrice_FX2"/>
   <xsl:template name="basketExcercicePricePercent_FX2"/>
   <xsl:template name="basketInitialFixingPrice_FX2"/>
   <xsl:template name="basketWeight_FX2"/>
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