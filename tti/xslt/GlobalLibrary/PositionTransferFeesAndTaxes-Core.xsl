<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printPositionTransferFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:param name="commission"/>
		<xsl:param name="tax"/>
		<xsl:param name="securityCcy"/>
		<!-- Avoid empty values when 0 -->
		<xsl:variable name="decimalformatZ" select="'0.########################################'"/>
		<!-- Ensure parameter values are not NaN -->
		<xsl:variable name="commissionNb">
			<xsl:value-of select="format-number($commission,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<xsl:variable name="taxNb">
			<xsl:value-of select="format-number($tax,$decimalformatZ,'nan2zero')"/>
		</xsl:variable>

		<xsl:call-template name="BP1">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP2">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP3">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP4">
			<xsl:with-param name="commissionNb" select="$commissionNb"/>
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP5">
			<xsl:with-param name="taxNb" select="$taxNb"/>
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP6">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP7">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP8">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP9">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
		<xsl:call-template name="BP10">
			<xsl:with-param name="securityCcy" select="$securityCcy"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="BP1">
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>

				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="commissionNb"/>
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$commissionNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="taxNb"/>
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="$taxNb"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
	<xsl:template name="BP8">
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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
		<xsl:param name="securityCcy"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$securityCcy"/>
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