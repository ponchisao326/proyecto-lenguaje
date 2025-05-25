import cv2
import os
from tqdm import tqdm  # Importamos tqdm para mostrar la barra de progreso

def extraer_fotogramas(video_path, output_folder, target_fps=60):
    # Crear la carpeta de salida si no existe
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Abrir el video
    video = cv2.VideoCapture(video_path)

    # Obtener FPS original y duración del video
    original_fps = video.get(cv2.CAP_PROP_FPS)
    frame_count = int(video.get(cv2.CAP_PROP_FRAME_COUNT))
    duration = frame_count / original_fps

    print(f"FPS original: {original_fps}, Fotogramas totales: {frame_count}, Duración: {duration:.2f} segundos")

    # Calcular cada cuántos frames capturaremos para llegar a los FPS deseados
    frame_step = original_fps / target_fps

    current_frame = 0  # Número del fotograma actual
    saved_frame = 0    # Número del fotograma guardado

    # Barra de progreso configurada con el número total de fotogramas
    with tqdm(total=frame_count, desc="Extrayendo fotogramas", unit="frame") as pbar:
        while video.isOpened():
            # Leer el siguiente fotograma
            ret, frame = video.read()
            if not ret:
                break  # Si no se puede leer más, salir del bucle

            # Guardar el fotograma solo si corresponde con el paso calculado
            if current_frame % round(frame_step) == 0:
                frame_name = f"{saved_frame:05d}.webp"  # Ejemplo: 00001.webp
                frame_path = os.path.join(output_folder, frame_name)
                cv2.imwrite(frame_path, frame, [int(cv2.IMWRITE_WEBP_QUALITY), 90])
                saved_frame += 1

            # Actualizar el progreso y avanzar el contador de frames
            current_frame += 1
            pbar.update(1)  # Actualizamos la barra de progreso en cada iteración

    # Liberar recursos
    video.release()
    print(f"Se han guardado {saved_frame} fotogramas en '{output_folder}'.")

# Ejemplo de uso
video_path = "video-cut.mp4"  # Ruta del video de entrada
output_folder = "fotogramas"  # Carpeta donde se guardarán los fotogramas
extraer_fotogramas(video_path, output_folder)
