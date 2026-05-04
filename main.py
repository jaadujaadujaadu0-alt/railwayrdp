import os
import asyncio
from telegram import Update
from telegram.ext import ApplicationBuilder, MessageHandler, filters

TOKEN = "8020390884:AAEkzEUBNy1gixWPX2WA_Xb32QvPuV-LyqE"
DOWNLOAD_DIR = "/app/received_files"

if not os.path.exists(DOWNLOAD_DIR):
    os.makedirs(DOWNLOAD_DIR)

async def save_document(update: Update, context):
    if update.message.document:
        file = await context.bot.get_file(update.message.document.file_id)
        file_name = update.message.document.file_name
        dest = os.path.join(DOWNLOAD_DIR, file_name)
        
        await file.download_to_drive(dest)
        await update.message.reply_text(f"🚀 File received!\nSaved to: {dest}\nYou can now run this in your RDP terminal.")

if __name__ == '__main__':
    print("Bot is starting...")
    app = ApplicationBuilder().token(TOKEN).build()
    app.add_handler(MessageHandler(filters.Document.ALL, save_document))
    app.run_polling()
