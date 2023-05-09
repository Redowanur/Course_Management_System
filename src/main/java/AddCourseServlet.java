import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddCourseServlet")
public class AddCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddCourseServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String courseName = request.getParameter("course-name");
		String credit = request.getParameter("credit");
		String teacherId = request.getParameter("teacher");

		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
		    int i=0;
		    
		    if(teacherId=="") {
		    	String sql = "INSERT INTO courses (name, credit) VALUES (?, ?)";
			    PreparedStatement statement = con.prepareStatement(sql);
			    statement.setString(1, courseName);
			    statement.setString(2, credit);
			    i = statement.executeUpdate();
		    }
		    else {
		    	String sql = "INSERT INTO courses (name, credit, teacher_id) VALUES (?, ?, ?)";
			    PreparedStatement statement = con.prepareStatement(sql);
			    statement.setString(1, courseName);
			    statement.setString(2, credit);
			    statement.setString(3, teacherId);
			    i = statement.executeUpdate();
		    }
		    
		    if(i>0) {
		    	RequestDispatcher rd = request.getRequestDispatcher("courses-list.jsp");
            	rd.forward(request, response);
		    }

		    con.close();
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}

}
