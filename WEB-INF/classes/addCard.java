import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class addCard extends HttpServlet{
    
    public void service(HttpServletRequest request,HttpServletResponse response){
        
        PrintWriter out = null;
        Connection con = null;
        Statement st = null;
        HttpSession session = request.getSession();
        
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            st = con.createStatement();
            
            String userId = session.getAttribute("userId").toString();
            long cardNo = Long.parseLong(request.getParameter("cardNo"));
            int cvv = Integer.parseInt(request.getParameter("cvv"));
            String expiryDate = request.getParameter("expiryDate");
            
            String srcPage = request.getParameter("srcPage");
            srcPage = srcPage+".jsp";
            
            String query1 = "select cardNo from savedCards where userId='"+userId+"';";
            ResultSet rs1 = st.executeQuery(query1);
            
            int cardExists = 0;
            while(rs1.next())
            {
                if(rs1.getLong("cardNo") == cardNo)
                    cardExists = 1;
            }
            
            if(cardExists == 0)
            {
                String query2 = "insert into savedCards(userId, cardNo, cvv, expiryDate) values('"+userId+"',"+cardNo+","+cvv+",'"+expiryDate+"');";
                
                int ans2 = st.executeUpdate(query2);
                
                if(ans2 == 1)
                {
                    request.setAttribute("message2","Card added Successfully.");
                    RequestDispatcher rd = request.getRequestDispatcher(srcPage);
                    rd.forward(request,response);
                }
            }
            else
            {
                request.setAttribute("errorMessage2","Card already exists/added.");
                RequestDispatcher rd = request.getRequestDispatcher(srcPage);
                rd.forward(request,response);
            }
            
            
        }
        catch(Exception e)
        {
            out.println(e);
        }
             
    }  
    
}