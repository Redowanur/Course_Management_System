<%@ page import="java.sql.*" %>
<html lang="en">
  <jsp:include page="/header.jsp">
    <jsp:param name="title" value="Student Dashboard" />
  </jsp:include>
  <body>
    <jsp:include page="/auth-navbar.jsp">
      <jsp:param name="header" value="Student Dashboard" />
    </jsp:include>
    <h1 class="ui center aligned header">Welcome, ${username}</h1>
    <div class="ui text container">
      <div class="ui medium header"><span>Registered Courses</span></div>
      <div
        class="ui middle aligned relaxed animated list divided"
        style="width: 100%; margin-top: 20px"
      >
      
      			<%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            String query = "SELECT student_id, course_id, name, credit FROM registrations, courses WHERE course_id=id AND student_id=?";
			            PreparedStatement st = con.prepareStatement(query);
			            int id = (int)session.getAttribute("id");
			            st.setInt(1, id);
			            ResultSet rs = st.executeQuery();

			            while (rs.next()) {
			            	%>
					        <div class="item">
					          <i class="book middle aligned icon"></i>
					          <div class="content">
					            <div class="right floated description">Credit: <%=rs.getString("credit") %></div>
					            <div class="header"><%=rs.getString("name") %></div>
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
      <button id="add-course" class="ui button black" type="submit">
        <i class="plus icon"></i>
        Register New Course
      </button>
    </div>
    <div class="ui tiny modal">
      <div class="header">Register for New Course</div>
      <div class="content">
        <form class="ui form" action="RegisterCourseServlet" method="post">
        <input type="hidden" value="<%=(int)session.getAttribute("id")%>" name="student_id">
          <div class="field">
            <select class="ui fluid dropdown" name="course_id" required>
              <option value="">Select Course</option>
				  <%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            Statement st = con.createStatement();
			            String query = "SELECT id, name FROM courses WHERE id NOT IN (SELECT course_id FROM registrations WHERE student_id = ?)";
			            PreparedStatement st2 = con.prepareStatement(query);
			            int id = (int)session.getAttribute("id");
			            st2.setInt(1, id);
			            ResultSet rs2 = st2.executeQuery();

			            while (rs2.next()) {
			            	%>
			                <option value="<%=rs2.getInt("id") %>"><%=rs2.getString("name")%></option>
			                <%
			            }

			            con.close();
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
				  %>
            </select>
          </div>
          <button class="ui button black" type="submit">Register</button>
          <div class="ui button" id="close">Cancel</div>
        </form>
      </div>
    </div>
    <%@ include file="/footer.jsp" %>
    <script>
      $(".ui.modal").modal("attach events", ".ui.button#add-course", "show");
      $(".ui.modal").modal("attach events", ".ui.button#close", "hide");
    </script>
  </body>
</html>
