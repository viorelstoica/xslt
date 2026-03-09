<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CgTxnBase"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCgTxnBase" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCgTxnBase" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCgTxnBase" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="taxLotSourceCode">
		<taxLotSourceCode>
			<xsl:value-of select="."/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode"/>
	<xsl:template name="portfolio">
		<portfolio>
			<xsl:value-of select="../../b:origSam"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<xsl:value-of select="substring-before(substring-after(substring-after(concat(../../../b:id,'.'),'.'),'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:variable name="purTxnNom">
			<xsl:choose>
				<xsl:when test="not(../b:purTxnNom) or ../b:purTxnNom = '' or ../b:purTxnNom = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:purTxnNom * -1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<quantity>
			<xsl:value-of select="$purTxnNom"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../../b:tradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount">
		<xsl:variable name="trdValue">
			<xsl:choose>
				<xsl:when test="not(../../b:trdValue) or ../../b:trdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdValue &lt; 0">
					<xsl:value-of select="../../b:trdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="trdNominal">
			<xsl:choose>
				<xsl:when test="not(../../b:trdNominal) or ../../b:trdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdNominal &lt; 0">
					<xsl:value-of select="../../b:trdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNom">
			<xsl:choose>
				<xsl:when test="not(../b:purTxnNom) or ../b:purTxnNom = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:purTxnNom"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posGrossAmount>
			<xsl:choose>
				<xsl:when test="$trdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$trdValue*($purTxnNom div $trdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount">
		<xsl:variable name="trdValue">
			<xsl:choose>
				<xsl:when test="not(../../b:trdValue) or ../../b:trdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdValue &lt; 0">
					<xsl:value-of select="../../b:trdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="trdNominal">
			<xsl:choose>
				<xsl:when test="not(../../b:trdNominal) or ../../b:trdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdNominal &lt; 0">
					<xsl:value-of select="../../b:trdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNom">
			<xsl:choose>
				<xsl:when test="not(../b:purTxnNom) or ../b:purTxnNom = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:purTxnNom"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="expenses">
			<xsl:choose>
				<xsl:when test="not(../../b:expenses) or ../../b:expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:choose>
				<xsl:when test="$trdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($trdValue + $expenses)*($purTxnNom div $trdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount">
		<xsl:choose>
			<xsl:when test="../b:purStCgPl and ../b:purStCgPl != ''">
				<posPlStNetAmount>
					<xsl:value-of select="../b:purStCgPl"/>
				</posPlStNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlStNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtNetAmount">
		<xsl:choose>
			<xsl:when test="../b:purLtCgPl and ../b:purLtCgPl != ''">
				<posPlLtNetAmount>
					<xsl:value-of select="../b:purLtCgPl"/>
				</posPlLtNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posFeesTaxesAmount">
		<xsl:variable name="trdNominal">
			<xsl:choose>
				<xsl:when test="not(../../b:trdNominal) or ../../b:trdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdNominal &lt; 0">
					<xsl:value-of select="../../b:trdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNom">
			<xsl:choose>
				<xsl:when test="not(../b:purTxnNom) or ../b:purTxnNom = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:purTxnNom"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="expenses">
			<xsl:choose>
				<xsl:when test="not(../../b:expenses) or ../../b:expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posFeesTaxesAmount>
			<xsl:choose>
				<xsl:when test="$trdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$expenses *($purTxnNom div $trdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="impact">
		<impact>
			<xsl:value-of select="'0'"/>
		</impact>
	</xsl:template>
	<xsl:template name="taxEffectiveDate">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../../b:effectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount"/>
	<xsl:template name="posIndexedAmount"/>
	<xsl:template name="posPlNonDiscAmount">
		<posPlNonDiscAmount>
			<xsl:value-of select="../b:purStCgStd"/>
		</posPlNonDiscAmount>
	</xsl:template>
	<xsl:template name="posPlIndexedAmount">
		<posPlIndexedAmount>
			<xsl:value-of select="../b:purLtCgIndexed"/>
		</posPlIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlDiscountedAmount">
		<posPlDiscountedAmount>
			<xsl:value-of select="../b:purLtCgDiscount"/>
		</posPlDiscountedAmount>
	</xsl:template>
	<xsl:template name="movementNature">
		<movementNature>
			<xsl:value-of select="'2'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote"/>
	<xsl:template name="posPlStGrossAmount">
		<xsl:choose>
			<xsl:when test="../b:purStCgPl and ../b:purStCgPl != ''">
				<posPlStGrossAmount>
					<xsl:value-of select="../b:purStCgPl"/>
				</posPlStGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlStGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtGrossAmount">
		<xsl:choose>
			<xsl:when test="../b:purLtCgPl and ../b:purLtCgPl != ''">
				<posPlLtGrossAmount>
					<xsl:value-of select="../b:purLtCgPl"/>
				</posPlLtGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="accrAmount">
		<xsl:if test="../../b:accruedInt and ../../b:accruedInt != ''">
			<accrAmount>
				<xsl:value-of select="../../b:accruedInt"/>
			</accrAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price">
		<xsl:variable name="trdValue">
			<xsl:choose>
				<xsl:when test="not(../../b:trdValue) or ../../b:trdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdValue &lt; 0">
					<xsl:value-of select="../../b:trdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="trdNominal">
			<xsl:choose>
				<xsl:when test="not(../../b:trdNominal) or ../../b:trdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../../b:trdNominal &lt; 0">
					<xsl:value-of select="../../b:trdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../../b:trdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<price>
			<xsl:choose>
				<xsl:when test="$trdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$trdValue div $trdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</price>
	</xsl:template>

	<xsl:template name="taxLotSourceCode_taxLotId">
		<taxLotSourceCode>
			<xsl:value-of select="../b:taxLotId"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_taxLotId"/>
	<xsl:template name="portfolio_taxLotId">
		<portfolio>
			<xsl:value-of select="../b:origSam"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_taxLotId">
		<instrument>
			<xsl:value-of select="substring-before(substring-after(substring-after(concat(../../b:id,'.'),'.'),'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_taxLotId">
		<quantity>
			<xsl:value-of select="../b:trdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_taxLotId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../b:tradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_taxLotId">
		<posGrossAmount>
			<xsl:value-of select="../b:trdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_taxLotId">
		<xsl:variable name="expenses">
			<xsl:choose>
				<xsl:when test="not(../b:expenses) or ../b:expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="trdValue">
			<xsl:choose>
				<xsl:when test="not(../b:trdValue) or ../b:trdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../b:trdValue &lt; 0">
					<xsl:value-of select="../b:trdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../b:trdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$trdValue + $expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_taxLotId"/>
	<xsl:template name="posPlLtNetAmount_taxLotId"/>
	<xsl:template name="posFeesTaxesAmount_taxLotId">
		<posFeesTaxesAmount>
			<xsl:value-of select="../b:expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_taxLotId">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_taxLotId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../b:effectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_taxLotId">
		<posReducedAmount>
			<xsl:value-of select="../b:cgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_taxLotId">
		<xsl:if test="../b:cgIndexedCost and ../b:cgIndexedCost != ''">
			<posIndexedAmount>
				<xsl:value-of select="../b:cgIndexedCost"/>
			</posIndexedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_taxLotId"/>
	<xsl:template name="posPlIndexedAmount_taxLotId"/>
	<xsl:template name="posPlDiscountedAmount_taxLotId"/>
	<xsl:template name="movementNature_taxLotId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_taxLotId">
		<quote>
			<xsl:value-of select="../b:costPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_taxLotId"/>
	<xsl:template name="posPlLtGrossAmount_taxLotId"/>
	<xsl:template name="accrAmount_taxLotId">
		<xsl:if test="../b:accruedInt and ../b:accruedInt != ''">
			<accrAmount>
				<xsl:value-of select="../b:accruedInt"/>
			</accrAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="impact_taxLotId">
		<impact>
			<xsl:value-of select="'0'"/>
		</impact>
	</xsl:template>
	<xsl:template name="price_taxLotId"/>
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