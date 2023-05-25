import db_sqlite, strformat, strutils, misc

let db* = open("blog.db","","","")


proc getPostFromID*(slug_title:string):Row=
  result = db.getRow(sql(&"SELECT * FROM Posts WHERE slug = '{slug_title}'"))

proc putPost*(filename:string)=
  let file = readFile(&"posts/{filename}.blog")
  if file == "":
    raise ValueError.newException("That file is empty!")
  let post = file.split("\n",1)
  let title = post[0]
  let content = post[1]
  let slug_name = title.slug()
  db.exec(sql(&"INSERT INTO Posts (title, content, date) VALUES ('{slug_name}','{title}', '{content}', date('now'))"))


