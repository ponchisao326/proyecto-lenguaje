@echo off
setlocal enabledelayedexpansion

:: Configurar la ruta donde está instalado cwebp
set "cwebp_path=C:\Herramientas\libwebp\bin\cwebp.exe"

:: Convertir todos los JPG a WebP
for %%a in (*.jpg *.JPG) do (
    echo Convirtiendo %%~na...
    "%cwebp_path%" "%%a" -o "%%~na.webp"
    if !errorlevel! equ 0 (
        del /q "%%a"
        echo Conversión exitosa: %%~na.webp
    ) else (
        echo Error convirtiendo %%~na
    )
)

echo Conversión completada
pause