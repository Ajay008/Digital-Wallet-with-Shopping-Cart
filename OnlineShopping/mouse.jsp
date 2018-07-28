<html>
    <head>
        <title>Mouse</title>
        <jsp:include page="includeFiles/head.jsp"></jsp:include>   
    </head>
    
    
    <body>
        
        <jsp:include page="includeFiles/header.jsp"></jsp:include>   
        
        <center><img src="images/mouse.jpg" class="img-rounded img-responsive" alt="Mouse" style="height:240px;">
        <br/> <br/> <br/>
        Price : &#8377; <%=session.getAttribute("pricemouse1").toString()%> <br/> <br/>
        Available : <span id="itemAvail"> <%=session.getAttribute("availablemouse1").toString()%> </span> <br/> <br/>
        Added : <span id="itemQuantity"></span> &nbsp;
        <input type="button" class="btn btn-info" style="" value="+" id="addButton" onclick="add()">  &nbsp;
        <input type="button" class="btn btn-danger" style="" value="-" id="removeButton" onclick="remove()">  <br/>  <br/>
        <input type="button" class="btn btn-success" style=";" value="Add To Cart" onclick="addToCart()">
        </center>
    </body>
    

    <script>
        
        $(document).ready(function(){
            $("#mouse").addClass("active");       
        });
        
        <%
            Object item = session.getAttribute("mouse");
            if(item==null)
                item=0;
            out.println("var selected = " + item+";");
        %>
        
        document.getElementById("itemQuantity").innerHTML=selected;
        var avail=Number(document.getElementById("itemAvail").innerHTML);
        
        if(selected==avail)
            document.getElementById("addButton").disabled = true;
        if(selected==0)
            document.getElementById("removeButton").disabled = true;

    </script>
    
</html>