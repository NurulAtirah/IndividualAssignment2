package com.profile;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/ProfileServlet"})
public class ProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentID = request.getParameter("studentID");
        String name = request.getParameter("name");
        String programme = request.getParameter("programme");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");

        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbies = "";

        if (hobbiesArray != null) {
            for (int i = 0; i < hobbiesArray.length; i++) {
                hobbies += hobbiesArray[i];

                if (i < hobbiesArray.length - 1) {
                    hobbies += ", ";
                }
            }
        }

        ProfileBean profile = new ProfileBean();
        profile.setStudentID(studentID);
        profile.setName(name);
        profile.setProgramme(programme);
        profile.setEmail(email);
        profile.setHobbies(hobbies);
        profile.setIntroduction(introduction);

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO PROFILE "
                    + "(STUDENTID, NAME, PROGRAMME, EMAIL, HOBBIES, INTRODUCTION) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, profile.getStudentID());
            ps.setString(2, profile.getName());
            ps.setString(3, profile.getProgramme());
            ps.setString(4, profile.getEmail());
            ps.setString(5, profile.getHobbies());
            ps.setString(6, profile.getIntroduction());

            ps.executeUpdate();

            request.setAttribute("profile", profile);
            request.getRequestDispatcher("profile.jsp").forward(request, response);

            ps.close();
            con.close();

        } catch (Exception e) {
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error occurred:</h3>");
            response.getWriter().println(e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}