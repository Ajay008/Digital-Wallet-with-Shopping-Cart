import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class notificationBadge extends HttpServlet
{
	PrintWriter out;
	Connection con;
	Statement st;
	HttpSession session;
	public void service(HttpServletRequest request, HttpServletResponse response)
	{
		try
		{
			out = response.getWriter();
			session = request.getSession();
			
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
			st = con.createStatement();
			
			String Id = session.getAttribute("userId").toString();
			String query = "select count(*) from notification where toId='"+Id+"' and read1=0;";
			
			ResultSet rs = st.executeQuery(query);
			rs.next();
			
			int notificationCount = rs.getInt(1);
			out.println(notificationCount);
			
			st.close();
			con.close();
			
		}
		catch(Exception e)
		{
			out.println(e);
		}
	}
	
}