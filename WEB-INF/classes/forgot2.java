import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.io.*;
import java.text.*;

import java.util.Random;

import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*; 



public class forgot2 extends HttpServlet{
    
    static PrintWriter out = null;
    static Connection con = null;
    static Statement st = null;
    static ResultSet rs;
    static RequestDispatcher rd;
    static HttpSession session = null;
    
    public void service(HttpServletRequest request,HttpServletResponse response){
        
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            session = request.getSession();
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            st = con.createStatement();
            
            String userId = request.getParameter("userId");
            String dob = request.getParameter("dob");
            
            String query = "select dob from user where userId = '"+userId+"' "; 
            
            rs = st.executeQuery(query);
            rs.next();
            
            int rowNumber = rs.getRow();            
            Date dbDob = null; 
            
            if(rowNumber==0)    // Incorrect UserId
            {
                request.setAttribute("errorMessage","Incorret UserId or DOB. Please try again.");
                rd = request.getRequestDispatcher("forgot.jsp");
                rd.forward(request,response);
            }
            else if(rowNumber==1)    // Correct UserId
            {
                dbDob = rs.getDate("dob");
                if(dbDob.toString().trim().equals(dob))    // Correct DOB
                {
                    Random ran = new Random();
                    int num = ran.nextInt(999999);
                    
                    
                    String query2 = "select userId from otp;";
                    ResultSet rs = st.executeQuery(query2);
                    int userIdExists = 0;
                    while(rs.next())
                    {
                        if(rs.getString(1).equals(userId))
                            userIdExists = 1;
                    }
                    
                    Timestamp sdateTime = new Timestamp((new Date()).getTime());
		            /*
                    Date sdateTime = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		            String sdateTime = sdf.format(dateTime);
                    */
                    String query3="";
                    if(userIdExists == 1)
                        query3 = "update otp set otp='"+num+"' , dateTime='"+sdateTime+"' where userId='"+userId+"';";
                    else
                        query3 = "insert into otp(userId,otp,dateTime) values('"+userId+"','"+num+"','"+sdateTime+"');";
                    
                    st.executeUpdate(query3);
                    
                    forgot2.send("ajay008chaudhary@gmail.com", "Aj@y018149", userId, "Digital Wallet : OTP for new password.", "<h3>Dear user "+userId+" , </h3> <h4> your One Time Password is "+num + " </h4> <h5>Note: This OTP is only valid for 3 minutes. </h5> <br/>", request, response);  
                    
                } 
                else         // Incorrect DOB
                {
                    request.setAttribute("errorMessage","Incorret UserId or DOB. Please try again.");
                    rd = request.getRequestDispatcher("forgot.jsp");
                    rd.forward(request,response);
                }
            }
            else
            {
                request.setAttribute("errorMessage","Server Error");
                rd = request.getRequestDispatcher("forgot.jsp");
                rd.forward(request,response);
            }
            
            
            //out.println("DOB2 : <br/>" + dbDob.toString().trim().equals(dob));
            //out.println("DOB2 : <br/>d" + dbDob.toString().trim() + "a<br/>c" + dob + "b");
            
            rs.close();
            st.close();
            con.close();
            
        }
        catch(Exception e){
            out.println(e);
            e.printStackTrace();
        }
    }
    
    
    
    
    public static void send(String from,String password,String to,String sub,String msg, HttpServletRequest request,HttpServletResponse response)
    {  
        try 
        {   
            //Get properties object    
            Properties props = new Properties();    
            props.put("mail.smtp.host", "smtp.gmail.com");    
            props.put("mail.smtp.socketFactory.port", "465");    
            props.put("mail.smtp.socketFactory.class",    
                      "javax.net.ssl.SSLSocketFactory");    
            props.put("mail.smtp.auth", "true");    
            props.put("mail.smtp.port", "465");    
            //get Session   
            Session session = Session.getDefaultInstance(props,    
             new javax.mail.Authenticator() {    
             protected PasswordAuthentication getPasswordAuthentication() {    
             return new PasswordAuthentication(from,password);  
             }    
            });    
            //compose message    
             
             MimeMessage message = new MimeMessage(session);    
             message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));    
                InternetAddress froms = new InternetAddress(from,"Digital Wallet");
				message.setFrom(froms);
				message.setContent(msg,"text/html"); 
             //message.setText(msg);    
             message.setSubject(sub);    
            
            
             //send message  
             Transport.send(message);    
             System.out.println("message sent successfully");    
            
        } 
        catch (Exception e) 
        {
            out.println(e);
            out.println("<br/> Server Error.");
            out.println("<br/> Plase try after some time.");
            
            try{
            request.setAttribute("errorMessage","Server Error. Please try after some time.");
            rd = request.getRequestDispatcher("forgot.jsp");
            rd.forward(request,response);
            }
            catch(Exception e2) {out.println(e2);}
        }   
        
        try
        {
            session.setAttribute("fUserId",request.getParameter("userId"));   
            response.sendRedirect("forgot3.jsp");
            
            /*
            request.setAttribute("fuserId",to);
            rd = request.getRequestDispatcher("forgot3.jsp");
            rd.forward(request,response);
            */
        }
        catch(Exception e)
        {
            out.println(e);
        }
             
    }  
    
}