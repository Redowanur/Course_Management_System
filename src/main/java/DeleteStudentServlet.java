import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");
            String query = "UPDATE registrations SET course_id = NULL WHERE student_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            
            query = "DELETE FROM registrations WHERE student_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            
            query = "DELETE FROM users WHERE id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            
            ps.close();
            con.close();
            response.getWriter().write("Student deleted successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting course");
        }
    }
}
