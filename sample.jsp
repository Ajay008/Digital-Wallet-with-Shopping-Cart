<html>
    <head>
        <title>Home</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
    
    </head>
    
    
    <body class="container-fluid">

        <section id="container" >
            <jsp:include page="DashGum/header.jsp"></jsp:include>
            <jsp:include page="DashGum/sidebar.jsp"></jsp:include>

            
            <!--main content start-->
            <section id="main-content">
                 <section class="wrapper">
                    <%
                        String userId="";
                        if(session.getAttribute("userId") != null)
                        {    
                            userId = session.getAttribute("userId").toString();   
                            out.println("UserId : " + userId);
                        }
                        else
                        {
                            out.println("UserId : error");
                        }   
                    %>
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        $("#homeA").addClass("active");
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
    
</html>