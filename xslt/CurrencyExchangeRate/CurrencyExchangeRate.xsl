<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CurrencyExchangeRate" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCurrencyExchangeRate" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCurrencyExchangeRate" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCurrencyExchangeRate" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiCurrencyExchangeRate">
      <xsl:apply-templates select="c:CurrentEvent/b:CurrencyExchangeRate"/>
   </xsl:template>
   <xsl:template match="batch:BatchCurrencyExchangeRate">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchCurrencyExchangeRate" name="BatchCurrencyExchangeRate">
         <xsl:apply-templates select="b:CurrencyExchangeRate"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiCurrencyExchangeRate">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiCurrencyExchangeRate" name="BatchMultiCurrencyExchangeRate">
         <xsl:apply-templates select="c:MultiCurrencyExchangeRate"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:CurrencyExchangeRate">
      <InfraPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('currencyExchangeRate',b:currencyCode)"/>
         </xsl:attribute><!--  get the eurp in rate - will return empty if does not exist -->
         <xsl:variable name="euroInCcyRate">
            <xsl:call-template name="euroinRate">
               <xsl:with-param name="ISOcurrency">
                  <xsl:value-of select="b:currencyCode"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:variable>
         <DataGroup><!-- midRevalRate -->
            <xsl:for-each select="b:currencyMarketGroup[
                                        ($CCY_MARKETS_TO_MAP = 'ALL' or contains($CCY_MARKETS_TO_MAP, concat(b:currencyMarket,' '))) and
                                        ($CCY_MAP_REVAL_RATE = 'MAP_REVAL_IF_PRESENT' and (b:midRevalRate or b:revalRate)
                                         or
                                        ($CCY_MAP_REVAL_RATE = 'ONLY_REVAL_RATES' and b:revalRate)
                                        )					                                       
					                     ]">
               <ExchangeRate>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('CurrencyExchangeRate.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_midRevalRate"/>
                  <xsl:call-template name="datetime_midRevalRate"/>
                  <xsl:call-template name="market_midRevalRate"/>
                  <xsl:call-template name="provider_midRevalRate"/>
                  <xsl:call-template name="rate_midRevalRate"/>
                  <xsl:call-template name="type_midRevalRate"/>
                  <xsl:call-template name="underlyCurrency_midRevalRate"/>
                  <xsl:call-template name="quoteFactor_midRevalRate"/>
                  <xsl:call-template name="inverseFlag_midRevalRate"/>
                  <xsl:call-template name="exchangeRateInverseFlag_midRevalRate"/>
                  <xsl:call-template name="mbFields_midRevalRate"/>
               </ExchangeRate>
            </xsl:for-each><!-- sellRate -->
            <xsl:for-each select="b:currencyMarketGroup[($CCY_MARKETS_TO_MAP = 'ALL' or contains($CCY_MARKETS_TO_MAP, concat(b:currencyMarket,' '))) and 
                                    b:sellRate and $CCY_MAP_BUY_SELL = 'Y']">
               <ExchangeRate>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('CurrencyExchangeRate.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_sellRate"/>
                  <xsl:call-template name="datetime_sellRate"/>
                  <xsl:call-template name="market_sellRate"/>
                  <xsl:call-template name="provider_sellRate"/>
                  <xsl:call-template name="rate_sellRate"/>
                  <xsl:call-template name="type_sellRate"/>
                  <xsl:call-template name="underlyCurrency_sellRate"/>
                  <xsl:call-template name="quoteFactor_sellRate"/>
                  <xsl:call-template name="inverseFlag_sellRate"/>
                  <xsl:call-template name="exchangeRateInverseFlag_sellRate"/>
                  <xsl:call-template name="mbFields_sellRate"/>
               </ExchangeRate>
            </xsl:for-each><!-- buyRate -->
            <xsl:for-each select="b:currencyMarketGroup[($CCY_MARKETS_TO_MAP = 'ALL' or contains($CCY_MARKETS_TO_MAP, concat(b:currencyMarket,' '))) and
                                    b:buyRate and $CCY_MAP_BUY_SELL = 'Y']">
               <ExchangeRate>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('CurrencyExchangeRate.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="currency_buyRate"/>
                  <xsl:call-template name="datetime_buyRate"/>
                  <xsl:call-template name="market_buyRate"/>
                  <xsl:call-template name="provider_buyRate"/>
                  <xsl:call-template name="rate_buyRate"/>
                  <xsl:call-template name="type_buyRate"/>
                  <xsl:call-template name="underlyCurrency_buyRate"/>
                  <xsl:call-template name="quoteFactor_buyRate"/>
                  <xsl:call-template name="inverseFlag_buyRate"/>
                  <xsl:call-template name="exchangeRateInverseFlag_buyRate"/>
                  <xsl:call-template name="mbFields_buyRate"/>
               </ExchangeRate>
            </xsl:for-each>
         </DataGroup>
      </InfraPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="no" name="Currency" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Currency\Currency.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Currency\CurrencyGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="yes" name="CurrencyExchangeRate" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CurrencyExchangeRate\CurrencyExchangeRate.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\CurrencyExchangeRate\CurrencyExchangeRateCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="no" name="CurrencyExchangeRateUSD" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CurrencyExchangeRate\CurrencyExchangeRateUSD.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\CurrencyExchangeRate\CurrencyExchangeRateUSDGWP.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
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