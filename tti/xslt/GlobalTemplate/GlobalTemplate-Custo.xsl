<?xml version="1.0"?>
<!-- _@GVA20240702_1446@_ -->
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" exclude-result-prefixes="infra xhtml" version="1.0">


<!-- AA Company Mnemonic Enabled/Disable -->
<!-- BEG - JPP20240603 - TSR-819295 -->
<xsl:param name="POSTFIX_AACOMNE" select="'N'"/>
<!-- END - JPP20240603 - TSR-819295 -->
<xsl:param name="DX_AUTO_AUTHORISE" select="'NO'"/>
    <!-- START of protected area  -->
<xsl:param name="HOLIDAY_END_YEAR" select="'2099'"/>

<!-- BEG - JPP20240515 - TSR-811606 - Close Fiduciary Depo order remains in status ‘’ to send’’ => desactivate PEN.COMM.TYPE -->
<xsl:param name="FD_EARLY_MAT_PENALTY_TYPE" select="''"/>
<!-- END - JPP20240515 - TSR-811606 - Close Fiduciary Depo order remains in status ‘’ to send’’ -->

<!-- BEG- JPP20240319- TSR-763980 L1: REQ115366 Currency Hedging- Fx forward contract are not displaying on the hedging screen due to missing configuration for forwards instruments -->
<xsl:param name="PCK_GL_FWD_TEMPLATE" select="'1'"/>
<xsl:param name="FWD_ACC_FLAG" select="'2'"/>
<!-- END- JPP20240319- TSR-763980 L1: REQ115366 Currency Hedging- Fx forward contract are not displaying on the hedging screen due to missing configuration for forwards instruments -->

<!-- BEG - JPP20240220 - TSR-754365 - SP99-FLOW-SP&DERIVATIVES -->
<xsl:param name="SY_ACCUDECU_VARIANT" select="''"/>
<xsl:param name="SY_ACCUDECU_AGENCY_BOOKING" select="'N'"/>
<xsl:param name="SY_DCI_VARIANT" select="''"/>
<xsl:param name="SY_DCI_AGENCY_BOOKING" select="'N'"/>
<xsl:param name="SY_TCI_VARIANT" select="''"/>
<xsl:param name="SY_TCI_AGENCY_BOOKING" select="'N'"/>
<xsl:param name="SY_PFWD_VARIANT" select="''"/>
<xsl:param name="SY_PFWD_AGENCY_BOOKING" select="'N'"/>
<xsl:param name="SY_TARKO_VARIANT" select="''"/>
<xsl:param name="SY_TARKO_AGENCY_BOOKING" select="'N'"/>
<xsl:param name="SY_DEALER_DESK" select="''"/>
<xsl:param name="SY_BP_CODE" select="'BANK_COMMISSION'"/>
<xsl:param name="SY_OTC_FX_CONTRACT_CODE" select="'777778'"/>
<!-- END - JPP20240220 - TSR-754365 - SP99-FLOW-SP&DERIVATIVES -->

<!-- Activate or not mapping of sensitive info -->
<xsl:param name="MAP_SENSITIVE_DATA" select="'Y'"/>
<xsl:param name="g_filterBySubAssetType" select="'Y'"/>

<xsl:param select="' 100 101 102 103 104 105 107 108 120 130 173 199 205 206  '" name="list_SubAssetType_FinancialInstrumentFixedIncome"/>    <!-- nature_e = 2 -->
<xsl:param select="' 131  174 175 176 177 181 182 183 184 185 '" name="list_SubAssetType_SpAirBagCertificates"/>   <!-- nature_e = 2 -->
<xsl:param select="' 200 201 202 203 204 207 299 '" name="list_SubAssetType_FinancialInstrumentDiscountInstrument"/>  <!-- nature_e = 11 -->
<xsl:param select="' 160 300 301 302 303 304 305 320 321 322 331 332 333 334 335 336 337 338 339 340 341 342 343 344 399 '" name="list_SubAssetType_FinancialInstrumentStock"/>  <!-- nature_e = 1 -->



