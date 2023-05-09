import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCourseServlet")
public class RegisterCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public RegisterCourseServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int studentId = Integer.parseInt(request.getParameter("student_id"));
		int courseId = Integer.parseInt(request.getParameter("course_id"));

		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");

		    String sql = "INSERT INTO registrations (student_id, course_id) VALUES (?, ?)";
		    PreparedStatement statement = con.prepareStatement(sql);
		    statement.setInt(1, studentId);
		    statement.setInt(2, courseId);

		    int rowsInserted = statement.executeUpdate();
		    
		    sql = "SELECT username FROM users WHERE id=?";
		    statement = con.prepareStatement(sql);
		    statement.setInt(1, studentId);
		    ResultSet rs = statement.executeQuery();
		    if (rowsInserted > 0) {
		    	if(rs.next()) request.setAttribute("username", rs.getString("username"));
		    	RequestDispatcher rd = request.getRequestDispatcher("student-dashboard.jsp");
            	rd.forward(request, response);
		    }
		    else {
		    	
		    }

		    con.close();
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}

}
