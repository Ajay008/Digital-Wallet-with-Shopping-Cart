import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*; 


import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class signUp2 extends HttpServlet{
    
    static PrintWriter out = null;
    static Connection con = null;
    static Statement st = null;
    //ResultSet rs;
    
    public void service(HttpServletRequest request,HttpServletResponse response){
        
        try{
            out = response.getWriter();
            response.setContentType("text/html");
            
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Wallet","root","0123");
            st = con.createStatement();
            
            String name = request.getParameter("name");
            String dob = request.getParameter("dob");
            String userId = request.getParameter("userId");
                userId = userId.trim();
            String password = request.getParameter("password");
            String userIdType = request.getParameter("userIdType");
            
            //out.println("date : " + date);
            
            String query0 = "select userId from user;";
            ResultSet rs0 = st.executeQuery(query0);
            int userIdExists = 0;
            while(rs0.next())
            {
                if(rs0.getString(1).equals(userId))
                    userIdExists = 1;
            }
            
            if(userIdExists == 1)
            {
                request.setAttribute("errorMessage","UserId already exists, try with different userId.");
                RequestDispatcher rd = request.getRequestDispatcher("signUp.jsp");
                rd.forward(request,response);
            }
            else
            {
                String query1 = "insert into user(userId,dob,name,password,"+userIdType+") values('"+userId+"','"+dob+"','"+name+"','"+password+"','"+userId+"');";
                int ans1 = st.executeUpdate(query1);
                
                String query2 = "insert into balance(userId) values('"+userId+"');";
                int ans2 = st.executeUpdate(query2);
                
                if(ans1==1 && ans2==1)
                {
                    signUp2.send("ajay008chaudhary@gmail.com","Aj@y018149",userId,"Digital Wallet","<br/><h1> Welcome to Digital Wallet and Shopping cart.</h1> <br/>  <b>Your userId : </b> "+userId+".",request, response);  
                }
                else
                {
                    request.setAttribute("errorMessage","Server error, Please try after some time.");
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                    rd.forward(request,response);
                }
            
            }
            
            //rs.close();
            st.close();
            con.close();
            
        }
        catch(Exception e){
            out.println(e);
        }
    }
    
    
    
    
    
    
    
    
    public static void send(String from,String password,String to,String sub,String msg,HttpServletRequest request,HttpServletResponse response)
    {  
        try {  
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
            InternetAddress froms = new InternetAddress(from,"Digital Wallet");
         MimeMessage message = new MimeMessage(session);    
         message.addRecipient(Message.RecipientType.TO,new InternetAddress(to)); 
            message.setFrom(froms);
         message.setSubject(sub);    
            message.setContent(msg,"text/html");    
         //message.setText(msg);  
         //send message  
         Transport.send(message);    
         System.out.println("message sent successfully");    
            
        } 
        catch (Exception e) 
        {
            out.println("ex e = "+e);
            //throw new RuntimeException(e);
            try
            {
                request.setAttribute("message","UserId added successfully, you can login Now.");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request,response);       
            }
            catch(Exception ex)
            {
                out.println("ex = "+ex);
            }
        }    
        
        try
        {
            request.setAttribute("message","UserId added successfully, you can login Now.");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request,response);       
        }
        catch(Exception e)
        {
            out.println("e = "+e);
        }
        
    }  
    
}







