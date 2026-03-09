<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdGroupPayment" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<xsl:template name="infra:code">
		<xsl:param name="header" select="'TPL_NOT_FID_'"/>
		<infra:code>
			<xsl:value-of select="concat($header, translate(b:id,'.','_'))"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="infra:shortName">
		<infra:shortName>
			<xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
		</infra:shortName>
	</xsl:template>
	<xsl:template name="infra:longName">
		<infra:longName>
			<xsl:value-of select="b:descriptionList/b:description[@language=$boDefaultLanguage]"/>
		</infra:longName>
	</xsl:template>

	<xsl:template name="accrualRule">
		<xsl:variable name="ACCRUAL" select="b:intDayBasis"/>
	    <accrualRule>
	      <xsl:choose>
	        <xsl:when test="$ACCRUAL = 'A' or $ACCRUAL = 'A1' or $ACCRUAL = 'A2' or $ACCRUAL = 'A3'">
	          <xsl:value-of select="24"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'B'">
	          <xsl:value-of select="31"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'C'">
	          <xsl:value-of select="19"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'C2'">
	          <xsl:value-of select="20"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'D'">
	          <xsl:value-of select="13"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'E'">
	          <xsl:value-of select="29"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'E1'">
	          <xsl:value-of select="30"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'F'">
	          <xsl:value-of select="26"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'F1'">
	          <xsl:value-of select="26"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'F2'">
	          <xsl:value-of select="26"/>
	        </xsl:when>
	        <xsl:when test="$ACCRUAL = 'G' or $ACCRUAL = 'S'">
	          <xsl:value-of select="0"/>
	        </xsl:when>
	      </xsl:choose>
	    </accrualRule>
	</xsl:template>
	<xsl:template name="accruedInterestCalculation"/>
	<xsl:template name="active">
		<active>
			<xsl:value-of select=" '1' "/>
		</active>
	</xsl:template>
	<xsl:template name="priceCalculationRule"/>
	<xsl:template name="subNature">
		<xsl:choose>
			<xsl:when test="b:daysPriorConf != '' ">
				<subNature>
					<xsl:value-of select=" '116' "/>
				</subNature>
			</xsl:when>
			<xsl:otherwise>
				<subNature>
					<xsl:value-of select=" '117' "/>
				</subNature>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="tenorFrequency">
		<xsl:if test="b:daysPriorConf = '' or not(b:daysPriorConf)">
			<tenorFrequency>
				<xsl:variable name="ID" select="substring-after(substring-after(b:id, '.'),'.')"/>
				
				<xsl:value-of select="translate($ID,translate($ID, '0123456789', ''), '')"/>
			</tenorFrequency>
		</xsl:if>
	</xsl:template>
	<xsl:template name="tenorFrequencyUnit">
		<xsl:if test="b:daysPriorConf = '' or not(b:daysPriorConf)">
			<tenorFrequencyUnit>
				<xsl:variable name="ID" select="substring-after(substring-after(b:id, '.'),'.')"/>
	
				<xsl:variable name="ID1" select="translate($ID,translate($ID, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', ''), '')"/>
			<xsl:choose>
	        	<xsl:when test="$ID1 = 'M'">
	          		<xsl:value-of select="4"/>
	        	</xsl:when>
	        	<xsl:when test="$ID1 = 'W'">
	          		<xsl:value-of select="3"/>
	        	</xsl:when>
	        	<xsl:when test="$ID1 = 'D'">
	          		<xsl:value-of select="1"/>
	        	</xsl:when>
			</xsl:choose>
			</tenorFrequencyUnit>
		</xsl:if>
	</xsl:template>
	<xsl:template name="referenceCurrency">
		<referenceCurrency>
			<infra:code>
				<xsl:value-of select="substring-before(substring-after(b:id, '.'),'.')"/>
			</infra:code>
		</referenceCurrency>
	</xsl:template>
	<xsl:template name="issuer">
		<issuer>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX and $CUSTOMER_PREFIX !=''">
						<xsl:value-of select="concat($CUSTOMER_PREFIX,substring-before(b:id, '.'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="substring-before(b:id, '.')"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</issuer>
	</xsl:template>
	<xsl:template name="riskCountry"/>
	<xsl:template name="riskNature"/>
	<xsl:template name="valuationRule"/>
	<xsl:template name="noticeDay">
	<xsl:if test="b:daysPriorConf != '' ">
		<noticeDay>
			<xsl:value-of select="substring-after(substring-after(b:id, '.'),'.')"/>
		</noticeDay>
	</xsl:if>
	</xsl:template>
	<xsl:template name="nextPayDay">
		<nextPayDay>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="substring(b:intSettleDate, 1, 8)"/>
			</xsl:call-template>
		</nextPayDay>
	</xsl:template>
	<xsl:template name="paymentFrequency">
		<paymentFrequency>
			<xsl:choose>
				<xsl:when test="contains(b:intSettleDate, 'DAILY') or contains(b:intSettleDate, 'BSNSS')">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="contains(b:intSettleDate, 'WEEK')">
					<xsl:value-of select="substring-after(b:intSettleDate, 'WEEK')"/>
				</xsl:when>
				<xsl:when test="contains(b:intSettleDate, 'TWMTH')">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="substring(b:intSettleDate,9,1) = 'M'">
					<xsl:value-of select="substring(b:intSettleDate,10,2)"/>
				</xsl:when>
			</xsl:choose>
		</paymentFrequency>
	</xsl:template>
	<xsl:template name="paymentFrequencyUnit">
		<paymentFrequencyUnit>
			<xsl:choose>
				<xsl:when test="contains(b:intSettleDate, 'DAILY')">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="contains(b:intSettleDate, 'BSNSS')">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:when test="contains(b:intSettleDate, 'WEEK')">
					<xsl:value-of select="'3'"/>
				</xsl:when>
				<xsl:when test="contains(b:intSettleDate, 'TWMTH')">
					<xsl:value-of select="'4'"/>
				</xsl:when>
				<xsl:when test="substring(b:intSettleDate,9,1) = 'M' and substring-after(intsettleDate,'M') != 'NaN'">
					<xsl:value-of select="'4'"/>
				</xsl:when>
			</xsl:choose>
		</paymentFrequencyUnit>
	</xsl:template>
	<xsl:template name="paymentFrequencyDay">
		<xsl:if test="substring(b:intSettleDate,9,1) = 'M'">
			<paymentFrequencyDay>
				<xsl:value-of select="substring(b:intSettleDate,12,2)"/>
			</paymentFrequencyDay>
		</xsl:if>
	</xsl:template>
	<xsl:template name="closingDate"/>
	<xsl:template name="interestRate">
		<interestRate>
			<xsl:value-of select="b:currentIntRate"/>
		</interestRate>
	</xsl:template>
	<xsl:template name="usageNature">
		<usageNature>
			<xsl:value-of select="'6'"/>
		</usageNature>
	</xsl:template>
	<xsl:template name="openingDate"/>
	<xsl:template name="infra:synonym"/>
	<xsl:template name="infra:multilingualLongName"/>
	<xsl:template name="infra:notepad"/>
	<xsl:template name="infra:userDefinedField"/>
	<xsl:template name="infra:mbFields"/>
	<xsl:template name="accruedInterestRoundingRule"/>
	<xsl:template name="accruedInterestRoundingUnit"/>
	<xsl:template name="accruedInterestUnitaryRounding"/>
	<xsl:template name="euroConversionDate"/>
	<xsl:template name="euroConversionRule"/>
	<xsl:template name="euroNewInstrument"/>
	<xsl:template name="mainBusinessEntity"/>
	<xsl:template name="subType"/>
	<xsl:template name="taxCountry"/>
	<xsl:template name="tradable"/>
	<xsl:template name="type"/>
	<xsl:template name="provider"/>
	<xsl:template name="yieldCurve"/>
	<xsl:template name="portfolio"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition>
			<template name="infra:code"></template>
			<template name="accrualRule"></template>
		</MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->