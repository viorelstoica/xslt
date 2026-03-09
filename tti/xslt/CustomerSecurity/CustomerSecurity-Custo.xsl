<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.odcgroup.com/InfraPMS" xmlns:b="http://www.temenos.com/T24/event/TTI/CustomerSecurity" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="b" version="1.0">
	<xsl:template name="dataSecuProf">
		<xsl:if test="((b:id != '')
             and (b:customerTypeList/b:customerType = 'DEPOSITORY'))

         or ((b:idDxCustomer != '')
             and (b:dxCustomerType = 'BROKER')
             and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'CLEARING'
               or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH'))

         or ((b:id != '')
             and (b:customerTypeList/b:customerType = 'BROKER'
               or b:customerTypeList/b:customerType = 'COUNTERPARTY'))

         or ((b:idDxCustomer != '')
             and (b:dxCustomerType = 'BROKER')
             and (b:exchMemberGroup/b:exchMemberList/b:exchMember = 'TRADING'
               or b:exchMemberGroup/b:exchMemberList/b:exchMember = 'BOTH'))

         or (b:customerTypeList/b:customerType = 'COUNTERPARTY'
             and not(b:customerTypeList/b:customerType = 'BROKER'))
      ">
			<dataSecuProf>
				<code>
					<xsl:value-of select="'DEF_DATA_SECU_PROF'"/>
				</code>
			</dataSecuProf>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>