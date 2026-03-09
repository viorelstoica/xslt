<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<!-- Global variables
-->
	<xsl:param name="THIRDPARTY_LEI_CODIFICATION" select="'PCK_MB_EUR_LEI'"/>
	<xsl:param name="PORTFOLIO_SYNONYM_CODIFICATION" select="'PCK_MB_EUR_FOLIO'"/>
	<xsl:param name="PORT_CODIFICATION" select="'PCK_MB_ESP_ALT_ID'"/>
	<xsl:param name="list_SubAssetType_T24AFBStatusChange" select="' 500 501 502 503 505 506 507 508 509 510 511 512 599 '"/>
	<xsl:param name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
	<xsl:param name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<xsl:param name="TRASPASO_IN" select="'IN'"/>
	<xsl:param name="internalTraspasos_TransactionCodeSell" select="'ITS'"/>
	<xsl:param name="internalTraspasos_TransactionCodeBuy" select="'ITB'"/>
	<xsl:param name="TRASPASO_REQUEST" select="'TRASPASO.REQUEST'"/>
	<xsl:param name="SOOTAP" select="'TAP'"/>
	<xsl:param name="transferTraspasoInTransactionType" select="'TWI'"/>
	<xsl:param name="transferTraspasoOutTransactionType" select="'TWO'"/>
	<xsl:param name="securityTransferInSupportedTypes" select="concat(' TRI UTI ETI CBY  ' ,$transferTraspasoInTransactionType)"/>
	<xsl:param name="securityTransferOutSupportedTypes" select="concat(' TRO UTO ETO CSL ',$transferTraspasoOutTransactionType)"/>
	<xsl:param name="list_operationSubtype_INTERFUND" select="' PCK_TCIB_INTER_SW_I PCK_TCIB_INTER_SW_O PCK_MB_ESP_TRA_EX_SI PCK_MB_ESP_TRA_EX_SO PCK_MB_ESP_TR_X_P_SO PCK_MB_ESP_TR_X_P_SI '"/>
	<xsl:param name="list_operationSubtype_INTRAFUND" select="' PCK_TCIB_INTRA_SW_I PCK_TCIB_INTRA_SW_O PCK_MB_ESP_TRA_IN_SI PCK_MB_ESP_TRA_IN_SO PCK_MB_ESP_TR_I_P_SI PCK_MB_ESP_TR_I_P_SO '"/>
	<xsl:param name="internalTraspasos_TAPSellType" select="'PCK_MB_ESP_TRASP_SWO'"/>
	<xsl:param name="internalTraspasos_TAPBuyType" select="'PCK_MB_ESP_TRASP_SWI'"/>
	<xsl:param name="transferOutTraspasos_WithdrawalType" select="'PCK_MB_ESP_TRASP_TRO'"/>
	<xsl:param name="list_TransCode_TransactionSecuritySell" select="' SEL SSL FRD SWO FSO MFR RDM CSL ITS '"/>
	<xsl:param name="list_TransCode_TransactionSecurityBuy"  select="' BUY SPR FPR SWI FSI MFP IPP CBY UPS ITB '"/>
	<xsl:param name="MANAGER_LEI_CODIFICATION" select="'PCK_MB_EUR_LEI_MGR'"/>
	<xsl:param name="NciCodeCUST" select="'PCK_MB_EUR_CUST'"/>
	<xsl:param name="NciCodeCCPT" select="'PCK_MB_EUR_CCPT'"/>
	<xsl:param name="NciCodeNIDN" select="'PCK_MB_EUR_NIDN'"/>
	<xsl:param name="NciCodeSOSE" select="'PCK_MB_EUR_SOSE'"/>
	<xsl:param name="NciCodeTXID" select="'PCK_MB_EUR_TXID'"/>
	<xsl:param name="NciCodeCONCAT" select="'PCK_MB_EUR_CONCAT'"/>
	<xsl:param name="ManagerNciCodeCUST" select="'PCK_MB_EUR_MGR_CUST'"/>
	<xsl:param name="ManagerNciCodeCCPT" select="'PCK_MB_EUR_MGR_CCPT'"/>
	<xsl:param name="ManagerNciCodeNIDN" select="'PCK_MB_EUR_MGR_NIDN'"/>
	<xsl:param name="ManagerNciCodeSOSE" select="'PCK_MB_EUR_MGR_SOSE'"/>
	<xsl:param name="ManagerNciCodeTXID" select="'PCK_MB_EUR_MGR_TXID'"/>
	<xsl:param name="ManagerNciCodeCONCAT" select="'PCK_MB_EUR_MGR_CONCAT'"/>


	<!--leDirectoryRegistrationStatusTranslation.-->

	<xsl:template name="leDirectoryRegistrationStatusTranslation">
		<xsl:param name="registrationStatus"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$registrationStatus = 'PENDING.VALIDATION'">1</xsl:when>
			<xsl:when test="$registrationStatus = 'ISSUED'">2</xsl:when>
			<xsl:when test="$registrationStatus = 'LAPSED'">3</xsl:when>
			<xsl:when test="$registrationStatus = 'MERGED'">4</xsl:when>
			<xsl:when test="$registrationStatus = 'RETIRED'">5</xsl:when>
			<xsl:when test="$registrationStatus = 'CANCELLED'">6</xsl:when>
			<xsl:when test="$registrationStatus = 'ANNULLED'">7</xsl:when>
			<xsl:when test="$registrationStatus = 'DUPLICATE'">8</xsl:when>
			<xsl:when test="$registrationStatus = 'TRANSFERRED'">9</xsl:when>
			<xsl:when test="$registrationStatus = 'PENDING.ARCHIVAL'">10</xsl:when>
			<xsl:when test="$registrationStatus = 'PENDING.TRANSFER'">11</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
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