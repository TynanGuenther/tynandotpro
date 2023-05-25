import jester
import json
from strutils import format
import views

routes:
  #Home Page
  get "/":
    var content = newJObject()
    content["page_title"] = newJString("tynan.pro")
    resp showPage("index", content)
  #Resume Page
  get "/resume":
    var content = newJObject()
    content["page_title"] = newJString("Resume")
    resp showPage("resume", content)
  #Software
#[  get "/software":
    var content = newJObject()
    content["page_title"] = newJString("Software")
    resp showPage("software", content)
]#
  #Blog
  get "/blog":
    var content = newJObject()
    content["page_title"] = newJString("Blog")
    resp blogPage(content)
  #Post
  get "/blog/@post?":
    var content = newJObject()
    content["page_title"] = newJString("Blog/" & @"post")
    resp showPost(@"post")



