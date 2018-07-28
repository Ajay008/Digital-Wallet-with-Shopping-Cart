
<html>
    <head>
        <title>Cart</title>
        <jsp:include page="includeFiles/head.jsp"></jsp:include> 
    </head>
   
    <body>
        
        
        <jsp:include page="includeFiles/header.jsp"></jsp:include> 
  
        
        <div class="row">
            <div class="col-sm-3"></div>
            
            <div class="col-sm-6">
                
                <br/> <br/>
                
                <div id="message" style="text-align:center;"></div> 
                
                <br/> <br/> 
                <h4 style="text-decoration:none; font-size:2em;"> <center> Digital Wallet </center> </h4> <br/>
            
                <div class="row" style="font-size:1.5em;">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-4"> Wallet User Id : </div>
                    <div class="col-sm-4"> <%=session.getAttribute("userId").toString()%> </div>
                    <div class="col-sm-2"></div>
                </div> <br/>
                
                <div class="row" style="font-size:1.5em;">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-4"> Available Balance :  </div>
                    <div class="col-sm-4"> &#8377; <span  id="loadBalance"></span> </div>
                    <div class="col-sm-2"></div>
                </div> <br/>
                        
                <div class="row" style="font-size:1.5em;">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-4"> Total Bill : </div>
                    <div class="col-sm-4"> &#8377; <%=session.getAttribute("totalPrice").toString()%> </div>
                    <div class="col-sm-2"></div>
                </div> <br/> <br/>
                        
                <center><button class="btn btn-success btn-lg" onclick="callCart3()" style="width:100px;">Pay</button></center>
                        
            </div>
            
            <div class="col-sm-3"></div>
        </div>
        
    </body>
    
    <script>
        $(document).ready(function(){
            $("#cart").addClass("active");       
        });
        
        $("#loadBalance").load("../loadBalance");
        
        function callCart3()
        {
            window.location.href = "../cart3";
        }
        
        <%
            if(request.getAttribute("message")!=null)
            {
                String message = request.getAttribute("message").toString();
                String tempString = "<p style='border:0.5px solid #58D68D;'>"+message+"</p>";
                out.println("$('#message').html(\""+tempString+"\");");
            }
            if(request.getAttribute("errorMessage")!=null)
            {
                String errorMessage = request.getAttribute("errorMessage").toString();
                String tempString = "<p style='border:0.5px solid #B80000;'>"+errorMessage+"</p>";
                out.println("$('#message').html(\""+tempString+"\");");
            }
        %> 
        setTimeout("hideMessage()",5000);
        function hideMessage()
        {
            $('#message').css("visibility","hidden");
        }
        
    </script>
</html>