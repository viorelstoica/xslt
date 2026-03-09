
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printTradeFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:variable name="intraSwitchFund">
			<xsl:choose>
				<xsl:when test="($caller = 'TransactionSecurityBuy' or $caller = 'TransactionSecuritySell' or $caller = 'SecTradeBuyActualSettlement' or $caller = 'SecTradeSellActualSettlement') and (../../*[local-name() = 'switchSuspCatJoin'] = ../../*[local-name() = 'custAccNoCategoryList']/*[local-name() = 'custAccNoCategory'])">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tradeFeesTaxesVar">
			<xsl:choose>
				<xsl:when test="$intraSwitchFund = '0' and (../../*[local-name() = 'originalSec'] = '' or not(../../*[local-name() = 'originalSec']))">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="BP1">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP2">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP3">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP4">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP5">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP6">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP7">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP8">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP9">
			<xsl:with-param name="tradeFeesTaxesVar" select="$tradeFeesTaxesVar"/>
		</xsl:call-template>
		<xsl:call-template name="BP10"/>
		
	</xsl:template>
	<xsl:template name="BP1">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(../*[local-name() = 'cuEbvFees'], $decimalformat,'nan2zero') + format-number(../*[local-name() = 'cuForeignFee'],$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP1'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP2">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="taxvar">
							<xsl:choose>
								<xsl:when test="../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuMantaxtcy'] and ../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuMantaxtcy'] != ''">
									<xsl:value-of select="format-number(sum(../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuMantaxtcy']),$decimalformat,'nan2zero')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuTaxTcy'] and ../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuTaxTcy'] != '' ">
											<xsl:value-of select="format-number(sum(../*[local-name() = 'cuTaxTcySubGroup']/*[local-name() = 'cuTaxTcy']),$decimalformat,'nan2zero')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'0'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="../*[local-name() = 'cgtTaxAmtSubGroup']/*[local-name() = 'cgtTaxAmt'] and ../*[local-name() = 'cgtTaxAmtSubGroup']/*[local-name() = 'cgtTaxAmt'] != ''">
								<xsl:value-of select="format-number($taxvar +sum(../*[local-name() = 'cgtTaxAmtSubGroup']/*[local-name() = 'cgtTaxAmt']),$decimalformat,'nan2zero')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="$taxvar"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP2'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP3">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
			<xsl:choose>
					<xsl:when test="not(starts-with(../../*[local-name() = 'linkReference'],'PECT'))">
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../*[local-name() = 'cuBrkrComm'] = '' or not(../*[local-name() = 'cuBrkrComm'])">
								<xsl:value-of select="'0'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../*[local-name() = 'cuBrkrComm']"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP3'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP4">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT')">
						<xsl:value-of select="format-number(sum(../../*[local-name() = 'cuChargeTaxTypePctGroup']/*[local-name() = 'cuChargeTaxTypePctSubGroup']/*[local-name() = 'cuChargeTaxAmountPct']),$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$tradeFeesTaxesVar = '1' or (../../*[local-name() = 'securityCodeIpoStartDate']  and not(../../*[local-name() = 'securityCodeIpoStartDate']  = ''))                          or  ../../*[local-name() = 'scStdSecTradeChargeTime'] = 'EXECUTION'            ">
								<xsl:value-of select="format-number(sum(../*[local-name() = 'cuCommission'])+sum(../*[local-name() = 'cuCommTax']),$decimalformat,'nan2zero')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="((../*[local-name() = 'cuCommission'] = '' or not(../*[local-name() = 'cuCommission'])) and (../*[local-name() = 'cuCommTax'] = '' or not(../*[local-name() = 'cuCommTax'])))">
										<xsl:value-of select="'0'"/>
									</xsl:when>
									<xsl:when test="../*[local-name() = 'cuCommission'] = '' or not(../*[local-name() = 'cuCommission'])">
										<xsl:value-of select="../*[local-name() = 'cuCommTax']"/>
									</xsl:when>
									<xsl:when test="../*[local-name() = 'cuCommTax'] = '' or not(../*[local-name() = 'cuCommTax'])">
										<xsl:value-of select="../*[local-name() = 'cuCommission']"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'0'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT')">
							<xsl:value-of select="../../*[local-name() = 'currency']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					
							<xsl:call-template name="BPTranslation">
								<xsl:with-param name="boBP" select="'BP4'"/>
							</xsl:call-template>
						
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP5">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../*[local-name() = 'cuStampTax'] = '' or not(../*[local-name() = 'cuStampTax'])">
								<xsl:value-of select="'0'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../*[local-name() = 'cuStampTax']"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP5'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP6">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="entryLoadVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.LOAD.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="salesTaxVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="exitLoadVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'EXIT.LOAD.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="exitSalesTaxVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'EXIT.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="switchCommissionVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SWITCH.COMM.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="switchTaxVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'SWITCH.GST.CU']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="turnOverFeeVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'TURNOVERFEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="cancChargeVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'CANC.CHARGE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="entryRebateVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'RB.ENTRY.LOAD']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="eLChDiscountVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'ENTRY.LOAD.CH.DI']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="minHoldingFeeVar">
							<xsl:value-of select="format-number(../../*[local-name() = 'customerNoGroup']/*[local-name() = 'cuChargeTaxTypeSubGroup'][*[local-name() = 'cuChargeTaxType'] = 'MIN.HOLDING.FEE']/*[local-name() = 'cuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:variable name="bpAmount6Var">
							<xsl:value-of select="format-number(number($entryLoadVar + $salesTaxVar + $exitLoadVar + $exitSalesTaxVar + $switchCommissionVar + $switchTaxVar + $turnOverFeeVar + $cancChargeVar + $minHoldingFeeVar - $entryRebateVar - $eLChDiscountVar),$decimalformat,'nan2zero')"/>
						</xsl:variable>
						<xsl:value-of select="round($bpAmount6Var * 100) div 100"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP6'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP7">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$PEWorkflowhandling = 'YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT')">
						<xsl:value-of select="format-number(sum(../../*[local-name() = 'cuChargeTaxTypePctGroup']/*[local-name() = 'issuerFeeDescSubGroup']/*[local-name() = 'chargedAmount']),$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$tradeFeesTaxesVar = '1'">
								<xsl:value-of select="'0'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="../*[local-name() = 'cuFeesMisc'] = '' or not(../*[local-name() = 'cuFeesMisc'])">
										<xsl:value-of select="'0'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="../*[local-name() = 'cuFeesMisc']"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
				<xsl:choose>
						<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT')">
							<xsl:value-of select="../../*[local-name() = 'currency']"/>
						</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
					</xsl:otherwise>
					</xsl:choose>

				</infra:code>
			</currency>
			<type>
				<infra:code>
				<xsl:choose>
						<xsl:when test="$PEWorkflowhandling ='YES' and starts-with(../../*[local-name() = 'linkReference'],'PECT') and not(../../*[local-name() = 'FeeChgCumulative'])">
							<xsl:value-of select="'FEE'"/>
						</xsl:when>
					<xsl:otherwise>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP8">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(../*[local-name() = 'cuReallowAmt'], $decimalformat,'nan2zero') + format-number(../*[local-name() = 'cuDiscAmt'],$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP8'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP9">
		<xsl:param name="tradeFeesTaxesVar"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$tradeFeesTaxesVar = '1'">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../*[local-name() = 'cuWhtTaxList']/*[local-name() = 'cuWhtTax'] = '' or not(../*[local-name() = 'cuWhtTaxList']/*[local-name() = 'cuWhtTax'])">
								<xsl:value-of select="'0'"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="format-number(sum(../*[local-name() = 'cuWhtTaxList']/*[local-name() = 'cuWhtTax']),$decimalformat,'nan2zero')"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP9'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP10">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'tradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP10'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
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