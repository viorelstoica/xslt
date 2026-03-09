<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="c xsi ns1 ns2 ns0 batch" version="1.0" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTaxLot" xmlns="http://www.odcgroup.com/TransactionPMS"
                xmlns:ns1="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:c="http://www.temenos.com/T24/event/TTI/TaxLot"
                xsi:schemaLocation="http://www.temenos.com/T24/event/TTI/TaxLot TTI-TaxLot.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:ns2="http://www.temenos.com/T24/CapitalGainsService/CgTxnBaseDets"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="batch:BatchTaxLot">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchTaxLot" name="BatchTaxLot">
			<xsl:apply-templates select="c:TaxLot"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="c:TaxLot">
		<TransactionPMS mode="INSUPD">
			<xsl:attribute name="output">
				<xsl:value-of select="concat('TaxLot',c:newcgtxnbase/ns2:idCgTxnBase)"/>
			</xsl:attribute>

			<!--Sending New records when there is no previous Event-->

			<xsl:choose>
				<xsl:when test="c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID and not(c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID) and not(c:eventCommon/ns0:application='CG.WASH.SALE.DETS')">
					<xsl:if test="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
						<xsl:call-template name="Insert_NewTaxLotId"/>
						<!-- BEG - EntSecTransId -->
						<xsl:if test="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
							<xsl:call-template name="Insert_NewEntSecTransId"/>
						</xsl:if>
						<!-- END - EntSecTransId -->
					</xsl:if>
					<xsl:if test="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
						<xsl:call-template name="Insert_NewPurTaxLotId"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>

			<!--Sending Deleted records when there is no current Event-->

			<xsl:choose>
				<xsl:when test="c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID and not(c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID) and not(c:eventCommon/ns0:application='CG.WASH.SALE.DETS')">
					<xsl:if test="c:oldcgtxnbase/ns1:TaxLotList/ns1:TaxLotID">
						<xsl:call-template name="Delete_TaxLotId"/>
						<!-- BEG - EntSecTransId -->
						<xsl:if test="c:oldcgtxnbase/ns1:TaxLotList/ns1:EntSecTransId">
							<xsl:call-template name="Delete_EntSecTransId"/>
						</xsl:if>
						<!-- END - EntSecTransId -->
					</xsl:if>
					<xsl:if test="c:oldcgtxnbase/ns1:TaxLotList/ns1:PurTaxLotID">
						<xsl:call-template name="Delete_PurtaxLotId"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>

			<!--Preparing index variable by calculating last of index-->

			<xsl:variable name="NewIndex">
				<xsl:value-of select="c:newcgtxnbase/ns2:TaxLotList[position()=last()]/ns2:index"/>
			</xsl:variable>
			<xsl:variable name="OldIndex">
				<xsl:value-of select="c:oldcgtxnbase/ns1:TaxLotList[position()=last()]/ns1:index"/>
			</xsl:variable>

			<!--Comparing previous Current values to do update of TaxLot and PurTaxLot-->

			<xsl:choose>
				<xsl:when test="$OldIndex &gt; $NewIndex and not(c:eventCommon/ns0:application='CG.WASH.SALE.DETS')">
					<xsl:call-template name="Delete_TaxLotId"/>
					<!-- BEG - EntSecTransId -->
					<xsl:call-template name="Delete_EntSecTransId"/>
					<!-- END - EntSecTransId -->
					<xsl:call-template name="Delete_PurtaxLotId"/>
					<xsl:call-template name="Update_PurtaxLotId"/>
					<xsl:call-template name="Update_NewTaxLotId"/>
					<xsl:call-template name="Update_OldNewTaxLotId"/>
					<!-- BEG - EntSecTransId -->
					<xsl:call-template name="Update_NewEntSecTransId"/>
					<xsl:call-template name="Update_OldEntSecTransId"/>
					<!-- END - EntSecTransId -->
					<xsl:call-template name="Update_OldPurtaxLotId"/>
				</xsl:when>
			</xsl:choose>

			<!--Comparing previous Current values to do a Backdate and update of TaxLot and PurTaxLot-->

			<xsl:choose>
				<xsl:when test="$NewIndex &gt; $OldIndex">
					<xsl:variable name="index">
						<xsl:value-of select="$NewIndex - $OldIndex"/>
					</xsl:variable>
					<xsl:variable name="INDEX">
						<xsl:value-of select="$NewIndex - $index"/>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="c:newcgtxnbase/ns2:TaxLotList[ns2:index=$INDEX]/ns2:SecTransID = c:oldcgtxnbase/ns1:TaxLotList[ns1:index=$INDEX]/ns1:SecTransID and not(c:eventCommon/ns0:application='CG.WASH.SALE.DETS')">
							<xsl:call-template name="Insert_TaxLotId"/>
							<xsl:call-template name="Insert_PurTaxLotId"/>
							<!-- BEG - EntSecTransId -->
							<xsl:call-template name="Insert_EntSecTransId"/>
							<!-- END - EntSecTransId -->
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="not(c:eventCommon/ns0:application='CG.WASH.SALE.DETS')">
								<xsl:call-template name="BackDate_TaxLotId"/>
								<xsl:call-template name="BackDate_PurTaxLotId"/>
								<!-- BEG - EntSecTransId -->
								<xsl:call-template name="BackDate_EntSecTransId"/>
								<!-- END - EntSecTransId -->
								<xsl:call-template name="Update_NewPurTaxLotIdAfterBackDate"/>
								<xsl:call-template name="Update_NewTaxLotIdAfterBackDate"/>
								<!-- BEG - EntSecTransId -->
								<xsl:call-template name="Update_NewEntSecTransIdAfterBackDate"/>
								<!-- END - EntSecTransId -->
								<xsl:call-template name="Update_OldTaxLotIdAfterBackDate"/>
								<xsl:call-template name="Update_OldPurTaxLotIdAfterBackDate"/>
								<!-- BEG - EntSecTransId -->
								<xsl:call-template name="Update_OldEntSecTransIdAfterBackDate"/>
								<!-- END - EntSecTransId -->
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>

			<!--Sending WashSales records -->

			<xsl:choose>
				<xsl:when test="$NewIndex &gt; $OldIndex">
					<xsl:if test="c:eventCommon/ns0:application='CG.WASH.SALE.DETS'">
						<xsl:call-template name="Insert_WashTaxLotId"/>
						<xsl:call-template name="Update_WashTaxLotId"/>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
		</TransactionPMS>
	</xsl:template>

	<!--Template to insert new taxLotId when there is no old-->

	<xsl:template name="Insert_NewTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
			<DataGroup>
				<TaxLot>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="accrAmount_taxLotId"/>
					<xsl:call-template name="beginDate_taxLotId"/>
					<xsl:call-template name="impact_taxLotId"/>
					<xsl:call-template name="inputNature_taxLotId"/>
					<xsl:call-template name="instrument_taxLotId"/>
					<xsl:call-template name="movementNature_taxLotId"/>
					<xsl:call-template name="taxLotSourceCode_taxLotId"/>
					<xsl:call-template name="opSourceCode_taxLotId"/>
					<xsl:call-template name="portfolio_taxLotId"/>
					<xsl:call-template name="posFeesTaxesAmount_taxLotId"/>
					<xsl:call-template name="posGrossAmount_taxLotId"/>
					<xsl:call-template name="posIndexedAmount_taxLotId"/>
					<xsl:call-template name="posNetAmount_taxLotId"/>
					<xsl:call-template name="posPlDiscountedAmount_taxLotId"/>
					<xsl:call-template name="posPlIndexedAmount_taxLotId"/>
					<xsl:call-template name="posPlLtGrossAmount_taxLotId"/>
					<xsl:call-template name="posPlLtNetAmount_taxLotId"/>
					<xsl:call-template name="posPlNonDiscAmount_taxLotId"/>
					<xsl:call-template name="posPlStGrossAmount_taxLotId"/>
					<xsl:call-template name="posPlStNetAmount_taxLotId"/>
					<xsl:call-template name="posReducedAmount_taxLotId"/>
					<xsl:call-template name="price_taxLotId"/>
					<xsl:call-template name="quantity_taxLotId"/>
					<xsl:call-template name="quote_taxLotId"/>
					<xsl:call-template name="taxEffectiveDate_taxLotId"/>
				</TaxLot>
			</DataGroup>
		</xsl:for-each>
	</xsl:template>

	<!--Template to insert_newpurtaxLotId-->

	<xsl:template name="Insert_NewPurTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
			<DataGroup>
				<xsl:call-template name="RepeatableNewPurTaxLotId"/>
			</DataGroup>
		</xsl:for-each>
	</xsl:template>

	<!--Repeatable Template to get PurTaxLot-->

	<xsl:template name="RepeatableNewPurTaxLotId">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns2:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns2:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns2:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns2:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns2:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns2:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount"/>
			<xsl:call-template name="beginDate"/>
			<xsl:call-template name="impact"/>
			<xsl:call-template name="inputNature"/>
			<xsl:call-template name="instrument"/>
			<xsl:call-template name="movementNature"/>
			<xsl:call-template name="taxLotSourceCode">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode"/>
			<xsl:call-template name="portfolio"/>
			<xsl:call-template name="posFeesTaxesAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount"/>
			<xsl:call-template name="posNetAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount"/>
			<xsl:call-template name="price"/>
			<xsl:call-template name="quantity">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote"/>
			<xsl:call-template name="taxEffectiveDate"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewPurTaxLotId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--Template to Delete taxLotId-->

	<xsl:template name="Delete_TaxLotId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:TaxLotID">
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID = ../ns1:SecTransID)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_Delete"/>
						<xsl:call-template name="beginDate_Delete"/>
						<xsl:call-template name="impact_Delete"/>
						<xsl:call-template name="inputNature_Delete"/>
						<xsl:call-template name="instrument_Delete"/>
						<xsl:call-template name="movementNature_Delete"/>
						<xsl:call-template name="taxLotSourceCode_Delete"/>
						<xsl:call-template name="opSourceCode_Delete"/>
						<xsl:call-template name="portfolio_Delete"/>
						<xsl:call-template name="posFeesTaxesAmount_Delete"/>
						<xsl:call-template name="posGrossAmount_Delete"/>
						<xsl:call-template name="posIndexedAmount_Delete"/>
						<xsl:call-template name="posNetAmount_Delete"/>
						<xsl:call-template name="posPlDiscountedAmount_Delete"/>
						<xsl:call-template name="posPlIndexedAmount_Delete"/>
						<xsl:call-template name="posPlLtGrossAmount_Delete"/>
						<xsl:call-template name="posPlLtNetAmount_Delete"/>
						<xsl:call-template name="posPlNonDiscAmount_Delete"/>
						<xsl:call-template name="posPlStGrossAmount_Delete"/>
						<xsl:call-template name="posPlStNetAmount_Delete"/>
						<xsl:call-template name="posReducedAmount_Delete"/>
						<xsl:call-template name="price_Delete"/>
						<xsl:call-template name="quantity_Delete"/>
						<xsl:call-template name="quote_Delete"/>
						<xsl:call-template name="taxEffectiveDate_Delete"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Template to Delete_purtaxLotId-->

	<xsl:template name="Delete_PurtaxLotId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:PurTaxLotID">
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID = ../ns1:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableDeletePurTaxLotId"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Repeatable Template to get Delete PurTaxLot-->

	<xsl:template name="RepeatableDeletePurTaxLotId">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns1:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns1:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns1:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns1:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns1:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns1:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_DeletePurTaxLot"/>
			<xsl:call-template name="beginDate_DeletePurTaxLot"/>
			<xsl:call-template name="impact_DeletePurTaxLot"/>
			<xsl:call-template name="inputNature_DeletePurTaxLot"/>
			<xsl:call-template name="instrument_DeletePurTaxLot"/>
			<xsl:call-template name="movementNature_DeletePurTaxLot"/>
			<xsl:call-template name="taxLotSourceCode_DeletePurTaxLot">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode_DeletePurTaxLot"/>
			<xsl:call-template name="portfolio_DeletePurTaxLot"/>
			<xsl:call-template name="posFeesTaxesAmount_DeletePurTaxLot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_DeletePurTaxLot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_DeletePurTaxLot"/>
			<xsl:call-template name="posNetAmount_DeletePurTaxLot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount_DeletePurTaxLot">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount_DeletePurTaxLot">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount_DeletePurTaxLot">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount_DeletePurTaxLot">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount_DeletePurTaxLot">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount_DeletePurTaxLot">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount_DeletePurTaxLot">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount_DeletePurTaxLot"/>
			<xsl:call-template name="price_DeletePurTaxLot"/>
			<xsl:call-template name="quantity_DeletePurTaxLot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote_DeletePurTaxLot"/>
			<xsl:call-template name="taxEffectiveDate_DeletePurTaxLot"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableDeletePurTaxLotId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--Update TaxLot ID-->

	<xsl:template name="Update_NewTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
			<xsl:variable name="Index" select="../ns2:index"/>
			<xsl:if test="not(../../../c:oldcgtxnbase/ns1:TaxLotList[ns1:index=$Index]/ns1:SecTransID = ../ns2:SecTransID)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_taxLotId"/>
						<xsl:call-template name="beginDate_taxLotId"/>
						<xsl:call-template name="impact_taxLotId"/>
						<xsl:call-template name="inputNature_DeleteAfterUpdatetaxLotId"/>
						<xsl:call-template name="instrument_taxLotId"/>
						<xsl:call-template name="movementNature_taxLotId"/>
						<xsl:call-template name="taxLotSourceCode_taxLotId"/>
						<xsl:call-template name="opSourceCode_taxLotId"/>
						<xsl:call-template name="portfolio_taxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_taxLotId"/>
						<xsl:call-template name="posGrossAmount_taxLotId"/>
						<xsl:call-template name="posIndexedAmount_taxLotId"/>
						<xsl:call-template name="posNetAmount_taxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_taxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_taxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_taxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_taxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlStNetAmount_taxLotId"/>
						<xsl:call-template name="posReducedAmount_taxLotId"/>
						<xsl:call-template name="price_taxLotId"/>
						<xsl:call-template name="quantity_taxLotId"/>
						<xsl:call-template name="quote_taxLotId"/>
						<xsl:call-template name="taxEffectiveDate_taxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Update to purtaxLotId-->

	<xsl:template name="Update_PurtaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
			<xsl:variable name="Index" select="../ns2:index"/>
			<xsl:if test="not(../../../c:oldcgtxnbase/ns1:TaxLotList[ns1:index=$Index]/ns1:SecTransID = ../ns2:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewPurTaxLotIdAfterDelete"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Repeatable Template to get Updated PurTaxLot-->

	<xsl:template name="RepeatableNewPurTaxLotIdAfterDelete">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns2:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns2:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns2:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns2:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns2:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns2:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount"/>
			<xsl:call-template name="beginDate"/>
			<xsl:call-template name="impact"/>
			<xsl:call-template name="inputNature_DeleteAfterUpdatePurtaxLotId"/>
			<xsl:call-template name="instrument"/>
			<xsl:call-template name="movementNature"/>
			<xsl:call-template name="taxLotSourceCode">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode"/>
			<xsl:call-template name="portfolio"/>
			<xsl:call-template name="posFeesTaxesAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount"/>
			<xsl:call-template name="posNetAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount"/>
			<xsl:call-template name="price"/>
			<xsl:call-template name="quantity">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote"/>
			<xsl:call-template name="taxEffectiveDate"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewPurTaxLotIdAfterDelete">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--Template to insert new taxLotId-->

	<xsl:template name="Insert_TaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
			<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_taxLotId"/>
						<xsl:call-template name="beginDate_taxLotId"/>
						<xsl:call-template name="impact_taxLotId"/>
						<xsl:call-template name="inputNature_taxLotId"/>
						<xsl:call-template name="instrument_taxLotId"/>
						<xsl:call-template name="movementNature_taxLotId"/>
						<xsl:call-template name="taxLotSourceCode_taxLotId"/>
						<xsl:call-template name="opSourceCode_taxLotId"/>
						<xsl:call-template name="portfolio_taxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_taxLotId"/>
						<xsl:call-template name="posGrossAmount_taxLotId"/>
						<xsl:call-template name="posIndexedAmount_taxLotId"/>
						<xsl:call-template name="posNetAmount_taxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_taxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_taxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_taxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_taxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlStNetAmount_taxLotId"/>
						<xsl:call-template name="posReducedAmount_taxLotId"/>
						<xsl:call-template name="price_taxLotId"/>
						<xsl:call-template name="quantity_taxLotId"/>
						<xsl:call-template name="quote_taxLotId"/>
						<xsl:call-template name="taxEffectiveDate_taxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Insert to purtaxLotId-->

	<xsl:template name="Insert_PurTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
			<xsl:if test="not(../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID = ../ns2:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewPurTaxLotId"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- Template to insert backdated taxLotId-->

	<xsl:template name="BackDate_TaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
			<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_backdatedtaxLotId"/>
						<xsl:call-template name="beginDate_backdatedtaxLotId"/>
						<xsl:call-template name="impact_backdatedtaxLotId"/>
						<xsl:call-template name="inputNature_backdatedtaxLotId"/>
						<xsl:call-template name="instrument_backdatedtaxLotId"/>
						<xsl:call-template name="movementNature_backdatedtaxLotId"/>
						<xsl:call-template name="taxLotSourceCode_backdatedtaxLotId"/>
						<xsl:call-template name="opSourceCode_backdatedtaxLotId"/>
						<xsl:call-template name="portfolio_backdatedtaxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posGrossAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posIndexedAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posNetAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posPlStNetAmount_backdatedtaxLotId"/>
						<xsl:call-template name="posReducedAmount_backdatedtaxLotId"/>
						<xsl:call-template name="price_backdatedtaxLotId"/>
						<xsl:call-template name="quantity_backdatedtaxLotId"/>
						<xsl:call-template name="quote_backdatedtaxLotId"/>
						<xsl:call-template name="taxEffectiveDate_backdatedtaxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- Sending Update of TaxLot after BackDate -->

	<xsl:template name="Update_NewTaxLotIdAfterBackDate">
		<xsl:variable name="backIndex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="backindex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="nonzero">
			<xsl:choose>
				<xsl:when test="$backIndex!=''">
					<xsl:value-of select="$backIndex"/>
				</xsl:when>
				<xsl:when test="$backindex!=''">
					<xsl:value-of select="$backindex"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
			<xsl:if test="(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID) and (../ns2:index &gt;= $nonzero)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_taxLotId"/>
						<xsl:call-template name="beginDate_taxLotId"/>
						<xsl:call-template name="impact_taxLotId"/>
						<xsl:call-template name="inputNature_NewTaxLotIdAfterBackDate"/>
						<xsl:call-template name="instrument_taxLotId"/>
						<xsl:call-template name="movementNature_taxLotId"/>
						<xsl:call-template name="taxLotSourceCode_taxLotId"/>
						<xsl:call-template name="opSourceCode_taxLotId"/>
						<xsl:call-template name="portfolio_taxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_taxLotId"/>
						<xsl:call-template name="posGrossAmount_taxLotId"/>
						<xsl:call-template name="posIndexedAmount_taxLotId"/>
						<xsl:call-template name="posNetAmount_taxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_taxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_taxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_taxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_taxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_taxLotId"/>
						<xsl:call-template name="posPlStNetAmount_taxLotId"/>
						<xsl:call-template name="posReducedAmount_taxLotId"/>
						<xsl:call-template name="price_taxLotId"/>
						<xsl:call-template name="quantity_taxLotId"/>
						<xsl:call-template name="quote_taxLotId"/>
						<xsl:call-template name="taxEffectiveDate_taxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- Template to insert backdated purtaxLotId-->

	<xsl:template name="BackDate_PurTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
			<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableBackDatedNewPurTaxLotId"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Repeatable Template to get backdated PurTaxLot-->

	<xsl:template name="RepeatableBackDatedNewPurTaxLotId">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns2:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns2:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns2:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns2:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns2:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns2:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount"/>
			<xsl:call-template name="beginDate"/>
			<xsl:call-template name="impact"/>
			<xsl:call-template name="inputNature_Backdatedpurtaxlot"/>
			<xsl:call-template name="instrument"/>
			<xsl:call-template name="movementNature"/>
			<xsl:call-template name="taxLotSourceCode">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode"/>
			<xsl:call-template name="portfolio"/>
			<xsl:call-template name="posFeesTaxesAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount"/>
			<xsl:call-template name="posNetAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount"/>
			<xsl:call-template name="price"/>
			<xsl:call-template name="quantity">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote"/>
			<xsl:call-template name="taxEffectiveDate"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableBackDatedNewPurTaxLotId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- Template to insert backdated purtaxLotId-->

	<xsl:template name="Update_NewPurTaxLotIdAfterBackDate">
		<xsl:variable name="backIndex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="backindex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="nonzero">
			<xsl:choose>
				<xsl:when test="$backIndex!=''">
					<xsl:value-of select="$backIndex"/>
				</xsl:when>
				<xsl:when test="$backindex!=''">
					<xsl:value-of select="$backindex"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
			<xsl:if test="(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID) and (../ns2:index &gt;= $nonzero)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewPurTaxLotIdAfterBackDate"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Repeatable Template to send updated backdated purtaxLotId-->

	<xsl:template name="RepeatableNewPurTaxLotIdAfterBackDate">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns2:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns2:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns2:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns2:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns2:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns2:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount"/>
			<xsl:call-template name="beginDate"/>
			<xsl:call-template name="impact"/>
			<xsl:call-template name="inputNature_NewPurTaxLotIdAfterBackDate"/>
			<xsl:call-template name="instrument"/>
			<xsl:call-template name="movementNature"/>
			<xsl:call-template name="taxLotSourceCode">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode"/>
			<xsl:call-template name="portfolio"/>
			<xsl:call-template name="posFeesTaxesAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount"/>
			<xsl:call-template name="posNetAmount">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount"/>
			<xsl:call-template name="price"/>
			<xsl:call-template name="quantity">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote"/>
			<xsl:call-template name="taxEffectiveDate"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewPurTaxLotIdAfterBackDate">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--	Update Old TaxLot ID After Delete-->

	<xsl:template name="Update_OldNewTaxLotId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:TaxLotID">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_OldtaxLotId"/>
						<xsl:call-template name="beginDate_OldtaxLotId"/>
						<xsl:call-template name="impact_OldtaxLotId"/>
						<xsl:call-template name="inputNature_OldtaxLotId"/>
						<xsl:call-template name="instrument_OldtaxLotId"/>
						<xsl:call-template name="movementNature_OldtaxLotId"/>
						<xsl:call-template name="taxLotSourceCode_OldtaxLotId"/>
						<xsl:call-template name="opSourceCode_OldtaxLotId"/>
						<xsl:call-template name="portfolio_OldtaxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_OldtaxLotId"/>
						<xsl:call-template name="posGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posIndexedAmount_OldtaxLotId"/>
						<xsl:call-template name="posNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlStNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posReducedAmount_OldtaxLotId"/>
						<xsl:call-template name="price_OldtaxLotId"/>
						<xsl:call-template name="quantity_OldtaxLotId"/>
						<xsl:call-template name="quote_OldtaxLotId"/>
						<xsl:call-template name="taxEffectiveDate_OldtaxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Update to Old purtaxLotId After Delete-->

	<xsl:template name="Update_OldPurtaxLotId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:PurTaxLotID">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<xsl:call-template name="RepeatableOldPurTaxLotId"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--	Repeatable Template to get Old PurTaxLot-->

	<xsl:template name="RepeatableOldPurTaxLotId">
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>
		<xsl:param name="index" select="1"/>

		<xsl:param name="PurTaxLotID" select="concat(.,'$')"/>
		<xsl:param name="PurTxnNom" select="concat(../ns1:PurTxnNom,'$')"/>
		<xsl:param name="PurStCgPL" select="concat(../ns1:PurStCgPL,'$')"/>
		<xsl:param name="PurStCgStd" select="concat(../ns1:PurStCgStd,'$')"/>
		<xsl:param name="PurLtCgPl" select="concat(../ns1:PurLtCgPl,'$')"/>
		<xsl:param name="PurLtCgIndexed" select="concat(../ns1:PurLtCgIndexed,'$')"/>
		<xsl:param name="purLtCgDiscount" select="concat(../ns1:purLtCgDiscount,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_Oldpurtaxlot"/>
			<xsl:call-template name="beginDate_Oldpurtaxlot"/>
			<xsl:call-template name="impact_Oldpurtaxlot"/>
			<xsl:call-template name="inputNature_Oldpurtaxlot"/>
			<xsl:call-template name="instrument_Oldpurtaxlot"/>
			<xsl:call-template name="movementNature_Oldpurtaxlot"/>
			<xsl:call-template name="taxLotSourceCode_Oldpurtaxlot">
				<xsl:with-param name="PurTaxLotID" select="$PurTaxLotID"/>
			</xsl:call-template>
			<xsl:call-template name="opSourceCode_Oldpurtaxlot"/>
			<xsl:call-template name="portfolio_Oldpurtaxlot"/>
			<xsl:call-template name="posFeesTaxesAmount_Oldpurtaxlot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_Oldpurtaxlot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_Oldpurtaxlot"/>
			<xsl:call-template name="posNetAmount_Oldpurtaxlot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="posPlDiscountedAmount_Oldpurtaxlot">
				<xsl:with-param name="purLtCgDiscount" select="$purLtCgDiscount"/>
			</xsl:call-template>
			<xsl:call-template name="posPlIndexedAmount_Oldpurtaxlot">
				<xsl:with-param name="PurLtCgIndexed" select="$PurLtCgIndexed"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtGrossAmount_Oldpurtaxlot">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlLtNetAmount_Oldpurtaxlot">
				<xsl:with-param name="PurLtCgPl" select="$PurLtCgPl"/>
			</xsl:call-template>
			<xsl:call-template name="posPlNonDiscAmount_Oldpurtaxlot">
				<xsl:with-param name="purStCgStd" select="$PurStCgStd"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStGrossAmount_Oldpurtaxlot">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posPlStNetAmount_Oldpurtaxlot">
				<xsl:with-param name="PurStCgPL" select="$PurStCgPL"/>
			</xsl:call-template>
			<xsl:call-template name="posReducedAmount_Oldpurtaxlot"/>
			<xsl:call-template name="price_Oldpurtaxlot"/>
			<xsl:call-template name="quantity_Oldpurtaxlot">
				<xsl:with-param name="PurTxnNom" select="$PurTxnNom"/>
			</xsl:call-template>
			<xsl:call-template name="quote_Oldpurtaxlot"/>
			<xsl:call-template name="taxEffectiveDate_Oldpurtaxlot"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableOldPurTaxLotId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="PurTaxLotID" select="substring-after($PurTaxLotID,'$')"/>
				<xsl:with-param name="PurTxnNom" select="substring-after($PurTxnNom,'$')"/>
				<xsl:with-param name="PurStCgPL" select="substring-after($PurStCgPL,'$')"/>
				<xsl:with-param name="PurStCgStd" select="substring-after($PurStCgStd,'$')"/>
				<xsl:with-param name="PurLtCgPl" select="substring-after($PurLtCgPl,'$')"/>
				<xsl:with-param name="PurLtCgIndexed" select="substring-after($PurLtCgIndexed,'$')"/>
				<xsl:with-param name="purLtCgDiscount" select="substring-after($purLtCgDiscount,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!-- Sending Update of Old TaxLot after BackDate -->

	<xsl:template name="Update_OldTaxLotIdAfterBackDate">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:TaxLotID">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_OldtaxLotId"/>
						<xsl:call-template name="beginDate_OldtaxLotId"/>
						<xsl:call-template name="impact_OldtaxLotId"/>
						<xsl:call-template name="inputNature_OldtaxLotId"/>
						<xsl:call-template name="instrument_OldtaxLotId"/>
						<xsl:call-template name="movementNature_OldtaxLotId"/>
						<xsl:call-template name="taxLotSourceCode_OldtaxLotId"/>
						<xsl:call-template name="opSourceCode_OldtaxLotId"/>
						<xsl:call-template name="portfolio_OldtaxLotId"/>
						<xsl:call-template name="posFeesTaxesAmount_OldtaxLotId"/>
						<xsl:call-template name="posGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posIndexedAmount_OldtaxLotId"/>
						<xsl:call-template name="posNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlDiscountedAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlIndexedAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlLtGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlLtNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlNonDiscAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlStGrossAmount_OldtaxLotId"/>
						<xsl:call-template name="posPlStNetAmount_OldtaxLotId"/>
						<xsl:call-template name="posReducedAmount_OldtaxLotId"/>
						<xsl:call-template name="price_OldtaxLotId"/>
						<xsl:call-template name="quantity_OldtaxLotId"/>
						<xsl:call-template name="quote_OldtaxLotId"/>
						<xsl:call-template name="taxEffectiveDate_OldtaxLotId"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Update to Old purtaxLotId after backdate-->

	<xsl:template name="Update_OldPurTaxLotIdAfterBackDate">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:PurTaxLotID">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<xsl:call-template name="RepeatableOldPurTaxLotId"/>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Insert of WashSales taxLotId when triggred from CG.WASH.SALE.DETS-->

	<xsl:template name="Insert_WashTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
			<xsl:if test="../ns2:DisallowedTxn and not(. = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<DataGroup>
					<TaxLot>
						<xsl:attribute name="description">
							<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
						</xsl:attribute>
						<xsl:attribute name="sequenceNumber">
							<xsl:call-template name="calcSeqNum">
								<xsl:with-param name="creationTime">
									<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
						<xsl:call-template name="accrAmount_WashSales"/>
						<xsl:call-template name="beginDate_WashSales"/>
						<xsl:call-template name="impact_WashSales"/>
						<xsl:call-template name="inputNature_WashSales"/>
						<xsl:call-template name="instrument_WashSales"/>
						<xsl:call-template name="movementNature_WashSales"/>
						<xsl:call-template name="taxLotSourceCode_WashSales"/>
						<xsl:call-template name="opSourceCode_WashSales"/>
						<xsl:call-template name="portfolio_WashSales"/>
						<xsl:call-template name="posFeesTaxesAmount_WashSales"/>
						<xsl:call-template name="posGrossAmount_WashSales"/>
						<xsl:call-template name="posIndexedAmount_WashSales"/>
						<xsl:call-template name="posNetAmount_WashSales"/>
						<xsl:call-template name="posPlDiscountedAmount_WashSales"/>
						<xsl:call-template name="posPlIndexedAmount_WashSales"/>
						<xsl:call-template name="posPlLtGrossAmount_WashSales"/>
						<xsl:call-template name="posPlLtNetAmount_WashSales"/>
						<xsl:call-template name="posPlNonDiscAmount_WashSales"/>
						<xsl:call-template name="posPlStGrossAmount_WashSales"/>
						<xsl:call-template name="posPlStNetAmount_WashSales"/>
						<xsl:call-template name="posReducedAmount_WashSales"/>
						<xsl:call-template name="price_WashSales"/>
						<xsl:call-template name="quantity_WashSales"/>
						<xsl:call-template name="quote_WashSales"/>
						<xsl:call-template name="taxEffectiveDate_WashSales"/>
					</TaxLot>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--Update of WashSales taxLotId when triggred from CG.WASH.SALE.DETS-->

	<xsl:template name="Update_WashTaxLotId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
			<xsl:if test="../ns2:DisallowedTxn and not(. = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<xsl:variable name="SecTransId">
					<xsl:value-of select="substring-after(substring-before(.,'*'),'1.')"/>
				</xsl:variable>
				<xsl:variable name="ReplacementTransId">
					<xsl:value-of select="concat(substring-before(.,'.'),'.1')"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="contains(../ns2:DisallowedTxn,$ReplacementTransId)">
						<xsl:for-each select="../../../c:newcgtxnbase/ns2:TaxLotList[ns2:SecTransID = $SecTransId]">
							<xsl:call-template name="mappingUpdate_WashTaxLotId">
								<xsl:with-param name="isReplacementPartOfDisallowedTxn" select="'Y'"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="../../../c:newcgtxnbase/ns2:TaxLotList[ns2:SecTransID = $ReplacementTransId]">
							<xsl:call-template name="mappingUpdate_WashTaxLotId">
								<xsl:with-param name="isReplacementPartOfDisallowedTxn" select="'N'"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="mappingUpdate_WashTaxLotId">
		<xsl:param name="isReplacementPartOfDisallowedTxn"/>
		<DataGroup>
			<TaxLot>
				<xsl:attribute name="description">
					<xsl:value-of select="concat('TaxLot.xsl+', name(/*), '+', ../../c:eventCommon/ns0:eventId, '+', ../../c:eventCommon/ns0:creationTime)"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="../../c:eventCommon/ns0:creationTime"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<xsl:call-template name="accrAmount_UpdateWashSales"/>
				<xsl:call-template name="beginDate_UpdateWashSales"/>
				<xsl:call-template name="impact_UpdateWashSales"/>
				<xsl:call-template name="inputNature_UpdateWashSales"/>
				<xsl:call-template name="instrument_UpdateWashSales"/>
				<xsl:call-template name="movementNature_UpdateWashSales"/>
				<xsl:call-template name="taxLotSourceCode_UpdateWashSales">
					<xsl:with-param name="isReplacementPartOfDisallowedTxn" select="$isReplacementPartOfDisallowedTxn"/>
				</xsl:call-template>
				<xsl:call-template name="opSourceCode_UpdateWashSales"/>
				<xsl:call-template name="portfolio_UpdateWashSales"/>
				<xsl:call-template name="posFeesTaxesAmount_UpdateWashSales"/>
				<xsl:call-template name="posGrossAmount_UpdateWashSales"/>
				<xsl:call-template name="posIndexedAmount_UpdateWashSales"/>
				<xsl:call-template name="posNetAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlDiscountedAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlIndexedAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlLtGrossAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlLtNetAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlNonDiscAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlStGrossAmount_UpdateWashSales"/>
				<xsl:call-template name="posPlStNetAmount_UpdateWashSales"/>
				<xsl:call-template name="posReducedAmount_UpdateWashSales"/>
				<xsl:call-template name="price_UpdateWashSales"/>
				<xsl:call-template name="quantity_UpdateWashSales"/>
				<xsl:call-template name="quote_UpdateWashSales"/>
				<xsl:call-template name="taxEffectiveDate_UpdateWashSales"/>
			</TaxLot>
		</DataGroup>
	</xsl:template>

	<!-- BEG - Template to Insert_NewEntSecTransId when there is no old -->
	<xsl:template name="Insert_NewEntSecTransId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
			<DataGroup>
				<xsl:call-template name="RepeatableNewEntSecTransId">
					<xsl:with-param name="index" select="1"/>
				</xsl:call-template>
			</DataGroup>
		</xsl:for-each>
	</xsl:template>
	<!--Repeatable Template to get EntSecTransId(Also used for Insert_EntSecTransId) -->
	<xsl:template name="RepeatableNewEntSecTransId">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_EntSecTransId"/>
			<xsl:call-template name="beginDate_EntSecTransId"/>
			<xsl:call-template name="impact_EntSecTransId"/>
			<xsl:call-template name="inputNature_EntSecTransId"/>
			<xsl:call-template name="instrument_EntSecTransId"/>
			<xsl:call-template name="movementNature_EntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_EntSecTransId"/>
			<xsl:call-template name="opSourceCode_EntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_EntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_EntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_EntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_EntSecTransId"/>
			<xsl:call-template name="posReducedAmount_EntSecTransId"/>
			<xsl:call-template name="price_EntSecTransId"/>
			<xsl:call-template name="quantity_EntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_EntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_EntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewEntSecTransId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template to Insert_NewEntSecTransId when there is no old -->

	<!-- BEG - Template to Delete_EntSecTransId-->
	<xsl:template name="Delete_EntSecTransId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:EntSecTransId">
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID = ../ns1:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableDeleteEntSecTransId">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--Repeatable Template to get Delete EntSecTransId-->
	<xsl:template name="RepeatableDeleteEntSecTransId">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="beginDate_DeleteEntSecTransId"/>
			<xsl:call-template name="impact_DeleteEntSecTransId"/>
			<xsl:call-template name="inputNature_DeleteEntSecTransId"/>
			<xsl:call-template name="instrument_DeleteEntSecTransId"/>
			<xsl:call-template name="movementNature_DeleteEntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_DeleteEntSecTransId"/>
			<xsl:call-template name="opSourceCode_DeleteEntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_DeleteEntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_DeleteEntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_DeleteEntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posNetAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="posReducedAmount_DeleteEntSecTransId"/>
			<xsl:call-template name="price_DeleteEntSecTransId"/>
			<xsl:call-template name="quantity_DeleteEntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_DeleteEntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_DeleteEntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableDeleteEntSecTransId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template to Delete_EntSecTransId-->

	<!-- BEG - Template to Update_NewEntSecTransId -->
	<xsl:template name="Update_NewEntSecTransId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
			<xsl:variable name="Index" select="../ns2:index"/>
			<xsl:if test="not(../../../c:oldcgtxnbase/ns1:TaxLotList[ns1:index=$Index]/ns1:SecTransID = ../ns2:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewEntSecTransIdAfterDelete">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--Repeatable Template to get Update_NewEntSecTransId-->
	<xsl:template name="RepeatableNewEntSecTransIdAfterDelete">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_EntSecTransId"/>
			<xsl:call-template name="beginDate_EntSecTransId"/>
			<xsl:call-template name="impact_EntSecTransId"/>
			<xsl:call-template name="inputNature_DeleteAfterUpdateEntSecTransId"/>
			<xsl:call-template name="instrument_EntSecTransId"/>
			<xsl:call-template name="movementNature_EntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_EntSecTransId"/>
			<xsl:call-template name="opSourceCode_EntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_EntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_EntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_EntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_EntSecTransId"/>
			<xsl:call-template name="posReducedAmount_EntSecTransId"/>
			<xsl:call-template name="price_EntSecTransId"/>
			<xsl:call-template name="quantity_EntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_EntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_EntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewEntSecTransIdAfterDelete">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template to Update_NewEntSecTransId -->

	<!-- BEG - Template to Update_OldEntSecTransId After Delete -->
	<xsl:template name="Update_OldEntSecTransId">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:EntSecTransId">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<xsl:call-template name="RepeatableOldEntSecTransId">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Repeatable Template to get Update_OldEntSecTransId(this is also used for Update_OldEntSecTransIdAfterBackDate) -->
	<xsl:template name="RepeatableOldEntSecTransId">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_OldEntSecTransId"/>
			<xsl:call-template name="beginDate_OldEntSecTransId"/>
			<xsl:call-template name="impact_OldEntSecTransId"/>
			<xsl:call-template name="inputNature_OldEntSecTransId"/>
			<xsl:call-template name="instrument_OldEntSecTransId"/>
			<xsl:call-template name="movementNature_OldEntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_OldEntSecTransId"/>
			<xsl:call-template name="opSourceCode_OldEntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_OldEntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_OldEntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_OldEntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_OldEntSecTransId"/>
			<xsl:call-template name="posNetAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_OldEntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_OldEntSecTransId"/>
			<xsl:call-template name="posReducedAmount_OldEntSecTransId"/>
			<xsl:call-template name="price_OldEntSecTransId"/>
			<xsl:call-template name="quantity_OldEntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_OldEntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_OldEntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableOldEntSecTransId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template to Update_OldEntSecTransId After Delete -->

	<!-- BEG - Template to insert BackDated EntSecTransId-->
	<xsl:template name="BackDate_EntSecTransId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
			<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableBackDatedEntSecTransId">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--Repeatable Template to get BackDate_EntSecTransId-->
	<xsl:template name="RepeatableBackDatedEntSecTransId">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>

			<xsl:call-template name="accrAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="beginDate_BackDatedEntSecTransId"/>
			<xsl:call-template name="impact_BackDatedEntSecTransId"/>
			<xsl:call-template name="inputNature_BackDatedEntSecTransId"/>
			<xsl:call-template name="instrument_BackDatedEntSecTransId"/>
			<xsl:call-template name="movementNature_BackDatedEntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_BackDatedEntSecTransId"/>
			<xsl:call-template name="opSourceCode_BackDatedEntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_BackDatedEntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_BackDatedEntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_BackDatedEntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posNetAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="posReducedAmount_BackDatedEntSecTransId"/>
			<xsl:call-template name="price_BackDatedEntSecTransId"/>
			<xsl:call-template name="quantity_BackDatedEntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_BackDatedEntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_BackDatedEntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableBackDatedEntSecTransId">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Template to insert BackDated EntSecTransId-->

	<!-- BEG - Sending Update of EntSecTransId after BackDate -->
	<xsl:template name="Update_NewEntSecTransIdAfterBackDate">
		<xsl:variable name="backIndex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:TaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="backindex">
			<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:PurTaxLotID">
				<xsl:if test="not(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID)">
					<xsl:value-of select="../ns2:index"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="nonzero">
			<xsl:choose>
				<xsl:when test="$backIndex!=''">
					<xsl:value-of select="$backIndex"/>
				</xsl:when>
				<xsl:when test="$backindex!=''">
					<xsl:value-of select="$backindex"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
			<xsl:if test="(../ns2:SecTransID = ../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID) and (../ns2:index &gt;= $nonzero)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewEntSecTransIdAfterBackDate">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Repeatable Template to send updated backdated EntSecTransId -->
	<xsl:template name="RepeatableNewEntSecTransIdAfterBackDate">
		<xsl:param name="index"/>
		<xsl:param name="NumberOfDollars">
			<xsl:value-of select="string-length(.) - string-length(translate(.,'$',''))"/>
		</xsl:param>
		<xsl:param name="total" select="$NumberOfDollars + 1"/>

		<xsl:param name="EntSecTransId" select="concat(.,'$')"/>
		<xsl:param name="EntNominal" select="concat(../ns2:EntNominal,'$')"/>
		<xsl:param name="EntExpenses" select="concat(../ns2:EntExpenses,'$')"/>
		<xsl:param name="EntReducedCost" select="concat(../ns2:EntReducedCost,'$')"/>
		<xsl:param name="EntCost" select="concat(../ns2:EntCost,'$')"/>
		<TaxLot>
			<xsl:attribute name="description">
				<xsl:value-of select="concat('TaxLot.xsl+',name(/*),'+', ../../../c:eventCommon/ns0:eventId, '+', ../../../c:eventCommon/ns0:creationTime)"/>
			</xsl:attribute>
			<xsl:attribute name="sequenceNumber">
				<xsl:call-template name="calcSeqNum">
					<xsl:with-param name="creationTime">
						<xsl:value-of select="../../../c:eventCommon/ns0:creationTime"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:attribute>
			<xsl:call-template name="accrAmount_EntSecTransId"/>
			<xsl:call-template name="beginDate_EntSecTransId"/>
			<xsl:call-template name="impact_EntSecTransId"/>
			<xsl:call-template name="inputNature_NewEntSecTransIdAfterBackDate"/>
			<xsl:call-template name="instrument_EntSecTransId"/>
			<xsl:call-template name="movementNature_EntSecTransId"/>
			<xsl:call-template name="taxLotSourceCode_EntSecTransId"/>
			<xsl:call-template name="opSourceCode_EntSecTransId">
				<xsl:with-param name="EntSecTransId" select="$EntSecTransId"/>
			</xsl:call-template>
			<xsl:call-template name="portfolio_EntSecTransId"/>
			<xsl:call-template name="posFeesTaxesAmount_EntSecTransId">
				<xsl:with-param name="EntExpenses" select="$EntExpenses"/>
			</xsl:call-template>
			<xsl:call-template name="posGrossAmount_EntSecTransId">
				<xsl:with-param name="EntCost" select="$EntCost"/>
			</xsl:call-template>
			<xsl:call-template name="posIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlDiscountedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlIndexedAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlLtNetAmount_EntSecTransId"/>
			<xsl:call-template name="posPlNonDiscAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStGrossAmount_EntSecTransId"/>
			<xsl:call-template name="posPlStNetAmount_EntSecTransId"/>
			<xsl:call-template name="posReducedAmount_EntSecTransId"/>
			<xsl:call-template name="price_EntSecTransId"/>
			<xsl:call-template name="quantity_EntSecTransId">
				<xsl:with-param name="EntNominal" select="$EntNominal"/>
			</xsl:call-template>
			<xsl:call-template name="quote_EntSecTransId"/>
			<xsl:call-template name="taxEffectiveDate_EntSecTransId"/>
		</TaxLot>
		<xsl:if test="not($index = $total)">
			<xsl:call-template name="RepeatableNewEntSecTransIdAfterBackDate">
				<xsl:with-param name="index" select="$index + 1"/>
				<xsl:with-param name="EntSecTransId" select="substring-after($EntSecTransId,'$')"/>
				<xsl:with-param name="EntNominal" select="substring-after($EntNominal,'$')"/>
				<xsl:with-param name="EntExpenses" select="substring-after($EntExpenses,'$')"/>
				<xsl:with-param name="EntReducedCost" select="substring-after($EntReducedCost,'$')"/>
				<xsl:with-param name="EntCost" select="substring-after($EntCost,'$')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!-- END - Sending Update of EntSecTransId after BackDate -->

	<!-- BEG - Update to Old EntSecTransId after backdate-->
	<xsl:template name="Update_OldEntSecTransIdAfterBackDate">
		<xsl:for-each select="c:oldcgtxnbase/ns1:TaxLotList/ns1:EntSecTransId">
			<xsl:variable name="Index" select="../ns1:index"/>
			<xsl:if test="not(../../../c:newcgtxnbase/ns2:TaxLotList[ns2:index=$Index]/ns2:SecTransID = ../ns1:SecTransID) and ../ns1:SecTransID = ../../../c:newcgtxnbase/ns2:TaxLotList/ns2:SecTransID">
				<DataGroup>
					<xsl:call-template name="RepeatableOldEntSecTransId">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- END - Update to Old EntSecTransId after backdate-->

	<!-- BEG - Insert to EntSecTransId -->
	<xsl:template name="Insert_EntSecTransId">
		<xsl:for-each select="c:newcgtxnbase/ns2:TaxLotList/ns2:EntSecTransId">
			<xsl:if test="not(../../../c:oldcgtxnbase/ns1:TaxLotList/ns1:SecTransID = ../ns2:SecTransID)">
				<DataGroup>
					<xsl:call-template name="RepeatableNewEntSecTransId">
						<xsl:with-param name="index" select="1"/>
					</xsl:call-template>
				</DataGroup>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- END - Insert to EntSecTransId -->
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