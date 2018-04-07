package at.greywind.onlinereader;

import javax.servlet.ServletContext;
import java.sql.*;
import java.util.ArrayList;

public class DBManager {
    private Connection connect = null;

    private static String dbName = null;
    private static String dbPassword = null;
    private static String dbUser = null;

    public static void main(String[] args){
        DBManager m = new DBManager();
        try {
            m.deleteBookFromUser(75, 5);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static boolean isDatabaseSet(){
        if(dbName != null && dbPassword != null && dbUser != null)
            return true;

        return false;
    }

    public static void setDatabase(ServletContext context){
        dbName = context.getInitParameter("db-name");
        dbPassword = context.getInitParameter("db-password");
        dbUser = context.getInitParameter("db-user");
    }

    public DBManager(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost/"+ dbName + "?" + "user="+ dbUser + "&password=" + dbPassword);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public User register(String username, String email, String password, String confirmPassword) throws NoSuchUserNameException, WrongPasswordException, SQLException {
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            statement = connect.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM user WHERE username = '" + username.toLowerCase() + "'");

            if (resultSet.isBeforeFirst()) {
                throw new NoSuchUserNameException();
            }

            closeSetAndStatement(resultSet, statement);

            statement = connect.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM user WHERE email = '" + email.toLowerCase() + "'");

            if (resultSet.isBeforeFirst()) {
                throw new EmailAlreadyExistsException();
            }

            closeSetAndStatement(resultSet, statement);

            if(!password.equals(confirmPassword)){
                throw new WrongPasswordException();
            }

            PreparedStatement preparedStatement = connect.prepareStatement("INSERT INTO online_reader.user VALUE (default, ?, ?, ?)");
            preparedStatement.setString(1, username.toLowerCase());
            preparedStatement.setString(2, email.toLowerCase());
            preparedStatement.setString(3, password);
            preparedStatement.executeUpdate();
            preparedStatement.close();

            statement = connect.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM user WHERE email = '" + email.toLowerCase() + "'");
            resultSet.first();

            return new User(resultSet.getInt("id"), resultSet.getString("username"),resultSet.getString("email"),resultSet.getString("password"));
        }catch (Exception e){
            throw e;
        }finally {
            closeSetAndStatement(resultSet, statement);
        }
    }

    public User login(String username, String password) throws WrongPasswordException, NoSuchUserNameException, SQLException {
        ResultSet resultSet = null;
        Statement statement = null;
        try {
            statement = connect.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM user WHERE username = '" + username + "'");

            if (!resultSet.isBeforeFirst() ) {
               throw new NoSuchUserNameException();
            }

            resultSet.first();
            if(!password.equals(resultSet.getString("password"))) {
                throw new WrongPasswordException();
            }

            return new User(resultSet.getInt("id"), resultSet.getString("username"),resultSet.getString("email"),resultSet.getString("password"));
        } catch (Exception e) {
            throw e;
        } finally {
            closeSetAndStatement(resultSet, statement);
        }
    }

    public void deleteBookFromUser(int bookID, int userID) throws SQLException {
        Statement statement = connect.createStatement();
        statement.execute("DELETE FROM online_reader.user_has_book WHERE user_id='"+ userID +"' and book_id='" + bookID + "'");
        statement.close();

        statement = connect.createStatement();
        statement.execute("DELETE FROM online_reader.book WHERE id='" + bookID + "'");
        statement.close();
    }

    public void addBookToUser(String title, String description, String filename, int userID) throws SQLException{
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            PreparedStatement preparedStatement = connect.prepareStatement("INSERT INTO online_reader.book VALUE (default, ?, ?, ?)");
            preparedStatement.setString(1, filename);
            preparedStatement.setString(2, description);
            preparedStatement.setString(3, title);
            preparedStatement.executeUpdate();
            preparedStatement.close();

            statement = connect.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM book WHERE book.name = '" + filename + "'");
            resultSet.first();

            int bookID = resultSet.getInt("id");

            preparedStatement = connect.prepareStatement("INSERT INTO online_reader.user_has_book VALUE (?, ?)");
            preparedStatement.setInt(1, userID);
            preparedStatement.setInt(2, bookID);
            preparedStatement.executeUpdate();
            preparedStatement.close();
        }catch (Exception e){
               throw e;
        }finally {
            closeSetAndStatement(resultSet, statement);
        }
    }

    public ArrayList<Book> getBooksforUser(int userID){
        ArrayList<Book> books = new ArrayList<>();
        Statement statement = null;
        try {
            statement = connect.createStatement();
            ResultSet resultSet = statement.executeQuery("select book.id, book.name, book.description, book.title from book inner join user_has_book on book.id = user_has_book.book_id where user_has_book.user_id = " + userID +";");

            while (resultSet.next()){
                books.add(new Book(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getString("title"), resultSet.getString("description")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    private void closeSetAndStatement(ResultSet resultSet, Statement statement) {
        if(resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if(statement != null){
            try {
                statement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void close() {
        try {
            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }
}
