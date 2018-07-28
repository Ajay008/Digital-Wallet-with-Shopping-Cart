import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class nameInitials extends HttpServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response)
    {
        PrintWriter out = null;
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        try{
            out = response.getWriter();
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wallet","root","0123");
            st = con.createStatement();
            
            String userId = request.getParameter("userId");
            //out.print("\n\n Id : " + userId + "\n\n");
            
            String query = "select name from user where userId = '" + userId + "';";
            rs = st.executeQuery(query);
            rs.next();
            
            String name = rs.getString(1);
            name = name.toUpperCase();
            char nameInitial = name.charAt(0);
            
            out.println("&nbsp;" + nameInitial + "&nbsp;");
            
            rs.close();
            st.close();
            con.close();
        }
        catch(Exception e){
            out.println(e);
        }
    }
}