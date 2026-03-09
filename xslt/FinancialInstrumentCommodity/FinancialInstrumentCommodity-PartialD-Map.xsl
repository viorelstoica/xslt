<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c batch multibatch"
    version="1.0" xmlns="http://www.odcgroup.com/FiPMS"
    xmlns:b="http://www.temenos.com/T24/event/TTI/FinancialInstrumentSecurity"
    xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFinancialInstrumentSecurity"
    xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFinancialInstrumentSecurity"
    xmlns:infra="http://www.odcgroup.com/InfraPMS"
    xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFinancialInstrumentSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
    <xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
    <xsl:import href="FinancialInstrumentCommodity-Core.xsl"/>
    <xsl:import href="FinancialInstrumentCommodity-Custo.xsl"/>
    <xsl:import href="FinancialInstrumentCommodity-PartialD-Core.xsl"/>
    <xsl:import href="FinancialInstrumentCommodity-PartialD-Custo.xsl"/>
    <xsl:import href="FinancialInstrumentCommodity-PartialD.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>
