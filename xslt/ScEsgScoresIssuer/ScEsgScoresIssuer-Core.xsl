<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/BusIndicator"   xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon"  xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgScores" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgScores" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c ns0" version="1.0">

	<!--ESG_RATING_GLOBAL_RATING-->
	<xsl:template name="esg-rating-global-rating">
		<ThirdBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-RATING+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>    		
			<xsl:call-template name="esg-rating-global-rating-busIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-rating-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-rating-instrument-code"/>
			<xsl:call-template name="esg-rating-global-rating-provider-code"/>
			<xsl:call-template name="esg-rating-global-rating-biType-code"/>
			<xsl:call-template name="esg-rating-global-rating-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-rating-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-rating-status"/>
			<xsl:call-template name="esg-rating-global-rating-currency"/>
			<xsl:call-template name="esg-rating-global-rating-dateTime"/>
			<xsl:call-template name="esg-rating-global-rating-validity"/>
			<xsl:call-template name="esg-rating-global-rating-flag"/>
			<xsl:call-template name="esg-rating-global-rating-number"/>
			<xsl:call-template name="esg-rating-global-rating-percentForThreshold"/>
			<xsl:call-template name="esg-rating-global-rating-percent"/>
			<xsl:call-template name="esg-rating-global-rating-text"/>
			<xsl:call-template name="esg-rating-global-rating-amount"/>
			<xsl:call-template name="esg-rating-global-rating-biValueType"/>
			<xsl:call-template name="esg-rating-global-rating-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-rating-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-rating-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-rating-global-rating-userDefinedField"/>
		</ThirdBiValue>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_GLOBAL_RATING</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-instrument-code">
		<thirdParty>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:scIssuer and b:scIssuer != ''">
						<xsl:choose>
							<xsl:when test="$ISSUER_PREFIX != ''">
								<xsl:value-of select="concat($ISSUER_PREFIX,b:scIssuer)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:scIssuer"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$CUSTOMER_PREFIX != ''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:issuerId)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:issuerId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</thirdParty>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-biType-code"/>
	<xsl:template name="esg-rating-global-rating-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-global-rating-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-global-rating-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-currency"/>
	<xsl:template name="esg-rating-global-rating-dateTime"/>
	<xsl:template name="esg-rating-global-rating-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-flag"/>
	<xsl:template name="esg-rating-global-rating-number"/>
	<xsl:template name="esg-rating-global-rating-percentForThreshold"/>
	<xsl:template name="esg-rating-global-rating-percent"/>
	<xsl:template name="esg-rating-global-rating-text"/>
	<xsl:template name="esg-rating-global-rating-amount"/>
	<xsl:template name="esg-rating-global-rating-biValueType">
		<biValueType>
			<infra:code>
				<xsl:value-of select="b:overallRating"/>
			</infra:code>
		</biValueType>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-biValueTypeBusIndicatorElt-code">
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_RAT_GLOBAL_RATING'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_RATING'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-rating-global-rating-userDefinedField"/>



	<!--ESG_RATING_GLOBAL_SCORE-->
	<xsl:template name="esg-rating-global-score">
		<ThirdBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>    		
			<xsl:call-template name="esg-rating-global-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-score-instrument-code"/>
			<xsl:call-template name="esg-rating-global-score-provider-code"/>
			<xsl:call-template name="esg-rating-global-score-biType-code"/>
			<xsl:call-template name="esg-rating-global-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-score-status"/>
			<xsl:call-template name="esg-rating-global-score-currency"/>
			<xsl:call-template name="esg-rating-global-score-dateTime"/>
			<xsl:call-template name="esg-rating-global-score-validity"/>
			<xsl:call-template name="esg-rating-global-score-flag"/>
			<xsl:call-template name="esg-rating-global-score-number"/>
			<xsl:call-template name="esg-rating-global-score-percentForThreshold"/>
			<xsl:call-template name="esg-rating-global-score-percent"/>
			<xsl:call-template name="esg-rating-global-score-text"/>
			<xsl:call-template name="esg-rating-global-score-amount"/>
			<xsl:call-template name="esg-rating-global-score-biValueType"/>
			<xsl:call-template name="esg-rating-global-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-global-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-global-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-rating-global-score-userDefinedField"/>
		</ThirdBiValue>
	</xsl:template>

	<xsl:template name="esg-rating-global-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_GLOBAL_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-instrument-code">
		<thirdParty>
			<infra:code>
				<xsl:choose>
					<xsl:when test="b:scIssuer and b:scIssuer != ''">
						<xsl:choose>
							<xsl:when test="$ISSUER_PREFIX != ''">
								<xsl:value-of select="concat($ISSUER_PREFIX,b:scIssuer)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:scIssuer"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$CUSTOMER_PREFIX != ''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,b:issuerId)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="b:issuerId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</thirdParty>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-biType-code"/>
	<xsl:template name="esg-rating-global-score-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-global-score-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-global-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-currency"/>
	<xsl:template name="esg-rating-global-score-dateTime"/>
	<xsl:template name="esg-rating-global-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-rating-global-score-flag"/>
	<xsl:template name="esg-rating-global-score-number">
		<number>
			<xsl:value-of select="b:ratingOverallScore"/>
		</number>
	</xsl:template>

	<xsl:template name="esg-rating-global-score-percentForThreshold"/>
	<xsl:template name="esg-rating-global-score-percent"/>
	<xsl:template name="esg-rating-global-score-text"/>
	<xsl:template name="esg-rating-global-score-amount"/>
	<xsl:template name="esg-rating-global-score-biValueType"/>
	<xsl:template name="esg-rating-global-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-global-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-global-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-rating-global-score-userDefinedField"/>

	<!--*********************************************************-->
	<xsl:template name="esg-rating-environment-score"/>
	<xsl:template name="esg-rating-environment-weight"/>
	<xsl:template name="esg-rating-social-score"/>
	<xsl:template name="esg-rating-social-weight"/>
	<xsl:template name="esg-rating-government-score"/>
	<xsl:template name="esg-rating-government-weight"/>
	<xsl:template name="esg-controversies-overall-score"/>
	<xsl:template name="esg-controversies-overall-flag"/>
	<xsl:template name="esg-controversies-overall-summary"/>
	<xsl:template name="esg-controversies-env-score"/>
	<xsl:template name="esg-controversies-env-flag"/>
	<xsl:template name="esg-controversies-social-score"/>
	<xsl:template name="esg-controversies-social-flag"/>
	<xsl:template name="esg-controversies-govern-score"/>
	<xsl:template name="esg-controversies-govern-flag"/>
	<xsl:template name="esg-ratings-below-pillar"/>
	<xsl:template name="esg-controversies-below-pillar"/>
	<xsl:template name="esg-screening-values"/>
	<xsl:template name="esg-government-pillar-score"/>
	<xsl:template name="esg-environment-pillar-score"/>
	<xsl:template name="esg-environment-pillar-weight"/>
	<xsl:template name="esg-government-pillar-weight"/>

	<!--************************************************-->


	<!--sdg-values-->
	<xsl:template name="esg-sdg-values">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'SDG'">
				<ThirdBiValue>
					<xsl:call-template name="esg-sdg-values-busIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-values-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-values-instrument-code"/>
					<xsl:call-template name="esg-sdg-values-provider-code"/>
					<xsl:call-template name="esg-sdg-values-biType-code"/>
					<xsl:call-template name="esg-sdg-values-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-values-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-values-status"/>
					<xsl:call-template name="esg-sdg-values-currency"/>
					<xsl:call-template name="esg-sdg-values-dateTime"/>
					<xsl:call-template name="esg-sdg-values-validity"/>
					<xsl:call-template name="esg-sdg-values-flag"/>
					<xsl:call-template name="esg-sdg-values-number"/>
					<xsl:call-template name="esg-sdg-values-percentForThreshold"/>
					<xsl:call-template name="esg-sdg-values-percent"/>
					<xsl:call-template name="esg-sdg-values-text"/>
					<xsl:call-template name="esg-sdg-values-amount"/>
					<xsl:call-template name="esg-sdg-values-biValueType"/>
					<xsl:call-template name="esg-sdg-values-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-values-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-values-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-sdg-values-userDefinedField"/>
				</ThirdBiValue>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="esg-sdg-values-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sdg-values-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_SDG</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-sdg-values-instrument-code">
		<thirdParty>
			<infra:code>
				<xsl:choose>
					<xsl:when test="../../b:scIssuer and ../../b:scIssuer != ''">
						<xsl:choose>
							<xsl:when test="$ISSUER_PREFIX != ''">
								<xsl:value-of select="concat($ISSUER_PREFIX,../../b:scIssuer)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../b:scIssuer"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$CUSTOMER_PREFIX != ''">
								<xsl:value-of select="concat($CUSTOMER_PREFIX,../../b:issuerId)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../b:issuerId"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</thirdParty>
	</xsl:template>
	<xsl:template name="esg-sdg-values-provider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
        </biValueTypeProvider>  
	</xsl:template>
	<xsl:template name="esg-sdg-values-biType-code"/>
	<xsl:template name="esg-sdg-values-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-sdg-values-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-sdg-values-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-sdg-values-currency"/>
	<xsl:template name="esg-sdg-values-dateTime"/>
	<xsl:template name="esg-sdg-values-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='SDG']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-sdg-values-flag"/>
	<xsl:template name="esg-sdg-values-number"/>
	<xsl:template name="esg-sdg-values-percentForThreshold"/>
	<xsl:template name="esg-sdg-values-percent"/>
	<xsl:template name="esg-sdg-values-text"/>
	<xsl:template name="esg-sdg-values-amount"/>
	<xsl:template name="esg-sdg-values-biValueType">
		<xsl:variable name="index" select="@index"/>
		<biValueType>
			<infra:code>
				<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
			</infra:code>
		</biValueType>
	</xsl:template>

	<xsl:template name="esg-sdg-values-biValueTypeBusIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sdg-values-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_SDG'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-sdg-values-biValueTypeProvider-code">
        <provider>
            <infra:code>
                <xsl:value-of select="../../b:provider"/>
            </infra:code>
        </provider>	
	</xsl:template>
	<xsl:template name="esg-sdg-values-userDefinedField"/>

	<!--esg-sdg-classification-->
	<xsl:template name="esg-sdg-classification"/>
	<xsl:template name="esg-sdg-classification-other"/>
	<xsl:template name="esg-eu-taxonomy"/>
	<xsl:template name="esg-sfdr-advers-impacts"/>
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