<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra xsl" version="1.0">
	<xsl:template name="printTradeFeesAndTaxesFromUpfrontTrade">
		<xsl:call-template name="BP1UPFR"/>
		<xsl:call-template name="BP2UPFR"/>
		<xsl:call-template name="BP3UPFR"/>
        <xsl:call-template name="BP4UPFR"/>
        <xsl:call-template name="BP5UPFR"/>
        <xsl:call-template name="BP6UPFR"/>
        <xsl:call-template name="BP7UPFR"/>
        <xsl:call-template name="BP8UPFR"/>
        <xsl:call-template name="BP9UPFR"/>
        <xsl:call-template name="BP10UPFR"/>

	</xsl:template>
	<xsl:template name="BP1UPFR">
		<transactionFeesTaxesCounter>
			<amount>
			    <xsl:choose>
					<xsl:when test="(*/*[local-name() = 'linkReferenceCuEbvFees'] = '' or not(*/*[local-name() = 'linkReferenceCuEbvFees'])) and 
					                (*/*[local-name() = 'linkReferenceCuForeignFee'] = '' or not(*/*[local-name() = 'linkReferenceCuForeignFee']))">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuEbvFees'] + */*[local-name() = 'linkReferenceCuForeignFee'],$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP2UPFR">
		<transactionFeesTaxesCounter>
			<amount>
					<xsl:variable name="taxvarUpr">
						<xsl:choose>
							<xsl:when test="*/*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuMantaxtcy'] and */*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuMantaxtcy'] != ''">
								<xsl:value-of select="format-number(sum(*/*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuMantaxtcy']),$decimalformat,'nan2zero')"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="*/*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuTaxTcy'] and */*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuTaxTcy'] != '' ">
										<xsl:value-of select="format-number(sum(*/*[local-name() = 'linkReferencelinkReferenceCuTaxTcySubGroup']/*[local-name() = 'linkReferenceCuTaxTcy']),$decimalformat,'nan2zero')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'0'"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="*/*[local-name() = 'linkReferenceCgtTaxAmtSubGroup']/*[local-name() = 'linkReferenceCgtTaxAmt'] and */*[local-name() = 'linkReferenceCgtTaxAmtSubGroup']/*[local-name() = 'linkReferenceCgtTaxAmt'] != ''">
							<xsl:value-of select="format-number($taxvarUpr +sum(*/*[local-name() = 'linkReferenceCgtTaxAmtSubGroup']/*[local-name() = 'linkReferenceCgtTaxAmt']),$decimalformat,'nan2zero')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$taxvarUpr"/>
						</xsl:otherwise>
					</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP3UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="*/*[local-name() = 'linkReferenceCuBrkrComm'] = '' or not(*/*[local-name() = 'linkReferenceCuBrkrComm'])">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="*/*[local-name() = 'linkReferenceCuBrkrComm']"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP4UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="((*/*[local-name() = 'linkReferenceCuCommission'] = '' or not(*/*[local-name() = 'linkReferenceCuCommission'])) and (*/*[local-name() = 'linkReferenceCuCommTax'] = '' or not(*/*[local-name() = 'linkReferenceCuCommTax'])))">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:when test="*/*[local-name() = 'linkReferenceCuCommission'] = '' or not(*/*[local-name() = 'linkReferenceCuCommission'])">
						<xsl:value-of select="../*[local-name() = 'linkReferenceCuCommTax']"/>
					</xsl:when>
					<xsl:when test="*/*[local-name() = 'linkReferenceCuCommTax'] = '' or not(*/*[local-name() = 'linkReferenceCuCommTax'])">
						<xsl:value-of select="*/*[local-name() = 'linkReferenceCuCommission']"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(sum(*/*[local-name() = 'linkReferenceCuCommission'])+sum(*/*[local-name() = 'linkReferenceCuCommTax']),$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP5UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="*/*[local-name() = 'linkReferenceCuStampTax'] = '' or not(*/*[local-name() = 'linkReferenceCuStampTax'])">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="*/*[local-name() = 'linkReferenceCuStampTax']"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP6UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:variable name="entryLoadVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'ENTRY.LOAD.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="salesTaxVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'ENTRY.GST.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="exitLoadVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'EXIT.LOAD.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="exitSalesTaxVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'EXIT.GST.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="switchCommissionVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'SWITCH.COMM.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="switchTaxVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'SWITCH.GST.CU']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="turnOverFeeVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'TURNOVERFEE']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="entryRebateVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'RB.ENTRY.LOAD']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="eLChDiscountVarUpr">
                    <xsl:value-of select="format-number(*/*[local-name() = 'linkReferenceCuChargeTaxTypeSubGroup'][*[local-name() = 'linkReferenceCuChargeTaxType'] = 'ENTRY.LOAD.CH.DI']/*[local-name() = 'linkReferenceCuChargeTaxAmt'],$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:variable name="bpAmount6VarUpr">
					<xsl:value-of select="format-number(number($entryLoadVarUpr + $salesTaxVarUpr + $exitLoadVarUpr + $exitSalesTaxVarUpr + $switchCommissionVarUpr + $switchTaxVarUpr + $turnOverFeeVarUpr - $entryRebateVarUpr - $eLChDiscountVarUpr),$decimalformat,'nan2zero')"/>
				</xsl:variable>
				<xsl:value-of select="round($bpAmount6VarUpr * 100) div 100"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP7UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="../*[local-name() = 'linkReferenceCuFeesMisc'] = '' or not(../*[local-name() = 'linkReferenceCuFeesMisc'])">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="../*[local-name() = 'linkReferenceCuFeesMisc']"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<xsl:template name="BP8UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="../*[local-name() = 'linkReferenceCuReallowAmt'] = '' or ../*[local-name() = 'linkReferenceCuDiscAmt'] = '' or not(../*[local-name() = 'linkReferenceCuDiscAmt']) or not(../*[local-name() = 'linkReferenceCuReallowAmt'])">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(number(concat('-',../*[local-name() = 'linkReferenceCuReallowAmt'] + ../*[local-name() = 'linkReferenceCuDiscAmt'])),$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP9UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="*/*[local-name() = 'linkReferenceCuWhtTaxList']/*[local-name() = 'linkReferenceCuWhtTax'] = '' or not(*/*[local-name() = 'linkReferenceCuWhtTaxList']/*[local-name() = 'linkReferenceCuWhtTax'])">
						<xsl:value-of select="'0'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(sum(*/*[local-name() = 'linkReferenceCuWhtTaxList']/*[local-name() = 'linkReferenceCuWhtTax']),$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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
	<xsl:template name="BP10UPFR">
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'linkReferenceTradeCcy']"/>
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