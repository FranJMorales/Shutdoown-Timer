:::::::::::::::::::::::::::
::TEMPORIZADOR DE APAGADO::
:::::::::::::::::::::::::::
::	Autor: FJ	 ::
::	Web: FJ.MK	 ::
:::::::::::::::::::::::::::

@echo off
set /p hora="Ingresa la hora en formato de 24 horas (0-23): "
set /p minuto="Ingresa el minuto (0-59): "

REM Validar que los valores ingresados sean numéricos y dentro del rango válido
echo %hora% | findstr /R /C:"^[0-9][0-9]*$" >nul || goto INPUT_ERROR
echo %minuto% | findstr /R /C:"^[0-9][0-9]*$" >nul || goto INPUT_ERROR

if %hora% lss 0 goto INPUT_ERROR
if %hora% gtr 23 goto INPUT_ERROR
if %minuto% lss 0 goto INPUT_ERROR
if %minuto% gtr 59 goto INPUT_ERROR

REM Calcular los segundos restantes hasta la hora y minuto especificados
for /f "delims=" %%a in ('wmic path win32_localtime get hour^,minute^,second /format:table ^| find ":"') do (
  set /a horaActual=10%%a %% 100
  set /a minutoActual=10%%b %% 100
  set /a segundoActual=10%%c %% 100
)

set /a segundosActuales=horaActual*3600 + minutoActual*60 + segundoActual
set /a segundosSeleccionados=hora*3600 + minuto*60

if %segundosSeleccionados% lss %segundosActuales% (
  set /a segundosHastaMediaNoche=24*3600 - segundosActuales
  set /a segundosHastaSeleccionado=segundosSeleccionados + segundosHastaMediaNoche
) else (
  set /a segundosHastaSeleccionado=segundosSeleccionados - segundosActuales
)

echo Apagando el PC a las %hora%:%minuto%...

:COUNTDOWN
set /a minutosRestantes=segundosHastaSeleccionado/60
set /a segundosRestantes=segundosHastaSeleccionado%%60

echo Tiempo restante: %minutosRestantes% minutos y %segundosRestantes% segundos

timeout /t 1 /nobreak >nul
set /a segundosHastaSeleccionado-=1

if %segundosHastaSeleccionado% gtr 0 goto COUNTDOWN

shutdown /s /f /t 1
goto :EOF

:INPUT_ERROR
echo Entrada inválida. Por favor, ingresa valores numéricos válidos.