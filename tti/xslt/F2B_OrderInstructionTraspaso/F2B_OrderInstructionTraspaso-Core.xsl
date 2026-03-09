<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="b" version="1.0" xmlns="http://www.temenos.com/T24/OFSML/150" xmlns:b="http://www.odcgroup.com/F2B" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Filter out this flow since this is only ESP(Spain) business entity specific -->
	<xsl:template name="PORTFOLIO.ID"/>
	<xsl:template name="SOURCE.FUND"/>
	<xsl:template name="BIC.IDEN.BANK"/>
	<xsl:template name="EXT.BANK.NAME"/>
	<xsl:template name="AC.HOLDER"/>
	<xsl:template name="EXT.SEC.NO"/>
	<xsl:template name="TARGET.FUND"/>
	<xsl:template name="DEPOSITORY"/>
	<xsl:template name="REQUEST.TYPE"/>
	<xsl:template name="VALUE.TYPE"/>
	<xsl:template name="SHARES.ORDERED"/>
	<xsl:template name="NET.AMOUNT"/>
	<xsl:template name="TRADE.DATE"/>
	<xsl:template name="VALUE.DATE"/>
	<xsl:template name="REQUEST.DATE"/>
	<xsl:template name="TRANS.IN.STATUS"/>
	<xsl:template name="TAP.REF.ID"/>
	<xsl:template name="TAP.EVENT.ID"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios/>
</metaInformation>
-->