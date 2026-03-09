<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsForex"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchPositionsForex" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiPositionsForex" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiPositionsForex" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">

	<xsl:template name="accountNetAmount">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="AccNetAmount">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="b:amountSold"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:amountBought"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<accountNetAmount>
			<xsl:value-of select="$AccNetAmount"/>
		</accountNetAmount>
	</xsl:template>
	<xsl:template name="account2">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Account2">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountRec"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountPay"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<account2>
			<infra:code>
				<xsl:value-of select="$Account2"/>
			</infra:code>
		</account2>
	</xsl:template>
	<xsl:template name="cashAccount">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Account">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountPay"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:ourAccountPayGroup[@index=1]/b:ourAccountRec"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<cashAccount>
			<infra:code>
				<xsl:value-of select="$Account"/>
			</infra:code>
		</cashAccount>
	</xsl:template>
	<xsl:template name="forward">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Instr">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="concat(b:currencyBought,'-',b:currencySold)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(b:currencySold,'-',b:currencyBought)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<forward>
			<infra:code>
				<xsl:choose>
					<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1'">
						<xsl:choose>
							<xsl:when test="b:tapRefId and b:tapRefId != ''">
								<xsl:value-of select="b:tapRefId"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$Instr"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</forward>
	</xsl:template>
	<xsl:template name="forwardRate">
		<forwardRate>
			<xsl:value-of select="b:forwardRate"/>
		</forwardRate>
	</xsl:template>
	<xsl:template name="nature">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Nature">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="'2'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'1'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<nature>
			<xsl:value-of select="$Nature"/>
		</nature>
	</xsl:template>
	<xsl:template name="operationDate">
		<operationDate>
			<xsl:call-template name="xsdate">
				<xsl:with-param name="date" select="b:dealDate"/>
			</xsl:call-template>
		</operationDate>
	</xsl:template>
	<xsl:template name="portfolio">
		<portfolio>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:portfolioNumber">
						<xsl:value-of select="concat(b:counterparty , '-' , b:portfolioNumber)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]">
								<xsl:value-of select="b:portfolioNoRecJoinGroup[@index=1]/b:portfolioNoRecJoinList/b:portfolioNoRecJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]">
								<xsl:value-of select="b:portfolioNoPayJoinGroup[@index=1]/b:portfolioNoPayJoinList/b:portfolioNoPayJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]">
								<xsl:value-of select="b:samHistIdRecJoinList/b:samHistIdRecJoin[@index=1]"/>
							</xsl:when>
							<xsl:when test="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]">
								<xsl:value-of select="b:samHistIdPayJoinList/b:samHistIdPayJoin[@index=1]"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="''"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</portfolio>
	</xsl:template>
	<xsl:template name="positionCode">
		<positionCode>
			<xsl:choose>
				<xsl:when test="b:tapRefId">
					<!-- order created on TAP -->
					<xsl:value-of select="b:tapRefId"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- order created on T24 -->
					<xsl:value-of select="b:id"/>
					<xsl:value-of select="$COMPANY_POSTFIX_SEPARATOR"/>
					<xsl:value-of select="b:companyMnemonicJoin"/>
				</xsl:otherwise>
			</xsl:choose>
		</positionCode>
	</xsl:template>
	<xsl:template name="quantity">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="Qty">
			<xsl:choose>
				<xsl:when test="$BuyOrSell = 'Sell'">
					<xsl:value-of select="b:amountBought"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="b:amountSold"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<quantity>
			<xsl:value-of select="$Qty"/>
		</quantity>
	</xsl:template>
	<xsl:template name="sourceCode">
		<sourceCode>
			<xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:companyMnemonicJoin)"/>
		</sourceCode>
	</xsl:template>
	<xsl:template name="spotRate">
		<spotRate>
			<xsl:value-of select="b:spotRate"/>
		</spotRate>
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
			<infra:code>
				<xsl:value-of select="'INITLOAD'"/>
			</infra:code>
		</type>
	</xsl:template>
	<xsl:template name="valueDate">
		<valueDate>
			<xsl:choose>
				<xsl:when test="b:valueDateBuy &lt; b:valueDateSell">
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="b:valueDateBuy"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="xsdate">
						<xsl:with-param name="date" select="b:valueDateSell"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</valueDate>
	</xsl:template>
	<xsl:template name="userDefinedField">
		<userDefinedField>
			<infra:name>ud_spot_value_d</infra:name>
			<infra:value>
				<xsl:call-template name="xsdate">
					<xsl:with-param name="date" select="b:spotDate"/>
				</xsl:call-template>
			</infra:value>
			<infra:type>date</infra:type>
		</userDefinedField>
	</xsl:template>
	<xsl:template name="mbFields"/>
	<xsl:template name="expirationDate"/>
	<xsl:template name="fxRateDirection">
		<fxRateDirection>
			<xsl:choose>
				<xsl:when test="b:tapFxRateDir = '0' or b:tapFxRateDir = '1'">
					<xsl:value-of select="b:tapFxRateDir"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
				</xsl:otherwise>
			</xsl:choose>
		</fxRateDirection>
	</xsl:template>
	<xsl:template name="fxClientRate">
		<xsl:if test="b:forwardRate != ''">
			<fxClientRate>
				<xsl:value-of select="b:forwardRate"/>
			</fxClientRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMarketRate">
		<xsl:if test="b:treasuryRate != ''">
			<fxMarketRate>
				<xsl:value-of select="b:treasuryRate"/>
			</fxMarketRate>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMargin">
		<xsl:if test="b:marginPips != ''">
			<fxMargin>
				<xsl:value-of select="b:marginPips"/>
			</fxMargin>
		</xsl:if>
	</xsl:template>
	<xsl:template name="fxMarginP">
		<xsl:if test="b:marginPerc != ''">
			<fxMarginP>
				<xsl:value-of select="b:marginPerc"/>
			</fxMarginP>
		</xsl:if>
	</xsl:template>
	<xsl:template name="initialLoadDate"/>
	<xsl:template name="positionCurrency"/>
	<xsl:template name="operationGrossAmount">
		<xsl:variable name="BuyOrSell">
			<xsl:choose>
				<xsl:when test="(b:tapRefId and b:tapOperNature = '2') or ( not(b:tapRefId) and b:baseCcy = b:currencyBought)">
					<xsl:value-of select="'Sell'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'Buy'"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<xsl:choose>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1' and $BuyOrSell = 'Buy'">
					<operationGrossAmount>
						<xsl:value-of select="b:amountBought"/>
					</operationGrossAmount>
				</xsl:when>
				<xsl:when test="$PCK_GL_FWD_TEMPLATE = '1' and $BuyOrSell = 'Sell'">
					<operationGrossAmount>
						<xsl:value-of select="b:amountSold"/>
					</operationGrossAmount>
				</xsl:when>
			</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
