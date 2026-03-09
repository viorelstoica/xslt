<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="c xsi ns1 ns2 ns0 batch" version="1.0" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTaxLot" xmlns="http://www.odcgroup.com/TransactionPMS"
                xmlns:ns1="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="http://www.temenos.com/T24/event/TTI/TaxLot"
                xsi:schemaLocation="http://www.temenos.com/T24/event/TTI/TaxLot TTI-TaxLot.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:ns2="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

	<!--Inserting new or updated or inserted TaxLot-->

	<xsl:template name="taxLotSourceCode_taxLotId">
		<taxLotSourceCode>
			<xsl:value-of select="."/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_taxLotId">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns2:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_taxLotId">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_taxLotId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_taxLotId">
		<quantity>
			<xsl:value-of select="../ns2:TrdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_taxLotId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_taxLotId">
		<posGrossAmount>
			<xsl:value-of select="../ns2:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_taxLotId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_taxLotId"/>
	<xsl:template name="posPlLtNetAmount_taxLotId"/>
	<xsl:template name="posFeesTaxesAmount_taxLotId">
		<posFeesTaxesAmount>
			<xsl:value-of select="../ns2:Expenses"/>
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
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_taxLotId">
		<posReducedAmount>
			<xsl:value-of select="../ns2:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_taxLotId">
		<posIndexedAmount>
			<xsl:value-of select="../ns2:cgIndexedCost"/>
		</posIndexedAmount>
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
			<xsl:value-of select="../ns2:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_taxLotId"/>
	<xsl:template name="posPlLtGrossAmount_taxLotId"/>
	<xsl:template name="accrAmount_taxLotId">
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_taxLotId"/>

	<!--Inserting new or updated or inserted PurTaxLot-->

	<xsl:template name="taxLotSourceCode">
		<xsl:param name="PurTaxLotID"/>
		<taxLotSourceCode>
			<xsl:value-of select="substring-before($PurTaxLotID,'$')"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns2:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="beginDate">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="movementNature">
		<movementNature>
			<xsl:value-of select="'2'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="inputNature">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="purTxnNomNeg">
			<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
		</xsl:variable>
		<quantity>
			<xsl:choose>
				<xsl:when test="$purTxnNomNeg = '' or $purTxnNomNeg = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$purTxnNomNeg * -1"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="posGrossAmount">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdNominal) or ../ns2:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdNominal &lt; 0">
					<xsl:value-of select="../ns2:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posGrossAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdNominal) or ../ns2:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdNominal &lt; 0">
					<xsl:value-of select="../ns2:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($TrdValue + $Expenses)*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStNetAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
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
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtNetAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
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
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdNominal) or ../ns2:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdNominal &lt; 0">
					<xsl:value-of select="../ns2:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posFeesTaxesAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Expenses *($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="taxEffectiveDate">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount"/>
	<xsl:template name="posIndexedAmount"/>
	<xsl:template name="posPlNonDiscAmount">
		<xsl:param name="purStCgStd"/>
		<xsl:if test="substring-before($purStCgStd,'$') != ''">
			<posPlNonDiscAmount>
				<xsl:value-of select="substring-before($purStCgStd,'$')"/>
			</posPlNonDiscAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlIndexedAmount">
		<xsl:param name="PurLtCgIndexed"/>
		<posPlIndexedAmount>
			<xsl:value-of select="substring-before($PurLtCgIndexed,'$')"/>
		</posPlIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlDiscountedAmount">
		<xsl:param name="purLtCgDiscount"/>
		<posPlDiscountedAmount>
			<xsl:value-of select="substring-before($purLtCgDiscount,'$')"/>
		</posPlDiscountedAmount>
	</xsl:template>
	<xsl:template name="quote"/>
	<xsl:template name="posPlStGrossAmount">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStGrossAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
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
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtGrossAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
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
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price">
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdNominal) or ../ns2:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdNominal &lt; 0">
					<xsl:value-of select="../ns2:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<price>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue div $TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</price>
	</xsl:template>

	<!--Tax Lot Delete Record-->

	<xsl:template name="taxLotSourceCode_Delete">
		<taxLotSourceCode>
			<xsl:value-of select="."/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_Delete">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns1:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_Delete">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_Delete">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_Delete">
		<quantity>
			<xsl:value-of select="../ns1:TrdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_Delete">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_Delete">
		<posGrossAmount>
			<xsl:value-of select="../ns1:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_Delete">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_Delete"/>
	<xsl:template name="posPlLtNetAmount_Delete"/>
	<xsl:template name="posFeesTaxesAmount_Delete">
		<posFeesTaxesAmount>
			<xsl:value-of select="../ns1:Expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_Delete">
		<inputNature>
			<xsl:value-of select="'2'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_Delete">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_Delete">
		<posReducedAmount>
			<xsl:value-of select="../ns1:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_Delete">
		<posIndexedAmount>
			<xsl:value-of select="../ns1:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_Delete"/>
	<xsl:template name="posPlIndexedAmount_Delete"/>
	<xsl:template name="posPlDiscountedAmount_Delete"/>
	<xsl:template name="movementNature_Delete">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_Delete">
		<quote>
			<xsl:value-of select="../ns1:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_Delete"/>
	<xsl:template name="posPlLtGrossAmount_Delete"/>
	<xsl:template name="accrAmount_Delete">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_Delete"/>

	<!--PurTaxLot Delete Record-->

	<xsl:template name="taxLotSourceCode_DeletePurTaxLot">
		<xsl:param name="PurTaxLotID"/>
		<taxLotSourceCode>
			<xsl:value-of select="substring-before($PurTaxLotID,'$')"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_DeletePurTaxLot">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns1:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_DeletePurTaxLot">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_DeletePurTaxLot">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="beginDate_DeletePurTaxLot">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="movementNature_DeletePurTaxLot">
		<movementNature>
			<xsl:value-of select="'2'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="inputNature_DeletePurTaxLot">
		<inputNature>
			<xsl:value-of select="'2'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="quantity_DeletePurTaxLot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="purTxnNomNeg">
			<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
		</xsl:variable>
		<quantity>
			<xsl:choose>
				<xsl:when test="$purTxnNomNeg = '' or $purTxnNomNeg = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$purTxnNomNeg * -1"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="posGrossAmount_DeletePurTaxLot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posGrossAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_DeletePurTaxLot">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStNetAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
				</posPlStNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlStNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtNetAmount_DeletePurTaxLot">
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtNetAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
				</posPlLtNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posFeesTaxesAmount_DeletePurTaxLot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posFeesTaxesAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Expenses *($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_DeletePurTaxLot">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_DeletePurTaxLot"/>
	<xsl:template name="posIndexedAmount_DeletePurTaxLot"/>
	<xsl:template name="posNetAmount_DeletePurTaxLot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($TrdValue + $Expenses)*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_DeletePurTaxLot">
		<xsl:param name="purStCgStd"/>
		<xsl:if test="substring-before($purStCgStd,'$') != ''">
			<posPlNonDiscAmount>
				<xsl:value-of select="substring-before($purStCgStd,'$')"/>
			</posPlNonDiscAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlIndexedAmount_DeletePurTaxLot">
		<xsl:param name="PurLtCgIndexed"/>
		<posPlIndexedAmount>
			<xsl:value-of select="substring-before($PurLtCgIndexed,'$')"/>
		</posPlIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlDiscountedAmount_DeletePurTaxLot">
		<xsl:param name="purLtCgDiscount"/>
		<posPlDiscountedAmount>
			<xsl:value-of select="substring-before($purLtCgDiscount,'$')"/>
		</posPlDiscountedAmount>
	</xsl:template>
	<xsl:template name="quote_DeletePurTaxLot"/>
	<xsl:template name="posPlStGrossAmount_DeletePurTaxLot">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStGrossAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
				</posPlStGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlStGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtGrossAmount_DeletePurTaxLot">
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtGrossAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
				</posPlLtGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="accrAmount_DeletePurTaxLot">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_DeletePurTaxLot">
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<price>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue div $TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</price>
	</xsl:template>

	<!--Inserting Backdated TaxLot-->

	<xsl:template name="taxLotSourceCode_backdatedtaxLotId">
		<taxLotSourceCode>
			<xsl:value-of select="."/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_backdatedtaxLotId">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns2:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_backdatedtaxLotId">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_backdatedtaxLotId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_backdatedtaxLotId">
		<quantity>
			<xsl:value-of select="../ns2:TrdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_backdatedtaxLotId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_backdatedtaxLotId">
		<posGrossAmount>
			<xsl:value-of select="../ns2:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_backdatedtaxLotId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_backdatedtaxLotId"/>
	<xsl:template name="posPlLtNetAmount_backdatedtaxLotId"/>
	<xsl:template name="posFeesTaxesAmount_backdatedtaxLotId">
		<posFeesTaxesAmount>
			<xsl:value-of select="../ns2:Expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_backdatedtaxLotId">
		<inputNature>
			<xsl:value-of select="'3'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_backdatedtaxLotId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_backdatedtaxLotId">
		<posReducedAmount>
			<xsl:value-of select="../ns2:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_backdatedtaxLotId">
		<posIndexedAmount>
			<xsl:value-of select="../ns2:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_backdatedtaxLotId"/>
	<xsl:template name="posPlIndexedAmount_backdatedtaxLotId"/>
	<xsl:template name="posPlDiscountedAmount_backdatedtaxLotId"/>
	<xsl:template name="movementNature_backdatedtaxLotId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_backdatedtaxLotId">
		<quote>
			<xsl:value-of select="../ns2:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_backdatedtaxLotId"/>
	<xsl:template name="posPlLtGrossAmount_backdatedtaxLotId"/>
	<xsl:template name="accrAmount_backdatedtaxLotId">
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_backdatedtaxLotId"/>

	<!--Only single call template to send backdate as it is different from normal update. 
		Rest templates will use existing insert functionality-->

	<xsl:template name="inputNature_Backdatedpurtaxlot">
		<inputNature>
			<xsl:value-of select="'3'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_NewTaxLotIdAfterBackDate">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_NewPurTaxLotIdAfterBackDate">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_DeleteAfterUpdatetaxLotId">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_DeleteAfterUpdatePurtaxLotId">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<!--Senging updated Old New PurTaxLot after the Backdate or Delete Operation-->

	<xsl:template name="taxLotSourceCode_OldtaxLotId">
		<taxLotSourceCode>
			<xsl:value-of select="."/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_OldtaxLotId">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns1:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_OldtaxLotId">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_OldtaxLotId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_OldtaxLotId">
		<quantity>
			<xsl:value-of select="../ns1:TrdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_OldtaxLotId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_OldtaxLotId">
		<posGrossAmount>
			<xsl:value-of select="../ns1:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_OldtaxLotId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_OldtaxLotId"/>
	<xsl:template name="posPlLtNetAmount_OldtaxLotId"/>
	<xsl:template name="posFeesTaxesAmount_OldtaxLotId">
		<posFeesTaxesAmount>
			<xsl:value-of select="../ns1:Expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_OldtaxLotId">
		<inputNature>
			<xsl:value-of select="'5'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_OldtaxLotId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_OldtaxLotId">
		<posReducedAmount>
			<xsl:value-of select="../ns1:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_OldtaxLotId">
		<posIndexedAmount>
			<xsl:value-of select="../ns1:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_OldtaxLotId"/>
	<xsl:template name="posPlIndexedAmount_OldtaxLotId"/>
	<xsl:template name="posPlDiscountedAmount_OldtaxLotId"/>
	<xsl:template name="movementNature_OldtaxLotId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_OldtaxLotId">
		<quote>
			<xsl:value-of select="../ns1:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_OldtaxLotId"/>
	<xsl:template name="posPlLtGrossAmount_OldtaxLotId"/>
	<xsl:template name="accrAmount_OldtaxLotId">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_OldtaxLotId"/>

	<!--Senging updated Old New PurTaxLot after the Backdate or Delete Operation-->

	<xsl:template name="taxLotSourceCode_Oldpurtaxlot">
		<xsl:param name="PurTaxLotID"/>
		<taxLotSourceCode>
			<xsl:value-of select="substring-before($PurTaxLotID,'$')"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_Oldpurtaxlot">
		<opSourceCode>
			<xsl:value-of select="substring-before(../ns1:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_Oldpurtaxlot">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_Oldpurtaxlot">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="beginDate_Oldpurtaxlot">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="movementNature_Oldpurtaxlot">
		<movementNature>
			<xsl:value-of select="'2'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="inputNature_Oldpurtaxlot">
		<inputNature>
			<xsl:value-of select="'5'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="quantity_Oldpurtaxlot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="purTxnNomNeg">
			<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
		</xsl:variable>
		<quantity>
			<xsl:choose>
				<xsl:when test="$purTxnNomNeg = '' or $purTxnNomNeg = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$purTxnNomNeg * -1"/>
				</xsl:otherwise>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="posGrossAmount_Oldpurtaxlot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posGrossAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_Oldpurtaxlot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="($TrdValue + $Expenses)*($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_Oldpurtaxlot">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStNetAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
				</posPlStNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlStNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtNetAmount_Oldpurtaxlot">
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtNetAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
				</posPlLtNetAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtNetAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtNetAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posFeesTaxesAmount_Oldpurtaxlot">
		<xsl:param name="PurTxnNom"/>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="purTxnNominal">
			<xsl:choose>
				<xsl:when test="substring-before($PurTxnNom,'$') != ''">
					<xsl:value-of select="substring-before($PurTxnNom,'$')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posFeesTaxesAmount>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$Expenses *($purTxnNominal div $TrdNominal)"/>
				</xsl:otherwise>
			</xsl:choose>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_Oldpurtaxlot">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_Oldpurtaxlot"/>
	<xsl:template name="posIndexedAmount_Oldpurtaxlot"/>
	<xsl:template name="posPlNonDiscAmount_Oldpurtaxlot">
		<xsl:param name="purStCgStd"/>
		<xsl:if test="substring-before($purStCgStd,'$') != ''">
			<posPlNonDiscAmount>
				<xsl:value-of select="substring-before($purStCgStd,'$')"/>
			</posPlNonDiscAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlIndexedAmount_Oldpurtaxlot">
		<xsl:param name="PurLtCgIndexed"/>
		<posPlIndexedAmount>
			<xsl:value-of select="substring-before($PurLtCgIndexed,'$')"/>
		</posPlIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlDiscountedAmount_Oldpurtaxlot">
		<xsl:param name="purLtCgDiscount"/>
		<posPlDiscountedAmount>
			<xsl:value-of select="substring-before($purLtCgDiscount,'$')"/>
		</posPlDiscountedAmount>
	</xsl:template>
	<xsl:template name="quote_Oldpurtaxlot"/>
	<xsl:template name="posPlStGrossAmount_Oldpurtaxlot">
		<xsl:param name="PurStCgPL"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurStCgPL,'$') and substring-before($PurStCgPL,'$') != ''">
				<posPlStGrossAmount>
					<xsl:value-of select="substring-before($PurStCgPL,'$')"/>
				</posPlStGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlStGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlStGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="posPlLtGrossAmount_Oldpurtaxlot">
		<xsl:param name="PurLtCgPl"/>
		<xsl:choose>
			<xsl:when test="substring-before($PurLtCgPl,'$') and substring-before($PurLtCgPl,'$') != ''">
				<posPlLtGrossAmount>
					<xsl:value-of select="substring-before($PurLtCgPl,'$')"/>
				</posPlLtGrossAmount>
			</xsl:when>
			<xsl:otherwise>
				<posPlLtGrossAmount>
					<xsl:value-of select="'0'"/>
				</posPlLtGrossAmount>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="accrAmount_Oldpurtaxlot">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_Oldpurtaxlot">
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdNominal">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdNominal) or ../ns1:TrdNominal = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdNominal &lt; 0">
					<xsl:value-of select="../ns1:TrdNominal * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<price>
			<xsl:choose>
				<xsl:when test="$TrdNominal = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$TrdValue div $TrdNominal"/>
				</xsl:otherwise>
			</xsl:choose>
		</price>
	</xsl:template>
	<xsl:template name="impact_taxLotId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="impact">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="impact_Delete">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="impact_DeletePurTaxLot">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!--xsl:template name="impact_taxLotId"/-->
	<!--xsl:template name="impact"/-->
	<!--xsl:template name="impact_taxLotId"/-->
	<xsl:template name="impact_backdatedtaxLotId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!--xsl:template name="impact_taxLotId"/-->
	<!--xsl:template name="impact"/-->
	<!--xsl:template name="impact"/-->
	<xsl:template name="impact_OldtaxLotId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="impact_Oldpurtaxlot">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!--xsl:template name="impact_OldtaxLotId"/-->

	<!--xsl:template name="Insert_WashTaxLotId" WashSales records for CG.WASH.SALE.DETS"/-->

	<xsl:template name="taxLotSourceCode_WashSales">
		<taxLotSourceCode>
			<xsl:value-of select="../ns2:TaxLotID"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_WashSales">
		<opSourceCode>
			<xsl:value-of select="substring-before(substring-before(../ns2:SecTransID,'*'),'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="impact_WashSales">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="portfolio_WashSales">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_WashSales">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_WashSales">
		<quantity>
			<xsl:value-of select="../ns2:TrdNominal"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_WashSales">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_WashSales">
		<posGrossAmount>
			<xsl:value-of select="../ns2:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_WashSales">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_WashSales"/>
	<xsl:template name="posPlLtNetAmount_WashSales"/>
	<xsl:template name="posFeesTaxesAmount_WashSales">
		<posFeesTaxesAmount>
			<xsl:value-of select="../ns2:Expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_WashSales">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_WashSales">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_WashSales">
		<posReducedAmount>
			<xsl:value-of select="../ns2:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_WashSales">
		<xsl:if test="../ns2:cgIndexedCost">
			<posIndexedAmount>
				<xsl:value-of select="../ns2:cgIndexedCost"/>
			</posIndexedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_WashSales"/>
	<xsl:template name="posPlIndexedAmount_WashSales"/>
	<xsl:template name="posPlDiscountedAmount_WashSales"/>
	<xsl:template name="movementNature_WashSales">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_WashSales">
		<quote>
			<xsl:value-of select="../ns2:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_WashSales"/>
	<xsl:template name="posPlLtGrossAmount_WashSales"/>
	<xsl:template name="accrAmount_WashSales">
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_WashSales"/>
	<!-- End - Insert WashSales -->

	<!-- Beg - Update WashSales -->
	<xsl:template name="taxLotSourceCode_UpdateWashSales">
		<xsl:param name="isReplacementPartOfDisallowedTxn"/>
		<taxLotSourceCode>
			<xsl:choose>
				<xsl:when test="$isReplacementPartOfDisallowedTxn = 'Y'">
					<xsl:value-of select="ns2:PurTaxLotID"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ns2:TaxLotID"/>
				</xsl:otherwise>
			</xsl:choose>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="impact_UpdateWashSales">
		<impact>
			<xsl:choose>
				<xsl:when test="../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="portfolio_UpdateWashSales">
		<portfolio>
			<xsl:value-of select="ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_UpdateWashSales">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="beginDate_UpdateWashSales">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_UpdateWashSales">
		<posGrossAmount>
			<xsl:value-of select="ns2:TrdValue"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_UpdateWashSales">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(ns2:Expenses) or ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(ns2:TrdValue) or ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_UpdateWashSales"/>
	<xsl:template name="posPlLtNetAmount_UpdateWashSales"/>
	<xsl:template name="posFeesTaxesAmount_UpdateWashSales">
		<posFeesTaxesAmount>
			<xsl:value-of select="ns2:Expenses"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_UpdateWashSales">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_UpdateWashSales">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_UpdateWashSales">
		<xsl:if test="ns2:CgReducedCost">
			<posReducedAmount>
				<xsl:value-of select="ns2:CgReducedCost"/>
			</posReducedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posIndexedAmount_UpdateWashSales">
		<xsl:if test="ns2:cgIndexedCost">
			<posIndexedAmount>
				<xsl:value-of select="ns2:cgIndexedCost"/>
			</posIndexedAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_UpdateWashSales"/>
	<xsl:template name="posPlIndexedAmount_UpdateWashSales"/>
	<xsl:template name="posPlDiscountedAmount_UpdateWashSales"/>
	<xsl:template name="quote_UpdateWashSales">
		<xsl:if test="ns2:CostPerUnit">
			<quote>
				<xsl:value-of select="ns2:CostPerUnit"/>
			</quote>
		</xsl:if>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_UpdateWashSales"/>
	<xsl:template name="posPlLtGrossAmount_UpdateWashSales"/>
	<xsl:template name="accrAmount_UpdateWashSales">
		<xsl:if test="ns2:AccruedInt">
			<accrAmount>
				<xsl:value-of select="ns2:AccruedInt"/>
			</accrAmount>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price_UpdateWashSales"/>
	<xsl:template name="opSourceCode_UpdateWashSales">
		<opSourceCode>
			<xsl:value-of select="substring-before(ns2:SecTransID,'.')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="movementNature_UpdateWashSales">
		<movementNature>
			<xsl:value-of select="'2'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quantity_UpdateWashSales">
		<quantity>
			<xsl:value-of select="ns2:TrdNominal"/>
		</quantity>
	</xsl:template>
	<!-- End - Insert WashSales -->

	<!-- BEG - Inserting new or updated or inserted EntSecTransId -->
	<xsl:template name="taxLotSourceCode_EntSecTransId">
		<taxLotSourceCode>
			<xsl:value-of select="../ns2:TaxLotID"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_EntSecTransId">
		<xsl:param name="EntSecTransId"/>
		<opSourceCode>
			<xsl:value-of select="substring-before($EntSecTransId,'$')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_EntSecTransId">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_EntSecTransId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_EntSecTransId">
		<xsl:param name="EntNominal"/>
		<quantity>
			<xsl:value-of select="substring-before($EntNominal,'$')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_EntSecTransId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_EntSecTransId">
		<xsl:param name="EntCost"/>
		<posGrossAmount>
			<xsl:value-of select="substring-before($EntCost,'$')"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_EntSecTransId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_EntSecTransId"/>
	<xsl:template name="posPlLtNetAmount_EntSecTransId"/>
	<xsl:template name="posFeesTaxesAmount_EntSecTransId">
		<xsl:param name="EntExpenses"/>
		<posFeesTaxesAmount>
			<xsl:value-of select="substring-before($EntExpenses,'$')"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_EntSecTransId">
		<inputNature>
			<xsl:value-of select="'1'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_DeleteAfterUpdateEntSecTransId">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="inputNature_NewEntSecTransIdAfterBackDate">
		<inputNature>
			<xsl:value-of select="'4'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_EntSecTransId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_EntSecTransId">
		<posReducedAmount>
			<xsl:value-of select="../ns2:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_EntSecTransId">
		<posIndexedAmount>
			<xsl:value-of select="../ns2:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_EntSecTransId"/>
	<xsl:template name="posPlIndexedAmount_EntSecTransId"/>
	<xsl:template name="posPlDiscountedAmount_EntSecTransId"/>
	<xsl:template name="movementNature_EntSecTransId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_EntSecTransId">
		<quote>
			<xsl:value-of select="../ns2:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_EntSecTransId"/>
	<xsl:template name="posPlLtGrossAmount_EntSecTransId"/>
	<xsl:template name="accrAmount_EntSecTransId">
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_EntSecTransId"/>
	<xsl:template name="impact_EntSecTransId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!-- END - Inserting new or updated or inserted EntSecTransId -->

	<!-- BEG - EntSecTransId Delete Record-->
	<xsl:template name="taxLotSourceCode_DeleteEntSecTransId">
		<taxLotSourceCode>
			<xsl:value-of select="../ns1:TaxLotID"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_DeleteEntSecTransId">
		<xsl:param name="EntSecTransId"/>
		<opSourceCode>
			<xsl:value-of select="substring-before($EntSecTransId,'$')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_DeleteEntSecTransId">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_DeleteEntSecTransId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_DeleteEntSecTransId">
		<xsl:param name="EntNominal"/>
		<quantity>
			<xsl:value-of select="substring-before($EntNominal,'$')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_DeleteEntSecTransId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_DeleteEntSecTransId">
		<xsl:param name="EntCost"/>
		<posGrossAmount>
			<xsl:value-of select="substring-before($EntCost,'$')"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_DeleteEntSecTransId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posFeesTaxesAmount_DeleteEntSecTransId">
		<xsl:param name="EntExpenses"/>
		<posFeesTaxesAmount>
			<xsl:value-of select="substring-before($EntExpenses,'$')"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_DeleteEntSecTransId">
		<inputNature>
			<xsl:value-of select="'2'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_DeleteEntSecTransId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_DeleteEntSecTransId">
		<posReducedAmount>
			<xsl:value-of select="../ns1:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_DeleteEntSecTransId">
		<posIndexedAmount>
			<xsl:value-of select="../ns1:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="movementNature_DeleteEntSecTransId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_DeleteEntSecTransId">
		<quote>
			<xsl:value-of select="../ns1:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="accrAmount_DeleteEntSecTransId">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="impact_DeleteEntSecTransId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<xsl:template name="posPlDiscountedAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlIndexedAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlLtGrossAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlLtNetAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlNonDiscAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlStGrossAmount_DeleteEntSecTransId"/>
	<xsl:template name="posPlStNetAmount_DeleteEntSecTransId"/>
	<xsl:template name="price_DeleteEntSecTransId"/>
	<!-- END - EntSecTransId Delete Record-->

	<!-- BEG - Sending updated Old EntSecTransId after the Backdate or Delete Operation-->
	<xsl:template name="taxLotSourceCode_OldEntSecTransId">
		<taxLotSourceCode>
			<xsl:value-of select="../ns1:TaxLotID"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_OldEntSecTransId">
		<xsl:param name="EntSecTransId"/>
		<opSourceCode>
			<xsl:value-of select="substring-before($EntSecTransId,'$')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_OldEntSecTransId">
		<portfolio>
			<xsl:value-of select="../ns1:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_OldEntSecTransId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns1:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_OldEntSecTransId">
		<xsl:param name="EntNominal"/>
		<quantity>
			<xsl:value-of select="substring-before($EntNominal,'$')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_OldEntSecTransId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_OldEntSecTransId">
		<xsl:param name="EntCost"/>
		<posGrossAmount>
			<xsl:value-of select="substring-before($EntCost,'$')"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_OldEntSecTransId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns1:Expenses) or ../ns1:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns1:TrdValue) or ../ns1:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns1:TrdValue &lt; 0">
					<xsl:value-of select="../ns1:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns1:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_OldEntSecTransId"/>
	<xsl:template name="posPlLtNetAmount_OldEntSecTransId"/>
	<xsl:template name="posFeesTaxesAmount_OldEntSecTransId">
		<xsl:param name="EntExpenses"/>
		<posFeesTaxesAmount>
			<xsl:value-of select="substring-before($EntExpenses,'$')"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_OldEntSecTransId">
		<inputNature>
			<xsl:value-of select="'5'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_OldEntSecTransId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns1:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_OldEntSecTransId">
		<posReducedAmount>
			<xsl:value-of select="../ns1:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_OldEntSecTransId">
		<posIndexedAmount>
			<xsl:value-of select="../ns1:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_OldEntSecTransId"/>
	<xsl:template name="posPlIndexedAmount_OldEntSecTransId"/>
	<xsl:template name="posPlDiscountedAmount_OldEntSecTransId"/>
	<xsl:template name="movementNature_OldEntSecTransId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_OldEntSecTransId">
		<quote>
			<xsl:value-of select="../ns1:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_OldEntSecTransId"/>
	<xsl:template name="posPlLtGrossAmount_OldEntSecTransId"/>
	<xsl:template name="accrAmount_OldEntSecTransId">
		<accrAmount>
			<xsl:value-of select="../ns1:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_OldEntSecTransId"/>
	<xsl:template name="impact_OldEntSecTransId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!-- END - Sending updated Old EntSecTransId after the Backdate or Delete Operation-->

	<!-- BEG - Inserting Backdated EntSecTransId -->
	<xsl:template name="taxLotSourceCode_BackDatedEntSecTransId">
		<taxLotSourceCode>
			<xsl:value-of select="../ns2:TaxLotID"/>
		</taxLotSourceCode>
	</xsl:template>
	<xsl:template name="opSourceCode_BackDatedEntSecTransId">
		<xsl:param name="EntSecTransId"/>
		<opSourceCode>
			<xsl:value-of select="substring-before($EntSecTransId,'$')"/>
		</opSourceCode>
	</xsl:template>
	<xsl:template name="portfolio_BackDatedEntSecTransId">
		<portfolio>
			<xsl:value-of select="../ns2:Portfolio"/>
		</portfolio>
	</xsl:template>
	<xsl:template name="instrument_BackDatedEntSecTransId">
		<instrument>
			<xsl:value-of select="substring-after(substring-after(../../ns2:idCgTxnBase,'.'),'.')"/>
		</instrument>
	</xsl:template>
	<xsl:template name="quantity_BackDatedEntSecTransId">
		<xsl:param name="EntNominal"/>
		<quantity>
			<xsl:value-of select="substring-before($EntNominal,'$')"/>
		</quantity>
	</xsl:template>
	<xsl:template name="beginDate_BackDatedEntSecTransId">
		<beginDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:TradeDateTime"/>
			</xsl:call-template>
		</beginDate>
	</xsl:template>
	<xsl:template name="posGrossAmount_BackDatedEntSecTransId">
		<xsl:param name="EntCost"/>
		<posGrossAmount>
			<xsl:value-of select="substring-before($EntCost,'$')"/>
		</posGrossAmount>
	</xsl:template>
	<xsl:template name="posNetAmount_BackDatedEntSecTransId">
		<xsl:variable name="Expenses">
			<xsl:choose>
				<xsl:when test="not(../ns2:Expenses) or ../ns2:Expenses = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:Expenses"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="TrdValue">
			<xsl:choose>
				<xsl:when test="not(../ns2:TrdValue) or ../ns2:TrdValue = ''">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="../ns2:TrdValue &lt; 0">
					<xsl:value-of select="../ns2:TrdValue * -1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../ns2:TrdValue"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<posNetAmount>
			<xsl:value-of select="$TrdValue + $Expenses"/>
		</posNetAmount>
	</xsl:template>
	<xsl:template name="posPlStNetAmount_BackDatedEntSecTransId"/>
	<xsl:template name="posPlLtNetAmount_BackDatedEntSecTransId"/>
	<xsl:template name="posFeesTaxesAmount_BackDatedEntSecTransId">
		<xsl:param name="EntExpenses"/>
		<posFeesTaxesAmount>
			<xsl:value-of select="substring-before($EntExpenses,'$')"/>
		</posFeesTaxesAmount>
	</xsl:template>
	<xsl:template name="inputNature_BackDatedEntSecTransId">
		<inputNature>
			<xsl:value-of select="'3'"/>
		</inputNature>
	</xsl:template>
	<xsl:template name="taxEffectiveDate_BackDatedEntSecTransId">
		<taxEffectiveDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="../ns2:EffectiveDate"/>
			</xsl:call-template>
		</taxEffectiveDate>
	</xsl:template>
	<xsl:template name="posReducedAmount_BackDatedEntSecTransId">
		<posReducedAmount>
			<xsl:value-of select="../ns2:CgReducedCost"/>
		</posReducedAmount>
	</xsl:template>
	<xsl:template name="posIndexedAmount_BackDatedEntSecTransId">
		<posIndexedAmount>
			<xsl:value-of select="../ns2:cgIndexedCost"/>
		</posIndexedAmount>
	</xsl:template>
	<xsl:template name="posPlNonDiscAmount_BackDatedEntSecTransId"/>
	<xsl:template name="posPlIndexedAmount_BackDatedEntSecTransId"/>
	<xsl:template name="posPlDiscountedAmount_BackDatedEntSecTransId"/>
	<xsl:template name="movementNature_BackDatedEntSecTransId">
		<movementNature>
			<xsl:value-of select="'1'"/>
		</movementNature>
	</xsl:template>
	<xsl:template name="quote_BackDatedEntSecTransId">
		<quote>
			<xsl:value-of select="../ns2:CostPerUnit"/>
		</quote>
	</xsl:template>
	<xsl:template name="posPlStGrossAmount_BackDatedEntSecTransId"/>
	<xsl:template name="posPlLtGrossAmount_BackDatedEntSecTransId"/>
	<xsl:template name="accrAmount_BackDatedEntSecTransId">
		<accrAmount>
			<xsl:value-of select="../ns2:AccruedInt"/>
		</accrAmount>
	</xsl:template>
	<xsl:template name="price_BackDatedEntSecTransId"/>
	<xsl:template name="impact_BackDatedEntSecTransId">
		<impact>
			<xsl:choose>
				<xsl:when test="../../../c:eventCommon/ns0:application = 'CG.WASH.SALE.DETS'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</impact>
	</xsl:template>
	<!-- END - Inserting Backdated EntSecTransId -->
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