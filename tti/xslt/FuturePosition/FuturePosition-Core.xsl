<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FuturePosition" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFuturePosition"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFuturePosition" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFuturePosition"
                xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountExchangeRate">
		<xsl:if test="../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin and ../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin !='' and ../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin != '0' and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin !='' and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin !='0'">
			<accountExchangeRate>
				<xsl:choose>
					<xsl:when test="$boDefaultExch_Inverse_Flag = '0'">
						<xsl:value-of select="format-number(../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin div ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin,$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin div ../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin,$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</accountExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="cashAccount">
		<xsl:variable name="index" select="@index"/>
		<cashAccount>
			<infra:code>
				<xsl:value-of select="../b:priAccountGroup[@index = $index]/b:priAccountSubGroup/b:priAccount"/>
			</infra:code>
		</cashAccount>
	</xsl:template>
	<xsl:template name="deposit">
		<xsl:choose>
			<xsl:when test="$MapDepositDX = 'YES'">
				<xsl:variable name="index" select="@index"/>
				<deposit>
					<infra:code>
						<xsl:value-of select="../b:secCustNoList/b:secCustNo[@index = $index]"/>
					</infra:code>
				</deposit>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="future">
		<future>
			<infra:code>
			<xsl:choose>
				<xsl:when test="../b:exchangeTypeJoinList/b:exchangeTypeJoin = 'OTC'">
					<xsl:choose>
						<xsl:when test="../b:tapRefIdList/b:tapRefId and ../b:tapRefIdList/b:tapRefId != ''">
							<xsl:value-of select="../b:tapRefIdList/b:tapRefId"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat(../b:tradeIdList/b:tradeId,$COMPANY_POSTFIX_SEPARATOR,../b:mnemonicCompanyJoin)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(../b:contract,'/',../b:currency,'/',../b:maturityDate,'/',../b:callPut,'/',../b:extStrikePri,'/',../b:deliveryCurrency,'/',../b:optionStyle)"/>	
				</xsl:otherwise>
			</xsl:choose>
			</infra:code>
		</future>
	</xsl:template>
	<xsl:template name="initialLoadDate">
		<initialLoadDate>
			<xsl:value-of select="../b:eventCommon/ns0:today"/>
		</initialLoadDate>
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
	<xsl:template name="nature">
		<nature>
			<xsl:choose>
				<xsl:when test="b:txBuySell = 'SELL'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="b:txBuySell = 'BUY'">
					<xsl:value-of select="1"/>
				</xsl:when>
			</xsl:choose>
		</nature>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:value-of select="../b:portfolio"/>
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
	<xsl:template name="positionExchangeRate">
		<xsl:if test="../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin and ../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin !='' and ../b:CostSamCcyDxTradeJoinList/b:CostSamCcyDxTradeJoin != '0' and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin !='' and ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin !='0'">
			<positionExchangeRate>
				<xsl:choose>
					<xsl:when test="../b:PriAccCcyDxTradeJoinGroup/b:PriAccCcyDxTradeJoinSubGroup/b:PriAccCcyDxTradeJoin = ../b:ReferenceCurrencySecAccMasterJoinList/b:ReferenceCurrencySecAccMasterJoin and $boDefaultExch_Inverse_Flag = '0'">
						<xsl:value-of select="format-number(../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin div ../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin,$decimalformat,'nan2zero')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="format-number(../b:PriTradeCostDxTradeJoinList/b:PriTradeCostDxTradeJoin div ../b:CostAccCcyDxTradeJoinList/b:CostAccCcyDxTradeJoin,$decimalformat,'nan2zero')"/>
					</xsl:otherwise>
				</xsl:choose>
			</positionExchangeRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="price">
		<price>
			<xsl:value-of select="b:txPrice"/>
		</price>
	</xsl:template>
	<xsl:template name="quantity">
		<quantity>
			<xsl:value-of select="b:txLots"/>
		</quantity>
	</xsl:template>
	<xsl:template name="status">
		<status>
			<xsl:call-template name="statusTranslation">
				<xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
			</xsl:call-template>
		</status>
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
	<xsl:template name="type">
		<type>
			<infra:code>INITLOAD</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="instrumentExchangeRate"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="operationDate"/>
	<xsl:template name="positionCriteria1"/>
	<xsl:template name="positionCriteria2"/>
	<xsl:template name="positionCriteria3"/>
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
	<xsl:template name="valueDate"/>
</xsl:stylesheet>