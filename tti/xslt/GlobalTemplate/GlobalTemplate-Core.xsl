<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" exclude-result-prefixes="infra xhtml" version="1.0">
	<!-- Global variables
-->

	<!-- a single quote, if needed within variable values -->
	<xsl:variable name="singleQuote">'</xsl:variable>
	<xsl:variable name="PEWorkflowhandling">YES</xsl:variable>

	<!-- variables -->
	<!-- TTI-4690 - FXForward&StrategyChecks -->
	<xsl:param name="PCK_GL_FWD_TEMPLATE" select="'1'"/>
	<xsl:param name="CCYMARKET_PREFIX" select="'CCYMKT_'"/>
	<xsl:param name="Onlineval" select="'ENQUIRY.SELECT'"/>
	<xsl:param name="subAccountNature" select="'OMNIBUS'"/>
	<xsl:param name="PRICEPROV_PREFIX" select="'PRICEP_'"/>
	<xsl:param name="STOCKEXCH_PREFIX" select="'MKT_'"/>
	<xsl:param name="CUSTOMER_PREFIX" select="''"/>
	<xsl:param name="ISSUER_PREFIX" select="'ISS_'"/>
	<xsl:param name="DXSTOCKEXCH_PREFIX" select="''"/>
	<xsl:param name="COMPANY_POSTFIX_SEPARATOR" select="'_'"/>
	<!-- For TTI B2F-TransactionPaymentOrder.xlsx, tab PO_Sell -->
	<xsl:param name="POSTFIX_PORTYPE" select="''"/>
	<!-- For cash positions take on: Are we running in trade or value dated accounting -->
	<xsl:param name="VALUE_DATED_ACCOUNTING" select="'N'"/>
	<!-- The one and only company we accept currencies and currency exchange rates from -->
	<xsl:param name="TTI_CCY_COMPANY" select="''"/>
	<!-- parameters for mapping the currency exchange rate -->
	<xsl:param name="CCY_MARKETS_TO_MAP" select="'ALL'"/>
	<xsl:param name="CCY_MAP_BUY_SELL" select="'Y'"/>
	<!--  how to map reval rate, possible values are MAP_REVAL_IF_PRESENT or ONLY_REVAL_RATES -->
	<xsl:param name="CCY_MAP_REVAL_RATE" select="'MAP_REVAL_IF_PRESENT'"/>

    <!-- F2B - Default delivery instruction -->
    <xsl:param name="SC_DEFAULT_DELIVERY_INSTR" select="''"/>
	<!-- F2B - Auto authorise SC and DX trades YES or NO -->
	<xsl:param name="SC_AUTHORISE_TRADE" select="'YES'"/>
	<xsl:param name="DX_AUTO_AUTHORISE" select="'YES'"/>
	<!-- Whether the deposit should be mapped or not -->
	<xsl:param name="MapDepositDX" select="'YES'"/>
	<!-- Activate or not mapping of sensitive info -->
	<xsl:param name="MAP_SENSITIVE_DATA" select="'Y'"/>
	<!-- Seggregation corrective operation types  -->
	<xsl:param name="SC_SEGGREG" select="'SC_SEGGREG'"/>
	<!-- Multiplier used for the generation of the execution set criteria of Securities NDMA executions coming back from T24 -->
	<xsl:param name="SC_EXEC_MULTIPLIER" select="'100'"/>
    <!-- The status to set to an order if CANCEL.REMAIN.ORD is used -->
    <xsl:param name="SC_CANCEL_REMAIN_ORD_STATUS" select="'CANCELLED'"/>    
    <!-- The status to set to an order if CANCEL.REMAIN.ORD is used --> 
    <xsl:param name="SC_CASH_ORDER_CHG_STATUS_IF_T24_EXEC" select="''"/>   
 	
	<!-- TA Parameters
-->
	<!--Adding variables for calendar xsl-->
	<xsl:param name="HOLIDAY_START_YEAR" select="'2018'"/>
	<xsl:param name="HOLIDAY_END_YEAR" select="'2022'"/>
	<!-- Get current date
-->
	<!-- removed curDate and curDate2 variable refering the Jira- TTI-57 -->
	<!-- Get current date
-->
	<!-- settlementOrderType TTI F2B-OrderInstructionSingleBulkChild.xlsx for ORDER.TYPE Mapping-->
	<xsl:param name="settlementOrderType" select="'NO'"/>

	<!-- variable for NDF F2B    -->
	<xsl:param name="NDF_TYPE" select="'VANILLA'"/>
	<xsl:param name="NDF_AGREEMENT_TYPE" select="'ISDA'"/>
	<xsl:param name="NDF_DEALER_DESK" select="'01'"/>
	<!-- TTI F2B-NDFPurchaseOpening.xlsx and TTI F2B-NDFSaleOpening.xlsx -->
	<xsl:param name="ndSettlRateSource" select="'TWD01'"/>

	<!-- variable for TaxLots    -->
	<xsl:param name="TAX_CLASSIFICATION" select="'TAX_CLASSIF'"/>
	<xsl:param name="TAX_START_DATE" select="'2000-01-01'"/>

	<!-- Dx Trade FX OTC Options    -->
	<xsl:param name="FX_EXOTIC_OTC_SUPP_MSG" select="'SWIFT'"/>

	<!-- 
floatingConditionFilter : Filter on records in SECURITY.MASTER: extract only records that have the field SUB.ASSET.TYPE =:
-->
	<xsl:param name="floatingConditionFilter" select="'102'"/>
	<xsl:param name="floatingConditionFilterConvBond" select="'106'"/>
	<!--
filter for the security transfer mappings, the list of transaction types to cover
-->
	<xsl:param name="securityTransferInSupportedTypes" select="' TRI UTI ETI CBY OAB OWI LWI '"/>
	<xsl:param name="securityTransferOutSupportedTypes" select="' TRO UTO ETO CSL OAS OWO LWO '"/>
	<xsl:param name="securityTransfersWithoutPaymentDeliveryInstr" select="' FOP FRE '"/>
	<xsl:param name="peFundsTransferInTypes" select="' PEI '"/>
	<xsl:param name="peFundsTransferOutTypes" select="' PEO '"/>
	<xsl:param name="peFundsTransCodeBuy" select="' PEB '"/>
	<xsl:param name="peFundsTransCodeSell" select="' PES '"/>
	<xsl:param name="f2bSecurityTransferInType" select="' ETI '"/>
	<xsl:param name="f2bSecurityTransferOutType" select="' ETO '"/>
	<xsl:param name="f2bSecurityTransferFREDeliveryInstr" select="' FRE '"/>

	<!-- hist variable for SecurityTransfer and PositionTransfer    -->
	<xsl:param name="TAKE_HIST_VALUES_INV" select="'YES'"/>
	<xsl:param name="TAKE_HIST_VALUES_WITH" select="'YES'"/>

	<!-- TTI B2F-TransactionTransferActualSettlement.xlsx -->
	<xsl:param name="sectPendTransNamesInSupportedTypes" select="' TPI '"/>
	<xsl:param name="sectPendTransNamesOutSupportedTypes" select="' TPO '"/>

	<!--- Fusion Rule Parameters -->
	<xsl:param name="DX_ETD_OPT_FUSION_RULE" select="'23'"/>
	<xsl:param name="DX_OTC_OPT_FUSION_RULE" select="'23'"/>
	<xsl:param name="DX_ETD_FUT_FUSION_RULE" select="'22'"/>
	<xsl:param name="DX_OTC_FUT_FUSION_RULE" select="'22'"/>

	<!-- F2B versions used (with or without auto-authorization)-->
	<!-- f2b revoke functionality variable -->
	<xsl:param name="RevokeType" select="''"/>

	<!--
filter for the Fullpartialexecution mapping, IPO zero allotment
-->
	<xsl:param name="IPO_ZERO_ALOTMENT_ORDER_STATUS" select=" 'REJECTED' "/>
	<!-- IPO corp action event type -->
	<xsl:param name="IPO_CORP_ACT_EVENT_TYPE" select=" 'PCK_GL_IPO_EVENT' "/>
	<!-- IPO f2b transaction code -->
	<xsl:param name="IPO_TRANS_TYPE" select=" 'SC_IPP' "/>
	<!-- 
boDefaultLanguage : T24 Language used by default to retrieve shortname and 
longname
-->
	<xsl:param name="boDefaultLanguage" select="'GB'"/>
	<!--
boDefaultExch_Inverse_Flag : Triple'A Plus system parameter EXCH_INVERSE_FLAG
-->
	<xsl:param name="boDefaultExch_Inverse_Flag" select="'0'"/>
	<!--
securityPriceStartDate : Any price older than that date will not be loaded(e.g 2012-12-31)
-->
	<xsl:param name="securityPriceStartDate" select="'1967-08-14'"/>
	<!--
Portfolio and PortfolioThirdCompo: THIRDCOMPO_RELTYPE and THIRDCOMPO_GROUPID value is prefixed and suffixed with comma ','
-->
	<xsl:param name="THIRDCOMPO_RELTYPE" select="' OTHERS TAX '"/>
	<xsl:param name="THIRDCOMPO_GROUPID" select="' 111 222 555 '"/>
	<xsl:param name="PORT_CODIFICATION" select="'PCK_MB_ESP_ALT_ID'"/>
	<!--  
Transaction types to be excluded from handling by the FT cash debit and credit flows.
 -->
	<xsl:param name="FT_TRANS_TYPES_TO_EXCLUDE" select="' ACDI ACPD ACPO ACAR ACCS ACCT ACDS ACCR ACPP ACDF ACDP ACPD ACRP '"/>
	<!--
F2B versions used (with or without auto-authorization)
-->
	<xsl:param name="SecOpenOrderUpdateVersionNDMA" select="''"/>
	<xsl:param name="SecOpenOrderUpdateVersionDMA" select="'TAP'"/>
	<xsl:param name="SecOpenOrderSingleBulkChildVersion" select="'TAP'"/>
	<xsl:param name="SecOpenOrderIPOVersion" select="'IPO'"/>
	<xsl:param name="SecOpenOrderCancelledExpiredVersion" select="'TAP'"/>
	<xsl:param name="SecOpenOrderUpdateTapRefIdNDMA" select="'TAP'"/>
	<xsl:param name="SecOpenOrderUpdateTapRefIdDMA" select="''"/>
	<xsl:param name="ScB2FAcknowledgmentActive" select="'N'"/>
	<xsl:param name="DxOrderInstructionVersion" select="'TAP'"/>
	<xsl:param name="DxOrderInstructionTRADEOTCVersion" select="'TAP'"/>
	<xsl:param name="DxOrderCancelledExpiredVersion" select="'TAP.CANC'"/>
	<xsl:param name="ScExeSecOrdersExecEnrichmentVersion" select="'TAP.HOLD'"/>
	<xsl:param name="DxOrderEnrichmentVersion" select="'TAP'"/>
	<xsl:param name="DxB2FAcknowledgmentActive" select="'N'"/>
	<xsl:param name="ForexFXForwardPurchaseVersion" select="'TAP'"/>
	<xsl:param name="ForexFXForwardSaleVersion" select="'TAP'"/>
	<xsl:param name="ForexFXSpotPurchaseVersion" select="'TAP'"/>
	<xsl:param name="ForexFXSpotSaleVersion" select="'TAP'"/>
	<xsl:param name="ForexFXSwapPurchaseVersion" select="'TAP'"/>
	<xsl:param name="ForexFXSwapSaleVersion" select="'TAP'"/>
	<xsl:param name="PAYMENT_ORDER_VERSION" select="'TAP'"/>
	<xsl:param name="FD_OPEN_CONTRACT_VERSION" select="'TAP'"/>
    <xsl:param name="FD_F2B_SET_COUNTERPARTY" select="'Y'"/>	
	<xsl:param name="PeCustomerTxnInstructionVersion" select="'INPUT'"/>
	<xsl:param name="PeCustomerTxnCancelInstructionVersion" select="'INPUT'"/>
	<xsl:param name="SecurityTransferCancelSecurityVersion" select="''"/>
	<xsl:param name="PositionTransferCancelPositionVersion" select="''"/>
	<xsl:param name="SecTradeInstruction" select="'TAP'"/>
	<xsl:param name="OrderAdjustmentVersion" select="''"/>
	<xsl:param name="ScCustEventCreateVersion" select="'TAP'"/>
	<xsl:param name="ScExeSecOrdersTapAuthVersion" select="'TAP.AUTH'"/>
	<!-- Global Variable for TTI F2B-PTOrderInstruction.xlsx and TTI F2B-TransferManagementOrderInstruction.xlsx -->
	<xsl:param name="TAPIHLD" select="'SC.API.CREATE.REQUEST.TRANSFER.1.0.0'"/>
	<xsl:param name="orderNetting" select="'TAP'"/>

	<!-- Global Variable for  TTI F2B-OrderInstructionSingleBulkChild (Done for the Day)-->
	<xsl:param name="stpOrderFix" select="''"/>

	<!-- Global Variable for TTI F2B-FidEarlyMatReimburse.xlsx -->
	<xsl:param name="FD_EARLY_MAT_PENALTY_TYPE" select="'PENALCOMM'"/>
	<xsl:param name="FD_T24_RENEWAL_MODE" select="'AUTO'"/>

	<!-- F2B SyAccuDEcuOrderInstruction Global Variable for F2B Version -->
	<xsl:param name="SyAccuDecuVersion" select="''"/>
	<!-- F2B SyDciTciOrderInstruction Global Variable for F2B Version -->
	<xsl:param name="SyDciVersion" select="''"/>
	<!-- F2B SyPwfdTarkoOrderInstruction Global Variable for F2B Version -->
	<xsl:param name="SyFxForwardsVersion" select="''"/>

	<!-- TTI F2B-Washsales Global Variable for F2B Version -->
	<xsl:param name="CgWashSaleDetsVersion" select="'INPUT'"/>

	<!-- No versions for ND.DEAL -->
	<xsl:param name="NdDealNDForwardPurchaseVersion" select="'TAP'"/>
	<xsl:param name="NdDealNDForwardSaleVersion" select="'TAP'"/>
	<xsl:param name="POSTFIX_TROPTYPE" select="'N'"/>
	<xsl:param name="POSTFIX_FTOPTYPE" select="'N'"/>
	<xsl:param name="POSTFIX_AAGRPTYPE" select="'N'"/>
	<xsl:param name="POSTFIX_AAGRPSUBTYPE" select="'N'"/>

	<!-- AA_INTERFACE_INPUT_DEALS (values Y/N) decides on whether the instrument is created during input or funding/disbursement. -->
	<xsl:param name="AA_INTERFACE_INPUT_DEALS" select="'Y'"/>

	<!--
