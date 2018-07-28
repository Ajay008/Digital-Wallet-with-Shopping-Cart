import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class rmff2 extends HttpServlet 
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
            
            String query = "select userId from user where userId='"+friendUserId+"';";
            rs = st.executeQuery(query);
            rs.next();
            int rowNumber = rs.getRow();
            //out.println("userId:"+userId+":"+rowNumber+":"+friendUserId);
            if(rowNumber == 0 || userId.equals(rs.getString("userId")))
            {
                request.setAttribute("errorMessage","Invalid user. Please try again with a valid userId.");
                RequestDispatcher rd = request.getRequestDispatcher("rmff.jsp");
                rd.forward(request,response); 
            }
            else
            {
                String query2 = "select name from user where userId = '"+userId+"';";
                rs = st.executeQuery(query2);
                rs.next();
                String fromName = rs.getString("name");
                String query3 = "insert into notification(fromId,toId,fromName,amount,message) values('"+userId+"','"+friendUserId+"','"+fromName+"',"+amount+",'"+message+"');";
                int ans = st.executeUpdate(query3);
                if(ans == 1)
                {
                    request.setAttribute("message","Your request has been sent successfully.");
                    RequestDispatcher rd = request.getRequestDispatcher("rmff.jsp");
                    rd.forward(request,response);
                }
                else
                {
                    request.setAttribute("errorMessage","Server Error.");
                    RequestDispatcher rd = request.getRequestDispatcher("rmff.jsp");
                    rd.forward(request,response); 
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