-- 1. Memberi reward kepada user yang paling lama dalam menggunakan Instagram

use instagram_user;

-- select * from users;
select username, created_at 
from users
order by created_at 
asc limit 5;

select count(id) from photos ; 

-- 2. Mencari inactive user untuk memulai membuat sebuah post
-- select * from photos, users;

select * from users u 
left join photos p 
on p.user_id = u.id
where p.image_url is null
order by u.username;

-- 3. Membuat sebuah kontes
select likes.photo_id, users.username, count(likes.user_id) as like_count
from 
likes 
inner join 
photos on likes.photo_id = photos.id
inner join 
users on photos.user_id = users.id
group by 
likes.photo_id, users.username 
order by 
like_count 
desc;

-- 4. Riset mendalam tentang hashtag
select t.tag_name, count(p.photo_id) as tag_count
from
photo_tags p
inner join 
tags t
on
t.id = p.tag_id
group by
t.tag_name
order by
tag_count
desc
limit 5;

-- 5. Mencari hari tebaik dalam meluncurkan Ad Campaign
select * from users;

select date_format((created_at), '%W') as days, count(username) as num_of_user_registered 
from 
users 
group by 1 
order by 2 
desc; 

-- 6. Mencari berapa kali orang-orang membuat post dalam sehari
with base as
(select u.id as userid, 
count(p.id) as photoid
from
users u
left join
photos p on p.user_id = u.id
group by u.id)

select sum(photoid) 
as totalphotos, 
count(userid) 
as total_users, 
sum(photoid)/count(userid) 
as photoperuser
from 
base;