<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentOption"/>                     <!-- nature_e = 3, no T24 OPTION.TYPE -->
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentOptionContractMaster"/>       <!-- nature_e = 3, no T24 OPTION.TYPE --> 
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentOptionDxCo"/>                 <!-- nature_e = 3, chk on Price -->
              <!-- nature_e = 22, no T24 EXOTIC.TYPE, PriceSet is INTERFACE -->
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentExoticOption"/>               <!-- nature_e = 22, need T24 OPTION.TYPE and list_DXExoticOptionsOptionType -->
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentExoticOptionContractMaster"/> <!-- nature_e = 22, need T24 OPTION.TYPE and list_DXExoticOptionsOptionType -->
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentOptionSyDx"/> 
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_FinancialInstrumentExoticOptionSyDx"/>           <!-- nature_e = 22, need T24 OPTION.TYPE and list_DXExoticOptionsOptionType -->
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 430 431 439 440 441 443 444 445 446 447 448 449 499 '" name="list_SubAssetType_OptionPosition"/>
<xsl:param select="' 410 411 412 413 414 415 416 417 450 451 452 453 454 455 490 '" name="list_SubAssetType_FinancialInstrumentFuture"/>                  <!-- nature_e = 6 -->
<xsl:param select="' 410 411 412 413 414 415 416 417 450 451 452 453 454 455 490 '" name="list_SubAssetType_FinancialInstrumentFutureContractMaster"/>    <!-- nature_e = 6 -->
<xsl:param select="' 410 411 412 413 414 415 416 417 450 451 452 453 454 455 490 '" name="list_SubAssetType_FinancialInstrumentFutureSYDX"/>              <!-- nature_e = 6 -->



<xsl:param select="' 410 411 412 413 414 415 416 417 450 451 452 453 454 455 490 '" name="list_SubAssetType_FuturePosition"/>

<!-- JPP20240702 - move 350, 351 from stock to MutualFunds -->
<xsl:param select="' 350 351 513 514 515 516 517 518 520 521 522 523 524 525 526 527 528 529 530 531 532 '" name="list_SubAssetType_FinancialInstrumentMutualFund"/>   <!-- nature_e = 13 -->



<xsl:param name="list_SubAssetType_FinancialInstrumentConvertibleBond" select="'106'"/>  <!-- nature_e = 19 -->
<xsl:param select="' 513 514 515 516 517 518 521 522 523 524 525 526 527 528 529 530 520 531 532 '" name="list_SubAssetType_OrderGroupingForSubscriptionRedemption"/>
<xsl:param select="' 513 514 515 516 517 518 521 522 523 524 525 526 527 528 529 530 520 531 532 '" name="list_SubAssetType_OrderGroupingCutOffDateChange"/>
<xsl:param select="' 513 514 515 516 517 518 521 522 523 524 525 526 527 528 529 530 520 531 532 '" name="list_SubAssetType_NDMAforSOO"/>
<xsl:param select="' 600 601 602 603 611 612 613 614 615 616 699 '" name="list_SubAssetType_FinancialInstrumentCommodity"/>   <!-- nature_e = 12 -->
<xsl:param select="' 650 651 652 653 654 655 656 657 658 659 661 662 663 664 665 666 667 668 669 900 901 902 903 904 905 906 907 999 '" name="list_SubAssetType_FinancialInstrumentOther"/>  <!-- nature_e = 17 -->
<!-- JPP20241114 - devop 94939 - map 170 171 -->
<xsl:param select="' 149 162 168 170 171 186 187 192 193 194 '" name="list_SubAssetType_SpCapitalProtectedNotes"/>            <!-- nature_e = 2 -->
<xsl:param select="' 163 188 '" name="list_SubAssetType_SpDiscountCertificate" />        <!-- nature_e = 2 -->
<xsl:param select="' 161 180 '" name="list_SubAssetType_SpBonusNotes"/>                  <!-- nature_e = 2 -->
<xsl:param select="' 164 189 '" name="list_SubAssetType_SpMemoryCouponNotes"/>           <!-- nature_e = 2 -->
<xsl:param select="' 165 190 '" name="list_SubAssetType_SpTwinWinCertificate"/>          <!-- nature_e = 2 -->
<xsl:param select="' 172 195 '" name="list_SubAssetType_SpRevConvCreditLinked"/>         <!-- nature_e = 19 -->
<!--NPN-MIR - Fix to create index instruments correctly -->
<xsl:param select="' 390 110 330 349 '" name="list_SubAssetType_SMIndices"/>
<!-- Filtering Section 2 -->
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_FullPartialExecution"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_LockedSecurityPosition"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_LockingTransaction"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_LockingTransactionCOA"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_OrderAcknowledgment"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_Price"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 900 520 531 532 905 906 999 665 '" name="list_SubAssetType_SecurityPosition"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_T24StatusChange"/>
<xsl:param select="$list_SubAssetType_T24StatusChange" name="list_SubAssetType_T24StatusChangeCancelUpdate"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_TransactionSecurityBuy"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_TransactionSecurityBuyReversal"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_TransactionSecuritySell"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_TransactionSecuritySellReversal"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_SubAssetType_TransactionSecOpenOrder"/>

