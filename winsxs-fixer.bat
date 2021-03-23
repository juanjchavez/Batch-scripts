@echo off
setlocal EnableDelayedExpansion
set parameterHost=[REEMPLAZAR POR EQUIPO DE PARAMETRO]
cd "c:\Windows\winsxs\FileMaps\"
echo "Fallidos tras reemplazo" >>"C:\VSSdanados\VSSFixing.txt"
for /r "C:\VSSdanados" %%a in (.\*) do (
	if exist "\\%parameterHost%\C$\Windows\winsxs\FileMaps\%%~nxa" (
		copy "\\%parameterHost%\C$\Windows\winsxs\FileMaps\%%~nxa" "c:\Windows\winsxs\FileMaps\"
		vssadmin list writers > "c:\writers.txt"
		 find /c /i "System Writer" "c:\writers.txt"
		if !errorlevel! NEQ 0 ( 
			echo "Error detectado"
		 	del /F "%%~nxa"
		 	echo "%%~nxa" >> "C:\VSSdanados\VSSFixing.txt"
			) else (
			del /F "C:\VSSdanados\%%~nxa"
			)
	) else (
		echo "Archivo no encontrado en %parameterHost%: %%~nxa" >>"C:\VSSdanados\VSSFixing.txt"
	)
)
timeout 5
PAUSE
