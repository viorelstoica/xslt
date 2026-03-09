<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFidOrderCob" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFidOrderCob" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiFdFidOrderCob">
      <xsl:apply-templates select="c:CurrentEvent/b:FdFidOrderCob"/>
   </xsl:template>
   <xsl:template match="batch:BatchFdFidOrderCob">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchFdFidOrderCob" name="BatchFdFidOrderCob">
         <xsl:apply-templates select="b:FdFidOrderCob"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiFdFidOrderCob">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiFdFidOrderCob" name="BatchMultiFdFidOrderCob">
         <xsl:apply-templates select="c:MultiFdFidOrderCob"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:FdFidOrderCob">
      <FiPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('FinInstrumentCloseFiduciaryCob',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <MoneyMarket>
               <SpecificMoneyMarket>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('FinInstrumentCloseFiduciaryCob.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="infra:code"/>
                  <xsl:call-template name="infra:synonym"/>
                  <xsl:call-template name="infra:shortName"/>
                  <xsl:call-template name="infra:longName"/>
                  <xsl:call-template name="infra:multilingualLongName"/>
                  <xsl:call-template name="infra:notepad"/>
                  <xsl:call-template name="infra:userDefinedField"/>
                  <xsl:call-template name="infra:mbFields"/>
                  <xsl:call-template name="accrualRule"/>
                  <xsl:call-template name="accruedInterestCalculation"/>
                  <xsl:call-template name="accruedInterestRoundingRule"/>
                  <xsl:call-template name="accruedInterestRoundingUnit"/>
                  <xsl:call-template name="accruedInterestUnitaryRounding"/>
                  <xsl:call-template name="active"/>
                  <xsl:call-template name="euroConversionDate"/>
                  <xsl:call-template name="euroConversionRule"/>
                  <xsl:call-template name="euroNewInstrument"/>
                  <xsl:call-template name="mainBusinessEntity"/>
                  <xsl:call-template name="priceCalculationRule"/>
                  <xsl:call-template name="referenceCurrency"/>
                  <xsl:call-template name="riskCountry"/>
                  <xsl:call-template name="riskNature"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="taxCountry"/>
                  <xsl:call-template name="tradable"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="valuationRule"/>
                  <xsl:call-template name="noticeDay"/>
                  <xsl:call-template name="provider"/>
                  <xsl:call-template name="yieldCurve"/>
                  <xsl:call-template name="closingDate"/>
                  <xsl:call-template name="interestRate"/>
				  <xsl:call-template name="issuer"/>
				  <xsl:call-template name="nextPayDay"/>
                  <xsl:call-template name="openingDate"/>
				  <xsl:call-template name="paymentFrequency"/>
				  <xsl:call-template name="paymentFrequencyDay"/>
				  <xsl:call-template name="paymentFrequencyUnit"/>
                  <xsl:call-template name="portfolio"/>
				  <xsl:call-template name="subNature"/>
				  <xsl:call-template name="tenorFrequency"/>
				  <xsl:call-template name="tenorFrequencyUnit"/>
				  <xsl:call-template name="usageNature"/>
               </SpecificMoneyMarket>
            </MoneyMarket>
         </DataGroup>
      </FiPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionFiduciaryInitiate" userelativepaths="yes" externalpreview="no" url="..\..\testfiles\FdFidOrder\FdFidOrder.xml" htmlbaseurl="" outputurl="..\..\testfiles\FdFidOrder\FdFidOrderGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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