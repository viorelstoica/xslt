<?xml version="1.0"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
    <!-- START of protected area  --> 
    <xsl:template name="PRI.COMM.TYP"/>
	<xsl:template name="PRI.COMM.CDE"/>
	<xsl:template name="PRI.COMM.CCY">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2')">
			<field name="PRI.COMM.CCY:1:1">
				<xsl:value-of select="substring-before(substring-after(*[local-name() = 'security']/infra:code,'/'),'/')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.COMM.AMT">
		<xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and (*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2')">
			<field name="PRI.COMM.AMT:1:1">
				<xsl:value-of select="- translate(*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value,',','')"/>
			</field>
		</xsl:if>
	</xsl:template>
	<xsl:template name="PRI.AUTO.MANUAL">
		<field name="PRI.AUTO.MANUAL">
			<xsl:choose>
				<xsl:when test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value  != 'NULL' and ((*[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '1' or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '100') or *[local-name() = 'userDefinedField'][infra:name='order_fee_e']/infra:value = '2')">
					<xsl:value-of select="'MANUAL'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'AUTOMATIC'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template> 
    <!-- END of protected area  -->
</xsl:stylesheet>