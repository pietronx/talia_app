@echo off
echo Construyendo APK...
flutter build apk

IF EXIST build\app\outputs\flutter-apk\app-release.apk (
    echo Instalando en el dispositivo conectado...
    flutter install
    echo ¡APK instalada correctamente!
) ELSE (
    echo No se encontró la APK. ¿Hubo errores al compilar?
)

pause