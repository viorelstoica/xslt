<?xml version="1.0"?>
<xsl:stylesheet xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="infra" version="1.0">
	<xsl:template name="printDxExecutionFeesAndTaxes">
		<xsl:param name="caller"/>
		<xsl:call-template name="PRI.TAX.CODE"/>
		<xsl:call-template name="PRI.TAX.TYPE"/>
		<xsl:call-template name="TAX.AMT.ACY"/>
		<xsl:call-template name="PRI.COMM.TYP"/>
		<xsl:call-template name="PRI.COMM.CDE"/>
		<xsl:call-template name="PRI.COMM.CCY"/>
		<xsl:call-template name="PRI.COMM.AMT"/>
		<xsl:call-template name="PRI.COMM.ACC"/>
	</xsl:template>
	 <xsl:template name="PRI.TAX.CODE">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_9_amount_m']/infra:value != 'NULL'">
         <field name="PRI.TAX.CODE">
            <xsl:value-of select="'USWHT'"/>
         </field>
      </xsl:if>
   </xsl:template>
    <xsl:template name="PRI.TAX.TYPE">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_9_amount_m']/infra:value != 'NULL'">
         <field name="PRI.TAX.TYPE">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
   </xsl:template>
    <xsl:template name="TAX.AMT.ACY">
      <field name="TAX.AMT.ACY">
         <xsl:value-of select="*[local-name() = 'userDefinedField'][infra:name='bp_9_amount_m']/infra:value"/>
      </field>
   </xsl:template>
     <xsl:template name="PRI.COMM.TYP">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.TYP:1:1">
            <xsl:value-of select="'CLEARING'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.TYP:1:2">
            <xsl:value-of select="'COMMISSION'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.TYP:1:3">
            <xsl:value-of select="'EXECUTION'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.TYP:1:4">
            <xsl:value-of select="'MISC'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.TYP:1:5">
            <xsl:value-of select="'REGULATORY'"/>
         </field>
      </xsl:if>
   </xsl:template>
    <xsl:template name="PRI.COMM.CDE">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CDE:1:1">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CDE:1:2">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CDE:1:3">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CDE:1:4">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CDE:1:5">
            <xsl:value-of select="'OVERRIDE'"/>
         </field>
      </xsl:if>
   </xsl:template>
    <xsl:template name="PRI.COMM.CCY">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CCY:1:1">
            <xsl:value-of select="*[local-name() = 'transactionFeesTaxesCounter'][5]/*[local-name() = 'currency']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CCY:1:2">
            <xsl:value-of select="*[local-name() = 'transactionFeesTaxesCounter'][4]/*[local-name() = 'currency']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CCY:1:3">
            <xsl:value-of select="*[local-name() = 'transactionFeesTaxesCounter'][3]/*[local-name() = 'currency']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CCY:1:4">
            <xsl:value-of select="*[local-name() = 'transactionFeesTaxesCounter'][7]/*[local-name() = 'currency']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.CCY:1:5">
            <xsl:value-of select="*[local-name() = 'transactionFeesTaxesCounter'][2]/*[local-name() = 'currency']/infra:code"/>
         </field>
      </xsl:if>
   </xsl:template>
    <xsl:template name="PRI.COMM.AMT">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.AMT:1:1">
            <xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value,',','')*(-1)"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.AMT:1:2">
            <xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value,',','')*(-1)"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.AMT:1:3">
            <xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value,',','')*(-1)"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.AMT:1:4">
            <xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value,',','')*(-1)"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.AMT:1:5">
            <xsl:value-of select="translate(*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value,',','')*(-1)"/>
         </field>
      </xsl:if>
   </xsl:template>
   <xsl:template name="PRI.COMM.ACC">
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_5_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.ACC:1:1">
            <xsl:value-of select="*[local-name() = 'account1']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_4_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.ACC:1:2">
            <xsl:value-of select="*[local-name() = 'account1']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_3_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.ACC:1:3">
            <xsl:value-of select="*[local-name() = 'account1']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_7_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.ACC:1:4">
            <xsl:value-of select="*[local-name() = 'account1']/infra:code"/>
         </field>
      </xsl:if>
      <xsl:if test="*[local-name() = 'userDefinedField'][infra:name='bp_2_amount_m']/infra:value != 'NULL'">
         <field name="PRI.COMM.ACC:1:5">
            <xsl:value-of select="*[local-name() = 'account1']/infra:code"/>
         </field>
      </xsl:if>
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