<?xml version="1.0" encoding="UTF-8"?>
<!--BEG - FIXONSITE - JPP20240306 - workaround for TSR-771504 - TTI - CashAccount - Wrong filter for Initial Load -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CashAccount" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchCashAccount" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCashAccount" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiCashAccount" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
<!--END - FIXONSITE - JPP20240306 - workaround for TSR-771504 - TTI - CashAccount - Wrong filter for Initial Load -->
	<!-- START of protected area  -->
	<!-- Do not change ! -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- END of protected area  -->
	<!-- Condition 1 -->
	<xsl:template match="b:CashAccount">
		<xsl:param name="IsSuspenseAccountCategoryVar">
			<xsl:call-template name="IsSuspenseAccountCategory">
				<xsl:with-param name="category" select="b:category"/>
			</xsl:call-template>
		</xsl:param>
		<xsl:apply-templates select="self::b:CashAccount[((b:category &gt;= '1001' and b:category &lt;= '1998' or b:category = '4002' or b:category = '4005' or b:category = '6009') and b:customerTypeCustomerSecurityJoinList/b:customerTypeCustomerSecurityJoin = 'CUSTOMER') or ($IsSuspenseAccountCategoryVar = 'true')]"
		                     mode="filter1"/>
	</xsl:template>

	<!-- Condition 2-->
	<xsl:template match="b:CashAccount" mode="filter1">
		<!--BEG - FIXONSITE - JPP20240306 - workaround for TSR-771504 - TTI - CashAccount - Wrong filter for Initial Load -->
		<xsl:apply-templates select="self::b:CashAccount[starts-with(b:eventCommon/ns0:transactionStage,'INITIAL-LOAD') or (../../c:CurrentEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]!='' and ../../c:PreviousEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]!='') or (not(../../c:CurrentEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]) and not(../../c:PreviousEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]))]" mode="filter-custo"/>
		<!--
		<xsl:apply-templates select="self::b:CashAccount[(../../c:CurrentEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]!='' and ../../c:PreviousEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]!='') or (not(../../c:CurrentEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]) and not(../../c:PreviousEvent/b:CashAccount/b:portfolioNoList/b:portfolioNo[1]))]" mode="filter-custo"/>
		-->
		<!--END - FIXONSITE - JPP20240306 - workaround for TSR-771504 - TTI - CashAccount - Wrong filter for Initial Load -->
  	</xsl:template>

	<!-- Custo placeholder -->
	<xsl:template match="b:CashAccount" mode="filter-custo">
		<xsl:apply-templates select="self::b:CashAccount" mode="filter-final"/>
	</xsl:template>

	<!-- Copy block -->
	<xsl:template match="b:CashAccount" mode="filter-final">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
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