Added the USE_FIXING_DATE as per the Jira TTI-98
-->
	<xsl:param name="USE_FIXING_DATE" select="'NO'"/>
	<xsl:param name="FD_UNPLACED_ORDER_STATUS">
		<xsl:call-template name="statusTranslation">
			<xsl:with-param name="boStatus" select="'RECEIVED'"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="FD_POOLED_ORDER_STATUS">
		<xsl:call-template name="statusTranslation">
			<xsl:with-param name="boStatus" select="'PLACED'"/>
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="FD_CANC_STATUS">
		<xsl:call-template name="statusTranslation">
			<xsl:with-param name="boStatus" select="'CANCELLED'"/>
		</xsl:call-template>
	</xsl:param>

	<xsl:param name="DCI_VALUATION_RULE" select="'3'"/>

	<!-- CASH.CHRGS = NET TTI F2B-OrderInstructionSingleBulkChild -->
	<xsl:param name="CALCCHRGS_NET" select="'YES'"/>
	<xsl:param name="CASHROUNDING_NET" select="'UNDER/OVER'"/>
	<xsl:param name="ADJUSTCOMM_NET" select="'YES'"/>
	<xsl:param name="CALCCHRGSCASHORDER" select="'NO'"/>

	<!-- Values for T24 attribute TRANSACTION.TYPE for Spot/Forward/Swap -->
	<xsl:param name="FORWARD_TRANSACTION_TYPE" select="'FW'"/>
	<xsl:param name="SPOT_TRANSACTION_TYPE" select="'SP'"/>
	<xsl:param name="SWAP_TRANSCATION_TYPE" select="'SW'"/>

	<!-- F2B Cash Withdrawal/Investment Global Variables -->
	<xsl:param name="PAYMENT_ORDER_PRODUCT" select="'ACTRF'"/>

	<!-- Payment Order Notification OperationReversed -->
	<xsl:param name="PAYMENT_ORDER_STATUS_CANCELLED" select="'997'"/>
	<!-- Payment Order Notification OperationReversed-->
	<xsl:param name="PAYMENT_ORDER_STATUS_REVERSED" select="'993'"/>

	<!-- B2F Sy Master sub asset types -->
	<xsl:param name="SY_SAT_ACCU" select="'150'"/>
	<xsl:param name="SY_SAT_DECU" select="'151'"/>
	<xsl:param name="SY_SAT_DCI" select="'158'"/>
	<xsl:param name="SY_SAT_TCI" select="'159'"/>
	<xsl:param name="SY_SAT_FXFWD" select="'152'"/>
	<xsl:param name="SY_SAT_TARKO" select="'153'"/>

    <!-- B2F ACCU DECU balance positions for cash settlement -->
    <xsl:param name="SY_ACCUDECU_BP_TYPE_CAPITAL_PROFIT" select="'CAPITAL_PROFIT'"/>
    <xsl:param name="SY_ACCUDECU_BP_TYPE_CAPITAL_LOSS" select="'CAPITAL_LOSS'"/>
    
    
    
	<!-- B2F PositionTransfer PortfolioTranfer mapping quote variable  -->
	<xsl:param name="TRANSFER_PRICE_NATURE" select="'0'"/>


	<!-- F2B SyAccuDEcuOrderInstruction Global Variables -->
	<xsl:param name="SY_ACCUDECU_VARIANT" select="concat('ACCUDECU', $singleQuote, '_', $singleQuote, 'AGENCY.BOOKING')"/>
	<xsl:param name="SY_ACCUDECU_AGENCY_BOOKING" select="'Y'"/>
	<xsl:param name="SY_DCI_VARIANT" select="concat('DCI', $singleQuote, '_', $singleQuote, 'AGENCY.BOOKING')"/>
	<xsl:param name="SY_DCI_AGENCY_BOOKING" select="'Y'"/>
	<xsl:param name="SY_TCI_VARIANT" select="concat('DCI', $singleQuote, '_', $singleQuote, 'AGENCY.BOOKING')"/>
	<xsl:param name="SY_TCI_AGENCY_BOOKING" select="'Y'"/>
	<xsl:param name="SY_PFWD_VARIANT" select="concat('FXFORWARDS', $singleQuote, '_', $singleQuote, 'AGENCY.BOOKING')"/>
	<xsl:param name="SY_PFWD_AGENCY_BOOKING" select="'Y'"/>
	<xsl:param name="SY_TARKO_VARIANT" select="concat('FXFORWARDS', $singleQuote, '_', $singleQuote, 'AGENCY.BOOKING')"/>
	<xsl:param name="SY_TARKO_AGENCY_BOOKING" select="'Y'"/>
	<xsl:param name="SY_DEALER_DESK" select="''"/>
	<xsl:param name="SY_BP_CODE" select="'BANK_COMMISSION'"/>
	<xsl:param name="SY_OTC_FX_CONTRACT_CODE" select="''"/>

	<!-- B2F SubscriptionRedemption Global Variables -->
	<xsl:param name="list_transactionCodes_SubscriptionRedemptionBuy" select="'FPR'"/>
	<xsl:param name="list_transactionCodes_SubscriptionRedemptionRed" select="'FRD'"/>

	<!-- Multi entity related: Only to be used if CST files in T24 are NOT shared -->
	<xsl:param name="isCstShared" select="'Y'"/>
	<!-- The following list needs to be synced with the list in multi-entity.xml 
    Again, this is only required if the CST files are NOT shared
   -->
	<xsl:param name="nonCustomerFieldDefinitions" select="' 1500 1501 1503 1599 1600 1601 1699 3000 3001 3002 3003 3005 3499 9999 '"/>

	<!-- Customer Relation Spouce Values  -->
	<xsl:param name="origRelSpouse" select="' 13 '"/>

	<!-- Customer Relation Relative Values -->
	<xsl:param name="origRelOtherRelative" select="' 21 '"/>

	<!-- AA Company Mnemonic Enabled/Disable -->
	<xsl:param name="POSTFIX_AACOMNE" select="'Y'"/>

<!-- Structured product Instruments with operation subTypes that will use Securities Order instead of DX Order will be configured in the below param-->
	<xsl:param name="SP_SC_ORDERLIST" select="'PCK_TCIB_MFT'"/>

	<!--OrigRel Translation.-->
	<xsl:template name="origRelTranslation">
		<xsl:param name="origRelType"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="contains(concat(' ',$origRelSpouse,' '),concat(' ',$origRelType,' '))">42</xsl:when>
			<xsl:when test="contains(concat(' ',$origRelOtherRelative,' '),concat(' ',$origRelType,' '))">30</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
BPTranslation.
-->
	<xsl:template name="BPTranslation">
		<xsl:param name="boBP"/>
		<xsl:param name="defaultReturnBP" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$boBP = 'BP1'">FOREIGN_FEE</xsl:when>
			<xsl:when test="$boBP = 'BP2'">LOCAL_TAX</xsl:when>
			<xsl:when test="$boBP = 'BP3'">BROKER_COMMISSION</xsl:when>
			<xsl:when test="$boBP = 'BP4'">BANK_COMMISSION</xsl:when>
			<xsl:when test="$boBP = 'BP5'">STAMP_AND_COMM_TAX</xsl:when>
			<xsl:when test="$boBP = 'BP6'">SUBSCR_REDEMP</xsl:when>
			<xsl:when test="$boBP = 'BP7'">OTHER</xsl:when>
			<xsl:when test="$boBP = 'BP8'">DISCOUNT_REALLOW</xsl:when>
			<xsl:when test="$boBP = 'BP9'">WITH_TAX</xsl:when>
			<xsl:when test="$boBP = 'BP10'">RESERVE</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnBP"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--
