import strutils, re
proc dedent*(s:string):string=
  var s = s.strip(leading = false)
  var minIndent = 9999999999
  for l in s.splitLines:
    let indent = count(l, ' ')
    if indent == 0:continue
    if indent < minIndent: minIndent = indent
  result = s.unindent(minIndent)

proc slug*(s:string):string=
  var s = s.toLowerAscii()
  s = s.replace(re"/[^a-z0-9-]/", "-")
  s = s.replace(" ", "-")
  s = s.replace(re"/-+/", "-")
  return s
