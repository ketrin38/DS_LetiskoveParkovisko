<?xml version="1.0" encoding="UTF-8" ?>
<displays>
<display id="f3d459b3-015b-1000-8006-c0a83801158e" type="" style="Chart" enable="true">
	<name><![CDATA[STATISTIKA_OBSADENOST]]></name>
	<description><![CDATA[]]></description>
	<tooltip><![CDATA[]]></tooltip>
	<drillclass><![CDATA[]]></drillclass>
	<CustomValues>
		<Y1AXIS_SCALE_INCREMENT><![CDATA[20.0]]></Y1AXIS_SCALE_INCREMENT>
		<Y1AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y1AXIS_TITLE_ALIGNMENT>
		<STYLE><![CDATA[Default]]></STYLE>
		<TITLE_ALIGNMENT><![CDATA[LEFT]]></TITLE_ALIGNMENT>
		<LEGEND_LOCATION><![CDATA[AUTOMATIC]]></LEGEND_LOCATION>
		<XAXIS_SCALE_INCREMENT><![CDATA[20.0]]></XAXIS_SCALE_INCREMENT>
		<LEGEND_ALIGNMENT><![CDATA[LEFT]]></LEGEND_ALIGNMENT>
		<PLOT_DATALABELS_SLICE_TYPE><![CDATA[PERCENT_VALUE]]></PLOT_DATALABELS_SLICE_TYPE>
		<PLOT_DATALABELS_SLICE_POSITION><![CDATA[OUTSIDE_SLICE_LINE]]></PLOT_DATALABELS_SLICE_POSITION>
		<Y2AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y2AXIS_TICK_LABEL_ROTATE>
		<XAXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></XAXIS_TITLE_ALIGNMENT>
		<Y1AXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></Y1AXIS_TICK_LABEL_ROTATE>
		<XAXIS_TICK_LABEL_ROTATE><![CDATA[HORIZONTAL]]></XAXIS_TICK_LABEL_ROTATE>
		<Y2AXIS_SCALE_INCREMENT><![CDATA[20.0]]></Y2AXIS_SCALE_INCREMENT>
		<TYPE><![CDATA[RING_MULTI]]></TYPE>
		<Y2AXIS_TITLE_ALIGNMENT><![CDATA[CENTER]]></Y2AXIS_TITLE_ALIGNMENT>
		<GRID_WIDTH><![CDATA[THINNER]]></GRID_WIDTH>
		<SUBTITLE_ALIGNMENT><![CDATA[LEFT]]></SUBTITLE_ALIGNMENT>
		<FOOTNOTE_ALIGNMENT><![CDATA[LEFT]]></FOOTNOTE_ALIGNMENT>
	</CustomValues>
	<query>
		<sql><![CDATA[SELECT '' AS VOZIDLO, EXTRACT(MONTH FROM odkedy)AS MESIAC, COUNT(*) AS POCET
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
       GROUP BY  EXTRACT(MONTH FROM odkedy)]]></sql>
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
				<value><![CDATA[1]]></value>
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
			<docproperty title="" author="" subject="" keywords="" />
			<cell toppadding="2" bottompadding="2" leftpadding="2" rightpadding="2" horizontalalign="LEFT" verticalalign="TOP" wrap="true" />
			<column>
				<heading font="null" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="FIRST_PAGE" />
				<footing font="null" size="10" style="NORMAL" color="-16777216" rowshading="-1" labeling="NONE" />
				<blob blob="NONE" zip="false" />
			</column>
			<table font="null" size="10" style="NORMAL" color="-16777216" userowshading="false" oddrowshading="-1" evenrowshading="-1" showborders="true" spacingbefore="12" spacingafter="12" horizontalalign="LEFT" />
			<header enable="false" generatedate="false">
				<data>
				null				</data>
			</header>
			<footer enable="false" generatedate="false">
				<data value="null" />
			</footer>
			<pagesetup papersize="LETTER" orientation="1" measurement="in" margintop="1.0" marginbottom="1.0" marginleft="1.0" marginright="1.0" />
		</pdf>
</display>
</displays>