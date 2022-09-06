--QUESTION1
SELECT SUM(ST_Length(ST_Transform(geom, 32735))/1000) AS KM_N1
FROM public."roads ldr_roads_national"
WHERE route = 'N1';

--QUESTION2
SELECT COUNT(MUN.id)
FROM public."municipalities SA_Munics2016" MUN,
	public."roads ldr_roads_national" R
WHERE ST_Crosses(MUN.geom,R.geom) AND route = 'N1';

--QUESTION3
SELECT SP1.sp_name, SP2.sp_name
FROM public."subplace_centroids subplaces_2011_centroids" CN1,
public."subplace_2011 subplaces_2011" SP1, 
public."subplace_centroids subplaces_2011_centroids" CN2,
public."subplace_2011 subplaces_2011" SP2
WHERE ST_Within(CN1.geom, SP1.geom) AND ST_Within(CN2.geom, SP2.geom)
AND CN1.id != CN2.id
ORDER BY ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
ASC
LIMIT 1;

SELECT SP1.sp_name, SP2.sp_name, ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
FROM public."subplace_centroids subplaces_2011_centroids" CN1,
public."subplace_2011 subplaces_2011" SP1, 
public."subplace_centroids subplaces_2011_centroids" CN2,
public."subplace_2011 subplaces_2011" SP2
WHERE ST_Within(CN1.geom, SP1.geom) AND ST_Within(CN2.geom, SP2.geom)
AND CN1.id != CN2.id
ORDER BY ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
ASC
LIMIT 1;

--QUESTION4
CREATE INDEX subplace_2011_geom_indx ON public."subplace_2011 subplaces_2011"  USING gist(geom);
CREATE INDEX subplace_centroids_geom_indx ON public."subplace_centroids subplaces_2011_centroids" 
USING gist(geom);

SELECT SP1.sp_name, SP2.sp_name
FROM public."subplace_centroids subplaces_2011_centroids" CN1,
public."subplace_2011 subplaces_2011" SP1, 
public."subplace_centroids subplaces_2011_centroids" CN2,
public."subplace_2011 subplaces_2011" SP2
WHERE ST_Within(CN1.geom, SP1.geom) AND ST_Within(CN2.geom, SP2.geom)
AND CN1.id != CN2.id
ORDER BY ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
ASC
LIMIT 1;

SELECT SP1.sp_name, SP2.sp_name, ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
FROM public."subplace_centroids subplaces_2011_centroids" CN1,
public."subplace_2011 subplaces_2011" SP1, 
public."subplace_centroids subplaces_2011_centroids" CN2,
public."subplace_2011 subplaces_2011" SP2
WHERE ST_Within(CN1.geom, SP1.geom) AND ST_Within(CN2.geom, SP2.geom)
AND CN1.id != CN2.id
ORDER BY ST_DISTANCE(ST_TRANSFORM(CN1.geom, 32735), ST_TRANSFORM(CN2.geom, 32735))
ASC
LIMIT 1;

--QUESTION6
SELECT SUM(ST_AREA(ST_TRANSFORM(geom, 32735))/1000)
FROM public."EA_SA_2011" EA, public."municipalities SA_Munics2016" MUN
WHERE ea_gtype = 'Urban' AND map_title = 'City of Tshwane Metropolitan Municipality'
AND ST_WITHIN(EA.geom, MUN.geom)

--QUESTION7
SELECT COUNT(GT.id)
FROM public.gautrain_bus_stops GT, public."points_of_interest points_of_interests" PO
WHERE ST_DWITHIN(GT.geom, PO.geom, 1000) AND PO.name = 'University Of Pretoria'

--QUESTION8
SELECT  ST_AREA(ST_TRANSFORM(N.geom, 32735))/1000 AS AREA
FROM public.nature_reserves N, public.provinces PR
WHERE name = 'Kruger National Park' AND prov_code = 'MP' and  
ST_INTERSECTS(ST_TRANSFORM( PR.geom, 32735), ST_Transform(N.geom, 32735))
