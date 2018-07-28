import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class profile2 extends HttpServlet 
{
    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        Connection con = null;
        Statement st = null;
        PrintWriter out = null;
        HttpSession session = null;
    
        try{
            response.setContentType("text/html");
            out = response.getWriter();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wallet","root","0123");           
            st = con.createStatement();
            session = request.getSession();
            
            String userId = session.getAttribute("userId").toString();
            
            String name = request.getParameter("name");
            String password = request.getParameter("password");
            String dob = request.getParameter("dob");
            long mobile = Long.parseLong(request.getParameter("mobile"));
            
            
            String query = "update user set name='"+name+"', password='"+password+"', dob='"+dob+"', mobile='"+mobile+"' where userId='"+userId+"';";
            int ans = st.executeUpdate(query);
            
            if(ans == 1){
                request.setAttribute("message","Changes were updated successfully.");
                RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
                rd.forward(request,response);
            }
            else{
                request.setAttribute("errorMessage","Changes were not updated, Please try after some time.");
                RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
                rd.forward(request,response);
            }
            
        
        }
        catch(Exception e){
            out.println(e);
        }
    }
}