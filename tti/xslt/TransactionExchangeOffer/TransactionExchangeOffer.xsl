<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/GenericCOA" xmlns:b="http://www.temenos.com/T24/event/TTI/TransactionEntitlement" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTransactionEntitlement" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!--<xsl:import href="../GlobalLibrary/EntitlementFeesAndTaxes-Custo.xsl"/>-->
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiTransactionEntitlement">
		<xsl:apply-templates select="c:CurrentEvent/b:TransactionEntitlement"/>
	</xsl:template>
	<xsl:template match="batch:BatchTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTransactionEntitlement" name="BatchTransactionEntitlement">
			<xsl:apply-templates select="b:TransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiTransactionEntitlement">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiTransactionEntitlement" name="BatchMultiTransactionEntitlement">
			<xsl:apply-templates select="c:MultiTransactionEntitlement"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:TransactionEntitlement">
		<GenericCOA>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('CoaExchOffer',b:diaryId)"/>
			</xsl:attribute>
			<!-- Transaction status: opStatus -->
			<xsl:variable name="opStatus">
				<xsl:call-template name="operationStatus">
					<xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
					<xsl:with-param name="recordStatus" select="b:recordStatus"/>
				</xsl:call-template>
			</xsl:variable>
			<!-- Step1: Check if exchange is made against other securities. -->
			<!-- If 0, no new securities, sell the position -->
			<!-- If 1, exchange 1-1 -->
			<!-- If > , exchange 1-N -->
			<xsl:variable name="nbOptionDescGroupWithNewSecurity" select="count(child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup/b:newSecurity != ../b:securityNo])"/>
			<xsl:variable name="nbNewSecuritySubGroup" select="count(child::b:optionDescGroup[b:optionNom]/b:newSecuritySubGroup[b:newSecurity != ../../b:securityNo])"/>
			<!-- Step 2: Compute the proportion of original cost price to distribute among optionDescGroup with securities -->
			<!-- Cost price for an optionDescGroup = (optionNom of the optionDescGroup with securities) / (sum of optionNom of the optionDescGroup(s) with securities) -->
			<xsl:variable name="sumOptionNomOfGroupsWithSecu" select="format-number(sum(child::b:optionDescGroup[b:optionNom][b:newSecuritySubGroup]/b:optionNom),$decimalformat,'nan2zero')"/>
			<!-- Step3: sum of entitlementAmt -->
			<xsl:variable name="sumEntitlementAmt" select="format-number(sum(child::b:optionDescGroup[b:optionNom]/b:entitlementAmt),$decimalformat,'nan2zero')"/>
			<!-- Perform the several cases: sell, 1-1, 1-N -->
			<xsl:choose>
				<!-- Sell the position when no new security -->
				<xsl:when test="$sumEntitlementAmt != 0 and $nbNewSecuritySubGroup = 0">
					<xsl:call-template name="sellPosition">
						<xsl:with-param name="opStatus" select="$opStatus"/>
						<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
					</xsl:call-template>
				</xsl:when>
				<!-- 1-1 with cash or 1-N, cash in separate transaction -->
				<xsl:when test="$sumEntitlementAmt != 0 or $nbNewSecuritySubGroup &gt; 1">
					<!-- cash and FT are set on the cash transaction -->
					<xsl:if test="$sumEntitlementAmt != 0">
						<xsl:call-template name="cashPartOfExchange">
							<xsl:with-param name="opStatus" select="$opStatus"/>
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
						</xsl:call-template>
					</xsl:if>
					<!-- For 1-N exchange: compute remaining quantity for last optionDescGroup to avoid rounding pb -->
					<!-- 1. Sum of eventNominal * (optionNom / (sum of optionNom)) on all secu groups but last-->
					<xsl:variable name="qtyOptionDescGroupAllButLast">
						<xsl:call-template name="addQtyOptionDescGroupAllButLast">
							<xsl:with-param name="nodes" select="b:optionDescGroup[b:optionNom][b:newSecuritySubGroup][position() &lt; last()]"/>
							<xsl:with-param name="totOptNom" select="$sumOptionNomOfGroupsWithSecu"/>
							<xsl:with-param name="eventN" select="b:eventNominal"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="qtyLastOptionDescGroupWithSecu">
						<xsl:value-of select="format-number(b:eventNominal - $qtyOptionDescGroupAllButLast,'#.########','nan2zero')"/>
					</xsl:variable>
					<!-- 2. Get indexes of last optionDescGroup -->
					<xsl:variable name="idxLastOptionDescGroupWithSecu" select="b:optionDescGroup[b:newSecuritySubGroup][position() = last()]/@index"/>
					<xsl:apply-templates mode="adj_generation" select="b:optionDescGroup">
						<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						<xsl:with-param name="sumOptionNom" select="$sumOptionNomOfGroupsWithSecu"/>
						<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
						<xsl:with-param name="opStatus" select="$opStatus"/>
						<xsl:with-param name="idxLastOptionDescGroupWithSecu" select="$idxLastOptionDescGroupWithSecu"/>
						<xsl:with-param name="qtyLastOptionDescGroupWithSecu" select="$qtyLastOptionDescGroupWithSecu"/>
					</xsl:apply-templates>
				</xsl:when>
				<!-- 1-1 no cash -->
				<xsl:otherwise>
					<xsl:apply-templates mode="adj_generation" select="b:optionDescGroup">
						<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						<xsl:with-param name="sumOptionNom" select="$sumOptionNomOfGroupsWithSecu"/>
						<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
						<xsl:with-param name="opStatus" select="$opStatus"/>
						<xsl:with-param name="idxLastOptionDescGroupWithSecu" select="'0'"/>
						<xsl:with-param name="qtyLastOptionDescGroupWithSecu" select="'0'"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
			<!-- End of if exchange offer -->
		</GenericCOA>
	</xsl:template>
	<!-- Template to compute the quantity of all optionDescGroup with security but the last one -->
	<xsl:template name="addQtyOptionDescGroupAllButLast">
		<xsl:param name="nodes"/>
		<xsl:param name="totOptNom"/>
		<xsl:param name="eventN"/>
		<xsl:param name="sumProp" select="0"/>
		<!-- default value if no value for this param -->
		<xsl:variable name="current" select="$nodes[1]"/>
		<xsl:if test="$current">
			<xsl:call-template name="addQtyOptionDescGroupAllButLast">
				<xsl:with-param name="nodes" select="$nodes[position() &gt; 1]"/>
				<xsl:with-param name="totOptNom" select="$totOptNom"/>
				<xsl:with-param name="eventN" select="$eventN"/>
				<xsl:with-param name="sumProp" select="format-number($sumProp + $eventN * ( $current/b:optionNom div $totOptNom),$decimalformat,'nan2zero')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not($current)">
			<xsl:value-of select="$sumProp"/>
		</xsl:if>
	</xsl:template>
	<!-- ................................................................................... -->
	<xsl:template name="sellPosition">
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="sumEntitlementAmt"/>
		<DataGroup>
			<Sell>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionExchangeOffer.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1_Sell"/>
				<xsl:call-template name="account1CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account1NetAmount_Sell"/>
				<xsl:call-template name="account2_Sell"/>
				<xsl:call-template name="account2CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account2NetAmount_Sell"/>
				<xsl:call-template name="account3_Sell"/>
				<xsl:call-template name="account3CcyTradeCcyExchangeRate_Sell"/>
				<xsl:call-template name="account3NetAmount_Sell"/>
				<xsl:call-template name="accountingCode_Sell"/>
				<xsl:call-template name="accountingDate_Sell"/>
				<xsl:call-template name="accruedInterestAmount_Sell"/>
				<xsl:call-template name="accruedInterestCounter_Sell"/>
				<xsl:call-template name="cashPortfolio_Sell"/>
				<xsl:call-template name="coaReference_Sell"/>
				<xsl:call-template name="commonReference_Sell"/>
				<xsl:call-template name="communication_Sell"/>
				<xsl:call-template name="depositaryAccount_Sell"/>
				<xsl:call-template name="exDate_Sell"/>
				<xsl:call-template name="initiator_Sell"/>
				<xsl:call-template name="notepad_Sell"/>
				<xsl:call-template name="portfolio_Sell"/>
				<xsl:call-template name="portfolioManager_Sell"/>
				<xsl:call-template name="positionCriteria1_Sell"/>
				<xsl:call-template name="positionCriteria2_Sell"/>
				<xsl:call-template name="positionCriteria3_Sell"/>
				<xsl:call-template name="remark_Sell"/>
				<xsl:call-template name="reversalIndicator_Sell"/>
				<xsl:call-template name="reversedTransactionCode_Sell"/>
				<xsl:call-template name="security_Sell"/>
				<xsl:call-template name="securityCcyNetAmount_Sell"/>
				<xsl:call-template name="securityCcyPortfolioCcyExchangeRate_Sell"/>
				<xsl:call-template name="sourceSystemCode_Sell"/>
				<xsl:call-template name="splitPortfolio_Sell"/>
				<xsl:call-template name="status_Sell"/>
				<xsl:call-template name="subType_Sell"/>
				<xsl:call-template name="supplementaryAmount_Sell"/>
				<xsl:call-template name="tradeCcyGrossAmount_Sell"/>
				<xsl:call-template name="tradeCcyNetAmount_Sell"/>
				<xsl:call-template name="tradeCcyPortfolioCcyExchangeRate_Sell"/>
				<xsl:call-template name="tradeCurrency_Sell"/>
				<xsl:call-template name="tradePrice_Sell">
					<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
				</xsl:call-template>
				<xsl:call-template name="tradeQuantity_Sell"/>
				<xsl:call-template name="transactionCode_Sell"/>
				<xsl:call-template name="transactionDate_Sell"/>
				<xsl:call-template name="transactionFeesTaxesCounter_Sell"/>
				<xsl:call-template name="type_Sell"/>
				<xsl:call-template name="typeInstrument_Sell"/>
				<xsl:call-template name="valueDate_Sell"/>
				<xsl:call-template name="userDefinedField_Sell"/>
				<xsl:call-template name="mbFields_Sell"/>
			</Sell>
		</DataGroup>
	</xsl:template>
	<!-- End of sellPosition -->
	<xsl:template name="cashPartOfExchange">
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="sumEntitlementAmt"/>
		<DataGroup>
			<Adjustment>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TransactionExchangeOffer.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="account1"/>
				<xsl:call-template name="account1CcyoldSecCcyExchangeRate"/>
				<xsl:call-template name="account1NetAmount"/>
				<xsl:call-template name="account2"/>
				<xsl:call-template name="account2CcyoldSecCcyExchangeRate"/>
				<xsl:call-template name="account2NetAmount"/>
				<xsl:call-template name="account3"/>
				<xsl:call-template name="account3CcyoldSecCcyExchangeRate"/>
				<xsl:call-template name="account3NetAmount"/>
				<xsl:call-template name="accountingCode"/>
				<xsl:call-template name="accountingDate"/>
				<xsl:call-template name="accruedInterestAmount"/>
				<xsl:call-template name="accruedInterestCounter"/>
				<xsl:call-template name="adjustmentCounter"/>
				<xsl:call-template name="adjustmentNature"/>
				<xsl:call-template name="adjustmentPortfolio"/>
				<xsl:call-template name="cashPortfolio"/>
				<xsl:call-template name="coaReference"/>
				<xsl:call-template name="commonReference"/>
				<xsl:call-template name="communication"/>
				<xsl:call-template name="exDate"/>
				<xsl:call-template name="initiator"/>
				<xsl:call-template name="newQuantity"/>
				<xsl:call-template name="newSecurity"/>
				<xsl:call-template name="newSecurityCcyPositionCcyExchangeRate"/>
				<xsl:call-template name="newSecurityDepositaryAccount"/>
				<xsl:call-template name="newSecurityNetAmount"/>
				<xsl:call-template name="newSecurityPositionCriteria1"/>
				<xsl:call-template name="newSecurityPositionCriteria2"/>
				<xsl:call-template name="newSecurityPositionCriteria3"/>
				<xsl:call-template name="newSecurityPositionCurrency"/>
				<xsl:call-template name="notepad"/>
				<xsl:call-template name="oldCcyGrossAmount"/>
				<xsl:call-template name="oldCcyNetAmount"/>
				<xsl:call-template name="oldCcyPortfolioCcyExchangeRate"/>
				<xsl:call-template name="oldPrice"/>
				<xsl:call-template name="oldQuantity">
					<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
				</xsl:call-template>
				<xsl:call-template name="oldSecurity"/>
				<xsl:call-template name="oldSecurityDepositaryAccount"/>
				<xsl:call-template name="oldSecurityPositionCriteria1"/>
				<xsl:call-template name="oldSecurityPositionCriteria2"/>
				<xsl:call-template name="oldSecurityPositionCriteria3"/>
				<xsl:call-template name="oldSecurityPositionCurrency"/>
				<xsl:call-template name="portfolio"/>
				<xsl:call-template name="portfolioManager"/>
				<xsl:call-template name="remark"/>
				<xsl:call-template name="reversalIndicator"/>
				<xsl:call-template name="reversedTransactionCode"/>
				<xsl:call-template name="sourceSystemCode"/>
				<xsl:call-template name="splitPortfolio"/>
				<xsl:call-template name="status"/>
				<xsl:call-template name="subType"/>
				<xsl:call-template name="supplementaryAmount"/>
				<xsl:call-template name="transactionCode"/>
				<xsl:call-template name="transactionDate"/>
				<xsl:call-template name="transactionFeesTaxesCounter"/>
				<xsl:call-template name="type"/>
				<xsl:call-template name="typeInstrument"/>
				<xsl:call-template name="valueDate"/>
				<xsl:call-template name="userDefinedField"/>
				<xsl:call-template name="mbFields"/>
			</Adjustment>
		</DataGroup>
	</xsl:template>
	<!-- End of cashPartOfExchange -->
	<!-- Template optionDescGroup for all having an optionNom (option choosen) -->
	<xsl:template match="b:optionDescGroup[b:optionNom != 0]" mode="adj_generation">
		<xsl:param name="nbNewSecuritySubGroup"/>
		<!-- indicates there are new securities -->
		<xsl:param name="sumOptionNom"/>
		<!-- Sum of optionNom for groups with a security -->
		<xsl:param name="sumEntitlementAmt"/>
		<!-- Sum of entitlementAmt -->
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="idxLastOptionDescGroupWithSecu"/>
		<xsl:param name="qtyLastOptionDescGroupWithSecu"/>
		<xsl:param name="qtyNotLastOptionDescGroupWithSecu"/>
		<!-- Compute the cost price proportion for the several new securities in the optionDescGroup -->
		<!-- ratio fields are used if present, otherwise we will use the price proportion -->
		<!-- Count the number of securities of the group -->
		<xsl:variable name="nbNewSecuritySubGroupInOptionGroup" select="count(descendant::b:newSecuritySubGroup)"/>
		<!-- Count the total price of the group -->
		<xsl:variable name="totalSubGroupPrice" select="format-number(sum(descendant::b:newSecuritySubGroup/b:price),$decimalformat,'nan2zero')"/>
		<!-- based on RATIO -->
		<!-- Example: new secu 1 ratio = 2 new for 6 old; new secu 2 ratio = 3 new for 7 old -->
		<!--   this equals: new secu 1 ratio = 14 new for 42 old; new secu 2 ratio = 18 new for 42 old -->
		<!--   ratios in the optionDescGroup for the secu.:  new secu 1 ratio = 14 / 32 = 0.4375 ;  new secu 2 ratio = 18 / 32 = 0.5625 -->
		<!-- ex:ratio_1 = 2:6, ratio_2 = 3:7 then oldRatioPgcm = 42 -->
		<!-- 1. Compute the old ratio PGCM (multiple of old ratios) -->
		<xsl:variable name="oldRatioPgcm">
			<!-- loop on all ratios and multiply the old ratio -->
			<xsl:call-template name="computeOldRatioPgcm">
				<xsl:with-param name="nodes" select="b:newSecuritySubGroup"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- 2. Compute the sum of new ratio with PGCM -->
		<!-- ex:ratio_1 = 2:6, ratio_2 = 3:7 then sumNewRatioWithPgcm = 42 / 6 * 2 + 42 / 7 * 3 = 14 + 18 = 32 -->
		<xsl:variable name="sumNewRatioWithPgcm">
			<!-- loop on all ratios and multiply the old ratio -->
			<xsl:call-template name="computeSumNewRatioWithPgcm">
				<xsl:with-param name="nodes" select="b:newSecuritySubGroup"/>
				<xsl:with-param name="pgcm" select="$oldRatioPgcm"/>
			</xsl:call-template>
		</xsl:variable>
		<!-- Cost price repartition in the optionDescGroup will be: 42 / 6 * 2 / 32 = 0.4375 and 42 / 7 * 3 / 32 = 0.5625 -->
		<!-- 3. Compute the quantity for the last newSecuritysubGroup -->
		<!-- Qty optionDescGroup -->
		<xsl:variable name="qtyOptionDescGroup">
			<xsl:choose>
				<xsl:when test="@index = $idxLastOptionDescGroupWithSecu">
					<xsl:value-of select="$qtyLastOptionDescGroupWithSecu"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(../b:eventNominal * b:optionNom div $sumOptionNom,'#.########','nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="sumQtyRatioButLast">
			<xsl:call-template name="addQtyRatioButLastNewSecuritySubGroup">
				<xsl:with-param name="nodes" select="b:newSecuritySubGroup[position() &lt; last()]"/>
				<xsl:with-param name="oldRatioPgcm" select="$oldRatioPgcm"/>
				<xsl:with-param name="sumNewRatioWithPgcm" select="$sumNewRatioWithPgcm"/>
				<xsl:with-param name="qtyOptionDescGroup" select="$qtyOptionDescGroup"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="lastRatioQty">
			<xsl:choose>
				<xsl:when test="$nbNewSecuritySubGroup = 1">
					<xsl:value-of select="$qtyLastOptionDescGroupWithSecu"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number( $qtyOptionDescGroup - $sumQtyRatioButLast, '#.########','nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="lastPriceQty">
			<xsl:choose>
				<xsl:when test="$nbNewSecuritySubGroup = 1">
					<xsl:value-of select="$qtyLastOptionDescGroupWithSecu"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="sumQtyPriceButLast">
						<xsl:call-template name="addQtyPriceButLastNewSecuritySubGroup">
							<xsl:with-param name="nodes" select="b:newSecuritySubGroup[position() &lt; last()]"/>
							<xsl:with-param name="totalSubGroupPrice" select="$totalSubGroupPrice"/>
							<xsl:with-param name="qtyOptionDescGroup" select="$qtyOptionDescGroup"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="format-number( $qtyOptionDescGroup - $sumQtyPriceButLast, '#.########','nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Get index of last newSecuritySubGroup -->
		<xsl:variable name="idxLastNewSecuritySubGroup" select="b:newSecuritySubGroup[position() = last()]/@index"/>
		<xsl:apply-templates select="b:newSecuritySubGroup">
			<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
			<xsl:with-param name="nbNewSecuritySubGroupInOptionGroup" select="$nbNewSecuritySubGroupInOptionGroup"/>
			<xsl:with-param name="totalSubGroupPrice" select="$totalSubGroupPrice"/>
			<xsl:with-param name="totalOptionNom" select="$sumOptionNom"/>
			<!-- Sum of optionNom for groups with a security -->
			<xsl:with-param name="oldRatioPgcm" select="$oldRatioPgcm"/>
			<xsl:with-param name="sumNewRatioWithPgcm" select="$sumNewRatioWithPgcm"/>
			<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
			<xsl:with-param name="opStatus" select="$opStatus"/>
			<xsl:with-param name="idxLastOptionDescGroupWithSecu" select="$idxLastOptionDescGroupWithSecu"/>
			<xsl:with-param name="qtyLastOptionDescGroupWithSecu" select="$qtyLastOptionDescGroupWithSecu"/>
			<xsl:with-param name="idxLastNewSecuritySubGroup" select="$idxLastNewSecuritySubGroup"/>
			<xsl:with-param name="lastRatioQty" select="$lastRatioQty"/>
			<xsl:with-param name="lastPriceQty" select="$lastPriceQty"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Template to compute the multiplication of oldRatio of ratio fields -->
	<xsl:template name="computeOldRatioPgcm">
		<xsl:param name="nodes"/>
		<xsl:param name="pgcm" select="1"/>
		<!-- default value if no value for this param -->
		<xsl:variable name="current" select="$nodes[1]"/>
		<xsl:if test="$current">
			<xsl:call-template name="computeOldRatioPgcm">
				<xsl:with-param name="nodes" select="$nodes[position() &gt; 1]"/>
				<xsl:with-param name="pgcm" select="format-number($pgcm * substring-after($current/b:ratio,':'),$decimalformat,'nan2zero')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not($current)">
			<xsl:value-of select="$pgcm"/>
		</xsl:if>
	</xsl:template>
	<!-- Template to compute the multiplication of oldRatio of ratio fields -->
	<!-- ratio is qtyNew:qtyOld -->
	<xsl:template name="computeSumNewRatioWithPgcm">
		<xsl:param name="nodes"/>
		<xsl:param name="pgcm"/>
		<xsl:param name="sumNewRt" select="0"/>
		<!-- default value if no value for this param -->
		<xsl:variable name="current" select="$nodes[1]"/>
		<xsl:if test="$current">
			<xsl:call-template name="computeSumNewRatioWithPgcm">
				<xsl:with-param name="nodes" select="$nodes[position() &gt; 1]"/>
				<xsl:with-param name="pgcm" select="$pgcm"/>
				<xsl:with-param name="sumNewRt" select="format-number($sumNewRt + $pgcm  div substring-after($current/b:ratio,':') * substring-before($current/b:ratio,':'),$decimalformat,'nan2zero')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not($current)">
			<xsl:value-of select="$sumNewRt"/>
		</xsl:if>
	</xsl:template>
	<!-- Template to compute the remainings -->
	<xsl:template name="addQtyPriceButLastNewSecuritySubGroup">
		<xsl:param name="nodes"/>
		<xsl:param name="totalSubGroupPrice"/>
		<xsl:param name="qtyOptionDescGroup"/>
		<xsl:param name="sumProp" select="0"/>
		<!-- default value if no value for this param -->
		<xsl:variable name="current" select="$nodes[1]"/>
		<xsl:if test="$current">
			<xsl:call-template name="addQtyPriceButLastNewSecuritySubGroup">
				<xsl:with-param name="nodes" select="$nodes[position() &gt; 1]"/>
				<xsl:with-param name="totalSubGroupPrice" select="$totalSubGroupPrice"/>
				<xsl:with-param name="qtyOptionDescGroup" select="$qtyOptionDescGroup"/>
				<xsl:with-param name="sumProp" select="format-number($sumProp + $qtyOptionDescGroup * ( $current/b:price div $totalSubGroupPrice),$decimalformat,'nan2zero')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not($current)">
			<xsl:value-of select="$sumProp"/>
		</xsl:if>
	</xsl:template>
	<!-- Template to compute the remainings -->
	<xsl:template name="addQtyRatioButLastNewSecuritySubGroup">
		<xsl:param name="nodes"/>
		<xsl:param name="oldRatioPgcm"/>
		<xsl:param name="sumNewRatioWithPgcm"/>
		<xsl:param name="qtyOptionDescGroup"/>
		<xsl:param name="sumProp" select="0"/>
		<!-- default value if no value for this param -->
		<xsl:variable name="current" select="$nodes[1]"/>
		<xsl:if test="$current">
			<xsl:call-template name="addQtyRatioButLastNewSecuritySubGroup">
				<xsl:with-param name="nodes" select="$nodes[position() &gt; 1]"/>
				<xsl:with-param name="oldRatioPgcm" select="$oldRatioPgcm"/>
				<xsl:with-param name="sumNewRatioWithPgcm" select="$sumNewRatioWithPgcm"/>
				<xsl:with-param name="qtyOptionDescGroup" select="$qtyOptionDescGroup"/>
				<xsl:with-param name="sumProp" select="format-number($sumProp + $qtyOptionDescGroup * ( $oldRatioPgcm div substring-after($current/b:ratio,':') * substring-before($current/b:ratio,':') div $sumNewRatioWithPgcm ),$decimalformat,'nan2zero')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not($current)">
			<xsl:value-of select="$sumProp"/>
		</xsl:if>
	</xsl:template>
	<!-- End of: addQtyRatioButLastNewSecuritySubGroup template -->
	<!-- Template for newSecuritySubGroup -->
	<xsl:template match="b:newSecuritySubGroup">
		<xsl:param name="nbNewSecuritySubGroup"/>
		<!-- nb of newSecuritySubGroup in the current optionDescGroup -->
		<xsl:param name="nbNewSecuritySubGroupInOptionGroup"/>
		<xsl:param name="totalSubGroupPrice"/>
		<!-- sum of the prices of the newSecuritySubGroup -->
		<xsl:param name="totalOptionNom"/>
		<!-- Sum of optionNom for groups with a security -->
		<xsl:param name="oldRatioPgcm"/>
		<xsl:param name="sumNewRatioWithPgcm"/>
		<xsl:param name="sumEntitlementAmt"/>
		<!-- Sum of entitlementAmt -->
		<xsl:param name="opStatus"/>
		<xsl:param name="idxLastOptionDescGroupWithSecu"/>
		<xsl:param name="qtyLastOptionDescGroupWithSecu"/>
		<xsl:param name="idxLastNewSecuritySubGroup"/>
		<xsl:param name="lastRatioQty"/>
		<xsl:param name="lastPriceQty"/>
		<!-- Quantity to deal in the ../optionDescGroup -->
		<xsl:variable name="optionDescGroupQtyToDeal">
			<xsl:choose>
				<xsl:when test="../@index = $idxLastOptionDescGroupWithSecu">
					<xsl:value-of select="$qtyLastOptionDescGroupWithSecu"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(../../b:eventNominal *../b:optionNom div $totalOptionNom,'#.########','nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- COMPUTE THE PROPORTION OF COST PRICE TO DISTRIBUTE IN THIS GROUP -->
		<!-- Compute optionDescGroup proportion against total of optionNom of optionDescGroup with securities -->
		<xsl:variable name="ratioProportion">
			<xsl:value-of select="format-number($oldRatioPgcm div substring-after(b:ratio,':') * substring-before(b:ratio,':') div $sumNewRatioWithPgcm,$decimalformat,'nan2zero')"/>
		</xsl:variable>
		<!-- CREATE THE TRANSACTION -->
		<!-- Performing an Adjustment PL if oldSecu != newSecu or (oldSecu = newSecu and sum Qty != 0)-->
		<xsl:variable name="sumQtyOldNewForOriginalSecu" select="sum(../../b:secNoGroup[b:secNo = ../b:securityNo]/b:secNominal) "/>
		<xsl:if test="b:newSecurity != ../../b:securityNo   or  (b:newSecurity = ../../b:securityNo and $sumQtyOldNewForOriginalSecu != 0)">
			<xsl:if test="../b:tapRefId = '' or not(../b:tapRefId)">
				<DataGroup>
					<Adjustment>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionExchangeOffer.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_Adj"/>
						<xsl:call-template name="account1CcyoldSecCcyExchangeRate_Adj">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						</xsl:call-template>
						<xsl:call-template name="account1NetAmount_Adj">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						</xsl:call-template>
						<xsl:call-template name="account2_Adj"/>
						<xsl:call-template name="account2CcyoldSecCcyExchangeRate_Adj"/>
						<xsl:call-template name="account2NetAmount_Adj"/>
						<xsl:call-template name="account3_Adj"/>
						<xsl:call-template name="account3CcyoldSecCcyExchangeRate_Adj"/>
						<xsl:call-template name="account3NetAmount_Adj"/>
						<xsl:call-template name="accountingCode_Adj"/>
						<xsl:call-template name="accountingDate_Adj"/>
						<xsl:call-template name="accruedInterestAmount_Adj"/>
						<xsl:call-template name="accruedInterestCounter_Adj"/>
						<xsl:call-template name="adjustmentCounter_Adj"/>
						<xsl:call-template name="adjustmentNature_Adj"/>
						<xsl:call-template name="adjustmentPortfolio_Adj"/>
						<xsl:call-template name="cashPortfolio_Adj"/>
						<xsl:call-template name="coaReference_Adj"/>
						<xsl:call-template name="commonReference_Adj"/>
						<xsl:call-template name="communication_Adj"/>
						<xsl:call-template name="exDate_Adj"/>
						<xsl:call-template name="initiator_Adj"/>
						<xsl:call-template name="newQuantity_Adj"/>
						<xsl:call-template name="newSecurity_Adj"/>
						<xsl:call-template name="newSecurityCcyPositionCcyExchangeRate_Adj"/>
						<xsl:call-template name="newSecurityDepositaryAccount_Adj"/>
						<xsl:call-template name="newSecurityNetAmount_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria1_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria2_Adj"/>
						<xsl:call-template name="newSecurityPositionCriteria3_Adj"/>
						<xsl:call-template name="newSecurityPositionCurrency_Adj"/>
						<xsl:call-template name="notepad_Adj"/>
						<xsl:call-template name="oldCcyGrossAmount_Adj"/>
						<xsl:call-template name="oldCcyNetAmount_Adj"/>
						<xsl:call-template name="oldCcyPortfolioCcyExchangeRate_Adj"/>
						<xsl:call-template name="oldPrice_Adj"/>
						<xsl:call-template name="oldQuantity_Adj">
							<xsl:with-param name="nbNewSecuritySubGroupInOptionGroup" select="$nbNewSecuritySubGroupInOptionGroup"/>
							<xsl:with-param name="optionDescGroupQtyToDeal" select="$optionDescGroupQtyToDeal"/>
							<xsl:with-param name="lastRatioQty" select="$lastRatioQty"/>
							<xsl:with-param name="ratioProportion" select="$ratioProportion"/>
							<xsl:with-param name="lastPriceQty" select="$lastPriceQty"/>
							<xsl:with-param name="totalSubGroupPrice" select="$totalSubGroupPrice"/>
						</xsl:call-template>
						<xsl:call-template name="oldSecurity_Adj"/>
						<xsl:call-template name="oldSecurityDepositaryAccount_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria1_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria2_Adj"/>
						<xsl:call-template name="oldSecurityPositionCriteria3_Adj"/>
						<xsl:call-template name="oldSecurityPositionCurrency_Adj"/>
						<xsl:call-template name="portfolio_Adj"/>
						<xsl:call-template name="portfolioManager_Adj"/>
						<xsl:call-template name="remark_Adj"/>
						<xsl:call-template name="reversalIndicator_Adj"/>
						<xsl:call-template name="reversedTransactionCode_Adj"/>
						<xsl:call-template name="sourceSystemCode_Adj"/>
						<xsl:call-template name="splitPortfolio_Adj"/>
						<xsl:call-template name="status_Adj"/>
						<xsl:call-template name="subType_Adj"/>
						<xsl:call-template name="supplementaryAmount_Adj"/>
						<xsl:call-template name="transactionCode_Adj"/>
						<xsl:call-template name="transactionDate_Adj"/>
						<xsl:call-template name="transactionFeesTaxesCounter_Adj">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
							<xsl:with-param name="ratioProportion" select="$ratioProportion"/>
						</xsl:call-template>
						<xsl:call-template name="type_Adj"/>
						<xsl:call-template name="typeInstrument_Adj"/>
						<xsl:call-template name="valueDate_Adj"/>
						<xsl:call-template name="userDefinedField_Adj"/>
						<xsl:call-template name="mbFields_Adj"/>
					</Adjustment>
				</DataGroup>
			</xsl:if>
			<!-- end of: if ../../securityNo != newSecurity -->
			<xsl:if test="../b:tapRefId != '' and ../b:tapRefId">
				<DataGroup>
					<Adjustment>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TransactionExchangeOffer.xsl+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../b:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="account1_Status"/>
						<xsl:call-template name="account1CcyoldSecCcyExchangeRate_Status">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						</xsl:call-template>
						<xsl:call-template name="account1NetAmount_Status">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						</xsl:call-template>
						<xsl:call-template name="account2_Status"/>
						<xsl:call-template name="account2CcyoldSecCcyExchangeRate_Status"/>
						<xsl:call-template name="account2NetAmount_Status"/>
						<xsl:call-template name="account3_Status"/>
						<xsl:call-template name="account3CcyoldSecCcyExchangeRate_Status"/>
						<xsl:call-template name="account3NetAmount_Status"/>
						<xsl:call-template name="accountingCode_Status"/>
						<xsl:call-template name="accountingDate_Status"/>
						<xsl:call-template name="accruedInterestAmount_Status"/>
						<xsl:call-template name="accruedInterestCounter_Status"/>
						<xsl:call-template name="adjustmentCounter_Status"/>
						<xsl:call-template name="adjustmentNature_Status"/>
						<xsl:call-template name="adjustmentPortfolio_Status"/>
						<xsl:call-template name="cashPortfolio_Status"/>
						<xsl:call-template name="coaReference_Status"/>
						<xsl:call-template name="commonReference_Status"/>
						<xsl:call-template name="communication_Status"/>
						<xsl:call-template name="initiator_Status"/>
						<xsl:call-template name="newQuantity_Status"/>
						<xsl:call-template name="newSecurity_Status"/>
						<xsl:call-template name="newSecurityCcyPositionCcyExchangeRate_Status"/>
						<xsl:call-template name="newSecurityDepositaryAccount_Status"/>
						<xsl:call-template name="newSecurityNetAmount_Status"/>
						<xsl:call-template name="newSecurityPositionCriteria1_Status"/>
						<xsl:call-template name="newSecurityPositionCriteria2_Status"/>
						<xsl:call-template name="newSecurityPositionCriteria3_Status"/>
						<xsl:call-template name="newSecurityPositionCurrency_Status"/>
						<xsl:call-template name="notepad_Status"/>
						<xsl:call-template name="oldCcyGrossAmount_Status"/>
						<xsl:call-template name="oldCcyNetAmount_Status"/>
						<xsl:call-template name="oldCcyPortfolioCcyExchangeRate_Status"/>
						<xsl:call-template name="oldPrice_Status"/>
						<xsl:call-template name="oldQuantity_Status">
							<xsl:with-param name="nbNewSecuritySubGroupInOptionGroup" select="$nbNewSecuritySubGroupInOptionGroup"/>
							<xsl:with-param name="optionDescGroupQtyToDeal" select="$optionDescGroupQtyToDeal"/>
							<xsl:with-param name="lastRatioQty" select="$lastRatioQty"/>
							<xsl:with-param name="ratioProportion" select="$ratioProportion"/>
							<xsl:with-param name="lastPriceQty" select="$lastPriceQty"/>
							<xsl:with-param name="totalSubGroupPrice" select="$totalSubGroupPrice"/>
						</xsl:call-template>
						<xsl:call-template name="oldSecurity_Status"/>
						<xsl:call-template name="oldSecurityDepositaryAccount_Status"/>
						<xsl:call-template name="oldSecurityPositionCriteria1_Status"/>
						<xsl:call-template name="oldSecurityPositionCriteria2_Status"/>
						<xsl:call-template name="oldSecurityPositionCriteria3_Status"/>
						<xsl:call-template name="oldSecurityPositionCurrency_Status"/>
						<xsl:call-template name="portfolio_Status"/>
						<xsl:call-template name="portfolioManager_Status"/>
						<xsl:call-template name="remark_Status"/>
						<xsl:call-template name="reversalIndicator_Status"/>
						<xsl:call-template name="reversedTransactionCode_Status"/>
						<xsl:call-template name="sourceSystemCode_Status"/>
						<xsl:call-template name="splitPortfolio_Status"/>
						<xsl:call-template name="status_Status"/>
						<xsl:call-template name="subType_Status"/>
						<xsl:call-template name="supplementaryAmount_Status"/>
						<xsl:call-template name="transactionCode_Status"/>
						<xsl:call-template name="transactionDate_Status"/>
						<xsl:call-template name="transactionFeesTaxesCounter_Status">
							<xsl:with-param name="sumEntitlementAmt" select="$sumEntitlementAmt"/>
							<xsl:with-param name="nbNewSecuritySubGroup" select="$nbNewSecuritySubGroup"/>
						</xsl:call-template>
						<xsl:call-template name="type_Status"/>
						<xsl:call-template name="typeInstrument_Status"/>
						<xsl:call-template name="valueDate_Status"/>
						<xsl:call-template name="userDefinedField_Status"/>
						<xsl:call-template name="mbFields_Status"/>
					</Adjustment>
				</DataGroup>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<!-- End of template for newSecuritySubGroup -->
	<!-- Default template for optionDescGroup, used when there is no optionNom. No action -->
	<xsl:template match="b:optionDescGroup" mode="adj_generation">
		<xsl:param name="nbOptionDescGroupWithNewSecurity"/>
		<!-- indicates there are new securities -->
		<xsl:param name="sumOptionNom"/>
		<!-- Sum of optionNom for groups with a security -->
		<xsl:param name="sumEntitlementAmt"/>
		<!-- Sum of entitlementAmt -->
		<xsl:param name="opStatus"/>
		<!-- transaction status -->
		<xsl:param name="idxLastOptionDescGroupWithSecu"/>
		<xsl:param name="qtyLastOptionDescGroupWithSecuWithSecu"/>
	</xsl:template>
	<!-- End of default for b:optionDescGroup  -->
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