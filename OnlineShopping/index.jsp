<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>


<html>
    <head>
        <title>Online Shopping</title>
        <jsp:include page="includeFiles/head.jsp"></jsp:include>   
    </head>
    
    <body>
        
        
        <jsp:include page="includeFiles/header.jsp"></jsp:include>   
        
        <ul>
            <li><a href="keyboard.jsp">KeyBoard</a></li>
            <li><a href="mouse.jsp">Mouse</a></li>
            <li><a href="motherboard.jsp">Motherboard</a></li>
            <li><a href="ram.jsp">RAM</a></li>
            <li><a href="soundCard.jsp">Sound Card</a></li>
            
            
            <%
                //String userId = session.getAttribute("userId").toString(); 
                //out.println(userId);
               
                if(session.getAttribute("onlineShopping") == null)
                {
                    session.setAttribute("onlineShopping","onlineShopping");
               
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
                    Statement st = con.createStatement();
                           
                    
                    String query = "select * from productlist;";
                    ResultSet rs = st.executeQuery(query);
                    
                    while(rs.next())
                    {
                        String id = rs.getString("id");
                        int available = rs.getInt("available");
                        //int sold = rs.getInt("sold");
                        float price = rs.getFloat("price");
                        
                        session.setAttribute("available"+id,available);
                        //session.setAttribute("sold"+id,sold);
                        session.setAttribute("price"+id,price);
                        //session.setAttribute("added"+id,0);
                    }
                
                    st.close();
                    con.close();
                 }
            %>
            
            
            
        </ul>
    </body>
    
    <script>
        $(document).ready(function(){
            $("#home").addClass("active");       
        });
    </script>
        
</html>