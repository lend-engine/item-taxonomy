<?php
/**
 * On a Mac, run php -S localhost:8000
 * Then http://localhost:8000/builder.php

DROP TABLE `item_type`;
CREATE TABLE `item_type` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`parent_id` int(11) DEFAULT NULL,
`name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
`emission_factor` decimal(10,2) DEFAULT NULL,
`note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`id`),
KEY `IDX_44EE13D2727ACA70` (`parent_id`),
CONSTRAINT `FK_44EE13D2727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `item_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

 */

$servername = "localhost";
$username = "root";
$password = "root";

try {
    $conn = new PDO("mysql:host=$servername;dbname=taxonomy", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo "Connection to database failed: " . $e->getMessage();
    die();
}

$itemTypes = [];

$selectedParentId = null;
if (isset($_GET['parent_id'])) {
    $selectedParentId = $_GET['parent_id'];
}

// Delete an entry
if (isset($_GET['delete'])) {
    $delete = (int)$_GET['delete'];
    try {
        $stmt = $conn->prepare("DELETE FROM item_type WHERE id = '{$delete}'");
        $stmt->execute();
        header("Location: /builder.php?parent_id=".$selectedParentId);
    } catch (\Exception $e) {
        header("Location: /builder.php?parent_id=".$selectedParentId."&deleteFail=1");
    }
    die();
}

// Create a new entry
if (isset($_POST['name'])) {
    $name = $_POST['name'];
    if ($selectedParentId) {
        $stmt = $conn->prepare("INSERT INTO item_type (parent_id, name) VALUES ({$selectedParentId}, '{$name}')");
    } else {
        $stmt = $conn->prepare("INSERT INTO item_type (parent_id, name) VALUES (null, '{$name}')");
    }
    $stmt->execute();
    header("Location: /builder.php?parent_id=".$selectedParentId);
    die();
}

$stmt = $conn->prepare("SELECT * FROM item_type");
$stmt->execute();
$result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
$results = $stmt->fetchAll();

$selected = [];
$data = [];

// Get all results in whatever order they come out
foreach ($results as $row) {

    $id = $row['id'];
    $parentId = (int)$row['parent_id']; // sets null as zero

    // Load the flat array
    $itemTypes[$id] = $row;

    if ((int)$parentId == (int)$selectedParentId) {
        $selected[] = $row;
    }

    $row['children'] = [];
    $vn = "row" . $row['id'];
    ${$vn} = $row;

    if (!is_null($row['parent_id'])) {
        $vp = "parent" . $row['parent_id'];
        if (isset($data[$row['parent_id']])) {
            ${$vp} = $data[$row['parent_id']];
        } else {
            ${$vp} = [
                'id' => $row['parent_id'],
                'parent_id' => null,
                'children' => []
            ];
            $data[$row['parent_id']] = &${$vp};
        }
        ${$vp}['children'][] = &${$vn};
        $data[$row['parent_id']] = ${$vp};
    }
    $data[$row['id']] = &${$vn};
}

$d = array_filter($data, function($elem) {
    return is_null($elem['parent_id']);
});

?>
<!doctype html>
<html lang="en">
<head>
    <title>Taxonomy manager</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        body {
            font-size: 12px;
        }
        ul {
            padding-left: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h3>
        Taxonomy explorer
        <span class="pull-right">
            <a style="font-size: 12px;" href="builder.php">Home</a>
        </span>
    </h3>

<!--    <pre>-->
<!--        --><?php //print_r($d); ?>
<!--    </pre>-->

    <div class="row">
        <div class="col-md-3">
            <br>
                <?php

                printTax($d, $selectedParentId);

                function printTax($data, $selectedParentId) {
                    echo '<ul>';
                    foreach ($data AS $dataV) {
                        if ($dataV['id'] == $selectedParentId) {
                            $class = 'active';
                        } else {
                            $class = '';
                        }
                        echo '<li class="'.$class.'">';
                        echo '<a href="builder.php?parent_id='.$dataV['id'].'">';
                        echo $dataV['name'];
                        echo '</a>';
                        echo '</li>';
                        if (count($dataV['children']) > 0) {
                            // Show header then go down
                            echo '<ul>';
                            printTax($dataV['children'], $selectedParentId);
                            echo '</ul>';
                        }
                    }
                    echo '</ul>';
                }
                ?>
        </div>
        <div class="col-md-9">
            <form method="POST">
                <table class="table table-compact table-striped">
                    <thead>
                    <tr>
                        <th style="width: 10px">ID</th>
                        <th style="width: 50px">Parent&nbsp;ID</th>
                        <th>Name</th>
                        <th style="width: 50px">Factor</th>
                        <th></th>
                    </tr>
                    </thead>
                    <?php
                    foreach($selected as $id => $type) {
                        echo '<tr>';
                        echo '<td>'.$type['id'].'</td>';
                        echo '<td>'.$type['parent_id'].'</td>';
                        echo '<td>';
                        echo '<a href="/builder.php?parent_id='.$type['id'].'&parent_name='.$type['name'].'">'.$type['name'].'</a> &nbsp;&nbsp;&nbsp;';
                        echo '<a class="pull-right" href="builder.php?parent_id='.$type['parent_id'].'&delete='.$type['id'].'">delete</a>';
                        echo '</td>';
                        echo '<td>'.$type['emission_factor'].'</td>';
                        echo '<td></td>';
                        echo '</tr>';
                    }
                    ?>
                    <tr>
                        <td></td>
                        <td></td>
                        <td><input type="text" name="name" class="form-control"></td>
                        <td><input type="text" name="emission_factor" class="form-control"></td>
                        <td>
                            <input type="submit" name="submit" value="Add" class="btn btn-sm btn-success">
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

</div>
</body>
</html>