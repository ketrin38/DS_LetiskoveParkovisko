<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="e790c825-015b-1000-8001-c0a83801d425" type="" style="Table" enable="true">
	<name><![CDATA[PREHLAD_PRIJMOV]]></name>
	<description><![CDATA[]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[horizontal]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[SELECT  sum(CENA), to_char(DATUM,'DD.MM.YYYY')
      FROM PLATBA
INNER JOIN HISTORIA_PARKOVANIA HP
     USING (ID_HISTORIA)
INNER JOIN PARKOVACIE_MIESTO PM
     USING (ID_MIESTA)
INNER JOIN ZONA
     USING (ID_ZONA)
     WHERE DATUM BETWEEN :DATUM_OD AND :DATUM_DO
       AND ZONA.TYP_VOZIDLO = :TYP_VOZIDLO
       AND ZONA.TYP_ZONA = :TYP_ZONA
       group by to_char(DATUM,'DD.MM.YYYY')]]></sql>
		<binds>
			<bind id="DATUM_OD">
				<prompt><![CDATA[DATUM_OD]]></prompt>
				<tooltip><![CDATA[DATUM_OD]]></tooltip>
				<value><![CDATA[01.01.2001]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
			<bind id="DATUM_DO">
				<prompt><![CDATA[DATUM_DO]]></prompt>
				<tooltip><![CDATA[DATUM_DO]]></tooltip>
				<value><![CDATA[01.01.2018]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
			<bind id="TYP_VOZIDLO">
				<prompt><![CDATA[TYP_VOZIDLO]]></prompt>
				<tooltip><![CDATA[TYP_VOZIDLO]]></tooltip>
				<value><![CDATA[O]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
			<bind id="TYP_ZONA">
				<prompt><![CDATA[TYP_ZONA]]></prompt>
				<tooltip><![CDATA[TYP_ZONA]]></tooltip>
				<value><![CDATA[Z]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
		</binds>
	</query>
		<pdf version="VERSION_1_7" compression="CONTENT">
			<docproperty title="null" author="null" subject="null" keywords="null" />
			<cell toppadding="2" bottompadding="2" leftpadding="2" rightpadding="2" horizontalalign="LEFT" verticalalign="TOP" wrap="true" />
			<column>
				<heading font="null" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="FIRST_PAGE" />
				<footing font="null" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="NONE" />
				<blob blob="NONE" zip="false" />
			</column>
			<table font="null" size="10" style="NORMAL" color="-16777216" userowshading="false" oddrowshading="-1" evenrowshading="-1" showborders="true" spacingbefore="12" spacingafter="12" horizontalalign="LEFT" />
			<header enable="false" generatedate="false">
				<data>
				
				
				null												</data>
			</header>
			<footer enable="false" generatedate="false">
				<data value="null" />
			</footer>
			<pagesetup papersize="LETTER" orientation="1" measurement="in" margintop="1.0" marginbottom="1.0" marginleft="1.0" marginright="1.0" />
		</pdf>
</display>
</displays>