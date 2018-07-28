import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.io.*;
import java.text.*;

public class loadSummary extends HttpServlet 
{
    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        Connection con = null;
        Statement st = null;
        PrintWriter out = null;
        HttpSession session = null;
    
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wallet","root","0123");           
            st = con.createStatement();
            session = request.getSession();
            
            String userId = session.getAttribute("userId").toString();
            String summaryType = request.getParameter("summaryType");
            
            SimpleDateFormat fDate = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat fMonth = new SimpleDateFormat("MM/yyyy");
            SimpleDateFormat fYear = new SimpleDateFormat("yyyy");
            
            Date d = new Date();
            String date = fDate.format(d);
            String month = fMonth.format(d);
            String year = fYear.format(d);
            
            String query0 = "select * from transactions;";
            ResultSet rs0 = st.executeQuery(query0);
            
            int tSpent=0, tReceived=0, tAdded=0, tSent=0; 
            int mSpent=0, mReceived=0, mAdded=0, mSent=0; 
            int aSpent=0, aReceived=0, aAdded=0, aSent=0; 
            
            while(rs0.next())
            {
                String fromUser = rs0.getString("fromUser");
                String toUser = rs0.getString("toUser");
                Date dbD = rs0.getDate("dateTime");
                float amount = rs0.getFloat("amount");
                
                if((fromUser.substring(0,4)).equals("Bank"))
                    fromUser = "Bank";
                if((toUser.substring(0,4)).equals("Bank"))
                    toUser = "Bank";
                
                String dbDate = fDate.format(dbD);
                String dbMonth = fMonth.format(dbD);
                String dbYear = fYear.format(dbD);
                
                if(summaryType.equals("t"))
                {
                    if(fromUser.equals(userId) && !(toUser.equals("Bank")) && dbDate.equals(date))    // tSpent
                        tSpent += amount;
                    else if(!(fromUser.equals("Bank")) && toUser.equals(userId) && dbDate.equals(date))    // tReceived
                        tReceived += amount;
                    else if(fromUser.equals("Bank") && toUser.equals(userId) && dbDate.equals(date))    // tAdded
                        tAdded += amount;
                    else if(fromUser.equals(userId) && toUser.equals("Bank") && dbDate.equals(date))    // tSent
                        tSent += amount;
                }
                else if(summaryType.equals("m"))
                {
                    if(fromUser.equals(userId) && !(toUser.equals("Bank")) && dbMonth.equals(month))    // mSpent
                        mSpent += amount;
                    else if(!(fromUser.equals("Bank")) && toUser.equals(userId) && dbMonth.equals(month))    // mReceived
                        mReceived += amount;
                    else if(fromUser.equals("Bank") && toUser.equals(userId) && dbMonth.equals(month))    // mAdded
                        mAdded += amount;
                    else if(fromUser.equals(userId) && toUser.equals("Bank") && dbMonth.equals(month))    // mSent
                        mSent += amount;
                }
                else if(summaryType.equals("a"))
                {
                    if(fromUser.equals(userId) && !(toUser.equals("Bank")) && dbYear.equals(year))    // aSpent
                        aSpent += amount;
                    else if(!(fromUser.equals("Bank")) && toUser.equals(userId) && dbYear.equals(year))    // aReceived
                        aReceived += amount;
                    else if(fromUser.equals("Bank") && toUser.equals(userId) && dbYear.equals(year))    // aAdded
                        aAdded += amount;
                    else if(fromUser.equals(userId) && toUser.equals("Bank") && dbYear.equals(year))    // aSent
                        aSent += amount;
                }
            }
            
            
            out.println("<div>");
            out.println("<br/> <br/>");
            if(summaryType.equals("t"))
            {
                out.println("<br/><h3>Date : " + date + "</h3> <br/>");
                out.println("<center><h4>Total Spent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + tSpent + "</h4>");
                out.println("<h4>Total Received : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + tReceived + "</h4>");
                out.println("<h4>Total Added : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + tAdded + "</h4>");
                out.println("<h4>Total Sent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + tSent + "</h4></center>");
            }
            else if(summaryType.equals("m"))
            {
                out.println("<br/><h3>Month : " + month + "</h3> <br/>");
                out.println("<center><h4>Total Spent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + mSpent + "</h4>");
                out.println("<h4>Total Received : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + mReceived + "</h4>");
                out.println("<h4>Total Added : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + mAdded + "</h4>");
                out.println("<h4>Total Sent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + mSent + "</h4></center>");
            }
            else if(summaryType.equals("a"))
            {
                out.println("<br/><h3>Year : " + year + "</h3> <br/>");
                out.println("<center><h4>Total Spent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + aSpent + "</h4>");
                out.println("<h4>Total Received : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + aReceived + "</h4>");
                out.println("<h4>Total Added : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + aAdded + "</h4>");
                out.println("<h4>Total Sent : &nbsp; <span class='fa fa-rupee'></span> &nbsp; " + aSent + "</h4></center>");
            }
            out.println("</div>");
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}