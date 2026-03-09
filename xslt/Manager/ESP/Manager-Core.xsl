<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Manager"
                xmlns:t="http://www.temenos.com/T24/SecuritiesEventsService/NciDetails" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchManager" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiManager"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiManager" exclude-result-prefixes="b c batch multibatch ns0 t" version="1.0">


	<xsl:template name="synonym">
		<!-- BEG - Manager Synonym (LEI) -->
		<xsl:if test="b:ocCustomerId and b:ocCustomerId != '' and b:legalEntityId and b:legalEntityId != ''">
			<synonym>
				<xsl:call-template name="active_LEI"/>
				<xsl:call-template name="beginDate_LEI"/>
				<code>
					<xsl:value-of select="b:legalEntityId"/>
				</code>
				<codification>
					<xsl:value-of select="$MANAGER_LEI_CODIFICATION"/>
				</codification>
				<xsl:call-template name="endDate_LEI"/>
				<xsl:call-template name="status_LEI"/>
				<xsl:call-template name="mbFields_LEI"/>
			</synonym>
		</xsl:if>
		<!-- END - Manager Synonym  (LEI) -->
		<!-- BEG - Manager Synonym when LEI module is not installed  -->
		<xsl:if test="(b:ocCustomerId != b:customerId or not(b:ocCustomerId))">
			<xsl:for-each select="b:legalIdGroup[b:legalDocName = 'LEI']/b:legalId">
				<synonym>
					<xsl:call-template name="active_NLEI"/>
					<xsl:call-template name="beginDate_NLEI"/>
					<code>
						<xsl:value-of select="."/>
					</code>
					<codification>
						<xsl:value-of select="$MANAGER_LEI_CODIFICATION"/>
					</codification>
					<xsl:call-template name="endDate_NLEI"/>
					<xsl:call-template name="status_NLEI"/>
					<xsl:call-template name="mbFields_NLEI"/>
				</synonym>
			</xsl:for-each>
		</xsl:if>
		<!-- END - Manager Synonym when LEI module is not installed  -->
		<!-- BEG - Manager Synonym (NCI) -->
		<xsl:if test="b:NciList/t:priority  and b:NciList/t:priority != '' and b:NciList/t:NciCode and b:NciList/t:NciCode != ''">
			<xsl:for-each select="b:NciList/t:identification">
				<synonym>
					<xsl:call-template name="active_NCI"/>
					<xsl:call-template name="beginDate_NCI"/>
					<code>
						<xsl:value-of select="."/>
					</code>
					<codification>
						<xsl:choose>
							<xsl:when test="../t:NciCode ='CUST'">
								<xsl:value-of select="$ManagerNciCodeCUST"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='CCPT'">
								<xsl:value-of select="$ManagerNciCodeCCPT"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='NIDN'">
								<xsl:value-of select="$ManagerNciCodeNIDN"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='SOSE'">
								<xsl:value-of select="$ManagerNciCodeSOSE"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='TXID'">
								<xsl:value-of select="$ManagerNciCodeTXID"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='CONCAT'">
								<xsl:value-of select="$ManagerNciCodeCONCAT"/>
							</xsl:when>
						</xsl:choose>
					</codification>
					<xsl:call-template name="endDate_NCI"/>
					<xsl:call-template name="status_NCI"/>
					<xsl:call-template name="mbFields_NCI"/>
				</synonym>
			</xsl:for-each>
		</xsl:if>
		<!-- END - Manager Synonym (NCI) -->
	</xsl:template>

	<xsl:template name="active_LEI">
		<xsl:choose>
			<xsl:when test="b:entityStatus = 'ACTIVE'">
				<active>
					<xsl:value-of select="'1'"/>
				</active>
			</xsl:when>
			<xsl:when test="b:entityStatus = 'INACTIVE'">
				<active>
					<xsl:value-of select="'0'"/>
				</active>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="beginDate_LEI">
		<xsl:if test="b:assignedDate and b:assignedDate != ''">
			<beginDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:assignedDate"/>
				</xsl:call-template>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate_LEI">
		<xsl:if test="b:nextRenewalDate and b:nextRenewalDate != ''">
			<endDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:nextRenewalDate"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_LEI">
		<xsl:if test="b:registrationStatus and b:registrationStatus != ''">
			<status>
				<xsl:call-template name="leDirectoryRegistrationStatusTranslation">
					<xsl:with-param name="registrationStatus" select="translate(b:registrationStatus,$lowercase,$uppercase)"/>
				</xsl:call-template>
			</status>
		</xsl:if>
	</xsl:template>
	<xsl:template name="mbFields_LEI"/>



	<xsl:template name="active_NLEI"/>
	<xsl:template name="beginDate_NLEI">
		<xsl:if test="../b:legalIssDate and ../b:legalIssDate != ''">
			<beginDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="../b:legalIssDate"/>
				</xsl:call-template>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate_NLEI">
		<xsl:if test="../b:legalExpDate and ../b:legalExpDate != ''">
			<endDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="../b:legalExpDate"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_NLEI">
		<status>
			<xsl:value-of select="'2'"/>
		</status>
	</xsl:template>
	<xsl:template name="mbFields_NLEI"/>



	<xsl:template name="active_NCI"/>
	<xsl:template name="beginDate_NCI">
		<xsl:choose>
			<xsl:when test="../t:issuedDate and ../t:issuedDate != '' and contains('-',substring(../t:issuedDate,5,1))">
				<beginDate>
					<xsl:call-template name="xsdatetime">
						<xsl:with-param name="date" select="../t:issuedDate"/>
					</xsl:call-template>
				</beginDate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../t:issuedDate and ../t:issuedDate != ''">
					<beginDate>
						<xsl:call-template name="xsdatetimeNoSep">
							<xsl:with-param name="date" select="../t:issuedDate"/>
						</xsl:call-template>
					</beginDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="endDate_NCI">
		<xsl:choose>
			<xsl:when test="../t:expiryDate and ../t:expiryDate != '' and contains('-',substring(../t:expiryDate,5,1))">
				<endDate>
					<xsl:call-template name="xsdatetime">
						<xsl:with-param name="date" select="../t:expiryDate"/>
					</xsl:call-template>
				</endDate>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="../t:expiryDate and ../t:expiryDate != ''">
					<endDate>
						<xsl:call-template name="xsdatetimeNoSep">
							<xsl:with-param name="date" select="../t:expiryDate"/>
						</xsl:call-template>
					</endDate>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="status_NCI">
		<status>
			<xsl:value-of select="'2'"/>
		</status>
	</xsl:template>
	<xsl:template name="mbFields_NCI">
		<mbFields>
			<mbField>
				<name>priority_n</name>
				<value>
					<xsl:value-of select="../t:priority"/>
				</value>
				<type>string</type>
			</mbField>
		</mbFields>
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