<html>
    <head>
        <title>Login</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
        
        <style>
            #loginButton:hover
            {
                background-color:#ffd777 !important;
            }
            a:hover
            {
                cursor:pointer;
            }
        </style>
        
    </head>
    
    <body class="container-fluid">
        
        <jsp:include page="DashGum/header.jsp"></jsp:include>
        
        <div class="row" style="margin-top:150px;">
            <div class="col-sm-4"></div>
            <div class="col-sm-4" style="border:1px solid #FFC300; border-radius:5px;">
                <h2 style="text-align:center;">Login</h2>
                <form action="logIn2" method="post" >
                    <div id="message" style="text-align:center;"></div> <br/>
                    <input type="text" name="userId" placeholder="Enter User Id (Email-Id) : " class="form-control" required> <br/>
                    <input type="password" name="password" placeholder="password" class="form-control" required> 
                    <div class="col-sm-8"> <br/>
                        <a style="margin-top:10px;" href="forgot.jsp">Forgot Password?</a> <br/> 
                        <p style="margin-top:10px;">Don't have an account? <a onclick="signUp()">Register Now.</a></p>
                    </div>
                    <div class="col-sm-4" style="margin-top:20px;">
                        <input type="submit" value="Login" id="loginButton" class="btn" style="background-color:#68dff0; float:right">
                    </div>
                </form>
            </div>
            <div class="col-sm-4"></div>
        </div>
        
    </body>
    
    
    <script>
            
        $("#sidebar-toggle-box").css("visibility","hidden");
        $("#logoutDiv").css("visibility","hidden");
        
        function signUp()
        {
            window.location.href = "signUp.jsp";
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
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
    
</html>