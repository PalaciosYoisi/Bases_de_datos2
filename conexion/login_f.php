<?php
session_start();
$host = "localhost"; 
$usuario = "root"; 
$password = "";
$bd = "farmacia"; 

// Conexión a la base de datos
$conn = new mysqli($host, $usuario, $password, $bd);

// Verificar conexión
if ($conn->connect_error) {
    die("Error en la conexión: " . $conn->connect_error);
}

// Obtener datos del formulario
$username = $_POST['username'];
$password = $_POST['password'];

// Preparar consulta para buscar el usuario
$stmt = $conn->prepare("SELECT password FROM usuarios WHERE correo = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows > 0) {
    $fila = $resultado->fetch_assoc();
    
    // Verificar la contraseña con password_verify()
    if (password_verify($password, $fila['password'])) {
        header("Location: /..login_farmacia.html?mensaje=exito"); // Inicio de sesión exitoso
    } else {
        header("Location: /..login_farmacia.html?mensaje=error_clave"); // Contraseña incorrecta
    }
} else {
    header("Location: /..login_farmacia.html?mensaje=error_usuario"); // Usuario no encontrado
}

$stmt->close();
$conn->close();
exit;
?>
