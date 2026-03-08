 ![Cifrado-cesar](https://github.com/root-pwd/Cifrado-Cesar/blob/19919998aa249c1d34115bcec3901ba1787c9413/Cifrado-cesar.png)
- - - -
# Cifrado César. 

El uso del cifrado César data de la época del rey **Julio César**, quien necesitaba que sus notas llegaran sin ser interpretadas por sus enemigos en el campo de batalla o durante el envío de mensajes a sus aliados.

## También se conoce como:

**cifrado por desplazamiento**, ya que César decidía si una letra iría tres posiciones adelante o tres posiciones atrás, influyendo en la rotación del mensaje con respecto a cada letra del mensaje original.

### Ejemplo:
Para la rotación de 3 posiciones:
- A = D
- B = E
- C = F

El principio de un cifrado es que exista una manera de que la contraparte pueda descifrar el mensaje. En este proyecto, no solo podremos cifrar, sino también descifrar. Además, podemos realizar nuestras propias rotaciones, lo que añade un poco más de misticismo a lo que queramos compartir con nuestros amigos y compañeros, ya sea en el entorno web o en la vida real.

Este proyecto fue creado con fines educativos y como modelo de desarrollo para el lenguaje **Bash**. Es un script que puedes ejecutar dando permisos de ejecución con el comando `chmod +x` y ejecutando con `./`. Puedes revisar el código y verificar que no contiene ningún actor malicioso.

----
# Uso.
=======================================================

Uso: ./cifrado_cesar.sh [OPCIONES] ["MENSAJE"]
   (Si no proporciona MENSAJE, se pedirá de forma interactiva).

Parámetros de Operación (mutuamente excluyentes):
  -cf          Modo de Codificación (Cifrar). Rotación por defecto: 3.
  -df          Modo de Decodificación (Descifrar). Rotación por defecto: 3.

Opciones Adicionales:
  -r [Número]  Establece la rotación/clave (ej: -r 5).
  -o [Archivo] Redirige la salida a un archivo (ej: -o salida.txt).

Comandos Independientes:
  -help        Muestra el menú de ayuda.
  -exit        Cancela la ejecución del script.

Ejemplo completo:
  ./cifrado_cesar.sh -cf -r 3 "Hola mundo" -o ejemplo.txt
  ./cifrado_cesar.sh -df

=======================================================

<a href="https://www.linkedin.com/in/luis-velasquez-552b0b185"><img src="https://img.shields.io/badge/-LinkeIn-0072b1?&style=for-the-badge&logo=linkedin&logoColor=white" /></a>
