irb(main):002> panimo = Brewery.create name: "BreDog", year: 2007
  TRANSACTION (0.0ms)  begin transaction
  Brewery Create (0.4ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BreDog"], ["year", 2007], ["created_at", "2024-11-14 16:51:40.186341"], ["updated_at", "2024-11-14 16:51:40.186341"]]
  TRANSACTION (1.3ms)  commit transaction
=> 
#<Brewery:0x0000000120f10588
...
irb(main):003> b = Beer.create name: "Punk IPA", style: "IPA"
=> 
#<Beer:0x0000000121072520
...
irb(main):004> b.brewery=panimo
=> 
#<Brewery:0x0000000120f10588
...
irb(main):005> b.save
  TRANSACTION (0.1ms)  begin transaction
  Beer Create (0.8ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 5], ["created_at", "2024-11-14 16:52:34.081139"], ["updated_at", "2024-11-14 16:52:34.081139"]]
  TRANSACTION (1.5ms)  commit transaction
=> true
irb(main):010> Rating.create score: 5, beer_id: b.id 
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 12], ["LIMIT", 1]]
  Rating Create (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 5], ["beer_id", 12], ["created_at", "2024-11-14 16:54:14.872534"], ["updated_at", "2024-11-14 16:54:14.872534"]]
  TRANSACTION (1.3ms)  commit transaction
=> 
#<Rating:0x000000012155fad8
 id: 1,
 score: 5,
 beer_id: 12,
 created_at:
  Thu, 14 Nov 2024 16:54:14.872534000 UTC +00:00,
 updated_at:
  Thu, 14 Nov 2024 16:54:14.872534000 UTC +00:00>
irb(main):011> Rating.create score: 2, beer_id: b.id 
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 12], ["LIMIT", 1]]
  Rating Create (0.7ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 2], ["beer_id", 12], ["created_at", "2024-11-14 16:55:11.915160"], ["updated_at", "2024-11-14 16:55:11.915160"]]
  TRANSACTION (1.8ms)  commit transaction
=> 
#<Rating:0x00000001220d8360
 id: 2,
 score: 2,
 beer_id: 12,
 created_at:
  Thu, 14 Nov 2024 16:55:11.915160000 UTC +00:00,
 updated_at:
  Thu, 14 Nov 2024 16:55:11.915160000 UTC +00:00>
irb(main):012> Rating.create score: 2, beer_id: b.id
irb(main):015> Rating.create score: 10, beer_id: b.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.3ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 11], ["LIMIT", 1]]
  Rating Create (0.6ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 11], ["created_at", "2024-11-14 16:55:44.525453"], ["updated_at", "2024-11-14 16:55:44.525453"]]
  TRANSACTION (1.5ms)  commit transaction
=> 
#<Rating:0x00000001220dd9a0
 id: 4,
 score: 10,
 beer_id: 11,
 created_at:
  Thu, 14 Nov 2024 16:55:44.525453000 UTC +00:00,
 updated_at:
  Thu, 14 Nov 2024 16:55:44.525453000 UTC +00:00>
irb(main):016> Rating.create score: 10, beer_id: b.id
  TRANSACTION (0.1ms)  begin transaction
  Beer Load (0.2ms)  SELECT "beers".* FROM "beers" WHERE "beers"."id" = ? LIMIT ?  [["id", 11], ["LIMIT", 1]]
  Rating Create (0.6ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 11], ["created_at", "2024-11-14 16:55:48.271217"], ["updated_at", "2024-11-14 16:55:48.271217"]]
  TRANSACTION (2.5ms)  commit transaction
=> 
#<Rating:0x00000001220b5158
 id: 5,
 score: 10,
 beer_id: 11,
 created_at:
  Thu, 14 Nov 2024 16:55:48.271217000 UTC +00:00,
 updated_at:
  Thu, 14 Nov 2024 16:55:48.271217000 UTC +00:00>
irb(main):017> Rating.create score: 2, beer_id: b.id