<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:a="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.temenos.com/T24/BatchOFSML/150" version="1.0">
  <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
  <xsl:param name="delim">,</xsl:param>
  <xsl:param name="globalListOfTarget" select="concat(      '?', $delim,      '|', $delim,      '^'     )   "/>
  <xsl:param name="globalListOfReplacement" select="concat(      '%?%', $delim,       '%|%', $delim,       '%^%'               )     "/>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="a:ofsTransactionInput/a:field">
    <xsl:element name="field" namespace="{namespace-uri()}">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:call-template name="cleanCharacters">
        <xsl:with-param name="value" select="."/>
      </xsl:call-template>
    </xsl:element>
  </xsl:template>
  <xsl:template name="cleanCharacters">
    <xsl:param name="value"/>
    <xsl:call-template name="multiReplace">
      <xsl:with-param name="actualNode" select="$value"/>
      <xsl:with-param name="listOfTarget" select="$globalListOfTarget"/>
      <xsl:with-param name="listOfReplacement" select="$globalListOfReplacement"/>
      <xsl:with-param name="delimiter" select="$delim"/>
    </xsl:call-template>
  </xsl:template>
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
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="test" userelativepaths="yes" externalpreview="no" url="F2B_OrderInstructionT24.xml" htmlbaseurl="" outputurl="F2B_OrderInstructionT24OUT.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="schemaCache" value="||"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no">
			<SourceSchema srcSchemaPath="F2B_OrderInstructionT24.xml" srcSchemaRoot="T24Batch" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/>
		</MapperInfo>
		<MapperBlockPosition>
			<template match="/">
				<block path="xsl:call-template" x="280" y="0"/>
			</template>
			<template match="@* | node()"></template>
			<template match="b:T24Batch/a:T24/a:serviceRequest/a:ofsTransactionInput/a:field"></template>
			<template match="b:T24Batch/a:T24/a:serviceRequest/a:ofsTransactionInput/a:field/a:name"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
