<%@ page import="java.sql.*" %>
<html lang="en">
  <jsp:include page="/header.jsp">
    <jsp:param name="title" value="Teacher Dashboard" />
  </jsp:include>
  <body>
    <jsp:include page="/auth-navbar.jsp">
      <jsp:param name="header" value="Teacher Dashboard" />
    </jsp:include>
    <h1 class="ui center aligned header">Welcome, ${username}</h1>
    <div class="ui text container">
      <div class="ui medium header"><span>Assigned Courses</span></div>
      <div
        class="ui middle aligned relaxed list divided"
        style="width: 100%; margin-top: 20px"
      >
      
            	<%
				  try {
			            Class.forName("com.mysql.cj.jdbc.Driver");
			            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
			            String query = "SELECT * FROM courses WHERE teacher_id=?";
			            PreparedStatement st = con.prepareStatement(query);
			            int id = (int)session.getAttribute("id");
			            st.setInt(1, id);
			            ResultSet rs = st.executeQuery();

			            while (rs.next()) {
			            	%>
					        <div class="item" role="button">
					          <i class="book middle aligned icon"></i>
					          <div class="content">
					            <div class="right floated description">Credit: <%=rs.getString("credit") %></div>
					            <div class="header"><%=rs.getString("name") %></div>
					          </div>
					          
					          <div class="content" style="margin-top: 20px; display: none">
					            <table class="ui basic celled table">
					              <thead>
					                <tr>
					                  <th>Student</th>
					                  <th>Registered on</th>
					                </tr>
					              </thead>
					              <tbody>
					              	<%
					              	String query2="SELECT student_id, course_id, username, registered_on FROM registrations, users WHERE student_id=id AND course_id=?";
					              	PreparedStatement st2 = con.prepareStatement(query2);
					              	st2.setString(1, rs.getString("id"));
					              	ResultSet rs2 = st2.executeQuery();
					              	
					              	while(rs2.next()){
					              		%>
						         		<tr>
						                  <td><%=rs2.getString("username") %></td>
						                  <td><%=rs2.getString("registered_on") %></td>
						                </tr>
					                	<%
					              	}
					              	st2.close();
					              	rs2.close();
 									%>
					              </tbody>
					            </table>
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
      $(".item").each(function () {
        $(this).click(function () {
          $(this).find(".content").last().slideToggle();
        });
      });
    </script>
  </body>
</html>
