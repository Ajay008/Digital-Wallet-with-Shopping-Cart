
<%
 
   Object keyboard = session.getAttribute("keyboard");
   if(keyboard==null)
        keyboard=0;
   float keyboardPrice1 = Float.parseFloat(session.getAttribute("pricekeyBoard1").toString());
   float keyboardPrice = Integer.parseInt(keyboard.toString()) * keyboardPrice1;
   
   
   Object mouse = session.getAttribute("mouse");
   if(mouse==null)
        mouse=0;
   float mousePrice1 = Float.parseFloat(session.getAttribute("pricemouse1").toString());
   float mousePrice = Integer.parseInt(mouse.toString()) * mousePrice1;
  
   
   Object motherboard = session.getAttribute("motherboard");
   if(motherboard==null)
        motherboard=0;
   float motherboardPrice1 = Float.parseFloat(session.getAttribute("pricemotherBoard1").toString());
   float motherboardPrice = Integer.parseInt(motherboard.toString()) * motherboardPrice1;
     
   
   Object ram = session.getAttribute("ram");
   if(ram==null)
        ram=0;
   float ramPrice1 = Float.parseFloat(session.getAttribute("priceram1").toString());
   float ramPrice = Integer.parseInt(ram.toString()) * ramPrice1;
      
   
   Object soundCard = session.getAttribute("soundCard");
   if(soundCard==null)
        soundCard=0;
   float soundCardPrice1 = Float.parseFloat(session.getAttribute("pricesoundCard1").toString());
   float soundCardPrice = Integer.parseInt(soundCard.toString()) * soundCardPrice1;
   
   
   float totalPrice = keyboardPrice + mousePrice + motherboardPrice + ramPrice + soundCardPrice;
   session.setAttribute("totalPrice",totalPrice);
%>



<html>
    <head>
        <title>Cart</title>
        <jsp:include page="includeFiles/head.jsp"></jsp:include> 
    </head>
    
    
    <body>
        
        <jsp:include page="includeFiles/header.jsp"></jsp:include> 
        
        <table class="table table-hover table-bordered" style="width:65%;" align="center">
            <thead>
                <tr>
                    <th>Sr. no.</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Price (Rs)</th>
                    <th>Total Price</th>
                </tr>
            </thead>
            <tbody>
                
            <%
                int index=0;
                   
                if(keyboardPrice!=0)
                {
                    index++;
                    out.println("<tr> <td>" + index + "</td> <td>Keyboard</td> <td>" + keyboard + "</td> <td>"+ keyboardPrice1 +"</td> <td>" + keyboardPrice + "</td> </tr>");
                }
                
                if(mousePrice!=0)
                {
                    index++;
                    out.println("<tr> <td>" + index + "</td> <td>Mouse</td> <td>" + mouse + "</td> <td>" + mousePrice1 + "</td> <td>" + mousePrice + "</td> </tr>");
                }
                
                if(motherboardPrice!=0)
                {
                    index++;
                    out.println("<tr> <td>" + index + "</td> <td>Motherboard</td> <td>" + motherboard + "</td> <td> " + motherboardPrice1 + " </td> <td>" + motherboardPrice + "</td> </tr>");
                }    
            
                if(ramPrice!=0)
                {
                    index++;
                    out.println("<tr> <td>" + index + "</td> <td>RAM</td> <td>" + ram + "</td> <td>" + ramPrice1 + " </td> <td>" + ramPrice + "</td> </tr>");
                }
                
                if(soundCardPrice!=0)
                {
                    index++;
                    out.println("<tr> <td>" + index + "</td> <td>SoundCard</td> <td>" + soundCard + "</td> <td> " + soundCardPrice1 + " </td> <td>" + soundCardPrice + "</td> </tr>");
                }
            %>    
                    
                <tr>
                    <td colspan="4" align="center" style="font-weight:bold">Total Price</td>
                    <td><% out.println("&#8377; " + totalPrice); %></td>
                </tr>
            </tbody>
        </table>
        
        <br/>
        
        <center><button class="btn btn-success btn-lg" onclick="callCart2()">Proceed to Pay</button></center>

        
        
    </body>
    
    <script>
        $(document).ready(function(){
            $("#cart").addClass("active");       
        });
        
        function callCart2()
        {
            window.location.href = "cart2.jsp";
        }
    </script>>
    
</html>

