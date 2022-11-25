import db_sqlite, math, strformat, strutils

let db* = open("blog.db","","","")

#doAssert db.getAllRows(sql"SELECT title FROM Posts") == @[Row(@["NOPe"])]
type EmptyFileException* = object of Exception

proc getAllPostsTitles*():seq[Row]=
  result = db.getAllRows(sql"SELECT title FROM Posts")

proc getPostFromID*(id:int):Row=
  result = db.getRow(sql(&"SELECT * FROM Posts WHERE ID = {id}"))

proc putPost*(filename:string)=
  let file = readFile(&"posts/{filename}.blog")
  if file == "":
    raise EmptyFileException.newException("That file is empty!")
  let post = file.split("\n",1)
  let title = post[0]
  let content = post[1]
  db.exec(sql(&"INSERT INTO Posts (title, content, date) VALUES ('{title}', '{content}', date('now'))"))


