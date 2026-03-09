<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b c d e f g ns0 batch multibatch" version="1.0" 
	xmlns="http://www.odcgroup.com/TransactionPMS" 
	xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" 
	xmlns:b="http://www.temenos.com/T24/event/TTI/TPHServiceFlow" 
	xmlns:c="http://www.temenos.com/T24/event/TTI/MultiTPHServiceFlow" 
	xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchTPHServiceFlow" 
	xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiTPHServiceFlow" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:d="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFull" 
	xmlns:e="http://www.temenos.com/T24/PaymentsEventsService/PorTransactionFullAdditional" 
	xmlns:f="http://www.temenos.com/T24/PaymentsEventsService/PorPostingAndConfirmation" 
	xmlns:g="http://www.temenos.com/T24/PaymentsEventsService/AccountDetails" 
	xmlns:infra="http://www.odcgroup.com/InfraPMS" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Core.xsl"/>
	<xsl:import href="../GlobalTemplate/GlobalTemplate-Custo.xsl"/>
	<xsl:import href="TransactionPaymentOutgoingTPH-Core.xsl"/>
	<xsl:import href="TransactionPaymentOutgoingTPH-Custo.xsl"/>
	<xsl:import href="TransactionPaymentOutgoingTPH.xsl"/>
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<!-- 	
			No templates defined here.
			This master file will execute
			the templates from the core and custo files.
	-->
</xsl:stylesheet>