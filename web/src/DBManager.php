<?php
/**
 * Created by PhpStorm.
 * User: quentinwendegass
 * Date: 18.04.18
 * Time: 13:01
 */

require_once "Exceptions.php";
require_once "Book.php";
require_once "User.php";
require_once "Constants.php";

class DBManager
{

    public function __construct()
    {

    }

    /**
     * @param $username
     * @param $email
     * @param $password
     * @param $confirmPassword
     * @return User
     * @throws EmailAlreadyExistsException
     * @throws UserAlreadyExistsException
     * @throws WrongPasswordException
     * @throws SQLException
     */
    public function register($username, $email, $password, $confirmPassword)
    {
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        if ($conn->connect_error) {
            throw new SQLException();
        }


        $sql = "SELECT * FROM user WHERE username = '" . strtolower($username) . "'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0){
            $result->close();
            $conn->close();
            throw new UserAlreadyExistsException();
        }

        $result->close();

        $sql = "SELECT * FROM user WHERE email = '" . strtolower($email) . "'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0)
            throw new EmailAlreadyExistsException();

        $result->close();

        if($password != $confirmPassword){
            $conn->close();
            throw new WrongPasswordException();
        }

        $sql = "INSERT INTO online_reader.user VALUE (default, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sss", $username, $email, $password);

        $stmt->execute();
        $stmt->close();

        $sql = "SELECT * FROM user WHERE email = '" . strtolower($email) . "'";
        $result = $conn->query($sql);

        $userData = $result->fetch_assoc();

        $user = new User($userData["id"], $userData["username"], $userData["email"], $userData["password"]);

        $result->close();
        $conn->close();

        return $user;
    }

    /**
     * @param $username
     * @param $password
     * @return User
     * @throws NoSuchUserNameException
     * @throws SQLException
     * @throws WrongPasswordException
     */
    public function login($username, $password)
    {
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        if ($conn->connect_error) {
            throw new SQLException();
        }

        $sql = "SELECT * FROM user WHERE username = '" . strtolower($username) . "'";
        $result = $conn->query($sql);

        if ($result->num_rows == 0){
            $result->close();
            $conn->close();
            throw new NoSuchUserNameException();
        }

        $userData = $result->fetch_assoc();

        if($userData["password"] != $password){
            $result->close();
            $conn->close();
            throw new WrongPasswordException();
        }

        $user = new User($userData["id"], $userData["username"], $userData["email"], $userData["password"]);

        $result->close();
        $conn->close();

        return $user;
    }

    /**
     * @param $bookID
     * @param $userID
     * @throws SQLException
     */
    public function deleteBookFromUser($bookID, $userID)
    {
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        if ($conn->connect_error) {
            throw new SQLException();
        }

        $sql = "DELETE FROM online_reader.user_has_book WHERE user_id='". $userID ."' and book_id='" . $bookID . "'";

        if ($conn->query($sql) === FALSE) {
            $conn->close();
            throw new SQLException();
        }

        $sql = "DELETE FROM online_reader.book WHERE id='" . $bookID . "'";

        if ($conn->query($sql) === FALSE) {
            $conn->close();
            throw new SQLException();
        }

        $conn->close();
    }

    /**
     * @param $title
     * @param $description
     * @param $filename
     * @param $userID
     * @throws NoSuchElementException
     * @throws SQLException
     */
    public function addBookToUser($title, $description, $filename, $userID)
    {
        $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        if ($conn->connect_error) {
            throw new SQLException();
        }

        $sql = "INSERT INTO online_reader.book VALUE (default, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sss", $filename, $description, $title);

        $stmt->execute();
        $stmt->close();

        $sql = "SELECT * FROM book WHERE book.name = '" . $filename . "'";
        $result = $conn->query($sql);

        if ($result->num_rows == 0){
            $result->close();
            throw new NoSuchElementException();
        }

        $bookData = $result->fetch_assoc();
        $bookID = $bookData["id"];

        $result->close();

        $sql = "INSERT INTO online_reader.user_has_book VALUE (?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ii", $userID, $bookID);

        $stmt->execute();
        $stmt->close();

        $conn->close();
    }

    /**
     * @param $userID
     * @return array
     * @throws NoSuchElementException
     * @throws SQLException
     */
    public function getBooksForUser($userID)
    {
        $books = array();

        $conn = new mysqli(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
        if ($conn->connect_error) {
            throw new SQLException();
        }

        $sql = "select book.id, book.name, book.description, book.title from book inner join user_has_book on book.id = user_has_book.book_id where user_has_book.user_id = " . $userID;
        $result = $conn->query($sql);

        if ($result->num_rows > 0){
            while($row = $result->fetch_assoc()) {
                $books[] = new Book($row["id"], $row["name"], $row["title"], $row["description"]);
            }
        }else{
            $result->close();
            $conn->close();
            throw new NoSuchElementException();
        }

        $result->close();
        $conn->close();

        return $books;
    }
}