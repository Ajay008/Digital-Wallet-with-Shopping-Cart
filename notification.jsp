<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<html>
    <head>
        <title>Notifications</title>
        
        <script src="Plugins/jquery-3.1.0.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css"  href="Plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css">
        <script src="Plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"> </script>
        
        
        <jsp:include page="DashGum/head.jsp"></jsp:include>
        
        <style>
            .divOne,.divTwo{
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
                    <%
                        String userId = session.getAttribute("userId").toString();   
                        
                       
                       Class.forName("com.mysql.jdbc.Driver");
                       Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                       Statement st = con.createStatement();
                       
                       String query = "select * from notification where toId='"+userId+"';";
                       
                       SimpleDateFormat ft1 = new SimpleDateFormat ("dd/MM/yyyy");
                       SimpleDateFormat ft2 = new SimpleDateFormat ("hh:mm:ss");
                       
                       ResultSet rs = st.executeQuery(query);
                       int sr=0;
                       
                       
                       rs.last();
                       int rsLength = rs.getRow();
                       rs.afterLast();
                       
                       int srArray[] = new int[rsLength];
                       
                    %>
                    
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>sr.</th>
                                        <th>Notifications</th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                                while(rs.previous())
                                {
                                    sr++;
                                
                                    float amount = rs.getFloat("amount");     
                               
                                    String message = rs.getString("message");
                               
                                    Timestamp timestamp = rs.getTimestamp("dateTime");
                                    String ddMMyyyy = ft1.format(timestamp);
                                    String hhmmss = ft2.format(timestamp);
                                    //int hhmmss = date.getHours();
                                    
                                    String friendUserId = rs.getString("fromId");
                                    
                                    String fromName = rs.getString("fromName");
                                    
                                    int i = rs.getInt("sr");
                                    srArray[sr-1] = i;
                                    
                                    int read1 = rs.getInt("read1");
                                    String color="";
                                    if(read1==0)
                                        color="white";
                                    else
                                        color="transparent";
                            %>
                                  <tr style="background-color:<%=color%>" id="row<%=i%>">
                                        <td><%=sr%></td>
                                        <td>
                                            <div class="divOne" id="divOne<%=i%>">
                                                <%=fromName%> has Requested <span class="fa fa-rupee"></span> <%=amount%> .
                                                    
                                                <span id="glyphicon<%=i%>" onclick="slide(<%=i%>)" class="glyphicon glyphicon-chevron-down" style="float:right;"></span> 
                                            
                                                <a href="notification2?op=delete&i=<%=i%>"><span class="glyphicon glyphicon-trash" data-toggle="tooltip" title="Delete" style="float:right;">&nbsp;</span></a>
                                                
                                                <a href="notification2?op=send&friendUserId=<%=friendUserId%>&amount=<%=amount%>"><span class="li_banknote" data-toggle="tooltip" title="Send Money" style="float:right;">&nbsp; &nbsp; &nbsp;</span></a>
                                            </div>
    
                                            <div class="divTwo" id="divTwo<%=i%>" style="display:none;">
                                                <hr/>
                                                <b>User Id &nbsp; &nbsp;: </b> <%=friendUserId%> <br/>
                                                <b>Message : </b> <%=message%> <br/>
                                                <span style="float:right;"><%=ddMMyyyy%> &nbsp; &nbsp; &nbsp; &nbsp; <%=hhmmss%> </span>
                                            </div>        
                                        </td>
                                    </tr>
                            <%
                                }
                               
                                                
                                                
                                rs.close();
                                st.close();
                                con.close();
                               
                            %>
                                </tbody>
                            </table>
                                                
                            <%
                                if(rsLength == 0)
                                    out.println("<br/> <br/> <br/><center>No notifications to display</center>");
                            %>
                                
                        </div>
                        <div class="col-sm-2"></div>
                    </div>
                        
                        
                    
                </section>
            
            </section>
            <!--main content end-->
        </section>
    </body>
    
    <script>
        
        $("#notificationA").addClass("active");
        
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip(); 
        });
        
        function slide(id)
        {
            $("#divTwo"+id).slideToggle();
            var glyphicon = document.getElementById("glyphicon"+id).className;
            if(glyphicon.includes("up"))
            {
                $("#glyphicon"+id).removeClass("glyphicon-chevron-up");
                $("#glyphicon"+id).addClass("glyphicon-chevron-down");
            }
            if(glyphicon.includes("down"))
            {
                $("#glyphicon"+id).removeClass("glyphicon-chevron-down");
                $("#glyphicon"+id).addClass("glyphicon-chevron-up");
            }
            
            var backgroundColor = $("#row"+id).css("background-color");
            if(backgroundColor != "rgba(0, 0, 0, 0)")
            {
                $("#glyphicon"+id).load("notificationReadUpdate?srNo="+id);
                $("#row"+id).css("background-color","transparent");
                var notificationCount = $("#notificationBadge").html();
                notificationCount -= 1;
                $("#notificationBadge").html(notificationCount);
            }
            
        }
        
    </script>>
        
    <jsp:include page="DashGum/bodyScript.jsp"></jsp:include>
                                                    
</html>
    