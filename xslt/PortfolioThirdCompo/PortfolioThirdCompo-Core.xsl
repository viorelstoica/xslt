<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/ClientPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioThirdCompo" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioThirdCompo" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
  <xsl:template name="infra:code">
    <infra:code>
      <xsl:value-of select="."/>
    </infra:code>
  </xsl:template>
  <xsl:template name="active">
    <active>
      <xsl:choose>
        <xsl:when test="not(../../b:startDateJoinList/b:startDateJoin) and not(../../b:closureDateJoinList/b:closureDateJoin)">
          <xsl:value-of select="'0'"/>
        </xsl:when>
        <xsl:when test="../../b:startDateJoinList/b:startDateJoin and number(translate(../../b:startDateJoinList/b:startDateJoin,'-','')) &lt;= number(translate(../../b:coCodeDatesTodayList/b:coCodeDatesToday,'-','')) and (not(../../b:closureDateJoinList/b:closureDateJoin) or number(translate(../../b:closureDateJoinList/b:closureDateJoin,'-','')) &gt; number(translate(../../b:coCodeDatesTodayList/b:coCodeDatesToday,'-','')))">
          <xsl:value-of select="'1'"/>
        </xsl:when>
        <xsl:when test="not(../../b:startDateJoinList/b:startDateJoin) and ../../b:closureDateJoinList/b:closureDateJoin and number(translate(../../b:closureDateJoinList/b:closureDateJoin,'-','')) &gt;= number(translate(../../b:coCodeDatesTodayList/b:coCodeDatesToday,'-',''))">
          <xsl:value-of select="'1'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'0'"/>
        </xsl:otherwise>
      </xsl:choose>
    </active>
  </xsl:template>
  <xsl:template name="ownership">
    <xsl:call-template name="PTC"/>
  </xsl:template>
  <xsl:template name="parentChildIndicator">
    <parentChildIndicator>
      <xsl:value-of select="1"/>
    </parentChildIndicator>
  </xsl:template>
  <xsl:template name="infra:synonym"/>
  <xsl:template name="infra:shortName"/>
  <xsl:template name="infra:longName"/>
  <xsl:template name="infra:multilingualLongName"/>
  <xsl:template name="infra:notepad"/>
  <xsl:template name="infra:userDefinedField"/>
  <xsl:template name="infra:mbFields"/>
  <xsl:template name="businessEntityComposition"/>
  <xsl:template name="client"/>
  <xsl:template name="mainBusinessEntity"/>
  <xsl:template name="managementBeginDate"/>
  <xsl:template name="managementEndDate"/>
  <xsl:template name="managementType"/>
  <xsl:template name="marginLending"/>
  <xsl:template name="nature"/>
  <xsl:template name="parentPortfolio"/>
  <xsl:template name="paymentInstruction"/>
  <xsl:template name="performanceCurrency"/>
  <xsl:template name="performanceDataStorageFrequency"/>
  <xsl:template name="performanceDataStorageUnit"/>
  <xsl:template name="performanceDetailLevel"/>
  <xsl:template name="portfolioManager"/>
  <xsl:template name="portfolioGroup"/>
  <xsl:template name="portfolioType"/>
  <xsl:template name="positionManagementDate"/>
  <xsl:template name="positionManagementLevel"/>
  <xsl:template name="positionManagementRule"/>
  <xsl:template name="relationshipManager"/>
  <xsl:template name="reportingLanguage"/>
  <xsl:template name="sharia"/>
  <xsl:template name="status"/>
  <xsl:template name="cashBookingModel"/>
  <xsl:template name="creditStatus"/>
  <xsl:template name="PTC">
    <xsl:choose>
      <xsl:when test="not (../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and not(../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipOrigPartyId) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))">
        <!-- ownership creation-->	
        <xsl:apply-templates select="../../b:origPartyGroup[b:origParty='CUSTOMER'][not (../../../c:PreviousEvent)][not(../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipOrigPartyId) ]">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="Query" select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER']"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup and ((contains($THIRDCOMPO_RELTYPE,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:relationType,' ')) and not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' '))))or( not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))) and contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' ')))))">
        <!-- ownership groupId  or rel.type changed (delete)-->
        <xsl:apply-templates select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup[b:origParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup and ((not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:relationType,' '))) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')))or( contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and not(contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' '))))or(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId,' '))and ../../b:groupId != ../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:groupId)))">
        <!-- ownership groupId  or rel.type changed (insupd)-->
        <xsl:apply-templates select="../../b:origPartyGroup[b:origParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
      </xsl:when>
      <!--###########################Prev fields ################## -->
      <xsl:when test="not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and (((contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:prevCustomerRelationshipRelationTypeList/b:prevCustomerRelationshipRelationType,' ')) and not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')))) and( not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupIdList/b:prevCustomerRelationshipGroupId,' ')))))">
	    <!-- ownership groupId  or rel.type changed previous date (delete) -->
		<xsl:apply-templates select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup[b:prevCustomerRelationshipOrigParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'prevCustomerRelationshipOrigPartyId'"/>
          <xsl:with-param name="field2" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'prevCustomerRelationshipOrigPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'prevCustomerRelationshipGroupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipRelPartyGroup[b:prevCustomerRelationshipRelParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'prevCustomerRelationshipRelPartyId'"/>
          <xsl:with-param name="field2" select="'prevCustomerRelationshipRelPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'prevCustomerRelationshipRelPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'prevCustomerRelationshipRelPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'prevCustomerRelationshipRelPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'prevCustomerRelationshipRelPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'prevCustomerRelationshipGroupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
		</xsl:apply-templates>
      </xsl:when>
      <xsl:when test="not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and (((not(contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:prevCustomerRelationshipRelationTypeList/b:prevCustomerRelationshipRelationType,' '))) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' '))) or( contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) and not(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupIdList/b:prevCustomerRelationshipGroupId,' '))))or(contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:prevCustomerRelationshipGroupIdList/b:prevCustomerRelationshipGroupId,' '))and ../../b:groupId != ../../b:prevCustomerRelationshipGroupIdList/b:prevCustomerRelationshipGroupId)))">
	    <!-- ownership groupId  or rel.type changed previous date (insupd) -->
	    <xsl:apply-templates select="../../b:origPartyGroup[b:origParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER']">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="not(../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup) and ((../../b:prevCustomerRelationshipOrigPartyGroup) and contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' ')) )">
		<!-- New ownership groupId Or RelId changed previous date  -->
        <xsl:variable name="IdListOrigCUSTOMER">
          <xsl:for-each select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup[b:prevCustomerRelationshipOrigParty ='CUSTOMER']">
			<xsl:variable name="OrigID" select="./b:prevCustomerRelationshipOrigPartyId"/>
            <xsl:variable name="OrigIndex" select="../../b:prevCustomerRelationshipOrigPartyIdCustomerTypeIdList/b:prevCustomerRelationshipOrigPartyIdCustomerTypeId[. = $OrigID]/@index"/>
			<xsl:if test="../../b:prevCustomerRelationshipOrigPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:prevCustomerRelationshipOrigPartyIdCustomerTypeList/b:prevCustomerRelationshipOrigPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:prevCustomerRelationshipOrigPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../b:origPartyGroup[b:origParty='CUSTOMER'][not(contains($IdListOrigCUSTOMER,concat(' - ',./b:origPartyId,' - ')))]">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>

        <xsl:variable name="IdListRelCUSTOMER2">
          <xsl:for-each select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipRelPartyGroup[b:prevCustomerRelationshipRelParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:prevCustomerRelationshipRelPartyId"/>
		    <xsl:variable name="RelIndex" select="../../../b:prevCustomerRelationshipRelPartyIdCustomerTypeIdList/b:prevCustomerRelationshipRelPartyIdCustomerTypeId[. = $RelID]/@index"/>
			<xsl:if test="../../../b:prevCustomerRelationshipRelPartyIdCustomerTypeGroup/b:prevCustomerRelationshipRelPartyIdCustomerTypeList/b:prevCustomerRelationshipRelPartyIdCustomerType[@index = $RelIndex] ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:prevCustomerRelationshipRelPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER'][not(contains($IdListRelCUSTOMER2,concat(' - ',b:relPartyId,' - ')))]">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <!-- Delete ownership not present anymore or not a customer changed previous date-->
        <xsl:variable name="IdListOrigNotPresCUSTOMER">
          <xsl:for-each select="../../b:origPartyGroup[b:origParty ='CUSTOMER']">
            <xsl:variable name="OrigID" select="./b:origPartyId"/>
            <xsl:variable name="OrigIndex" select="../b:origPartyIdCustomerTypeIdList/b:origPartyIdCustomerTypeId[. = $OrigID]/@index"/>
            <xsl:if test="../b:origPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:origPartyIdCustomerTypeList/b:origPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:origPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="IdListOrigNotPresCUSTOMER2">
          <xsl:for-each select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup[b:prevCustomerRelationshipOrigParty ='CUSTOMER']">
            <xsl:variable name="OrigID" select="./b:prevCustomerRelationshipOrigPartyId"/>
            <xsl:variable name="OrigIndex" select="../../b:prevCustomerRelationshipOrigPartyIdCustomerTypeIdList/b:prevCustomerRelationshipOrigPartyIdCustomerTypeId[. = $OrigID]/@index"/>
            <xsl:if test="../../b:prevCustomerRelationshipOrigPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:prevCustomerRelationshipOrigPartyIdCustomerTypeList/b:prevCustomerRelationshipOrigPartyIdCustomerType ='CUSTOMER'">
              <xsl:if test="not(contains($IdListOrigNotPresCUSTOMER,concat(' - ',$OrigID,' - '))) ">
                <xsl:value-of select="concat(' - ',./b:prevCustomerRelationshipOrigPartyId,' - ')"/>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
		
        <xsl:apply-templates select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup[b:prevCustomerRelationshipOrigParty='CUSTOMER'][contains($IdListOrigNotPresCUSTOMER2,concat(' - ',b:prevCustomerRelationshipOrigPartyId,' - '))]">
          <xsl:with-param name="field1" select="'prevCustomerRelationshipOrigPartyId'"/>
          <xsl:with-param name="field2" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'prevCustomerRelationshipOrigPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'prevCustomerRelationshipOrigPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'prevCustomerRelationshipGroupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
        <xsl:variable name="IdListRelNotPresCUSTOMER">
          <xsl:for-each select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:relPartyId"/>
           <xsl:variable name="RelIndex" select="../../b:relPartyIdCustomerTypeIdGroup/b:relPartyIdCustomerTypeIdSubGroup[./b:relPartyIdCustomerTypeId = $RelID]/@index"/>
            <xsl:if test="../../b:relPartyIdCustomerTypeGroup/b:relPartyIdCustomerTypeSubGroup[@index = $RelIndex]/b:relPartyIdCustomerTypeList/b:relPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:relPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="IdListRelNotPresCUSTOMER2">
          <xsl:for-each select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipRelPartyGroup[b:prevCustomerRelationshipRelParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:prevCustomerRelationshipRelPartyId"/>
            <xsl:variable name="RelIndex" select="../../../b:prevCustomerRelationshipRelPartyIdCustomerTypeIdList/b:prevCustomerRelationshipRelPartyIdCustomerTypeId[. = $RelID]/@index"/>
            <xsl:if test="../../../b:prevCustomerRelationshipRelPartyIdCustomerTypeGroup/b:prevCustomerRelationshipRelPartyIdCustomerTypeList/b:prevCustomerRelationshipRelPartyIdCustomerType[@index = $RelIndex]='CUSTOMER'">
              <xsl:if test="not(contains($IdListRelNotPresCUSTOMER,concat(' - ',$RelID,' - '))) ">
                <xsl:value-of select="concat(' - ',$RelID,' - ')"/>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipRelPartyGroup[b:prevCustomerRelationshipRelParty='CUSTOMER'][contains($IdListRelNotPresCUSTOMER2,concat(' - ',b:prevCustomerRelationshipRelPartyId,' - '))]">
          <xsl:with-param name="field1" select="'prevCustomerRelationshipRelPartyId'"/>
          <xsl:with-param name="field2" select="'prevCustomerRelationshipRelPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'prevCustomerRelationshipRelPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'prevCustomerRelationshipRelPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'prevCustomerRelationshipRelPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'prevCustomerRelationshipRelPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'prevCustomerRelationshipGroupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
      </xsl:when>

      <!--###########################Current/Previous section ################## -->
      <xsl:when test="contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationType,' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupId,' '))">
        <!-- New ownership origPartyId Or relPartyId-->
        <xsl:variable name="IdListOrigCUSTOMER">
          <xsl:for-each select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup[b:origParty ='CUSTOMER']">
            <xsl:variable name="OrigID" select="./b:origPartyId"/>
            <xsl:variable name="OrigIndex" select="../b:origPartyIdCustomerTypeIdList/b:origPartyIdCustomerTypeId[. = $OrigID]/@index"/>
            <xsl:if test="../b:origPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:origPartyIdCustomerTypeList/b:origPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:origPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../b:origPartyGroup[b:origParty='CUSTOMER'][not(contains($IdListOrigCUSTOMER,concat(' - ',b:origPartyId,' - ')))]">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <xsl:variable name="RelIdListCUSTOMER">
          <xsl:for-each select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup/b:relPartySubGroup[b:relParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:relPartyId"/>
			<xsl:variable name="RelIndex" select="../../b:relPartyIdCustomerTypeIdGroup/b:relPartyIdCustomerTypeIdSubGroup[./b:relPartyIdCustomerTypeId = $RelID]/@index"/>
            <xsl:if test="../../b:relPartyIdCustomerTypeGroup/b:relPartyIdCustomerTypeSubGroup[@index = $RelIndex]/b:relPartyIdCustomerTypeList/b:relPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:relPartyId,' - ')"/>
            </xsl:if>
			
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER'][not(contains($RelIdListCUSTOMER,concat(' - ',b:relPartyId,' - ')))]">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'insupd'"/>
        </xsl:apply-templates>
        <!-- Delete ownership not present anymore or not CUTOMER anymore-->
        <xsl:variable name="IdListOrigDelCUSTOMER">
          <xsl:for-each select="../../b:origPartyGroup[b:origParty ='CUSTOMER']">
            <xsl:variable name="OrigID" select="./b:origPartyId"/>
            <xsl:variable name="OrigIndex" select="../b:origPartyIdCustomerTypeIdList/b:origPartyIdCustomerTypeId[. = $OrigID]/@index"/>
            <xsl:if test="../b:origPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:origPartyIdCustomerTypeList/b:origPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:origPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="IdListOrigDelCUSTOMER2">
          <xsl:for-each select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup[b:origParty ='CUSTOMER']">
            <xsl:variable name="OrigID" select="./b:origPartyId"/>
            <xsl:variable name="OrigIndex" select="../b:origPartyIdCustomerTypeIdList/b:origPartyIdCustomerTypeId[. = $OrigID]/@index"/>
            <xsl:if test="../b:origPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:origPartyIdCustomerTypeList/b:origPartyIdCustomerType ='CUSTOMER'">
              <xsl:if test="not(contains($IdListOrigDelCUSTOMER,concat(' - ',$OrigID,' - '))) ">
                <xsl:value-of select="concat(' - ',./b:origPartyId,' - ')"/>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup[b:origParty='CUSTOMER'][contains($IdListOrigDelCUSTOMER2,concat(' - ',b:origPartyId,' - '))]">
          <xsl:with-param name="field1" select="'origPartyId'"/>
          <xsl:with-param name="field2" select="'origPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'origPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'origPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'origPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'origPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
        <xsl:variable name="IdListRelDelCUSTOMER">
          <xsl:for-each select="../../b:origPartyGroup/b:relPartySubGroup[b:relParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:relPartyId"/>
            <xsl:variable name="RelIndex" select="../../b:relPartyIdCustomerTypeIdGroup/b:relPartyIdCustomerTypeIdSubGroup[./b:relPartyIdCustomerTypeId = $RelID]/@index"/>
            <xsl:if test="../../b:relPartyIdCustomerTypeGroup/b:relPartyIdCustomerTypeSubGroup[@index = $RelIndex]/b:relPartyIdCustomerTypeList/b:relPartyIdCustomerType ='CUSTOMER'">
              <xsl:value-of select="concat(' - ',./b:relPartyId,' - ')"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="IdListRelDelCUSTOMER2">
          <xsl:for-each select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup/b:relPartySubGroup[b:relParty ='CUSTOMER']">
            <xsl:variable name="RelID" select="./b:relPartyId"/>
            <xsl:variable name="RelIndex" select="../../b:relPartyIdCustomerTypeIdGroup/b:relPartyIdCustomerTypeIdSubGroup[./b:relPartyIdCustomerTypeId = $RelID]/@index"/>
            <xsl:if test="../../b:relPartyIdCustomerTypeGroup/b:relPartyIdCustomerTypeSubGroup[@index = $RelIndex]/b:relPartyIdCustomerTypeList/b:relPartyIdCustomerType ='CUSTOMER'">
              <xsl:if test="not(contains($IdListRelDelCUSTOMER,concat(' - ',$RelID,' - '))) ">
                <xsl:value-of select="concat(' - ',./b:relPartyId,' - ')"/>
              </xsl:if>
            </xsl:if>
          </xsl:for-each>
        </xsl:variable>
        <xsl:apply-templates select="../../../../c:PreviousEvent/b:PortfolioThirdCompo/b:origPartyGroup/b:relPartySubGroup[b:relParty='CUSTOMER'][contains($IdListRelDelCUSTOMER2,concat(' - ',b:relPartyId,' - '))]">
          <xsl:with-param name="field1" select="'relPartyId'"/>
          <xsl:with-param name="field2" select="'relPartyIdCustomerTypeIdList'"/>
          <xsl:with-param name="field3" select="'relPartyIdCustomerTypeId'"/>
          <xsl:with-param name="field4" select="'relPartyIdCustomerTypeGroup'"/>
          <xsl:with-param name="field5" select="'relPartyIdCustomerTypeList'"/>
          <xsl:with-param name="field6" select="'relPartyIdCustomerType'"/>
          <xsl:with-param name="field7" select="'groupId'"/>
          <xsl:with-param name="mode" select="'delete'"/>
        </xsl:apply-templates>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="b:origPartyGroup | b:prevCustomerRelationshipOrigPartyGroup ">
    <xsl:param name="field1"/>
    <xsl:param name="field2"/>
    <xsl:param name="field3"/>
    <xsl:param name="field4"/>
    <xsl:param name="field5"/>
    <xsl:param name="field6"/>
    <xsl:param name="field7"/>
    <xsl:param name="mode"/>
    <xsl:variable name="ID" select="./*[local-name() = $field1 ]"/>
    <xsl:variable name="Index" select="./../*[local-name() = $field2 ]/*[local-name() = $field3 ][. = $ID]/@index"/>
    <!--<xsl:if test="./../*[local-name() = $field4 ][@index=$Index]/*[local-name() = $field5 ]/*[local-name() = $field6 ] = 'CUSTOMER'">-->
    <xsl:element name="ownership">
      <xsl:if test="$mode ='delete'">
        <xsl:attribute name="mode">
          <xsl:value-of select="'delete'"/>
        </xsl:attribute>
      </xsl:if>
      <owner>
        <infra:code>
          <xsl:value-of select="concat($CUSTOMER_PREFIX,$ID)"/>
        </infra:code>
      </owner>
      <ownershipRule>
        <xsl:call-template name="ownershipRuleTemplate">
          <xsl:with-param name="groupId" select="./../*[local-name() = $field7 ]"/>
        </xsl:call-template>
      </ownershipRule>
      <validityDate>2000-01-01</validityDate>
    </xsl:element>
    <!--</xsl:if>-->
  </xsl:template>
  <xsl:template match="b:origPartyGroup/b:relPartySubGroup">
    <xsl:param name="field1"/>
    <xsl:param name="field2"/>
    <xsl:param name="field3"/>
    <xsl:param name="field4"/>
    <xsl:param name="field5"/>
    <xsl:param name="field6"/>
    <xsl:param name="field7"/>
    <xsl:param name="mode"/>
    <xsl:variable name="ID" select="./*[local-name() = $field1 ]"/>
    <xsl:variable name="Index" select="./../../*[local-name() = $field2 ]/*[local-name() = $field3 ][. = $ID]/@index"/>
    <!--<xsl:if test="./../../*[local-name() = $field4 ][@index=$Index]/*[local-name() = $field5 ]/*[local-name() = $field6 ] = 'CUSTOMER'">-->
    <xsl:element name="ownership">
      <xsl:if test="$mode ='delete'">
        <xsl:attribute name="mode">
          <xsl:value-of select="'delete'"/>
        </xsl:attribute>
      </xsl:if>
      <owner>
        <infra:code>
          <xsl:value-of select="concat($CUSTOMER_PREFIX,$ID)"/>
        </infra:code>
      </owner>
      <ownershipRule>
        <xsl:call-template name="ownershipRuleTemplate">
          <xsl:with-param name="groupId" select="./../../*[local-name() = $field7 ]"/>
        </xsl:call-template>
      </ownershipRule>
      <validityDate>2000-01-01</validityDate>
    </xsl:element>
    <!--</xsl:if>-->
  </xsl:template>
  <xsl:template match="b:prevCustomerRelationshipOrigPartyGroup/b:prevCustomerRelationshipOrigPartySubGroup/b:prevCustomerRelationshipRelPartyGroup">
    <xsl:param name="field1"/>
    <xsl:param name="field2"/>
    <xsl:param name="field3"/>
    <xsl:param name="field4"/>
    <xsl:param name="field5"/>
    <xsl:param name="field6"/>
    <xsl:param name="field7"/>
    <xsl:param name="mode"/>
    <xsl:variable name="ID" select="./*[local-name() = $field1 ]"/>
    <xsl:variable name="Index" select="./../../../*[local-name() = $field2 ]/*[local-name() = $field3 ][. = $ID]/@index"/>
    <xsl:element name="ownership">
      <xsl:if test="$mode ='delete'">
        <xsl:attribute name="mode">
          <xsl:value-of select="'delete'"/>
        </xsl:attribute>
      </xsl:if>
      <owner>
        <infra:code>
          <xsl:value-of select="concat($CUSTOMER_PREFIX,$ID)"/>
        </infra:code>
      </owner>
      <ownershipRule>
        <xsl:call-template name="ownershipRuleTemplate">
          <xsl:with-param name="groupId" select="./../../../*[local-name()='prevCustomerRelationshipGroupIdList']/*[local-name() = $field7 ]"/>
        </xsl:call-template>
      </ownershipRule>
      <validityDate>2000-01-01</validityDate>
    </xsl:element>
    <!--</xsl:if>-->
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="jaxp" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="schemaCache" value="||"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="infra:code"></template>
			<template name="active"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->