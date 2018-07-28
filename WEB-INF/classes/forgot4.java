import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
//import java.util.Timestamp;
import java.io.*;

public class forgot4 extends HttpServlet{
    
    public void service(HttpServletRequest request,HttpServletResponse response){
        
        PrintWriter out = null;
        Connection con = null;
        Statement st = null;
        HttpSession session = null;
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            st = con.createStatement();
            
            session = request.getSession();
            
            String otpStr = request.getParameter("otp");
            int otp = Integer.parseInt(otpStr);
            String password = request.getParameter("password");
            if(session.getAttribute("fUserId") == null)
            {
                request.setAttribute("errorMessage","Session expired. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("forgot.jsp");
                rd.forward(request,response);
            }
            String fUserId = session.getAttribute("fUserId").toString();
            session.removeAttribute("fUserId");
            
            String query0 = "select otp, dateTime from otp where userId='"+fUserId+"';";
            ResultSet rs0 = st.executeQuery(query0);
            rs0.next();
            Timestamp otpDateTime = rs0.getTimestamp("dateTime");
            long t1 = otpDateTime.getTime() / 1000;
            Date currentDate = new Date();
            long t2 = currentDate.getTime() / 1000;
            long diff = t2 - t1;
            
            
            
            if((diff >= 0) && (diff <= 180) && (t1 != 0))   // If time not expired
            {
                String query1 = "select otp from otp where userId='"+fUserId+"';";
                ResultSet rs1 = st.executeQuery(query1);
                rs1.next();
                int dbOtp = rs1.getInt(1);
                
                if(dbOtp == otp)    // Correct otp
                {
                    String query2 = "update otp set otp=null where userId='"+fUserId+"';";
                    //String query2 = "update otp set dateTime=null, otp=null where userId='"+fUserId+"';";
                    st.executeUpdate(query2);
                    
                    String query3 = "update user set password = '"+password+"' where userId = '"+fUserId+"';";
                    int ans3 = st.executeUpdate(query3);
                    if(ans3 == 1)
                    {
                        request.setAttribute("message","Your password has been reset. You can login now.");
                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.forward(request,response);
                    }
                    else 
                    {
                        request.setAttribute("errorMessage","Server error. Plesae try after sometime.");
                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.forward(request,response);
                    }
                }
                else    // Incorrect opt
                {
                    request.setAttribute("errorMessage","Incorrect otp. Please try again.");
                    RequestDispatcher rd = request.getRequestDispatcher("forgot3.jsp");
                    rd.forward(request,response);
                }
            }
            else          // If time expired 
            {
                request.setAttribute("errorMessage","Time expired. Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("forgot.jsp");
                rd.forward(request,response);
            }
            
            
            st.close();
            con.close();
            
        }
        catch(Exception e){
            out.println(e);
            e.printStackTrace();
        }
    }
}