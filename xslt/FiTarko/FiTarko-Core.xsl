<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/StructuredProducts"
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyFxForwards"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyFxForwards"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c d"
                version="1.0">
   <xsl:template name="infra:code">
      <infra:code>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="b:tapRefId"/>
            </xsl:when>
            <xsl:otherwise>
         <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
            </xsl:otherwise>
         </xsl:choose>
      </infra:code>   
   </xsl:template>
   <xsl:template name="infra:synonym"/>
   <xsl:template name="infra:shortName">
      <infra:shortName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="b:descriptionList/b:description"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('TARKO','/',b:id,'/',b:maturityDate,'/',b:currencyBought,'/',b:currencySold)"/>
            </xsl:otherwise>
         </xsl:choose>           
      </infra:shortName>
   </xsl:template>
   <xsl:template name="infra:longName">
      <infra:longName>
         <xsl:choose>
            <xsl:when test="b:tapRefId">
                <xsl:value-of select="b:descriptionList/b:description"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('TARKO','/',b:id,'/',b:maturityDate,'/',b:currencyBought,'/',b:currencySold)"/>
            </xsl:otherwise>
         </xsl:choose>  
      </infra:longName>
   </xsl:template>
   <xsl:template name="infra:multilingualLongName"/>
   <xsl:template name="infra:notepad"/>
   <xsl:template name="infra:userDefinedField"/>
   <xsl:template name="infra:mbFields"/>
   <xsl:template name="subNature">
      <subNature>
	  	<xsl:choose>
			<xsl:when test="b:variant != ''">
				<xsl:choose>
					<xsl:when test="b:subAssetTypeIdVariant= $SY_SAT_FXFWD ">
						<xsl:value-of select="94"/>
					</xsl:when>
					<xsl:when test="b:subAssetTypeIdVariant= $SY_SAT_TARKO ">
						<xsl:value-of select="95"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:subAssetTypeTapInstrTypeVariant and b:subAssetTypeTapInstrTypeVariant = 'PFWD' ">
								<xsl:value-of select="94"/>
							</xsl:when>
							<xsl:when test="b:subAssetTypeTapInstrTypeVariant and b:subAssetTypeTapInstrTypeVariant = 'TARKO' ">
								<xsl:value-of select="95"/>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
		 		</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="b:subAssetTypeId= $SY_SAT_FXFWD ">
						<xsl:value-of select="94"/>
					</xsl:when>
					<xsl:when test="b:subAssetTypeId= $SY_SAT_TARKO ">
						<xsl:value-of select="95"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType = 'PFWD' ">
								<xsl:value-of select="94"/>
							</xsl:when>
							<xsl:when test="b:subAssetTypeTapInstrType and b:subAssetTypeTapInstrType = 'TARKO' ">
								<xsl:value-of select="95"/>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
      </subNature>
   </xsl:template>
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
   <xsl:template name="category">
      <category>0</category>
   </xsl:template>    
   <xsl:template name="commonReference">
      <xsl:if test="b:transactionRef != ''">
         <commonReference>
            <xsl:value-of select="b:transactionRef"/>
         </commonReference>
      </xsl:if>
   </xsl:template>
   <xsl:template name="compundingFrequency"/>
   <xsl:template name="compundingFrequencyUnit"/>
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
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:maturityDate,'-','')"/>
         </xsl:call-template>
      </endDate>
   </xsl:template>
   <xsl:template name="euroConversionDate"/>
   <xsl:template name="euroConversionRule"/>
   <xsl:template name="euroNewInstrument"/>
   <xsl:template name="eventType">
   <xsl:variable name="opStatus">
         <xsl:call-template name="operationStatus">
            <xsl:with-param name="transactionStage" select="b:eventCommon/d:transactionStage"/>
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
			<xsl:when test= "b:contractStatus and b:contractStatus = 'KNOCKEDOUT'">
				<xsl:value-of select="'1'"/>
			</xsl:when>
			<xsl:when test= "$opStatus = 'REVERSE-AUTHORISE'">
				<xsl:value-of select="'4'"/>
			</xsl:when>
		</xsl:choose>
	</eventType>
