<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PortfolioCashAccounts"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPortfolioCashAccounts" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPortfolioCashAccounts" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPortfolioCashAccounts" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- BEG - For accountNosGroup -->
	<xsl:template name="t1-infra-code">
		<xsl:variable name="index" select="./@index"/>
		<infra:code>
			<xsl:value-of select="b:accountNos"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="t1-infra-userDefinedField"/>
	<xsl:template name="t1-infra-mbFields"/>
	<xsl:template name="t1-portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="t1-active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="t1-subType">
		<xsl:variable name="index" select="./@index"/>
		<subType>
			<infra:code>
				<xsl:value-of select="concat(../b:accountNosCategoryJoinList/b:accountNosCategoryJoin[@index=number($index)],'_CAPITAL')"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="t1-infra-synonym"/>
	<xsl:template name="t1-infra-shortName"/>
	<xsl:template name="t1-infra-longName"/>
	<xsl:template name="t1-infra-multilingualLongName"/>
	<xsl:template name="t1-infra-notepad"/>
	<xsl:template name="t1-accrualRule"/>
	<xsl:template name="t1-accruedInterestCalculation"/>
	<xsl:template name="t1-accruedInterestRoundingRule"/>
	<xsl:template name="t1-accruedInterestRoundingUnit"/>
	<xsl:template name="t1-accruedInterestUnitaryRounding"/>
	<xsl:template name="t1-euroConversionDate"/>
	<xsl:template name="t1-euroConversionRule"/>
	<xsl:template name="t1-euroNewInstrument"/>
	<xsl:template name="t1-mainBusinessEntity"/>
	<xsl:template name="t1-priceCalculationRule"/>
	<xsl:template name="t1-referenceCurrency">
	<referenceCurrency>
		<xsl:variable name="index" select="./@index"/>
		<infra:code>
			<xsl:value-of select="b:accountCcy"/>
		</infra:code>
	</referenceCurrency>
	</xsl:template>
	<xsl:template name="t1-riskCountry"/>
	<xsl:template name="t1-riskNature"/>
	<xsl:template name="t1-taxCountry"/>
	<xsl:template name="t1-tradable"/>
	<xsl:template name="t1-type">
		<xsl:variable name="index" select="./@index"/>
		<type>
			<infra:code>
				<xsl:value-of select="../b:accountNosCategoryJoinList/b:accountNosCategoryJoin[@index=number($index)]"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="t1-valuationRule"/>
	<xsl:template name="t1-openingDate"/>
	<xsl:template name="t1-interestAccrualDate"/>
	<xsl:template name="t1-closingDate"/>
	<xsl:template name="t1-eomConvention"/>
	<xsl:template name="t1-client"/>
	<xsl:template name="t1-parentCashAccount"/>
	<xsl:template name="t1-witholdingTax"/>
	<xsl:template name="t1-suspenseAccount"/>
	<xsl:template name="t2-infra-code">
		<infra:code>
			<xsl:value-of select="b:accountNos"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="t2-infra-userDefinedField"/>
	<xsl:template name="t2-infra-mbFields"/>
	<xsl:template name="t2-portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select=" 'null' "/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="t2-active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="t2-subType">
		<xsl:variable name="index" select="./@index"/>
		<subType>
			<infra:code>
				<xsl:value-of select="concat(../b:accountNosCategoryJoinList/b:accountNosCategoryJoin[@index=number($index)],'_CAPITAL')"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="t2-infra-synonym"/>
	<xsl:template name="t2-infra-shortName"/>
	<xsl:template name="t2-infra-longName"/>
	<xsl:template name="t2-infra-multilingualLongName"/>
	<xsl:template name="t2-infra-notepad"/>
	<xsl:template name="t2-accrualRule"/>
	<xsl:template name="t2-accruedInterestCalculation"/>
	<xsl:template name="t2-accruedInterestRoundingRule"/>
	<xsl:template name="t2-accruedInterestRoundingUnit"/>
	<xsl:template name="t2-accruedInterestUnitaryRounding"/>
	<xsl:template name="t2-euroConversionDate"/>
	<xsl:template name="t2-euroConversionRule"/>
	<xsl:template name="t2-euroNewInstrument"/>
	<xsl:template name="t2-mainBusinessEntity"/>
	<xsl:template name="t2-priceCalculationRule"/>
	<xsl:template name="t2-referenceCurrency">
	<referenceCurrency>
		<infra:code>
			<xsl:value-of select="b:accountCcy"/>
		</infra:code>
	</referenceCurrency>
	</xsl:template>
	<xsl:template name="t2-riskCountry"/>
	<xsl:template name="t2-riskNature"/>
	<xsl:template name="t2-taxCountry"/>
	<xsl:template name="t2-tradable"/>
	<xsl:template name="t2-type"/>
	<xsl:template name="t2-valuationRule"/>
	<xsl:template name="t2-openingDate"/>
	<xsl:template name="t2-interestAccrualDate"/>
	<xsl:template name="t2-closingDate"/>
	<xsl:template name="t2-eomConvention"/>
	<xsl:template name="t2-client"/>
	<xsl:template name="t2-parentCashAccount"/>
	<xsl:template name="t2-suspenseAccount"/>
	<xsl:template name="t2-witholdingTax"/>
	<!-- END - For accountNosGroup -->
	<!-- BEG - For incAccountNoGroup -->
	<xsl:template name="t3-infra-code">
		<infra:code>
			<xsl:value-of select="b:incAccountNo"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="t3-portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:id"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="t3-active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="t3-subType">
		<xsl:variable name="index" select="./@index"/>
		<subType>
			<infra:code>
				<xsl:value-of select="concat(../b:incAccountNoCategoryJoinList/b:incAccountNoCategoryJoin[@index=number($index)],'_INCOME')"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="t3-infra-synonym"/>
	<xsl:template name="t3-infra-shortName"/>
	<xsl:template name="t3-infra-longName"/>
	<xsl:template name="t3-infra-multilingualLongName"/>
	<xsl:template name="t3-infra-notepad"/>
	<xsl:template name="t3-infra-userDefinedField"/>
	<xsl:template name="t3-infra-mbFields"/>
	<xsl:template name="t3-accrualRule"/>
	<xsl:template name="t3-accruedInterestCalculation"/>
	<xsl:template name="t3-accruedInterestRoundingRule"/>
	<xsl:template name="t3-accruedInterestRoundingUnit"/>
	<xsl:template name="t3-accruedInterestUnitaryRounding"/>
	<xsl:template name="t3-euroConversionDate"/>
	<xsl:template name="t3-euroConversionRule"/>
	<xsl:template name="t3-euroNewInstrument"/>
	<xsl:template name="t3-mainBusinessEntity"/>
	<xsl:template name="t3-priceCalculationRule"/>
	<xsl:template name="t3-referenceCurrency">