checkPortfolioCondition
-->
	<xsl:template name="checkPortfolioCondition">
		<xsl:param name="xsltName"/>
		<xsl:param name="memoAccount"/>
		<xsl:param name="dealerBook"/>
		<xsl:param name="customerType"/>
		<xsl:param name="defaultReturn" select="'NotFound'"/>
		<!-- portfolioGroup1 - Allow if MEMO.ACCOUNT=NO,dealerBook empty and CustomerType is Customer -->
		<xsl:param name="portfolioGroup1">
			<!-- FD.FID.ORDER xslts -->
			<xsl:value-of select="' FinancialInstrumentFiduciaryInit TransactionFiduciaryTransfer TransactionFiduciaryInitiate PositionFiduciary PositionFiduciaryFWD FinancialInstrumentFiduciaryIL FiduciaryAccruedInterest FinInstrumentCloseFiduciaryCob '"/>
			<!-- SY.FX.FORWARDS xslts -->
			<xsl:value-of select="' FiPFOption FiPFCallOpt FiPFPutOpt FiPFVanillaOpt FiTarko FiTarkoCallOption FiTarkoPutOption FiTarkoVanillaOption TransactionSYFXOpenDerivativeBuy TransOpenSYFXDerivativeBuyRev TransactionSYTarkoOpenDerivativeBuy TransSYTarkoDerivativeBuyRev TransactionSYTarkoOpenDerivativeSell TransactionSYFXOpenDerivativeSell '"/>
			<!-- SY.DCI xslts -->
			<xsl:value-of select="' FinancialInstrumentSPDCI FinancialInstrumentSPDCIFX FinancialInstrumentSPDCIFX2 FinancialInstrumentSPDCIMM SyDciOpenDeposit SyDciReversal SyDCIForexSpotSale SyDCIDepositInterest SyDCICloseDeposit SyDCIPositions '"/>
			<!-- PAYMENT.ORDER xslts -->
			<xsl:value-of select="' TransactionPaymentOrderDebit TransactionPaymentOrderCredit TransactionPaymentOrderDebitRev TransactionPaymentOrderCreditRev '"/>
			<!-- PAYMENT.ORDER.NOTIFICATION,NEW xslts -->
			<xsl:value-of select="' TransactionPaymentOrderNotificationCredit TransactionPaymentOrderNotificationDebit '"/>
			<!-- FUNDS.TRANSFER xslts -->
			<xsl:value-of select="' FundsTransferTransactionCashCredit FundsTransferTransactionCashDebit FundsTransferTransactionCashCreditReversal FundsTransferTransactionCashDebitReversal '"/>
			<!-- DATA.CAPTURE xslts -->
			<xsl:value-of select="' DataCaptureTransactionCashCredit DataCaptureTransactionCashDebit '"/>
			<!-- TTI B2F-TransactionTransferActualSettlement.xlsx xslts -->
			<xsl:value-of select="' PTPtfToPtfInvActualSettlement1 PTPtfToPtfWithdrActualSettlement PTPortfolioTransferActualSettlement1 PTPortfolioTransferActualSettlement '"/>
		</xsl:param>
		<!-- portfolioGroup2 - Allow if MEMO.ACCOUNT=YES(Y),dealerBook empty and CustomerType is Customer -->
		<xsl:param name="portfolioGroup2">
			<xsl:value-of select="''"/>
		</xsl:param>
		<!-- portfolioGroup3 - Allow irrespective of memoAccount value,dealerBook empty and CustomerType is Customer -->
		<xsl:param name="portfolioGroup3">
			<!-- AccountClosure xslts -->
			<xsl:value-of select="' AccountClosure AccountClosureCOB '"/>
			<!-- Portfolio xslts -->
			<xsl:value-of select="' Portfolio PortfolioCashAccounts '"/>
			<!-- CorporateActions xslts -->
			<xsl:value-of select="' TransactionCashDividend TransactionCoaPurchase TransactionCoaSale TransactionConversion TransactionDecreaseInValue TransactionDecreaseInValuePL TransactionDistribution TransactionExchangeOffer TransactionFinalMaturity TransactionIncreaseInValue TransactionIncreaseInValuePL TransactionInterestPayment TransactionLapse TransactionMerger TransactionMultiCurrencyDividend TransactionOptionDividend TransactionReinvest TransactionRepurchase TransactionReverseStockSplit TransactionRightsDistribution TransactionRightsDistributionCOA TransactionSinkingRedemption TransactionSpinOff TransactionStockDividend TransactionStockSplit TransactionTaxRefund TransactionWarrantExercise TransactionOddlotEvent TransactionOffMarketBuyback TransactionSharePurchasePlan TransactionSaleNoticeOfRetentionTopUp TransactionRightsExecution TransactionSpinOffProp TransactionTakeoverMultipleSettlements TransactionWithholdingTaxBooking '"/>
			<!-- Maintain Portfolio Value xslt -->
			<xsl:value-of select="' MaintainPortfolioValue '"/>
			<!-- Derivatives xslts -->
			<xsl:value-of select="' TransactionOpenDerivativeBuy TransactionOpenDerivativeBuyReversal TransactionOpenDerivativeSell TransactionOpenDerivativeSellReversal TransactionSettleFutureBuy TransactionSettleFutureSell TransactionSettleOptionBuy TransactionSettleOptionSell '"/>
			<!-- Securities xslts -->
			<xsl:value-of select="' TransactionSecurityBuy TransactionSecurityBuyReversal TransactionSecuritySell TransactionSecuritySellReversal TransactionSecOpenOrder '"/>
			<!-- Locking-Unlocking-Transactions xslts -->
			<xsl:value-of select="' LockingTransaction UnlockingTransaction '"/>
			<!-- TTI B2F-TransactionTradeActualSettlement.xlsx xslts -->
			<xsl:value-of select="' SecTradeBuyActualSettlement SecTradeSellActualSettlement '"/>
			<!-- TTI F2B-OrderT24MarketPlacement.xlsx|TTI F2B-OrderExecutionFullPartial.xlsx|TTI F2B-OrderAcknowledgment.xlsx|TTI F2B-OrderT24CancelUpdateAcceptance.xlsx|TTI F2B-OrderT24Expiration.xlsx|TTI F2B-OrderT24Rejection.xlsx -->
			<xsl:value-of select="' T24StatusChange FullPartialExecution OrderAcknowledgment T24StatusChangeCancelUpdate '"/>
		</xsl:param>
		<!-- portfolioGroup4 - Allow if memoAccount != 'NO' or dealerBook present or CustomerType != 'CUSTOMER' - doesnot satisfy portfolio conditions -->
		<xsl:param name="portfolioGroup4">
			<!-- TTI B2F-TransactionTransferActualSettlement.xlsx xslts -->
			<xsl:value-of select="' PTPtfToPtfInvActualSettlement PTPtfToPtfWithdrActualSettlement1 '"/>
		</xsl:param>
		<xsl:param name="portfolioGroup5">
					<!-- TTI TPH xslts -->
			<xsl:value-of select="' TransactionPaymentIncomingTPH TransactionPaymentOutgoingTPH TransactionPaymentIncomingRevTPH TransactionPaymentOutgoingRevTPH '"/>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="contains($portfolioGroup1,concat(' ',$xsltName,' ')) and $memoAccount = 'NO' and ($dealerBook = '' or not($dealerBook)) and $customerType = 'CUSTOMER'">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:when test="contains($portfolioGroup2,concat(' ',$xsltName,' ')) and ($memoAccount = 'YES' or $memoAccount = 'Y') and ($dealerBook = '' or not($dealerBook)) and $customerType = 'CUSTOMER'">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:when test="contains($portfolioGroup3,concat(' ',$xsltName,' ')) and ($dealerBook = '' or not($dealerBook)) and $customerType = 'CUSTOMER'">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:when test="contains($portfolioGroup4,concat(' ',$xsltName,' ')) and ($memoAccount != 'NO' or ($dealerBook != '' and $dealerBook) or $customerType != 'CUSTOMER')">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:when test="contains($portfolioGroup5,concat(' ',$xsltName,' ')) and $memoAccount = 'NO' and ($dealerBook = '' or not($dealerBook)) and contains($customerType, 'CUSTOMER')">
				<xsl:value-of select="'true'"/> 
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--
extCustodianTranslation.
-->
	<xsl:template name="extCustodianTranslation">
		<xsl:param name="boExtCustodian"/>
		<xsl:param name="defaultReturn" select="'0'"/>
		<xsl:choose>
			<xsl:when test="$boExtCustodian = '111111'">1</xsl:when>
			<xsl:when test="$boExtCustodian = '222222'">2</xsl:when>
			<xsl:when test="$boExtCustodian = '333333'">3</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--
orderTypeTranslation.
-->
	<xsl:template name="orderTypeTranslation">
		<xsl:param name="orderType"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$orderType = 'LONG.CALL.SPREAD'">PCK_TCIB_LCALLSPREAD</xsl:when>
			<xsl:when test="$orderType = 'SHORT.CALL.SPREAD'">PCK_TCIB_SCALLSPREAD</xsl:when>
			<xsl:when test="$orderType = 'LONG.PUT.SPREAD'">PCK_TCIB_LPUTSPREAD</xsl:when>
			<xsl:when test="$orderType = 'SHORT.PUT.SPREAD'">PCK_TCIB_SPUTSPREAD</xsl:when>
			<xsl:when test="$orderType = 'LONG.COMBO'">PCK_TCIB_LCOMBO</xsl:when>
			<xsl:when test="$orderType = 'SHORT.COMBO'">PCK_TCIB_SCOMBO</xsl:when>
			<xsl:when test="$orderType = 'LONG.STRADDLE'">PCK_TCIB_LSTRADDLE</xsl:when>
			<xsl:when test="$orderType = 'SHORT.STRADDLE'">PCK_TCIB_SSTRADDLE</xsl:when>
			<xsl:when test="$orderType = 'LONG.STRANGLE'">PCK_TCIB_LSTRANGLE</xsl:when>
			<xsl:when test="$orderType = 'SHORT.STRANGLE'">PCK_TCIB_SSTRANGLE</xsl:when>
			<xsl:when test="$orderType = 'LONG.GUTS'">PCK_TCIB_LGUTS</xsl:when>
			<xsl:when test="$orderType = 'SHORT.GUTS'">PCK_TCIB_SGUTS</xsl:when>
			<xsl:when test="$orderType = 'LG.SYNTH.UNDERLYING'">PCK_TCIB_LSYNTH_UNDR</xsl:when>
			<xsl:when test="$orderType = 'SH.SYNTH.UNDERLYING'">PCK_TCIB_SSYNTH_UNDR</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
orderTypeTranslation.
-->
	<xsl:template name="orderTypeTranslationF2b">
		<xsl:param name="orderType"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$orderType = 'PCK_TCIB_LCALLSPREAD'">LONG.CALL.SPREAD</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SCALLSPREAD'">SHORT.CALL.SPREAD</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LPUTSPREAD'">LONG.PUT.SPREAD</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SPUTSPREAD'">SHORT.PUT.SPREAD</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LCOMBO'">LONG.COMBO</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SCOMBO'">SHORT.COMBO</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LSTRADDLE'">LONG.STRADDLE</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SSTRADDLE'">SHORT.STRADDLE</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LSTRANGLE'">LONG.STRANGLE</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SSTRANGLE'">SHORT.STRANGLE</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LGUTS'">LONG.GUTS</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SGUTS'">SHORT.GUTS</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_LSYNTH_UNDR'">LG.SYNTH.UNDERLYING</xsl:when>
			<xsl:when test="$orderType = 'PCK_TCIB_SSYNTH_UNDR'">SH.SYNTH.UNDERLYING</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:param name="dxStrategyTypes"
	           select="' PCK_TCIB_LCALLSPREAD PCK_TCIB_SCALLSPREAD PCK_TCIB_LPUTSPREAD PCK_TCIB_SPUTSPREAD PCK_TCIB_LCOMBO PCK_TCIB_SCOMBO PCK_TCIB_LSTRADDLE PCK_TCIB_SSTRADDLE PCK_TCIB_LSTRANGLE PCK_TCIB_SSTRANGLE PCK_TCIB_LGUTS PCK_TCIB_SGUTS PCK_TCIB_LSYNTH_UNDR PCK_TCIB_SSYNTH_UNDR '"/>
	<!--
statusTranslation.
-->
	<xsl:template name="statusTranslation">
		<xsl:param name="boStatus"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$boStatus = 'ACCOUNTED'">90</xsl:when>
			<xsl:when test="$boStatus = 'CANCELLED'">0</xsl:when>
			<xsl:when test="$boStatus = 'TOVALIDATE'">25</xsl:when>
			<xsl:when test="$boStatus = 'To validate'">25</xsl:when>
			<xsl:when test="$boStatus = 'RECEIVED'">45</xsl:when>
			<xsl:when test="$boStatus = 'REJECTED'">15</xsl:when>
			<xsl:when test="$boStatus = 'To send'">35</xsl:when>
			<xsl:when test="$boStatus = 'Sent'">40</xsl:when>
			<xsl:when test="$boStatus = 'SENT'">40</xsl:when>
			<xsl:when test="$boStatus = 'Placed'">70</xsl:when>
			<xsl:when test="$boStatus = 'PLACED'">70</xsl:when>
			<xsl:when test="$boStatus = 'EXECUTED'">80</xsl:when>
			<xsl:when test="$boStatus = 'EXPIRED'">5</xsl:when>
			<xsl:when test="$boStatus = 'PARTIALLY EXECUTED'">75</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
boAdjustmentNature.
-->
	<xsl:template name="boAdjustmentNature">
		<xsl:param name="boAdjNature"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$boAdjNature = 'PandL'">18</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
DIARY.TYPETranslation.
-->
	<!-- Global variables used for filtering -->
    <xsl:param name="g_filterCOAUsingGlobalTemplateFunction" select="'N'"/>
    <!-- Old diary type translation -->    	
