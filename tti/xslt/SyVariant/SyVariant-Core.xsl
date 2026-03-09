<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS"
                xmlns:b="http://www.temenos.com/T24/event/TTI/SyVariant"
                xmlns:c="http://www.temenos.com/T24/event/TTI/MultiSyVariant"
                xmlns:d="http://www.temenos.com/T24/event/Common/EventCommon"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="b c d"
                version="1.0">
	<xsl:template name="code">
		<code>
			<xsl:value-of select="b:id"/>
		</code>
	</xsl:template>
	<xsl:template name="shortName">
		<shortName>
			<xsl:value-of select="b:id"/>
		</shortName>
	</xsl:template>
	<xsl:template name="longName">
		<longName>
			<xsl:value-of select="b:descriptionList/b:description"/>
		</longName>
	</xsl:template>
	<xsl:template name="attribute">
      <attribute>contract_type_id</attribute>
   </xsl:template>
	<xsl:template name="synonym"/>
	<xsl:template name="multilingualLongName"/>
	<xsl:template name="notepad"/>
	<xsl:template name="userDefinedField"/>
	<xsl:template name="mbFields"/>
	<xsl:template name="nature"/>
</xsl:stylesheet>