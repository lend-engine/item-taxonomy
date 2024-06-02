<?php
/**
 * This is a very basic PHP file to manage the database quickly and easily
 *
 * On a Mac, run php -S localhost:8000
 * Then http://localhost:8000/builder.php
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
if (isset($_POST['submit']) && $_POST['submit'] == "Add") {
    $name   = $_POST['name'];
    $note   = $_POST['note'];
    $factor = $_POST['emission_factor'];
    if (!$factor) {
        $factor = 'null';
    }
    if ($selectedParentId) {
        $stmt = $conn->prepare("INSERT INTO item_type (parent_id, name, emission_factor, note) VALUES ({$selectedParentId}, '{$name}', {$factor}, '{$note}')");
    } else {
        $stmt = $conn->prepare("INSERT INTO item_type (parent_id, name, emission_factor, note) VALUES (null, '{$name}', {$factor}, '{$note}')");
    }
    $stmt->execute();
    header("Location: /builder.php?parent_id=".$selectedParentId."&added");
    die();
}

// Update an entry
if (isset($_POST['submit']) && $_POST['submit'] == "Update") {
    $name   = $_POST['name'];
    $note   = $_POST['note'];
    $factor = $_POST['emission_factor'];
    if (!$factor) {
        $factor = 'null';
    }
    $stmt = $conn->prepare("UPDATE item_type SET name = '{$name}', emission_factor = {$factor}, note = '{$note}' WHERE id = '{$selectedParentId}'");
    $stmt->execute();
    header("Location: /builder.php?parent_id=".$selectedParentId."&updated");
    die();
}

$stmt = $conn->prepare("SELECT * FROM item_type ORDER BY parent_id, name");
$stmt->execute();
$result = $stmt->setFetchMode(PDO::FETCH_ASSOC);
$results = $stmt->fetchAll();

$selected = [];
$data = [];
$activeType = [];

// Get all results in whatever order they come out
foreach ($results as $row) {

    $id = $row['id'];
    $parentId = (int)$row['parent_id']; // sets null as zero

    // Load the flat array
    $itemTypes[$id] = $row;

    if ((int)$parentId == (int)$selectedParentId) {
        $selected[] = $row;
    }

    if ($id == (int)$selectedParentId) {
        $activeType = $row;
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
        table.update-form td {
            background-color: #aaa;
        }
        .line-note {
            font-size: 11px; color: #aaa;
        }
    </style>
</head>
<body>
<div class="container">
    <br>
    <h3>Libraries Of Things &nbsp;&nbsp; <strong>Taxonomy manager</strong> &nbsp;&nbsp;&nbsp;&nbsp;
        <span style="font-size: 12px;">
            <a href="builder.php">Root</a>
            <?php if ($selectedParentId && $activeType['parent_id']) { ?>
                &raquo; <a href="builder.php?parent_id=<?php echo $itemTypes[(int)$activeType['parent_id']]['id']; ?>"><?php echo $itemTypes[(int)$activeType['parent_id']]['name']; ?></a>
                &raquo; <?php echo $activeType['name']; ?>
            <?php } ?>
        </span>
    </h3>

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
            <?php
                if ($selectedParentId) {
                    ?>
                    <hr>
                        <form method="POST">
                            <table style="width: 100%" cellpadding="4">
                                <tr>
                                    <td><input type="text" class="form-control" name="name" value="<?php echo $activeType['name']; ?>"></td>
                                    <td><input type="text" class="form-control" placeholder="Note" name="note" value="<?php echo $activeType['note']; ?>"></td>
                                    <td style="width: 80px"><input type="text" size="4" class="form-control" placeholder="EF" name="emission_factor" value="<?php echo $activeType['emission_factor']; ?>"></td>
                                    <td>
                                        <input type="submit" name="submit" value="Update" class="btn btn-sm btn-success float-right">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    <hr>
                    <?php
                }
            ?>
            <form method="POST">
                <table class="table table-compact table-striped table-hover">
                    <thead>
                    <tr>
                        <th style="width: 10px">ID</th>
                        <th>Name</th>
                        <th>Note</th>
                        <th style="width: 50px">Emissions&nbsp;factor</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <?php
                    foreach($selected as $id => $type) {
                        echo '<tr>';
                        echo '<td>'.$type['id'].'</td>';
                        echo '<td>';
                        echo '<a href="/builder.php?parent_id='.$type['id'].'&parent_name='.$type['name'].'">'.$type['name'].'</a> &nbsp;&nbsp;&nbsp;';
                        echo '</td>';
                        echo '<td class="line-note">'.$type['note'].'</td>';
                        echo '<td>'.$type['emission_factor'].'</td>';
                        echo '<td></td>';
                        echo '<td><a class="pull-right" href="builder.php?parent_id='.$type['parent_id'].'&delete='.$type['id'].'">delete</a></td>';
                        echo '</tr>';
                    }
                    ?>
                    <tr>
                        <td></td>
                        <td><input type="text" placeholder="Name" name="name" class="form-control"></td>
                        <td><input type="text" placeholder="Note/Keywords" name="note" class="form-control"></td>
                        <td style="width: 80px"><input type="text" name="emission_factor" class="form-control"></td>
                        <td></td>
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