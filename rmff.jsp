<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<html>
    <head>
        <title>Request money from a friend</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
    
        <style>
            #requestMoneyButton:hover
            {
                background-color:#ffd777 !important;
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
                            <h4 style="text-decoration:none; font-size:2em;"> <center> Request Money from a friend </center> </h4>
                            <br/>
                            <form action="rmff2" method="post">
                                <div id="message" style="text-align:center;"></div> <br/>
                                <input type="text" name="friendUserId" placeholder="Enter your friends User Id" class="form-control" required> <br/>
                                <input type="number" name="amount" placeholder="Enter amount you want to request" class="form-control" min="10" max="50000" required> <br/>
                                <textarea class="form-control" row="3" name="message" placeholder="Enter your message here (optional)"></textarea> <br/> <br/>
                                <center>
                                    <input type="submit" value="Request from friend" id="requestMoneyButton" class="btn" style="background-color:#68dff0;">
                                </center>
                                
                                <br/> <br/>
                                
                            </form>
                        </div>
                        
                      
                        
                        <div class="col-sm-6" style="border-left:1px solid #999da3; padding-left:50px; padding-right:50px; min-height:350px;">
                        
                            <h4 style="text-decoration:none; font-size:2em;"> <center> Request History </center> </h4>
                            <br/>
                            
                            
                            
                     
                            <%
                                String userId = session.getAttribute("userId").toString();   
                                
                               
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                                Statement st = con.createStatement();
                                
                                String query = "select * from notification where fromId='"+userId+"';";
                                
                                SimpleDateFormat ft1 = new SimpleDateFormat ("dd/MM/yyyy");
                                SimpleDateFormat ft2 = new SimpleDateFormat ("hh:mm:ss");
                                
                                ResultSet rs = st.executeQuery(query);
                                int i=0;
                                
                               
                                // Requested to :  , Message : , Amount : , Date time
                                 
                                rs.last();
                                int rsLength = rs.getRow();
                                rs.afterLast();
                    
                            %>
                            
                            
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>sr.</th>
                                        <th>Requests</th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                                while(rs.previous())
                                {
                                    i++;
                                
                                    float amount = rs.getFloat("amount");     
                               
                                    String message = rs.getString("message");
                               
                                    Timestamp timestamp = rs.getTimestamp("dateTime");
                                    String ddMMyyyy = ft1.format(timestamp);
                                    String hhmmss = ft2.format(timestamp);
                                
                                    String toId = rs.getString("toId");    
                             %>
                                    <tr>
                                        <td><%=i%></td>
                                        <td>
                                            <div>
                                                <span><b>User Id : </b><%=toId%> </span> <br/>
                                                <span><b>Amount : </b></span> <span class="fa fa-rupee"></span> <%=amount%> <br/>
                                                <span><b>Message : </b><%=message%></span> <br/>
                                                <span style="float:right"> &nbsp; &nbsp; &nbsp;  <%=hhmmss%></span> 
                                                <span style="float:right"><%=ddMMyyyy%></span>
                                            </div>
                                        </td>
                                    </tr>
                                <%
                                   }
                                %>
                                
                                </tbody>
                            </table>
                            
                            <%
                                if(rsLength == 0)
                                    out.println("<br/> <br/> <br/><center>No Requets made yet.</center>");
                            %>
                            
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
            $("#rmffA").addClass("active");
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
            
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>