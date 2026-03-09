<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch ns0" version="1.0" xmlns="http://www.odcgroup.com/BusIndicator" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/MIFID"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchMIFID" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiMIFID" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiMIFID" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="investObjective">
		<xsl:call-template name="investObjective_capital_preservation"/>
		<xsl:call-template name="investObjective_growth"/>
		<xsl:call-template name="investObjective_income"/>
		<xsl:call-template name="investObjective_hedging"/>
		<xsl:call-template name="investObjective_leveraged_return_profile"/>
		<xsl:call-template name="investObjective_pension_scheme_germany"/>
		<xsl:call-template name="investObjective_financial_instrument_considers_client_sustainability_preferences"/>
		<xsl:call-template name="investObjective_custom"/>
	</xsl:template>
	<xsl:template name="investObjective_capital_preservation">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_CAPITAL_PRESERVATION'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_CAPITAL_PRESERVATION'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
		<instrument>
			<infra:code>
			     <xsl:choose>
			         <xsl:when test="starts-with(b:id, 'DX*')">
			             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
			         </xsl:when>
			         <xsl:otherwise>
			             <xsl:value-of select="b:id"/>      
			         </xsl:otherwise>
			     </xsl:choose>
			</infra:code>
		</instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'CAPITAL.PRESERVATION^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'CAPITAL.PRESERVATION^')][1],'CAPITAL.PRESERVATION^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'CAPITAL.PRESERVATION'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>		
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_CAPITAL_PRESERVATION'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_growth">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_GROWTH'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_GROWTH'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>        
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'GROWTH^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'GROWTH^')][1],'GROWTH^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'GROWTH'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>		
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_GROWTH'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_income">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_INCOME'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_INCOME'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'INCOME^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'INCOME^')][1],'INCOME^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'INCOME'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>		
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_INCOME'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_hedging">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_HEDGING'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_HEDGING'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'HEDGING^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'HEDGING^')][1],'HEDGING^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'HEDGING'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>	
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_HEDGING'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_leveraged_return_profile">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_LEVERAGED_RETURN_PROFILE'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_LEVERAGED_RETURN_PROFILE'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'LEVERAGED.RETURN.PROFILE^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'LEVERAGED.RETURN.PROFILE^')][1],'LEVERAGED.RETURN.PROFILE^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'LEVERAGED.RETURN.PROFILE'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>		
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_LEVERAGED_RETURN_PROFILE'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_pension_scheme_germany">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_PENSION_SCHEME_GERMANY'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_PENSION_SCHEME_GERMANY'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'PENSION.SCHEME.GERMANY^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'PENSION.SCHEME.GERMANY^')][1],'PENSION.SCHEME.GERMANY^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'PENSION.SCHEME.GERMANY'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
					<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>			
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_PENSION_SCHEME_GERMANY'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_financial_instrument_considers_client_sustainability_preferences">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA Objectives_OBJ_FIN_INST_CPT_CLT_ESG_PREF'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_FIN_INST_CPT_CLT_ESG_PREF'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:investObjectiveList/b:investObjective[starts-with(., 'FIN.INST.CPT.CLT.ESG.PREF^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:investObjectiveList/b:investObjective[starts-with(., 'FIN.INST.CPT.CLT.ESG.PREF^')][1],'FIN.INST.CPT.CLT.ESG.PREF^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:investObjectiveList/b:investObjective[. = 'FIN.INST.CPT.CLT.ESG.PREF'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>	
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'OBJ_FIN_INST_CPT_CLT_ESG_PREF'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investObjective_custom"/>
	<xsl:template name="allowedInvestor">
		<xsl:call-template name="allowedInvestor_retail"/>
		<xsl:call-template name="allowedInvestor_professional"/>
		<xsl:call-template name="allowedInvestor_eligible_counterparty"/>
		<xsl:call-template name="allowedInvestor_custom"/>
	</xsl:template>
	<xsl:template name="allowedInvestor_retail">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_RETAIL'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'RETAIL'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[starts-with(., 'RETAIL^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:allowedInvestorList/b:allowedInvestor[starts-with(., 'RETAIL^')][1],'RETAIL^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[. = 'RETAIL'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>	
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'RETAIL'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_professional">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_PROFESSIONAL'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'PROFESSIONAL'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[starts-with(., 'PROFESSIONAL^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:allowedInvestorList/b:allowedInvestor[starts-with(., 'PROFESSIONAL^')][1],'PROFESSIONAL^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[. = 'PROFESSIONAL'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>	
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'PROFESSIONAL'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_eligible_counterparty">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA allowedInvestor_ELIGIBLE_COUNTERPARTY'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ELIGIBLE_COUNTERPARTY'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[starts-with(., 'ELIGIBLE.COUNTERPARTY^')][1] != ''">
						<xsl:value-of select="translate(substring-after(b:allowedInvestorList/b:allowedInvestor[starts-with(., 'ELIGIBLE.COUNTERPARTY^')][1],'ELIGIBLE.COUNTERPARTY^'), '.', '_')"/>
					</xsl:when>
					<xsl:when test="b:allowedInvestorList/b:allowedInvestor[. = 'ELIGIBLE.COUNTERPARTY'][1] != ''">
						<xsl:value-of select="'YES'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>	
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ELIGIBLE_COUNTERPARTY'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_ALLOWED_INVESTOR'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="allowedInvestor_custom"/>
	<xsl:template name="riskLevel">
		<xsl:call-template name="riskLevel_riskLevel"/>
		<xsl:call-template name="riskLevel_custom"/>
	</xsl:template>
	<xsl:template name="riskLevel_riskLevel">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA riskLevel_RISK_LEVEL'"/>
			</xsl:attribute>
			<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="'RISK_LEVEL'"/>
			</infra:code>
		</busIndicatorElt>
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_RISK_LEVEL'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
        <instrument>
            <infra:code>
                 <xsl:choose>
                     <xsl:when test="starts-with(b:id, 'DX*')">
                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                     </xsl:when>
                     <xsl:otherwise>
                         <xsl:value-of select="b:id"/>      
                     </xsl:otherwise>
                 </xsl:choose>
            </infra:code>
        </instrument>
		<provider>
			<infra:code>
				<xsl:value-of select="b:tmaProvider" />
			</infra:code>
		</provider>
		<status>
			<xsl:value-of select="'20'"/>
		</status>
		<validity>
			<xsl:value-of select="b:tmaRefDate"/>
		</validity>
		<biValueType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:riskLevel">
						<xsl:value-of select="translate(b:riskLevel, '.', '_')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'UNDEFINED'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biValueType>
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'RISK_LEVEL'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'MIFID_TMA_RISK_LEVEL'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="riskLevel_custom"/>
	<xsl:template name="investTenor">
		<xsl:call-template name="investTenor_tenor_veryshort"/>
		<xsl:call-template name="investTenor_tenor_short"/>
		<xsl:call-template name="investTenor_tenor_medium"/>
		<xsl:call-template name="investTenor_tenor_long"/>
		<xsl:call-template name="investTenor_custom"/>
	</xsl:template>
	<xsl:template name="investTenor_tenor_veryshort">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_VERYSHORT'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_VERYSHORT'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
	        <instrument>
	            <infra:code>
	                 <xsl:choose>
	                     <xsl:when test="starts-with(b:id, 'DX*')">
	                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                         <xsl:value-of select="b:id"/>      
	                     </xsl:otherwise>
	                 </xsl:choose>
	            </infra:code>
	        </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor and b:investTenorList/b:investTenor = 'VERYSHORT'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_short">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_SHORT'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_SHORT'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
	        <instrument>
	            <infra:code>
	                 <xsl:choose>
	                     <xsl:when test="starts-with(b:id, 'DX*')">
	                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                         <xsl:value-of select="b:id"/>      
	                     </xsl:otherwise>
	                 </xsl:choose>
	            </infra:code>
	        </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor and b:investTenorList/b:investTenor = 'SHORT'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_medium">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_MEDIUM'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_MEDIUM'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
	        <instrument>
	            <infra:code>
	                 <xsl:choose>
	                     <xsl:when test="starts-with(b:id, 'DX*')">
	                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                         <xsl:value-of select="b:id"/>      
	                     </xsl:otherwise>
	                 </xsl:choose>
	            </infra:code>
	        </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor and b:investTenorList/b:investTenor = 'MEDIUM'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="investTenor_tenor_long">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA investTenor_TIME_HOR_TENOR_LONG'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'TIME_HOR_TENOR_LONG'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
	        <instrument>
	            <infra:code>
	                 <xsl:choose>
	                     <xsl:when test="starts-with(b:id, 'DX*')">
	                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                         <xsl:value-of select="b:id"/>      
	                     </xsl:otherwise>
	                 </xsl:choose>
	            </infra:code>
	        </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<flag>
				<xsl:choose>
					<xsl:when test="b:investTenorList/b:investTenor and b:investTenorList/b:investTenor = 'LONG'">
						<xsl:value-of select="'1'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'2'"/>
					</xsl:otherwise>
				</xsl:choose>
			</flag>
		</InstrBiValue>
	</xsl:template>		
	<xsl:template name="investTenor_custom"/>
	<xsl:template name="experienceRequired">
		<xsl:call-template name="experienceRequired_basicInvestor"/>
		<xsl:call-template name="experienceRequired_informedInvestor"/>
		<xsl:call-template name="experienceRequired_advancedInvestor"/>
		<xsl:call-template name="experienceRequired_expert_investor_germany"/>
		<xsl:call-template name="experienceRequired_custom"/>
	</xsl:template>
	<xsl:template name="experienceRequired_basicInvestor">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA experineceRequired_BASIC_INVESTOR'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'BASIC_INVESTOR'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
	        <instrument>
	            <infra:code>
	                 <xsl:choose>
	                     <xsl:when test="starts-with(b:id, 'DX*')">
	                         <xsl:value-of select="translate(b:id, 'DX*', '')"/>
	                     </xsl:when>
	                     <xsl:otherwise>
	                         <xsl:value-of select="b:id"/>      
	                     </xsl:otherwise>
	                 </xsl:choose>
	            </infra:code>
	        </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:expReqList/b:expReq[starts-with(., 'BASIC.INVESTOR^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:expReqList/b:expReq[starts-with(., 'BASIC.INVESTOR^')][1],'BASIC.INVESTOR^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:expReqList/b:expReq[. = 'BASIC.INVESTOR'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'BASIC_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="experienceRequired_informedInvestor">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA experineceRequired_INFORMED_INVESTOR'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'INFORMED_INVESTOR'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:expReqList/b:expReq[starts-with(., 'INFORMED.INVESTOR^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:expReqList/b:expReq[starts-with(., 'INFORMED.INVESTOR^')][1],'INFORMED.INVESTOR^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:expReqList/b:expReq[. = 'INFORMED.INVESTOR'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'INFORMED_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="experienceRequired_advancedInvestor">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA experienceRequired_ADVANCED_INVESTOR'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'ADVANCED_INVESTOR'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:expReqList/b:expReq[starts-with(., 'ADVANCED.INVESTOR^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:expReqList/b:expReq[starts-with(., 'ADVANCED.INVESTOR^')][1],'ADVANCED.INVESTOR^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:expReqList/b:expReq[. = 'ADVANCED.INVESTOR'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'ADVANCED_INVESTOR'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="experienceRequired_expert_investor_germany">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA experienceRequired_EXPERT_INVESTOR_GERMANY'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EXPERT_INVESTOR_GERMANY'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:expReqList/b:expReq[starts-with(., 'EXPERT.INVESTOR.GERMANY^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:expReqList/b:expReq[starts-with(., 'EXPERT.INVESTOR.GERMANY^')][1],'EXPERT.INVESTOR.GERMANY^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:expReqList/b:expReq[. = 'EXPERT.INVESTOR.GERMANY'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EXPERT_INVESTOR_GERMANY'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_EXPERIENCE_REQ'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="experienceRequired_custom"/>
	<xsl:template name="objectives">
		<xsl:call-template name="objectives_otherObjectives"/>
		<xsl:call-template name="objectives_custom"/>
	</xsl:template>
	<xsl:template name="objectives_otherObjectives">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA objectives_OTHEROBJ_SPECIFIC_INV_NEED'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'OTHEROBJ_SPECIFIC_INV_NEED'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:othrObjectivesList/b:othrObjectives[1] and b:othrObjectivesList/b:othrObjectives[1]!=''">
							<xsl:value-of select="translate(b:othrObjectivesList/b:othrObjectives[1], '.', '_')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'OTHEROBJ_SPECIFIC_INV_NEED'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_CL_INV_OBJECTIVE_NEEDS'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="objectives_custom"/>
	<xsl:template name="distributionStrategy">
		<xsl:call-template name="distributionStrategy_executionOnly"/>
		<xsl:call-template name="distributionStrategy_executionWithAppropriatnvessTestorNonAdvisedServices"/>
		<xsl:call-template name="distributionStrategy_investmentAdvice"/>
		<xsl:call-template name="distributionStrategy_portfolioManagement"/>
		<xsl:call-template name="distributionStrategy_custom"/>
	</xsl:template>
	<xsl:template name="distributionStrategy_executionOnly">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA distributionStrategy_EXECUTION_ONLY'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EXECUTION_ONLY'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'EXECUTION.ONLY^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'EXECUTION.ONLY^')][1],'EXECUTION.ONLY^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[. = 'EXECUTION.ONLY'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EXECUTION_ONLY'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="distributionStrategy_executionWithAppropriatnvessTestorNonAdvisedServices">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA distributionStrategy_EX_APP_TEST_OR_NON_AD_SERV'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EX_APP_TEST_OR_NON_AD_SERV'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'EX.APP.TEST.OR.NON.AD.SERV^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'EX.APP.TEST.OR.NON.AD.SERV^')][1],'EX.APP.TEST.OR.NON.AD.SERV^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[. = 'EX.APP.TEST.OR.NON.AD.SERV'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>	
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'EX_APP_TEST_OR_NON_AD_SERV'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="distributionStrategy_investmentAdvice">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA distributionStrategy_INVESTMENT_ADVICE'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'INVESTMENT_ADVICE'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'INVESTMENT.ADVICE^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'INVESTMENT.ADVICE^')][1],'INVESTMENT.ADVICE^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[. = 'INVESTMENT.ADVICE'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>	
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'INVESTMENT_ADVICE'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="distributionStrategy_portfolioManagement">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA distributionStrategy_PORTFOLIO_MANAGEMENT'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'PORTFOLIO_MANAGEMENT'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'PORTFOLIO.MANAGEMENT^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:distributionStrtgyList/b:distributionStrtgy[starts-with(., 'PORTFOLIO.MANAGEMENT^')][1],'PORTFOLIO.MANAGEMENT^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:distributionStrtgyList/b:distributionStrtgy[. = 'PORTFOLIO.MANAGEMENT'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'PORTFOLIO_MANAGEMENT'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_DISTRIBUTION_STRTGY'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="distributionStrategy_custom"/>
	<xsl:template name="lossTolerance">
		<xsl:call-template name="lossTolerance_none"/>
		<xsl:call-template name="lossTolerance_limited"/>
		<xsl:call-template name="lossTolerance_noGuarantee"/>
		<xsl:call-template name="lossTolerance_beyondInitial"/>
		<xsl:call-template name="lossTolerance_custom"/>
	</xsl:template>
	<xsl:template name="lossTolerance_none">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA lossTolerance_NONE'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'NONE'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[starts-with(., 'NONE^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:lossToleranceList/b:lossTolerance[starts-with(., 'NONE^')][1],'NONE^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[. = 'NONE'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>					
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'NONE'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="lossTolerance_limited">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA lossTolerance_LIMITED'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'LIMITED'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[starts-with(., 'LIMITED^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:lossToleranceList/b:lossTolerance[starts-with(., 'LIMITED^')][1],'LIMITED^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[. = 'LIMITED'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>	
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'LIMITED'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="lossTolerance_noGuarantee">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA lossTolerance_NO_GUARANTEE'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'NO_GUARANTEE'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[starts-with(., 'NO.GUARANTEE^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:lossToleranceList/b:lossTolerance[starts-with(., 'NO.GUARANTEE^')][1],'NO.GUARANTEE^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[. = 'NO.GUARANTEE'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>				
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'NO_GUARANTEE'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="lossTolerance_beyondInitial">
		<InstrBiValue>
			<xsl:attribute name="description">
				<xsl:value-of select="'Mifid TMA lossTolerance_BEYOND_INITIAL'"/>
			</xsl:attribute>
			<busIndicatorElt>
				<infra:code>
					<xsl:value-of select="'BEYOND_INITIAL'"/>
				</infra:code>
			</busIndicatorElt>
			<busIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</busIndicatorEltbusIndicator>
            <instrument>
                <infra:code>
                     <xsl:choose>
                         <xsl:when test="starts-with(b:id, 'DX*')">
                             <xsl:value-of select="translate(b:id, 'DX*', '')"/>
                         </xsl:when>
                         <xsl:otherwise>
                             <xsl:value-of select="b:id"/>      
                         </xsl:otherwise>
                     </xsl:choose>
                </infra:code>
            </instrument>
			<provider>
				<infra:code>
					<xsl:value-of select="b:tmaProvider" />
				</infra:code>
			</provider>
			<status>
				<xsl:value-of select="'20'"/>
			</status>
			<validity>
				<xsl:value-of select="b:tmaRefDate"/>
			</validity>
			<biValueType>
				<infra:code>
					<xsl:choose>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[starts-with(., 'BEYOND.INITIAL^')][1] != ''">
							<xsl:value-of select="translate(substring-after(b:lossToleranceList/b:lossTolerance[starts-with(., 'BEYOND.INITIAL^')][1],'BEYOND.INITIAL^'), '.', '_')"/>
						</xsl:when>
						<xsl:when test="b:lossToleranceList/b:lossTolerance[. = 'BEYOND.INITIAL'][1] != ''">
							<xsl:value-of select="'YES'"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="'UNDEFINED'"/>
						</xsl:otherwise>
					</xsl:choose>
				</infra:code>
			</biValueType>				
			<biValueTypeBusIndicatorElt>
				<infra:code>
					<xsl:value-of select="'BEYOND_INITIAL'"/>
				</infra:code>
			</biValueTypeBusIndicatorElt>
			<biValueTypeBusIndicatorEltbusIndicator>
				<infra:code>
					<xsl:value-of select="'MIFID_TMA_LOSS_TOLERANCE'"/>
				</infra:code>
			</biValueTypeBusIndicatorEltbusIndicator>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="lossTolerance_custom"/>
	<xsl:template name="mifid_tma_custom"/>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

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