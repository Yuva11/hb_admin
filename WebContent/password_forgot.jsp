<!DOCTYPE html>
<html >
  <head>
    <meta charset="UTF-8">
    <title>Reset  Password</title>
    
    
  <link rel="stylesheet" href="css/stylef.css">
   
   <script>
     function validation()
       {
           if(document.f1.user_email.value==0)
                {
                    alert("Please enter the username name...");
                    document.f1.user_email.focus();
                    return false;
                }
               
             
                
             }
</script>
  </head>

  <body>

   
<div class="pen-title">
 
</div>
<!-- Form Module-->
<div class="module form-module" >
  <div class="toggle"><i class="fa fa-times fa-pencil"></i>
  
  </div>
  <div class="form">
    <h2>Reset Your Password</h2>
    <form method="post" name="f1" action="reset_password.jsp" onsubmit="return validation()">
      <input type="text" name="user_email" placeholder="Enter Username"/>
      <button>Reset</button>
    </form>
  </div> 

  <div class="cta"><a href="index.html">Login?</a></div>
</div>

    
    
  </body>
</html>
