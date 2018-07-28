import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class commonFilter1 implements Filter
{
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    {
        response.setContentType("text/html");
        PrintWriter out = null;
        HttpSession session = null;
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        try{
            out = res.getWriter();
            session = req.getSession();
            
            if(session.getAttribute("userId") == null)
            {
                res.sendRedirect("index.jsp");
            }
            else
            {
                chain.doFilter(req,res);
            }
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}