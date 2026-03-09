<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolio"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolio" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:template name="infra:synonym">
		<xsl:if test="b:portAltId and b:portAltId !=''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="b:portAltId"/>
				</infra:code>
				<infra:codification>
					<xsl:value-of select="$PORT_CODIFICATION"/>
				</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="b:subAccExtIdGroup/b:subAccExtId and b:subAccExtIdGroup/b:subAccExtId !='' ">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="b:subAccExtIdGroup/b:subAccExtId"/>
				</infra:code>
				<infra:codification>
					<xsl:value-of select="$PORTFOLIO_SYNONYM_CODIFICATION"/>
				</infra:codification>
				<xsl:call-template name="endDate_MBPortfolioSyn"/>
				<xsl:call-template name="status_MBPortfolioSyn"/>
				<xsl:call-template name="mbFields_MBPortfolioSyn"/>
			</infra:synonym>
		</xsl:if>
	</xsl:template>

	<xsl:template name="active_MBPortfolioSyn"/>
	<xsl:template name="beginDate_MBPortfolioSyn">
		<infra:beginDate>
			<xsl:call-template name="xsdatetime">
				<xsl:with-param name="date" select="b:eventCommon/ns0:today"/>
			</xsl:call-template>
		</infra:beginDate>
	</xsl:template>
	<xsl:template name="endDate_MBPortfolioSyn"/>
	<xsl:template name="status_MBPortfolioSyn">
		<infra:status>
			<xsl:call-template name="leDirectoryRegistrationStatusTranslation">
				<xsl:with-param name="registrationStatus" select="'ISSUED'"/>
			</xsl:call-template>
		</infra:status>
	</xsl:template>
	<xsl:template name="mbFields_MBPortfolioSyn"/>
	<xsl:template name="infra:mbFields">
		<infra:mbFields>
			<infra:mbField>
				<infra:name>fund_portfolio_type_id.code</infra:name>
				<infra:value>
				<xsl:choose>
				<xsl:when test="b:fundPortType!= ''">
					<xsl:value-of select="b:fundPortType"/>
				</xsl:when>
				<xsl:when test="not(b:fundPortType)">
				<xsl:value-of select="'NULL'"/>
				</xsl:when>
				</xsl:choose>
				</infra:value>
				<infra:type>string</infra:type>
			</infra:mbField>
		</infra:mbFields>
	</xsl:template>


	<xsl:template name="ownership">
		<xsl:variable name="CRList">
			<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:samCustRelIdList/b:samCustRelId">
				<xsl:value-of select="concat(substring-before(.,'-'),' - ')"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="CRListCurrent">
			<xsl:for-each select="b:samCustRelIdList/b:samCustRelId">
				<xsl:value-of select="concat(substring-before(.,'-'),' - ')"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:for-each select="b:samCustRelIdList/b:samCustRelId [ not(contains($CRList,concat(substring-before(.,'-'),' - '))) ]">
			<xsl:variable name="CRindex" select="@index"/>
			<xsl:if test="contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationshipTypeList/b:relationshipType[@index=$CRindex],' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupIdList/b:groupId[@index=$CRindex],' '))">
				<xsl:apply-templates select="../../b:origPartyGroup[@index=$CRindex]/b:origPartySubGroup[b:origParty='CUSTOMER']">
					<xsl:with-param name="CRindex" select="$CRindex"/>
					<xsl:with-param name="mode" select="'insupd'"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="../../b:origPartyGroup[@index=$CRindex]/b:origPartySubGroup/b:relPartyGroup[b:relParty='CUSTOMER']">
					<xsl:with-param name="CRindex" select="$CRindex"/>
					<xsl:with-param name="mode" select="'insupd'"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:samCustRelIdList/b:samCustRelId [ not(contains($CRListCurrent,concat(substring-before(.,'-'),' - '))) ]">
			<xsl:variable name="CRindex" select="@index"/>
			<xsl:if test="contains($THIRDCOMPO_RELTYPE,concat(' ',../../b:relationshipTypeList/b:relationshipType[@index=$CRindex],' ')) and contains($THIRDCOMPO_GROUPID,concat(' ',../../b:groupIdList/b:groupId[@index=$CRindex],' '))">
				<xsl:apply-templates select="../../b:origPartyGroup[@index=$CRindex]/b:origPartySubGroup[b:origParty='CUSTOMER']">
					<xsl:with-param name="CRindex" select="$CRindex"/>
					<xsl:with-param name="mode" select="'delete'"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="../../b:origPartyGroup[@index=$CRindex]/b:origPartySubGroup/b:relPartyGroup[b:relParty='CUSTOMER']">
					<xsl:with-param name="CRindex" select="$CRindex"/>
					<xsl:with-param name="mode" select="'delete'"/>
				</xsl:apply-templates>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>


	<xsl:template match="b:origPartyGroup/b:origPartySubGroup/b:relPartyGroup">
		<xsl:param name="CRindex"/>
		<xsl:param name="mode"/>
		<xsl:variable name="RelPartyID" select="./b:relPartyId"/>
		<xsl:variable name="RelPartyIndex" select="../../../b:customerSecurityRelPartyIdList/b:customerSecurityRelPartyId[. = $RelPartyID]/@index"/>
		<!--<xsl:if test="../../../b:relPartyIdCustomerTypeGroup[@index = $RelPartyIndex]/b:relPartyIdCustomerTypeList/b:relPartyIdCustomerType ='CUSTOMER'">-->
		<xsl:element name="ownership">
			<xsl:if test="$mode ='delete'">
				<xsl:attribute name="mode">
					<xsl:value-of select="'delete'"/>
				</xsl:attribute>
			</xsl:if>
			<owner>
				<infra:code>
					<xsl:value-of select="concat($CUSTOMER_PREFIX,$RelPartyID)"/>
				</infra:code>
			</owner>
			<ownershipRule>
				<xsl:call-template name="ownershipRuleTemplate">
					<xsl:with-param name="groupId" select="../../../b:groupIdList/b:groupId[@index=$CRindex]"/>
				</xsl:call-template>
			</ownershipRule>
			<validityDate>2000-01-01</validityDate>
			<mbFields>
				<mbField>
					<name>trading_right_f</name>
					<value>
						<xsl:choose>
							<xsl:when test="../../../b:tradingRightList/b:tradingRight = $RelPartyID">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</value>
					<type>string</type>
				</mbField>
			</mbFields>
		</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>
	<xsl:template match="b:origPartyGroup/b:origPartySubGroup">
		<xsl:param name="CRindex"/>
		<xsl:param name="mode"/>
		<xsl:variable name="OrigID" select="./b:origPartyId"/>
		<xsl:variable name="OrigIndex" select="../../b:customerSecurityorigPartyIdList/b:customerSecurityorigPartyId[. = $OrigID]/@index"/>
		<!--<xsl:if test="../../b:origPartyIdCustomerTypeGroup[@index = $OrigIndex]/b:origPartyIdCustomerTypeList/b:origPartyIdCustomerType ='CUSTOMER'">-->
		<xsl:element name="ownership">
			<xsl:if test="$mode ='delete'">
				<xsl:attribute name="mode">
					<xsl:value-of select="'delete'"/>
				</xsl:attribute>
			</xsl:if>
			<owner>
				<infra:code>
					<xsl:value-of select="concat($CUSTOMER_PREFIX,$OrigID)"/>
				</infra:code>
			</owner>
			<ownershipRule>
				<xsl:call-template name="ownershipRuleTemplate">
					<xsl:with-param name="groupId" select="../../b:groupIdList/b:groupId[@index=$CRindex]"/>
				</xsl:call-template>
			</ownershipRule>
			<validityDate>2000-01-01</validityDate>
			<mbFields>
				<mbField>
					<name>trading_right_f</name>
					<value>
						<xsl:choose>
							<xsl:when test="../../b:tradingRightList/b:tradingRight = $OrigID">
								<xsl:value-of select="'1'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="'0'"/>
							</xsl:otherwise>
						</xsl:choose>
					</value>
					<type>string</type>
				</mbField>
			</mbFields>
		</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>

</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->