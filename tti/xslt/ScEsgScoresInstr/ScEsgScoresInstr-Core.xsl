<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/BusIndicator"  xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/ScEsgScores" xmlns:c="http://www.temenos.com/T24/event/TTI/MultiScEsgScores" xmlns:infra="http://www.odcgroup.com/InfraPMS"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b c ns0" version="1.0">

	<!--ESG_RATING_GLOBAL_RATING-->
	<xsl:template name="esg-rating-global-rating">
		<InstrBiValue>
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
		</InstrBiValue>
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
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
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
		<InstrBiValue>
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
		</InstrBiValue>
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
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
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



	<!--ESG_ENVIRONMENT_PILLAR_SCORE-->
	<xsl:template name="esg-environment-pillar-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-ENV-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>    		
			<xsl:call-template name="esg-environment-pillar-busIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-instrument-code"/>
			<xsl:call-template name="esg-environment-pillar-provider-code"/>
			<xsl:call-template name="esg-environment-pillar-biType-code"/>
			<xsl:call-template name="esg-environment-pillar-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-status"/>
			<xsl:call-template name="esg-environment-pillar-currency"/>
			<xsl:call-template name="esg-environment-pillar-dateTime"/>
			<xsl:call-template name="esg-environment-pillar-validity"/>
			<xsl:call-template name="esg-environment-pillar-flag"/>
			<xsl:call-template name="esg-environment-pillar-number"/>
			<xsl:call-template name="esg-environment-pillar-percentForThreshold"/>
			<xsl:call-template name="esg-environment-pillar-percent"/>
			<xsl:call-template name="esg-environment-pillar-text"/>
			<xsl:call-template name="esg-environment-pillar-amount"/>
			<xsl:call-template name="esg-environment-pillar-biValueType"/>
			<xsl:call-template name="esg-environment-pillar-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-environment-pillar-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_ENVIR_PILLAR_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-biType-code"/>
	<xsl:template name="esg-environment-pillar-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-environment-pillar-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-environment-pillar-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-currency"/>
	<xsl:template name="esg-environment-pillar-dateTime"/>
	<xsl:template name="esg-environment-pillar-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-flag"/>
	<xsl:template name="esg-environment-pillar-number">
		<number>
			<xsl:value-of select="b:ratingEPillarScore"/>
		</number>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-percentForThreshold"/>
	<xsl:template name="esg-environment-pillar-percent"/>
	<xsl:template name="esg-environment-pillar-text"/>
	<xsl:template name="esg-environment-pillar-amount"/>
	<xsl:template name="esg-environment-pillar-biValueType"/>
	<xsl:template name="esg-environment-pillar-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-environment-pillar-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-environment-pillar-biValueTypeProvider-code"/>
	<xsl:template name="esg-environment-pillar-userDefinedField"/>



	<!--esg-environment-pillar-weight-->
	<xsl:template name="esg-environment-pillar-weight">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-ENV-WEIGHT+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>  		
			<xsl:call-template name="esg-environment-pillar-weight-busIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-instrument-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-provider-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-biType-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-status"/>
			<xsl:call-template name="esg-environment-pillar-weight-currency"/>
			<xsl:call-template name="esg-environment-pillar-weight-dateTime"/>
			<xsl:call-template name="esg-environment-pillar-weight-validity"/>
			<xsl:call-template name="esg-environment-pillar-weight-flag"/>
			<xsl:call-template name="esg-environment-pillar-weight-number"/>
			<xsl:call-template name="esg-environment-pillar-weight-percentForThreshold"/>
			<xsl:call-template name="esg-environment-pillar-weight-percent"/>
			<xsl:call-template name="esg-environment-pillar-weight-text"/>
			<xsl:call-template name="esg-environment-pillar-weight-amount"/>
			<xsl:call-template name="esg-environment-pillar-weight-biValueType"/>
			<xsl:call-template name="esg-environment-pillar-weight-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-environment-pillar-weight-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>

	<xsl:template name="esg-environment-pillar-weight-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_ENVIR_PILLAR_WEIGHT</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-biType-code"/>
	<xsl:template name="esg-environment-pillar-weight-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-environment-pillar-weight-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-environment-pillar-weight-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-currency"/>
	<xsl:template name="esg-environment-pillar-weight-dateTime"/>
	<xsl:template name="esg-environment-pillar-weight-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-flag"/>
	<xsl:template name="esg-environment-pillar-weight-number">
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-percentForThreshold"/>
	<xsl:template name="esg-environment-pillar-weight-percent">
		<percent>
			<xsl:value-of select="b:ratingEWeight"/>
		</percent>
	</xsl:template>
	<xsl:template name="esg-environment-pillar-weight-text"/>
	<xsl:template name="esg-environment-pillar-weight-amount"/>
	<xsl:template name="esg-environment-pillar-weight-biValueType"/>
	<xsl:template name="esg-environment-pillar-weight-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-environment-pillar-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-environment-pillar-weight-biValueTypeProvider-code"/>
	<xsl:template name="esg-environment-pillar-weight-userDefinedField"/>



	<!--esg-rating-social-score-->
	<xsl:template name="esg-rating-social-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-SOCIAL-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>  		
			<xsl:call-template name="esg-rating-social-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-score-instrument-code"/>
			<xsl:call-template name="esg-rating-social-score-provider-code"/>
			<xsl:call-template name="esg-rating-social-score-biType-code"/>
			<xsl:call-template name="esg-rating-social-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-score-status"/>
			<xsl:call-template name="esg-rating-social-score-currency"/>
			<xsl:call-template name="esg-rating-social-score-dateTime"/>
			<xsl:call-template name="esg-rating-social-score-validity"/>
			<xsl:call-template name="esg-rating-social-score-flag"/>
			<xsl:call-template name="esg-rating-social-score-number"/>
			<xsl:call-template name="esg-rating-social-score-percentForThreshold"/>
			<xsl:call-template name="esg-rating-social-score-percent"/>
			<xsl:call-template name="esg-rating-social-score-text"/>
			<xsl:call-template name="esg-rating-social-score-amount"/>
			<xsl:call-template name="esg-rating-social-score-biValueType"/>
			<xsl:call-template name="esg-rating-social-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-rating-social-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>

	<xsl:template name="esg-rating-social-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_SOCIAL_PILLAR_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-biType-code"/>
	<xsl:template name="esg-rating-social-score-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-social-score-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-social-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-currency"/>
	<xsl:template name="esg-rating-social-score-dateTime"/>
	<xsl:template name="esg-rating-social-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-flag"/>
	<xsl:template name="esg-rating-social-score-number">
		<number>
			<xsl:value-of select="b:ratingSPillarScore"/>
		</number>
	</xsl:template>
	<xsl:template name="esg-rating-social-score-percentForThreshold"/>
	<xsl:template name="esg-rating-social-score-percent"/>
	<xsl:template name="esg-rating-social-score-text"/>
	<xsl:template name="esg-rating-social-score-amount"/>
	<xsl:template name="esg-rating-social-score-biValueType"/>
	<xsl:template name="esg-rating-social-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-social-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-social-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-rating-social-score-userDefinedField"/>


	<!--esg-rating-social-weight-->
	<xsl:template name="esg-rating-social-weight">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-SOCIAL-WEIGHT+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-rating-social-weight-busIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-weight-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-weight-instrument-code"/>
			<xsl:call-template name="esg-rating-social-weight-provider-code"/>
			<xsl:call-template name="esg-rating-social-weight-biType-code"/>
			<xsl:call-template name="esg-rating-social-weight-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-weight-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-weight-status"/>
			<xsl:call-template name="esg-rating-social-weight-currency"/>
			<xsl:call-template name="esg-rating-social-weight-dateTime"/>
			<xsl:call-template name="esg-rating-social-weight-validity"/>
			<xsl:call-template name="esg-rating-social-weight-flag"/>
			<xsl:call-template name="esg-rating-social-weight-number"/>
			<xsl:call-template name="esg-rating-social-weight-percentForThreshold"/>
			<xsl:call-template name="esg-rating-social-weight-percent"/>
			<xsl:call-template name="esg-rating-social-weight-text"/>
			<xsl:call-template name="esg-rating-social-weight-amount"/>
			<xsl:call-template name="esg-rating-social-weight-biValueType"/>
			<xsl:call-template name="esg-rating-social-weight-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-rating-social-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-rating-social-weight-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-rating-social-weight-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>

	<xsl:template name="esg-rating-social-weight-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_SOCIAL_PILLAR_WEIGHT</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-biType-code"/>
	<xsl:template name="esg-rating-social-weight-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-social-weight-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-social-weight-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-currency"/>
	<xsl:template name="esg-rating-social-weight-dateTime"/>
	<xsl:template name="esg-rating-social-weight-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-flag"/>
	<xsl:template name="esg-rating-social-weight-number"/>
	<xsl:template name="esg-rating-social-weight-percentForThreshold"/>
	<xsl:template name="esg-rating-social-weight-percent">
		<percent>
			<xsl:value-of select="b:ratingSWeight"/>
		</percent>
	</xsl:template>
	<xsl:template name="esg-rating-social-weight-text"/>
	<xsl:template name="esg-rating-social-weight-amount"/>
	<xsl:template name="esg-rating-social-weight-biValueType"/>
	<xsl:template name="esg-rating-social-weight-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-rating-social-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-rating-social-weight-biValueTypeProvider-code"/>
	<xsl:template name="esg-rating-social-weight-userDefinedField"/>


	<!--esg-rating-government-score-->
	<xsl:template name="esg-government-pillar-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-GOVERN-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-government-pillar-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-score-instrument-code"/>
			<xsl:call-template name="esg-government-pillar-score-provider-code"/>
			<xsl:call-template name="esg-government-pillar-score-biType-code"/>
			<xsl:call-template name="esg-government-pillar-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-score-status"/>
			<xsl:call-template name="esg-government-pillar-score-currency"/>
			<xsl:call-template name="esg-government-pillar-score-dateTime"/>
			<xsl:call-template name="esg-government-pillar-score-validity"/>
			<xsl:call-template name="esg-government-pillar-score-flag"/>
			<xsl:call-template name="esg-government-pillar-score-number"/>
			<xsl:call-template name="esg-government-pillar-score-percentForThreshold"/>
			<xsl:call-template name="esg-government-pillar-score-percent"/>
			<xsl:call-template name="esg-government-pillar-score-text"/>
			<xsl:call-template name="esg-government-pillar-score-amount"/>
			<xsl:call-template name="esg-government-pillar-score-biValueType"/>
			<xsl:call-template name="esg-government-pillar-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-government-pillar-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>

	<xsl:template name="esg-government-pillar-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_GOVERN_PILLAR_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-biType-code"/>
	<xsl:template name="esg-government-pillar-score-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-government-pillar-score-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-government-pillar-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-currency"/>
	<xsl:template name="esg-government-pillar-score-dateTime"/>
	<xsl:template name="esg-government-pillar-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-flag"/>
	<xsl:template name="esg-government-pillar-score-number">
		<number>
			<xsl:value-of select="b:ratingGPillarScore"/>
		</number>
	</xsl:template>
	<xsl:template name="esg-government-pillar-score-percentForThreshold"/>
	<xsl:template name="esg-government-pillar-score-percent"/>
	<xsl:template name="esg-government-pillar-score-text"/>
	<xsl:template name="esg-government-pillar-score-amount"/>
	<xsl:template name="esg-government-pillar-score-biValueType"/>
	<xsl:template name="esg-government-pillar-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-government-pillar-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-government-pillar-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-government-pillar-score-userDefinedField"/>

	<!--esg_government-pillar-weight-->
	<xsl:template name="esg-government-pillar-weight">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('GLOBAL-GOVERN-WEIGHT+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-government-pillar-weight-busIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-weight-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-weight-instrument-code"/>
			<xsl:call-template name="esg-government-pillar-weight-provider-code"/>
			<xsl:call-template name="esg-government-pillar-weight-biType-code"/>
			<xsl:call-template name="esg-government-pillar-weight-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-weight-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-weight-status"/>
			<xsl:call-template name="esg-government-pillar-weight-currency"/>
			<xsl:call-template name="esg-government-pillar-weight-dateTime"/>
			<xsl:call-template name="esg-government-pillar-weight-validity"/>
			<xsl:call-template name="esg-government-pillar-weight-flag"/>
			<xsl:call-template name="esg-government-pillar-weight-number"/>
			<xsl:call-template name="esg-government-pillar-weight-percentForThreshold"/>
			<xsl:call-template name="esg-government-pillar-weight-percent"/>
			<xsl:call-template name="esg-government-pillar-weight-text"/>
			<xsl:call-template name="esg-government-pillar-weight-amount"/>
			<xsl:call-template name="esg-government-pillar-weight-biValueType"/>
			<xsl:call-template name="esg-government-pillar-weight-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-government-pillar-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-government-pillar-weight-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-government-pillar-weight-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_RAT_GOVERN_PILLAR_WEIGHT</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-biType-code"/>
	<xsl:template name="esg-government-pillar-weight-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-government-pillar-weight-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-government-pillar-weight-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-currency"/>
	<xsl:template name="esg-government-pillar-weight-dateTime"/>
	<xsl:template name="esg-government-pillar-weight-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-flag"/>
	<xsl:template name="esg-government-pillar-weight-number"/>

	<xsl:template name="esg-government-pillar-weight-percentForThreshold"/>
	<xsl:template name="esg-government-pillar-weight-percent">
		<percent>
			<xsl:value-of select="b:ratingGWeight"/>
		</percent>
	</xsl:template>
	<xsl:template name="esg-government-pillar-weight-text"/>
	<xsl:template name="esg-government-pillar-weight-amount"/>
	<xsl:template name="esg-government-pillar-weight-biValueType"/>
	<xsl:template name="esg-government-pillar-weight-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-government-pillar-weight-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-government-pillar-weight-biValueTypeProvider-code"/>
	<xsl:template name="esg-government-pillar-weight-userDefinedField"/>

	<!--esg-controversies-overall-score-->
	<xsl:template name="esg-controversies-overall-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('CONTROVERSY-OVERALL-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-controversies-overall-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-overall-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-overall-score-instrument-code"/>
			<xsl:call-template name="esg-controversies-overall-score-provider-code"/>
			<xsl:call-template name="esg-controversies-overall-score-biType-code"/>
			<xsl:call-template name="esg-controversies-overall-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-overall-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-overall-score-status"/>
			<xsl:call-template name="esg-controversies-overall-score-currency"/>
			<xsl:call-template name="esg-controversies-overall-score-dateTime"/>
			<xsl:call-template name="esg-controversies-overall-score-validity"/>
			<xsl:call-template name="esg-controversies-overall-score-flag"/>
			<xsl:call-template name="esg-controversies-overall-score-number"/>
			<xsl:call-template name="esg-controversies-overall-score-percentForThreshold"/>
			<xsl:call-template name="esg-controversies-overall-score-percent"/>
			<xsl:call-template name="esg-controversies-overall-score-text"/>
			<xsl:call-template name="esg-controversies-overall-score-amount"/>
			<xsl:call-template name="esg-controversies-overall-score-biValueType"/>
			<xsl:call-template name="esg-controversies-overall-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-overall-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-overall-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-controversies-overall-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_OVERALL_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-biType-code">
		<biType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
									(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
						<xsl:value-of select="'NUMBER'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'PERCENT'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biType>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-biTypeBusIndicatorElt-code">
		<biTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_OVERALL_SCORE'"/>
			</infra:code>
		</biTypeBusIndicatorElt>
	</xsl:template>

	<xsl:template name="esg-controversies-overall-score-biTypeBusIndicatorEltbusIndicator-code">
		<biTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-currency"/>
	<xsl:template name="esg-controversies-overall-score-dateTime"/>
	<xsl:template name="esg-controversies-overall-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-flag"/>
	<xsl:template name="esg-controversies-overall-score-number">
		<xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
					 (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<number>
				<xsl:value-of select="b:controversyOverallScore"/>
			</number>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-percentForThreshold"/>
	<xsl:template name="esg-controversies-overall-score-percent">
		<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
					  (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<percent>
				<xsl:value-of select="b:controversyOverallScore"/>
			</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-score-text"/>
	<xsl:template name="esg-controversies-overall-score-amount"/>
	<xsl:template name="esg-controversies-overall-score-biValueType"/>
	<xsl:template name="esg-controversies-overall-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-overall-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-overall-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-controversies-overall-score-userDefinedField"/>

	<!--esg-controversies-overall-flag-->
	<xsl:template name="esg-controversies-overall-flag">
        <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
                                    (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
	        <InstrBiValue>
	            <xsl:attribute name="description">
	                <xsl:value-of select="concat('CONTROVERSY-OVERALL-FLAG+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
	            </xsl:attribute>    	        
	            <xsl:call-template name="esg-controversies-overall-flag-busIndicatorElt-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-busIndicatorEltbusIndicator-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-instrument-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-provider-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biType-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biTypeBusIndicatorElt-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biTypeBusIndicatorEltbusIndicator-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-status"/>
	            <xsl:call-template name="esg-controversies-overall-flag-currency"/>
	            <xsl:call-template name="esg-controversies-overall-flag-dateTime"/>
	            <xsl:call-template name="esg-controversies-overall-flag-validity"/>
	            <xsl:call-template name="esg-controversies-overall-flag-flag"/>
	            <xsl:call-template name="esg-controversies-overall-flag-number"/>
	            <xsl:call-template name="esg-controversies-overall-flag-percentForThreshold"/>
	            <xsl:call-template name="esg-controversies-overall-flag-percent"/>
	            <xsl:call-template name="esg-controversies-overall-flag-text"/>
	            <xsl:call-template name="esg-controversies-overall-flag-amount"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biValueType"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biValueTypeBusIndicatorElt-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biValueTypeBusIndicatorEltbusIndicator-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-biValueTypeProvider-code"/>
	            <xsl:call-template name="esg-controversies-overall-flag-userDefinedField"/>
	        </InstrBiValue>
        </xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_OVERALL_FLAG</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-biType-code"/>
	<xsl:template name="esg-controversies-overall-flag-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-overall-flag-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-overall-flag-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-currency"/>
	<xsl:template name="esg-controversies-overall-flag-dateTime"/>
	<xsl:template name="esg-controversies-overall-flag-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-flag"/>
	<xsl:template name="esg-controversies-overall-flag-number"/>

	<xsl:template name="esg-controversies-overall-flag-percentForThreshold"/>
	<xsl:template name="esg-controversies-overall-flag-percent"/>

	<xsl:template name="esg-controversies-overall-flag-text"/>
	<xsl:template name="esg-controversies-overall-flag-amount"/>
	<xsl:template name="esg-controversies-overall-flag-biValueType">
		<biValueType>
			<infra:code>
				<xsl:value-of select="b:controversyOverallFlag"/>
			</infra:code>
		</biValueType>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-biValueTypeBusIndicatorElt-code">
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_OVERALL_FLAG'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-flag-userDefinedField"/>


	<!--esg-controversies-overall-summary-->
	<xsl:template name="esg-controversies-overall-summary">
       <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
                                    (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<InstrBiValue>
	            <xsl:attribute name="description">
	                <xsl:value-of select="concat('CONTROVERSY-OVERALL-SUMMARY+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
	            </xsl:attribute>    			
				<xsl:call-template name="esg-controversies-overall-summary-busIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-instrument-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-provider-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-biType-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-status"/>
				<xsl:call-template name="esg-controversies-overall-summary-currency"/>
				<xsl:call-template name="esg-controversies-overall-summary-dateTime"/>
				<xsl:call-template name="esg-controversies-overall-summary-validity"/>
				<xsl:call-template name="esg-controversies-overall-summary-flag"/>
				<xsl:call-template name="esg-controversies-overall-summary-number"/>
				<xsl:call-template name="esg-controversies-overall-summary-percentForThreshold"/>
				<xsl:call-template name="esg-controversies-overall-summary-percent"/>
				<xsl:call-template name="esg-controversies-overall-summary-text"/>
				<xsl:call-template name="esg-controversies-overall-summary-amount"/>
				<xsl:call-template name="esg-controversies-overall-summary-biValueType"/>
				<xsl:call-template name="esg-controversies-overall-summary-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-controversies-overall-summary-userDefinedField"/>
			</InstrBiValue>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_OVERALL_SUMMARY</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-biType-code"/>
	<xsl:template name="esg-controversies-overall-summary-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-overall-summary-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-overall-summary-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-currency"/>
	<xsl:template name="esg-controversies-overall-summary-dateTime"/>
	<xsl:template name="esg-controversies-overall-summary-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-flag"/>
	<xsl:template name="esg-controversies-overall-summary-number"/>
	<xsl:template name="esg-controversies-overall-summary-percentForThreshold"/>
	<xsl:template name="esg-controversies-overall-summary-percent"/>
	<xsl:template name="esg-controversies-overall-summary-text">
		<text>
			<xsl:for-each select="b:controversyOverallSummaryList/b:controversyOverallSummary">
				<xsl:value-of select="."/>
			</xsl:for-each>
		</text>
	</xsl:template>
	<xsl:template name="esg-controversies-overall-summary-amount"/>
	<xsl:template name="esg-controversies-overall-summary-biValueType"/>
	<xsl:template name="esg-controversies-overall-summary-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-overall-summary-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-overall-summary-biValueTypeProvider-code"/>
	<xsl:template name="esg-controversies-overall-summary-userDefinedField"/>

	<!--esg-controversies-env-score-->
	<xsl:template name="esg-controversies-env-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('CONTROVERSY-ENV-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-controversies-env-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-env-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-env-score-instrument-code"/>
			<xsl:call-template name="esg-controversies-env-score-provider-code"/>
			<xsl:call-template name="esg-controversies-env-score-biType-code"/>
			<xsl:call-template name="esg-controversies-env-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-env-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-env-score-status"/>
			<xsl:call-template name="esg-controversies-env-score-currency"/>
			<xsl:call-template name="esg-controversies-env-score-dateTime"/>
			<xsl:call-template name="esg-controversies-env-score-validity"/>
			<xsl:call-template name="esg-controversies-env-score-flag"/>
			<xsl:call-template name="esg-controversies-env-score-number"/>
			<xsl:call-template name="esg-controversies-env-score-percentForThreshold"/>
			<xsl:call-template name="esg-controversies-env-score-percent"/>
			<xsl:call-template name="esg-controversies-env-score-text"/>
			<xsl:call-template name="esg-controversies-env-score-amount"/>
			<xsl:call-template name="esg-controversies-env-score-biValueType"/>
			<xsl:call-template name="esg-controversies-env-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-env-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-env-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-controversies-env-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_ENVIR_CONTROVERSY_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-biType-code">
		<biType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
									(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
						<xsl:value-of select="'NUMBER'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'PERCENT'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biType>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-biTypeBusIndicatorElt-code">
		<biTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_ENVIR_CONTROVERSY_SCORE'"/>
			</infra:code>
		</biTypeBusIndicatorElt>
	</xsl:template>

	<xsl:template name="esg-controversies-env-score-biTypeBusIndicatorEltbusIndicator-code">
		<biTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-currency"/>
	<xsl:template name="esg-controversies-env-score-dateTime"/>
	<xsl:template name="esg-controversies-env-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-flag"/>
	<xsl:template name="esg-controversies-env-score-number">
		<xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
									(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<number>
				<xsl:value-of select="b:controversyEPillarScore"/>
			</number>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-percentForThreshold"/>
	<xsl:template name="esg-controversies-env-score-percent">
		<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
						(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<percent>
				<xsl:value-of select="b:controversyEPillarScore"/>
			</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-env-score-text"/>
	<xsl:template name="esg-controversies-env-score-amount"/>
	<xsl:template name="esg-controversies-env-score-biValueType"/>
	<xsl:template name="esg-controversies-env-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-env-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-env-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-controversies-env-score-userDefinedField"/>

	<!--esg-controversies-env-flag-->
	<xsl:template name="esg-controversies-env-flag">
       <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
                                    (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<InstrBiValue>
	            <xsl:attribute name="description">
	                <xsl:value-of select="concat('CONTROVERSY-ENV-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
	            </xsl:attribute> 			
				<xsl:call-template name="esg-controversies-env-flag-busIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-env-flag-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-env-flag-instrument-code"/>
				<xsl:call-template name="esg-controversies-env-flag-provider-code"/>
				<xsl:call-template name="esg-controversies-env-flag-biType-code"/>
				<xsl:call-template name="esg-controversies-env-flag-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-env-flag-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-env-flag-status"/>
				<xsl:call-template name="esg-controversies-env-flag-currency"/>
				<xsl:call-template name="esg-controversies-env-flag-dateTime"/>
				<xsl:call-template name="esg-controversies-env-flag-validity"/>
				<xsl:call-template name="esg-controversies-env-flag-flag"/>
				<xsl:call-template name="esg-controversies-env-flag-number"/>
				<xsl:call-template name="esg-controversies-env-flag-percentForThreshold"/>
				<xsl:call-template name="esg-controversies-env-flag-percent"/>
				<xsl:call-template name="esg-controversies-env-flag-text"/>
				<xsl:call-template name="esg-controversies-env-flag-amount"/>
				<xsl:call-template name="esg-controversies-env-flag-biValueType"/>
				<xsl:call-template name="esg-controversies-env-flag-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-env-flag-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-env-flag-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-controversies-env-flag-userDefinedField"/>
			</InstrBiValue>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_ENVIR_CONTROVERSY_FLAG</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-biType-code"/>
	<xsl:template name="esg-controversies-env-flag-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-env-flag-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-env-flag-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-currency"/>
	<xsl:template name="esg-controversies-env-flag-dateTime"/>
	<xsl:template name="esg-controversies-env-flag-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-flag"/>
	<xsl:template name="esg-controversies-env-flag-number"/>
	<xsl:template name="esg-controversies-env-flag-percentForThreshold"/>
	<xsl:template name="esg-controversies-env-flag-percent"/>
	<xsl:template name="esg-controversies-env-flag-text"/>
	<xsl:template name="esg-controversies-env-flag-amount"/>
	<xsl:template name="esg-controversies-env-flag-biValueType">
		<biValueType>
			<infra:code>
				<xsl:value-of select="b:controversyEFlag"/>
			</infra:code>
		</biValueType>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-biValueTypeBusIndicatorElt-code">
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_ENVIR_CONTROVERSY_FLAG'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-controversies-env-flag-userDefinedField"/>


	<!--esg-controversies-social-score-->
	<xsl:template name="esg-controversies-social-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('CONTROVERSY-SOCIAL-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute> 		
			<xsl:call-template name="esg-controversies-social-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-social-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-social-score-instrument-code"/>
			<xsl:call-template name="esg-controversies-social-score-provider-code"/>
			<xsl:call-template name="esg-controversies-social-score-biType-code"/>
			<xsl:call-template name="esg-controversies-social-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-social-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-social-score-status"/>
			<xsl:call-template name="esg-controversies-social-score-currency"/>
			<xsl:call-template name="esg-controversies-social-score-dateTime"/>
			<xsl:call-template name="esg-controversies-social-score-validity"/>
			<xsl:call-template name="esg-controversies-social-score-flag"/>
			<xsl:call-template name="esg-controversies-social-score-number"/>
			<xsl:call-template name="esg-controversies-social-score-percentForThreshold"/>
			<xsl:call-template name="esg-controversies-social-score-percent"/>
			<xsl:call-template name="esg-controversies-social-score-text"/>
			<xsl:call-template name="esg-controversies-social-score-amount"/>
			<xsl:call-template name="esg-controversies-social-score-biValueType"/>
			<xsl:call-template name="esg-controversies-social-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-social-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-social-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-controversies-social-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_SOCIAL_CONTROVERSY_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-biType-code">
		<biType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
									(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
						<xsl:value-of select="'NUMBER'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'PERCENT'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biType>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-biTypeBusIndicatorElt-code">
		<biTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_SOCIAL_CONTROVERSY_SCORE'"/>
			</infra:code>
		</biTypeBusIndicatorElt>
	</xsl:template>

	<xsl:template name="esg-controversies-social-score-biTypeBusIndicatorEltbusIndicator-code">
		<biTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-currency"/>
	<xsl:template name="esg-controversies-social-score-dateTime"/>
	<xsl:template name="esg-controversies-social-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-flag"/>
	<xsl:template name="esg-controversies-social-score-number">
		<xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
						(b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<number>
				<xsl:value-of select="b:controversySPillarScore"/>
			</number>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-percentForThreshold"/>
	<xsl:template name="esg-controversies-social-score-percent">
		<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
					  (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<percent>
				<xsl:value-of select="b:controversySPillarScore"/>
			</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-social-score-text"/>
	<xsl:template name="esg-controversies-social-score-amount"/>
	<xsl:template name="esg-controversies-social-score-biValueType"/>
	<xsl:template name="esg-controversies-social-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-social-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-social-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-controversies-social-score-userDefinedField"/>


	<!--esg-controversies-social-flag-->
	<xsl:template name="esg-controversies-social-flag">
       <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
                                    (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<InstrBiValue>
	            <xsl:attribute name="description">
	                <xsl:value-of select="concat('CONTROVERSY-SOCIAL-FLAG+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
	            </xsl:attribute>    			
				<xsl:call-template name="esg-controversies-social-flag-busIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-social-flag-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-social-flag-instrument-code"/>
				<xsl:call-template name="esg-controversies-social-flag-provider-code"/>
				<xsl:call-template name="esg-controversies-social-flag-biType-code"/>
				<xsl:call-template name="esg-controversies-social-flag-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-social-flag-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-social-flag-status"/>
				<xsl:call-template name="esg-controversies-social-flag-currency"/>
				<xsl:call-template name="esg-controversies-social-flag-dateTime"/>
				<xsl:call-template name="esg-controversies-social-flag-validity"/>
				<xsl:call-template name="esg-controversies-social-flag-flag"/>
				<xsl:call-template name="esg-controversies-social-flag-number"/>
				<xsl:call-template name="esg-controversies-social-flag-percentForThreshold"/>
				<xsl:call-template name="esg-controversies-social-flag-percent"/>
				<xsl:call-template name="esg-controversies-social-flag-text"/>
				<xsl:call-template name="esg-controversies-social-flag-amount"/>
				<xsl:call-template name="esg-controversies-social-flag-biValueType"/>
				<xsl:call-template name="esg-controversies-social-flag-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-social-flag-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-social-flag-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-controversies-social-flag-userDefinedField"/>
			</InstrBiValue>
        </xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_SOCIAL_CONTROVERSY_FLAG</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-biType-code"/>
	<xsl:template name="esg-controversies-social-flag-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-social-flag-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-social-flag-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-currency"/>
	<xsl:template name="esg-controversies-social-flag-dateTime"/>
	<xsl:template name="esg-controversies-social-flag-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-flag"/>
	<xsl:template name="esg-controversies-social-flag-number"/>
	<xsl:template name="esg-controversies-social-flag-percentForThreshold"/>
	<xsl:template name="esg-controversies-social-flag-percent"/>
	<xsl:template name="esg-controversies-social-flag-text"/>
	<xsl:template name="esg-controversies-social-flag-amount"/>
	<xsl:template name="esg-controversies-social-flag-biValueType">
		<biValueType>
			<infra:code>
				<xsl:value-of select="b:controversySFlag"/>
			</infra:code>
		</biValueType>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-biValueTypeBusIndicatorElt-code">
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_SOCIAL_CONTROVERSY_FLAG'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-controversies-social-flag-userDefinedField"/>


	<!--esg-controversies-govern-score-->
	<xsl:template name="esg-controversies-govern-score">
		<InstrBiValue>
            <xsl:attribute name="description">
                <xsl:value-of select="concat('CONTROVERSY-GOVERN-SCORE+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
            </xsl:attribute>    		
			<xsl:call-template name="esg-controversies-govern-score-busIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-govern-score-busIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-govern-score-instrument-code"/>
			<xsl:call-template name="esg-controversies-govern-score-provider-code"/>
			<xsl:call-template name="esg-controversies-govern-score-biType-code"/>
			<xsl:call-template name="esg-controversies-govern-score-biTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-govern-score-biTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-govern-score-status"/>
			<xsl:call-template name="esg-controversies-govern-score-currency"/>
			<xsl:call-template name="esg-controversies-govern-score-dateTime"/>
			<xsl:call-template name="esg-controversies-govern-score-validity"/>
			<xsl:call-template name="esg-controversies-govern-score-flag"/>
			<xsl:call-template name="esg-controversies-govern-score-number"/>
			<xsl:call-template name="esg-controversies-govern-score-percentForThreshold"/>
			<xsl:call-template name="esg-controversies-govern-score-percent"/>
			<xsl:call-template name="esg-controversies-govern-score-text"/>
			<xsl:call-template name="esg-controversies-govern-score-amount"/>
			<xsl:call-template name="esg-controversies-govern-score-biValueType"/>
			<xsl:call-template name="esg-controversies-govern-score-biValueTypeBusIndicatorElt-code"/>
			<xsl:call-template name="esg-controversies-govern-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
			<xsl:call-template name="esg-controversies-govern-score-biValueTypeProvider-code"/>
			<xsl:call-template name="esg-controversies-govern-score-userDefinedField"/>
		</InstrBiValue>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_GOVER_CONTROVERSY_SCORE</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-biType-code">
		<biType>
			<infra:code>
				<xsl:choose>
					<xsl:when test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
				   					   (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
						<xsl:value-of select="'NUMBER'"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'PERCENT'"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</biType>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-biTypeBusIndicatorElt-code">
		<biTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_GOVER_CONTROVERSY_SCORE'"/>
			</infra:code>
		</biTypeBusIndicatorElt>
	</xsl:template>

	<xsl:template name="esg-controversies-govern-score-biTypeBusIndicatorEltbusIndicator-code">
		<biTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-currency"/>
	<xsl:template name="esg-controversies-govern-score-dateTime"/>
	<xsl:template name="esg-controversies-govern-score-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-flag"/>
	<xsl:template name="esg-controversies-govern-score-number">
		<xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
				         (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<number>
				<xsl:value-of select="b:controversyGPillarScore"/>
			</number>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-percentForThreshold"/>
	<xsl:template name="esg-controversies-govern-score-percent">
		<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
					  (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<percent>
				<xsl:value-of select="b:controversyGPillarScore"/>
			</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-score-text"/>
	<xsl:template name="esg-controversies-govern-score-amount"/>
	<xsl:template name="esg-controversies-govern-score-biValueType"/>
	<xsl:template name="esg-controversies-govern-score-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-govern-score-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-govern-score-biValueTypeProvider-code"/>
	<xsl:template name="esg-controversies-govern-score-userDefinedField"/>

	<!--esg-controversies-govern-flag-->

	<xsl:template name="esg-controversies-govern-flag">
       <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType) or
                                    (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND')))">
			<InstrBiValue>
	            <xsl:attribute name="description">
	                <xsl:value-of select="concat('CONTROVERSY-GOVERN-FLAG+', name(/*), '+', b:eventCommon/ns0:eventId, '+', b:eventCommon/ns0:creationTime)"/>
	            </xsl:attribute>    			
				<xsl:call-template name="esg-controversies-govern-flag-busIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-instrument-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-provider-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-biType-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-status"/>
				<xsl:call-template name="esg-controversies-govern-flag-currency"/>
				<xsl:call-template name="esg-controversies-govern-flag-dateTime"/>
				<xsl:call-template name="esg-controversies-govern-flag-validity"/>
				<xsl:call-template name="esg-controversies-govern-flag-flag"/>
				<xsl:call-template name="esg-controversies-govern-flag-number"/>
				<xsl:call-template name="esg-controversies-govern-flag-percentForThreshold"/>
				<xsl:call-template name="esg-controversies-govern-flag-percent"/>
				<xsl:call-template name="esg-controversies-govern-flag-text"/>
				<xsl:call-template name="esg-controversies-govern-flag-amount"/>
				<xsl:call-template name="esg-controversies-govern-flag-biValueType"/>
				<xsl:call-template name="esg-controversies-govern-flag-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-controversies-govern-flag-userDefinedField"/>
			</InstrBiValue>
        </xsl:if>
    </xsl:template>
	<xsl:template name="esg-controversies-govern-flag-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_CTR_GOVER_CONTROVERSY_FLAG</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CONTROVERSIES</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-biType-code"/>
	<xsl:template name="esg-controversies-govern-flag-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-controversies-govern-flag-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-controversies-govern-flag-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-currency"/>
	<xsl:template name="esg-controversies-govern-flag-dateTime"/>
	<xsl:template name="esg-controversies-govern-flag-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='CONTROVERSIES']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-flag"/>
	<xsl:template name="esg-controversies-govern-flag-number"/>
	<xsl:template name="esg-controversies-govern-flag-percentForThreshold"/>
	<xsl:template name="esg-controversies-govern-flag-percent"/>
	<xsl:template name="esg-controversies-govern-flag-text"/>
	<xsl:template name="esg-controversies-govern-flag-amount"/>
	<xsl:template name="esg-controversies-govern-flag-biValueType">
		<biValueType>
			<infra:code>
				<xsl:value-of select="b:controversyGFlag"/>
			</infra:code>
		</biValueType>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-biValueTypeBusIndicatorElt-code">
		<biValueTypeBusIndicatorElt>
			<infra:code>
				<xsl:value-of select="'ESG_CTR_GOVER_CONTROVERSY_FLAG'"/>
			</infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-biValueTypeBusIndicatorEltbusIndicator-code">
		<biValueTypeBusIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_CONTROVERSIES'"/>
			</infra:code>
		</biValueTypeBusIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-controversies-govern-flag-userDefinedField"/>



	<!--esg-ratings-below-pillar-->
	<xsl:template name="esg-ratings-below-pillar">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'RATING'">
				<InstrBiValue>				
					<xsl:call-template name="esg-ratings-below-pillar-busIndicatorElt-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-instrument-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-provider-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-biType-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-status"/>
					<xsl:call-template name="esg-ratings-below-pillar-currency"/>
					<xsl:call-template name="esg-ratings-below-pillar-dateTime"/>
					<xsl:call-template name="esg-ratings-below-pillar-validity"/>
					<xsl:call-template name="esg-ratings-below-pillar-flag"/>
					<xsl:call-template name="esg-ratings-below-pillar-number"/>
					<xsl:call-template name="esg-ratings-below-pillar-percentForThreshold"/>
					<xsl:call-template name="esg-ratings-below-pillar-percent"/>
					<xsl:call-template name="esg-ratings-below-pillar-text"/>
					<xsl:call-template name="esg-ratings-below-pillar-amount"/>
					<xsl:call-template name="esg-ratings-below-pillar-biValueType"/>
					<xsl:call-template name="esg-ratings-below-pillar-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-ratings-below-pillar-userDefinedField"/>
				</InstrBiValue>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="esg-ratings-below-pillar-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_RATING</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-biType-code">
		<xsl:variable name="index" select="@index"/>
              <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
					<biType>
						<infra:code>
								<xsl:choose>
									<xsl:when test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType) 
													or (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND')))">
										<xsl:value-of select="'NUMBER'"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="'PERCENT'"/>
									</xsl:otherwise>
								</xsl:choose>
						</infra:code>
					</biType>
              </xsl:if>
	</xsl:template>

	<xsl:template name="esg-ratings-below-pillar-biTypeBusIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
            <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
				<biTypeBusIndicatorElt>
					<infra:code>
							<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
					</infra:code>
				</biTypeBusIndicatorElt>
            </xsl:if>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-biTypeBusIndicatorEltbusIndicator-code">
		<xsl:variable name="index" select="@index"/>
            <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
				<biTypeBusIndicatorEltbusIndicator>
					<infra:code>
							<xsl:value-of select="'ESG_RATING'"/>
					</infra:code>
				</biTypeBusIndicatorEltbusIndicator>
            </xsl:if>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-currency"/>
	<xsl:template name="esg-ratings-below-pillar-dateTime"/>
	<xsl:template name="esg-ratings-below-pillar-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='RATING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-flag">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'YES.OR.NO'">
			<xsl:choose>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'YES'">
					<flag>
						<xsl:value-of select="'1'"/>
					</flag>
				</xsl:when>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'NO'">
					<flag>
						<xsl:value-of select="'0'"/>
					</flag>
				</xsl:when>
				<xsl:otherwise>
					<flag>
						<xsl:value-of select="'2'"/>
					</flag>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-number">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
			<xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType) or
							 (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND')))">
				<number>
					<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
				</number>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-percentForThreshold"/>
	<xsl:template name="esg-ratings-below-pillar-percent">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
			<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType)) or
						 (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND'))">
				<percent>
					<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
				</percent>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-ratings-below-pillar-text"/>
	<xsl:template name="esg-ratings-below-pillar-amount"/>
	<xsl:template name="esg-ratings-below-pillar-biValueType"/>

	<xsl:template name="esg-ratings-below-pillar-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-ratings-below-pillar-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-ratings-below-pillar-biValueTypeProvider-code"/>
	<xsl:template name="esg-ratings-below-pillar-userDefinedField"/>

	<!--esg-controversies-below-pillar-->
	<xsl:template name="esg-controversies-below-pillar"/>

	<!--esg-screening-values-->
	<xsl:template name="esg-screening-values">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'SCREENING'">
				<InstrBiValue description="This is the description">
                    <xsl:variable name="index" select="@index"/>	
	                <xsl:attribute name="description">
	                    <xsl:value-of select="concat('SCREENING+', name(/*), '+', ../../b:eventCommon/ns0:eventId, '+', ../../b:eventCommon/ns0:creationTime, '+', ../../b:indicatorGroup[@index=$index]/b:indicator)"/>
	                </xsl:attribute>
					<xsl:call-template name="esg-screening-values-busIndicatorElt-code"/>
					<xsl:call-template name="esg-screening-values-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-screening-values-instrument-code"/>
					<xsl:call-template name="esg-screening-values-provider-code"/>
					<xsl:call-template name="esg-screening-values-biType-code"/>
					<xsl:call-template name="esg-screening-values-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-screening-values-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-screening-values-status"/>
					<xsl:call-template name="esg-screening-values-currency"/>
					<xsl:call-template name="esg-screening-values-dateTime"/>
					<xsl:call-template name="esg-screening-values-validity"/>
					<xsl:call-template name="esg-screening-values-flag"/>
					<xsl:call-template name="esg-screening-values-number"/>
					<xsl:call-template name="esg-screening-values-percentForThreshold"/>
					<xsl:call-template name="esg-screening-values-percent"/>
					<xsl:call-template name="esg-screening-values-text"/>
					<xsl:call-template name="esg-screening-values-amount"/>
					<xsl:call-template name="esg-screening-values-biValueType"/>
					<xsl:call-template name="esg-screening-values-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-screening-values-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-screening-values-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-screening-values-userDefinedField"/>
				</InstrBiValue>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="esg-screening-values-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:variable name="element">
					<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicator"/>
				</xsl:variable>
				<xsl:variable name="element_len">
					<xsl:value-of select="string-length($element)"/>
				</xsl:variable>
				<xsl:variable name="element_last_revenue">
					<xsl:value-of select="substring($element, $element_len - 8)"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="contains($element_last_revenue,'-REVENUE')">
						<xsl:value-of select="translate(substring-before(../../b:indicatorGroup[@index=$index]/b:indicator,'-REVENUE'),'-','_')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
					</xsl:otherwise>
				</xsl:choose>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-screening-values-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>
				<xsl:value-of select="'ESG_SCREENING'"/>
			</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-screening-values-instrument-code">
        <instrument>
            <infra:code>
                <xsl:value-of select="../../b:securityNo"/>
            </infra:code>
        </instrument>	
	</xsl:template>
	<xsl:template name="esg-screening-values-provider-code">
        <provider>
            <infra:code>
                <xsl:value-of select="../../b:provider"/>
            </infra:code>
        </provider>	
	</xsl:template>
	<xsl:template name="esg-screening-values-biType-code"/>
	<xsl:template name="esg-screening-values-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-screening-values-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-screening-values-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-screening-values-currency"/>
	<xsl:template name="esg-screening-values-dateTime"/>
	<xsl:template name="esg-screening-values-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='SCREENING']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-screening-values-flag">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'YES.OR.NO'">
			<xsl:choose>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'YES'">
					<flag>
						<xsl:value-of select="'1'"/>
					</flag>
				</xsl:when>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'NO'">
					<flag>
						<xsl:value-of select="'0'"/>
					</flag>
				</xsl:when>
				<xsl:otherwise>
					<flag>
						<xsl:value-of select="'2'"/>
					</flag>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-screening-values-number"/>
	<xsl:template name="esg-screening-values-percentForThreshold">
		<xsl:variable name="index" select="@index"/>
		<xsl:variable name="element">
			<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicator"/>
		</xsl:variable>
		<xsl:variable name="element_len">
			<xsl:value-of select="string-length($element)"/>
		</xsl:variable>
		<xsl:variable name="element_last_revenue">
			<xsl:value-of select="substring($element, $element_len - 8)"/>
		</xsl:variable>
		<xsl:if test="contains($element_last_revenue,'-REVENUE')">
			<percentForThreshold>
			     <xsl:choose>
			         <xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue and not(../../b:indicatorGroup[@index=$index]/b:indicatorValue ='')">
                            <xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
			         </xsl:when>
			         <xsl:otherwise>
                           <xsl:value-of select="'0'"/>
			         </xsl:otherwise>
			     </xsl:choose>
			</percentForThreshold>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-screening-values-percent">
		<xsl:variable name="index" select="@index"/>
		<xsl:variable name="element">
			<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicator"/>
		</xsl:variable>
		<xsl:variable name="element_len">
			<xsl:value-of select="string-length($element)"/>
		</xsl:variable>
		<xsl:variable name="element_last_mf">
			<xsl:value-of select="substring($element, $element_len - 8)"/>
		</xsl:variable>
		<xsl:if test="contains($element_last_mf,'-MF')">
			<percent>
				<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
			</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-screening-values-text"/>
	<xsl:template name="esg-screening-values-amount"/>
	<xsl:template name="esg-screening-values-biValueType"/>
	<xsl:template name="esg-screening-values-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-screening-values-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-screening-values-biValueTypeProvider-code"/>
	<xsl:template name="esg-screening-values-userDefinedField"/>


	<!--esg-sdg-values-->
	<xsl:template name="esg-sdg-values">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'SDG'">
				<InstrBiValue>
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
				</InstrBiValue>
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
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-sdg-values-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</provider>
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
	<xsl:template name="esg-sdg-values-percent">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
			<xsl:if test="($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType)) or
                         (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND'))">
				<percent>
					<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
				</percent>
			</xsl:if>
		</xsl:if>
	</xsl:template>
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
        <biValueTypeProvider>
            <infra:code>
                <xsl:value-of select="../../b:provider"/>
            </infra:code>
        </biValueTypeProvider>
    </xsl:template>	
	<xsl:template name="esg-sdg-values-userDefinedField"/>


	<!--esg-sdg-classification-->
	<xsl:template name="esg-sdg-classification">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'CLASSIFICATION'">
				<xsl:variable name="index" select="@index"/>
				<xsl:if test="starts-with(../../b:indicatorGroup[@index=$index]/b:indicator, 'ESG-CLASS-SFDR-ART') 
				            or ../../b:indicatorGroup[@index=$index]/b:indicator = 'ESG-CLASS-ESG-COVERAGE-MF'
                            or ../../b:indicatorGroup[@index=$index]/b:indicator = 'ESG-CLASS-SFDR-MUTUAL-FUNDS'				            
				            ">
				<InstrBiValue>
					<xsl:call-template name="esg-sdg-classification-busIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-classification-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-classification-instrument-code"/>
					<xsl:call-template name="esg-sdg-classification-provider-code"/>
					<xsl:call-template name="esg-sdg-classification-biType-code"/>
					<xsl:call-template name="esg-sdg-classification-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-classification-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-classification-status"/>
					<xsl:call-template name="esg-sdg-classification-currency"/>
					<xsl:call-template name="esg-sdg-classification-dateTime"/>
					<xsl:call-template name="esg-sdg-classification-validity"/>
					<xsl:call-template name="esg-sdg-classification-flag"/>
					<xsl:call-template name="esg-sdg-classification-number"/>
					<xsl:call-template name="esg-sdg-classification-percentForThreshold"/>
					<xsl:call-template name="esg-sdg-classification-percent"/>
					<xsl:call-template name="esg-sdg-classification-text"/>
					<xsl:call-template name="esg-sdg-classification-amount"/>
					<xsl:call-template name="esg-sdg-classification-biValueType"/>
					<xsl:call-template name="esg-sdg-classification-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sdg-classification-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sdg-classification-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-sdg-classification-userDefinedField"/>
				</InstrBiValue>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_CLASSIFICATION</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-biType-code"/>
	<xsl:template name="esg-sdg-classification-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-sdg-classification-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-sdg-classification-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-currency"/>
	<xsl:template name="esg-sdg-classification-dateTime"/>
	<xsl:template name="esg-sdg-classification-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='CLASSIFICATION']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-flag">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'YES.OR.NO'">
			<xsl:choose>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'YES'">
					<flag>
						<xsl:value-of select="'1'"/>
					</flag>
				</xsl:when>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'NO'">
					<flag>
						<xsl:value-of select="'0'"/>
					</flag>
				</xsl:when>
				<xsl:otherwise>
					<flag>
						<xsl:value-of select="'2'"/>
					</flag>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-number"/>
	<xsl:template name="esg-sdg-classification-percentForThreshold"/>
	<xsl:template name="esg-sdg-classification-percent">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'">
			<percent>
				<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
				</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-sdg-classification-text"/>
	<xsl:template name="esg-sdg-classification-amount"/>
	<xsl:template name="esg-sdg-classification-biValueType">
        <xsl:variable name="index" select="@index"/>
        <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'LOOKUP'">
	        <biValueType>
	            <infra:code>
	                <xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
	            </infra:code>
	        </biValueType>
	    </xsl:if>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-biValueTypeBusIndicatorElt-code">
        <xsl:variable name="index" select="@index"/>
        <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'LOOKUP'">
	        <biValueTypeBusIndicatorElt>
	            <infra:code>
	                <xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
	            </infra:code>
	        </biValueTypeBusIndicatorElt>
        </xsl:if>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-biValueTypeBusIndicatorEltbusIndicator-code">
       <xsl:variable name="index" select="@index"/>
       <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'LOOKUP'">
	        <biValueTypeBusIndicatorEltbusIndicator>
	            <infra:code>
	                <xsl:value-of select="'ESG_CLASSIFICATION'"/>
	            </infra:code>
	        </biValueTypeBusIndicatorEltbusIndicator>
        </xsl:if>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-biValueTypeProvider-code">
       <xsl:variable name="index" select="@index"/>
       <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'LOOKUP'">
	        <biValueTypeProvider>
	            <infra:code>
	                <xsl:value-of select="../../b:provider"/>
	            </infra:code>
	        </biValueTypeProvider>
        </xsl:if>
    </xsl:template> 
	<xsl:template name="esg-sdg-classification-userDefinedField"/>

    <!--esg-sdg-classification-other-->
    <xsl:template name="esg-sdg-classification-other">
        <xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
            <xsl:if test=". = 'CLASSIFICATION'">
                <xsl:variable name="index" select="@index"/>
                <xsl:if test="../../b:indicatorGroup[@index=$index]/b:indicator = 'ESG-CLASS-OTHER-PRODUCTS'">
                <InstrBiValue>
                    <xsl:call-template name="esg-sdg-classification-other-busIndicatorElt-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-busIndicatorEltbusIndicator-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-instrument-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-provider-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-biType-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-biTypeBusIndicatorElt-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-biTypeBusIndicatorEltbusIndicator-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-status"/>
                    <xsl:call-template name="esg-sdg-classification-other-currency"/>
                    <xsl:call-template name="esg-sdg-classification-other-dateTime"/>
                    <xsl:call-template name="esg-sdg-classification-other-validity"/>
                    <xsl:call-template name="esg-sdg-classification-other-flag"/>
                    <xsl:call-template name="esg-sdg-classification-other-number"/>
                    <xsl:call-template name="esg-sdg-classification-other-percentForThreshold"/>
                    <xsl:call-template name="esg-sdg-classification-other-percent"/>
                    <xsl:call-template name="esg-sdg-classification-other-text"/>
                    <xsl:call-template name="esg-sdg-classification-other-amount"/>
                    <xsl:call-template name="esg-sdg-classification-other-biValueType"/>
                    <xsl:call-template name="esg-sdg-classification-other-biValueTypeBusIndicatorElt-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-biValueTypeBusIndicatorEltbusIndicator-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-biValueTypeProvider-code"/>
                    <xsl:call-template name="esg-sdg-classification-other-userDefinedField"/>
                </InstrBiValue>
                </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-busIndicatorElt-code">
        <xsl:variable name="index" select="@index"/>
        <busIndicatorElt>
            <infra:code>
                <xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
            </infra:code>
        </busIndicatorElt>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-busIndicatorEltbusIndicator-code">
        <busIndicatorEltbusIndicator>
            <infra:code>ESG_CLASSIFICATION</infra:code>
        </busIndicatorEltbusIndicator>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-instrument-code">
        <instrument>
            <infra:code>
                <xsl:value-of select="../../b:securityNo"/>
            </infra:code>
        </instrument>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-provider-code">
        <provider>
            <infra:code>
                <xsl:value-of select="../../b:provider"/>
            </infra:code>
        </provider>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-biType-code"/>
    <xsl:template name="esg-sdg-classification-other-biTypeBusIndicatorElt-code"/>
    <xsl:template name="esg-sdg-classification-other-biTypeBusIndicatorEltbusIndicator-code"/>
    <xsl:template name="esg-sdg-classification-other-status">
        <status>20</status>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-currency"/>
    <xsl:template name="esg-sdg-classification-other-dateTime"/>
    <xsl:template name="esg-sdg-classification-other-validity">
        <validity>
            <xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='CLASSIFICATION']/b:categoryUpdateDate"/>
        </validity>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-flag"/>
    <xsl:template name="esg-sdg-classification-other-number"/>
    <xsl:template name="esg-sdg-classification-other-percentForThreshold"/>
    <xsl:template name="esg-sdg-classification-other-percent"/>
    <xsl:template name="esg-sdg-classification-other-text"/>
    <xsl:template name="esg-sdg-classification-other-amount"/>
    <xsl:template name="esg-sdg-classification-other-biValueType">
        <xsl:variable name="index" select="@index"/>
        <biValueType>
            <infra:code>
                <xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
            </infra:code>
        </biValueType>
    </xsl:template>
    <xsl:template name="esg-sdg-classification-other-biValueTypeBusIndicatorElt-code">
        <xsl:variable name="index" select="@index"/>
        <biValueTypeBusIndicatorElt>
            <infra:code>
                <xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
            </infra:code>
        </biValueTypeBusIndicatorElt>
    </xsl:template>    
    <xsl:template name="esg-sdg-classification-other-biValueTypeBusIndicatorEltbusIndicator-code">
        <biValueTypeBusIndicatorEltbusIndicator>
            <infra:code>
                <xsl:value-of select="'ESG_CLASSIFICATION'"/>
            </infra:code>
        </biValueTypeBusIndicatorEltbusIndicator>
    </xsl:template>    
    <xsl:template name="esg-sdg-classification-other-biValueTypeProvider-code">
        <biValueTypeProvider>
            <infra:code>
                <xsl:value-of select="../../b:provider"/>
            </infra:code>
        </biValueTypeProvider>
    </xsl:template>      
    <xsl:template name="esg-sdg-classification-other-userDefinedField"/>
	<!--  EU taxonomy -->
	<xsl:template name="esg-eu-taxonomy">
	   <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType)) or
                         (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND'))">
			<InstrBiValue>
				<xsl:call-template name="esg-eu-taxonomy-busIndicatorElt-code"/>
				<xsl:call-template name="esg-eu-taxonomy-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-eu-taxonomy-instrument-code"/>
				<xsl:call-template name="esg-eu-taxonomy-provider-code"/>
				<xsl:call-template name="esg-eu-taxonomy-biType-code"/>
				<xsl:call-template name="esg-eu-taxonomy-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-eu-taxonomy-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-eu-taxonomy-status"/>
				<xsl:call-template name="esg-eu-taxonomy-currency"/>
				<xsl:call-template name="esg-eu-taxonomy-dateTime"/>
				<xsl:call-template name="esg-eu-taxonomy-validity"/>
				<xsl:call-template name="esg-eu-taxonomy-flag"/>
				<xsl:call-template name="esg-eu-taxonomy-number"/>
				<xsl:call-template name="esg-eu-taxonomy-percentForThreshold"/>
				<xsl:call-template name="esg-eu-taxonomy-percent"/>
				<xsl:call-template name="esg-eu-taxonomy-text"/>
				<xsl:call-template name="esg-eu-taxonomy-amount"/>
				<xsl:call-template name="esg-eu-taxonomy-biValueType"/>
				<xsl:call-template name="esg-eu-taxonomy-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-eu-taxonomy-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-eu-taxonomy-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-eu-taxonomy-userDefinedField"/>
			</InstrBiValue>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_EU_TAXO_SUST_INVEST</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_EU_TAXONOMY</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-biType-code"/>
	<xsl:template name="esg-eu-taxonomy-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-eu-taxonomy-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-eu-taxonomy-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-currency"/>
	<xsl:template name="esg-eu-taxonomy-dateTime"/>
	<xsl:template name="esg-eu-taxonomy-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='EU.TAXONOMY']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-flag">
		<flag>
			<xsl:choose>
				<xsl:when test="b:taxonomyOverallIndicator = 'YES'">
					<xsl:value-of select="'1'"/>
				</xsl:when>
				<xsl:when test="b:taxonomyOverallIndicator = 'NO'">
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="'2'"/>
				</xsl:otherwise>
			</xsl:choose>
		</flag>
	</xsl:template>
	<xsl:template name="esg-eu-taxonomy-number"/>
	<xsl:template name="esg-eu-taxonomy-percentForThreshold"/>
	<xsl:template name="esg-eu-taxonomy-percent"/>
	<xsl:template name="esg-eu-taxonomy-text"/>
	<xsl:template name="esg-eu-taxonomy-amount"/>
	<xsl:template name="esg-eu-taxonomy-biValueType"/>
	<xsl:template name="esg-eu-taxonomy-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-eu-taxonomy-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-eu-taxonomy-biValueTypeProvider-code"/>
	<xsl:template name="esg-eu-taxonomy-userDefinedField"/>



	<!--  EU taxonomy Indicators-->
	<xsl:template name="esg-eu-taxonamy-indicators">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'EU.TAXONOMY' and not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType)) or
                         (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND'))">
				<InstrBiValue>				
					<xsl:call-template name="esg-eu-taxonamy-indicators-busIndicatorElt-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-instrument-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-provider-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biType-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-status"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-currency"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-dateTime"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-validity"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-flag"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-number"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-percentForThreshold"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-percent"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-text"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-amount"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biValueType"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-eu-taxonamy-indicators-userDefinedField"/>
				</InstrBiValue>
			</xsl:if>
		  </xsl:for-each>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_EU_TAXONOMY</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-biType-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-currency"/>
	<xsl:template name="esg-eu-taxonamy-indicators-dateTime"/>
	<xsl:template name="esg-eu-taxonamy-indicators-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='EU.TAXONOMY']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-flag">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'YES.OR.NO'">
			<xsl:choose>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'YES'">
					<flag>
						<xsl:value-of select="'1'"/>
					</flag>
				</xsl:when>
				<xsl:when test="../../b:indicatorGroup[@index=$index]/b:indicatorValue = 'NO'">
					<flag>
						<xsl:value-of select="'0'"/>
					</flag>
				</xsl:when>
				<xsl:otherwise>
					<flag>
						<xsl:value-of select="'2'"/>
					</flag>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-number">
        <xsl:variable name="index" select="@index"/>
        <xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'
          and (
            not(../../b:scEsgIndicatorOtherAttrGroup[@index= $index]/b:scEsgIndicatorOtherAttrSubGroup[b:scEsgIndicatorOtherAttr = 'Sub-datatypes']/b:scEsgIndicatorOtherAttrVal)
            or
            ../../b:scEsgIndicatorOtherAttrGroup[@index= $index]/b:scEsgIndicatorOtherAttrSubGroup[b:scEsgIndicatorOtherAttr = 'Sub-datatypes']/b:scEsgIndicatorOtherAttrVal = ''
            )
        ">
                <number>
                    <xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
                </number>
        </xsl:if>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-percentForThreshold"/>
	<xsl:template name="esg-eu-taxonamy-indicators-percent">
		<xsl:variable name="index" select="@index"/>
		<xsl:if test="../../b:scEsgIndicatorDataTypeList/b:scEsgIndicatorDataType[@index=$index] = 'NUMERIC'
		  and ../../b:scEsgIndicatorOtherAttrGroup[@index= $index]/b:scEsgIndicatorOtherAttrSubGroup[b:scEsgIndicatorOtherAttr = 'Sub-datatypes']/b:scEsgIndicatorOtherAttrVal 
		  and ../../b:scEsgIndicatorOtherAttrGroup[@index= $index]/b:scEsgIndicatorOtherAttrSubGroup[b:scEsgIndicatorOtherAttr = 'Sub-datatypes']/b:scEsgIndicatorOtherAttrVal = 2
		">
				<percent>
					<xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
				</percent>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-eu-taxonamy-indicators-text"/>
	<xsl:template name="esg-eu-taxonamy-indicators-amount"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biValueType"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biValueTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biValueTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-biValueTypeProvider-code"/>
	<xsl:template name="esg-eu-taxonamy-indicators-userDefinedField"/>



	<!--  SFDR Adverse impacts  -->
	<xsl:template name="esg-sfdr-advers-impacts">
       <xsl:if test="not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,b:securityMasterSubAssetType)) or
                         (b:subAssetTypeTapInstrType and (b:subAssetTypeTapInstrType='MUTUALFUND'))">
			<InstrBiValue>
				<xsl:call-template name="esg-sfdr-advers-impacts-busIndicatorElt-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-busIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-instrument-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-provider-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biType-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-status"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-currency"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-dateTime"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-validity"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-flag"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-number"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-percentForThreshold"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-percent"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-text"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-amount"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biValueType"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biValueTypeBusIndicatorElt-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biValueTypeBusIndicatorEltbusIndicator-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-biValueTypeProvider-code"/>
				<xsl:call-template name="esg-sfdr-advers-impacts-userDefinedField"/>
			</InstrBiValue>
		</xsl:if>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-busIndicatorElt-code">
		<busIndicatorElt>
			<infra:code>ESG_PAI_OVERALL_STATUS</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_SFDR_ADVERSE_IMPACTS</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-biType-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-currency"/>
	<xsl:template name="esg-sfdr-advers-impacts-dateTime"/>
	<xsl:template name="esg-sfdr-advers-impacts-validity">
		<validity>
			<xsl:value-of select="b:indicatorCategoryGroup[b:indicatorCategory='SFDR.ADVERSE.IMPACT']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-flag"/>
	<xsl:template name="esg-sfdr-advers-impacts-number"/>
	<xsl:template name="esg-sfdr-advers-impacts-percentForThreshold"/>
	<xsl:template name="esg-sfdr-advers-impacts-percent"/>
	<xsl:template name="esg-sfdr-advers-impacts-text"/>
	<xsl:template name="esg-sfdr-advers-impacts-amount"/>
	<xsl:template name="esg-sfdr-advers-impacts-biValueType">
        <biValueType>
            <infra:code>
                <xsl:value-of select="b:paiOverallStatus"/>
            </infra:code>
        </biValueType>
    </xsl:template>
    <xsl:template name="esg-sfdr-advers-impacts-biValueTypeBusIndicatorElt-code">
        <biValueTypeBusIndicatorElt>
            <infra:code>
                <xsl:value-of select="'ESG_PAI_OVERALL_STATUS'"/>
            </infra:code>
        </biValueTypeBusIndicatorElt>
    </xsl:template>
    <xsl:template name="esg-sfdr-advers-impacts-biValueTypeBusIndicatorEltbusIndicator-code">
        <biValueTypeBusIndicatorEltbusIndicator>
            <infra:code>
                <xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
            </infra:code>
        </biValueTypeBusIndicatorEltbusIndicator>
    </xsl:template>
    <xsl:template name="esg-sfdr-advers-impacts-biValueTypeProvider-code">
        <biValueTypeProvider>
            <infra:code>
                <xsl:value-of select="b:provider"/>
            </infra:code>
        </biValueTypeProvider>
    </xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-userDefinedField"/>

	<!--  SFDR Adverse impacts indicators -->

	<xsl:template name="esg-sfdr-advers-impacts-indicators">
		<xsl:for-each select="b:scEsgIndicatorIndicatorCategoryList/b:scEsgIndicatorIndicatorCategory">
			<xsl:if test=". = 'SFDR.ADVERSE.IMPACT' and not($g_filterBySubAssetType='Y' and contains($list_SubAssetType_FinancialInstrumentMutualFund,../../b:securityMasterSubAssetType)) or
                         (../../b:subAssetTypeTapInstrType and (../../b:subAssetTypeTapInstrType='MUTUALFUND'))">
				<InstrBiValue>				
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-busIndicatorElt-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-busIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-instrument-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-provider-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biType-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-status"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-currency"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-dateTime"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-validity"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-flag"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-number"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-percentForThreshold"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-percent"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-text"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-amount"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biValueType"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biValueTypeBusIndicatorElt-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biValueTypeBusIndicatorEltbusIndicator-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-biValueTypeProvider-code"/>
					<xsl:call-template name="esg-sfdr-advers-impacts-indicators-userDefinedField"/>
				</InstrBiValue>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-busIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<busIndicatorElt>
			<infra:code>
				<xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>
			</infra:code>
		</busIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-busIndicatorEltbusIndicator-code">
		<busIndicatorEltbusIndicator>
			<infra:code>ESG_SFDR_ADVERSE_IMPACTS</infra:code>
		</busIndicatorEltbusIndicator>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-instrument-code">
		<instrument>
			<infra:code>
				<xsl:value-of select="../../b:securityNo"/>
			</infra:code>
		</instrument>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-provider-code">
		<provider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</provider>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biType-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biTypeBusIndicatorElt-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biTypeBusIndicatorEltbusIndicator-code"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-status">
		<status>20</status>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-currency"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-dateTime"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-validity">
		<validity>
			<xsl:value-of select="../../b:indicatorCategoryGroup[b:indicatorCategory='EU.TAXONOMY']/b:categoryUpdateDate"/>
		</validity>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-flag"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-number"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-percentForThreshold"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-percent"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-text"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-amount"/>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biValueType">
        <xsl:variable name="index" select="@index"/>
        <biValueType>
            <infra:code>
                <xsl:value-of select="../../b:indicatorGroup[@index=$index]/b:indicatorValue"/>
            </infra:code>
        </biValueType>	
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biValueTypeBusIndicatorElt-code">
		<xsl:variable name="index" select="@index"/>
		<biValueTypeBusIndicatorElt>
		    <infra:code>
                <xsl:value-of select="translate(../../b:indicatorGroup[@index=$index]/b:indicator,'-','_')"/>		  
            </infra:code>
		</biValueTypeBusIndicatorElt>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biValueTypeBusIndicatorEltbusIndicator-code">
        <biValueTypeBusIndicatorEltbusIndicator>
            <infra:code>
                <xsl:value-of select="'ESG_SFDR_ADVERSE_IMPACTS'"/>
            </infra:code>
        </biValueTypeBusIndicatorEltbusIndicator>	
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-biValueTypeProvider-code">
		<biValueTypeProvider>
			<infra:code>
				<xsl:value-of select="../../b:provider"/>
			</infra:code>
		</biValueTypeProvider>
	</xsl:template>
	<xsl:template name="esg-sfdr-advers-impacts-indicators-userDefinedField"/>

	<!--  ESG  Custom Indicators  -->
	<xsl:template name="esg-custom-indicators"/>
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