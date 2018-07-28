<%@page import="java.util.*"%>
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
            a:hover{
                cursor:pointer;
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
                       Date date = new Date();
                       //SimpleDateFormat ft = new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
                       SimpleDateFormat ft1 = new SimpleDateFormat ("dd/MM/yyyy");
                       SimpleDateFormat ft2 = new SimpleDateFormat ("hh:mm:ss");
                       String ddMMyyyy = ft1.format(date);
                       String hhmmss = ft2.format(date);
                       //out.print(ddMMyyyy + "<br/>" + hhmmss);
                    %>
                        
                    <br/><br/>
                    <div class="row">
                        <h3 style="text-decoration:none; font-size:2em;"> <center> Your Balance : &nbsp; <span class="fa fa-rupee"></span> &nbsp; <span id="loadBalance"></span> </center></h3> <br/>
                        
                        <div class="col-sm-1"></div>
                        <div class="col-sm-10">
                            <ul class="nav nav-tabs" style="background-color:#68dff0; font-size:1.3em;">
                                <li class="active" id="All" onclick="loadContent(this.id)"><a>All</a></li>
                                <li id="Paid" onclick="loadContent(this.id)"><a>Paid</a></li>
                                <li id="Received" onclick="loadContent(this.id)"><a>Received</a></li>
                                <li id="Added" onclick="loadContent(this.id)"><a>Added</a></li>
                                <li id="Sent" onclick="loadContent(this.id)"><a>Sent to Bank</a></li>
                            </ul>    
                            <br/>
                            <div id="divContent"></div>
                            
                        </div>
                        <div class="col-sm-1"></div>
                    </div>
                    
                        
                        
                        
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        $("#passbookA").addClass("active");
        
        var previousCategory = "All";
        $(document).ready(function(){
            $("#divContent").load("passbookContent.jsp?category="+previousCategory);
        });
        function loadContent(category)
        {
            $("#"+previousCategory).removeClass("active");
            previousCategory = category;
            $("#"+category).addClass("active");
            
            $("#divContent").load("passbookContent.jsp?category="+category);
        }
        
        $(document).ready(function(){
            $("#loadBalance").load("loadBalance");
        });
        
        
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>