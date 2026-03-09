<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurityCob" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurityCob" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b c ns0" version="1.0">
    <!-- START of protected area  -->
    <xsl:template name="userDefinedField">    	
		<userDefinedField>
        <name>
            <xsl:value-of select="'ud_ndma_dma_e'"/>
        </name>
        <value>
            <xsl:choose>
                <xsl:when test="b:csdNdmaDma ='None'">
                    <xsl:value-of select="0"/>
                </xsl:when>
                <xsl:when test="b:csdNdmaDma ='DMA'">
                    <xsl:value-of select="1"/>
                </xsl:when>           
                <xsl:when test="b:csdNdmaDma ='NDMA'">
                    <xsl:value-of select="2"/>
                </xsl:when>
            </xsl:choose>
        </value>
    </userDefinedField>
		    <userDefinedField>
        <name>
            <xsl:value-of select="'ud_structure_note_e'"/>
        </name>
        <value>
            <xsl:choose>
                <xsl:when test="b:structureNotes ='Blank'">
                    <xsl:value-of select="0"/>
                </xsl:when>            
                <xsl:when test="b:structureNotes ='YES'">
                    <xsl:value-of select="1"/>
                </xsl:when>                
            </xsl:choose>
        </value>
    </userDefinedField>
	<xsl:variable name="PEAEligibility">
    <xsl:for-each select="b:instrumentTypeGroup/b:instrumentType">
        <xsl:if test=". = 'PEA.Eligible'">
            <xsl:value-of select="'1'"/>
        </xsl:if>
    </xsl:for-each>
	</xsl:variable>

	<xsl:variable name="PEASME">
    <xsl:for-each select="b:instrumentTypeGroup/b:instrumentType">
        <xsl:if test=". = 'PEA.SME'">
            <xsl:value-of select="'1'"/>
        </xsl:if>
    </xsl:for-each>
	</xsl:variable>

	<infra:userDefinedField>
    <infra:name>ud_pea_eligible_e</infra:name>
    <infra:value>
        <xsl:choose>
            <xsl:when test="contains($PEAEligibility, '1') and contains($PEASME, '1')">
                <xsl:value-of select="'3'"/>
            </xsl:when>
            <xsl:when test="contains($PEAEligibility, '') and contains($PEASME, '1')">
                <xsl:value-of select="'2'"/>
            </xsl:when>
            <xsl:when test="contains($PEAEligibility, '1') and contains($PEASME, '')">
                <xsl:value-of select="'1'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'0'"/>
            </xsl:otherwise>
        </xsl:choose>
    </infra:value>
	</infra:userDefinedField>
	
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_sc_irs_code_e'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdIrsCode ='1'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdIrsCode ='2'">
                    <xsl:value-of select="2"/>
                </xsl:when>
                <xsl:when test="b:csdIrsCode ='3'">
                    <xsl:value-of select="3"/>
                </xsl:when>	
                <xsl:when test="b:csdIrsCode =''">
                    <xsl:value-of select="0"/>
                </xsl:when>				
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
    <infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_issue_date_d'"/>
        </infra:name>
        <infra:value>
		<xsl:if test="b:issueDate!='' and b:issueDate">
            <xsl:value-of select="concat(substring(b:issueDate, 9, 2),'-',substring(b:issueDate, 6, 2),'-',substring(b:issueDate, 1, 4))"/>
        </xsl:if>
		</infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>ud_domicile_id.code</infra:name>
        <infra:value>
            <xsl:value-of select="b:securityDomicile"/>
        </infra:value>
    </infra:userDefinedField>
	</xsl:template>
    <!-- END of protected area  -->
</xsl:stylesheet>
