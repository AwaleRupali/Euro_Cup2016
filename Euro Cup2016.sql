# 1. Return the sql query to find out where the final match of the EURO cup 2016 was played. return venue name, city.
select venue_name, city from soccer_venue sv join soccer_city sc on sv.city_id=sc.city_id join match_mast mm on sv.venue_id = mm.venue_id and play_stage='F';

# 2. Write a SQL query to find the number of goals scored by each team in each match during normal play. Return match number, country name and goal score.
select match_no, country_name, goal_score ,team_id from match_details md join soccer_country  sc on md.team_id=sc.country_id where decided_by='N' order by match_no;

# 3. Write a SQL query to count the number of goals scored by each player within a normal play schedule. Group the result set on player name and country name and
 # sort the result-set according to the highest to the lowest scorer. Return player name, number of goals and country name.
select player_name,count(*), country_name from player_mast pl join goal_details gd on pl.team_id=gd.team_id join soccer_country sc on sc.country_id=gd.team_id
 where goal_schedule='NT' group by player_name, country_name order by count(*) desc;

# 4. Write a SQL query to find out who scored the most goals in the 2016 Euro Cup. Return player name, country name and highest individual scorer.
select player_name,count(player_name), country_name from goal_details gd join player_mast pm on gd.player_id=pm.player_id join soccer_country sc on pm.team_id=sc.country_id
group by player_name, country_name having count(player_name)>= all( select count(player_name) from goal_details gd join player_mast pm on gd.player_id=pm.player_id join soccer_country sc on pm.team_id=sc.country_id
group by player_name, country_name); 

# 5. Write a SQL query to find out who scored in the final of the 2016 Euro Cup. Return player name, jersey number and country name.
select player_name, jersey_no,country_name from player_mast pm join goal_details gd on pm.team_id=gd.team_id join soccer_country sc on pm.team_id=sc.country_id where
play_stage='F';

# 6.write a SQL query to find out which country hosted the 2016 Football EURO Cup. Return country name.*/
select country_name from soccer_country sc join soccer_city s using(country_id) join soccer_venue sv using (city_id) group by country_name;

# 7. write a SQL query to find out who scored the first goal of the 2016 European Championship. 
 # Return player_name, jersey_no, country_name, goal_time, play_stage, goal_schedule, goal_half.*/
 select pm.player_name, pm.jersey_no, sc.country_name, gd.goal_time,gd.goal_id, gd.play_stage, gd.goal_schedule, gd.goal_half from player_mast pm join soccer_country sc
 on sc.country_id=pm.team_id join goal_details gd 
  on pm.player_id=gd.player_id where  goal_id=1;
  
# 8. Write a SQL query to find the referee who managed the opening match. Return referee name, country name.
 select match_no, referee_name, country_name from referee_mast rm join match_mast mm on rm.referee_id=mm.referee_id join soccer_country sc on sc.country_id= rm.country_id
 where match_no=1;
 
 # 9. Write a SQL query to find the referee who managed the final match. Return referee name, country name.
 SELECT b.referee_name, c.country_name 
FROM match_mast a
NATURAL JOIN referee_mast b 
NATURAL JOIN soccer_country c
WHERE play_stage='F';
select match_no,referee_name,country_name from referee_mast rm join match_mast mm on rm.referee_id=mm.referee_id join soccer_country sc on sc.country_id= rm.country_id
 where play_stage='F';
 
 # 10. Write a SQL query to find the referee who assisted the referee in the opening match. Return associated referee name, country name.
 SELECT ass_ref_name, country_name 
FROM asst_referee_mast a
JOIN soccer_country b
ON a.country_id=b.country_id
JOIN match_details c
ON a.ass_ref_id=c.ass_ref
WHERE match_no=1;
 select ass_ref_name, country_name from asst_referee_mast ar join soccer_country sc on ar.country_id=sc.country_id join  match_details md on 
 md.ass_ref=ar.ass_ref_id where match_no=1;
 
 # 11. Write a SQL query to find the referee who assisted the referee in the final match. Return associated referee name, country name.
  select ass_ref_name, country_name from asst_referee_mast ar join soccer_country sc on ar.country_id=sc.country_id join  match_details md on 
 md.ass_ref=ar.ass_ref_id where play_stage='F';
 
 # 12. Write a SQL query to find the city where the opening match of EURO cup 2016 took place. Return venue name, city.
 select venue_name,city from  soccer_venue sv join soccer_city sc on sv.city_id=sc.city_id join match_mast mm on sv.venue_id=mm.venue_id 
 where match_no=1;
 
 # 13. Write a SQL query to find out which stadium hosted the final match of the 2016 Euro Cup. Return venue_name, city, aud_capacity, audience.
 select venue_name, city,audience, aud_capacity from soccer_venue sv join soccer_city sc on sv.city_id=sc.city_id join match_mast mm on mm.venue_id=sv.venue_id
 where play_stage='F';
 
 # 14.Write a SQL query to count the number of matches played at each venue. Sort the result-set on venue name. Return Venue name, city, and number of matches.
 select venue_name,count(match_no),city from soccer_venue sv join soccer_city sc on sv.city_id=sc.city_id join match_mast mm on sv.venue_id=mm.venue_id
 group by venue_name,city order by venue_name;
 
 #15. Write a SQL query to find the player who was the first player to be sent off at the tournament EURO cup 2016. Return match Number, country name and player name.
 SELECT match_no, country_name, player_name, 
booking_time as "sent_off_time", play_schedule, jersey_no
FROM player_booked a
JOIN player_mast b
ON a.player_id=b.player_id
JOIN soccer_country c
ON a.team_id=c.country_id
AND  a.sent_off='Y'
AND match_no=(
	SELECT MIN(match_no) 
	from player_booked)
ORDER BY match_no,play_schedule,play_half,booking_time;
select match_no,country_name,player_name from player_mast pm join player_booked pb on pm.player_id=pb.player_id join soccer_country sc on pb.team_id=sc.country_id
 where sent_off='Y' and match_no=1;
 