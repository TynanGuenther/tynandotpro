import db_sqlite, math, strformat


#doAssert db.getAllRows(sql"SELECT title FROM Posts") == @[Row(@["NOPe"])]

proc getAllPostsTitles*():seq[Row]=
  let db = open("blog.db","","","")
  result = db.getAllRows(sql"SELECT title FROM Posts")
  db.close()

proc getPostFromID*(id:int):Row=
  let db = open("blog.db","","","")
  result = db.getRow(sql(&"SELECT * FROM Posts WHERE ID = {id}"))
  db.close()

proc putPost*(title:string, content:string)=
  let db = open("blog.db","","","")
  db.exec(sql(&"INSERT INTO Posts (title, content, date) VALUES ('{title}', '{content}', date('now'))"))
  db.close()

