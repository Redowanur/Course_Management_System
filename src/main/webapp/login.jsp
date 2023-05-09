<html lang="en">
  <head>
  <meta charset="UTF-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>${param.title} - Course Management System</title>
  <link rel="stylesheet" href="semantic/semantic.min.css" />
  <link rel="stylesheet" href="style.css" />
  <link rel="stylesheet" media="screen" href="https://cdn.dribbble.com/assets/auth-e3eaae66706af6ad333ae9321650f4834927cc5d184b0ff1281647c29a48d393.css" />
</head>

  <body>
    <div class="ui menu">
      <div class="header item">Course Managements</div>
		<div class="right menu">
		  <a class="item active" href="login.jsp">
		    <i class="sign-in icon"></i> Log In
		  </a>
		  <a class="item" href="signup.jsp">
		    <i class="user plus icon"></i> Sign Up
		  </a>
		  <button onclick="myFunction()">Toggle dark mode</button>
		</div>

    </div>
    <div class="ui text container">
      <div class="ui two column centered grid">
        <div class="column">
        
		  <div class="auth-form sign-in-form">
		    <form action="LoginServlet" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />
		      
		      <div class="form-fields">
		        <fieldset>
		          <label for="login">Username</label>
		          <input type="text" name="username" id="login" tabindex="1" class="text-input" autocorrect="off" autocapitalize="off" data-cypress="email" />
		        </fieldset>
		
		        <fieldset>
		          <label for="password" class="password">Password</label>
		          <input type="password" name="password" id="password" value="" tabindex="2" class="text-input" data-cypress="password" />
		        </fieldset>
		      </div>
		
		      <input class="button form-sub" type="submit" value="Sign In" tabindex="3" data-cypress="submit-sign-in-btn"/>
		</form>
		    <p class="auth-link-mobile">
		      Not a member? <a href="/signup/new">Sign up now</a>
		    </p>
		  </div>
          
        </div>
      </div>
    </div>
    <%@ include file="/footer.jsp" %>
	<script>
	function myFunction() {
	   var element = document.body;
	   element.classList.toggle("dark-mode");
	}
	</script>
	    
  </body>
</html>
