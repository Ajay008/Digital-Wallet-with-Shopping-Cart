import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class notification2 extends HttpServlet 
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
            
            String operation = request.getParameter("op");
            
            if(operation.equals("delete"))
            {
                int sr = Integer.parseInt(request.getParameter("i"));
                String query = "delete from notification where sr = '"+sr+"';";
                st.executeUpdate(query);
                response.sendRedirect("notification.jsp");
            }
            else if(operation.equals("send"))
            {
                String userId = request.getParameter("friendUserId");
                float amount = Float.parseFloat(request.getParameter("amount").toString());
                //out.println(userId + "<br/>" + amount);
                
                RequestDispatcher rd = request.getRequestDispatcher("smtf.jsp");
                rd.forward(request,response);
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