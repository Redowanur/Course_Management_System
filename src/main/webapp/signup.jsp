<html lang="en">
  <jsp:include page="/header.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
  </jsp:include>
  <body>
    <div class="ui menu">
      <div class="header item">Course Managements</div>
      <div class="right menu">
        <a class="item" href="login.jsp">
          <i class="sign-in icon"></i> Log In
        </a>
        <a class="item active" href="signup.jsp">
          <i class="user plus icon"></i> Sign Up
        </a>
      </div>
    </div>
    <div class="ui text container">
      <div class="ui two column centered grid">
        <div class="column">
          <div class="ui segment">
            <form class="ui form" action="SignupServlet" method="post">
              <div class="field">
                <div class="ui left icon input">
                  <input type="text" name="username" placeholder="Username" required/>
                  <i class="user icon"></i>
                </div>
              </div>
              <div class="field">
                <div class="ui left icon input">
                  <input type="text" placeholder="E-mail" />
                  <i class="mail icon"></i>
                </div>
              </div>
              <div class="field">
                <div class="ui left icon input">
                  <input type="password" name="password" placeholder="Password" required/>
                  <i class="key icon"></i>
                </div>
              </div>
              <div class="field">
                <div class="ui left icon input">
                  <input type="password" placeholder="Confirm Password" required/>
                  <i class="key icon"></i>
                </div>
              </div>
              
              <div class="field">
                <select class="ui dropdown" name="user_type" required>
			  	  <option value=""></option>
			  	  <option value="teacher">Teacher</option>
			  	  <option value="student">Student</option>
			  	</select>
              </div>

              <button class="ui button primary" type="submit">Sign Up</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/footer.jsp" %>
    
  </body>
</html>
