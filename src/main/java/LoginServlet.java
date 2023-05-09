import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
        	PrintWriter out = response.getWriter();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/course_management_system", "root", "connected");

            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                String userType = rs.getString("user_type");
                int id = rs.getInt("id");
                //System.out.println(id);
                if (userType.equals("admin")) {
                	RequestDispatcher rd = request.getRequestDispatcher("courses-list.jsp");
                	rd.forward(request, response);
                } else if (userType.equals("teacher")) {
                	request.setAttribute("username", username);
                	HttpSession session = request.getSession();
                	session.setAttribute("id", id);
                	RequestDispatcher rd = request.getRequestDispatcher("teacher-dashboard.jsp");
                	rd.forward(request, response);
                } else if (userType.equals("student")) {
                	request.setAttribute("username", username);
                	HttpSession session = request.getSession();
                	session.setAttribute("id", id);
                	RequestDispatcher rd = request.getRequestDispatcher("student-dashboard.jsp");
                	rd.forward(request, response);
                }
            } else {
            	out.println("<font color=red size=18>Login Failed!!<br>");
				out.println("<a href=login.jsp>Try Again!!</a>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
