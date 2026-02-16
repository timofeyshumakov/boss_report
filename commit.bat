@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

cd /d %~dp0

git add .

:: По умолчанию комментарий
set "COMMENT=comment"

echo Введите комментарий к коммиту (или нажмите Enter для "comment"):
echo (у вас есть 10 секунд для ввода)

:: Простой способ с таймаутом через choice
choice /t 10 /d Y /n > nul 2>&1

:: Запрашиваем ввод
set /p USER_INPUT="> "

if "!USER_INPUT!"=="" (
    set "COMMENT=comment"
    echo Используется комментарий по умолчанию: "comment"
) else (
    set "COMMENT=!USER_INPUT!"
)

:: Выполняем коммит
git commit -m "!COMMENT!"

if !errorlevel! equ 0 (
    echo Коммит выполнен с комментарием: "!COMMENT!"
    git push origin main
) else (
    echo Ошибка при создании коммита!
    pause
    exit /b !errorlevel!
)

echo Готово!
pause