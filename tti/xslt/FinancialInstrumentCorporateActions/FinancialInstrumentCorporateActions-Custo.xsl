<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/CaEvent" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
	<xsl:template name="infra:userDefinedField">
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_allfunds_mir_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdAfbMirAva ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdAfbMirAva ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_traspasos_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdEligTrasp ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdEligTrasp ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdInvAvl ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdInvAvl ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	<infra:userDefinedField>
        <infra:name>
            <xsl:value-of select="'ud_inversis_mir_active_f'"/>
        </infra:name>
        <infra:value>
            <xsl:choose>
                <xsl:when test="b:csdInvAvlMir ='Yes'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:csdInvAvlMir ='No'">
                    <xsl:value-of select="0"/>
                </xsl:when>
            </xsl:choose>
        </infra:value>
    </infra:userDefinedField>
	</xsl:template>
	<xsl:template name="infra:longName">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
		<infra:longName>
			<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</infra:longName>
	</xsl:if>
</xsl:template>
<xsl:template name="infra:multilingualLongName">
	<xsl:if test="b:descriptList/b:descript[@language='GB'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'en'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='GB']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:if test="b:descriptList/b:descript[@language='FR'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'fr'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='FR']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:if test="b:descriptList/b:descript[@language='DE'] != ''">
		<infra:multilingualLongName>
			<infra:language>
				<xsl:value-of select="'de'"/>
			</infra:language>
			<infra:longName>
				<xsl:for-each select="b:descriptList/b:descript[@language='DE']">
					<xsl:value-of select="."/>
					<xsl:if test="position() != last()">
						<xsl:text> </xsl:text>
					</xsl:if>
				</xsl:for-each>
			</infra:longName>
		</infra:multilingualLongName>
	</xsl:if>
	<xsl:call-template name="OldNewDenomConcatManagment">
		<xsl:with-param name="CurrentEvent" select="./b:descriptList/b:descript"/>
		<xsl:with-param name="PreviousEvent" select="../../c:PreviousEvent/b:FinancialInstrumentSecurity/b:descriptList/b:descript"/>
	</xsl:call-template>
</xsl:template>
	<!-- END of protected area  -->
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