<xsl:template name="diaryTypeTranslation">
		<xsl:param name="diaryType"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$diaryType = 'CASH.DIVIDENDS'">ACCUMINC CASH CASH.DIV CGT.DISTRIB DIVIDENDS EQUALISATION SHARE.PR.DIV PEFUNDDIST</xsl:when>
			<xsl:when test="$diaryType = 'STOCK.DIVIDENDS'">STOCK.DIV BONUS BONUS.SHARE CAPITALISATION</xsl:when>
			<xsl:when test="$diaryType = 'OPTION.DIVIDENDS'">SCRIP.DIV EUROPEAN.BONUS DRIPS STOCK.CASH DIV.OPTION</xsl:when>
			<xsl:when test="$diaryType = 'INTEREST'">INTEREST COUPON</xsl:when>
			<xsl:when test="$diaryType = 'FINAL.MAT'">REDEMPTION FINAL.MAT LIQUIDATION OPTIONAL.REDEM RIGHTS.SELL</xsl:when>
			<xsl:when test="$diaryType = 'EXCHANGE.OFFER'">EXCH.OFFER EXCH.CLASS STOCK.CONVERT SECURITY.SWITCH BOND.CONVERSION EQUAL.SHS TAKEOVER SEC.TRANSFER</xsl:when>
			<xsl:when test="$diaryType = 'CONVERSION'">ROLLUP WARRANT CONVERSION CONVERSION.VOLU OPTION.EXERCISE</xsl:when>
			<xsl:when test="$diaryType = 'STOCK.SPLIT'">STOCK.SPLIT</xsl:when>
			<xsl:when test="$diaryType = 'REV.STOCK.SPLIT'">REV.STOCK.SPLIT</xsl:when>
			<xsl:when test="$diaryType = 'SPIN.OFF'">SPIN.OFF DEMERGER DETACHMENT RIGHTS.DISTRIB</xsl:when>
			<xsl:when test="$diaryType = 'DECREASE.VALUE'">DECREASE.VALUE CAPITAL.RED.BDS</xsl:when>
			<xsl:when test="$diaryType = 'INCREASE.VALUE'">INSTAL.CALL</xsl:when>
			<xsl:when test="$diaryType = 'LAPSE'">LAPSE</xsl:when>
			<xsl:when test="$diaryType = 'MERGER'">MERGER.MAN CONSOLIDATION MERGER.VOL MERGER</xsl:when>
			<xsl:when test="$diaryType = 'REINVEST'">REINVEST REINVEST.DIV SUBSCR.OFFER</xsl:when>
			<xsl:when test="$diaryType = 'DISTRIBUTION'">DISTRIBUTION</xsl:when>
			<xsl:when test="$diaryType = 'REPURCHASE'">REPURCHASE</xsl:when>
			<xsl:when test="$diaryType = 'RIGHTS.DISTRIB.EXERCISE'">RIGHTS</xsl:when>
			<xsl:when test="$diaryType = 'RHTS.DIST.EXRI'">RHTS.DIST.EXRI</xsl:when>
			<xsl:when test="$diaryType = 'WARRANTS.EXERCISE'">WRTS.EXERCISE</xsl:when>
			<xsl:when test="$diaryType = 'SALE'">SALE</xsl:when>
			<xsl:when test="$diaryType = 'PURCHASE'">PURCHASE</xsl:when>
			<xsl:when test="$diaryType = 'TAX.REFUND'"/>
			<xsl:when test="$diaryType = 'PARTIAL.REDEM'">PARTIAL.REDEM</xsl:when>
			<xsl:when test="$diaryType = 'MULTI.CCY.DIVIDEND'">DIV.MULTICCY</xsl:when>
			<xsl:when test="$diaryType = 'ODDLOT'">ODDLOT</xsl:when>
			<xsl:when test="$diaryType = 'OFF.MKT.BUYBACK'">OFF.MKT.BUYBACK</xsl:when>
			<xsl:when test="$diaryType = 'SHARE.PUR.PLAN'">SHARE.PUR.PLAN</xsl:when>
			<xsl:when test="$diaryType = 'SH.SALE.FAC'">SH.SALE.FAC</xsl:when>
			<xsl:when test="$diaryType = 'SPIN.OFF.PROP'">SPIN.OFF.PROP</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
TransactionCode for Increase/Decrease value.
-->
	<xsl:template name="scBookCostTransactionCodeTranslation">
		<xsl:param name="transactionCode"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$transactionCode = 'COST_INCREASE'">DCP</xsl:when>
			<!-- Separate multiply codes by blanks, if any -->
			<xsl:when test="$transactionCode = 'COST_DECREASE'">DCR</xsl:when>
			<!-- Separate multiply codes by blanks, if any -->
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
 	 SECURITY.TRANS Trans Type selection. Must be separated by blank character.
	 	 -->
	<xsl:param name="SECURITY_TRANS_SELECTION" select="'BNR '"/>
	<!--
PRICE.SETTranslation.
-->
	<xsl:template name="priceSetTranslation">
		<xsl:param name="priceSet"/>
		<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$priceSet = 'CLOSING'">CLOSING</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturnStatus"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
languageTranslation: lookup table to store correspondance between the BO and the FO.
-->
	<xsl:template name="languageTranslation">
		<xsl:param name="boLanguage"/>
		<xsl:param name="defaultReturn" select="'NotFound'"/>
		<xsl:choose>
			<xsl:when test="$boLanguage = 'GB'">en</xsl:when>
			<xsl:when test="$boLanguage = 'FR'">fr</xsl:when>
			<xsl:when test="$boLanguage = 'DE'">de</xsl:when>
			<xsl:when test="$boLanguage = 'ES'">es</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- instrumentBusinessEntityComposition -->

	<xsl:template name="instrBusinessEntity">
		<xsl:param name="beAllowedCountry"/>
		<xsl:choose>
			<xsl:when test="$beAllowedCountry = 'SG'">SG0010001</xsl:when>
			<xsl:when test="$beAllowedCountry = 'GB'">GB0010001</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--
roundingunitTranslation: lookup table to store correspondance between the BO and the FO.
-->
	<xsl:template name="roundingunitTranslation">
		<xsl:param name="boRoundingunit"/>
		<xsl:choose>
			<xsl:when test="$boRoundingunit = '0'">5</xsl:when>
			<xsl:when test="$boRoundingunit = '1'">3</xsl:when>
			<xsl:when test="$boRoundingunit = '2'">1</xsl:when>
			<xsl:when test="$boRoundingunit = '3'">11</xsl:when>
			<xsl:when test="$boRoundingunit = '4'">13</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
EuroExchangeRate: lookup table to store EURO-IN Rate.
-->
	<xsl:template name="euroinRate">
		<xsl:param name="ISOcurrency"/>
		<xsl:choose>
			<xsl:when test="$ISOcurrency = 'ATS'">13.7603</xsl:when>
			<xsl:when test="$ISOcurrency = 'BEF'">40.3399</xsl:when>
			<xsl:when test="$ISOcurrency = 'CYP'">0.585274</xsl:when>
			<xsl:when test="$ISOcurrency = 'DEM'">1.95583</xsl:when>
			<xsl:when test="$ISOcurrency = 'EEK'">15.6466</xsl:when>
			<xsl:when test="$ISOcurrency = 'ESP'">166.386</xsl:when>
			<xsl:when test="$ISOcurrency = 'FIM'">5.94573</xsl:when>
			<xsl:when test="$ISOcurrency = 'FRF'">6.55957</xsl:when>
			<xsl:when test="$ISOcurrency = 'GRD'">340.75</xsl:when>
			<xsl:when test="$ISOcurrency = 'IEP'">0.787564</xsl:when>
			<xsl:when test="$ISOcurrency = 'ITL'">1936.27</xsl:when>
			<xsl:when test="$ISOcurrency = 'LUF'">40.3399</xsl:when>
			<xsl:when test="$ISOcurrency = 'LVL'">0.702804</xsl:when>
			<xsl:when test="$ISOcurrency = 'MCF'">6.55957</xsl:when>
			<xsl:when test="$ISOcurrency = 'MTL'">0.4293</xsl:when>
			<xsl:when test="$ISOcurrency = 'NLG'">2.20371</xsl:when>
			<xsl:when test="$ISOcurrency = 'PTE'">200.482</xsl:when>
			<xsl:when test="$ISOcurrency = 'SIT'">239.64</xsl:when>
			<xsl:when test="$ISOcurrency = 'SKK'">30.126</xsl:when>
			<xsl:when test="$ISOcurrency = 'SML'">1936.27</xsl:when>
			<xsl:when test="$ISOcurrency = 'VAL'">1936.27</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
EuroExchangeDate: lookup table to store EURO-IN Yielded date.
-->
	<xsl:template name="euroinDate">
		<xsl:param name="ISOcurrency"/>
		<xsl:choose>
			<xsl:when test="$ISOcurrency = 'ATS'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'BEF'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'CYP'">2008-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'DEM'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'EEK'">2011-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'ESP'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'FIM'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'FRF'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'GRD'">2001-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'IEP'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'ITL'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'LUF'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'LVL'">2014-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'MCF'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'MTL'">2008-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'NLG'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'PTE'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'SIT'">2007-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'SKK'">2009-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'SML'">1999-01-01</xsl:when>
			<xsl:when test="$ISOcurrency = 'VAL'">1999-01-01</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
date
-->
	<xsl:template name="xsdatetime">
		<xsl:param name="date"/>
		<xsl:variable name="year" select="substring($date,1,4)"/>
		<xsl:variable name="mo" select="substring($date,6,2)"/>
		<xsl:variable name="da" select="substring($date,9,2)"/>
		<xsl:variable name="hr" select="substring($date,11,2)"/>
		<xsl:variable name="min" select="substring($date,13,2)"/>
		<xsl:variable name="sec" select="substring($date,15,2)"/>
		<xsl:value-of select="$year"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$mo"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$da"/>
		<xsl:value-of select="'T'"/>
		<xsl:choose>
			<xsl:when test="$hr != ''">
				<xsl:value-of select="$hr"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'00'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$min != ''">
				<xsl:value-of select="$min"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="':00'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$sec != ''">
				<xsl:value-of select="$sec"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="':00'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="xsdatetimeNoSep">
		<xsl:param name="date"/>
		<xsl:variable name="year" select="substring($date,1,4)"/>
		<xsl:variable name="mo" select="substring($date,5,2)"/>
		<xsl:variable name="da" select="substring($date,7,2)"/>
		<xsl:variable name="hr" select="substring($date,9,2)"/>
		<xsl:variable name="min" select="substring($date,11,2)"/>
		<xsl:variable name="sec" select="substring($date,13,2)"/>
		<xsl:value-of select="$year"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$mo"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$da"/>
		<xsl:value-of select="'T'"/>
		<xsl:choose>
			<xsl:when test="$hr != ''">
				<xsl:value-of select="$hr"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="'00'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$min != ''">
				<xsl:value-of select="concat(':',$min)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="':00'"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="$sec != ''">
				<xsl:value-of select="concat(':',$sec)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="':00'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="xsdate">
		<xsl:param name="date"/>
		<xsl:variable name="year" select="substring($date,1,4)"/>
		<xsl:variable name="mo" select="substring($date,5,2)"/>
		<xsl:variable name="da" select="substring($date,7,2)"/>
		<xsl:value-of select="$year"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$mo"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$da"/>
	</xsl:template>
	<xsl:template name="mdate">
		<xsl:param name="date"/>
		<xsl:variable name="year" select="substring($date,2,3)"/>
		<xsl:variable name="mo" select="substring($date,5,2)"/>
		<xsl:variable name="da" select="substring($date,7,2)"/>
		<xsl:value-of select="concat('2',$year)"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$mo"/>
		<xsl:value-of select="'-'"/>
		<xsl:value-of select="$da"/>
	</xsl:template>
	<xsl:template name="xsdateSepSlash">
		<xsl:param name="date"/>
		<xsl:choose>
			<xsl:when test="contains($date,'-')">
				<xsl:variable name="da" select="substring($date,9,2)"/>
				<xsl:variable name="mo" select="substring($date,6,2)"/>
				<xsl:variable name="year" select="substring($date,1,4)"/>
				<xsl:value-of select="$da"/>
				<xsl:value-of select="'/'"/>
				<xsl:value-of select="$mo"/>
				<xsl:value-of select="'/'"/>
				<xsl:value-of select="$year"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="da" select="substring($date,7,2)"/>
				<xsl:variable name="mo" select="substring($date,5,2)"/>
				<xsl:variable name="year" select="substring($date,1,4)"/>
				<xsl:value-of select="$da"/>
				<xsl:value-of select="'/'"/>
				<xsl:value-of select="$mo"/>
				<xsl:value-of select="'/'"/>
				<xsl:value-of select="$year"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!--
        date: from T24 'numeric' data.time to date value with 4 digit year. NOTE: We use a static '20' prefix
