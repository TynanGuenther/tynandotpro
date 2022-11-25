import moustachu
import misc
import json
import db
from strutils import format

import db_sqlite

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
          <a href="/software">Software</a>
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
          <a href="/software">Software</a>
					<a href="/blog">Blog</a>
				</div>
			</div>
    <header>
    <div class="main">
      <h2>{title}</h2>
      <h3>{date}</h3>
      <p>{content}</p>
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

proc showPage*(pageFile:string, content:JsonNode):string=
  let core = readFile("public/pages/$1.html".format(pageFile))
  let coreRendered = render(core, content)
  content["core_html"] = newJString(coreRendered)
  result = render(GeneralTemplate , content)

proc showPost*(pageFile:string, content:JsonNode):string=
  let post = getPostFromID(2)
  content["title"] = newJString(post[1])
  content["date"] = newJString(post[2])
  content["content"] = newJString(post[3])
  result = render(BlogPostTemplate , content)





