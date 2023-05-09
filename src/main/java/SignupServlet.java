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

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SignupServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String userType = request.getParameter("user_type");

		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");

		    String sql = "INSERT INTO users (username, password, user_type) VALUES (?, ?, ?)";
		    PreparedStatement statement = con.prepareStatement(sql);
		    statement.setString(1, username);
		    statement.setString(2, password);
		    statement.setString(3, userType);

		    int rowsInserted = statement.executeUpdate();
		    if (rowsInserted > 0) {
		    	RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
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
