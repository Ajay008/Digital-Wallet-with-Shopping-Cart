import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class notificationReadUpdate extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        PrintWriter out = null;
        
        try
        {
            out = response.getWriter();
            response.setContentType("text/html");
            
            int srNo = Integer.parseInt(request.getParameter("srNo"));
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            Statement st = con.createStatement();
            
            String query = "update notification set read1=1 where sr="+srNo+";";     
            st.executeUpdate(query);            
            
            st.close();
            con.close();
            
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }

}