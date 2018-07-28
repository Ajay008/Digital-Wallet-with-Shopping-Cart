<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<html>
    <head>
        <title>Home</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
    
        <style>
            #load:hover
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
                    
                     <%
                        String userId = session.getAttribute("userId").toString();   
                        
                       
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                        Statement st = con.createStatement();
                       
                        String query0 = "select * from balance where userId='"+userId+"';";
                        ResultSet rs0 = st.executeQuery(query0);
                        rs0.next();
                        
                        float amount = rs0.getFloat("amount");
                        float maxLimit = rs0.getFloat("maxLimit");
                        
                        float amountPercent = amount/maxLimit * 100;
                        float remainingPercent = 100 - amountPercent;
                        
                        // Balance , Wallet limit
                        
                      %>
                     
                     
                     
                    <div class="row" style="margin-top:115px;">
                        
                        <div class="col-sm-6" style="border-right:0px solid #999da3; padding-left:60px; padding-right:60px;">
            
                            <div>
                                <center><canvas id="serverstatus01" height="150" width="150"></canvas></center>
						        <script>
						          	var doughnutData = [
						                {
						                	value: <%=amountPercent%>,
						                	color:"#68dff0"
						                },
						                {
						                	value : <%=remainingPercent%>,
						                	color : "#fdfdfd"
						                }
						             ];
						            var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData);
						         </script>
                                <span style="float:right;"><%=amountPercent%> % </span> 
	                       </div>
                            
                            <br/> <br/>
                            <center>
                            <h3>Your Balance : &nbsp; <span class="fa fa-rupee"></span> &nbsp; <%=amount%> </h3>
                            <h3>Wallet Limit : &nbsp; <span class="fa fa-rupee"></span> &nbsp; <%=maxLimit%> </h3>
                            </center>
                            
                                
                        </div>
                        
                        
                        
                        <div class="col-sm-6" style="border-left:1px solid #999da3; padding-left:50px; padding-right:50px; min-height:350px;">
                        
                            <h4 style="text-decoration:none; font-size:2em;"> <center> Wallet Summary </center> </h4>
                            <br/>          
                            
                            <div class="col-sm-8">
                                <select class="form-control" id="summaryType" name="summaryType">
                                    <option>Today's Summary</option>
                                    <option selected>Monthly Summary</option>
                                    <option>Annual Summary</option>
                                </select>
                            </div>
                            <div class="col-sm-4">
                                <input type="button" value="Load" id="load" onclick="loadSummary()" class="btn" style="background-color:#68dff0;">
                            </div>
                            
                            <div id="summaryContent"></div>
                            
                        </div>
                        
                        
                    </div>
        
                     
                     
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        $("#homeA").addClass("active");
        
        
        loadSummary();
        
        function loadSummary()
        {
            var summaryType = $("#summaryType").val();
            var type;
            
            if(summaryType == "Today's Summary")
                type = "t";
            if(summaryType == "Monthly Summary")
                type = "m";
            if(summaryType == "Annual Summary")
                type = "a";
            
            $("#summaryContent").load("loadSummary?summaryType="+type);
            
        }
        
        
        
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>