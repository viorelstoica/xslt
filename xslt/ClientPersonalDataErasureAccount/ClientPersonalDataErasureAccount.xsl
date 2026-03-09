<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/FiPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ClientPersonalDataErasure"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchClientPersonalDataErasure" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiClientPersonalDataErasure" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiClientPersonalDataErasure" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<xsl:output encoding="UTF-8" indent="yes" method="xml"/>
	<xsl:template match="c:MultiClientPersonalDataErasure">
		<xsl:apply-templates select="c:CurrentEvent/b:ClientPersonalDataErasure"/>
	</xsl:template>
	<xsl:template match="batch:BatchClientPersonalDataErasure">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchClientPersonalDataErasure" name="BatchClientPersonalDataErasure">
			<xsl:apply-templates select="b:ClientPersonalDataErasure"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="multibatch:BatchMultiClientPersonalDataErasure">
		<xsl:element xmlns="http://www.temenos.com/T24/event/TTI/BatchMultiClientPersonalDataErasure" name="BatchMultiClientPersonalDataErasure">
			<xsl:apply-templates select="c:MultiClientPersonalDataErasure"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="b:ClientPersonalDataErasure">
		<FiPMS>
			<xsl:attribute name="mode">INSUPD</xsl:attribute>
			<xsl:attribute name="output">
				<xsl:value-of select="concat('ClientPersonalDataErasureAccount',b:id)"/>
			</xsl:attribute>
			<xsl:variable name="acctId" select="substring-before(substring-after(substring-after(b:id,'*'),'*'),'*')"/>
			<xsl:variable name="fileType" select="substring-before(substring-after(substring-after(substring-after(b:id,'*'),'*'),'*'),'*')"/>
			<xsl:if test="$acctId = 'ACCOUNT' and $fileType = 'HIS'">
			<DataGroup>
				<CashAccount>
					<xsl:attribute name="description">
						<xsl:value-of select="concat('ClientPersonalDataErasureAccount.xsl+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
					</xsl:attribute>
					<xsl:attribute name="sequenceNumber">
						<xsl:call-template name="calcSeqNum">
							<xsl:with-param name="creationTime">
								<xsl:value-of select="b:eventCommon/ns0:creationTime"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:call-template name="infra:code"/>
					<xsl:call-template name="infra:synonym"/>
					<xsl:call-template name="infra:shortName"/>
					<xsl:call-template name="infra:longName"/>
					<xsl:call-template name="infra:multilingualLongName"/>
					<xsl:call-template name="infra:notepad"/>
					<xsl:call-template name="infra:userDefinedField"/>
					<xsl:call-template name="infra:mbFields"/>
					<xsl:call-template name="accrualRule"/>
					<xsl:call-template name="accruedInterestCalculation"/>
					<xsl:call-template name="accruedInterestRoundingRule"/>
					<xsl:call-template name="accruedInterestRoundingUnit"/>
					<xsl:call-template name="accruedInterestUnitaryRounding"/>
					<xsl:call-template name="active"/>
					<xsl:call-template name="euroConversionDate"/>
					<xsl:call-template name="euroConversionRule"/>
					<xsl:call-template name="euroNewInstrument"/>
					<xsl:call-template name="mainBusinessEntity"/>
					<xsl:call-template name="priceCalculationRule"/>
					<xsl:call-template name="referenceCurrency"/>
					<xsl:call-template name="riskCountry"/>
					<xsl:call-template name="riskNature"/>
					<xsl:call-template name="subType"/>
					<xsl:call-template name="taxCountry"/>
					<xsl:call-template name="tradable"/>
					<xsl:call-template name="type"/>
					<xsl:call-template name="valuationRule"/>
					<xsl:call-template name="openingDate"/>
					<xsl:call-template name="interestAccrualDate"/>
					<xsl:call-template name="closingDate"/>
					<xsl:call-template name="eomConvention"/>
					<xsl:call-template name="client"/>
					<xsl:call-template name="parentCashAccount"/>
					<xsl:call-template name="portfolio"/>
					<xsl:call-template name="suspenseAccount"/>
					<xsl:call-template name="witholdingTax"/>
				</CashAccount>
			</DataGroup>
			</xsl:if>
		</FiPMS>
	</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="CashAccount" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CashAccount\CashAccount.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CashAccount\CashAccount_Custo.xml" processortype="jaxp"
		          useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath=""
		          postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="no" name="CashAccountType" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\CashAccountType\CashAccountType.xml" htmlbaseurl="" outputurl="..\..\TestFiles\CashAccountType\CashAccountTypeGWP.xml"
		          processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline=""
		          postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
		<scenario default="no" name="Country.xml" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\Country\Country.xml" htmlbaseurl="" outputurl="..\..\TestFiles\Country\CountryGWP.xml" processortype="saxon8" useresolver="no"
		          profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""
		          validateoutput="no" validator="internal" customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->