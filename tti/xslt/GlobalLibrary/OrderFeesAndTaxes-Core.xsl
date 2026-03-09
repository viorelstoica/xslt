<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printOrderFeesAndTaxes">
	<xsl:param name="caller"/>
		<xsl:choose>
			<xsl:when test="$caller = 'OrderTaxLots'">
				<xsl:call-template name="CU.EBV.FEES_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.FOREIGN.FEE_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.TAX.TCY_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CGT.TAX.AMT_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CGT.MANTAXTCY_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.BRKR.COMM_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.COMMISSION_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.COMM.TAX_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.STAMP.TAX_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.FEES.MISC_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.REALLOW.AMT_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.DISC.AMT_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.WHT.TAX_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.CHARGE.TAX.AMT_Taxlots">
				</xsl:call-template>
				<xsl:call-template name="CU.CHARGE.TAX.TYPE_Taxlots">
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="CU.EBV.FEES">
				</xsl:call-template>
				<xsl:call-template name="CU.FOREIGN.FEE">
				</xsl:call-template>
				<xsl:call-template name="CU.TAX.TCY">
				</xsl:call-template>
				<xsl:call-template name="CGT.TAX.AMT">
				</xsl:call-template>
				<xsl:call-template name="CGT.MANTAXTCY">
				</xsl:call-template>
				<xsl:call-template name="CU.BRKR.COMM">
				</xsl:call-template>
				<xsl:call-template name="CU.COMMISSION">
				</xsl:call-template>
				<xsl:call-template name="CU.COMM.TAX">
				</xsl:call-template>
				<xsl:call-template name="CU.STAMP.TAX">
				</xsl:call-template>
				<xsl:call-template name="CU.FEES.MISC">
				</xsl:call-template>
				<xsl:call-template name="CU.REALLOW.AMT">
				</xsl:call-template>
				<xsl:call-template name="CU.DISC.AMT">
				</xsl:call-template>
				<xsl:call-template name="CU.WHT.TAX">
				</xsl:call-template>
				<xsl:call-template name="CU.CHARGE.TAX.AMT">
				</xsl:call-template>
				<xsl:call-template name="CU.CHARGE.TAX.TYPE">
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CU.EBV.FEES"/>
	<xsl:template name="CU.FOREIGN.FEE"/>
	<xsl:template name="CU.TAX.TCY"/>
	<xsl:template name="CGT.TAX.AMT"/>
	<xsl:template name="CGT.MANTAXTCY"/>
	<xsl:template name="CU.BRKR.COMM"/>
	<xsl:template name="CU.COMMISSION">
		<xsl:choose>
			<xsl:when test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2' and *[local-name() = 'userDefinedField'][infra:name='order_fee_p']/infra:value != 'NULL'">
				<xsl:element name="field" xmlns="http://www.temenos.com/T24/OFSML/150">
					<xsl:attribute name="name">
						<xsl:value-of select="'CU.COMMISSION'"/>
					</xsl:attribute>
					<xsl:value-of select="translate(concat(*[local-name() = 'userDefinedField'][infra:name='order_fee_p']/infra:value,'%'),',','')"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' ">
					<xsl:element name="field" xmlns="http://www.temenos.com/T24/OFSML/150">
					<xsl:attribute name="name">
						<xsl:value-of select="'CU.COMMISSION'"/>
					</xsl:attribute>
						<xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value,',','')"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CU.COMM.TAX"/>
	<xsl:template name="CU.STAMP.TAX"/>
	<xsl:template name="CU.FEES.MISC"/>
	<xsl:template name="CU.REALLOW.AMT"/>
	<xsl:template name="CU.DISC.AMT"/>
	<xsl:template name="CU.WHT.TAX"/>
	<xsl:template name="CU.CHARGE.TAX.AMT"/>
	<xsl:template name="CU.CHARGE.TAX.TYPE"/>
	
	<xsl:template name="CU.EBV.FEES_Taxlots"/>
	<xsl:template name="CU.FOREIGN.FEE_Taxlots"/>
	<xsl:template name="CU.TAX.TCY_Taxlots"/>
	<xsl:template name="CGT.TAX.AMT_Taxlots"/>
	<xsl:template name="CGT.MANTAXTCY_Taxlots"/>
	<xsl:template name="CU.BRKR.COMM_Taxlots"/>
	<xsl:template name="CU.COMMISSION_Taxlots">
		<xsl:choose>
			<xsl:when test="*[local-name() = 'attribute'][@name='order_fee_e'] = '2' and *[local-name() = 'attribute'][@name='order_fee_p'] != 'NULL'">
				<xsl:element name="field" xmlns="http://www.temenos.com/T24/OFSML/150">
					<xsl:attribute name="name">
						<xsl:value-of select="'CU.COMMISSION'"/>
					</xsl:attribute>
					<xsl:value-of select="translate(concat(*[local-name() = 'attribute'][@name='order_fee_p'],'%'),',','')"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="*[local-name() = 'attribute'][@name='order_fee_e'] = '1' ">
					<xsl:element name="field" xmlns="http://www.temenos.com/T24/OFSML/150">
						<xsl:attribute name="name">
							<xsl:value-of select="'CU.COMMISSION'"/>
						</xsl:attribute>
						<xsl:value-of select="translate(*[local-name() = 'attribute'][@name='bp_4_amount_m'],',','')"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="CU.COMM.TAX_Taxlots"/>
	<xsl:template name="CU.STAMP.TAX_Taxlots"/>
	<xsl:template name="CU.FEES.MISC_Taxlots"/>
	<xsl:template name="CU.REALLOW.AMT_Taxlots"/>
	<xsl:template name="CU.DISC.AMT_Taxlots"/>
	<xsl:template name="CU.WHT.TAX_Taxlots"/>
	<xsl:template name="CU.CHARGE.TAX.AMT_Taxlots"/>
	<xsl:template name="CU.CHARGE.TAX.TYPE_Taxlots"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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