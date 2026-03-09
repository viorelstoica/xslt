<?xml version="1.0"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
    <!-- START of protected area  -->
	 
    <xsl:template name="CU.CHARGE.TAX.AMT">
		<xsl:choose>
			<xsl:when test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1'">
				<xsl:element name="field">
					<xsl:attribute name="name">
						<xsl:value-of select="concat('CU.CHARGE.TAX.AMT:','-1')"/>
					</xsl:attribute>
						<xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value,',','')"/>
				</xsl:element>
			</xsl:when>
			<!--<xsl:otherwise>
				<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '0' ">
					<xsl:element name="field">
					<xsl:attribute name="name">
						<xsl:value-of select="concat('CU.CHARGE.TAX.AMT:','-1')"/>
					</xsl:attribute>
						<xsl:value-of select="''"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise> -->
		</xsl:choose>
    </xsl:template>
	<xsl:template name="CU.COMMISSION">
		<xsl:choose>
			<xsl:when test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2' and *[local-name() = 'userDefinedField'][infra:name='order_fee_p']/infra:value != 'NULL'">
				<xsl:element name="field">
					<xsl:attribute name="name">
						<xsl:value-of select="'CU.COMMISSION'"/>
					</xsl:attribute>
					<xsl:value-of select="''"/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' ">
					<xsl:element name="field">
					<xsl:attribute name="name">
						<xsl:value-of select="'CU.COMMISSION'"/>
					</xsl:attribute>
						<xsl:value-of select="''"/>
					</xsl:element>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
    <!-- END of protected area  -->
</xsl:stylesheet>