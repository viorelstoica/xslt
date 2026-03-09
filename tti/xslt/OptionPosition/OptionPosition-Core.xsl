<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/OptionPosition" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
	<xsl:template name="deposit">
	<xsl:param name="positionIndex"/>
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				
				<deposit>
					<infra:code>
						<xsl:value-of select="translate(../b:secCustNoList/b:secCustNo[@index=$positionIndex],' ','')"/>
					</infra:code>
				</deposit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="historicalExchangeRate">
		<xsl:param name="positionIndex"/>
		<xsl:if test="../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin[@index=$positionIndex] and ../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin[@index=$positionIndex] !='' and ../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin[@index=$positionIndex] != '0' and ../b:PriTradeCostCcyDxTradeJoinList/b:PriTradeCostCcyDxTradeJoin[@index=$positionIndex] and ../b:PriTradeCostCcyDxTradeJoinList/b:PriTradeCostCcyDxTradeJoin[@index=$positionIndex] !='' and ../b:PriTradeCostCcyDxTradeJoinList/b:PriTradeCostCcyDxTradeJoin[@index=$positionIndex] !='0'">
			<historicalExchangeRate>
				<xsl:choose>
					<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
						<xsl:value-of select="format-number(../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin div ../b:PriTradeCostCcyDxTradeJoinList/b:PriTradeCostCcyDxTradeJoin[@index=$positionIndex],$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(../b:PriTradeCostCcyDxTradeJoinList/b:PriTradeCostCcyDxTradeJoin div ../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin[@index=$positionIndex],$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</historicalExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="historicalInstrExchRate"/>
	<xsl:template name="historicalPrice">
		<historicalPrice>
			<xsl:value-of select="b:txPrice"/>
		</historicalPrice>
	</xsl:template>
	<xsl:template name="initialLoadDate">
		<initialLoadDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</initialLoadDate>
	</xsl:template>

	<xsl:template name="instrument">
	<xsl:choose>
		<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC'">
			<instrument>
				<infra:code>
					<xsl:choose>
						<xsl:when test="../b:tapRefIdList/b:tapRefId">
							<xsl:value-of select="../b:tapRefIdList/b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:dxTradeIdList/b:dxTradeId,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonicCompanyJoin)"/>
							
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</instrument>
		</xsl:when>
		<xsl:otherwise>
			<xsl:variable name="Var_Barrier" select="substring-after(substring-after(../b:repPositionKey,':'),':')"/>
			<xsl:variable name="securityNo">
				<xsl:choose>
					<xsl:when test="$Var_Barrier">
						<xsl:value-of select="concat(../b:contract,'/',../b:currency,'/',../b:maturityDate,'/',../b:callPut,'/',../b:extStrikePri,'/',../b:deliveryCurrency,'/',../b:optionStyle,'/',../b:optionTypeGroup/b:optionType,'/',$Var_Barrier)"/>
					</xsl:when>
					<xsl:when test="$Var_Barrier='' and ../b:optionTypeGroup/b:optionType">
						<xsl:value-of select="concat(../b:contract,'/',../b:currency,'/',../b:maturityDate,'/',../b:callPut,'/',../b:extStrikePri,'/',../b:deliveryCurrency,'/',../b:optionStyle,'/',../b:optionTypeGroup/b:optionType)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(../b:contract,'/',../b:currency,'/',../b:maturityDate,'/',../b:callPut,'/',../b:extStrikePri,'/',../b:deliveryCurrency,'/',../b:optionStyle)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<instrument>
				<infra:code>
					<xsl:value-of select="$securityNo"/>
				</infra:code>
			</instrument>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	
	<xsl:template name="intermediary">
	<xsl:variable name="index" select="@index"/>
		<intermediary>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$CUSTOMER_PREFIX !=''">
						<xsl:choose>
							<xsl:when test="../../b:executingBrokerList/b:executingBroker[@index=$index]!=''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:executingBrokerList/b:executingBroker[@index=$index])"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:secCustNoList/b:secCustNo[@index=$index])"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="../../b:executingBrokerList/b:executingBroker[@index=$index]!=''">
								<xsl:value-of select="../../b:executingBrokerList/b:executingBroker[@index=$index]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../b:secCustNoList/b:secCustNo[@index=$index]"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</intermediary>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolio1"/>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="positionCode">
		<positionCode>
			<xsl:value-of select="concat(substring(b:transactionIds,'1','15'),$COMPANY_POSTFIX_SEPARATOR,../b:mnemonicCompanyJoin)"/>
		</positionCode>
	</xsl:template>
	<xsl:template name="positionCurrency">
		<positionCurrency>
			<infra:code>
				<xsl:value-of select="../b:currency"/>
			</infra:code>
		</positionCurrency>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:choose>
				<xsl:when test="b:txBuySell = 'SELL'">
					<xsl:value-of select="format-number(-1 * b:txLots,$decimalformat,'nan2zero')"/>
				</xsl:when>
				<xsl:when test="b:txBuySell = 'BUY'">
					<xsl:value-of select="b:txLots"/>
				</xsl:when>
			</xsl:choose>
		</quantity>
	</xsl:template>
	<xsl:template name="referenceNature">
		<referenceNature>
			<xsl:choose>
				<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and ../b:contractTypeList/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_ETD_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and ../b:contractTypeList/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_ETD_FUT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and ../b:contractTypeList/b:contractType = 'OPTION'">
					<xsl:value-of select="$DX_OTC_OPT_FUSION_RULE"/>
				</xsl:when>
				<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and ../b:contractTypeList/b:contractType = 'FUTURE'">
					<xsl:value-of select="$DX_OTC_FUT_FUSION_RULE"/>
				</xsl:when>
			</xsl:choose>
		</referenceNature>
	</xsl:template>
	<xsl:template name="referenceOperationCode">
		<referenceOperationCode>
			<xsl:if test="(../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and ../b:contractTypeList/b:contractType = 'OPTION' and $DX_ETD_OPT_FUSION_RULE ='23') or (../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'NORMAL' and ../b:contractTypeList/b:contractType = 'FUTURE' and $DX_ETD_FUT_FUSION_RULE ='22') or (../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and ../b:contractTypeList/b:contractType = 'OPTION' and $DX_OTC_OPT_FUSION_RULE ='23') or (../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC' and ../b:contractTypeList/b:contractType = 'FUTURE' and $DX_OTC_FUT_FUSION_RULE ='22') ">
				<xsl:value-of select="concat(substring(b:transactionIds,'1','15'),$COMPANY_POSTFIX_SEPARATOR,../b:mnemonicCompanyJoin)"/>
			</xsl:if>
		</referenceOperationCode>
	</xsl:template>
	<xsl:template name="sourceCode">
		<sourceCode>
			<xsl:value-of select="concat(substring(b:transactionIds,'1','15'),$COMPANY_POSTFIX_SEPARATOR,../b:mnemonicCompanyJoin)"/>
		</sourceCode>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
	</xsl:template>
	<xsl:template name="type">
		<type>
			<infra:code>INITLOAD</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="accruedInterests"/>
	<xsl:template name="historicalNetAmount"/>
	<xsl:template name="initialLoadPrice"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
	<xsl:template name="positionValueDate"/>
	<xsl:template name="bookExchangeRate"/>
	<xsl:template name="bookPrice"/>
	<xsl:template name="bookNetAmount"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
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