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

@WebServlet("/AssignCourseServlet")
public class AssignCourseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AssignCourseServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String teacherId = request.getParameter("userId");
		//System.out.println(userId);
		String[] selectedCourses = request.getParameterValues("course");
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
	        String query = "UPDATE courses SET teacher_id = ? WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        int i=0;
	        for (String courseId : selectedCourses) {
	            pstmt.setInt(1, Integer.parseInt(teacherId)); // set the teacher_id parameter
	            pstmt.setInt(2, Integer.parseInt(courseId)); // set the id parameter
	            i=pstmt.executeUpdate(); // execute the update statement
	        }
	        conn.close();
	        if(i>0) {
		    	RequestDispatcher rd = request.getRequestDispatcher("teachers-list.jsp");
            	rd.forward(request, response);
		    }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
