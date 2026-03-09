<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/ClientPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Portfolio"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolio" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolio" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolio" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="infra:code">
		<infra:code>
			<xsl:value-of select="b:id"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:choose>
				<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
					<xsl:value-of select="b:accountName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<infra:longName>
			<xsl:choose>
				<xsl:when test="$MAP_SENSITIVE_DATA = 'Y'">
					<xsl:value-of select="b:accountName"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:id"/>
				</xsl:otherwise>
			</xsl:choose>
		</infra:longName>
	</xsl:template>
	<xsl:template name="infra:userDefinedField-custo"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
    <xsl:template name="managementType">
       <xsl:if test="b:investmentProgram and b:investmentProgram != ''">
            <managementType>
                <infra:code>        
                    <xsl:value-of select="b:investmentProgram"/>
                </infra:code>
            </managementType>      
       </xsl:if>
    </xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:choose>
				<xsl:when test="b:blockingDate != ''">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="b:closureDate != ''">
					<xsl:value-of select="'8'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</status>
	</xsl:template>
	<xsl:template name="active">
		<active>
			<xsl:choose>
				<xsl:when test="not(b:startDate) and not(b:closureDate)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:closureDate and not(b:accountNosGroup/b:accountNos)">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="(b:startDate and not(b:closureDate)) and (number(translate(b:startDate,'-','')) &lt;= number(translate(b:coCodeDatesToday,'-','')))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="(not(b:startDate) and b:closureDate) and (number(translate(b:closureDate,'-','')) &gt;= number(translate(b:coCodeDatesToday,'-','')))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="(b:startDate and b:closureDate) and (number(translate(b:startDate,'-','')) &lt;= number(translate(b:coCodeDatesToday,'-',''))) and (number(translate(b:closureDate,'-','')) &gt;= number(translate(b:coCodeDatesToday,'-','')))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</active>
	</xsl:template>
	<xsl:template name="businessEntityComposition">
		<xsl:if test="b:ownCompId and b:ownCompId != ''">
			<businessEntityComposition>
				<infra:businessEntity>
					<infra:code>
						<xsl:value-of select="b:ownCompId"/>
					</infra:code>
				</infra:businessEntity>
				<infra:mainBusinessEntity>1</infra:mainBusinessEntity>
				<infra:role>0</infra:role>
				<infra:type>
					<infra:code>OWNCOMPANY</infra:code>
				</infra:type>
			</businessEntityComposition>
		</xsl:if>
		<xsl:if test="b:portCompId and b:portCompId != ''">
			<businessEntityComposition>
				<infra:businessEntity>
					<infra:code>
						<xsl:value-of select="b:portCompId"/>
					</infra:code>
				</infra:businessEntity>
				<infra:mainBusinessEntity>0</infra:mainBusinessEntity>
				<infra:role>0</infra:role>
				<infra:type>
					<infra:code>ACCTCOMPANY</infra:code>
				</infra:type>
			</businessEntityComposition>
		</xsl:if>
		<xsl:if test="b:coCode and b:coCode != ''">
			<businessEntityComposition>
				<infra:businessEntity>
					<infra:code>
						<xsl:value-of select="b:coCode"/>
					</infra:code>
				</infra:businessEntity>
				<infra:mainBusinessEntity>0</infra:mainBusinessEntity>
				<infra:role>0</infra:role>
				<infra:type>
					<infra:code>FILECOMPANY</infra:code>
				</infra:type>
			</businessEntityComposition>
		</xsl:if>
	</xsl:template>
	<xsl:template name="client">
		<client>
			<infra:code>
				<xsl:if test="b:customerNumber != ''">
					<xsl:value-of select="concat($CUSTOMER_PREFIX,b:customerNumber)"/>
				</xsl:if>
			</infra:code>
		</client>
	</xsl:template>
	<xsl:template name="managementBeginDate">
		<xsl:if test="b:startDate != ''">
			<managementBeginDate>
				<xsl:value-of select="b:startDate"/>
			</managementBeginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="managementEndDate">
		<xsl:if test="b:closureDate != ''">
			<managementEndDate>
				<xsl:value-of select="b:closureDate"/>
			</managementEndDate>
		</xsl:if>
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
	<xsl:template name="parentChildIndicator">
		<parentChildIndicator>1</parentChildIndicator>
	</xsl:template>
	<xsl:template name="paymentInstruction">
		<!-- BEG - paymentInstruction for accountNosGroup -->
		<xsl:for-each select="b:accountNosGroup">
			<paymentInstruction>
				<account>
					<infra:code>
						<xsl:value-of select="b:accountNos"/>
					</infra:code>
				</account>
				<currency>
					<infra:code>
						<xsl:value-of select="b:accountCcy"/>
					</infra:code>
				</currency>
				<operationNature>0</operationNature>
			</paymentInstruction>
		</xsl:for-each>
		<!--  Remove the payment instructions for the accounts that do not exist anymore as accountNo -->
		<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:accountNosGroup/b:accountNos">
			<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:accountNosGroup[b:accountNos = current()])">
				<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:accountNosGroup[b:accountCcy = current()/following-sibling::b:accountCcy])">
					<paymentInstruction mode="delete">
						<account>
							<infra:code>
								<xsl:value-of select="."/>
							</infra:code>
						</account>
						<currency>
							<infra:code>
								<xsl:value-of select="../b:accountCcy"/>
							</infra:code>
						</currency>
						<operationNature>0</operationNature>
					</paymentInstruction>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<!-- END - paymentInstruction for accountNosGroup -->
		<!-- BEG - paymentInstruction for incAccountNoGroup -->
		<xsl:if test="b:exclIncValuationScParameterJoin = 'YES'">
			<xsl:for-each select="b:incAccountNoGroup">
				<paymentInstruction>
					<account>
						<infra:code>
							<xsl:value-of select="b:incAccountNo"/>
						</infra:code>
					</account>
					<currency>
						<infra:code>
							<xsl:value-of select="b:incAccountCcy"/>
						</infra:code>
					</currency>
					<operationNature>3</operationNature>
				</paymentInstruction>
			</xsl:for-each>
			<!--  Remove the payment instructions for the accounts that do not exist anymore as accountNo -->
			<xsl:for-each select="../../c:PreviousEvent/b:Portfolio/b:incAccountNoGroup/b:incAccountNo">
				<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:incAccountNoGroup[b:incAccountNo = current()])">
					<xsl:if test="not(../../../../c:CurrentEvent/b:Portfolio/b:incAccountNoGroup[b:incAccountCcy = current()/following-sibling::b:incAccountCcy])">
						<paymentInstruction mode="delete">
							<account>
								<infra:code>
									<xsl:value-of select="."/>
								</infra:code>
							</account>
							<currency>
								<infra:code>
									<xsl:value-of select="../b:incAccountCcy"/>
								</infra:code>
							</currency>
							<operationNature>3</operationNature>
						</paymentInstruction>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<!-- END - paymentInstruction for incAccountNoGroup -->
	</xsl:template>
	<xsl:template name="performanceCurrency">
		<performanceCurrency>
			<infra:code>
				<xsl:value-of select="b:referenceCurrency"/>
			</infra:code>
		</performanceCurrency>
	</xsl:template>
	<xsl:template name="portfolioManager">
		<portfolioManager>
			<infra:code>
				<xsl:value-of select="b:otherOfficerList/b:otherOfficer"/>
			</infra:code>
		</portfolioManager>
	</xsl:template>
	<xsl:template name="relationshipManager">
		<relationshipManager>
			<infra:code>
				<xsl:value-of select="b:accountOfficer"/>
			</infra:code>
		</relationshipManager>
	</xsl:template>
	<xsl:template name="reportingLanguage">
		<reportingLanguage>
			<xsl:call-template name="languageTranslation">
				<xsl:with-param name="boLanguage" select="b:customerLanguageMnemonic"/>
			</xsl:call-template>
		</reportingLanguage>
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
		</xsl:element>
		<!--</xsl:if>-->
	</xsl:template>
	<xsl:template name="marginLending">
		<xsl:choose>
			<xsl:when test="b:marginLending and b:marginLending='YES'">
				<marginLending>
					<xsl:value-of select="'1'"/>
				</marginLending>
			</xsl:when>
			<xsl:otherwise>
				<marginLending>
					<xsl:value-of select="'0'"/>
				</marginLending>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="cashBookingModel">
		<xsl:if test="b:memoAccount and b:memoAccount != ''">
			<cashBookingModel>
				<xsl:choose>
					<xsl:when test="b:memoAccount = 'NO'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'1'"/>
					</xsl:otherwise>
				</xsl:choose>
			</cashBookingModel>
		</xsl:if>
	</xsl:template>
    <xsl:template name="serviceType">
        <serviceType>
                <xsl:choose>
                    <xsl:when test="not(b:managedAccount) or b:managedAccount = ''">
                        <xsl:value-of select="'0'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '1'">
                        <xsl:value-of select="'2'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '2'">
                        <xsl:value-of select="'1'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '3'">
                        <xsl:value-of select="'5'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '4'">
                        <xsl:value-of select="'3'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '5'">
                        <xsl:value-of select="'6'"/>
                    </xsl:when>
                    <xsl:when test="b:managedAccount = '6'">
                        <xsl:value-of select="'4'"/>
                    </xsl:when>                                     
                    <xsl:when test="b:managedAccount = '9'">
                        <xsl:value-of select="'0'"/>
                    </xsl:when>                                                                             
                    <xsl:otherwise>
                        <xsl:value-of select="''"/>
                    </xsl:otherwise>
                </xsl:choose>            
        </serviceType>
    </xsl:template>
	<xsl:template name="trailerFeeEligibility">
		<trailerFeeEligibility>
			<xsl:choose>
				<xsl:when test="b:reimburseTrFee = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</trailerFeeEligibility>
	</xsl:template>
	<xsl:template name="trailerFeePercentage">
		<xsl:if test="b:reimburseTrRate and b:reimburseTrRate != ''">
			<trailerFeePercentage>
				<xsl:value-of select="b:reimburseTrRate"/>
			</trailerFeePercentage>
		</xsl:if>
	</xsl:template>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="creditStatus"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="nature"/>
	<xsl:template name="parentPortfolio"/>
	<xsl:template name="performanceDataStorageFrequency"/>
	<xsl:template name="performanceDataStorageUnit"/>
	<xsl:template name="performanceDetailLevel"/>
	<xsl:template name="portfolioGroup"/>
	<xsl:template name="portfolioType"/>
	<xsl:template name="positionManagementDate"/>
	<xsl:template name="positionManagementLevel"/>
	<xsl:template name="positionManagementRule"/>
	<xsl:template name="sharia"/>
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