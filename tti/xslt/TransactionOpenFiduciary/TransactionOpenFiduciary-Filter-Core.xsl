<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/FdFiduciary" xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchFdFiduciary" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiFdFiduciary" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:infra="http://www.odcgroup.com/InfraPMS" xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiFdFiduciary" exclude-result-prefixes="b c batch multibatch" version="1.0">
  <!-- START of protected area  -->
  <!-- Do not change ! -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <!-- END of protected area  -->
  <!-- Condition 1 -->
  <xsl:template match="b:FdFiduciary">
    <xsl:apply-templates select="self::b:FdFiduciary" mode="filter-custo"/>
  </xsl:template>
  <xsl:template match="b:FdFiduciary" mode="filter-custo">
    <xsl:apply-templates select="self::b:FdFiduciary" mode="filter-final"/>
  </xsl:template>
  <xsl:template match="b:FdFiduciary" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="b:orderNosGroup">
    <xsl:variable name="index" select="@index"/>
    <xsl:apply-templates select="self::node()[../b:memoAccountList/b:memoAccount[@index=$index] = 'NO']" mode="filter1"/>
  </xsl:template>
  <xsl:template match="b:orderNosGroup" mode="filter1">
    <xsl:variable name="index" select="@index"/>
    <xsl:apply-templates select="self::node()[not(../b:dealerBookList/b:dealerBook[@index=$index])]" mode="filter2"/>
  </xsl:template>
  <xsl:template match="b:orderNosGroup" mode="filter2">
    <xsl:variable name="index" select="@index"/>
    <xsl:apply-templates select="self::node()[../b:customerTypeGroup[@index=$index]/b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter3"/>
  </xsl:template>
  <xsl:template match="b:orderNosGroup" mode="filter3">
    <xsl:variable name="index" select="@index"/>
       	
        <xsl:variable name="check_toDay">
            <xsl:choose>
                <xsl:when test="string-length(../b:eventCommon/ns0:today) ='8'">
                    <xsl:value-of select="b:eventCommon/ns0:today"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(translate(../b:eventCommon/ns0:today,'-',''),1,8)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="check_contractValueDate">
                    <xsl:value-of select="substring(translate(../b:fdFidOrderValueDateList/b:fdFidOrderValueDate[@index = $index] ,'-',''),1,8)"/>
        </xsl:variable>        
		
	    <xsl:apply-templates select="self::node()[
	    		(../b:fidType = 'FIXED' and
	    		 (
	    		 	(../b:fidStatus = 'CUR' and ../../../c:PreviousEvent/b:FdFiduciary/b:fidStatus= 'FWD' 
	    		 		and (../b:eventCommon/ns0:application = 'FD.EOD.PROCESS.SCHEDULES' or ../b:eventCommon/ns0:application = 'FD.SOD.PROCESS.SCHEDULES') and $check_toDay = $check_contractValueDate)
	    		 	or
	    		 	(../b:fidStatus = 'CUR' and ../b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE'
	    		 		and not(../../../c:PreviousEvent/b:FdFiduciary/b:fidStatus)
	    		 		and $check_toDay >= $check_contractValueDate)	    		 		
	    		 )
	    		)
	    		or
	    		(../b:fidType = 'NOTICE' and 
	    		    (
		    			(../b:fidStatus = 'CUR' and (../b:eventCommon/ns0:application = 'FD.EOD.PROCESS.SCHEDULES' or ../b:eventCommon/ns0:application = 'FD.SOD.PROCESS.SCHEDULES') 
		    				and $check_toDay = $check_contractValueDate and not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup[@index = $index]/b:orderAmt)	
		    			)
		    			or
	    				(../b:fidStatus = 'CUR' and ../../../c:PreviousEvent/b:FdFiduciary/b:fidStatus= 'FWD' 
	    		 			and (../b:eventCommon/ns0:application = 'FD.EOD.PROCESS.SCHEDULES' or ../b:eventCommon/ns0:application = 'FD.SOD.PROCESS.SCHEDULES') and $check_toDay = $check_contractValueDate)
		    		)
		    		or
		    		(
		    			(../b:fidStatus = 'CUR' and ../b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE'
		    				and $check_toDay = $check_contractValueDate and not(../../../c:PreviousEvent/b:FdFiduciary/b:orderNosGroup[@index = $index]/b:orderNos)	
		    			)
		    			or
		    		 	(../b:fidStatus = 'CUR' and ../b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE' 
		    		 		and not(../../../c:PreviousEvent/b:FdFiduciary/b:fidStatus)
		    		 		and $check_toDay = $check_contractValueDate)	    			
		    		)
		    		or 
		    		  (
		    		  	../b:fidStatus = 'CUR' and ../b:eventCommon/ns0:transactionStage = 'INPUT-AUTHORISE' 
		    		 		and not(../../../c:PreviousEvent/b:FdFiduciary/b:fidStatus)
		    		 		and  $check_toDay > $check_contractValueDate
		    		  
		    		)
	    		)
	    		or 
	    		(../b:eventCommon/ns0:transactionStage = 'REVERSE-AUTHORISE')
	    	
	    	
	    	]" mode="filter-custo"/>
	  </xsl:template>  
  <xsl:template match="b:orderNosGroup" mode="filter-custo">
    <xsl:apply-templates select="self::node()" mode="filter-final"/>
  </xsl:template>
  <xsl:template match="b:orderNosGroup" mode="filter-final">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="TransactionOpenFiduciary" userelativepaths="yes" externalpreview="no" url="..\..\TestFiles\TransactionOpenFiduciary\TransactionOpenFiduciary.xml" htmlbaseurl=""
		          outputurl="..\..\TestFiles\TransactionOpenFiduciary\TransactionOpenFiduciaryCusto.xml" processortype="saxon8" useresolver="no" profilemode="0" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath=""
		          additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal" customvalidator="">
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
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->
