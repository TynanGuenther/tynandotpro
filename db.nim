import db_sqlite, math

let db = open("blog.db","","","")

doAssert db.getAllRows(sql"SELECT title FROM Posts") == @[Row(@["hello"])]

#proc getAllPostsTitles():seq[Row]=


