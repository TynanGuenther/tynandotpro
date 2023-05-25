import moustachu
import misc
import json
import db
import db_sqlite
from strutils import format

#<a href="/software">Software</a> for when software is ready
const GeneralTemplate = dedent """
<!DOCTYPE html>
<html>
	<head>
    <link rel="stylesheet" type="text/css" href={{css_file}}/>
	  <link rel="stylesheet" type="text/css" href="pages/css/default.css"/>

	</head>
	<body>


		<header>
			<div class="titleContainer">
				<h1><a href="/">Tynan.pro</a></h1>
			</div>
			
			<div class="navContainer">
				<div class="topnav">
					<a href="/resume">Resume</a>
					<a href="/blog">Blog</a>
				</div>
			</div>
    <header>
    <div class="main">
      {{{core_html}}}
      
      <hr style="color:white" width="100%">
    </div>
    <footer>
      <center>
        <a href="https://github.com/TynanGuenther"><img src="static/github.png" alt="Github" width="30" height="30"></a>
        <p>If you want to see my code check out my Github</p>
        <h4>Tynan Guenther 2022</h4>
      </center>
    </footer>

	</body>
</html>
  
  """
const BlogPostTemplate = dedent """
<!DOCTYPE html>
<html>
	<head>
    <link rel="stylesheet" type="text/css" href={{css_file}}/>
	  <link rel="stylesheet" type="text/css" href="/pages/css/default.css"/>

	</head>
	<body>


		<header>
			<div class="titleContainer">
				<h1><a href="/">Tynan.pro</a></h1>
			</div>
			
			<div class="navContainer">
				<div class="topnav">
					<a href="/resume">Resume</a>
          <a href="/software">Software</a>
					<a href="/blog">Blog</a>
				</div>
			</div>
    <header>
    <div class="main">
      <h2>{{title}}</h2>
      <h3>{{date}}</h3>
      <p>{{content}}</p>
      <hr style="color:white" width="100%">
    </div>
    <footer>
      <center>
        <a href="https://github.com/TynanGuenther"><img src="/static/github.png" alt="Github" width="30" height="30"></a>
        <p>If you want to see my code check out my Github</p>
        <h4>Tynan Guenther 2022</h4>
      </center>
    </footer>

	</body>
</html>
  
  """

proc showPage*(pageFile:string, content:JsonNode):string=
  let core = readFile("public/pages/$1.html".format(pageFile))
  let coreRendered = render(core, content)
  content["core_html"] = newJString(coreRendered)
  result = render(GeneralTemplate , content)

proc showPost*(slug_title:string):string=
  var content = newJObject()
  let post = getPostFromID(slug_title)
  echo post
  content["title"] = newJString(post[1])
  content["date"] = newJString(post[3])
  content["content"] = newJString(post[2])
  result = render(BlogPostTemplate , content)


proc getAllPosts():string=
  var page:string = readFile("public/pages/blog.html")
  for row in db.db.instantRows(sql"SELECT slug,title,date FROM Posts"):
    var slug_name = "/blog/"&row[0]
    page = page & "<tr>" & "<td><a href=\"$1\">".format(slug_name) & row[1] & "</a></td>" & "<td>" & row[2] & "</td></tr>" 

  page = page & "</table>"
  return page

proc blogPage*(content:JsonNode):string=
  content["core_html"]= newJString(getAllPosts())
  result = render(GeneralTemplate, content)






