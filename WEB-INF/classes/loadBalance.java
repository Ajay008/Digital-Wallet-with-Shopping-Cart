import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class loadBalance extends HttpServlet 
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
            
            String query = "select amount from balance where userId='"+userId+"';";
            rs = st.executeQuery(query);
            rs.next();
            out.println(rs.getFloat("amount"));
            
            st.close();
            con.close();
            
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}