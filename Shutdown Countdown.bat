:::::::::::::::::::::::::::
::TEMPORIZADOR DE APAGADO::
:::::::::::::::::::::::::::
::	Autor: FJ	 ::
::	Web: FJ.MK	 ::
:::::::::::::::::::::::::::

@echo off
set /p tiempo="Ingresa el tiempo en minutos para apagar el PC: "

set /a segundos=%tiempo%*60

echo Apagando el PC en %tiempo% minutos...

:COUNTDOWN
set /a minutosRestantes=segundos/60
set /a segundosRestantes=segundos%%60

echo Tiempo restante: %minutosRestantes% minutos y %segundosRestantes% segundos

timeout /t 1 /nobreak >nul
set /a segundos-=1

if %segundos% gtr 0 goto COUNTDOWN

shutdown /s /f /t 1