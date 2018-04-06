package at.greywind.onlinereader;

import java.util.ArrayList;
import java.util.NoSuchElementException;

public class User {

    private int id;
    private String username;
    private String email;
    private String password;
    private ArrayList<Book> books;

    public User(int id, String username, String email, String password){
        this.id = id;
        this.username = username;
        this.email = email;
        this.password = password;
        books = new ArrayList<>();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public ArrayList<Book> getBooks() {
        return books;
    }

    public void setBooks(ArrayList<Book> books){
        this.books = books;
    }

    public int getBookIdByName(String name) throws NoSuchElementException{
        for(Book b : books){
            if(b.getName().equals(name))
                return b.getId();
        }
        throw new NoSuchElementException();
    }
}
