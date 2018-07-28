import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class smtf2 extends HttpServlet 
{
    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        Connection con = null;
        Statement st = null;
        PrintWriter out = null;
        ResultSet rs = null;
        HttpSession session = null;
    
        try{
            out = response.getWriter();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wallet","root","0123");           
            st = con.createStatement();
            session = request.getSession();
            
            String userId = session.getAttribute("userId").toString();
            String friendUserId = request.getParameter("friendUserId");
            String message = request.getParameter("message");
            float amount = Float.parseFloat(request.getParameter("amount"));
            
            String query = "select amount from balance where userId='"+userId+"';";
            rs = st.executeQuery(query);
            rs.next();
            float dbAmount = rs.getFloat("amount");
            
            if(amount > dbAmount)   // Insufficient balance
            {
                request.setAttribute("errorMessage","Insufficient balance in your wallet.");
                RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                rd.forward(request,response); 
            }
            else   
            {
                String query2 = "select userId from user where userId='"+friendUserId+"';";
                rs = st.executeQuery(query2);
                rs.next();
                int rowNumber = rs.getRow();
                if(rowNumber == 0 || userId.equals(rs.getString("userId"))) // Invalid user     
                {
                    request.setAttribute("errorMessage","Invalid user. Please try again with a valid userId.");
                    RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                    rd.forward(request,response); 
                }
                else       
                {
                    String query3 = "update balance set amount=amount-'"+amount+"' where userID='"+userId+"';";
                    String query4 = "update balance set amount=amount+'"+amount+"' where userId='"+friendUserId+"';";
                    
                    int ans3 = st.executeUpdate(query3);
                    
                    if(ans3 == 1)  // successfully withdrawn, proceed to transfer
                    {
                        int ans4 = st.executeUpdate(query4);
                        if(ans4 == 1)
                        {
                            String query5 = "insert into transactions(fromUser,toUser,amount,status) values('"+userId+"','"+friendUserId+"','"+amount+"','success');";
                            st.executeUpdate(query5);
                        
                            request.setAttribute("message","Amount sent to friend successfully.");
                            RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                            rd.forward(request,response);
                        }
                        else  // unsuccessfull transfer
                        {
                            request.setAttribute("errorMessage","Server error");
                            RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                            rd.forward(request,response); 
                        }
                    }
                    else  // unsuccessfull withdrawl
                    {
                        request.setAttribute("errorMessage","Server error");
                        RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                        rd.forward(request,response); 
                    }   
                }
            }
            
            st.close();
            con.close();
            
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}