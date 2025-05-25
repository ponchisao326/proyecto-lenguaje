@echo off
setlocal enabledelayedexpansion

:: -------------------------------------
:: Configuración
:: -------------------------------------
set QUALITY=80
set OUTPUT_DIR=optimized

:: Verificar cwebp
where cwebp >nul 2>&1 || (
    echo Error: Instala WebP Utilities desde:
    echo https://developers.google.com/speed/webp/docs/precompiled
    pause
    exit /b
)

:: Crear carpeta de salida
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

:: Procesar frames
for /L %%i in (0,1,491) do (
    set "num=00000%%i"
    set "num=!num:~-5!"
    cwebp -q %QUALITY% "!num!.webp" -o "%OUTPUT_DIR%\!num!.webp"
    echo Optimizado: !num!.webp
)

echo ¡Proceso completado!
pause