-->
    <xsl:template name="t24DateTimeToDate">
        <xsl:param name="t24ProvidedDate"/>
        <xsl:variable name="yearT24DateTime" select="substring($t24ProvidedDate,1,2)"/>
        <xsl:variable name="moT24DateTime" select="substring($t24ProvidedDate,3,2)"/>
        <xsl:variable name="dayT24DateTime" select="substring($t24ProvidedDate,5,2)"/>
        <xsl:value-of select="'20'"/>
        <xsl:value-of select="$yearT24DateTime"/>
        <xsl:value-of select="$moT24DateTime"/>
        <xsl:value-of select="$dayT24DateTime"/>
    </xsl:template>


	<xsl:template name="t24DateTimeToDatePE">
        <xsl:param name="t24ProvidedDate"/>
        <xsl:variable name="yearT24DateTime" select="substring($t24ProvidedDate,1,2)"/>
        <xsl:variable name="moT24DateTime" select="substring($t24ProvidedDate,3,2)"/>
        <xsl:variable name="dayT24DateTime" select="substring($t24ProvidedDate,5,2)"/>
        <xsl:value-of select="'20'"/>
        <xsl:value-of select="$yearT24DateTime"/>
		<xsl:value-of select="'-'"/>
        <xsl:value-of select="$moT24DateTime"/>
		<xsl:value-of select="'-'"/>
        <xsl:value-of select="$dayT24DateTime"/>
    </xsl:template>	<!--
        date: from TAP formatted dates to T24 dates
-->
	<xsl:template name="t24Date">
		<xsl:param name="tapDate"/>
		<xsl:variable name="da" select="substring($tapDate,1,2)"/>
		<xsl:variable name="mo" select="substring($tapDate,4,2)"/>
		<xsl:variable name="year" select="substring($tapDate,7,4)"/>
		<xsl:value-of select="$year"/>
		<xsl:value-of select="$mo"/>
		<xsl:value-of select="$da"/>
	</xsl:template>
	<!--
        amount: Remove commas from any format based amount provided by TAP
