import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class logIn2 extends HttpServlet{
    
    public void service(HttpServletRequest request,HttpServletResponse response){
        
        PrintWriter out = null;
        Connection con = null;
        Statement st = null;
        HttpSession session = request.getSession();
        ResultSet rs;
        
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            st = con.createStatement();
            
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            
            String query = "select password from user where userId = '"+userId+"' "; 
            
            rs = st.executeQuery(query);
            rs.next();
            
            int rowNumber = rs.getRow();            
            String dbPassword=""; 
            
            if(rowNumber!=0)
                dbPassword= rs.getString("password");
            
            rs.close();
            st.close();
            con.close();
            
            
            if(rowNumber!=0 && dbPassword.equals(password))
            {
                session.setAttribute("userId",userId);
                response.sendRedirect("home.jsp");
            }
            else
            {
                request.setAttribute("errorMessage","Incorret UserId or password. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request,response);
                //response.sendRedirect("index.jsp");
            }
            
     
        }
        catch(Exception e){
            out.println(e);
        }
    }
}