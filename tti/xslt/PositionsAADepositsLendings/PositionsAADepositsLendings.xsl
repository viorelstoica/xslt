<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsAADepositsLendings" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsAADepositsLendings" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsAADepositsLendings" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsAADepositsLendings" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiPositionsAADepositsLendings">
      <xsl:apply-templates select="c:CurrentEvent/b:PositionsAADepositsLendings"/>
   </xsl:template>
   <xsl:template match="batch:BatchPositionsAADepositsLendings">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchPositionsAADepositsLendings" name="BatchPositionsAADepositsLendings">
         <xsl:apply-templates select="b:PositionsAADepositsLendings"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiPositionsAADepositsLendings">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsAADepositsLendings" name="BatchMultiPositionsAADepositsLendings">
         <xsl:apply-templates select="c:MultiPositionsAADepositsLendings"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:PositionsAADepositsLendings">
      <PositionPMS mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('PositionsAADepositsLendings',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <DepositLoansPosition>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('PositionsAADepositsLendings.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <xsl:call-template name="accruedInterests"/>
               <xsl:call-template name="amount"/>
               <xsl:call-template name="expirationDate"/>
               <xsl:call-template name="initialLoadDate"/>
               <xsl:call-template name="moneyMarket"/>
               <xsl:call-template name="operationDate"/>
               <xsl:call-template name="portfolio"/>
               <xsl:call-template name="positionCode"/>
               <xsl:call-template name="positionCurrency"/>
               <xsl:call-template name="positionExchangeRate"/>
               <xsl:call-template name="referenceNature"/>
               <xsl:call-template name="sourceCode"/>
               <xsl:call-template name="status"/>
               <xsl:call-template name="type"/>
               <xsl:call-template name="valueDate"/>
               <xsl:call-template name="interestRate"/>
               <xsl:call-template name="userDefinedField"/>
               <xsl:call-template name="mbFields"/>
            </DepositLoansPosition>
         </DataGroup>
      </PositionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="PositionsAADepositsLendings" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PositionsAADepositsLendings\PositionsAADepositsLendings.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PositionsAADepositsLendings\PositionsAADepositsLendingsCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
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