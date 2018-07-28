<html>
    <head>
        <title>SignUp</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
        
        <style>
            #signUpButton:hover
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
        
        <div class="row">
            <div class="col-sm-4"></div>
            
            <div class="col-sm-4" style="border:1px solid #FFC300; margin-top:150px; border-radius:5px;"> 
                <h2 style="text-align:center;">SignUp</h2>
                <form action="signUp2" method="post" onsubmit="return validate()"> 
                    <div id="message" style="text-align:center;"></div> <br/>
                    <input type="text" name="name" class="form-control" placeholder="Enter your Name : " required>  <br/>
                    <input type="date" name="dob" class="form-control" placeholder="Enter your date of  birth : " required> <br/>
                    <input type="text" name="userId" id="userId" class="form-control" placeholder="Enter a UserId (Email Id) : " required> <br/>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Enter your Password : " required> <br/> 
                    <input type="password" name="cPassword" id="cPassword" class="form-control" placeholder="ReEnter your Password : " required> <br/>
                    <span>&nbsp; Already an user? <a href="index.jsp">Login.</a></span>
                    <input type="submit" class="btn" id="signUpButton" value="SignUp" style="background-color:#68dff0; float:right;"> <br/> <br/>
                    <input type="hidden" name="userIdType" id="userIdType" value="">
                </form>
            </div>
            
            <div class="col-sm-4"></div>
        </div>
        
    </body>
    
    
    <script>
        
        $("#sidebar-toggle-box").css("visibility","hidden");
        $("#logoutDiv").css("visibility","hidden");
        
        function validate(){
            
            var userId = $("#userId").val();
            var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            
            var password = $("#password").val();
            var cPassword = $("#cPassword").val();
            
            if(password != cPassword)
            {
                $("#message").html("<p style='border:0.5px solid #B80000;'> Password does not match. </p>");
                $('#message').css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;
            }
            if(!(re.test(userId)))           // if email id
            {   
                $("#message").html("<p style='border:0.5px solid #B80000;'> Invalid Email Id. </p>");
                $('#message').css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;
            }
            else if(re.test(userId))
            {
                $("#userIdType").val("email");
                return true;
            }
            return true;
            /*else if((userId.length == 10) && !(isNaN(userId)))     // if 10 digit mobile number
            {
                $("#userIdType").val("mobile");
                return true;
            }
            */
        }
        
        setTimeout("hideMessage()",5000);
        function hideMessage()
        {
            $('#message').css("visibility","hidden");
        }
        
        function logIn(){
            window.location.href = "index.jsp";
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
        
    </script>
    
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>