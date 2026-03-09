<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/Customer"
                xmlns:t="http://www.temenos.com/T24/SecuritiesEventsService/NciDetails" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCustomer" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCustomer"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCustomer" exclude-result-prefixes="b c batch multibatch ns0 t" version="1.0">
	<xsl:template name="mbFields">
		<mbFields>
			<mbField>
				<name>disability_f</name>
				<value>
					<xsl:choose>
						<xsl:when test="b:vulnerabilityList/b:vulnerability = 'DISABLED'">
							<xsl:value-of select=" '1' "/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select=" '0' "/>
						</xsl:otherwise>
					</xsl:choose>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>total_income_m</name>
				<value>
					<xsl:value-of select="b:netMonthlyIn"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>salary_m</name>
				<value>
					<xsl:value-of select="b:salaryGroup/b:salary"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>total_expenses_m</name>
				<value>
					<xsl:value-of select="b:netMonthlyOut"/>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>birth_date_d</name>
				<value>
					<xsl:if test="b:dateOfBirth !=''">
						<xsl:call-template name="xsdateSepSlash">
							<xsl:with-param name="date" select="b:dateOfBirth"/>
						</xsl:call-template>
					</xsl:if>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>vulnerable_e</name>
				<value>
					<xsl:choose>
						<xsl:when test="b:vulnerabilityList/b:vulnerability='VISUALLY.IMPAIRED'">
							<xsl:value-of select="1"/>
						</xsl:when>
						<xsl:when test="b:vulnerabilityList/b:vulnerability='HEARING.IMPAIRED'">
							<xsl:value-of select="1"/>
						</xsl:when>
						<xsl:when test="b:vulnerabilityList/b:vulnerability='DISABLED'">
							<xsl:value-of select="1"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="2"/>
						</xsl:otherwise>
					</xsl:choose>
				</value>
				<type>string</type>
			</mbField>
			<mbField>
				<name>legal_entity_type_e</name>
				<value>
					<xsl:choose>
						<xsl:when test="b:legalEntType ='PERSON'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:legalEntType ='ORGANIZATION'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
						<xsl:when test="b:legalEntType ='ECONOMIC.GROUP'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="b:legalEntType ='HOUSEHOLD'">
							<xsl:value-of select="'5'"/>
						</xsl:when>
						<xsl:when test="b:legalEntType ='CUSTOMER'">
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
	</xsl:template>
	<xsl:template name="synonym">
		<!-- BEG - Third Party Synonym (LEI) -->
		<xsl:if test="b:legalEntityIdOcCustomerJoin and b:legalEntityIdOcCustomerJoin != ''">
			<synonym>
				<xsl:call-template name="active_LEI"/>
				<xsl:call-template name="beginDate_LEI"/>
				<code>
					<xsl:value-of select="b:legalEntityIdOcCustomerJoin"/>
				</code>
				<codification>
					<xsl:value-of select="$THIRDPARTY_LEI_CODIFICATION"/>
				</codification>
				<xsl:call-template name="endDate_LEI"/>
				<xsl:call-template name="status_LEI"/>
				<xsl:call-template name="mbFields_LEI"/>
			</synonym>
		</xsl:if>
		<!-- END - Third Party Synonym (LEI) -->
		<!-- BEG - Third Party Synonym when LEI module is not installed  -->
		<xsl:if test="(b:ocCustomerId != b:id or not(b:ocCustomerId)) and b:customerSecurityId and b:customerSecurityId != ''">
			<xsl:for-each select="b:legalIdGroup[b:legalDocName = 'LEI']/b:legalId">
				<synonym>
					<xsl:call-template name="active_NLEI"/>
					<xsl:call-template name="beginDate_NLEI"/>
					<code>
						<xsl:value-of select="."/>
					</code>
					<codification>
						<xsl:value-of select="$THIRDPARTY_LEI_CODIFICATION"/>
					</codification>
					<xsl:call-template name="endDate_NLEI"/>
					<xsl:call-template name="status_NLEI"/>
					<xsl:call-template name="mbFields_NLEI"/>
				</synonym>
			</xsl:for-each>
		</xsl:if>
		<!-- END - Third Party Synonym when LEI module is not installed  -->
		<!-- BEG - Third Party Synonym (NCI) -->
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
								<xsl:value-of select="$NciCodeCUST"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='CCPT'">
								<xsl:value-of select="$NciCodeCCPT"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='NIDN'">
								<xsl:value-of select="$NciCodeNIDN"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='SOSE'">
								<xsl:value-of select="$NciCodeSOSE"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='TXID'">
								<xsl:value-of select="$NciCodeTXID"/>
							</xsl:when>
							<xsl:when test="../t:NciCode ='CONCAT'">
								<xsl:value-of select="$NciCodeCONCAT"/>
							</xsl:when>
						</xsl:choose>
					</codification>
					<xsl:call-template name="endDate_NCI"/>
					<xsl:call-template name="status_NCI"/>
					<xsl:call-template name="mbFields_NCI"/>
				</synonym>
			</xsl:for-each>
		</xsl:if>
		<!-- END - Third Party Synonym (NCI) -->
	</xsl:template>

	<xsl:template name="active_LEI">
		<xsl:choose>
			<xsl:when test="b:entityStatusLeDirectoryJoin = 'ACTIVE'">
				<active>
					<xsl:value-of select="'1'"/>
				</active>
			</xsl:when>
			<xsl:when test="b:entityStatusLeDirectoryJoin = 'INACTIVE'">
				<active>
					<xsl:value-of select="'0'"/>
				</active>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="beginDate_LEI">
		<xsl:if test="b:assignedDateLeDirectoryJoin and b:assignedDateLeDirectoryJoin != ''">
			<beginDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:assignedDateLeDirectoryJoin"/>
				</xsl:call-template>
			</beginDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="endDate_LEI">
		<xsl:if test="b:nextRenewalDateLeDirectoryJoin and b:nextRenewalDateLeDirectoryJoin != ''">
			<endDate>
				<xsl:call-template name="xsdatetime">
					<xsl:with-param name="date" select="b:nextRenewalDateLeDirectoryJoin"/>
				</xsl:call-template>
			</endDate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="status_LEI">
		<xsl:if test="b:registrationStatusLeDirectoryJoin and b:registrationStatusLeDirectoryJoin != ''">
			<status>
				<xsl:call-template name="leDirectoryRegistrationStatusTranslation">
					<xsl:with-param name="registrationStatus" select="translate(b:registrationStatusLeDirectoryJoin,$lowercase,$uppercase)"/>
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

	<!-- BEG - ChronologicalData tab for L2 Layer-->
	<xsl:template name="mappingChronologicalData">
		<xsl:if test="b:loansInCir and b:loansInCir != ''">
			<ChronologicalData>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('Customer.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="ChronologicalData_code"/>
				<xsl:call-template name="ChronologicalData_currency"/>
				<xsl:call-template name="ChronologicalData_dataNature"/>
				<xsl:call-template name="ChronologicalData_validity"/>
				<xsl:call-template name="ChronologicalData_value"/>
				<xsl:call-template name="ChronologicalData_mbFields"/>
			</ChronologicalData>
		</xsl:if>
	</xsl:template>
	<!-- END - ChronologicalData tab for L2 Layer-->

	<!-- BEG - ChronologicalData Templates' definitions -->
	<xsl:template name="ChronologicalData_code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="ChronologicalData_dataNature">
		<dataNature>
			<xsl:value-of select="'151'"/>
		</dataNature>
	</xsl:template>
	<xsl:template name="ChronologicalData_value">
		<value>
			<xsl:value-of select="b:loansInCir"/>
		</value>
	</xsl:template>
	<xsl:template name="ChronologicalData_currency">
		<currency>
			<code>
				<xsl:value-of select="b:loansInCirccy"/>
			</code>
		</currency>
	</xsl:template>
	<xsl:template name="ChronologicalData_validity">
		<xsl:if test="b:eventCommon/ns0:today != ''">
			<validity>
				<xsl:value-of select="b:eventCommon/ns0:today"/>
			</validity>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ChronologicalData_mbFields"/>
	<!-- END - ChronologicalData Templates' definitions -->

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