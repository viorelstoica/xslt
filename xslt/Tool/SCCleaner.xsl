<?xml version="1.0" encoding="UTF-8"?>
<!-- xq332.xsl: converts xq331.xml into xq333.xml -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:INFRA="http://www.odcgroup.com/InfraPMS" xmlns:FI="http://www.odcgroup.com/FiPMS" xmlns:CLIENT="http://www.odcgroup.com/ClientPMS" xmlns:TRANSACTION="http://www.odcgroup.com/TransactionPMS" xmlns:POSITION="http://www.odcgroup.com/PositionPMS" xmlns:F2B="http://www.odcgroup.com/F2B" xmlns:F2B_MM_FX="http://www.odcgroup.com/F2B_MM_FX" xmlns:GENERICCOA="http://www.odcgroup.com/GenericCOA" xmlns:STRUCTP="http://www.odcgroup.com/StructuredProducts" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0">
  <xsl:output method="xml" omit-xml-declaration="no" encoding="UTF-8"/>
  <xsl:param name="apos">'</xsl:param>
  <xsl:param name="delim">,</xsl:param>
  <xsl:param name="cReturn" select="'&#10;'"/>
  <!-- ############################################################### -->
  <!-- MAIN TEMPLATE DEFINITION  -->
  <xsl:template name="globalReplace">
    <xsl:param name="outputString"/>
    <xsl:param name="target"/>
    <xsl:param name="replacement"/>
    <xsl:choose>
      <xsl:when test="contains($outputString,$target)">
        <xsl:value-of select="concat(substring-before($outputString,$target),                $replacement)"/>
        <xsl:call-template name="globalReplace">
          <xsl:with-param name="outputString" select="substring-after($outputString,$target)"/>
          <xsl:with-param name="target" select="$target"/>
          <xsl:with-param name="replacement" select="$replacement"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$outputString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="multiReplace">
    <xsl:param name="actualNode"/>
    <xsl:param name="listOfTarget"/>
    <xsl:param name="delimiter"/>
    <xsl:param name="listOfReplacement"/>
    <xsl:choose>
      <xsl:when test="contains($listOfTarget,$delimiter)">
        <xsl:variable name="currentTarget" select="substring-before($listOfTarget,$delimiter)"/>
        <xsl:variable name="currentReplacement" select="substring-before($listOfReplacement,$delimiter)"/>
        <xsl:variable name="localOutput">
          <xsl:call-template name="globalReplace">
            <xsl:with-param name="outputString" select="$actualNode"/>
            <xsl:with-param name="target" select="$currentTarget"/>
            <xsl:with-param name="replacement" select="$currentReplacement"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:call-template name="multiReplace">
          <xsl:with-param name="actualNode" select="$localOutput"/>
          <xsl:with-param name="listOfTarget" select="substring-after($listOfTarget,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
          <xsl:with-param name="listOfReplacement" select="substring-after($listOfReplacement,$delimiter)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="globalReplace">
          <xsl:with-param name="outputString" select="$actualNode"/>
          <xsl:with-param name="target" select="$listOfTarget"/>
          <xsl:with-param name="replacement" select="$listOfReplacement"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="doubleQuoteReplace">
    <xsl:variable name="globalListOfTarget" select="'&quot;'"/>
    <xsl:variable name="globalListOfReplacement" select="$apos"/>
    <xsl:call-template name="multiReplace">
      <xsl:with-param name="actualNode" select="."/>
      <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
      <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
      <xsl:with-param name="delimiter" select="$delim"/>
    </xsl:call-template>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- MATCH FOR ALL CODE -->
  <xsl:template match="  INFRA:code|  CLIENT:code|  CLIENT:postCode|  FI:code|  FI:requestCode|  STRUCTP:code|  STRUCTP:requestCode|  TRANSACTION:code|  TRANSACTION:reversedTransactionCode|  TRANSACTION:sourceSystemCode|  TRANSACTION:transactionCode|  TRANSACTION:contractReferenceCode|  TRANSACTION:contractReferenceCode|  TRANSACTION:originalOrderCode|  TRANSACTION:accountingCode|  TRANSACTION:referenceTransactionCode|  TRANSACTION:lockingTransactionCode|  TRANSACTION:lockingTransactionCode|  POSITION:code|  POSITION:positionCode|  F2B:code|  F2B:sourceSystemCode|  F2B_MM_FX:pmsReferenceCode|  F2B_MM_FX:closingpmsReferenceCode|  GENERICCOA:accountingCode|  GENERICCOA:reversedTransactionCode|  GENERICCOA:sourceSystemCode|  GENERICCOA:transactionCode|  GENERICCOA:code ">
    <!-- 
  ###########################
  REPLACEMENT CODED HERE :
   " 		: _
   ;		: _
   SPACE 	: _
   ! 		: _
   # 		: _
   % 		: _
   & 		: _
   ' 		: _
   ( 		: _
   ) 		: _
   : 		: _
   > 		: _
   < 		: _
   ? 		: _
   @ 		: _
   [ 		: _
   ] 		: _
   ^		: _
   `		: _
   {		: _
   }		: _
   |		: _
   ~		: _
   			
  ###########################
  -->
    <xsl:variable name="globalListOfTarget" select="concat(      '&quot;', $delim,      ';', $delim,      ' ', $delim,      '!', $delim,      '#', $delim,      '%', $delim,      '&amp;', $delim,      $apos, $delim,      '(', $delim,      ')', $delim,      ':', $delim,      '&gt;', $delim,      '&lt;', $delim,      '?', $delim,      '@', $delim,      '[', $delim,      ']', $delim,      '^', $delim,      '`', $delim,      '{', $delim,      '}', $delim,      '|', $delim,      '~'     )   "/>
    <xsl:variable name="globalListOfReplacement">
		<xsl:choose>
			<xsl:when test="local-name() = 'code' and local-name(..) = 'synonym'">
				<xsl:value-of select="concat(      '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '#', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,       '_'               )     "/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(      '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,       '_'               )     "/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	 
    <xsl:copy>
      <xsl:call-template name="multiReplace">
        <xsl:with-param name="actualNode" select="./text()"/>
        <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
        <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
        <xsl:with-param name="delimiter" select="$delim"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- MATCH FOR ALL Name -->
  <xsl:template match="  INFRA:shortName|  INFRA:longName|  FI:shortName|  FI:longName|  STRUCTP:shortName|  STRUCTP:longName|  CLIENT:shortName|  CLIENT:longName ">
    <!-- 
  ###########################
  REPLACEMENT CODED HERE :
   ;		: \;
   " 		: '
   Line Feed 	: \n
  ###########################
  -->
    <xsl:variable name="globalListOfTarget" select="concat(  ';', $delim,      '&quot;', $delim,      $cReturn           )   "/>
    <xsl:variable name="globalListOfReplacement" select="concat(  '\;', $delim ,        $apos, $delim,      '\n'     )     "/>
    <xsl:copy>
      <xsl:call-template name="multiReplace">
        <xsl:with-param name="actualNode" select="./text()"/>
        <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
        <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
        <xsl:with-param name="delimiter" select="$delim"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- MATCH FOR ALL Agency -->
  <xsl:template match="  INFRA:agency|  FI:agency   ">
    <!-- 
  ###########################
  REPLACEMENT CODED HERE :
   " 		: _
   ;		: _
   SPACE 	: _
   ! 		: _
   # 		: _
   % 		: _
   & 		: _
   ' 		: _
   ( 		: _
   ) 		: _
   : 		: _
   > 		: _
   < 		: _
   ? 		: _
   @ 		: _
   [ 		: _
   ] 		: _
   ^		: _
   `		: _
   {		: _
   }		: _
   |		: _
   ~		: _
   			
  ###########################
  -->
    <xsl:variable name="globalListOfTarget" select="concat(      '&quot;', $delim,      ';', $delim,      ' ', $delim,      '!', $delim,      '#', $delim,      '%', $delim,      '&amp;', $delim,      $apos, $delim,      '(', $delim,      ')', $delim,      ':', $delim,      '&gt;', $delim,      '&lt;', $delim,      '?', $delim,      '@', $delim,      '[', $delim,      ']', $delim,      '^', $delim,      '`', $delim,      '{', $delim,      '}', $delim,      '|', $delim,      '~'     )   "/>
    <xsl:variable name="globalListOfReplacement" select="concat(      '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,       '_'               )     "/>
	<xsl:copy>
      <xsl:call-template name="multiReplace">
        <xsl:with-param name="actualNode" select="./text()"/>
        <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
        <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
        <xsl:with-param name="delimiter" select="$delim"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- MATCH FOR ALL Agency -->
  <xsl:template match="  @output   ">
    <!-- 
  ###########################
  REPLACEMENT CODED HERE :
   " 		: _
   ;		: _
   SPACE 	: _
   ! 		: _
   # 		: _
   % 		: _
   & 		: _
   ' 		: _
   ( 		: _
   ) 		: _
   : 		: _
   > 		: _
   < 		: _
   ? 		: _
   @ 		: _
   [ 		: _
   ] 		: _
   ^		: _
   `		: _
   {		: _
   }		: _
   |		: _
   ~		: _
   /		: _
   \		: _
   			
  ###########################
  -->
    <xsl:variable name="globalListOfTarget" select="concat(      '&quot;', $delim,      ';', $delim,      ' ', $delim,      '!', $delim,      '#', $delim,      '%', $delim,      '&amp;', $delim,      $apos, $delim,      '(', $delim,      ')', $delim,      ':', $delim,      '&gt;', $delim,      '&lt;', $delim,      '?', $delim,      '@', $delim,      '[', $delim,      ']', $delim,      '^', $delim,      '`', $delim,      '{', $delim,      '}', $delim,      '|', $delim,      '~', $delim,      '/', $delim,      '\'     )   "/>
    <xsl:variable name="globalListOfReplacement" select="concat(      '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,       '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,   '_', $delim,       '_', $delim,       '_', $delim,       '_'               )     "/>
    <xsl:attribute name="output">
      <xsl:call-template name="multiReplace">
        <xsl:with-param name="actualNode" select="."/>
        <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
        <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
        <xsl:with-param name="delimiter" select="$delim"/>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>
  <!-- ############################################################### -->
  <xsl:template name="ReturnQuoteReplace">
    <xsl:variable name="globalListOfTarget" select="concat($cReturn, $delim,'&quot;')"/>
    <xsl:variable name="globalListOfReplacement" select="concat('\n', $delim, $apos)"/>
    <xsl:call-template name="multiReplace">
      <xsl:with-param name="actualNode" select="./text()"/>
      <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
      <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
      <xsl:with-param name="delimiter" select="$delim"/>
    </xsl:call-template>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- MATCH FOR ALL  -->
  <!-- Global replacement for " and cReturn -->
  <xsl:template match="INFRA:*|FI:*|CLIENT:*|TRANSACTION:*|POSITION:*|F2B:*|F2B_MM_FX:*|GENERICCOA:*">
    <xsl:variable name="childCount" select="count(*)"/>
    <xsl:choose>
      <xsl:when test="$childCount = 0">
        <xsl:copy>
          <xsl:call-template name="ReturnQuoteReplace"/>
        </xsl:copy>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ############################################################### -->
  <!-- ############################################################### -->
  <!-- MAIN MATCH -->
  <xsl:template match="@*|*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- ############################################################### -->
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="RatingAgency_GWP.xml" htmlbaseurl="" outputurl="RatingAgency_GWPOUT.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="bGenerateByteCode" value="true"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="sInitialMode" value=""/>
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