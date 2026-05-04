FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV PORT=8080
ENV TELEGRAM_TOKEN=8020390884:AAEkzEUBNy1gixWPX2WA_Xb32QvPuV-LyqE

RUN apt-get update && apt-get install -y \
    python3 python3-pip wget curl xvfb fluxbox x11vnc novnc websockify \
    net-tools ca-certificates fonts-liberation libnss3 libxss1 libasound2 \
    libatk-bridge2.0-0 libgtk-3-0 libgbm1 unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Chromium for automation tasks
RUN wget https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/1095492/chrome-linux.zip \
    && unzip chrome-linux.zip && mv chrome-linux /opt/chrome \
    && ln -s /opt/chrome/chrome /usr/bin/chromium && rm chrome-linux.zip

WORKDIR /app
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .
RUN chmod +x /app/start.sh

EXPOSE 8080
CMD ["/app/start.sh"]
