<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/OptionPosition" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchOptionPosition" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOptionPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiOptionPosition" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiOptionPosition">
      <xsl:apply-templates select="c:CurrentEvent/b:OptionPosition"/>
   </xsl:template>
   <xsl:template match="batch:BatchOptionPosition">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchOptionPosition" name="BatchOptionPosition">
         <xsl:apply-templates select="b:OptionPosition"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiOptionPosition">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiOptionPosition" name="BatchMultiOptionPosition">
         <xsl:apply-templates select="c:MultiOptionPosition"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:OptionPosition">
      <PositionPMS>
         <xsl:attribute name="mode">INSUPD</xsl:attribute>
         <xsl:variable name="securityNo">
            <xsl:value-of select="concat(b:contractCode,'/',b:tradeCcy,'/',b:maturityDate,'/',b:callPut,'/',b:strike,'/',b:deliveryCcy,'/',b:optionStyle,'/',b:optionTypeGroup/b:optionType,'/',substring-after(substring-after(b:repPositionKey,':'),':'))"/>
         </xsl:variable>
         <xsl:attribute name="output">
            <xsl:value-of select="concat('optionPosition',translate($securityNo,'/',''))"/>
         </xsl:attribute>
         <DataGroup>
            <xsl:for-each select="b:transactionIdsGroup">
               <SecuritiesPosition>
                  <xsl:attribute name="description">
                     <xsl:value-of select="concat('OptionPosition.xsl+', name(/*), '+', ../b:eventCommon/ns0:eventId, '+', ../b:eventCommon/ns0:creationTime)"/>
                  </xsl:attribute>
                  <xsl:attribute name="sequenceNumber">
                     <xsl:call-template name="calcSeqNum">
                        <xsl:with-param name="creationTime">
                           <xsl:value-of select="../b:eventCommon/ns0:creationTime"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:attribute>
                  <xsl:call-template name="accruedInterests"/>
                  <xsl:call-template name="deposit">
                     <xsl:with-param name="positionIndex" select="@index"/>
                  </xsl:call-template>
                  <xsl:call-template name="historicalExchangeRate">
                     <xsl:with-param name="positionIndex" select="@index"/>
                  </xsl:call-template>
                  <xsl:call-template name="historicalInstrExchRate"/>
                  <xsl:call-template name="historicalPrice"/>
                  <xsl:call-template name="historicalNetAmount"/>
                  <xsl:call-template name="initialLoadDate"/>
                  <xsl:call-template name="initialLoadPrice"/>
                  <xsl:call-template name="instrument"/>
                  <xsl:call-template name="intermediary"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="positionCode"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="positionCurrency"/>
                  <xsl:call-template name="positionValueDate"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="referenceNature"/>
                  <xsl:call-template name="referenceOperationCode"/>
                  <xsl:call-template name="sourceCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="bookExchangeRate"/>
                  <xsl:call-template name="bookPrice"/>
                  <xsl:call-template name="bookNetAmount"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
               </SecuritiesPosition>
            </xsl:for-each>
         </DataGroup>
      </PositionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="CashAccountTypeType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CashAccountType\CashAccountType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CashAccountType\CashAccountTypeGWP.xml"
		          processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="InstrumentType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\InstrumentType\InstrumentType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\InstrumentType\InstrumentTypeGWP.xml" processortype="saxon8"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="no" name="OperationType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\OperationType\OperationType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\OperationType\OperationType_GWP.xml" processortype="jaxp"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
		<scenario default="yes" name="OptionPosition" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\OptionPosition\OptionPosition.xml" htmlbaseurl="" outputurl="..\..\TestFiles\OptionPosition\OptionPositionGWP.xml" processortype="jaxp"
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