<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<html>
    <head>
        <title>Profile</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
    
        <style>
            #updateChanges:hover
            {
                background-color:#ffd777 !important;
            }
            input:before
            {
                content: attr(placeholder) !important;
                opacity: 0.7;
                padding-left: 0%;
            }
        </style>
        
        
    </head>
    
    
    <body class="container-fluid">

        <section id="container" >
            <jsp:include page="DashGum/header.jsp"></jsp:include>
            <jsp:include page="DashGum/sidebar.jsp"></jsp:include>

            
            <!--main content start-->
            <section id="main-content">
                 <section class="wrapper">
                    
                    <%
                        String userId=session.getAttribute("userId").toString();   
                          
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                        Statement st = con.createStatement();
                       
                        String query0 = "select * from user where userId='"+userId+"';";
                        ResultSet rs0 = st.executeQuery(query0);
                        rs0.next();
                        
                        Date dob = rs0.getDate("dob");
                        String name = rs0.getString("name");
                        String password = rs0.getString("password");
                        String email = rs0.getString("email");
                        long mobile = rs0.getLong("mobile");
                        
                    %>
                        
                    <div class="row" style="margin-top:0px;">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-5">
                            
                            <div class="centered">
                                <a href="profile.jsp"><span id="nameInitials2" style="border-radius:50%; width:60; color:fff; background-color:#ffd777; font-size:3.5em;"> &nbsp; Z &nbsp;</span></a>
                            </div>
                            
                            <form action="profile2" method="post" onsubmit="return detailsValidate()" style="margin-top:0px;">
                                <div id="message" style="text-align:center;"></div> <br/>
                                
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" name="name" id="name" placeholder="Name : ">
                                </div>
                                
                                <div class="form-group">
                                    <label for="userId">UserId:</label>
                                    <input type="text" class="form-control" name="userId" id="userId" placeholder="User ID : " disabled>
                                </div>
                                
                                <div class="form-group">
                                    <label for="password">Password:</label>
                                    <input type="password" class="form-control" name="password" id="password" placeholder="Password : ">
                                </div>
                                
                                <div class="form-group">
                                    <label for="dob">DOB:</label>
                                    <input type="date" class="form-control" name="dob" id="dob" placeholder="DOB : ">
                                </div>
                                
                                <div class="form-group">
                                    <label for="mobile">Mobile:</label>
                                    <input type="text" class="form-control" name="mobile" id="mobile" placeholder="Mobile : " maxlength="10">
                                </div>
                                
                                <center>
                                    <input type="submit" value="Update changes" id="updateChanges" class="btn" style="background-color:#68dff0;">
                                </center>
                            </form>
                        
                        
                        </div>
                        <div class="col-sm-4"></div>
                    </div>
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        
        $(document).ready(function(){
            $("#nameInitials2").load('nameInitials?userId=<%=session.getAttribute("userId")%>');
        });
        
        
        $(document).ready(function(){
            $("#name").val("<%=name%>");
            $("#userId").val("<%=userId%>");
            $("#password").val("<%=password%>");
            $("#dob").val("<%=dob%>");
            $("#mobile").val("<%=mobile%>");
        });
        
        
        function detailsValidate(){
            var mobile = $("#mobile").val();
            var password = $("#password").val();
            
            var para = "";
            
            if(isNaN(mobile)){
                para = "<p style='border:0.5px solid #B80000;'>Invalid mobile number.</p>";
                $('#message').html(para).css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false; 
            }
            else if(mobile.length != 10){
                para = "<p style='border:0.5px solid #B80000;'>Mobile number must have ten digits.</p>";
                $('#message').html(para).css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;
            }
            else if(password.length < 4 || password.length > 13){
                para = "<p style='border:0.5px solid #B80000;'>Password length must be between 4 to 13.</p>";
                $('#message').html(para).css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;
            }
            
            return true;
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
        
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>