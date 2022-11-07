import strutils
import jester
import moustachu
import json

import views

routes:
  #Home Page
  get "/":
    var content = newJObject()
    content["page_title"] = newJString("tynan.pro")
    resp render(readFile("pages/index.html"),content)
  #Resume Page
  get "/resume":
    var content = newJObject()
    content["page_title"] = newJString("Resume")
    resp showPage("resume", content)
  #About Me Page
  get "/about":
    var content = newJObject()
    content["page_title"] = newJString("About-Me")
    resp showPage("about", content)

  get "/software":
    var content = newJObject()
    content["page_title"] = newJString("Software")
    resp showPage("software", content)


