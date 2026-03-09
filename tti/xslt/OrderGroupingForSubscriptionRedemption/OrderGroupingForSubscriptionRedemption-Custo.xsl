<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/OrderGroupingForSubscriptionRedemption" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiOrderGroupingForSubscriptionRedemption" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="infra:userDefinedField-custo">
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'ud_valuation_subs_d'"/>
			</infra:name>
			<infra:value>
				<xsl:if test="contains(b:id, '*FPR') and b:actCutOffDate!=''">
					<xsl:value-of select="concat(substring(b:actCutOffDate, 9, 2),'-',substring(b:actCutOffDate, 6, 2),'-',substring(b:actCutOffDate, 1, 4))"/>
				</xsl:if>
				<xsl:if test="contains(b:id, '*FPR')">
					<xsl:value-of select="concat(substring(b:cutOffFreq, 7, 2),'-',substring(b:cutOffFreq, 5, 2),'-',substring(b:cutOffFreq, 1, 4))"/>
				</xsl:if>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'ud_valuation_red_d'"/>
			</infra:name>
			<infra:value>
				<xsl:if test="contains(b:id, '*FRD') and b:actCutOffDate!=''">
					<xsl:value-of select="concat(substring(b:actCutOffDate, 9, 2),'-',substring(b:actCutOffDate, 6, 2),'-',substring(b:actCutOffDate, 1, 4))"/>
				</xsl:if>
				<xsl:if test="contains(b:id, '*FRD')">
					<xsl:value-of select="concat(substring(b:cutOffFreq, 7, 2),'-',substring(b:cutOffFreq, 5, 2),'-',substring(b:cutOffFreq, 1, 4))"/>
				</xsl:if>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'ud_exp_settlement_sub_d'"/>
			</infra:name>
			<infra:value>
				<xsl:if test="contains(b:id, '*FPR') and b:cutOffExpryDate!='' and b:cutOffExpryDate">
					<xsl:value-of select="concat(substring(b:cutOffExpryDate, 9, 2),'-',substring(b:cutOffExpryDate, 6, 2),'-',substring(b:cutOffExpryDate, 1, 4))"/>
				</xsl:if>
			</infra:value>
		</infra:userDefinedField>
		<infra:userDefinedField>
			<infra:name>
				<xsl:value-of select="'ud_exp_settlement_red_d'"/>
			</infra:name>
			<infra:value>
				<xsl:if test=" contains(b:id, '*FRD') and b:cutOffExpryDate!='' and b:cutOffExpryDate">
					<xsl:value-of select="concat(substring(b:cutOffExpryDate, 9, 2),'-',substring(b:cutOffExpryDate, 6, 2),'-',substring(b:cutOffExpryDate, 1, 4))"/>
				</xsl:if>
			</infra:value>
		</infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:userDefinedField">
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionBuy) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_subs_d'"/>
				</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="b:cutOffDate"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionBuy) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_time_subs_d'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="string-length(b:csdCutOffTim) = '5'">
							<xsl:value-of select="concat(b:csdCutOffTim,':00')"/>
						</xsl:when>
						<xsl:when test="string-length(b:csdCutOffTim) = '8'">
							<xsl:value-of select="b:csdCutOffTim"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionRed) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_red_d'"/>
				</infra:name>
				<infra:value>
					<xsl:call-template name="xsdateSepSlash">
						<xsl:with-param name="date" select="b:cutOffDate"/>
					</xsl:call-template>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
		<xsl:if test="contains(substring-after(b:id,'*'),$list_transactionCodes_SubscriptionRedemptionRed) or not(contains(b:id, '*'))">
			<infra:userDefinedField>
				<infra:name>
					<xsl:value-of select="'next_cutoff_time_red_d'"/>
				</infra:name>
				<infra:value>
					<xsl:choose>
						<xsl:when test="string-length(b:csdCutOffTim) = '5'">
							<xsl:value-of select="concat(b:csdCutOffTim,':00')"/>
						</xsl:when>
						<xsl:when test="string-length(b:csdCutOffTim) = '8'">
							<xsl:value-of select="b:csdCutOffTim"/>
						</xsl:when>
					</xsl:choose>
				</infra:value>
			</infra:userDefinedField>
		</xsl:if>
	</xsl:template>
	<!-- END of protected area  -->
</xsl:stylesheet>
