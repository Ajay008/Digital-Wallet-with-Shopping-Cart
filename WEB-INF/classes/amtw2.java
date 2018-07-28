import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class amtw2 extends HttpServlet 
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
            long cardNo = Long.parseLong(request.getParameter("cardNo0"));
            int cvv = Integer.parseInt(request.getParameter("cvv0"));
            float amount = Float.parseFloat(request.getParameter("amount0"));
            
            String query0 = "select cvv from savedCards where cardNo = '"+cardNo+"';";
            ResultSet rs0 = st.executeQuery(query0);
            rs0.next();
            if(rs0.getInt("cvv") == cvv)
            {
            
                String query2 = "select amount, maxLimit from balance where userId='"+session.getAttribute("userId")+"';";
                ResultSet rs2 = st.executeQuery(query2);
                rs2.next();
                
                float limit = (float) rs2.getFloat("maxLimit");        
                float dbAmount = (float) rs2.getFloat("amount"); 
                float newAmount = amount + dbAmount;
                
                if(newAmount > limit)
                {
                    request.setAttribute("errorMessage","You exceeded the max limit(Max limit is Rs "+limit+"). Please upgrade your wallet account to add more amount.");
                    RequestDispatcher rd = request.getRequestDispatcher("amtw.jsp");
                    rd.forward(request,response);
                }
                else
                {
                    String query3 = "update balance set amount = "+newAmount+" where userId='"+userId+"';";
                    //out.println("amount = " + amount + "<br>" + query3);
                    int ans3 = st.executeUpdate(query3);
                    
                    if(ans3 == 1)
                    {
                        String query4 = "insert into transactions(fromUser,toUser,amount,status) values('Bank card no - "+cardNo+"','"+userId+"','"+amount+"','success');";
                        st.executeUpdate(query4);
                    
                        request.setAttribute("message","Amount added Successfully to wallet. New Balance is <span class='fa fa-rupee'></span> " + newAmount);
                        RequestDispatcher rd = request.getRequestDispatcher("amtw.jsp");
                        rd.forward(request,response);
                    }
                    else 
                    {
                        //out.println("hihih");
                        request.setAttribute("errorMessage","Amount was not added. Please try again.");
                        RequestDispatcher rd = request.getRequestDispatcher("amtw.jsp");
                        rd.forward(request,response);
                    }
                }
            }
            else 
            {
                request.setAttribute("errorMessage","Incorrect CVV, Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("amtw.jsp");
                rd.forward(request,response);
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