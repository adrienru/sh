# 📁 Encriptador: Oculta imágenes cifradas dentro de audios WAV generados automáticamente

import os
import base64
import wave
import struct
import time
import sys
from uuid import uuid4
from PIL import Image
from cryptography.fernet import Fernet

# 🔐 1. Clave Fernet fija
key = 'zm7vT7SsWq5mW3djikNaAhirHl5G3GdydtVwxPoSAAM='
fernet = Fernet(key.encode())

# 📥 Leer argumentos: ruta_origen, ruta_salida, ruta_log
try:
    base_path = sys.argv[1]
    output_path = sys.argv[2]
    log_file = sys.argv[3]
except IndexError:
    print("❌ Faltan argumentos. Uso: python3 procesar.py <origen> <salida> <log>")
    sys.exit(1)

os.makedirs(output_path, exist_ok=True)

# 📦 Cifrar imagen y codificar

def cifrar_imagen(ruta):
    with open(ruta, "rb") as img:
        datos = img.read()
    cifrado = fernet.encrypt(base64.b64encode(datos))
    return cifrado

# 📏 Calcular duración mínima

def calcular_duracion(datos_bytes, extra_chars=200, framerate=44100, nchannels=1, bits=16):
    total_chars = len(datos_bytes) + extra_chars
    total_bits = total_chars * 8
    total_samples = total_bits
    duracion = int((total_samples * 8) / (framerate * nchannels * bits)) + 1
    return max(duracion, 1)

# 🎵 Generar WAV silencioso

def generar_wav(duracion, nombre, framerate=44100, amplitude=0):
    nframes = framerate * duracion
    with wave.open(nombre, 'w') as wav:
        wav.setparams((1, 2, framerate, nframes, 'NONE', 'not compressed'))
        for _ in range(nframes):
            sample = struct.pack('<h', amplitude)
            wav.writeframesraw(sample)

# 🎙️ Codificar con LSB

def encode_dentro_wav(cifrado_bytes, wav_entrada, wav_salida):
    audio = wave.open(wav_entrada, mode="rb")
    frame_bytes = bytearray(list(audio.readframes(audio.getnframes())))
    cifrado_str = cifrado_bytes.decode("latin1") + "#" * 200
    bits = list(map(int, ''.join([bin(ord(i)).lstrip('0b').rjust(8,'0') for i in cifrado_str])))

    if len(bits) > len(frame_bytes):
        raise ValueError("❌ El mensaje es demasiado grande para el audio generado.")

    for i, bit in enumerate(bits):
        frame_bytes[i] = (frame_bytes[i] & 254) | bit

    with wave.open(wav_salida, 'wb') as new_audio:
        new_audio.setparams(audio.getparams())
        new_audio.writeframes(bytes(frame_bytes))

    audio.close()

# 🔁 Procesar todas las imágenes

imagenes = [f for f in os.listdir(base_path) if f.lower().endswith(('.png', '.jpg', '.jpeg'))]
log = open(log_file, "a")

for imagen in imagenes:
    ruta_imagen = os.path.join(base_path, imagen)
    cifrado = cifrar_imagen(ruta_imagen)
    duracion = calcular_duracion(cifrado)
    nombre_base = f"{int(time.time())}_{uuid4().hex[:6]}"
    temp_wav = os.path.join(output_path, nombre_base + "_temp.wav")
    final_wav = os.path.join(output_path, nombre_base + ".wav")

    generar_wav(duracion, temp_wav)
    encode_dentro_wav(cifrado, temp_wav, final_wav)
    os.remove(temp_wav)

    print(f"✅ {imagen} | {os.path.basename(final_wav)}")
    log.write(f"{imagen} | {os.path.basename(final_wav)}\n")

log.close()
print("🎉 Todas las imágenes han sido procesadas.")
