<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.odcgroup.com/InfraPMS" xmlns:ns0="http://www.temenos.com/T24/event/Common/EventCommon" xmlns:b="http://www.temenos.com/T24/event/TTI/CsdQiCustomerSupInfo" exclude-result-prefixes="b  ns0" version="1.0">
  <xsl:template name="active">
    <active>1</active>
  </xsl:template>
  <xsl:template name="code">
    <code>
      <xsl:if test="b:id != ''">
        <xsl:value-of select="concat($CUSTOMER_PREFIX,b:id)"/>
      </xsl:if>
    </code>
  </xsl:template>
  <xsl:template name="userDefinedField">
		<userDefinedField>
				<name>ud_cust_qistatus_e</name>	
				<value>
					<xsl:choose>
						<xsl:when test="b:cusQiStatus ='None'">
							<xsl:value-of select="'0'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='ADT'">
							<xsl:value-of select="'1'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='AM'">
							<xsl:value-of select="'2'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='AT'">
							<xsl:value-of select="'3'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='AU'">
							<xsl:value-of select="'4'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='AZ'">
							<xsl:value-of select="'5'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BB'">
							<xsl:value-of select="'6'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BD'">
							<xsl:value-of select="'7'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BE'">
							<xsl:value-of select="'8'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BG'">
							<xsl:value-of select="'9'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BNE'">
							<xsl:value-of select="'10'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='BY'">
							<xsl:value-of select="'11'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='CA'">
							<xsl:value-of select="'12'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='CH'">
							<xsl:value-of select="'13'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='CN'">
							<xsl:value-of select="'14'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='CY'">
							<xsl:value-of select="'15'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='CZ'">
							<xsl:value-of select="'16'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='DE'">
							<xsl:value-of select="'17'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='DK'">
							<xsl:value-of select="'18'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='EE'">
							<xsl:value-of select="'19'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='EG'">
							<xsl:value-of select="'20'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='ES'">
							<xsl:value-of select="'21'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='EUS'">
							<xsl:value-of select="'22'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='EXP'">
							<xsl:value-of select="'23'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='FI'">
							<xsl:value-of select="'24'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='FR'">
							<xsl:value-of select="'25'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='GB'">
							<xsl:value-of select="'26'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='GE'">
							<xsl:value-of select="'27'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='GR'">
							<xsl:value-of select="'28'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='HU'">
							<xsl:value-of select="'29'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='ID'">
							<xsl:value-of select="'30'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IE'">
							<xsl:value-of select="'31'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IL'">
							<xsl:value-of select="'32'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IMY'">
							<xsl:value-of select="'33'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IN'">
							<xsl:value-of select="'34'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IS'">
							<xsl:value-of select="'35'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='IT'">
							<xsl:value-of select="'36'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='JM'">
							<xsl:value-of select="'37'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='JP'">
							<xsl:value-of select="'38'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='KG'">
							<xsl:value-of select="'39'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='KR'">
							<xsl:value-of select="'40'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='KZ'">
							<xsl:value-of select="'41'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='LK'">
							<xsl:value-of select="'42'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='LT'">
							<xsl:value-of select="'43'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='LU'">
							<xsl:value-of select="'44'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='LV'">
							<xsl:value-of select="'45'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='MA'">
							<xsl:value-of select="'46'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='MD'">
							<xsl:value-of select="'47'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='MT'">
							<xsl:value-of select="'48'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='MX'">
							<xsl:value-of select="'49'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NDT'">
							<xsl:value-of select="'50'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NL'">
							<xsl:value-of select="'51'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NO'">
							<xsl:value-of select="'52'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NPFFI'">
							<xsl:value-of select="'53'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NQI'">
							<xsl:value-of select="'54'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NW8'">
							<xsl:value-of select="'55'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NW9'">
							<xsl:value-of select="'56'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='NZ'">
							<xsl:value-of select="'57'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='PH'">
							<xsl:value-of select="'58'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='PK'">
							<xsl:value-of select="'59'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='PL'">
							<xsl:value-of select="'60'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='PT'">
							<xsl:value-of select="'61'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='QIA'">
							<xsl:value-of select="'62'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='QIB'">
							<xsl:value-of select="'63'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='RFD'">
							<xsl:value-of select="'64'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='RO'">
							<xsl:value-of select="'65'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='RU'">
							<xsl:value-of select="'66'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='SE'">
							<xsl:value-of select="'67'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='SI'">
							<xsl:value-of select="'68'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='SK'">
							<xsl:value-of select="'69'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TH'">
							<xsl:value-of select="'70'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TJ'">
							<xsl:value-of select="'71'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TM'">
							<xsl:value-of select="'72'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TN'">
							<xsl:value-of select="'73'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TR'">
							<xsl:value-of select="'74'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='TT'">
							<xsl:value-of select="'75'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='UA'">
							<xsl:value-of select="'76'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='UPT'">
							<xsl:value-of select="'77'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='UZ'">
							<xsl:value-of select="'78'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='VE'">
							<xsl:value-of select="'79'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='VW9'">
							<xsl:value-of select="'80'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='WFT'">
							<xsl:value-of select="'81'"/>
						</xsl:when>
						<xsl:when test="b:cusQiStatus ='ZA'">
							<xsl:value-of select="'82'"/>
						</xsl:when>
					</xsl:choose>
				</value>
				<type>string</type>
		</userDefinedField>	
  </xsl:template>
</xsl:stylesheet>