</xsl:template>
   <xsl:template name="issuer"/>
   <xsl:template name="mainBusinessEntity"/>
   <xsl:template name="mainStockExchange"/>
   <xsl:template name="parentInstrument"/>
   <xsl:template name="priceCalculationRule">
      <priceCalculationRule>
         <xsl:value-of select="'1'"/>
      </priceCalculationRule>
   </xsl:template>
   <xsl:template name="referenceCurrency">
      <referenceCurrency>
         <infra:code>
            <xsl:value-of select="b:currencySold"/>
         </infra:code>
      </referenceCurrency>
   </xsl:template>
   <xsl:template name="genericFlag"/>
   <xsl:template name="riskLevel"/>
   <xsl:template name="riskCountry"/>
   <xsl:template name="riskNature"/>
   <xsl:template name="subType">
	<subType>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:variant != ''">
					<xsl:value-of select="b:subAssetTypeIdVariant"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:subAssetTypeId"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</subType>
   </xsl:template>
   <xsl:template name="taxCountry"/>
   <xsl:template name="tradable"/>
   <xsl:template name="type">
   	<type>
		<infra:code>
			<xsl:choose>
				<xsl:when test="b:variant != ''">
					<xsl:value-of select="b:assetTypeCodeVariant"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:assetTypeCode"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:code>
	</type>
   </xsl:template>
   <xsl:template name="underlying"/>
   <xsl:template name="valuationRule">
      <valuationRule>
         <xsl:value-of select="'1'"/>
      </valuationRule>
   </xsl:template>
   <xsl:template name="usageNature"/>
   <xsl:template name="instrument1">
      <instrument>
         <infra:code>
             <xsl:choose>             
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>           
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="compositeInstrument1">
      <compositeInstrument>
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
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate1">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank1">
      <rank>
         <xsl:value-of select=" '1' "/>
      </rank>
   </xsl:template>
   <xsl:template name="value1">
      <xsl:if test="b:bTotalCallAmt != ''">
         <value>
            <xsl:value-of select="b:bTotalCallAmt"/>
         </value>
      </xsl:if>
   </xsl:template>
   <xsl:template name="cheapest_Composition1"/>
   <xsl:template name="conversionFactor_Composition1"/>
   <xsl:template name="conversionRatio_Composition1"/>
   <xsl:template name="divisor_Composition1"/>
   <xsl:template name="endDate_Composition1"/>
   <xsl:template name="mbFields_Composition1"/>
   <xsl:template name="basketBarrier1"/>
   <xsl:template name="basketBarrierPercent1"/>
   <xsl:template name="basketExercicePrice1"/>
   <xsl:template name="basketExercicePricePercent1"/>
   <xsl:template name="basketInitialFixingPrice1"/>
   <xsl:template name="basketWeight1"/>
   <xsl:template name="instrument2">
      <instrument>
         <infra:code>
             <xsl:choose>             
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>  
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="compositeInstrument2">
      <compositeInstrument>
         <infra:code>
             <xsl:choose>             
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_PUT')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:sOptionType,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>            
         </infra:code>
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate2">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank2">
      <rank>
         <xsl:value-of select=" '1' "/>
      </rank>
   </xsl:template>
   <xsl:template name="value2">
      <xsl:if test="b:sTotalPutAmt != ''">
         <value>
            <xsl:value-of select="(-1 * b:sTotalPutAmt)"/>
         </value>
      </xsl:if>
   </xsl:template>
   <xsl:template name="cheapest_Composition2"/>
   <xsl:template name="conversionFactor_Composition2"/>
   <xsl:template name="conversionRatio_Composition2"/>
   <xsl:template name="divisor_Composition2"/>
   <xsl:template name="endDate_Composition2"/>
   <xsl:template name="mbFields_Composition2"/>
   <xsl:template name="basketBarrier2"/>
   <xsl:template name="basketBarrierPercent2"/>
   <xsl:template name="basketExercicePrice2"/>
   <xsl:template name="basketExercicePricePercent2"/>
   <xsl:template name="basketInitialFixingPrice2"/>
   <xsl:template name="basketWeight2"/>
   <xsl:template name="instrument3">
      <instrument>
         <infra:code>
             <xsl:choose>             
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="b:tapRefId"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>  
         </infra:code>
      </instrument>
   </xsl:template>
   <xsl:template name="compositeInstrument3">
      <compositeInstrument>
         <infra:code>
             <xsl:choose>             
                <xsl:when test="b:tapRefId">
                    <xsl:value-of select="concat(b:tapRefId, '_VANILLA')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('TARKO',$COMPANY_POSTFIX_SEPARATOR,b:id,$COMPANY_POSTFIX_SEPARATOR,b:sOptionType,$COMPANY_POSTFIX_SEPARATOR,b:mnemonic)"/>
                </xsl:otherwise>
             </xsl:choose>          
         </infra:code>
      </compositeInstrument>
   </xsl:template>
   <xsl:template name="validityDate3">
      <validityDate>
         <xsl:call-template name="xsdate">
            <xsl:with-param name="date" select="translate(b:tradeDate,'-','')"/>
         </xsl:call-template>
      </validityDate>
   </xsl:template>
   <xsl:template name="rank3">
      <rank>
         <xsl:value-of select=" '1' "/>
      </rank>
   </xsl:template>
   <xsl:template name="value3">
      <xsl:if test="b:sTotalPutAmt != ''">
         <value>
            <xsl:value-of select="b:sTotalPutAmt"/>
         </value>
      </xsl:if>
   </xsl:template>
   <xsl:template name="cheapest_Composition3"/>
   <xsl:template name="conversionFactor_Composition3"/>
   <xsl:template name="conversionRatio_Composition3"/>
   <xsl:template name="divisor_Composition3"/>
   <xsl:template name="endDate_Composition3"/>
   <xsl:template name="mbFields_Composition3"/>
   <xsl:template name="basketBarrier3"/>
   <xsl:template name="basketBarrierPercent3"/>
   <xsl:template name="basketExercicePrice3"/>
   <xsl:template name="basketExercicePricePercent3"/>
   <xsl:template name="basketInitialFixingPrice3"/>
   <xsl:template name="basketWeight3"/>
</xsl:stylesheet>