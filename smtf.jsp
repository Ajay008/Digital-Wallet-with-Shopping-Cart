<html>
    <head>
        <title>Send money to a friend</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
    
        <style>
            #sendMoneyButton:hover
            {
                background-color:#ffd777 !important;
            }
            a:hover{
                cursor: pointer;
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
                   
                     
                    
                     
                     
                    <h3 style="text-decoration:none; font-size:2em;"> &#9679; Send Money to a friend</h3>
                    <br/>
                     
                     
                     
                    <div class="row" style="margin-top:50px;">
                        <div class="col-sm-3"></div>
                        <div class="col-sm-5">
                            
                            <h3 style="text-decoration:none; font-size:2em;"> <center> Your Balance : &nbsp; <span class="fa fa-rupee"></span> &nbsp; <span id="loadBalance"></span> </center></h3>
                            
                            <form action="smtf2" method="post" style="margin-top:50px;">
                                <div id="message" style="text-align:center;"></div> <br/>
                                <input type="text" id="friendUserId" name="friendUserId" placeholder="Enter your friends User Id" class="form-control" required> <br/>
                                <input type="number" id="amount" name="amount" placeholder="Enter amount you want to send" class="form-control" min="10" max="50000" required> <br/>
                                <textarea class="form-control" row="3" name="message" placeholder="Enter your message here (optional)"></textarea> <br/>
                                <center>
                                    <input type="submit" value="Send to friend" id="sendMoneyButton" class="btn" style="background-color:#68dff0;">
                                </center>
                            </form>
                            
                            <br/> <br/> 
                            <h6> <center> Note : To see who has requested money from you <a href="notification.jsp">Click here.</a> </center> </h6>
                            
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
           $("#transactionsA").trigger('click'); 
            $("#smtfA").addClass("active");
        });
        
        
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

        $(document).ready(function(){
           var friendUserId = '<%=request.getParameter("friendUserId")%>';
           var amount = '<%=request.getParameter("amount")%>';
           if(isNaN(amount))
           {
                amount="";
                friendUserId="";
           }
           $("#friendUserId").val(friendUserId); 
           $("#amount").val(amount); 
        });
        
        $(document).ready(function(){
            $("#loadBalance").load("loadBalance");
        });
        
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>
