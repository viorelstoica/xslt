<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/SyAccuDecu" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyAccuDecu" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
   <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
   <xsl:template match="c:MultiTransactionSPAccuDecuClose">
      <xsl:apply-templates select="c:CurrentEvent/b:SyAccuDecu"/>
   </xsl:template>
   <xsl:template match="batch:BatchSyAccuDecu">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchSyAccuDecu" name="BatchSyAccuDecu">
         <xsl:apply-templates select="b:SyAccuDecu"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="multibatch:BatchMultiSyAccuDecu">
      <xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiSyAccuDecu" name="BatchMultiSyAccuDecu">
         <xsl:apply-templates select="c:MultiSyAccuDecu"/>
      </xsl:element>
   </xsl:template>
   <xsl:template match="b:SyAccuDecu">
      <TransactionPMS mode="INSUPD">
         <xsl:attribute name="output">
            <xsl:value-of select="concat('SYBlockUnblockSecPos',b:id)"/>
         </xsl:attribute>
         <DataGroup>
            <Security>
               <xsl:attribute name="description">
                  <xsl:value-of select="concat('SYBlockUnblockSecPos.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
               </xsl:attribute>
               <xsl:attribute name="sequenceNumber">
                  <xsl:call-template name="calcSeqNum">
                     <xsl:with-param name="creationTime">
                        <xsl:value-of select="b:eventCommon/ns0:creationTime"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:attribute>
               <locking>
                  <xsl:call-template name="accountingCode"/>
                  <xsl:call-template name="accountingDate"/>
                  <xsl:call-template name="cashPortfolio"/>
                  <xsl:call-template name="commonReference"/>
                  <xsl:call-template name="contractNumber"/>
                  <xsl:call-template name="depositaryAccount"/>
                  <xsl:call-template name="endDate"/>
                  <xsl:call-template name="initiatedBy"/>
                  <xsl:call-template name="lockingDate"/>
                  <xsl:call-template name="lockingTransactionCode"/>
                  <xsl:call-template name="lockingType"/>
                  <xsl:call-template name="lockingUnlocking"/>
                  <xsl:call-template name="notepad"/>
                  <xsl:call-template name="portfolioManager"/>
                  <xsl:call-template name="positionCriteria1"/>
                  <xsl:call-template name="positionCriteria2"/>
                  <xsl:call-template name="positionCriteria3"/>
                  <xsl:call-template name="portfolio"/>
                  <xsl:call-template name="quantity"/>
                  <xsl:call-template name="remark"/>
                  <xsl:call-template name="reversalIndicator"/>
                  <xsl:call-template name="reversedTransactionCode"/>
                  <xsl:call-template name="security"/>
                  <xsl:call-template name="sourceSystemCode"/>
                  <xsl:call-template name="status"/>
                  <xsl:call-template name="subType"/>
                  <xsl:call-template name="trader"/>
                  <xsl:call-template name="transactionCode"/>
                  <xsl:call-template name="transactionCurrency"/>
                  <xsl:call-template name="type"/>
                  <xsl:call-template name="validityDate"/>
                  <xsl:call-template name="valueDate"/>
                  <xsl:call-template name="userDefinedField"/>
                  <xsl:call-template name="mbFields"/>
               </locking>
            </Security>
         </DataGroup>
      </TransactionPMS>
   </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="SYBlockUnblockSecPos" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\SYBlockUnblockAccPos\SYBlockUnblockAccPosFilter.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\SYBlockUnblockSecPos\SYBlockUnblockSecPosGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
		          postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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