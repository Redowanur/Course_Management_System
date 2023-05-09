<%@ page import="java.sql.*" %>
<html lang="en">
  <jsp:include page="/header.jsp">
    <jsp:param name="title" value="Admin Dashboard" />
  </jsp:include>
  <body>
    <jsp:include page="/auth-navbar.jsp">
      <jsp:param name="header" value="Admin Dashboard" />
    </jsp:include>
    <div class="ui text container">
      <div class="ui two column grid">
        <div class="ui three item menu">
          <a class="item" href="courses-list.jsp">Courses</a>
          <a class="item" href="teachers-list.jsp">Teachers</a>
          <a class="item active" href="students-list.jsp">Students</a>
        </div>
        <div class="ui middle aligned relaxed animated list divided" style="width: 100%">
        
				<%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            Statement st = con.createStatement();
			            String query = "SELECT * FROM users WHERE user_type = 'student'";
			            ResultSet rs = st.executeQuery(query);

			            while (rs.next()) {
			            	%>
			                <div class="item">
					            <div class="right floated content">
					              <div class="ui button icon"  onclick="deleteStudent(<%=rs.getInt("id") %>)">
					                <i class="red trash icon"></i>
					              </div>
					            </div>
					            <i class="user middle aligned icon"></i>
					            <div class="content">
					              <div class="header"><%=rs.getString("username") %></div>
					            </div>
					          </div>
			                <%
			            }

			            con.close();
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
				  %>
				  
        </div>
      </div>
    </div>
    <%@ include file="/footer.jsp" %>
    <script>
    function deleteStudent(id) {
	    $.ajax({
	        type: "POST",
	        url: "DeleteStudentServlet",
	        data: { id: id },
	        success: function(response) {
	            // Reload the page after successful deletion
	            location.reload();
	        },
	        error: function(xhr) {
	            console.log(xhr.responseText);
	        }
	    });
	}
    </script>
  </body>
</html>
