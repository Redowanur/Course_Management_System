<%@ page import="java.sql.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
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
        <a class="item active" href="courses-list.jsp">Courses</a>
        <a class="item" href="teachers-list.jsp">Teachers</a>
        <a class="item" href="students-list.jsp">Students</a>
      </div>
      <button id="add-course" class="ui button black" type="submit">
        <i class="plus icon"></i>
        Add Course
      </button>
      <div class="ui divider"></div>
      <div
        class="ui middle aligned relaxed animated list divided"
        style="width: 100%; margin-top: 20px"
      >
      
	<%
	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
	    String query = "SELECT * FROM courses";
	    PreparedStatement ps = con.prepareStatement(query);
	    ResultSet rs = ps.executeQuery();
	
	    while (rs.next()) {
	        %>
	        <div class="item">
	            <div class="right floated content">
	                <div class="ui button icon" onclick="deleteCourse(<%=rs.getInt("id") %>)">
					    <i class="red trash icon"></i>
					</div>
	            </div>
	            <i class="book middle aligned icon"></i>
				<div class="content">
					<div class="right floated description">Credit: <%=rs.getInt("credit") %></div>
					<div class="header"><%=rs.getString("name") %></div>	
					<div class="description">Teacher:  
					<%
						int id = rs.getInt("teacher_id");
						if(id>0){
							String query2 = "SELECT username FROM users WHERE id =?";
						    PreparedStatement ps2 = con.prepareStatement(query2);
						    ps2.setInt(1, id);
						    ResultSet rs2 = ps2.executeQuery();
						    if(rs2.next()) %><span><%=rs2.getString("username") %></span><%
						}
					%>
					</div>
				</div>

	        </div>
	        <%
	        
	    }
	
	    rs.close();
	    ps.close();
	    con.close();
	} catch (Exception e) {
	    e.printStackTrace();
	}
	%>
      </div>
    </div>
    <div class="ui tiny modal">
      <div class="header">Add Courses</div>
      <div class="content">
        <form class="ui form" action="AddCourseServlet" method="post">
          <div class="field">
            <label>Course Name</label>
            <input type="text" name="course-name" placeholder="Course Name" required/>
          </div>
          <div class="field">
            <label>Credit</label>
            <input type="text" name="credit" placeholder="Credit" required/>
          </div>
          <div class="field">
            <label>Teacher</label>
            	<select class="ui fluid dropdown" name="teacher">
				  <option value="">Select Teacher</option>
				  <%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            Statement st = con.createStatement();
			            String query = "SELECT * FROM users WHERE user_type = 'teacher'";
			            ResultSet rs = st.executeQuery(query);

			            while (rs.next()) {
			            	%>
			                <option value="<%=rs.getInt("id") %>"><%=rs.getString("username")%></option>
			                <%
			            }

			            con.close();
			        } catch (Exception e) {
			            e.printStackTrace();
			        }
				  %>
				</select>
				            	
          </div>
          <button class="ui button black" type="submit">OK</button>
          <div class="ui button" id="close">Cancel</div>
        </form>
      </div>
    </div>
    <%@ include file="/footer.jsp" %>
    <script>
      $(".ui.modal").modal("attach events", ".ui.button#add-course", "show");
      $(".ui.modal").modal("attach events", ".ui.button#close", "hide");

	function deleteCourse(id) {
	    $.ajax({
	        type: "POST",
	        url: "DeleteCourseServlet",
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