<!-- Filtering Other -->

<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 107 108 '" name="list_SubAssetType_ChronoDataUnpaidPercentage"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 149 173 199 300 301 303 304 305 320 321 322 331 332 350 399 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 '" name="list_SubAssetType_ChronologicalData"/>
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 410 411 412 413 414 415 416 417 430 431 432 435 439 440 441 443 444 445 446 447 448 449 490 499 450 451 452 453 454 455 '" name="list_SubAssetType_DerivativesPrice"/>
<xsl:param select="' 157 306 400 401 402 403 404 405 407 408 410 411 412 413 414 415 416 417 430 431 432 435 439 440 441 443 444 445 446 447 448 449 490 499 450 451 452 453 454 455 '" name="list_subAssetType_FinancialInstrumentLombardWeightsDX"/>
<xsl:param select="' 100 101 102 103 104 105 106 120 130 173 199 131 160 161 162 163 164 165 166 167 168 169 170 171 172 200 201 202 203 204 205 206 207 299 149 300 301 303 304 305 320 321 322 331 332 399 350 513 514 515 516 517 518 521 600 601 602 603 611 612 613 699 107 108 302 333 334 335 336 337 338 339 340 341 342 343 344 351 522 523 524 525 526 527 528 529 530 614 615 616 174 175 176 177 181 182 183 184 185 186 187 191 192 193 194 188 180 189 190 195 520 531 532 '" name="list_subAssetType_FinancialInstrumentLombardWeightsSC"/>
<xsl:param select="' 513 514 515 516 517 518 521 522 523 524 525 526 527 528 529 530 520 531 532 '" name="list_SubAssetType_FinancialInstrumentCorporateActions"/>
<!-- DO 227174 -->
<xsl:param select="' 166 167 191 '" name="list_SubAssetType_FinancialInstrumentMiniFutureTurbo"/>
<!--NPN-MIR - Custo New Transaction Types TRE and TRS-->
<xsl:param select="' TRI UTI ETI CBY OAB OWI LWI TRE '" name="securityTransferInSupportedTypes"/>
<xsl:param select="' TRO UTO ETO CSL OAS OWO LWO TRS '" name="securityTransferOutSupportedTypes"/>


<!--RNJ-MIR - F2B versions used (with or without auto-authorization)-->
<!--To auto authorize the OTC product (Item 15332)-->
<xsl:param name="DxOrderInstructionTRADEOTCVersion" select="'CSD.TAP'"/>

<!--RNJ-MIR - BUG 15929-->
<xsl:param name="NDF_DEALER_DESK" select="'03'"/>
<!-- BEG - JPP20240404 - TSR-781013 - Call.Rights event (COA) does not reach TAP -->
<xsl:param name="g_filterCOAUsingGlobalTemplateFunction" select="'Y'"/>
<!-- END - JPP20240404 - TSR-781013 - Call.Rights event (COA) does not reach TAP -->

