@echo off
setlocal

if [%1]==[] (
  echo Usage: run.bat ^<YouTube_URL^>
  exit /b 1
)

set URL=%1

if not exist out mkdir out

docker run --rm --memory="8g" -v "%cd%\out:/out" youtube-cleaner %URL%
