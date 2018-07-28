<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
 

<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    
    <body>
        
        
        <%
            String userId = session.getAttribute("userId").toString();   
            String category = request.getParameter("category");
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            Statement st = con.createStatement();
            
            SimpleDateFormat ft1 = new SimpleDateFormat ("dd/MM/yyyy");
            SimpleDateFormat ft2 = new SimpleDateFormat ("hh:mm:ss");
           
            String query1 = "";
           
            if(category.equals("All"))
                query1 = "select * from transactions where fromUser='"+userId+"' or toUser='"+userId+"' order by dateTime desc;";
            else if(category.equals("Paid"))
                query1 = "select * from transactions where fromUser='"+userId+"' and toUser not like 'Bank%' order by dateTime desc;";
            else if(category.equals("Received"))
                query1 = "select * from transactions where toUser='"+userId+"' and fromUser not like 'Bank%' order by dateTime desc;";
            else if(category.equals("Added"))
                query1 = "select * from transactions where fromUser like 'Bank%' and toUser='"+userId+"' order by dateTime desc;";
            else if(category.equals("Sent"))
                query1 = "select * from transactions where fromUser='"+userId+"' and toUser like 'Bank%' order by dateTime desc;";
           
           
           
            ResultSet rs1 = st.executeQuery(query1);            
        %>
        
        
        
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-10">
                <table class="table table-hover ">
                    <thead>
                      <tr>
                        <th>Transaction Details</th>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                      </tr>
                    </thead>
                    <tbody>
                        
                        <%
                            rs1.last();
                            int rowLength = rs1.getRow();
                            rs1.beforeFirst();
                            
                            while(rs1.next())
                            {
                                int txnId = rs1.getInt("txnId");
                                String txnId2 = "txn"+txnId;
                                
                                String fromUser2 = rs1.getString("fromUser");
                                String toUser2 = rs1.getString("toUser");
                                String sign2 = "";
                                if(fromUser2.equals(userId))
                                    sign2="-";
                                else if(toUser2.equals(userId))
                                    sign2="+";
                           
                                Timestamp dateTime  = rs1.getTimestamp("dateTime");
                                String date2 = ft1.format(dateTime); 
                                String time2 = ft2.format(dateTime); 
                           
                                float amount = rs1.getFloat("amount");
                                String amount2 = sign2 + " " + amount;
                           
                                String status2 = rs1.getString("status");
                        %>
                        
                            <tr>
                              <td>Txn ID : &nbsp; <%=txnId2%> <br/>From &nbsp; : &nbsp; <%=fromUser2%> <br/> To &nbsp; &nbsp; &nbsp; &nbsp; : &nbsp; <%=toUser2%></td>
                              <td><%=date2%> <br/><%=time2%></td>
                              <td><%=amount2%></td>
                              <td><%=status2%></td>
                            </tr>
                      
                        <%
                            }
                        %>
                            
                            
                    </tbody>
                </table>
                                  
                <%
                    if(rowLength == 0)
                        out.println("<br/> <br/> <br/><center>No transactions to display</center>");
                %>                  
                
            </div>
            <div class="col-sm-1"></div>
        </div>
        
    </body>
</html>