<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/PositionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/PositionsAADepositsLendings" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" exclude-result-prefixes="b ns0" version="1.0">
   <xsl:template name="amount">
      <xsl:variable name="TotalAccr" select="format-number(sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:openBalance) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:creditMvmt) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'CURACCOUNT')]/b:openBalanceSubGroup/b:debitMvmt),'0.00','nan2zero')"/>
      <xsl:variable name="TotalAccr1" select="format-number(sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'DUEACCOUNT')]/b:openBalanceSubGroup/b:openBalance) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'DUEACCOUNT')]/b:openBalanceSubGroup/b:creditMvmt) + sum(b:typeSysdateGroup[starts-with(b:typeSysdate,'DUEACCOUNT')]/b:openBalanceSubGroup/b:debitMvmt),'0.00','nan2zero')"/>
      <xsl:variable name="TotalCommitmentDep" select="format-number(b:typeSysdateGroup[starts-with(b:typeSysdate,'TOTCOMMITMENT-')][last()]/b:openBalanceSubGroup/b:creditMvmt,'0.00','nan2zero')"/>
      <xsl:variable name="TotalCommitmentLoan" select="format-number(b:typeSysdateGroup[starts-with(b:typeSysdate,'TOTCOMMITMENT-')][last()]/b:openBalanceSubGroup/b:debitMvmt,'0.00','nan2zero')"/>
      <amount>
         <xsl:choose>
            <xsl:when test="b:arrStatus = 'CURRENT'">
		         <xsl:choose>
		            <xsl:when test="b:productLine = 'DEPOSITS'">
		               <xsl:value-of select="$TotalAccr"/>
		            </xsl:when>
		            <xsl:when test="b:productLine = 'LENDING'">
		               <xsl:value-of select="($TotalAccr + $TotalAccr1)"/>
		            </xsl:when>
		         </xsl:choose>
		     </xsl:when>
		     <xsl:when test="b:arrStatus = 'AUTH' or b:arrStatus = 'AUTH-FWD'">
                 <xsl:choose>
                    <xsl:when test="b:productLine = 'DEPOSITS'">
                       <xsl:value-of select="$TotalCommitmentDep"/>
                    </xsl:when>
                    <xsl:when test="b:productLine = 'LENDING'">
                       <xsl:value-of select="($TotalCommitmentLoan)"/>
                    </xsl:when>
                 </xsl:choose>		     
		     </xsl:when>
		 </xsl:choose>
      </amount>
   </xsl:template>
   <xsl:template name="accruedInterests">
      <accruedInterests>
         <xsl:value-of select="'0'"/>
      </accruedInterests>
   </xsl:template>
   <xsl:template name="initialLoadDate">
      <initialLoadDate>
         <xsl:value-of select="b:eventCommon/ns0:today"/>
      </initialLoadDate>
   </xsl:template>
   <xsl:template name="moneyMarket">
      <moneyMarket>
         <infra:code>
             <xsl:choose>
		 	<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
            	<xsl:value-of select="concat(b:arrangementId,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="b:arrangementId"/>
		    </xsl:otherwise>
		</xsl:choose>
         </infra:code>
      </moneyMarket>
   </xsl:template>
   <xsl:template name="portfolio">
      <portfolio>
         <infra:code>
            <xsl:value-of select="b:aaPortfolioList/b:aaPortfolio"/>
         </infra:code>
      </portfolio>
   </xsl:template>
   <xsl:template name="positionCode">
      <positionCode>
         <xsl:choose>
			<xsl:when test="$POSTFIX_AACOMNE = 'Y'">
        		 <xsl:value-of select="concat(b:id,$COMPANY_POSTFIX_SEPARATOR,b:coMnemonic,'-INIT')"/>
			</xsl:when>
			<xsl:otherwise>
				 <xsl:value-of select="concat(b:id,'-INIT')"/>
			</xsl:otherwise>
		</xsl:choose>
      </positionCode>
   </xsl:template>
   <xsl:template name="positionCurrency">
      <positionCurrency>
         <infra:code>
            <xsl:value-of select="b:operationCurrency"/>
         </infra:code>
      </positionCurrency>
   </xsl:template>
   <xsl:template name="referenceNature">
      <referenceNature>
         <xsl:value-of select="'0'"/>
      </referenceNature>
   </xsl:template>
   <xsl:template name="sourceCode">
      <sourceCode>
         <xsl:value-of select="b:id"/>
      </sourceCode>
   </xsl:template>
   <xsl:template name="status">
      <status>
        <xsl:choose>
            <xsl:when test="b:arrStatus = 'CURRENT'">
		         <xsl:call-template name="statusTranslation">
		            <xsl:with-param name="boStatus" select="'ACCOUNTED'"/>
		         </xsl:call-template>            
            </xsl:when>
            <xsl:when test="b:arrStatus = 'AUTH' or b:arrStatus = 'AUTH-FWD'">
                 <xsl:call-template name="statusTranslation">
                    <xsl:with-param name="boStatus" select="'PLACED'"/>
                 </xsl:call-template>                
            </xsl:when>
        </xsl:choose>

      </status>
   </xsl:template>
   <xsl:template name="type">
      <type>
         <infra:code>INITLOAD</infra:code>
      </type>
   </xsl:template>
   <xsl:template name="userDefinedField"/>
   <xsl:template name="mbFields"/>
   <xsl:template name="expirationDate"/>
   <xsl:template name="operationDate"/>
   <xsl:template name="positionExchangeRate"/>
   <xsl:template name="valueDate"/>
   <xsl:template name="interestRate"/>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="" htmlbaseurl="" outputurl="" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline=""
		          additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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