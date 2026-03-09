<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioThirdCompo" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolioThirdCompo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioThirdCompo" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioThirdCompo" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <xsl:template match="b:portfolioIdList/b:portfolioId">
    <xsl:if test="(not (../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and not(../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartyId) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')))         or ((../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup and ((contains($THIRDCOMPO_RELTYPE,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:relationType,' ')) and not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' '))))or( not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))) and contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' '))))))         or ((../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup and ((not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:relationType,' '))) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')))or( contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and not(contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' '))))or(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' '))and ../../b:groupId != ../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId))))         or (not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and (((contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:prevCustomerRelationshipRelationType,' ')) and not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')))) and( not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupId,' '))))or(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupId,' '))and ../../b:groupId != ../../b:prevCustomerRelationshipGroupId)))         or (not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and (((not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:prevCustomerRelationshipRelationType,' '))) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' '))) or( contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupId,' ')))))))         or (not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and ((../../b:prevCustomerRelationshipOrigPartyGroup) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) ))         or (contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')))">
        <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="no" name="PortfolioThirdCompo" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PortfolioThirdCompo\PortfolioThirdCompo.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\PortfolioThirdCompo\PortfolioThirdCompoGWP.xml" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath=""
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
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\PortfolioThirdCompo\PortfolioThirdCompo2.xml" htmlbaseurl="" outputurl="..\..\TestFiles\PortfolioThirdCompo\PortfolioThirdCompoCusto.xml"
		          processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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