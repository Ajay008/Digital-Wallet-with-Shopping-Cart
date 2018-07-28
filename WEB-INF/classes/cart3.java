import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.io.*;

public class cart3 extends HttpServlet 
{
    public void service(HttpServletRequest request, HttpServletResponse response)
    {
        Connection con = null;
        Statement st = null;
        PrintWriter out = null;
        HttpSession session = null;
    
        try{
            out = response.getWriter();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wallet","root","0123");           
            st = con.createStatement();
            session = request.getSession();
            
            String userId = session.getAttribute("userId").toString();
            float amount = Float.parseFloat(session.getAttribute("totalPrice").toString());
            
            String query = "select amount from balance where userId='"+userId+"';";
            ResultSet rs = st.executeQuery(query);
            rs.next();
            float dbAmount = rs.getFloat("amount");
            
            if(amount > dbAmount)   // Insufficient balance
            {
                request.setAttribute("errorMessage","Insufficient balance in your wallet.");
                RequestDispatcher rd = request.getRequestDispatcher("OnlineShopping/cart2.jsp");
                rd.forward(request,response); 
            }
            else   
            {
                
                String query3 = "update balance set amount=amount-'"+amount+"' where userID='"+userId+"';";
                int ans3 = st.executeUpdate(query3);
                    
                if(ans3 == 1)  // successfully withdrawn, proceed to transaction
                {
                    String query5 = "insert into transactions(fromUser,toUser,amount,status) values('"+userId+"','Online Shopping','"+amount+"','success');";
                    st.executeUpdate(query5);
                    
                    /*
                    Enumeration sessionNames = session.getAttributeNames();
                    while(sessionNames.hasMoreElements())
                    {
                        String name = (String) sessionNames.nextElement();
                        out.println(name);
                        if(!(name.equals("userId")))
                            session.removeAttribute(name);
                    }
                    */
                    
                    request.setAttribute("message","Transaction Successfull.");
                    RequestDispatcher rd = request.getRequestDispatcher("OnlineShopping/cart2.jsp");
                    rd.forward(request,response);
                }
                            
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