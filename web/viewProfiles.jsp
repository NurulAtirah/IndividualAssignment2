<%@page import="java.sql.*"%>
<%@page import="com.profile.DBConnection"%>


<!DOCTYPE html>
<html>
<head>
    <title>View Profiles</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="table-wrapper">

<h1>Profile Management</h1>
<p class="form-subtitle">View, search and delete student profiles</p>

<form method="get" action="viewProfiles.jsp" class="search-form">
    <input type="text" name="searchKeyword" placeholder="Search by Student ID or Name">
    <input type="submit" value="Search" class="btn-submit">
    <a href="viewProfiles.jsp" class="show-button">Show All</a>
</form>

<%
String deleteID = request.getParameter("deleteID");

if (deleteID != null) {
    try {
        Connection con = DBConnection.getConnection();

        String deleteSql = "DELETE FROM PROFILE WHERE STUDENTID=?";
        PreparedStatement psDelete = con.prepareStatement(deleteSql);
        psDelete.setString(1, deleteID);

        int result = psDelete.executeUpdate();

        if (result > 0) {
            out.println("<p class='success-msg'>Profile deleted successfully.</p>");
        } else {
            out.println("<p class='error-msg'>No profile found to delete.</p>");
        }

        psDelete.close();
        con.close();

    } catch (Exception e) {
        out.println("<p class='error-msg'>" + e.getMessage() + "</p>");
    }
}
%>

<table>
    <tr>
        <th>Student ID</th>
        <th>Name</th>
        <th>Programme</th>
        <th>Email</th>
        <th>Hobbies</th>
        <th>Introduction</th>
        <th>Action</th>
    </tr>

<%
try {
    Connection con = DBConnection.getConnection();

    String searchKeyword = request.getParameter("searchKeyword");
    PreparedStatement ps;

    if (searchKeyword != null && !searchKeyword.trim().equals("")) {

        String sql = "SELECT * FROM PROFILE "
                   + "WHERE STUDENTID = ? "
                   + "OR UPPER(NAME) LIKE UPPER(?)";

        ps = con.prepareStatement(sql);
        ps.setString(1, searchKeyword);
        ps.setString(2, "%" + searchKeyword + "%");

    } else {

        String sql = "SELECT * FROM PROFILE";
        ps = con.prepareStatement(sql);

    }

    ResultSet rs = ps.executeQuery();

    boolean found = false;

    while (rs.next()) {
        found = true;
%>

    <tr>
        <td><%= rs.getString("STUDENTID") %></td>
        <td><%= rs.getString("NAME") %></td>
        <td><%= rs.getString("PROGRAMME") %></td>
        <td><%= rs.getString("EMAIL") %></td>
        <td><%= rs.getString("HOBBIES") %></td>
        <td><%= rs.getString("INTRODUCTION") %></td>
        <td>
            <a class="delete-button"
               href="viewProfiles.jsp?deleteID=<%= rs.getString("STUDENTID") %>"
               onclick="return confirm('Are you sure you want to delete this profile?');">
                Delete
            </a>
        </td>
    </tr>

<%
    }

    if (!found) {
%>

    <tr>
        <td colspan="7">No profile records found.</td>
    </tr>

<%
    }

    rs.close();
    ps.close();
    con.close();

} catch (Exception e) {
    out.println("<p class='error-msg'>" + e.getMessage() + "</p>");
}
%>

</table>

<br>
<a href="index.html" class="link-button">Back to Form</a>

</div>

</body>
</html>