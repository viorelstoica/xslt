<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printDxMaturityFeesAndTaxes">
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
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
				<xsl:value-of select="'0'"/>
			</amount>
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
				<xsl:value-of select="'0'"/>
			</amount>
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
		<xsl:variable name="index" select="@index"/>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="../../*[local-name() = 'taxAmtTcyGroup'][@index=$index]/*[local-name() = 'taxAmtTcySubGroup']/*[local-name() = 'taxAmtTcy'] and ../../*[local-name() = 'taxAmtTcyGroup'][@index=$index]/*[local-name() = 'taxAmtTcySubGroup']/*[local-name() = 'taxAmtTcy'] != ''">
						<xsl:value-of select="format-number(sum(../../*[local-name() = 'taxAmtTcyGroup'][@index=$index]/*[local-name() = 'taxAmtTcySubGroup']/*[local-name() = 'taxAmtTcy'][. &gt; 0]) - sum(../../*[local-name() = 'taxAmtTcyGroup'][@index=$index]/*[local-name() = 'taxAmtTcySubGroup']/*[local-name() = 'taxAmtTcy'][. &lt; 0]),$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="../../*[local-name() = 'currencyList']/*[local-name() = 'currency'][@index=$index]"/>
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