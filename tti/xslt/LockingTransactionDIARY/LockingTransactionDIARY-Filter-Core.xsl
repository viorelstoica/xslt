<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/TransactionPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/LockingTransactionCOA"
                xmlns:batch="http://www.temenos.com/T24/event/TTI/BatchLockingTransactionCOA" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiLockingTransactionCOA" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:multibatch="http://www.temenos.com/T24/event/TTI/BatchMultiLockingTransactionCOA" exclude-result-prefixes="b c batch multibatch ns0" version="1.0">
	<!-- START of protected area  -->
    <!-- START of protected area  -->
    <!-- Do not change ! -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!-- END of protected area  -->
    <!-- Condition 1 -->
    <xsl:template match="b:LockingTransactionCOA">
        <xsl:apply-templates select="self::b:LockingTransactionCOA[b:memoAccountSecAccMasterJoin = 'NO']" mode="filter1"/>
    </xsl:template>
    <!-- Condition 2 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter1">
        <xsl:apply-templates select="self::b:LockingTransactionCOA[not(b:dealerBookSecAccMasterJoin)]" mode="filter2"/>
    </xsl:template>
    <!-- Condition 3 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter2">
        <xsl:apply-templates select="self::b:LockingTransactionCOA[b:customerTypeList/b:customerType = 'CUSTOMER']" mode="filter3"/>
    </xsl:template>
    <!-- Condition 4 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter3">
        <xsl:apply-templates select="self::b:LockingTransactionCOA[($g_filterBySubAssetType='Y' and b:subAssetTypeJoin and contains(concat(' ',$list_SubAssetType_LockingTransactionCOA,' '),concat(' ',b:subAssetTypeJoin,' '))) or
									($g_filterBySubAssetType != 'Y' and b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='STOCK' or b:subAssetTypeTapInstrType='MUTUALFUND' or b:subAssetTypeTapInstrType='FIXEDINCOME' or b:subAssetTypeTapInstrType='CONVBOND' or 
									 b:subAssetTypeTapInstrType='DISCINSTR' or b:subAssetTypeTapInstrType='COMMODITY' or b:subAssetTypeTapInstrType='AIRBAGCERT' or b:subAssetTypeTapInstrType='BONUSNOTES' or b:subAssetTypeTapInstrType='CAPPROTNOT' or 
									 b:subAssetTypeTapInstrType='CAPPROTNOTWC' or b:subAssetTypeTapInstrType='DISCOUNTCERT' or b:subAssetTypeTapInstrType='MEMORYCOUPNOT' or b:subAssetTypeTapInstrType='TWINWINCERT' or b:subAssetTypeTapInstrType='REVCONVBONDLK' or 
									 b:subAssetTypeTapInstrType='REVCONVEQLK' or b:subAssetTypeTapInstrType='REVCONVCREDLK' or b:subAssetTypeTapInstrType='MINIFUTTURBO1' or b:subAssetTypeTapInstrType='MINIFUTTURBO2'))]" mode="filter4"/>
    </xsl:template>
    <!-- Condition 5 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter4">
        <xsl:apply-templates select="self::b:LockingTransactionCOA[b:blockType = 'DIARY']" mode="filter5"/>
    </xsl:template>
    <!-- Condition 6 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter5">
        <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
                <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
                <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:apply-templates select="self::b:LockingTransactionCOA[$opStatus = 'INPUT-INPUT' or $opStatus = 'INPUT-DELETE' or $opStatus = 'INPUT-AUTHORISE']" mode="filter6"/>
    </xsl:template>
    <!-- Condition 7 -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter6">
        <xsl:variable name="check_PayDateJoin">
            <xsl:choose>
                <xsl:when test="string-length(b:PayDateJoin) ='8'">
                    <xsl:value-of select="b:PayDateJoin"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(translate(b:PayDateJoin,'-',''),1,8)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="check_toDay">
            <xsl:choose>
                <xsl:when test="string-length(b:eventCommon/ns0:today) ='8'">
                    <xsl:value-of select="b:eventCommon/ns0:today"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(translate(b:eventCommon/ns0:today,'-',''),1,8)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="check_diaryDateTime">
            <xsl:call-template name="t24DateTimeToDate">
                <xsl:with-param name="t24ProvidedDate" select="b:diaryDateTimeList[1]/b:diaryDateTime"/>
            </xsl:call-template>        
        </xsl:variable>
        <xsl:variable name="opStatus">
            <xsl:call-template name="operationStatus">
                <xsl:with-param name="transactionStage" select="b:eventCommon/ns0:transactionStage"/>
                <xsl:with-param name="recordStatus" select="b:recordStatus"/>
            </xsl:call-template>
        </xsl:variable>         
        <xsl:apply-templates select="self::b:LockingTransactionCOA[number($check_PayDateJoin) &gt;= number($check_toDay)
          or 
           (
            ($opStatus = 'INPUT-DELETE' or $opStatus = 'INPUT-AUTHORISE')
            and 
            number($check_diaryDateTime) &lt; number($check_PayDateJoin)
           )
        ]" mode="filter-custo"/>
    </xsl:template>
    <!-- Custo placeholder -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter-custo">
        <xsl:apply-templates select="self::b:LockingTransactionCOA" mode="filter-final"/>
    </xsl:template>
    <!-- Copy block -->
    <xsl:template match="b:LockingTransactionCOA" mode="filter-final">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
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