
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printTransferFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:call-template name="BP1">
		</xsl:call-template>
		<xsl:call-template name="BP2">
		</xsl:call-template>
		<xsl:call-template name="BP3">
		</xsl:call-template>
		<xsl:call-template name="BP4">
		</xsl:call-template>
		<xsl:call-template name="BP5">
		</xsl:call-template>
		<xsl:call-template name="BP6">
		</xsl:call-template>
		<xsl:call-template name="BP7">
		</xsl:call-template>
		<xsl:call-template name="BP8">
		</xsl:call-template>
		<xsl:call-template name="BP9">
		</xsl:call-template>
		<xsl:call-template name="BP10">
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="BP1">

		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<xsl:variable name="taxvar">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'cuTaxTcyGroup']/*[local-name() = 'manTaxTcy'] and *[local-name() = 'cuTaxTcyGroup']/*[local-name() = 'manTaxTcy'] != ''">
					<xsl:value-of select="format-number(sum(*[local-name() = 'cuTaxTcyGroup']/*[local-name() = 'manTaxTcy']),$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="format-number(sum(*[local-name() = 'cuTaxTcyGroup']/*[local-name() = 'cuTaxTcy']),$decimalformat,'nan2zero')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="format-number(sum(*[local-name() = 'localTax'])+$taxvar+sum(*[local-name() = 'cgtTaxAmtGroup']/*[local-name() = 'cgtTaxAmt']),$decimalformat,'nan2zero')"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:variable name="chargesVar">
					<xsl:choose>
						<xsl:when test="*[local-name() = 'charges'] = '' or not(*[local-name() = 'charges'])">
							<xsl:value-of select="0"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'charges']"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="cuCommissionVar">
					<xsl:choose>
						<xsl:when test="*[local-name() = 'cuCommission'] = '' or not(*[local-name() = 'cuCommission']) or *[local-name() = 'upfrontSec']='Y'">
							<xsl:value-of select="0"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="format-number(sum(*[local-name() = 'cuCommission']),$decimalformat,'nan2zero')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="format-number($chargesVar + $cuCommissionVar,$decimalformat,'nan2zero')"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="format-number(sum(*[local-name() = 'cuTax']|*[local-name() = 'cuStampTax']),$decimalformat,'nan2zero')"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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
					<xsl:value-of select="*[local-name() = 'securityCcy']"/>
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