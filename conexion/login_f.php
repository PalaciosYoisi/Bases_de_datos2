<?php
// Configuración de la base de datos
$servidor = "localhost";
$usuario_db = "root";
$password_db = "";
$base_datos = "farmacia";

// Crear conexión
$conn = new mysqli($servidor, $usuario_db, $password_db, $base_datos);

// Verificar conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

session_start();

// Verificar si el formulario ha sido enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recibir y limpiar datos del formulario
    $correo = trim($_POST["username"]); // Se mantiene "username" pero corresponde al correo
    $password = trim($_POST["password"]);

    // Validar que los campos no estén vacíos
    if (empty($correo) || empty($password)) {
        header("Location: ../login_farmacia.html?mensaje=Todos los campos son obligatorios.&tipo=error");
        exit();
    }

    // Buscar usuario en la base de datos
    $sql = "SELECT id_usuario, nombre, correo, password FROM usuarios WHERE correo = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("s", $correo);
        $stmt->execute();
        $stmt->store_result();

        // Verificar si existe el usuario
        if ($stmt->num_rows > 0) {
            $stmt->bind_result($id_usuario, $nombre, $correo, $password_hash);
            $stmt->fetch();

            // Verificar la contraseña
            if (password_verify($password, $password_hash)) {
                $_SESSION["id_usuario"] = $id_usuario;
                $_SESSION["nombre"] = $nombre;

                header("Location: ../login_farmacia.html?mensaje=Bienvenido, $nombre!&tipo=success");
                exit();
            } else {
                header("Location: ../login_farmacia.html?mensaje=Contraseña incorrecta. Inténtalo de nuevo.&tipo=error");
                exit();
            }
        } else {
            header("Location: ../login_farmacia.html?mensaje=El correo ingresado no está registrado.&tipo=error");
            exit();
        }
        $stmt->close();
    } else {
        header("Location: ../login_farmacia.html?mensaje=Error en la consulta a la base de datos.&tipo=error");
        exit();
    }
}

// Cerrar conexión
$conn->close();
?>