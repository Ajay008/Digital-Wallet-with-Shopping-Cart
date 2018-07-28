 <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
                    
                  <!--
              	  <p class="centered"><img src="assets/img/ui-sam.jpg" class="img-circle" width="60"></p>
              	  <h5 class="centered">UserName</h5>
              	  -->
                  
                  <br/>
                  <div class="centered">
                      <a href="profile.jsp"><span id="nameInitials" style="border-radius:50%; width:60; color:fff; background-color:#ffd777; font-size:3.5em;" data-toggle="tooltip" title="Profile"> &nbsp; Z &nbsp;</span></a>
                  </div>
                  <br/>
                  
                  
                  <li class="mt">
                      <a id="homeA" href="home.jsp">
                          <i class="li_shop"></i>
                          <span>Home</span>
                      </a>
                  </li>

                  <li class="mt">
                      <a href="passbook.jsp" id="passbookA">
                          <i class="li_vallet"></i>
                          <span>Passbook</span>
                      </a>
                  </li>

                  <li class="mt">
                      <a id="onlineShoppingA" href="OnlineShopping/index.jsp" target="_blank">
                          <i class="glyphicon glyphicon-shopping-cart"></i>
                          <span>Online Shopping</span>
                      </a>
                  </li>
                  
                  <li class="mt">
                      <a id="notificationA" href="notification.jsp">
                          <i class="li_mail"></i>
                          <span>Notifications</span> &nbsp;
                          <span class="badge" id="notificationBadge">0</span>
                      </a>
                  </li>
                  
                  <li class="sub-menu">
                      <a href="javascript:;" id="transactionsA">
                          <i class="li_banknote"></i>
                          <span>Transactions</span>
                          &nbsp; &nbsp; 
                          <span class="caret" style=""></span>
                      </a>
                      <ul class="sub">
                          <li id="smtfA"><a href="smtf.jsp">Send money to a Friend</a></li>
                          <li id="rmffA"><a href="rmff.jsp">Request money from Friend</a></li>
                          <li id="smtbA"><a href="smtb.jsp">Send money to Bank</a></li>
                          <li id="amtwA"><a href="amtw.jsp">Add money to wallet</a></li>
                      </ul>
                  </li>

                  
              </ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->


<script>
    
    $(document).ready(function(){
        $("#notificationBadge").load("notificationBadge");
    });
    
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip(); 
    });
       
</script>>