compare_bc(
  generate_bc("mysite.com/pictures/holidays.html", " : "),
  '<a href="/">HOME</a> : <a href="/pictures/">PICTURES</a> : <span class="active">HOLIDAYS</span>'
)
compare_bc(
  generate_bc("www.codewars.com/users/GiacomoSorbi?ref=CodeWars", " / "),
  '<a href="/">HOME</a> / <a href="/users/">USERS</a> / <span class="active">GIACOMOSORBI</span>'
)
compare_bc(
  generate_bc("www.microsoft.com/docs/index.htm#top", " * "),
  '<a href="/">HOME</a> * <span class="active">DOCS</span>'
)
compare_bc(
  generate_bc("mysite.com/very-long-url-to-make-a-silly-yet-meaningful-example/example.asp", " > "),
  '<a href="/">HOME</a> > <a href="/very-long-url-to-make-a-silly-yet-meaningful-example/">VLUMSYME</a> > <span class="active">EXAMPLE</span>'
)
compare_bc(
  generate_bc("www.very-long-site_name-to-make-a-silly-yet-meaningful-example.com/users/giacomo-sorbi", " + "),
  '<a href="/">HOME</a> + <a href="/users/">USERS</a> + <span class="active">GIACOMO SORBI</span>'
)
compare_bc(
  generate_bc("www.microsoft.com/important/confidential/docs/index.htm#top", " * "),
  '<a href="/">HOME</a> * <a href="/important/">IMPORTANT</a> * <a href="/important/confidential/">CONFIDENTIAL</a> * <span class="active">DOCS</span>'
)
compare_bc(
  generate_bc("https://www.linkedin.com/in/giacomosorbi", " * "),
  '<a href="/">HOME</a> * <a href="/in/">IN</a> * <span class="active">GIACOMOSORBI</span>'
)
compare_bc(
  generate_bc("www.agcpartners.co.uk/", " * "),
  '<span class="active">HOME</span>'
)
compare_bc(
  generate_bc("https://www.agcpartners.co.uk/index.html", " * "),
  '<span class="active">HOME</span>'
)
