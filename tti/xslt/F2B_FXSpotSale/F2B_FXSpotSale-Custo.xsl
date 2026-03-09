<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B_MM_FX" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="USERDEF.FIELDS">
		<!-- START Best Execution Development GOPI M -->
		<field name="CSD.CONTACT.BY">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_ACCT_HOLDER'">
					<xsl:value-of select="'Account Holder'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_PWR_ATTORNEY'">
					<xsl:value-of select="'Attorney'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_BENEF_OWNER'">
					<xsl:value-of select="'Beneficial Owner'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_ACCT_OTHER'">
					<xsl:value-of select="'Other'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_SIGNATORY'">
					<xsl:value-of select="'Signatory'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='comm_party_type']/infra:value = 'PCK_GL_THIRD_MANAGER'">
					<xsl:value-of select="'Third Party Manager'"/>
				</xsl:when>
				<!-- Optional: handle NULL or missing value -->
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.CONT.DATE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='communication_d']/infra:value != 'NULL'">
					<xsl:variable name="date" select="b:userDefinedField[infra:name='communication_d']/infra:value"/>
					<xsl:value-of select="concat(substring($date, 7, 4), substring($date, 4, 2), substring($date, 1, 2))"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.CONT.METHOD">
			<xsl:choose>
				<xsl:when test="b:contactMethod = 'PCK_GL_EMAIL'">
					<xsl:value-of select="'Email'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_OTHER'">
					<xsl:value-of select="'Other'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_FAX'">
					<xsl:value-of select="'Facsimile'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_INTERNET'">
					<xsl:value-of select="'Internet'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_LETTER'">
					<xsl:value-of select="'Letter Post'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_MEETING'">
					<xsl:value-of select="'Meeting'"/>
				</xsl:when>
				<xsl:when test="b:contactMethod = 'PCK_GL_PHONE'">
					<xsl:value-of select="'Telephone'"/>
				</xsl:when>
				<!-- Optional: handle NULL or missing value -->
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.ORDER.INR">
			<xsl:choose>
				<xsl:when test="b:initiatedBy = '2'">
					<xsl:value-of select="'Bank'"/>
				</xsl:when>
				<xsl:when test="b:initiatedBy = '1'">
					<xsl:value-of select="'Client'"/>
				</xsl:when>
				<xsl:when test="b:initiatedBy = ''">
					<xsl:value-of select="''"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<!-- END Best Execution Development GOPI M-->
		<field name="CSD.LIM.PRICE">
			<xsl:value-of select="b:userDefinedField[infra:name='limit_price_n']/infra:value"/>
		</field>
		<field name="CSD.TAP.INPUTT">
			<xsl:value-of select="b:userDefinedField[infra:name='input_user']/infra:value"/>
		</field>
		<xsl:if test="b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value!='NULL' and b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value">
			<field name="CSD.LIM.EXP.DT">
				<xsl:value-of select="concat(substring(b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value, 7, 4),substring(b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value, 4, 2),substring(b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value, 1, 2))"/>
			</field>
			<field name="CSD.LIM.EXP.TM">
				<xsl:value-of select="substring(b:userDefinedField[infra:name='ud_validity_date_time_d']/infra:value, 12,5)"/>
			</field>
		</xsl:if>
		<field name="CSD.LIM.TYPE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_limit_type_e']/infra:value = '0'">
					<xsl:value-of select="'MARKET'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_limit_type_e']/infra:value = '1'">
					<xsl:value-of select="'LIMIT'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_limit_type_e']/infra:value = '2'">
					<xsl:value-of select="'STOP.LOSS'"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.ORDER.DETS">
			<xsl:value-of select="concat('SEL', b:userDefinedField[infra:name='fi_currency']/infra:value, b:quantity)"/>
		</field>
		<field name="CSD.MARGIN.PIPS">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='fx_margin_n']/infra:value != '' and contains(b:userDefinedField[infra:name='order_type']/infra:value, 'NEG')">
					<xsl:value-of select="b:userDefinedField[infra:name='fx_margin_n']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.MARKET.RATE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value != ''">
					<xsl:value-of select="b:userDefinedField[infra:name='fx_market_rate_n']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<!-- <xsl:template name="BASE.CCY"/> -->
	<!-- END of protected area  -->
</xsl:stylesheet>
