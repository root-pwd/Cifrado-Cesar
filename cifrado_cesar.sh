#!/bin/bash
echo "==============XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX================"
echo "================xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx================"

echo "  ______     __     ______   ______     ______     _____     ______        ______     ______     ______     ______     ______       
 /\  ___\   /\ \   /\  ___\ /\  == \   /\  __ \   /\  __-.  /\  __ \      /\  ___\   /\  ___\   /\  ___\   /\  __ \   /\  == \      
 \ \ \____  \ \ \  \ \  __\ \ \  __<   \ \  __ \  \ \ \/\ \ \ \ \/\ \     \ \ \____  \ \  __\   \ \___  \  \ \  __ \  \ \  __<      
  \ \_____\  \ \_\  \ \_\    \ \_\ \_\  \ \_\ \_\  \ \____-  \ \_____\     \ \_____\  \ \_____\  \/\_____\  \ \_\ \_\  \ \_\ \_\    
   \/_____/   \/_/   \/_/     \/_/ /_/   \/_/\/_/   \/____/   \/_____/      \/_____/   \/_____/   \/_____/   \/_/\/_/   \/_/ /_/    
"
echo "================xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx============="
echo "==============XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=============="

# ===============================================
# SCRIPT: Cifrado César (Modo CLI con Entrada Interactiva)
# ===============================================

ALFABETO_MAYUS="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
ALFABETO_MINUS="abcdefghijklmnopqrstuvwxyz"

MODO_CIFRADO=0      # 1: Codificar (-cf), 2: Decodificar (-df)
ROTACION=3          # Rotación por defecto
ARCHIVO_SALIDA=""
MENSAJE=""          # Mensaje a procesar

mostrar_ayuda() {
    echo ""
    echo "======================================================="
    echo "         Menú de Ayuda - Cifrado César CLI"
    echo "======================================================="
    echo "Uso: $0 [OPCIONES] [\"MENSAJE\"]"
    echo "   (Si no proporciona MENSAJE, se pedirá de forma interactiva)."
    echo ""
    echo "Parámetros de Operación (mutuamente excluyentes):"
    echo "  -cf          Modo de Codificación (Cifrar). Rotación por defecto: 3."
    echo "  -df          Modo de Decodificación (Descifrar). Rotación por defecto: 3."
    echo ""
    echo "Opciones Adicionales:"
    echo "  -r [Número]  Establece la rotación/clave (ej: -r 5)."
    echo "  -o [Archivo] Redirige la salida a un archivo (ej: -o salida.txt)."
    echo ""
    echo "Comandos Independientes:"
    echo "  -help        Muestra este menú de ayuda."
    echo "  -exit        Cancela la ejecución del script."
    echo ""
    echo "Ejemplo completo:"
    echo "  $0 -cf -r 3 \"Hola mundo\" -o ejemplo.txt"
    echo "  $0 -df" 
    echo "======================================================="
    echo ""
}

cifrar_mensaje() {
    local desplazamiento=$1
    local mensaje_claro="$2"
    local alfa_origen="$ALFABETO_MAYUS$ALFABETO_MINUS"
    
    local indice=$((desplazamiento % 26))

    local alfa_destino_mayus=$(echo "$ALFABETO_MAYUS" | cut -c $((indice + 1))-)$(echo "$ALFABETO_MAYUS" | cut -c 1-$indice)
    local alfa_destino_minus=$(echo "$ALFABETO_MINUS" | cut -c $((indice + 1))-)$(echo "$ALFABETO_MINUS" | cut -c 1-$indice)
    local alfa_destino="$alfa_destino_mayus$alfa_destino_minus"
    
    local MENSAJE_PROCESADO

    if [ $MODO_CIFRADO -eq 2 ]; then
        MENSAJE_PROCESADO=$(echo "$mensaje_claro" | tr "$alfa_destino" "$alfa_origen")
    else
        MENSAJE_PROCESADO=$(echo "$mensaje_claro" | tr "$alfa_origen" "$alfa_destino")
    fi

    if [ -n "$ARCHIVO_SALIDA" ]; then
        echo "$MENSAJE_PROCESADO" > "$ARCHIVO_SALIDA"
        echo "Archivo creado correctamente: $ARCHIVO_SALIDA (Rotación: $ROTACION)"
    else
        echo ""
        echo "--- Resultado ---"
        echo "Rotación: $ROTACION"
        echo "Mensaje Original: $MENSAJE"
        if [ $MODO_CIFRADO -eq 2 ]; then
            echo "🔓 Mensaje Decodificado: $MENSAJE_PROCESADO"
        else
            echo "🔐 Mensaje Codificado: $MENSAJE_PROCESADO"
        fi
        echo "-----------------"
        echo ""
    fi
}

if [ "$1" == "-exit" ]; then
    echo "Script cancelado por el usuario."
    exit 0
elif [ "$1" == "-help" ]; then
    mostrar_ayuda
    exit 0
fi

while [ $# -gt 0 ]; do
    case "$1" in
        -cf)
            [ $MODO_CIFRADO -ne 0 ] && { echo "❌ ERROR: Los modos -cf y -df no pueden combinarse."; exit 1; }
            MODO_CIFRADO=1
            ;;
        -df)
            [ $MODO_CIFRADO -ne 0 ] && { echo "❌ ERROR: Los modos -cf y -df no pueden combinarse."; exit 1; }
            MODO_CIFRADO=2
            ;;
        -r)
            shift
            if ! [[ "$1" =~ ^[0-9]+$ ]]; then
                echo "❌ ERROR: El parámetro -r requiere un número entero positivo."
                exit 1
            fi
            ROTACION=$1 
            ;;
        -o)
            shift
            if [ -z "$1" ]; then
                echo "❌ ERROR: El parámetro -o requiere un nombre de archivo."
                exit 1
            fi
            ARCHIVO_SALIDA="$1"
            ;;
        *)
            if [ -z "$MENSAJE" ]; then MENSAJE="$1"; else MENSAJE="$MENSAJE $1"; fi
            ;;
    esac
    shift
done

if [ $MODO_CIFRADO -eq 0 ]; then
    echo "❌ ERROR: Debe especificar el modo de operación (-cf o -df)."
    mostrar_ayuda
    exit 1
fi

if [ -z "$MENSAJE" ]; then
    TIPO_OP="Codificar"
    [ $MODO_CIFRADO -eq 2 ] && TIPO_OP="Decodificar"
    echo "Modo interactivo: $TIPO_OP (Rotación $ROTACION)"
    read -p ">> Inserte su mensaje: " MENSAJE
fi

if [ -z "$MENSAJE" ]; then
    echo "❌ ERROR: No se proporcionó ningún mensaje."
    exit 1
fi

cifrar_mensaje $ROTACION "$MENSAJE"