-->
	<xsl:template name="t24Amount">
		<xsl:param name="tapAmount"/>
		<xsl:value-of select="translate($tapAmount, ',', '')"/>
	</xsl:template>



	<!--  padNumber : pad a number with a preceding zero if < 10 -->
	<xsl:template name="padNumber">
		<xsl:param name="number"/>
		<xsl:choose>
			<xsl:when test="string-length($number) = 1">
				<xsl:value-of select="concat('0', $number)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$number"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	OldNew Interest Rate Condition Managament
	-->
	<xsl:template name="OldNewInterestRateConditionManagment">
        <xsl:param name="CurrentEvent"/>
        <xsl:param name="PreviousEvent"/>

        <xsl:for-each select="$PreviousEvent/*[local-name() = 'interestRateGroup']">
            <xsl:variable name="index" select="./@index"/>
            <xsl:if test="
                         $PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name()='rateChDate'] and
                         $PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name()='rateChDate'] != '' and
                         $PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name()='interestRate'] and
                         $PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name()='interestRate'] != '' and
                         not($PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name()='rateChDate'] 
                                     = $CurrentEvent/*[local-name()='interestRateGroup']/*[local-name() = 'rateChDate'])">
                <interestSchedule mode="delete">
                    <interestRate>
                        <xsl:value-of select="./*[local-name() = 'interestRate']"/>
                    </interestRate>
                    <scheduledDate>
                        <xsl:value-of select="$PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name() = 'rateChDate']"/>
                    </scheduledDate>
                    <validityDate>
                        <xsl:value-of select="$PreviousEvent/*[local-name() = 'interestRateGroup'][@index=number($index)]/*[local-name() = 'rateChDate']"/>
                    </validityDate>
                </interestSchedule>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
	<!--
	OldNew Interest Floating Condition Managament
	-->
	<xsl:template name="OldNewFloatingConditionManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:if test="(($PreviousEvent/*[local-name() = 'interestKey'] and ($CurrentEvent/*[local-name() = 'interestKey']= '' or not($CurrentEvent/*[local-name() = 'interestKey']))) or ($CurrentEvent/*[local-name() = 'issueDate'] != $PreviousEvent/*[local-name() = 'issueDate'] ) or (($CurrentEvent/*[local-name() = 'interestKey'] != $PreviousEvent/*[local-name() = 'interestKey'] ) and ($CurrentEvent/*[local-name() = 'issueDate'] != $PreviousEvent/*[local-name() = 'issueDate'] )))">
			<floatingCondition mode="delete">
				<benchmark>
					<infra:code>
						<xsl:variable name="floatInstr">
							<xsl:choose>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '0.2'">60M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '1'">12M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '2'">06M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '3'">04M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '4'">03M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '6'">02M</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '12'">30D</xsl:when>
								<xsl:when test="$PreviousEvent/*[local-name() = 'noOfPayments'] = '13'">30D</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="concat(substring($PreviousEvent/*[local-name() = 'interestKey'],'1','5'),$floatInstr)"/>
					</infra:code>
				</benchmark>
				<xsl:if test="$PreviousEvent/*[local-name() = 'cpnRateSpread'] != '' and $PreviousEvent/*[local-name() = 'cpnRateSpread']">
					<spreadRate>
						<xsl:value-of select="$PreviousEvent/*[local-name() = 'cpnRateSpread']"/>
					</spreadRate>
				</xsl:if>
				<scheduledDate>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'issueDate']"/>
				</scheduledDate>
				<validityDate>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'issueDate']"/>
				</validityDate>
			</floatingCondition>
		</xsl:if>
	</xsl:template>
	<!--
OldNewSynonym managment
-->
	<xsl:template name="OldNewSynonymManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:if test="$PreviousEvent/*[local-name() = 'iSIN'] and ($CurrentEvent/*[local-name() = 'iSIN']= '' or not($CurrentEvent/*[local-name() = 'iSIN']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'iSIN']"/>
				</infra:code>
				<infra:codification>ISIN</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'euroclearNo'] and ($CurrentEvent/*[local-name() = 'euroclearNo']= '' or not($CurrentEvent/*[local-name() = 'euroclearNo']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'euroclearNo']"/>
				</infra:code>
				<infra:codification>EUROCLEAR</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'cedelNo'] and ($CurrentEvent/*[local-name() = 'cedelNo']= '' or not($CurrentEvent/*[local-name() = 'cedelNo']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'cedelNo']"/>
				</infra:code>
				<infra:codification>CEDEL</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'sedolNo'] and ($CurrentEvent/*[local-name() = 'sedolNo']= '' or not($CurrentEvent/*[local-name() = 'sedolNo']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'sedolNo']"/>
				</infra:code>
				<infra:codification>SEDOL</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'swissNo'] and ($CurrentEvent/*[local-name() = 'swissNo']= '' or not($CurrentEvent/*[local-name() = 'swissNo']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'swissNo']"/>
				</infra:code>
				<infra:codification>VALOR_TELEKURS</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'cusipNo'] and ($CurrentEvent/*[local-name() = 'cusipNo']= '' or not($CurrentEvent/*[local-name() = 'cusipNo']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'cusipNo']"/>
				</infra:code>
				<infra:codification>CUSIP</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$PreviousEvent/*[local-name() = 'SecuritySuppJoinTickerSymbol'] and ($CurrentEvent/*[local-name() = 'SecuritySuppJoinTickerSymbol']= '' or not($CurrentEvent/*[local-name() = 'SecuritySuppJoinTickerSymbol']) )">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="$PreviousEvent/*[local-name() = 'SecuritySuppJoinTickerSymbol']"/>
				</infra:code>
				<infra:codification>TICKER_SYMBOL</infra:codification>
			</infra:synonym>
		</xsl:if>
	</xsl:template>
	<xsl:template name="OldNewAltSecSynonymManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:call-template name="OldNewAltSec">
			<xsl:with-param name="AltSec"
			                select="$PreviousEvent/*[local-name() = 'altSecurityIdGroup'] [*[local-name() = 'altSecurityId'] = $CurrentEvent/*[local-name() = 'altSecurityIdGroup'][not(./*[local-name() = 'altSecurityNo'])]/*[local-name() = 'altSecurityId']]"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="OldNewAltSec">
		<xsl:param name="AltSec"/>
		<xsl:for-each select="$AltSec[./*[local-name() = 'altSecurityNo']][./*[local-name() = 'altSecurityNo']!='']">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="./*[local-name() = 'altSecurityNo']"/>
				</infra:code>
				<infra:codification>
					<xsl:value-of select="./*[local-name() = 'altSecurityId']"/>
				</infra:codification>
			</infra:synonym>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="OldNewAltAcctSynonymManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:call-template name="OldNewAltAcct">
			<xsl:with-param name="AltAcct"
			                select="$PreviousEvent/*[local-name() = 'altAcctTypeGroup'] [*[local-name() = 'altAcctType'] = $CurrentEvent/*[local-name() = 'altAcctTypeGroup'][not(./*[local-name() = 'altAcctId'])]/*[local-name() = 'altAcctType']]"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="OldNewAltAcct">
		<xsl:param name="AltAcct"/>
		<xsl:for-each select="$AltAcct[./*[local-name() = 'altAcctId']][./*[local-name() = 'altAcctId']!='']">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="./*[local-name() = 'altAcctId']"/>
				</infra:code>
				<infra:codification>
					<xsl:value-of select="./*[local-name() = 'altAcctType']"/>
				</infra:codification>
			</infra:synonym>
		</xsl:for-each>
	</xsl:template>
	<!-- Old/New alt id synonym management for derivatives coming from DX -->
	<xsl:template name="OldNewAltDerivativeSynonymManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:call-template name="OldNewAltDerivative">
			<xsl:with-param name="AltSec" select="$PreviousEvent/*[local-name() = 'altIndNameGroup'] [*[local-name() = 'altIndName'] = $CurrentEvent/*[local-name() = 'altIndNameGroup'][not(./*[local-name() = 'altIndId'])]/*[local-name() = 'altIndName']]"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="OldNewAltDerivative">
		<xsl:param name="AltSec"/>
		<xsl:for-each select="$AltSec[./*[local-name() = 'altIndId']][./*[local-name() = 'altIndId']!='']">
			<infra:synonym mode="delete">
				<infra:code>
					<xsl:value-of select="./*[local-name() = 'altIndId']"/>
				</infra:code>
				<infra:codification>
					<xsl:value-of select="./*[local-name() = 'altIndName']"/>
				</infra:codification>
			</infra:synonym>
		</xsl:for-each>
	</xsl:template>
	<!--
OldNew Deposit managment
-->
	<xsl:template name="OldNewDepositManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:if test="$PreviousEvent/*[local-name() = 'defaultDepository'] and ($CurrentEvent/*[local-name() = 'defaultDepository']= '' or not($CurrentEvent/*[local-name() = 'defaultDepository']) or $CurrentEvent/*[local-name() = 'defaultDepository'] != $PreviousEvent/*[local-name() = 'defaultDepository'] )">
			<InstrumentDeposit mode="delete">
				<xsl:attribute name="description">
					<xsl:value-of select="concat('GlobalTemplate-Core.xsl+', name($CurrentEvent/*), '+', $CurrentEvent/*[local-name() = 'eventCommon']/*[local-name() = 'eventId'], '+', $CurrentEvent/*[local-name() = 'eventCommon']/*[local-name() = 'creationTime'])"/>
				</xsl:attribute>
				<xsl:attribute name="sequenceNumber">
					<xsl:call-template name="calcSeqNum">
						<xsl:with-param name="creationTime">
							<xsl:value-of select="$CurrentEvent/*[local-name() = 'eventCommon']/*[local-name() = 'creationTime']"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
				<deposit>
					<infra:code>
						<xsl:value-of select="$PreviousEvent/*[local-name() = 'defaultDepository']"/>
					</infra:code>
				</deposit>
				<instrument>
					<infra:code>
						<xsl:value-of select="$PreviousEvent/*[local-name() = 'id']"/>
					</infra:code>
				</instrument>
			</InstrumentDeposit>
		</xsl:if>
	</xsl:template>
	<!--
OldNew Denomination managment without concat values,  for complex types that are refering to the denom type "multilingualLongName"
-->
	<xsl:template name="OldNewDenomManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:for-each select="$PreviousEvent[not(./@language = $CurrentEvent/@language)]">
			<multilingualLongName mode="delete">
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongName>
		</xsl:for-each>
	</xsl:template>
	<!--
OldNew Denomination managment for complex types that are refering to the denom type "multilingualLongname"
-->
	<xsl:template name="OldNewDenomManagment2">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:for-each select="$PreviousEvent[not(./@language = $CurrentEvent/@language)]">
			<multilingualLongname mode="delete">
				<language>
					<xsl:call-template name="languageTranslation">
						<xsl:with-param name="boLanguage" select="@language"/>
					</xsl:call-template>
				</language>
				<longName>
					<xsl:value-of select="."/>
				</longName>
			</multilingualLongname>
		</xsl:for-each>
	</xsl:template>
	<!--
OldNew PortfolioThirdCompo managment
-->
	<xsl:template name="OldNewPortfolioThirdCompoManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:for-each select="$PreviousEvent/*[local-name() = 'origPartyGroup']/*[local-name() = 'origPartyId'][not(. = $CurrentEvent/*[local-name() = 'origPartyGroup']/*[local-name() = 'origPartyId'])]">
			<xsl:variable name="index" select="../@index"/>
			<xsl:if test="$PreviousEvent/*[local-name() = 'origPartyIdCustomerTypeGroup'][./@index = $index]/*[local-name() = 'origPartyIdCustomerTypeList']/*[local-name() = 'origPartyIdCustomerType'] ='CUSTOMER'">
				<ownership mode="delete">
					<owner>
						<infra:code>
							<xsl:value-of select="concat($CUSTOMER_PREFIX,.)"/>
						</infra:code>
					</owner>
					<ownershipRule>
						<xsl:call-template name="ownershipRuleTemplate">
							<xsl:with-param name="groupId" select="$PreviousEvent/*[local-name() = 'groupId']"/>
						</xsl:call-template>
					</ownershipRule>
				</ownership>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!--
OldNew Denomination managment with concat values
-->
	<xsl:template name="OldNewDenomConcatManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:if test="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='GB'] !='' ">
			<infra:multilingualLongName mode="delete">
				<infra:language>
					<xsl:value-of select="'en'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='GB']">
						<xsl:value-of select="concat(.,' ')"/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='FR'] !='' ">
			<infra:multilingualLongName mode="delete">
				<infra:language>
					<xsl:value-of select="'fr'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='FR']">
						<xsl:value-of select="concat(.,' ')"/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
		<xsl:if test="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='DE'] !='' ">
			<infra:multilingualLongName mode="delete">
				<infra:language>
					<xsl:value-of select="'de'"/>
				</infra:language>
				<infra:longName>
					<xsl:for-each select="$PreviousEvent[not(./@language = $CurrentEvent/@language)][./@language='DE']">
						<xsl:value-of select="concat(.,' ')"/>
					</xsl:for-each>
				</infra:longName>
			</infra:multilingualLongName>
		</xsl:if>
	</xsl:template>
	<!--
synonym managment
-->
	<xsl:template name="SynonymManagment">
		<xsl:param name="structure"/>
		<xsl:if test="$structure/*[local-name() = 'iSIN'] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'iSIN']"/>
				</infra:code>
				<infra:codification>ISIN</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() = 'euroclearNo' ] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'euroclearNo']"/>
				</infra:code>
				<infra:codification>EUROCLEAR</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() = 'cedelNo' ] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'cedelNo']"/>
				</infra:code>
				<infra:codification>CEDEL</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() = 'sedolNo'] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'sedolNo']"/>
				</infra:code>
				<infra:codification>SEDOL</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() = 'swissNo'] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'swissNo']"/>
				</infra:code>
				<infra:codification>VALOR_TELEKURS</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() = 'cusipNo' ] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() = 'cusipNo']"/>
				</infra:code>
				<infra:codification>CUSIP</infra:codification>
			</infra:synonym>
		</xsl:if>
		<xsl:if test="$structure/*[local-name() ='SecuritySuppJoinTickerSymbol'] != ''">
			<infra:synonym>
				<infra:code>
					<xsl:value-of select="$structure/*[local-name() ='SecuritySuppJoinTickerSymbol']"/>
				</infra:code>
				<infra:codification>TICKER_SYMBOL</infra:codification>
			</infra:synonym>
		</xsl:if>
	</xsl:template>
	<!-- This template SectorManagment to be used for FiPMS schema only -->
	<xsl:template name="SectorManagment">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:param name="Codif"/>
		<xsl:if test="$CurrentEvent!= '' and ($PreviousEvent != $CurrentEvent or not ($PreviousEvent) )">
			<xsl:element name="sector" xmlns="http://www.odcgroup.com/FiPMS">
				<code>
					<xsl:value-of select="$CurrentEvent"/>
				</code>
				<codification>
					<xsl:value-of select="$Codif"/>
				</codification>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template name="SectorManagmentGICS">
		<xsl:param name="CurrentEvent"/>
		<xsl:param name="PreviousEvent"/>
		<xsl:param name="Codif"/>
		<xsl:param name="Today"/>
		<xsl:param name="GicsCode"/>
		<xsl:param name="CodifGics"/>
		<xsl:if test="$CurrentEvent!= '' and ($PreviousEvent != $CurrentEvent or not ($PreviousEvent) )">
			<xsl:element name="sector" xmlns="http://www.odcgroup.com/FiPMS">
				<code>
					<xsl:value-of select="$CurrentEvent"/>
				</code>
				<codification>
					<xsl:choose>
						<xsl:when test="not($GicsCode) or $GicsCode= 'NO'">
							<xsl:value-of select="$Codif"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$CodifGics"/>
						</xsl:otherwise>
					</xsl:choose>
				</codification>
				<validityDate>
					<xsl:value-of select="$Today"/>
				</validityDate>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template name="RatingManagment">
		<xsl:param name="structure"/>
		<xsl:param name="application"/>
		<xsl:choose>
			<xsl:when test="$application = 'CUSTOMER'">
				<xsl:if test="$structure/*[local-name() ='agencyIdList']!= ''">
					<xsl:for-each select="$structure/*[local-name() ='ratingDescGroup']/*[local-name() ='ratingDescList']/*[local-name() ='ratingDesc'][@language='GB']">
						<xsl:variable name="language" select="@language"/>
						<xsl:variable name="desc" select="."/>
						<xsl:variable name="curPos" select="../../@index"/>
						<xsl:if test="not(../../../../../*[local-name() ='PreviousEvent']/*[local-name() ='ratingDescGroup']/*[local-name() ='ratingDescList']/*[local-name() ='ratingDesc'][@language = $language] = $desc)">
							<xsl:element name="rating" xmlns="http://www.odcgroup.com/InfraPMS">
							<code>
								<xsl:value-of select="substring-before(.,'.')"/>
							</code>
							<agency>
								<xsl:value-of select="../../../*[local-name() ='agencyIdList']/*[local-name() ='agencyId'][@index = $curPos]"/>
							</agency>
							</xsl:element>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$structure/*[local-name() ='agencyIdList']!= ''">
					<xsl:for-each select="$structure/*[local-name() ='ratingDescGroup']/*[local-name() ='ratingDescList']/*[local-name() ='ratingDesc'][@language='GB']">
						<xsl:variable name="language" select="@language"/>
						<xsl:variable name="desc" select="."/>
						<xsl:variable name="curPos" select="../../@index"/>
						<xsl:if test="not(../../../../../*[local-name() ='PreviousEvent']/*[local-name() ='ratingDescGroup']/*[local-name() ='ratingDescList']/*[local-name() ='ratingDesc'][@language = $language] = $desc)">
							<xsl:element name="rating" xmlns="http://www.odcgroup.com/FiPMS">
							<code>
								<xsl:value-of select="substring-before(.,'.')"/>
							</code>
							<agency>
								<xsl:value-of select="../../../*[local-name() ='agencyIdList']/*[local-name() ='agencyId'][@index = $curPos]"/>
							</agency>
							</xsl:element>
						</xsl:if>
					</xsl:for-each>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	decimal number formats,
	format strings to use when writing out decimanl numbers,
	Nan converter to Zero.
	-->
	<xsl:decimal-format NaN="0" name="nan2zero"/>
	<xsl:param name="decimalformat" select="'0.##############'"/>
	<!--
		Operation status returns the current T24 file operation, based on 2 variables provided
		- the transactionStage field
		- the recordStatus field 
		 
	 -->
	<xsl:template name="operationStatus">
		<xsl:param name="transactionStage"/>
		<xsl:param name="recordStatus"/>
		<xsl:choose>
			<xsl:when test="$transactionStage = 'INPUT' and $recordStatus='INAU'">
				<xsl:value-of select="'INPUT-INPUT'"/>
			</xsl:when>
			<xsl:when test="$transactionStage = 'INPUT-DELETE'">
				<xsl:value-of select="'INPUT-DELETE'"/>
			</xsl:when>
			<xsl:when test="$transactionStage = 'HOLD-DELETE'">
				<xsl:value-of select="'HOLD-DELETE'"/>
			</xsl:when>
			<xsl:when test="($transactionStage = 'INPUT-AUTHORISE' or $transactionStage = 'INITIAL-LOAD.INPUT-AUTHORISE') and not($recordStatus)">
				<xsl:value-of select="'INPUT-AUTHORISE'"/>
			</xsl:when>
			<xsl:when test="$transactionStage = 'REVERSE' and $recordStatus='RNAU'">
				<xsl:value-of select="'REVERSE-INPUT'"/>
			</xsl:when>
			<xsl:when test="$transactionStage = 'REVERSE-DELETE'">
				<xsl:value-of select="'REVERSE-DELETE'"/>
			</xsl:when>
			<xsl:when test="($transactionStage='REVERSE-AUTHORISE' or $transactionStage = 'INITIAL-LOAD.REVERSE-AUTHORISE') and $recordStatus='REVE'">
				<xsl:value-of select="'REVERSE-AUTHORISE'"/>
			</xsl:when>
			<xsl:when test="$transactionStage='AUTHORISE' and not($recordStatus)">
				<xsl:value-of select="'AUTHORISE'"/>
			</xsl:when>
			<xsl:when test="$transactionStage='INPUT-HOLD' and $recordStatus='IHLD'">
				<xsl:value-of select="'INPUT-HOLD'"/>
			</xsl:when>
			<xsl:when test="$transactionStage='JOB-PROCESS'">
				<xsl:value-of select="'JOB-PROCESS'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
	ClientPMS.xsd OwnershipRule enumerated values
	Portfolio Third Composition
	-->
	<xsl:template name="ownershipRuleTemplate">
		<xsl:param name="groupId"/>
		<xsl:choose>
			<xsl:when test="$groupId = '111'">
				<xsl:value-of select="'101'"/>
			</xsl:when>
			<xsl:when test="$groupId = '222'">
				<xsl:value-of select="'102'"/>
			</xsl:when>
			<xsl:when test="$groupId = '555'">
				<xsl:value-of select="'105'"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--
LombardWeights: PledgedCreditRate and PledgedDebitRate value
-->
	<xsl:param name="pledgedCreditRate" select="'50'"/>
	<xsl:param name="pledgedDebitRate" select="'51'"/>
	<!-- AA: Validation of custo additional criterias for xml generation. -->
	<!-- must return '1' when condition is true or when no custo condition, otherwise must return '0' -->
	<xsl:template name="aaCustoAdditionalSelectionCriteria">
		<xsl:value-of select="'1'"/>
		<!-- by default -->
	</xsl:template>
	<!--Template to write Fees and Taxes part for Fiduciary-->
	<xsl:template name="printFiduciaryFeesFeesAndTaxes">
		<xsl:param name="amount"/>
		<xsl:param name="cashExtractionBPType"/>
		<xsl:param name="currency"/>
		<!-- Avoid empty values when 0 -->
		<xsl:variable name="decimalformatZ" select="'0.########################################'"/>
		<!-- Ensure parameter values are not NaN -->
		<xsl:variable name="amountNb">
			<xsl:value-of select="format-number(-1 * ($amount),$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP1'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP2'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP3'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:choose>
					<xsl:when test="$cashExtractionBPType = 'FD_COMMISSION' or $cashExtractionBPType = 'FD_CHARGE'">
						<xsl:value-of select="$amountNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP4'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP5'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:choose>
					<xsl:when test="$cashExtractionBPType = 'FD_TAX'">
						<xsl:value-of select="$amountNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP6'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP8'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP9'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter xmlns="http://www.odcgroup.com/TransactionPMS">>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP10'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<!-- End of template printFiduciaryFeesFeesAndTaxes -->
	<!--Template to write Fees and Taxes part for LD-->
	<xsl:template name="printLDCommAndChrgFeesAndTaxes">
		<xsl:param name="amount"/>
		<xsl:param name="cashExtractionBPType"/>
		<xsl:param name="currency"/>
		<!-- Avoid empty values when 0 -->
		<xsl:variable name="decimalformatZ" select="'0.########################################'"/>
		<!-- Ensure parameter values are not NaN -->
		<xsl:variable name="amountNb">
			<xsl:value-of select="format-number(-1 * ($amount),$decimalformatZ,'nan2zero')"/>
		</xsl:variable>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP1'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP2'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP3'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:choose>
					<xsl:when test="$cashExtractionBPType = 'LD_COMMISSION' or $cashExtractionBPType = 'LD_CHARGE'">
						<xsl:value-of select="$amountNb"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'0'"/>
					</xsl:otherwise>
				</xsl:choose>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP4'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP5'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP6'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP7'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP8'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP9'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
		<transactionFeesTaxesCounter>
			<amount>
				<xsl:value-of select="'0'"/>
			</amount>
			<currency>
				<infra:code>
					<xsl:value-of select="$currency"/>
				</infra:code>
			</currency>
			<type>
				<infra:code>
					<xsl:call-template name="BPTranslation">
						<xsl:with-param name="boBP" select="'BP10'"/>
					</xsl:call-template>
				</infra:code>
			</type>
		</transactionFeesTaxesCounter>
	</xsl:template>
	<!-- End of template printLDCommAndChrgFeesAndTaxes -->
	<!-- SY fixing frequency template -->
	<xsl:template name="sySetFixingFrequency">
		<xsl:param name="fixingDate"/>
		<xsl:param name="fixingFrequency"/>
		<xsl:param name="fixingFrequencyUnit"/>

		<xsl:choose>
			<xsl:when test="$fixingDate and $fixingFrequency">
				<xsl:variable name="fixDate">
					<xsl:call-template name="t24Date">
						<xsl:with-param name="tapDate" select="$fixingDate"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$fixingFrequencyUnit = '1'">
						<xsl:value-of select="concat($fixDate,'DAILY')"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '2'">
						<xsl:value-of select="concat($fixDate,'BSNSS')"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '3'">
						<xsl:value-of select="concat($fixDate,'WEEK', $fixingFrequency)"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '4'">
						<xsl:variable name="fixFrequency">
							<xsl:call-template name="padNumber">
								<xsl:with-param name="number" select="$fixingFrequency"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat($fixDate,'M', $fixFrequency, '01')"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '5'">
						<xsl:variable name="fixFrequency">
							<xsl:call-template name="padNumber">
								<xsl:with-param name="number" select="3 * $fixingFrequency"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat($fixDate,'M', $fixFrequency, '01')"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '6'">
						<xsl:variable name="fixFrequency">
							<xsl:call-template name="padNumber">
								<xsl:with-param name="number" select="6 * $fixingFrequency"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat($fixDate,'M', $fixFrequency, '01')"/>
					</xsl:when>
					<xsl:when test="$fixingFrequencyUnit = '7'">
						<xsl:variable name="fixFrequency">
							<xsl:call-template name="padNumber">
								<xsl:with-param name="number" select="12 * $fixingFrequency"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat($fixDate,'M', $fixFrequency, '01')"/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<!-- this should not happen, no fixing date/freq provided -->
				<xsl:value-of select="'NO_FIXING_DATE_OR_FREQ_PROVIDED_BY_TAP'"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--  End SY fixing frequency template -->

	<!-- SY map back t24 fixing frequency to TAP payment fixing date / payment freq / payment freq unit 
  
  Possible frequencies from T24
	       	20180425DAILY - Daily
			20180425BSNSS - Business Day
			20180501WEEK<n> - Every <n> weeks
			20180425TWMTH - Twice monthly
			20180425M<nn><mm> - Every <nn> month, on the <mm>th
			20180425LHFYR - Last Day of this Mid Year
			20180430LMNTH - Last Day of this Month
			20180430LQUAT - Last Day of this Quarter
			20180430LWEEK - Last Day of this Week
    		20180430LYEAR - Last Day of this Year
		
            not supported are the special cases  LHFYR LMNTH LQUAT LWEEK LYEAR
            
  -->
	<xsl:template name="sySetTapFixingDate">
		<xsl:param name="t24FixingFrequency"/>
		<xsl:call-template name="xsdate">
			<xsl:with-param name="date" select="translate(substring($t24FixingFrequency, 1, 8),'-','')"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="sySetTapPaymentFrequency">
		<xsl:param name="t24FixingFrequency"/>
		<xsl:choose>
			<xsl:when test="contains($t24FixingFrequency, 'DAILY')">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'BSNSS')">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'WEEK')">
				<!--  get the last digits behind the 'M' and remove the preceding '0' if present -->
				<xsl:variable name="everyNthWeek">
					<xsl:value-of select="substring(substring-after($t24FixingFrequency, 'WEEK'), 1, 2)"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="starts-with($everyNthWeek, '0')">
						<xsl:value-of select="substring-after($everyNthWeek, '0')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$everyNthWeek"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency,'TWMTH')">
				<xsl:value-of select="2"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'M') and not (contains($t24FixingFrequency, 'LMNTH'))">
				<!--  get the last digits behind the 'M' and remove the preceding '0' if present -->
				<xsl:variable name="everyNthMonth">
					<xsl:value-of select="substring(substring-after($t24FixingFrequency, 'M'), 1, 2)"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="starts-with($everyNthMonth, '0')">
						<xsl:value-of select="substring-after($everyNthMonth, '0')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$everyNthMonth"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="sySetTapPaymentFrequencyUnit">
		<xsl:param name="t24FixingFrequency"/>
		<xsl:choose>
			<xsl:when test="contains($t24FixingFrequency, 'DAILY')">
				<xsl:value-of select="1"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'BSNSS')">
				<xsl:value-of select="2"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'WEEK') or contains($t24FixingFrequency,'TWMTH')">
				<xsl:value-of select="3"/>
			</xsl:when>
			<xsl:when test="contains($t24FixingFrequency, 'M') and not (contains($t24FixingFrequency, 'LMNTH'))">
				<xsl:value-of select="4"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<!-- Global template used for filtering SuspenseAccountCategories list_SuspenseAccountCategories -->
	<xsl:template name="IsSuspenseAccountCategory">
		<xsl:param name="category"/>
		<xsl:param name="defaultReturn" select="'NotFound'"/>
		<!-- Mention the sarting number and ending number of range of categories here-->
		<xsl:param name="strtCategory" select="'14000'"/>
		<xsl:param name="endCategory" select="'14999'"/>
		<xsl:choose>
			<xsl:when test="$category and $category != '' and $category &gt;= $strtCategory and $category &lt;= $endCategory">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Global variables used for filtering -->
<!-- Be flexible when we determine what security pays irregular coupons 
        the example rules has irregular coupons for instruments that are FRNs - they have an interestKey
    -->
    <xsl:template name="irregularCoupon">
        <xsl:choose>
            <xsl:when test="./*[local-name() = 'interestKey'] and $g_filterBySubAssetType ='N'">Y</xsl:when>
            <xsl:otherwise>N</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!--  g_filterBySubAssetType - defined whether we use the old sub asset type rules to filter/decide -->
    <xsl:param name="g_filterBySubAssetType" select="'N'"/>
	<xsl:param name="list_SubAssetType_ChronoDataUnpaidPercentage" select="' 106 100 101 102 103 104 105 199 '"/>
	<xsl:param name="list_SubAssetType_ChronologicalData" select="' 106 100 101 102 103 104 105 199 300 301 302 303 320 350 399 '"/>
	<xsl:param name="list_ArrStatus_Activ_DepositsLoansFloatingCondition" select="' AUTH AUTH-FWD CURRENT EXPIRED '"/>
	<xsl:param name="list_ArrStatus_Activ_DepositsLoansFloatingConditionIL" select="' CURRENT AUTH-FWD EXPIRED '"/>
	<xsl:param name="list_SubAssetType_DerivativesPrice" select="' 400 401 402 403 404 405 430 431 449 499 450 451 452 453 454 455 '"/>
	<xsl:param name="list_ArrStatus_Activ_FinancialInstrumentAADepositAndLoan" select="' CURRENT '"/>
	<xsl:param name="list_ArrStatus_InActiv_FinancialInstrumentAADepositAndLoan" select="' EXPIRED '"/>
	<xsl:param name="list_auth_FinancialInstrumentAADepositFloatingCondition" select="' AUTH AUTH-FWD CURRENT EXPIRED '"/>
	<xsl:param name="list_idComp2_FinancialInstrumentAADepositFloatingCondition" select="' DEPOSITINT PRINCIPALINT '"/>
	<xsl:param name="list_ArrStatus_Input_FinancialInstrumentAADepositsandLoansIL" select="' AUTH AUTH-FWD  '"/>
	<xsl:param name="list_ArrStatus_Activ_FinancialInstrumentAADepositsandLoansIL" select="' CURRENT EXPIRED '"/>
	<xsl:param name="list_Input_FinancialInstrumentAADepositsInterestRate" select="' AUTH AUTH-FWD '"/>
	<xsl:param name="list_Active_FinancialInstrumentAADepositsInterestRate" select="' CURRENT EXPIRED  '"/>
	<xsl:param name="list_idComp2_FinancialInstrumentAADepositsInterestRate" select="' DEPOSITINT PRINCIPALINT '"/>
	<xsl:param name="list_auth_FinancialInstrumentAADepositsInterestRateIL" select="' CURRENT AUTH-FWD EXPIRED '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentCommodity" select="' 601 602 603 699 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentConvertibleBond" select="'106'"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentCorporateActions" select="' 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentDiscountInstrument" select="' 200 201 202 203 204 205 206 299 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentExoticOption" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentExoticOptionContractMaster" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentFixedIncome" select="' 100 101 102 103 104 105 199 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentFuture" select="' 450 451 452 453 454 455 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentFutureContractMaster" select="' 450 451 452 453 454 455 '"/>
	<xsl:param name="list_subAssetType_FinancialInstrumentLombardWeightsDX" select=" ' 400 401 402 403 404 405 430 431 449 499 451 452 453 454 455 '"/>
	<xsl:param name="list_subAssetType_FinancialInstrumentLombardWeightsSC"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 160 161 162 163 164 165  166 167 170 171 172 200 201 202 203 204 205 206 299 601 602 603 699 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentMiniFutureTurbo" select="' 166 167 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentMiniFutureTurboLoad" select="' 166 167 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentMutualFund" select="' 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentOption" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentOptionContractMaster" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentOptionDxCo" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentOther" select="' 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentStock" select="' 300 301 302 303 320 350 399 '"/>
	<xsl:param name="list_SubAssetType_FullPartialExecution"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 507 '"/>
	<xsl:param name="list_SubAssetType_FuturePosition" select="' 450 451 452 453 454 455 '"/>
	<xsl:param name="list_SubAssetType_LockedSecurityPosition"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_LockingTransaction"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_LockingTransactionCOA"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_OptionPosition" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_OrderAcknowledgment"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_Price"
	           select="' 300 301 302 303 320 350 399 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 390 '"/>
	<xsl:param name="list_SubAssetType_SecurityPosition"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_T24StatusChange"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_T24StatusChangeCancelUpdate" select="$list_SubAssetType_T24StatusChange"/>
	<xsl:param name="list_SubAssetType_SpAirBagCertificates" select="' 160 '"/>
	<xsl:param name="list_SubAssetType_SpBonusNotes" select="' 161 '"/>
	<xsl:param name="list_SubAssetType_SpCapitalProtectedNotes" select="' 162 168 '"/>
	<xsl:param name="list_SubAssetType_SpDiscountCertificate" select="' 163 '"/>
	<xsl:param name="list_SubAssetType_SpMemoryCouponNotes" select="' 164 '"/>
	<xsl:param name="list_SubAssetType_SpTwinWinCertificate" select="' 165 '"/>
	<xsl:param name="list_SubAssetType_SpRevConvBondLinked" select="' 170 '"/>
	<xsl:param name="list_SubAssetType_SpRevConvEquityLinked" select="' 171 '"/>
	<xsl:param name="list_SubAssetType_SpRevConvCreditLinked" select="' 172 '"/>
	<xsl:param name="list_SubAssetType_SMIndices" select=" ' 390 ' "/>
	<xsl:param name="list_auth_TransactionAACapitaliseInterestDeposit" select="' AUTH CURRENT AUTH-FWD '"/>
	<xsl:param name="list_auth_TransactionAADepositInterestPayment" select="' AUTH CURRENT AUTH-FWD EXPIRED PENDING.CLOSURE '"/>
	<xsl:param name="list_auth_TransactionAAPayOffInterest" select="' PENDING.CLOSURE CURRENT CLOSE '"/>
	<xsl:param name="list_auth_TransactionAAPayOffLending" select="' PENDING.CLOSURE CURRENT EXPIRED CLOSE '"/>
	<xsl:param name="list_aaMasterActivity_TransactionCloseAADeposits" select="' DEPOSITS-MATURE-ARRANGEMENT DEPOSITS-REDEEM-ARRANGEMENT DEPOSITS-MAKEDUE-SCHEDULE '"/>
	<xsl:param name="list_SubAssetType_TransactionSecurityBuy"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_TransCode_TransactionSecurityBuy" select="' BUY SPR FPR SWI FSI MFP IPP CBY UPS TPI '"/>
	<xsl:param name="list_SubAssetType_TransactionSecurityBuyReversal"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_TransCode_TransactionSecurityBuyReversal" select="' BUY SPR FPR SWI FSI MFP CBY '"/>
	<xsl:param name="list_SubAssetType_TransactionSecuritySell"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_TransCode_TransactionSecuritySell" select="' SEL SSL FRD SWO FSO MFR RDM CSL TPO '"/>
	<xsl:param name="list_SubAssetType_TransactionSecuritySellReversal"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_TransCode_TransactionSecuritySellReversal" select="' SEL SSL FRD SWO FSO MFR CSL '"/>
	<xsl:param name="list_Status_FinancialInstrumentNdForward" select="' OPN FIX '"/>
	<xsl:param name="list_Status_NdForwardPurchaseOpening" select="' OPN FIX REV '"/>
	<xsl:param name="list_Status_NdForwardPurchaseClosing" select="' MAT '"/>
	<xsl:param name="list_Status_NdForwardSaleClosing" select="' MAT '"/>
	<xsl:param name="list_Status_NdForwardSaleOpening" select="' OPN FIX REV '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentExoticOptionSyDx" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentFutureSYDX" select="' 450 451 452 453 454 455 '"/>
	<xsl:param name="list_SubAssetType_FinancialInstrumentOptionSyDx" select="' 400 401 402 403 404 405 430 431 449 499 '"/>
	<xsl:param name="list_SubAssetType_IrregularCoupon" select="' 102 '"/>
	<xsl:param name="list_SubAssetType_TaxLot" select="' 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 '"/>
	<xsl:param name="list_TxnType_TaxLot" select="' CBY OAB CSL OAS '"/>
	<xsl:param name="list_SubAssetType_OrderGroupingForSubscriptionRedemption" select="' 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 '"/>
	<xsl:param name="list_SubAssetType_OrderGroupingCutOffDateChange" select="' 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 '"/>
	<xsl:param name="list_SubAssetType_TransactionSecOpenOrder"
	           select="' 301 302 300 303 320 399 350 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 100 101 102 103 104 105 199 106 200 201 202 203 204 205 206 299 601 602 603 699 160 161 162 163 164 165 166 167 170 171 172 '"/>
	<xsl:param name="list_SubAssetType_NDMAforSOO"
	           select="' 500 501 502 503 505 506 507 508 509 510 511 512 513 514 515 516 517 518 520 521 599 '"/>
    <xsl:param name="list_TapInstrType_NDMAforSOO"
               select="' MUTUALFUND '"/>	           
	<!-- End of Global variables used for filtering -->
	<!-- lists for operation subtypes for INTRAFUND and INTERFUND orders -->
	<xsl:param name="list_operationSubtype_INTERFUND" select="' PCK_TCIB_INTER_SW_I PCK_TCIB_INTER_SW_O PCK_TCIB_INTE_P_SW_I PCK_TCIB_INTE_P_SW_O '"/>
	<xsl:param name="list_operationSubtype_INTRAFUND" select="' PCK_TCIB_INTRA_SW_I PCK_TCIB_INTRA_SW_O PCK_TCIB_INTR_P_SW_I PCK_TCIB_INTR_P_SW_O '"/>
	<xsl:param name="list_DXExoticOptionsOptionType" select="' KNOCKIN KIKO KIKI KNOCKOUT KOKO DIGITAL ALL '"/>
	<xsl:param name="list_SYDXExoticOptionsExoticType" select="' KNOCKIN KNOCKOUT KIKI KIKO KOKO DIGITAL '"/>
	<!-- End of lists for operation subtypes for INTRAFUND and INTERFUND orders -->
	<!-- Start of sequence number calculation -->
	<!--
	decimal number format,Nan converted to empty value.
	-->
	<xsl:decimal-format NaN="" name="nan2Null"/>
	<xsl:template name="calcSeqNum">
		<xsl:param name="creationTime"/>
		<xsl:variable name="year">
			<xsl:value-of select="substring($creationTime, 1, 4)"/>
		</xsl:variable>
		<xsl:variable name="month">
			<xsl:value-of select="substring($creationTime, 6, 2)"/>
		</xsl:variable>
		<xsl:variable name="day">
			<xsl:value-of select="substring($creationTime, 9, 2)"/>
		</xsl:variable>
		<xsl:variable name="hour">
			<xsl:value-of select="substring($creationTime, 12, 2)"/>
		</xsl:variable>
		<xsl:variable name="minute">
			<xsl:value-of select="substring($creationTime, 15, 2)"/>
		</xsl:variable>
		<xsl:variable name="second">
			<xsl:value-of select="substring($creationTime, 18, 2)"/>
		</xsl:variable>
		<xsl:variable name="micro">
			<xsl:value-of select="substring(concat(translate(substring($creationTime, 21), 'Z', ''), '000000'), 1, 6)"/>
		</xsl:variable>
		<xsl:value-of select="format-number((($year - 2000)*372*24*60*60 + ($month)*2678400 + ($day)*86400 + ($hour)*3600 + ($minute)*60 + $second)*1000000 + $micro,'####################','nan2Null')"/>
	</xsl:template>
	<!-- End of sequence number calculation -->
	<!--Julian date(YYDDD) to  YYYY-MM-DD Format -->
	<xsl:template name="juliandate">
		<xsl:param name="date"/>
		<xsl:variable name="yyyy" select="concat('20',substring($date,1,2))"/>
		<xsl:variable name="day" select="substring($date,3,3)"/>
		<xsl:choose>
			<xsl:when test="$yyyy mod 4 != 0">
				<xsl:choose>
					<xsl:when test="$day &lt; 32">
						<xsl:choose>
							<xsl:when test="format-number($day,'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','01','-0',format-number($day,'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','01','-',format-number($day,'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt; 60">
						<xsl:choose>
							<xsl:when test="format-number(($day - 31),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','02','-0',format-number(($day - 31),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','02','-',format-number(($day - 31),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt; 91">
						<xsl:choose>
							<xsl:when test="format-number(($day - 59),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','03','-0',format-number(($day - 59),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','03','-',format-number(($day - 59),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;121">
						<xsl:choose>
							<xsl:when test="format-number(($day - 90),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','04','-0',format-number(($day - 90),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','04','-',format-number(($day - 90),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;152">
						<xsl:choose>
							<xsl:when test="format-number(($day - 120),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','05','-0',format-number(($day - 120),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','05','-',format-number(($day - 120),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;182">
						<xsl:choose>
							<xsl:when test="format-number(($day - 151),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','06','-0',format-number(($day - 151),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','06','-',format-number(($day - 151),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;213">
						<xsl:choose>
							<xsl:when test="format-number(($day - 181),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','07','-0',format-number(($day - 181),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','07','-',format-number(($day - 181),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;244">
						<xsl:choose>
							<xsl:when test="format-number(($day - 212),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','08','-0',format-number(($day - 212),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','08','-',format-number(($day - 212),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;274">
						<xsl:choose>
							<xsl:when test="format-number(($day - 243),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','09','-0',format-number(($day - 243),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','09','-',format-number(($day - 243),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;305">
						<xsl:choose>
							<xsl:when test="format-number(($day - 273),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','10','-0',format-number(($day - 273),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','10','-',format-number(($day - 273),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;335">
						<xsl:choose>
							<xsl:when test="format-number(($day - 304),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','11','-0',format-number(($day - 304),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','11','-',format-number(($day - 304),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;366">
						<xsl:choose>
							<xsl:when test="format-number(($day - 334),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','12','-0',format-number(($day - 334),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','12','-',format-number(($day - 334),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$day &lt;32">
						<xsl:choose>
							<xsl:when test="format-number($day,'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','01','-0',format-number(($day),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','01','-',format-number(($day),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;61">
						<xsl:choose>
							<xsl:when test="format-number(($day - 31),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','02','-0',format-number(($day - 31),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','02','-',format-number(($day - 31),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;92">
						<xsl:choose>
							<xsl:when test="format-number(($day - 60),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','03','-0',format-number(($day - 60),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','03','-',format-number(($day - 60),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;112">
						<xsl:choose>
							<xsl:when test="format-number(($day - 91),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','04','-0',format-number(($day - 91),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','04','-',format-number(($day - 91),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;153">
						<xsl:choose>
							<xsl:when test="format-number(($day - 121),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','05','-0',format-number(($day - 121),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','05','-',format-number(($day - 121),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;183">
						<xsl:choose>
							<xsl:when test="format-number(($day - 152),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','06','-0',format-number(($day - 152),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','06','-',format-number(($day - 152),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;214">
						<xsl:choose>
							<xsl:when test="format-number(($day - 182),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','07','-0',format-number(($day - 182),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','07','-',format-number(($day - 182),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;245">
						<xsl:choose>
							<xsl:when test="format-number(($day - 213),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','08','-0',format-number(($day - 213),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','08','-',format-number(($day - 213),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;275">
						<xsl:choose>
							<xsl:when test="format-number(($day - 244),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','09','-0',format-number(($day - 244),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','09','-',format-number(($day - 244),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;306">
						<xsl:choose>
							<xsl:when test="format-number(($day - 274),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','10','-0',format-number(($day - 274),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','10','-',format-number(($day - 274),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;336">
						<xsl:choose>
							<xsl:when test="format-number(($day - 305),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','11','-0',format-number(($day - 305),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','11','-',format-number(($day - 305),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:when test="$day &lt;367">
						<xsl:choose>
							<xsl:when test="format-number(($day - 335),'####################','nan2Null') &lt; 10">
								<xsl:value-of select="concat($yyyy,'-','12','-0',format-number(($day - 335),'####################','nan2Null'))"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat($yyyy,'-','12','-',format-number(($day - 335),'####################','nan2Null'))"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Format a 8 or 6 digit date so that it can be converted to a number -->
	<xsl:template name="formatDateForMaturityComparison">
		<xsl:param name="dateToFormat"/>
		<xsl:choose>
			<xsl:when test="string-length($dateToFormat) ='8' or string-length($dateToFormat) ='10'">
				<xsl:value-of select="substring(translate($dateToFormat,'-',''),1,8)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($dateToFormat,'31')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Format a 8 or 6 digit date so that it can be converted to a number -->
	<xsl:template name="formatDateForComparison">
		<xsl:param name="dateToFormat"/>
		<xsl:choose>
			<xsl:when test="string-length($dateToFormat) ='8' or string-length($dateToFormat) ='10'">
				<xsl:value-of select="substring(translate($dateToFormat,'-',''),1,8)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(translate($dateToFormat,'-',''),'31')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>