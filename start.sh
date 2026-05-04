#!/bin/bash

# 1. Start the virtual display (Xvfb)
Xvfb :99 -screen 0 1280x720x24 &

# 2. Start Fluxbox (Window Manager)
fluxbox &

# 3. Start VNC server
x11vnc -display :99 -forever -nopw -rfbport 5900 &

# 4. Start noVNC bridge (Web access)
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen $PORT &

# 5. Launch the Telegram Bot
python3 /app/main.py
