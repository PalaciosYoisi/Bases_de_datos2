<?php
// Datos de conexión a la base de datos
$servidor = "localhost";
$usuario = "root";
$clave = "";
$base_datos = "farmacia";

// Conectar a MySQL
$conexion = new mysqli($servidor, $usuario, $clave, $base_datos);

// Verificar conexión
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Verificar si se envió el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = trim($_POST["nombre"]);
    $correo = trim($_POST["correo"]);
    $password = password_hash($_POST["password"], PASSWORD_DEFAULT); // Cifrar la contraseña

    // Verificar si el correo ya existe
    $consulta = "SELECT id_usuario FROM usuarios WHERE correo = ?";
    $stmt = $conexion->prepare($consulta);
    $stmt->bind_param("s", $correo);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        echo "Este correo ya está registrado.";
    } else {
        // Insertar usuario
        $sql = "INSERT INTO usuarios (nombre, correo, password) VALUES (?, ?, ?)";
        $stmt = $conexion->prepare($sql);
        $stmt->bind_param("sss", $nombre, $correo, $password);

        if ($stmt->execute()) {
            header("Location: ../login_farmacia.html");
            exit(); 
        } else {
            echo "Error al registrar usuario.";
        }
    }

    $stmt->close();
}
$conexion->close();
?>
