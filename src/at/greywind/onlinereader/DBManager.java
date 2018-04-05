package at.greywind.onlinereader;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.apache.pdfbox.tools.imageio.ImageIOUtil;


import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DBManager {
    private Connection connect = null;

    public static void main(String[] args){

    }

    public DBManager(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connect = DriverManager.getConnection("jdbc:mysql://localhost/online_reader?" + "user=root&password=***REMOVED***");
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

    public void addBookToUser(String title, String description, String filename, int userID){
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
            e.printStackTrace();
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
