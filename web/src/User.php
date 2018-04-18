<?php
/**
 * Created by PhpStorm.
 * User: quentinwendegass
 * Date: 18.04.18
 * Time: 12:33
 */

require_once "Exceptions.php";
require_once "Book.php";

class User
{

    private $id;
    private $username;
    private $email;
    private $password;
    private $books = [];

    /**
     * User constructor.
     * @param $id
     * @param $username
     * @param $email
     * @param $password
     */
    public function __construct($id, $username, $email, $password)
    {
        $this->id = $id;
        $this->username = $username;
        $this->email = $email;
        $this->password = $password;
    }

    public function __toString()
    {
        return $this->username . " " . $this->email . " " . $this->password;
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id)
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * @param mixed $username
     */
    public function setUsername($username)
    {
        $this->username = $username;
    }

    /**
     * @return mixed
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * @param mixed $email
     */
    public function setEmail($email)
    {
        $this->email = $email;
    }

    /**
     * @return mixed
     */
    public function getPassword()
    {
        return $this->password;
    }

    /**
     * @param mixed $password
     */
    public function setPassword($password)
    {
        $this->password = $password;
    }

    /**
     * @return array
     */
    public function getBooks()
    {
        return $this->books;
    }

    /**
     * @param array $books
     */
    public function setBooks($books)
    {
        $this->books = $books;
    }

    /**
     * @param $name
     * @return mixed
     * @throws NoSuchElementException
     */
    public function getBookIdByName($name)
    {
        foreach($this->books as $book){
            if($book->getName() == $name){
                return $book->getId();
            }
        }

        throw new NoSuchElementException();
    }


}