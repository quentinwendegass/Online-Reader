<?php
require_once "src/User.php";
session_start();

require_once "src/Book.php";
require_once "src/DBManager.php";
?>
<html>
<head>
    <?php
    $user = $_SESSION["user"];

    $db = new DBManager();

    try{
        $user->setBooks($db->getBooksForUser($user->getId()));
    }catch (Exception $e){
    }
    ?>
    <title>Books</title>
    <script src="script/books.js"></script>
</head>
<body>

<?php
foreach($user->getBooks() as $book){
?>
<div class="book" style="background-image: url('<?php echo "uploads/thumb/" . $book->getName() . "-thumb.png";?>')" id="<?php echo $book->getName();?>">
    <div class="book-content">
        <i class="fas fa-times-circle delete"></i>
        <div class="title-bar">
            <h3 class="title"><?= $book->getTitle() ?></h3>
        </div>
        <div class="description-wrapper">
            <p class="description"><?php if($book->getDescription() != null) echo $book->getDescription();?></p>
        </div>
    </div>
</div>
<?php
}
?>
<div class="add-book">
    <i class="fas fa-plus fa-8x icon"></i>
</div>


</body>
</html>
