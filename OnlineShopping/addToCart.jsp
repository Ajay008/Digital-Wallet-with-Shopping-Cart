


<%
   //out.println(request.getQueryString());
   String query = request.getQueryString();
   
   String name = query.substring(0,query.indexOf('='));
   String value = request.getParameter(name);
   
   String gobackURL = name +".jsp";
   //out.println(gobackURL + "  " + name  + "  " + value);
   
   session.setAttribute(name,value);
   
%>


    
    
<script>

    window.location.assign("<%=gobackURL%>");
    
</script>