<!-- BEG - Trade Instructions -->
<xsl:param name="SecOpenOrderUpdateVersionDMA" select="'CSD.TAP'"/>
	<xsl:param name="SecOpenOrderSingleBulkChildVersion" select="'CSD.TAP'"/>
	<xsl:param name="SecOpenOrderUpdateTapRefIdNDMA" select="'CSD.TAP'"/>
	<xsl:param name="DxOrderInstructionVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXForwardPurchaseVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXForwardSaleVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXSpotPurchaseVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXSpotSaleVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXSwapPurchaseVersion" select="'CSD.TAP'"/>
	<xsl:param name="ForexFXSwapSaleVersion" select="'CSD.TAP'"/>
	<xsl:param name="FD_OPEN_CONTRACT_VERSION" select="'CSD.TAP'"/>
	<xsl:param name="PeCustomerTxnInstructionVersion" select="'CSD.INPUT'"/>
	<xsl:param name="SecOpenOrderCancelledExpiredVersion" select="'CSD.TAP.CANC'"/>

	<!-- No versions for ND.DEAL -->
	<xsl:param name="NdDealNDForwardPurchaseVersion" select="'CSD.AUTH'"/>
	<xsl:param name="NdDealNDForwardSaleVersion" select="'CSD.AUTH'"/>
	
	<!-- END of Trade Instruction -->
	<!-- START TSR-904546 - SM - CHANGE TO CSD VERSION -->
	<xsl:param name="ScExeSecOrdersExecEnrichmentVersion" select="'CSD.TAP.HOLD'"/>
	<!-- END TSR-904546 - SM - CHANGE TO CSD VERSION -->
	<!-- BEG - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->		
    <xsl:param name="DXSTOCKEXCH_PREFIX" select="'MKT_'"/>
    <!-- END - JPP20240904 - TSR-881979 - FIX_CODIF_MARKET with mnemonic for DX -->
