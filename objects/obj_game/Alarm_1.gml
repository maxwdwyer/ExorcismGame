alarm[1] = minutelen
minute += 1 
//if minute = 30 then event_user(0)
//if minute = 10 then event_user(0)
//if minute = 20 then event_user(0)
if minute = 30 then event_user(0)
//if minute = 40 then event_user(0)
//if minute = 50 then event_user(0)
if minute = 60
{
	hour += 1
	minute = 0
	event_user(0)
	event_user(0)
}