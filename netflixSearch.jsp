<html>
<head><title>Simple Search Page</title></head>
<body>
<script type="text/javascript">
 //callback
  Response resp = null;
 Strong sTerm = request.getParameter("term");
 if( sTerm != null ) {
   DemoApp.getService().buildRequestURI("http://api-public.netflix.com/catalog/titles?term="+sTerm);
  resp = DemoApp.getService().call(sRequest, Method.GET, null); 
 }
</script>
<table>
 <tr><form action="netflixSearch.jsp"><td></td>
  <input type="text" name="term" />
  <input type="submit" /></form></tr>
<script type="text/javascript">
 if( resp != null ) {
  DomRepresentation rep = resp.getEntityAsDom();
  Document doc = rep.getDocument(); 
  XPath xpath = XPathFactory.newInstance().newXPath();
  NodeList nodes = 
   (NodeList) xpath.evaluate( "http://api-public.netflix.com/catalog_titles/catalog_title", doc, XPathConstants.NODESET );
  for( int i=0, n=nodes.getLength(); i<n; i++ ) {
   Node node = nodes.item(i);
       Retrieve the data of interest:
   String sTitle = (String) xpath.evaluate( "title/@regular", node, XPathConstants.STRING );
   String sImage = (String) xpath.evaluate( "box_art/@large", node, XPathConstants.STRING );
   String sID = (String) xpath.evaluate( "id/text()", node, XPathConstants.STRING );

  }
 }
</script>
<tr><table><tr align="center">
 <img src="<%=sImage%>" /><br />
 <%=sTitle%><br />
 <form action="addToQueue.jsp">
  <input type="hidden" name="title_ref" value="<%=sID%>" />
  <input type="submit" value="ADD" />
 </form><br /></tr></table>
</tr>
</table></body></html>
