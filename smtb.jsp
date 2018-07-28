<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
    

<html>
    <head>
        <title>Send money to Bank</title>
        
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
            input[type='date']:before
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
                   
                     
                                
                     
                     
                       
                    <div class="row" style="margin-top:115px;">
                        
                        <div class="col-sm-6" style="border-right:0px solid #999da3; padding-left:60px; padding-right:60px;">
                            <h4 style="text-decoration:none; font-size:2em;"> <center> Send Money to Bank </center> </h4>
                            <br/>
                            <form action="smtb2" method="post" onsubmit="return sendMoneyValidate()">
                                <div id="message" style="text-align:center;"></div> <br/>
                                
                                
                                <%
                                    String userId = session.getAttribute("userId").toString();   
                                    
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                                    Statement st = con.createStatement();
                                 
                                    String query = "select cardNo from savedCards where userId='"+userId+"';";
                                    ResultSet rs = st.executeQuery(query);
                                %>
                                
                                <select class="form-control" id="cardNo0" name="cardNo0">
                                    <option selected>Select a Card</option>
                                    <%
                                        while(rs.next())
                                        {
                                            long cardNo = rs.getLong("cardNo");
                                            out.println("<option>"+cardNo+"</option>");
                                        }
                                    %>
                                </select>
                                <br/>
                                    
                                <input type="text" id="cvv0" name="cvv0" placeholder="Enter CVV : " class="form-control" maxlength="3" required> <br/>
                                <input type="number" id="amount0" name="amount0" placeholder="Enter amount to be sent to bank" class="form-control" min="10" max="50000" required> <br/>
                                <center>
                                    <input type="submit" value="Send money to Bank" id="sendMoneyButton" class="btn" style="background-color:#68dff0;">
                                </center>
                            </form>
                            <br/> <br/> <br/>
                        </div>

                        
                        
                        
                         <div class="col-sm-6" style="border-left:1px solid #999da3; padding-left:50px; padding-right:50px; min-height:350px;">
                             <h4 style="text-decoration:none; font-size:2em;"> <center> Add a new Card </center> </h4>
                             <br/>          
                             <form action="addCard?srcPage=smtb" method="post" onsubmit="return validateCard()">
                                <div id="message2" style="text-align:center;"></div> <br/>
                                <input type="text" name="cardNo" id="cardNo" placeholder="Enter card number (12 digits) : " class="form-control" required> <br/>
                                <input type="text" name="cvv" id="cvv" placeholder="Enter CVV (3 digits) : " class="form-control" maxlength="3" required> <br/>
                                <input type="date" name="expiryDate" id="expiryDate" placeholder="Expiry Date &nbsp; : &nbsp; " class="form-control" required> <br/>
                                <center>
                                    <input type="submit" value="Save Card" class="btn" style="background-color:#68dff0;">
                                </center>
                            </form>                                        
                                                                            
                        </div>
                    
                     </div>
                     
                     
                     
                     
    
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                     
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        $(document).ready(function(){
           $("#transactionsA").trigger('click'); 
            $("#smtbA").addClass("active");
        });
        
        
        function sendMoneyValidate()
        {
            var cardNo0 = $("#cardNo0").val()
            var cvv0 = $("#cvv0").val();
            var amount0 = $("#amount0").val();
            
            //console.log(cardNo0 + " " + cvv0 + " " + amount0);
            
            var para0 = "";
            
            if(cardNo0 == "Select a Card")
            {
                para0 = "<p style='border:0.5px solid #B80000;'>Please select a Card.</p>";
                $('#message').html(para0).css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;    
            }
            else if(isNaN(cvv0) || cvv0 > 999 || cvv0 < 1){
                para0 = "<p style='border:0.5px solid #B80000;'>Invalid CVV.</p>";
                $('#message').html(para0).css("visibility","visible");
                setTimeout("hideMessage()",5000);
                return false;
            }
            return true;
        }
        
        function validateCard()
        {
            var cardNo = $("#cardNo").val()
            var cvv = $("#cvv").val();
            var expiryDate = $("#expiryDate").val();
        
            var now = new Date();
             
            var para = "";
            
            if(isNaN(cardNo) || cardNo > 999999999999 || cardNo < 1){
                para = "<p style='border:0.5px solid #B80000;'>Invalid Card number.</p>";
                $('#message2').html(para).css("visibility","visible");
                setTimeout("hideMessage2()",5000);
                return false; 
            }
            else if(isNaN(cvv) || cvv > 999 || cvv < 1){
                para = "<p style='border:0.5px solid #B80000;'>Invalid CVV.</p>";
                $('#message2').html(para).css("visibility","visible");
                setTimeout("hideMessage2()",5000);
                return false;
            }
            else if(Date.parse(expiryDate) < Date.parse(now)){
                para = "<p style='border:0.5px solid #B80000;'>Invalid Date. (Card is expired) </p>";
                $('#message2').html(para).css("visibility","visible");
                setTimeout("hideMessage2()",5000);
                return false;
            }
            return true;
            
        }
        
        // message1
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
        
        
        // message2
        <%
            if(request.getAttribute("message2")!=null)
            {
                String message2 = request.getAttribute("message2").toString();
                String tempString2 = "<p style='border:0.5px solid #58D68D;'>"+message2+"</p>";
                out.println("$('#message2').html(\""+tempString2+"\");");
            }
            if(request.getAttribute("errorMessage2")!=null)
            {
                String errorMessage2 = request.getAttribute("errorMessage2").toString();
                String tempString2 = "<p style='border:0.5px solid #B80000;'>"+errorMessage2+"</p>";
                out.println("$('#message2').html(\""+tempString2+"\");");
            }
        %> 
        setTimeout("hideMessage2()",5000);
        function hideMessage2()
        {
            $('#message2').css("visibility","hidden");
        }
        
            
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>