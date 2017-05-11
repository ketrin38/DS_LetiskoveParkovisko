<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="e838d7f5-015b-1000-800f-c0a83801d425" type="" style="Chart" enable="true">
	<name><![CDATA[OBSADENOST_VYVIN]]></name>
	<description><![CDATA[]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<PLOT_HGRID_WIDTH><![CDATA[THINNER]]></PLOT_HGRID_WIDTH>
		<Y1AXIS_SCALE_INCREMENT><![CDATA[30.0]]></Y1AXIS_SCALE_INCREMENT>
		<Y2AXIS_SCALE_MAXIMUM><![CDATA[80.0]]></Y2AXIS_SCALE_MAXIMUM>
		<Y1AXIS_LINE_WIDTH><![CDATA[THINNEST]]></Y1AXIS_LINE_WIDTH>
		<Y1AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y1AXIS_TITLE_ALIGNMENT>
		<LEGEND_LOCATION><![CDATA[AUTOMATIC]]></LEGEND_LOCATION>
		<LEGEND_ALIGNMENT><![CDATA[LEFT]]></LEGEND_ALIGNMENT>
		<XAXIS_LINE_WIDTH><![CDATA[THINNEST]]></XAXIS_LINE_WIDTH>
		<Y1AXIS_SCALE_MAXIMUM><![CDATA[210.0]]></Y1AXIS_SCALE_MAXIMUM>
		<XAXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></XAXIS_TITLE_ALIGNMENT>
		<XAXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></XAXIS_TICK_LABEL_ROTATE>
		<Y1AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y1AXIS_LOGARITHMIC_BASE>
		<TYPE><![CDATA[LINE_VERT_STACK]]></TYPE>
		<GRID_WIDTH><![CDATA[THINNER]]></GRID_WIDTH>
		<FOOTNOTE_ALIGNMENT><![CDATA[LEFT]]></FOOTNOTE_ALIGNMENT>
		<XAXIS_TICK_LABEL_SKIP_MODE><![CDATA[AUTOMATIC]]></XAXIS_TICK_LABEL_SKIP_MODE>
		<Y2AXIS_LOGARITHMIC_BASE><![CDATA[BASE_10]]></Y2AXIS_LOGARITHMIC_BASE>
		<STYLE><![CDATA[Default]]></STYLE>
		<TITLE_ALIGNMENT><![CDATA[LEFT]]></TITLE_ALIGNMENT>
		<Y2AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y2AXIS_TICK_LABEL_ROTATE>
		<Y2AXIS_SCALE_MINIMUM><![CDATA[10.0]]></Y2AXIS_SCALE_MINIMUM>
		<Y2AXIS_LINE_WIDTH><![CDATA[THINNEST]]></Y2AXIS_LINE_WIDTH>
		<Y1AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y1AXIS_TICK_LABEL_ROTATE>
		<Y2AXIS_SCALE_INCREMENT><![CDATA[20.0]]></Y2AXIS_SCALE_INCREMENT>
		<PLOT_VGRID_WIDTH><![CDATA[THINNER]]></PLOT_VGRID_WIDTH>
		<Y2AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y2AXIS_TITLE_ALIGNMENT>
		<SUBTITLE_ALIGNMENT><![CDATA[LEFT]]></SUBTITLE_ALIGNMENT>
	</CustomValues>
	<query>
		<sql><![CDATA[SELECT  ROUND(NVL(dokedy,sysdate)-odkedy), COUNT(*), ROUND(NVL(dokedy,sysdate)-odkedy)
      FROM HISTORIA_PARKOVANIA
INNER JOIN PARKOVACIE_MIESTO
     USING (ID_MIESTA)
INNER JOIN ZONA
     USING (ID_ZONA)
INNER JOIN VOZIDLO 
     USING (SPZ)
INNER JOIN PREUKAZ 
     USING (ID_PREUKAZ)
INNER JOIN ZAKAZNIK
     USING (ID_ZAKAZNIK)
     WHERE TYP_ZONA = :ZONA
       AND ID_MIESTA = :ID_MIESTA
       AND TYP = :TYP_KLIENTA
       GROUP BY ROUND(NVL(dokedy,sysdate)-odkedy)]]></sql>
		<binds>
			<bind id="ZONA">
				<prompt><![CDATA[ZONA]]></prompt>
				<tooltip><![CDATA[ZONA]]></tooltip>
				<value><![CDATA[V]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
			<bind id="ID_MIESTA">
				<prompt><![CDATA[ID_MIESTA]]></prompt>
				<tooltip><![CDATA[ID_MIESTA]]></tooltip>
				<value><![CDATA[640]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
			<bind id="TYP_KLIENTA">
				<prompt><![CDATA[TYP_KLIENTA]]></prompt>
				<tooltip><![CDATA[TYP_KLIENTA]]></tooltip>
				<value><![CDATA[S]]></value>
				<bracket><![CDATA[null]]></bracket>
			</bind>
		</binds>
	</query>
		<pdf version="VERSION_1_7" compression="CONTENT">
			<docproperty title="null" author="null" subject="null" keywords="null" />
			<cell toppadding="2" bottompadding="2" leftpadding="2" rightpadding="2" horizontalalign="LEFT" verticalalign="TOP" wrap="true" />
			<column>
				<heading font="AR BERKLEY" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="FIRST_PAGE" />
				<footing font="AR BERKLEY" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="NONE" />
				<blob blob="NONE" zip="false" />
			</column>
			<table font="AR BERKLEY" size="10" style="NORMAL" color="-16777216" userowshading="false" oddrowshading="-1" evenrowshading="-1" showborders="true" spacingbefore="12" spacingafter="12" horizontalalign="LEFT" />
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