<referenceCurrency>
		<infra:code>
			<xsl:value-of select="b:incAccountCcy"/>
		</infra:code>
	</referenceCurrency>
	</xsl:template>

	<xsl:template name="t3-riskCountry"/>
	<xsl:template name="t3-riskNature"/>
	<xsl:template name="t3-taxCountry"/>
	<xsl:template name="t3-tradable"/>
	<xsl:template name="t3-type"/>
	<xsl:template name="t3-valuationRule"/>
	<xsl:template name="t3-openingDate"/>
	<xsl:template name="t3-interestAccrualDate"/>
	<xsl:template name="t3-closingDate"/>
	<xsl:template name="t3-eomConvention"/>
	<xsl:template name="t3-client"/>
	<xsl:template name="t3-parentCashAccount"/>
	<xsl:template name="t3-suspenseAccount"/>
	<xsl:template name="t3-witholdingTax"/>

	<xsl:template name="t4-infra-code">
		<infra:code>
			<xsl:value-of select="b:incAccountNo"/>
		</infra:code>
	</xsl:template>
	<xsl:template name="t4-portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select=" 'null' "/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="t4-active">
		<active>1</active>
	</xsl:template>
	<xsl:template name="t4-subType">
		<xsl:variable name="index" select="./@index"/>
		<subType>
			<infra:code>
				<xsl:value-of select="concat(../b:incAccountNoCategoryJoinList/b:incAccountNoCategoryJoin[@index=number($index)],'_INCOME')"/>
			</infra:code>
		</subType>
	</xsl:template>
	<xsl:template name="t4-infra-synonym"/>
	<xsl:template name="t4-infra-shortName"/>
	<xsl:template name="t4-infra-longName"/>
	<xsl:template name="t4-infra-multilingualLongName"/>
	<xsl:template name="t4-infra-notepad"/>
	<xsl:template name="t4-infra-userDefinedField"/>
	<xsl:template name="t4-infra-mbFields"/>
	<xsl:template name="t4-accrualRule"/>
	<xsl:template name="t4-accruedInterestCalculation"/>
	<xsl:template name="t4-accruedInterestRoundingRule"/>
	<xsl:template name="t4-accruedInterestRoundingUnit"/>
	<xsl:template name="t4-accruedInterestUnitaryRounding"/>
	<xsl:template name="t4-euroConversionDate"/>
	<xsl:template name="t4-euroConversionRule"/>
	<xsl:template name="t4-euroNewInstrument"/>
	<xsl:template name="t4-mainBusinessEntity"/>
	<xsl:template name="t4-priceCalculationRule"/>
	<xsl:template name="t4-referenceCurrency">
	<referenceCurrency>
		<infra:code>
			<xsl:value-of select="b:incAccountCcy"/>
		</infra:code>
	</referenceCurrency>
	</xsl:template>
	<xsl:template name="t4-riskCountry"/>
	<xsl:template name="t4-riskNature"/>
	<xsl:template name="t4-taxCountry"/>
	<xsl:template name="t4-tradable"/>
	<xsl:template name="t4-type"/>
	<xsl:template name="t4-valuationRule"/>
	<xsl:template name="t4-openingDate"/>
	<xsl:template name="t4-interestAccrualDate"/>
	<xsl:template name="t4-closingDate"/>
	<xsl:template name="t4-eomConvention"/>
	<xsl:template name="t4-client"/>
	<xsl:template name="t4-parentCashAccount"/>
	<xsl:template name="t4-suspenseAccount"/>
	<xsl:template name="t4-witholdingTax"/>
	<!-- END - For incAccountNoGroup -->
</xsl:stylesheet>