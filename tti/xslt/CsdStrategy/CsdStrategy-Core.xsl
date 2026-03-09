<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/generic" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.odcgroup.com/generic/generic.xsd" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdStrategy" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCsdStrategy" exclude-result-prefixes="b c ns0" version="1.0">
	<xsl:template name="businessEntityComposition"/>
	<!--	<xsl:if test="b:ownCompId and b:ownCompId != ''">
			<businessEntityComposition>
				<businessEntity>
					<code>
						<xsl:value-of select="b:ownCompId"/>
					</code>
				</businessEntity>
				<mainBusinessEntity>1</mainBusinessEntity>
				<role>0</role>
				<type>
					<code>OWNCOMPANY</code>
				</type>
			</businessEntityComposition>
		</xsl:if>
		<xsl:if test="b:portCompId and b:portCompId != ''">
			<businessEntityComposition>
				<businessEntity>
					<code>
						<xsl:value-of select="b:portCompId"/>
					</code>
				</businessEntity>
				<mainBusinessEntity>0</mainBusinessEntity>
				<role>0</role>
				<type>
					<code>ACCTCOMPANY</code>
				</type>
			</businessEntityComposition>
		</xsl:if>
		<xsl:if test="b:coCode and b:coCode != ''">
			<businessEntityComposition>
				<businessEntity>
					<code>
						<xsl:value-of select="b:coCode"/>
					</code>
				</businessEntity>
				<mainBusinessEntity>0</mainBusinessEntity>
				<role>0</role>
				<type>
					<code>FILECOMPANY</code>
				</type>
			</businessEntityComposition>
		</xsl:if> 
	</xsl:template> -->
	<xsl:template name="userDefinedField">
		<attribute name="strategy_id.code" type="string">
			<xsl:value-of select="b:csdPtfInvPrf"/>
		</attribute>
		<attribute name="strategy_id.nature_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="linked_entity_dict_id.sqlname_c" type="string">
			<xsl:value-of select="'portfolio'"/>
		</attribute>
		<attribute name="object_id.code" type="string">
			<xsl:value-of select="b:id"/>
		</attribute>
		<attribute name="link_nat_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="begin_d" type="date">
			<xsl:choose>
				<xsl:when test="(not(../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf) or ../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf = '') or (../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf != ../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf) ">
					<xsl:value-of select="../../c:CurrentEvent/b:CsdStrategy/b:eventCommon/ns0:today"/>
				</xsl:when>
				<xsl:when test="(../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf) = (../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf)">
					<xsl:value-of select="../../c:PreviousEvent/b:CsdStrategy/b:eventCommon/ns0:today"/>
				</xsl:when>
			</xsl:choose>
		</attribute>
		<attribute name="priority_n" type="string">
			<xsl:value-of select="1"/>
		</attribute>
		<attribute name="mandatory_f" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="data_secu_prof_id.code" type="string">
			<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
		</attribute>
		<attribute name="privilege_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
	</xsl:template>
	<xsl:template name="userDefinedField_Previous">
		<attribute name="strategy_id.code" type="string">
			<xsl:value-of select="../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf"/>
		</attribute>
		<attribute name="strategy_id.nature_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="linked_entity_dict_id.sqlname_c" type="string">
			<xsl:value-of select="'portfolio'"/>
		</attribute>
		<attribute name="object_id.code" type="string">
			<xsl:value-of select="b:id"/>
		</attribute>
		<attribute name="link_nat_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="begin_d" type="date">
			<xsl:value-of select="../../c:PreviousEvent/b:CsdStrategy/b:eventCommon/ns0:today"/>
		</attribute>
		<!--attribute name="end_d" type="date">
            <xsl:choose>
                <xsl:when test="(../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf != ../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf) ">
                    <xsl:value-of select="../../c:CurrentEvent/b:CsdStrategy/b:eventCommon/ns0:today-1"/>
                </xsl:when>
            </xsl:choose>
        </attribute-->
		<xsl:if test='../../c:PreviousEvent/b:CsdStrategy/b:eventCommon/ns0:today'>
			<attribute name="end_d" type="date">
				<xsl:choose>
					<xsl:when test="(../../c:CurrentEvent/b:CsdStrategy/b:eventCommon/ns0:today = ../../c:PreviousEvent/b:CsdStrategy/b:eventCommon/ns0:today) ">
						<xsl:value-of select="../../c:PreviousEvent/b:CsdStrategy/b:eventCommon/ns0:today"/>
					</xsl:when>
					<xsl:when test="(../../c:PreviousEvent/b:CsdStrategy/b:csdPtfInvPrf != ../../c:CurrentEvent/b:CsdStrategy/b:csdPtfInvPrf) ">
						<xsl:variable name="string2date" select="b:eventCommon/ns0:today"/>
						<xsl:variable name="year" select="substring($string2date, 1, 4)"/>
						<xsl:variable name="month" select="substring($string2date, 6, 2)"/>
						<xsl:variable name="day" select="substring($string2date, 9, 2)"/>
						<xsl:variable name="prevDay" select="number($day) - 1"/>
						<xsl:variable name="adjustedDate">
							<xsl:choose>
								<xsl:when test="$prevDay &gt; 0">
									<xsl:value-of select="concat($year, '-', $month, '-', format-number($prevDay, '00'))"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="prevMonth" select="number($month) - 1"/>
									<xsl:choose>
										<xsl:when test="$prevMonth = 0">
											<xsl:value-of select="concat($year - 1, '-12-31')"/>
										</xsl:when>
										<xsl:when test="$prevMonth = 1 or $prevMonth = 3 or $prevMonth = 5 or $prevMonth = 7 or $prevMonth = 8 or $prevMonth = 10">
											<xsl:value-of select="concat($year, '-', format-number($prevMonth, '00'), '-31')"/>
										</xsl:when>
										<xsl:when test="$prevMonth = 4 or $prevMonth = 6 or $prevMonth = 9 or $prevMonth = 11">
											<xsl:value-of select="concat($year, '-', format-number($prevMonth, '00'), '-30')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="concat($year, '-02-28')"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="($adjustedDate)"/>
					</xsl:when>
				</xsl:choose>
			</attribute>
		</xsl:if>
		<attribute name="priority_n" type="string">
			<xsl:value-of select="1"/>
		</attribute>
		<attribute name="mandatory_f" type="string">
			<xsl:value-of select="0"/>
		</attribute>
		<attribute name="data_secu_prof_id.code" type="string">
			<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
		</attribute>
		<attribute name="privilege_e" type="string">
			<xsl:value-of select="0"/>
		</attribute>
	</xsl:template>
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