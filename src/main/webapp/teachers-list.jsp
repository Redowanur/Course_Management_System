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
      <div class="ui three item menu">
        <a class="item" href="courses-list.jsp">Courses</a>
        <a class="item active" href="teachers-list.jsp">Teachers</a>
        <a class="item" href="students-list.jsp">Students</a>
      </div>
      <div
        class="ui middle aligned relaxed list divided"
        style="width: 100%; margin-top: 20px"
      >
      
				<%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            Statement st = con.createStatement();
			            String query = "SELECT * FROM users WHERE user_type = 'teacher'";
			            ResultSet rs = st.executeQuery(query);

			            while (rs.next()) {
			            	%>
					        <div class="item">
					          <div class="right floated content">
					            <div class="ui button icon"  onclick="deleteTeacher(<%=rs.getInt("id") %>)">
					              <i class="red trash icon"></i>
					            </div>
					          </div>
					          <div class="left floated content">
					            <button class="ui button black icon edit-course">
					              <i class="edit icon"></i>
					            </button>
					          </div>
					          	<div class="content">
								    <div class="header"><%=rs.getString("username") %></div>
								    <div class="description">Course(s): 
								    <% 
								    int id = rs.getInt("id");
								    String query2 = "SELECT name FROM courses WHERE teacher_id = ?";
								    PreparedStatement ps = con.prepareStatement(query2);
								    ps.setInt(1, id);
								    ResultSet rs2 = ps.executeQuery();
								    while (rs2.next()) {
								        if (!rs2.isLast()) {
								            %><%=rs2.getString("name")%>, <% 
								        } else {
								            %><%=rs2.getString("name")%><%
								        }
								    }
 									%>
								    </div>
								</div>

					          <div class="ui content segment course-drop" style="display: none">
					            <form class="ui form" action="AssignCourseServlet" method="post">
					            <input type="hidden" name="userId" value="<%=rs.getInt("id") %>">
					              <div class="field">
					                <label>Assign Courses</label>
					                <select class="ui fluid search dropdown" name="course" multiple required>
					                  <%
									  try {
								            Statement st2 = con.createStatement();
								            String query3 = "SELECT * FROM courses WHERE teacher_id IS NULL";
								            ResultSet rs3 = st2.executeQuery(query3);
											
								            while (rs3.next()) {
								            	%>
								                <option value="<%=rs3.getInt("id") %>"><%=rs3.getString("name")%></option>
								                <%
								            }
					
								            //con.close();
								        } catch (Exception e) {
								            e.printStackTrace();
								        }
									  %>
					                </select>
					              </div>
					              <button class="ui button black" type="submit">Assign</button>
					            </form>
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
    <%@ include file="/footer.jsp" %>
    <script>
      $(".edit-course").each(function () {
        $(this).click(function () {
          var courseDrop = $(this).closest(".item").find(".course-drop");
          courseDrop.transition("scale");
          courseDrop.find("select").dropdown();
        });
      });
      function deleteTeacher(id) {
  	    $.ajax({
  	        type: "POST",
  	        url: "DeleteTeacherServlet",
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
