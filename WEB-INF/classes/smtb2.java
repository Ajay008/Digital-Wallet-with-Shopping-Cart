import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;

public class smtb2 extends HttpServlet 
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
            long cardNo = Long.parseLong(request.getParameter("cardNo0"));
            int cvv = Integer.parseInt(request.getParameter("cvv0"));
            float amount = Float.parseFloat(request.getParameter("amount0"));
            
            
            String query0 = "select cvv from savedCards where cardNo = '"+cardNo+"';";
            ResultSet rs0 = st.executeQuery(query0);
            rs0.next();
            if(rs0.getInt("cvv") == cvv)
            {
            
                String query1 = "select amount from balance where userId='"+session.getAttribute("userId")+"';";
                ResultSet rs1 = st.executeQuery(query1);
                rs1.next();
                float dbAmount = (float) rs1.getFloat("amount"); 
                
                float newAmount = dbAmount - amount;
                //out.println(amount + "<br/>db = " + dbAmount + "<br/>" + newAmount);
                if(newAmount < 0)
                {   
                    request.setAttribute("errorMessage","You do not have sufficient amount to transfer to bank. Your balance is Rs " + dbAmount);
                    //out.println(request.getAttribute("errorMessage"));
                    RequestDispatcher rd = request.getRequestDispatcher("smtb.jsp");
                    rd.forward(request,response);
                }
                else
                {
                    String query2 = "update balance set amount = "+newAmount+" where userId='"+userId+"';";
                    //out.println("amount = " + amount + "<br>" + query2);
                    int ans2 = st.executeUpdate(query2);
                
                    if(ans2 == 1)
                    {
                        String query3 = "insert into transactions(fromUser,toUser,amount,status) values('"+userId+"','Bank card no - "+cardNo+"','"+amount+"','success');";
                        st.executeUpdate(query3);
                    
                        request.setAttribute("message","Amount transter to bank was successfull. New balance is Rs " + newAmount);
                        RequestDispatcher rd = request.getRequestDispatcher("smtb.jsp");
                        rd.forward(request,response);
                        
                    }
                    else 
                    {
                        request.setAttribute("errorMessage","Amount was not transfered to bank. Please try again.");
                        RequestDispatcher rd = request.getRequestDispatcher("smtb.jsp");
                        rd.forward(request,response);
                    }
                }
            }
            else
            {
                request.setAttribute("errorMessage","Incorrect CVV, Please try again.");
                RequestDispatcher rd = request.getRequestDispatcher("smtb.jsp");
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