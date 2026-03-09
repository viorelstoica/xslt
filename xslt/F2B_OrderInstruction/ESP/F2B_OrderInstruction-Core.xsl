<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:t="http://www.odcgroup.com/F2B_FORMAT" xmlns:dxorder="http://www.temenos.com/T24/dxorder"
                xmlns:dxtrade="http://www.temenos.com/T24/dxtrade" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:adjustmentorder="http://www.temenos.com/T24/adjustmentorder" xmlns:secopenorder1="http://www.temenos.com/T24/secopenorder1"
                xmlns:secopenorder2="http://www.temenos.com/T24/secopenorder2" xmlns:secopenorder3="http://www.temenos.com/T24/secopenorder3" xmlns:sectrade="http://www.temenos.com/T24/sectrade"
                xmlns:pecustomertxn="http://www.temenos.com/T24/pecustomertxn" xmlns:positiontransfer="http://www.temenos.com/T24/positiontransfer" xmlns:securitytransfer="http://www.temenos.com/T24/securitytransfer"
                xmlns:securitytransfer2="http://www.temenos.com/T24/securitytransfer2" exclude-result-prefixes="b t" version="1.0">

	<xsl:param name="SecOpenOrderSingleBulkChildVersion">
		<xsl:choose>
			<xsl:when test="(contains($internalTraspasos_TAPSellType,b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction/b:type/infra:code) or (contains($internalTraspasos_TAPBuyType,b:F2B/b:DataGroup/b:Security/b:OrderLifeCycle/b:OrderInstruction/b:type/infra:code)))">
				<xsl:value-of select="$TRASPASO_REQUEST"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$SOOTAP"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>

	<xsl:template name="secopenorder2:ModelBankSpecificFields">
		<xsl:if test="b:targetNature = '8'">
			<field name="REDEEM.ALL">
				<xsl:value-of select="'Y'"/>
			</field>
		</xsl:if>
		<field name="SESN.ORD.COUNT">
			<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'order_count_n']/infra:value"/>
		</field>
		<field name="REBALANCING.IND">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name = 'function_c']/infra:value = 'Strategy Reconciliation'">
					<xsl:value-of select="'Y'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'N'"/>
				</xsl:otherwise>
			</xsl:choose>
		</field>
		<field name="SESSION.NO">
			<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'function_result_id']/infra:value"/>
		</field>
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>


		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="secopenorder2:ORDER.TYPE">
		<field name="ORDER.TYPE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="(b:subType/infra:code != '') and ((contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,''))) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,''))))">
							<xsl:value-of select="'SWITCH'"/>
						</xsl:when>
						<xsl:when test="b:targetNature = '2' or b:targetNature = '5'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="b:targetNature = '1' or b:targetNature = '8'">
							<xsl:choose>
								<xsl:when test="b:type/infra:code = $RevokeType">
									<xsl:value-of select="'CANC'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '1'">
									<xsl:value-of select="'MARKET'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '2'">
									<xsl:choose>
										<xsl:when test="$settlementOrderType = 'NO'">
											<xsl:value-of select="'PRICE'"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="'LIMIT'"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="b:orderType = '3'">
									<xsl:value-of select="'STOP'"/>
								</xsl:when>
								<xsl:when test="b:orderType = '4'">
									<xsl:value-of select="'STOP.LIMIT'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NOTSUPPORTED'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="(t:attribute[@name = 'subTypeCode'] != '') and ((contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))) or (contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],''))))">
							<xsl:value-of select="'SWITCH'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2' or t:attribute[@name = 'target_nature_e'] = '5'">
							<xsl:value-of select="'CASH'"/>
						</xsl:when>
						<xsl:when test="t:attribute[@name = 'target_nature_e'] = '1'">
							<xsl:choose>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '1'">
									<xsl:value-of select="'MARKET'"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '2'">
									<xsl:value-of select="'PRICE'"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'order_nat_e'] = '3'">
									<xsl:value-of select="'STOP'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'NOTSUPPORTED'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:TRANSACTION.CODE">
		<field name="TRANSACTION.CODE">
			<xsl:choose>
				<xsl:when test="local-name() != 'attributes'">
					<xsl:choose>
						<xsl:when test="b:type/infra:code = $internalTraspasos_TAPSellType">
							<xsl:value-of select="$internalTraspasos_TransactionCodeSell"/>
						</xsl:when>
						<xsl:when test="b:type/infra:code = $internalTraspasos_TAPBuyType">
							<xsl:value-of select="$internalTraspasos_TransactionCodeBuy"/>
						</xsl:when>
						<xsl:when test="b:buySellIndicator = '1'">
							<xsl:choose>
								<xsl:when test="b:type/infra:code = 'PCK_TCIB_SWITCH_IN'">
									<xsl:value-of select="'SWI'"/>
								</xsl:when>
								<xsl:when test="b:userDefinedField[infra:name='ud_upfront_payment']/infra:value = '1'">
									<xsl:value-of select="'UPS'"/>
								</xsl:when>
								<xsl:when test="starts-with(b:type/infra:code, 'SC')">
									<xsl:value-of select="substring-after(b:type/infra:code,'SC_')"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'BUY'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="b:orderPriceType = '6'">
									<xsl:value-of select="'RDM'"/>
								</xsl:when>
								<xsl:when test="starts-with(b:type/infra:code, 'SC')">
									<xsl:value-of select="substring-after(b:type/infra:code,'SC_')"/>
								</xsl:when>
								<xsl:when test="b:type/infra:code = 'PCK_TCIB_SWITCH_OUT'">
									<xsl:value-of select="'SWO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'SEL'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<!-- BEG - For Format Based input which follows F2B_Format Schema -->
					<xsl:choose>
						<xsl:when test="t:attribute[@name = 'nature_e'] = '1'">
							<xsl:choose>
								<xsl:when test="starts-with(t:attribute[@name = 'typeCode'], 'SC')">
									<xsl:value-of select="substring-after(t:attribute[@name = 'typeCode'],'SC_')"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'typeCode'] = 'PCK_TCIB_SWITCH_IN'">
									<xsl:value-of select="'SWI'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'BUY'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="t:attribute[@name = 'order_price_nat_e'] = '6'">
									<xsl:value-of select="'RDM'"/>
								</xsl:when>
								<xsl:when test="starts-with(t:attribute[@name = 'typeCode'], 'SC')">
									<xsl:value-of select="substring-after(t:attribute[@name = 'typeCode'],'SC_')"/>
								</xsl:when>
								<xsl:when test="t:attribute[@name = 'typeCode'] = 'PCK_TCIB_SWITCH_OUT'">
									<xsl:value-of select="'SWO'"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="'SEL'"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
					<!-- END - For Format Based input which follows F2B_Format Schema -->
				</xsl:otherwise>
			</xsl:choose>
		</field>
	</xsl:template>
	<xsl:template name="secopenorder2:SWITCH.QTY">
		<xsl:choose>
			<xsl:when test="local-name() != 'attributes'">
				<xsl:if test="b:subType/infra:code != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',b:subType/infra:code,'')) or contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',b:subType/infra:code,'')))">
					<field name="SWITCH.QTY">
						<xsl:choose>
							<xsl:when test="b:targetNature = '1' or b:targetNature = '8'">
								<xsl:value-of select="'UNIT'"/>
							</xsl:when>
							<xsl:when test="b:targetNature = '2'">
								<xsl:value-of select="'AMOUNT'"/>
							</xsl:when>
							<xsl:when test="b:targetNature = '6' or b:targetNature = '7'">
								<xsl:value-of select="'PERCENTAGE'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<!-- BEG - For Format Based input which follows F2B_Format Schema -->
				<xsl:if test="t:attribute[@name = 'subTypeCode'] != '' and (contains(concat('',$list_operationSubtype_INTERFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')) or contains(concat('',$list_operationSubtype_INTRAFUND,''),concat('',t:attribute[@name = 'subTypeCode'],'')))">
					<field name="SWITCH.QTY">
						<xsl:choose>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '1'">
								<xsl:value-of select="'UNIT'"/>
							</xsl:when>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '2'">
								<xsl:value-of select="'AMOUNT'"/>
							</xsl:when>
							<xsl:when test="t:attribute[@name = 'target_nature_e'] = '6' or t:attribute[@name = 'target_nature_e'] = '7'">
								<xsl:value-of select="'PERCENTAGE'"/>
							</xsl:when>
						</xsl:choose>
					</field>
				</xsl:if>
				<!-- END - For Format Based input which follows F2B_Format Schema -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="secopenorder3:ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>


		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="dxorder:ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>



		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="PRI.CUST.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>



	<xsl:template name="positiontransfer:ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>



		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="securitytransfer:ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>



		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="INSTRUCTION.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>



	<xsl:template name="sectrade:ModelBankSpecificFields">
		<xsl:if test="b:initiatedBy != ''">
			<field name="ORDER.INITIATOR">
				<xsl:choose>
					<xsl:when test="b:initiatedBy = '1'">
						<xsl:value-of select="'Client'"/>
					</xsl:when>
					<xsl:when test="b:initiatedBy = '2'">
						<xsl:value-of select="'Bank'"/>
					</xsl:when>
				</xsl:choose>
			</field>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="b:initiatedBy != '2' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value != '1'">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='decision_maker_nci_c']/infra:value != 'NULL')">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='decision_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='decision_maker_type_e']/infra:value = '3'">
					<field name="DECISION.MKR.ID">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'decision_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy = '2' and (b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="(b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = '' or b:mbFields/infra:mbField[infra:name ='manager_nci_c']/infra:value = 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:portfolioManager/infra:code"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="b:initiatedBy != '2' or not(b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '1' or b:mbFields/infra:mbField[infra:name = 'ptf_service_type_e']/infra:value = '2')">
			<xsl:choose>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '2' and (b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name ='instruction_maker_nci_c']/infra:value != 'NULL')">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value,'-',b:mbFields/infra:mbField[infra:name='instruction_maker_nci_c']/infra:value)"/>
					</field>
				</xsl:when>
				<xsl:when test="b:mbFields/infra:mbField[infra:name ='instruction_maker_type_e']/infra:value = '3'">
					<field name="TAP.INSTR.MKR">
						<xsl:value-of select="b:mbFields/infra:mbField[infra:name = 'instruction_maker']/infra:value"/>
					</field>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value != 'NULL')">
				<field name="MANAGER">
					<xsl:value-of select="concat('N','-',b:portfolioManager/infra:code,'-',b:mbFields/infra:mbField[infra:name='manager_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="MANAGER">
					<xsl:value-of select="b:portfolioManager/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value != 'NULL')">
				<field name="TRADER">
					<xsl:value-of select="concat('N','-',b:trader/infra:code,'-',b:mbFields/infra:mbField[infra:name='trader_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:otherwise>
				<field name="TRADER">
					<xsl:value-of select="b:trader/infra:code"/>
				</field>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '2' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != '' and b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value != 'NULL'">
				<field name="CUSTOMER.LEI.NCI">
					<xsl:value-of select="concat('N','-',b:mbFields/infra:mbField[infra:name='client_third_party']/infra:value,'-',b:mbFields/infra:mbField[infra:name='client_nci_c']/infra:value)"/>
				</field>
			</xsl:when>
			<xsl:when test="b:mbFields/infra:mbField[infra:name='client_type_e']/infra:value = '3'"/>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>