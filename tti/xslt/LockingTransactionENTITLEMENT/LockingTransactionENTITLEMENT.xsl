<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockingTransactionCOA"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockingTransactionCOA" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockingTransactionCOA" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransactionCOA" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiLockingTransactionCOA">
		<xsl:apply-templates select="c:CurrentEvent/b:LockingTransactionCOA"/>
	</xsl:template>
	<xsl:template match="batch:BatchLockingTransactionCOA">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchLockingTransactionCOA" name="BatchLockingTransactionCOA">
			<xsl:apply-templates select="b:LockingTransactionCOA"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiLockingTransactionCOA">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransactionCOA" name="BatchMultiLockingTransactionCOA">
			<xsl:apply-templates select="c:MultiLockingTransactionCOA"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:LockingTransactionCOA">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('LockingTransactionENTITLEMENT',b:id)"/>
			</xsl:attribute>
			<DataGroup>
				<xsl:choose>
					<xsl:when test="b:newSecurityGroup/b:newSecuritySubGroup[b:nominal and b:nominal != '' and number(b:nominal) != '0'] and b:blockNewSec = 'YES'">
						<xsl:for-each select="b:newSecurityGroup/b:newSecuritySubGroup[b:nominal and b:nominal != '' and number(b:nominal) != '0']">
							<xsl:call-template name="mappingLockingTransactionCOA">
								<xsl:with-param name="isNewSecPres" select="'Y'"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="mappingLockingTransactionCOA">
							<xsl:with-param name="isNewSecPres" select="'N'"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</DataGroup>
		</TransactionPMS>
	</xsl:template>
	<xsl:template name="mappingLockingTransactionCOA">
		<xsl:param name="isNewSecPres"/>
		<xsl:param name="eventId">
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="../../b:eventCommon/ns0:eventId"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:eventCommon/ns0:eventId"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:param name="creationTime">
			<xsl:choose>
				<xsl:when test="$isNewSecPres = 'Y'">
					<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<Security>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('LockingTransactionENTITLEMENT.xsl+', name(/*), '+', $eventId, '+', $creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="$creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<locking>
				<xsl:call-template name="accountingCode">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="accountingDate">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="cashPortfolio">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="commonReference">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="contractNumber">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="depositaryAccount">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="endDate">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="initiatedBy">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="lockingDate">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="LockingTransactionCOACode">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="lockingType">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="lockingUnlocking">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="notepad">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="portfolioManager">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="positionCriteria1">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="positionCriteria2">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="positionCriteria3">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="portfolio">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="quantity">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="remark">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="reversalIndicator">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="reversedTransactionCode">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="security">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="sourceSystemCode">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="splitPortfolio">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="status">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="subType">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="trader">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="transactionCode">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="transactionCurrency">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="type">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="validityDate">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="valueDate">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="userDefinedField">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
				<xsl:call-template name="mbFields">
					<xsl:with-param name="isNewSecPres" select="$isNewSecPres"/>
				</xsl:call-template>
			</locking>
		</Security>
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