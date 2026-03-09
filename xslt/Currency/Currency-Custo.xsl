<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/Currency" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiCurrency" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c" version="1.0">
    <!-- START of protected area  -->
	<xsl:template name="userDefinedField_Currency">
    	<userDefinedField>
        <name>
            <xsl:value-of select="'ud_precious_metal_f'"/>
        </name>
        <value>
            <xsl:choose>
                <xsl:when test="b:preciousMetal ='YES'">
                    <xsl:value-of select="1"/>
                </xsl:when>
                <xsl:when test="b:preciousMetal ='NO'">
                    <xsl:value-of select="0"/>
                </xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'0'"/>
			</xsl:otherwise>
            </xsl:choose>
        </value>
    </userDefinedField>
	</xsl:template>
    <!-- END of protected area  -->
</xsl:stylesheet>
