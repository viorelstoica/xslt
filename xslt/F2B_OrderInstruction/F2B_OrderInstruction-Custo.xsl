<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:t="http://www.odcgroup.com/F2B_FORMAT" xmlns:dxorder="http://www.temenos.com/T24/dxorder" xmlns:dxtrade="http://www.temenos.com/T24/dxtrade" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:adjustmentorder="http://www.temenos.com/T24/adjustmentorder" xmlns:secopenorder1="http://www.temenos.com/T24/secopenorder1" xmlns:secopenorder2="http://www.temenos.com/T24/secopenorder2" xmlns:secopenorder3="http://www.temenos.com/T24/secopenorder3" xmlns:secopenorder4="http://www.temenos.com/T24/secopenorder4" xmlns:sectrade="http://www.temenos.com/T24/sectrade" xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer" xmlns:securitytransfer2="http://www.temenos.com/T24/securitytransfer2" exclude-result-prefixes="b t" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="secopenorder1:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.TRADE.FLAG">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="'Yes'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'No'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.INV.REF">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_ord_inversis_ref_t']/infra:value"/>
		</field>
		<field name="CSD.STD.COM.AMT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='bank_fee_m']/infra:value,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<!-- Canadian markers -->
		<field name="CSD.FIX.BR.NO">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_nr_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.BR.LEI">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_lei_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.ACC.TY">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_account_type_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.REG.ID">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_reg_id_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.RT.IND">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '1'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<!-- End Of Canadian Markers -->
	</xsl:template>
	<xsl:template name="secopenorder1:CUST.NUMBER">
		<field name="CUST.NUMBER">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_customer_nr_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_customer_nr_c']/infra:value"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$CUSTOMER_PREFIX != ''">
							<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="b:client/infra:code"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.TRADE.FLAG">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="'Yes'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'No'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.INV.REF">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_ord_inversis_ref_t']/infra:value"/>
		</field>
		<field name="CSD.STD.COM.AMT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='bank_fee_m']/infra:value,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.FIX.BR.NO">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_nr_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.BR.LEI">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_lei_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.ACC.TY">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_account_type_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.REG.ID">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_reg_id_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.RT.IND">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '0'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '1'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:CUST.NUMBER">
		<field name="CUST.NUMBER">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_customer_nr_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_customer_nr_c']/infra:value"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="local-name() != 'attributes'">
							<xsl:choose>
								<xsl:when test="$CUSTOMER_PREFIX != ''">
									<xsl:value-of select="substring-after(b:client/infra:code,$CUSTOMER_PREFIX)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="b:client/infra:code"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<!-- BEG - For Format Based input which follows F2B_Format Schema -->
							<xsl:choose>
								<xsl:when test="$CUSTOMER_PREFIX != ''">
									<xsl:value-of select="substring-after(t:attribute[@name = 'ud_client_id'],$CUSTOMER_PREFIX)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="t:attribute[@name = 'ud_client_id']"/>
								</xsl:otherwise>
							</xsl:choose>
							<!-- END - For Format Based input which follows F2B_Format Schema -->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder3:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.TRADE.FLAG">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="'Yes'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'No'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="CSD.INV.REF">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_ord_inversis_ref_t']/infra:value"/>
		</field>
		<field name="CSD.STD.COM.AMT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='bank_fee_m']/infra:value,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.FIX.BR.NO">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_nr_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.BR.LEI">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_broker_lei_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.ACC.TY">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_account_type_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.REG.ID">
			<xsl:value-of select="b:userDefinedField[infra:name='ud_cm_reg_id_c']/infra:value"/>
		</field>
		<field name="CSD.FIX.RT.IND">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '0'">
					<xsl:value-of select="'no routing arrangement in place'"/>
				</xsl:when>
				<xsl:when test="b:userDefinedField[infra:name='ud_cm_routing_f']/infra:value = '1'">
					<xsl:value-of select="'routing arrangement in place'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="pecustomertxn:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="dxtrade:USERDEF.FIELDS">
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.STD.COM.AMT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='bank_fee_m']/infra:value,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
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
	</xsl:template>
	<xsl:template name="dxorder:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.STD.COM.AMT">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='order_fee_e']/infra:value != '0'">
					<xsl:value-of select="translate(b:userDefinedField[infra:name='bank_fee_m']/infra:value,',','')"/>
				</xsl:when>
			</xsl:choose>
		</field>
		<field name="CSD.MKT.PRI.KEY">
			<xsl:value-of select="b:security/infra:code"/>
		</field>
	</xsl:template>
	<xsl:template name="securitytransfer:USERDEF.FIELDS">
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
		<field name="CSD.TRADE.INSTR">
			<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:LIMIT.TYPE">
		<field name="LIMIT.TYPE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
						<xsl:when test="b:validityDate">
							<xsl:value-of select="'GTD'"/>
						</xsl:when>
						<xsl:when test="b:orderValidityType = '2'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'stp_order_e']= '0'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'order_limit_d']">
							<xsl:value-of select="'GTD'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'order_validity_nat_e'] = '2'">
							<xsl:value-of select="'GTC'"/>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder1:LIMIT.TYPE">
		<field name="LIMIT.TYPE">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='stp_order_e']/infra:value = '0'">
					<xsl:value-of select="'GTC'"/>
				</xsl:when>
				<xsl:when test="b:validityDate">
					<xsl:value-of select="'GTD'"/>
				</xsl:when>
				<xsl:when test="b:orderValidityType = '2'">
					<xsl:value-of select="'GTC'"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:CUST.ACC.NO">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:bulkChildIndicator != '2'">
					<field name="CUST.ACC.NO">
						<xsl:choose>
							<xsl:when test="b:remark = '1'">
								<xsl:value-of select="''"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="b:boPortfolio/infra:code != ''">
										<xsl:value-of select="b:boAccount/infra:code"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="b:currentAccount/infra:code"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!--  BEG - For Format Based input which follows F2B_Format Schema  -->
				<xsl:choose>
					<xsl:when test="b:remark = '1'">
						<xsl:value-of select="''"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="t:attribute[@name = 'boportfolioCode'] != ''">
								<field name="CUST.ACC.NO">
									<xsl:value-of select="t:attribute[@name = 'boAccountId']"/>
								</field>
							</xsl:when>
							<xsl:otherwise>
								<field name="CUST.ACC.NO">
									<xsl:value-of select="t:attribute[@name = 'accountCode']"/>
								</field>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				<!--  END - For Format Based input which follows F2B_Format Schema  -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder1:CUST.ACC.NO">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:bulkChildIndicator != '2'">
					<field name="CUST.ACC.NO">
						<xsl:value-of select="b:currentAccount/infra:code"/>
					</field>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="positiontransfer:USERDEF.FIELDS">
		<field name="CSD.TRADE.INSTR">
			<xsl:choose>
				<xsl:when test="b:userDefinedField[infra:name='remark_3_c']/infra:value != 'NULL'">
					<xsl:value-of select="b:userDefinedField[infra:name='remark_3_c']/infra:value"/>
				</xsl:when>
			</xsl:choose>
		</field>
	</xsl:template>
</xsl:stylesheet>