<xsl:template name="diaryTypeTranslation">
	<xsl:param name="diaryType"/>
	<xsl:param name="defaultReturnStatus" select="'NotFound'"/>
	<xsl:choose>
		<!-- BEG - JBR20240417 - TSR-... - COAs configuration -->
		<!-- JPP20241023 - add PEFUNDDIST -->
		<xsl:when test="$diaryType = 'CASH.DIVIDENDS'">ACCUMINC CASH CASH.DISTRIB CASH.DIV CGT.DISTRIB EQUALISATION SH.PR.DIV.CCY SHARE.PR.DIV PEFUNDDIST </xsl:when>
		<xsl:when test="$diaryType = 'STOCK.DIVIDENDS'">BONUS BONUS.SHARE CAPITALISATION CRYSTALISATION STOCK.DIV</xsl:when>
		<xsl:when test="$diaryType = 'OPTION.DIVIDENDS'">INTR.KIND SCRIP.DIV STOCK.CASH </xsl:when>
		<xsl:when test="$diaryType = 'INTEREST'">INTEREST COUPON</xsl:when>
		<xsl:when test="$diaryType = 'FINAL.MAT'">DRAWING FINAL.MAT FINAL.MAT.CCY FINAL.REDEM LIQUIDATION REDEMPTION RIGHTS.SELL</xsl:when>
		<xsl:when test="$diaryType = 'EXCHANGE.OFFER'">BOND.CONVERSION CHANGE.ISIN EU.BD.HLD.DN EXCH.CLASS EXCH.OFFER EXCH.OFFER.CHOS EXCH.OFFER.VOLU OPEN.OFFER PARI.PASSU PRIORITY.OFFER SECURITY.SWITCH STOCK.CONVERT TAKEOVER TAKEOVER.BID TAKEOVER.SHARE</xsl:when>
		<xsl:when test="$diaryType = 'CONVERSION'">CALL.RIGHTS CONVERSION CONVERSION.VOLU ROLLUP WARRANT WARRANT.CHOS WARRANT.VOLU</xsl:when>
		<xsl:when test="$diaryType = 'STOCK.SPLIT'">STOCK.SPLIT STOCK.SPLIT.NEW</xsl:when>
		<xsl:when test="$diaryType = 'REV.STOCK.SPLIT'">REVE.SPLIT.FRAC CONSOL.NEW</xsl:when>
		<xsl:when test="$diaryType = 'SPIN.OFF'">DETACHMENT SPIN.OFF</xsl:when>
		<xsl:when test="$diaryType = 'DECREASE.VALUE'">CALL.PAYMENT CAPITAL.RETURN COMPENSATN.PYMT DECREASE.VALUE</xsl:when>
		<xsl:when test="$diaryType = 'INCREASE.VALUE'">INC.VALUE INSTAL.CALL</xsl:when>
		<xsl:when test="$diaryType = 'LAPSE'">LAPSE WORTHLESS</xsl:when>
		<xsl:when test="$diaryType = 'MERGER'">CONSOLIDATION MERGER.CHOS MERGER.MAN</xsl:when>
		<xsl:when test="$diaryType = 'REINVEST'">DRIPS</xsl:when>
		<xsl:when test="$diaryType = 'DISTRIBUTION'">RIGHTS RIGHTS.DISTRIB</xsl:when>
		<xsl:when test="$diaryType = 'REPURCHASE'">REPURCHASE</xsl:when>
		<xsl:when test="$diaryType = 'RIGHTS.DISTRIB.EXERCISE'">RHTS.DIST.EXRI</xsl:when>
		<xsl:when test="$diaryType = 'RHTS.DIST.EXRI'"></xsl:when>  <!-- no xslt -->
		<xsl:when test="$diaryType = 'WARRANTS.EXERCISE'"></xsl:when>
		<xsl:when test="$diaryType = 'SALE'">CAP.RETU.CCY DUTCH.ACTION LIQUI.CHOS PUT.REDM</xsl:when>
		<xsl:when test="$diaryType = 'PURCHASE'">COMPANY.OPTION</xsl:when>
		<xsl:when test="$diaryType = 'TAX.REFUND'"/>
		<xsl:when test="$diaryType = 'PARTIAL.REDEM'">PARTIAL.REDEM</xsl:when>
		<xsl:when test="$diaryType = 'MULTI.CCY.DIVIDEND'">MULTI.CCY.DIV</xsl:when>
		<xsl:when test="$diaryType = 'ODDLOT'">ODDLOT</xsl:when>
		<xsl:when test="$diaryType = 'OFF.MKT.BUYBACK'"></xsl:when>
		<xsl:when test="$diaryType = 'SHARE.PUR.PLAN'"></xsl:when>
		<xsl:when test="$diaryType = 'SH.SALE.FAC'">SH.SALE.FAC</xsl:when>
		<xsl:when test="$diaryType = 'SPIN.OFF.PROP'"></xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$defaultReturnStatus"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
		<!-- END - JBR20240417 - TSR-... - COAs configuration -->
		<!--
checkPortfolioCondition
-->
	<xsl:template name="checkPortfolioConditionCsdEam">
		<xsl:param name="xsltName"/>
		<xsl:param name="memoAccount"/>
		<xsl:param name="dealerBook"/>
		<xsl:param name="customerType"/>
		<xsl:param name="defaultReturn" select="'NotFound'"/>
		<!-- portfolioGroup1 - Allow if MEMO.ACCOUNT=NO,dealerBook empty and CustomerType is Customer -->
		<xsl:param name="portfolioGroup1">
			<!-- EAM PAYMENT.ORDER xslts -->
			<xsl:value-of select="' CsdTransactionPaymentOrderDebit CsdTransactionPaymentOrderCredit CsdTransactionPaymentOrderNotificationCredit CsdTransactionPaymentOrderNotificationDebit '"/>
		</xsl:param>
		<xsl:choose>
			<xsl:when test="contains($portfolioGroup1,concat(' ',$xsltName,' ')) and $memoAccount = 'NO' and ($dealerBook = '' or not($dealerBook)) and $customerType = 'CUSTOMER'">
				<xsl:value-of select="'true'"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$defaultReturn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
    <!-- END of protected area  -->
</xsl:stylesheet>

