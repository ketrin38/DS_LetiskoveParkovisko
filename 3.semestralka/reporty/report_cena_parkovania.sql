<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="ee23bf41-015b-1000-8001-c0a80166f66e" type="" style="Chart" enable="true">
	<name><![CDATA[cena_parkovania]]></name>
	<description><![CDATA[				]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<TYPE><![CDATA[BAR_VERT_CLUST]]></TYPE>
	</CustomValues>
	<query>
		<sql><![CDATA[select 'suma v €',typ_zona,sum(cena) from platba
join historia_parkovania using(id_historia)
join parkovacie_miesto using(id_miesta)
join zona using(id_zona)
group by typ_zona]]></sql>
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
	<display id="null" type="" style="Table" enable="true">
		<name><![CDATA[aa]]></name>
		<description><![CDATA[]]></description>
		<tooltip><![CDATA[]]></tooltip>
		<drillclass><![CDATA[]]></drillclass>
		<CustomValues>
			<TYPE><![CDATA[horizontal]]></TYPE>
		</CustomValues>
		<query>
			<sql><![CDATA[select * from parkovacie_miesto]]></sql>
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
					
					
					null															</data>
				</header>
				<footer enable="false" generatedate="false">
					<data value="null" />
				</footer>
				<pagesetup papersize="LETTER" orientation="1" measurement="in" margintop="1.0" marginbottom="1.0" marginleft="1.0" marginright="1.0" />
			</pdf>
	</display>
</display>
</displays>