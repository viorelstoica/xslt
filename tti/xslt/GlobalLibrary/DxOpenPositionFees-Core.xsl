<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printDxOpenPositionFeesAndTaxes">
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
			<amount>0</amount>
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
				<xsl:choose>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommAmt'] &lt; 0">
						<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommAmt'] &gt; 0">
						<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommAmt']"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommCcy'] != ''">
							<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='REGULATORY']/*[local-name() = 'priCommCcy']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
						</xsl:otherwise>
					</xsl:choose>
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
				<xsl:choose>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommAmt'] &lt; 0">
						<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommAmt'] &gt; 0">
						<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommAmt']"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommCcy'] != ''">
							<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='EXECUTION']/*[local-name() = 'priCommCcy']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
						</xsl:otherwise>
					</xsl:choose>
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
				<xsl:choose>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommAmt'] &lt; 0">
						<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommAmt'] &gt; 0">
						<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommAmt']"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommCcy'] != ''">
							<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='COMMISSION']/*[local-name() = 'priCommCcy']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommAmt'] &lt; 0">
						<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommAmt'] &gt; 0">
						<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommAmt']"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommCcy'] != ''">
							<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='CLEARING']/*[local-name() = 'priCommCcy']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
						</xsl:otherwise>
					</xsl:choose>
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
			<amount>0</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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
				<xsl:choose>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommAmt'] &lt; 0">
						<xsl:value-of select="format-number(-1* *[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommAmt'],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommAmt'] &gt; 0">
						<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommAmt']"/>
					</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:choose>
						<xsl:when test="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommCcy'] != ''">
							<xsl:value-of select="*[local-name() = 'priSecAccGroup']/*[local-name() = 'priCommTypSubGroup'][*[local-name() = 'priCommTyp']='MISC']/*[local-name() = 'priCommCcy']"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
						</xsl:otherwise>
					</xsl:choose>
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
			<amount>0</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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
				<xsl:value-of select="format-number(sum(*[local-name() = 'priSecAccGroup']/*[local-name() = 'taxAmtAcySubGroup'][*[local-name() = 'taxAmtTcy'] &gt;= 0]/*[local-name() = 'taxAmtTcy']) -  sum(*[local-name() = 'priSecAccGroup']/*[local-name() = 'taxAmtAcySubGroup'][*[local-name() = 'taxAmtTcy'] &lt;= 0]/*[local-name() = 'taxAmtTcy']),$decimalformat,'nan2zero')"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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
			<amount>0</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="*[local-name() = 'tradeCcy']"/>
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