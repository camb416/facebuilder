<html>
<head>
<script language="javascript" src="scripts.js" ></script>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<form method="post" style="float:left;">
<?php


$counter = 0;
for($i=0;$i<8;$i++){
for($j=0;$j<8;$j++){
$classlist = "roundedOne clear";
echo '<div class="roundedOne">
	<input type="checkbox" value="1"  id="roundedOne'.$i.'-'.$j.'" name="'.$counter.'" />
	<label for="roundedOne'.$i.'-'.$j.'"></label>
</div>';
$classlist = "roundedOne";
$counter++;
}
echo '<br />';
}

?>

<input type="submit" value="Submit">

</form>
<pre style="float:left;margin-left:20px;">
<?php var_dump($_POST ); ?>

<?php 

// refactor this to get each byte
$mybyte = 0;
if(isset($_POST[0])) $mybyte ++;
if(isset($_POST[1])) $mybyte +=2;
if(isset($_POST[2])) $mybyte +=4;
if(isset($_POST[3])) $mybyte +=8;
if(isset($_POST[4])) $mybyte +=16;
if(isset($_POST[5])) $mybyte +=32;
if(isset($_POST[6])) $mybyte +=64;
if(isset($_POST[7])) $mybyte +=128;
echo "first byte is: ".dechex($mybyte);




?>
</pre>
</body>
</html>